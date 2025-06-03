Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C9AC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 14:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A89382AE1;
	Tue,  3 Jun 2025 16:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BxGOjYRA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 608BA82AF6; Tue,  3 Jun 2025 16:43:34 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BFEE82A8B
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 16:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7cadd46ea9aso690659785a.1
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748961810; x=1749566610; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8BckY+tlclgtB31TXdAr50AMvxzD7hBQJsUA0JQQe5Q=;
 b=BxGOjYRA9az4smzEn1sFGra8TxB3Z6uUsKXuWcQPJ8Dqna4wLvIFLqJlDfLHQfY6S+
 IA6wcLMjxRMxTeBwS1JSpXZcxUgUrKx0ie3X4YRM/I8G8xmwznLEMGpjZ9xbbGrPXM1l
 YcAMKJpBZkgx1kTXkO4DaqjvtJxh3V+Q7jJHkrCxzv694YSkmahLhC3nMqSVm5trgpMQ
 sgnYMUdZix8ATNC7TITlkDHsTgTQ360DcxMx6Ecq4+H/Ye3OxF3B4iWfzi9VwVCZaOf7
 K/WyDZjo2xs5uWzbHv72a7duxJa3x7uOp0ODssDV7xkXDNhUJtTGWsHVFY60rIoqfr4U
 pCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748961810; x=1749566610;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8BckY+tlclgtB31TXdAr50AMvxzD7hBQJsUA0JQQe5Q=;
 b=EmVIhqmpHyJEZKSy+/jKkP9z0kqPpx3U9eco3FObwly5wILrG6sL3oOpTUlFu8+2dL
 sf6238ztDwF+5+kWqryHDc3plZqT/+X1U03x1RVSikA909MTJYJEjTPgm2ILUt/IHXO8
 YAeI0L7aRzmeRBSLktxyOxAF2e+jX2xIEUgFcyKduD8KTVPFa5d2kgc78rOaJbQE3cb+
 botBO1CwWaKs/CknKdkGd0ufOhXPzYTeujfUF50J1InrsUvmDkzq21XOn/23vihvPX3q
 b7mFctqVU8DsO90GITMuGq1xyj/R3BZhayRFYPBLHLOUD00lpPV49VInJgCLkE9zkuN+
 oF5A==
X-Gm-Message-State: AOJu0YzcfcTtrYNlrixQzFRLKdPApQQrH5vqUz8JfZGzvKH9Mva2/hGK
 07vX2tPAU0DfeV48DQQQIqT+LHpR2fDcjX22bRbWXt6bhJnAwXueJqz0R5VdiUM/R+69OO+hIpD
 ftQSs
X-Gm-Gg: ASbGncuUpTIduhnbckR/w4+GUL6/A6vsXHt+wUmtlmR6Sy1+BgKPtll9eHh8EWVzVpA
 Qhzqw7dU6AgMgJbUqcsw6IyNuadpCY7N+XNSEvSZKnHV019JpATgd05QWD2M1zfmSvp5Z3yHmoL
 pRtUI4vcZBqskNbTfCfGWo8Yp4n0JAjzbqBk1RLmlFy6EXSqbsI8HJ4rs9bKigYHYxxtIsO+eAX
 gZpwECVAR/0QBiZXB6lnxSssbPckbTcTaDyVzhni1HWKlSP5YcaeY9u/7Inzl61w42IBuj2dmzH
 ib4rq8WyZ50/1Jx+hlJdPW76DVmt8bmY5SnNejMUqxMbbmoMZc/qDVdIRW6BpdChFFELivBQhtj
 lcUI4F3IHRwEqKtP7R8wpYSZwW2im7XBwH/DE
X-Google-Smtp-Source: AGHT+IEMPU7gGz2hXLcHwRPAz/qi0K85J9NJs9SmU40MfIet5yV5WjHxr53+XflA+FIptzvNNL2pow==
X-Received: by 2002:a05:622a:4011:b0:4a4:3c3e:5754 with SMTP id
 d75a77b69052e-4a443ef6eb5mr303167841cf.32.1748961799080; 
 Tue, 03 Jun 2025 07:43:19 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a4358b282asm74550651cf.30.2025.06.03.07.43.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 07:43:18 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH v2] makefile: fix Clang link error when RSA_PUBLIC_KEY_PARSER
 is selected
Date: Tue,  3 Jun 2025 07:42:55 -0700
Message-Id: <20250603144258.1701265-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

MbedTLS bignum module needs '__udivti3' which is a 128-bit division
function provided by the compiler runtime, typically libgcc for GCC or
clang_rt.builtins for Clang.
Thus 'clang_rt.builtins' library is required when building using Clang.

This patch supports the location layout of clang_rt.builtins libraries
from both LLVM pre-15 pattern [1] and post-15(up to 20) pattern [2].

As a fact that starts from LLVM 20, no official prebuilt multi-targets
are included and users might need to cross-built it from source. [3] is
an example of instructions for building.

