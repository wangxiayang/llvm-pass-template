#include <stdio.h>
#include "llvm/Pass.h"
#include "llvm/IR/Module.h"

#define DEBUG_TYPE "pass-temp"

using namespace llvm;

namespace {
	
class PassTemplate : public ModulePass {
	
public:
	static char ID;
	PassTemplate() : ModulePass(ID) {}
	bool runOnModule(Module &M) override;
};
}

char PassTemplate::ID = 0;

bool
PassTemplate::runOnModule(Module &M) {
	return false;
}

static RegisterPass<PassTemplate> X("pass-temp", "pass-intro");