[1] <INST_DIR>/lib/clang/<REV>/lib/linux/libclang_rt.builtins-<ARCH>.a
E.g.
lib/clang/14.0.0/lib/linux/libclang_rt.builtins-aarch64.a
lib/clang/14.0.0/lib/linux/libclang_rt.builtins-x86_64.a

[2] <INST_DIR>/lib/clang/<REV_MAJOR>/lib/<CROSSTOOL>/libclang_rt.builtins.a
E.g.
lib/clang/20/lib/aarch64-none-linux-gnu/libclang_rt.builtins.a
lib/clang/20/lib/x86_64-unknown-linux-gnu/libclang_rt.builtins.a

[3]
git clone https://github.com/llvm/llvm-project.git
cd llvm-project
git checkout -b llvmorg-20.1.6 llvmorg-20.1.6
mkdir build-builtin && cd build-builtin
cmake -G Ninja ../llvm \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_C_COMPILER=clang \
  -DLLVM_ENABLE_PROJECTS="clang" \
  -DLLVM_ENABLE_RUNTIMES="compiler-rt" \
  -DLLVM_TARGETS_TO_BUILD="X86;AArch64" \
  -DLLVM_BUILTIN_TARGETS=\
    "x86_64-unknown-linux-gnu;aarch64-none-linux-gnu" \
  -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSTEM_NAME=Linux \
  -DBUILTINS_aarch64-none-linux-gnu_CMAKE_C_COMPILER=\
    <YOUR_TOOLCHAIN_GCC> \
  -DBUILTINS_aarch64-none-linux-gnu_CMAKE_ASM_COMPILER=\
    <YOUR_TOOLCHAIN_GCC> \
  -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSROOT=\
    <YOUR_TOOLCHAIN_LIBC_DIR> \
  -DCOMPILER_RT_BUILD_BUILTINS=ON \
  -DCOMPILER_RT_BUILD_SANITIZERS=OFF \
  -DCOMPILER_RT_BUILD_XRAY=OFF \
  -DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
  -DCOMPILER_RT_BUILD_PROFILE=OFF \
  -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> \
  -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=OFF
ninja builtins
sudo ninja install

Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in V2:
- Add support for LLVM post-15.

 Makefile | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index f88684947ee..6cec94e1cd3 100644
--- a/Makefile
+++ b/Makefile
@@ -37,7 +37,6 @@ else ifeq ("riscv32", $(MK_ARCH))
 else ifeq ("riscv64", $(MK_ARCH))
   export HOST_ARCH=$(HOST_ARCH_RISCV64)
 endif
-undefine MK_ARCH
 
 # Avoid funny character set dependencies
 unexport LC_ALL
@@ -915,8 +914,27 @@ PLATFORM_LIBGCC = arch/$(ARCH)/lib/lib.a
 else
 ifndef CONFIG_CC_IS_CLANG
 PLATFORM_LIBGCC := -L $(shell dirname `$(CC) $(c_flags) -print-libgcc-file-name`) -lgcc
+else
+# mbedtls bignum needs '__udivti3' - a 128-bit division function that's provided by clang-rt.
+ifeq ($(CONFIG_RSA_PUBLIC_KEY_PARSER_MBEDTLS),y)
+CLANG_RES_DIR := $(shell $(CC) --print-resource-dir)
+# Find all matching libclang_rt.builtins*.a files
+CLANG_RT_LIB_FULL := $(shell find $(CLANG_RES_DIR)/lib -name "libclang_rt.builtins*.a" 2>/dev/null | grep "$(MK_ARCH)" | head -n 1)
+CLANG_RT_DIR := $(shell dirname $(CLANG_RT_LIB_FULL))
+ifeq ($(CLANG_RT_LIB_FULL),)
+$(info libclang_rt.builtins.a not found for target $(MK_ARCH))
+else ifneq ($(findstring /linux/, $(CLANG_RT_LIB_FULL)),)
+# Legacy(pre-LLVM15) layout (<INSTALLED_DIR>/lib/clang/<REV>/lib/linux/libclang_rt.builtins-<ARCH>.a)
+PLATFORM_LIBGCC := -L$(CLANG_RT_DIR) -lclang_rt.builtins-$(shell echo $(MK_ARCH) | tr -d '"')
+else
+# New(post-LLVM15) layout (<INSTALLED_DIR>/lib/clang/<REV_MAJOR>/lib/<CROSSTOOL_NAME>/libclang_rt.builtins.a)
+PLATFORM_LIBGCC := -L$(CLANG_RT_DIR) -lclang_rt.builtins
 endif
-endif
+endif # CONFIG_RSA_PUBLIC_KEY_PARSER_MBEDTLS
+endif # CONFIG_CC_IS_CLANG
+endif # CONFIG_USE_PRIVATE_LIBGCC
+
+undefine MK_ARCH
 PLATFORM_LIBS += $(PLATFORM_LIBGCC)
 
 ifdef CONFIG_CC_COVERAGE
-- 
2.25.1

