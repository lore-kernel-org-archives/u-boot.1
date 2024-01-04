Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A31BC47255
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 717D48798C;
	Thu,  4 Jan 2024 16:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H75rPUk3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEB1B8796B; Thu,  4 Jan 2024 16:11:05 +0100 (CET)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A5A879A5
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd42.google.com with SMTP id
 ca18e2360f4ac-7b7fdde8b98so22679239f.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381050; x=1704985850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37EbUCUpA2uiD8JW7BW15+qfeqzZ+3vxmFHC7zbTRMY=;
 b=H75rPUk3zGFQMXlVSwZfWlRl4+3y9uvw0z0+V6V2CcjFpEf1mm8TPiwHiMEhDpZGYA
 HHSv+A7OpGMcqUUzYC+Q7C3ylmHDCOOU2CGeRIR+eZSRwlNbVtd78uCO3aexRJbaSm0f
 CLl6iti6PSSg7RL5GQS38lNvr6aVk2+uq0CZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381050; x=1704985850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37EbUCUpA2uiD8JW7BW15+qfeqzZ+3vxmFHC7zbTRMY=;
 b=R83YWncmnZ35vMR4hXDqSCHKjFrH7CJ4Tz/ANFSjp1OpnIBN+g22AuDbq9OlhcOfsR
 FO8KR5KFEwXh3J5rBNTBOGh9Q7iPkY5mIsRzRuoNiOM8R0CwPygN5KFt/ykGvXq/hoAe
 CBZP/2H37m0lYf29Tn0XbVeJ3XBmeowyqsK+Tf47ysO8KXRzCUZjdGbyY6RZJtye+Rhj
 dnY+wJrPWHDJnzCI6e4Bwzubf95QiZviFz8aTzwEskXFdRSnom/o2OEIMaoEMrzt1o2H
 jV3BgY8JOgzX2Sq0J37/gkDN7e+nW92NJZpJRcJ7KT/420AaiugCpvjsVZziUgFBD/Tb
 eMmg==
X-Gm-Message-State: AOJu0Yx7jil0BDgdWSmG995XXLWQLYaf0rMh5ueh6ByP7oAMtAJeE1wH
 BrGGmEJT6TUlEu35jluDwkdYykTo4adwMFwOr+ElFiZC7R3wf/g=
X-Google-Smtp-Source: AGHT+IGSRVv8p/jBi+L6hDp0HhLIiBefap28dOqYuMi+6JWHWq/4ETaAQaR/Mu3sDheQiKJ6Ppk8sQ==
X-Received: by 2002:a6b:912:0:b0:7b7:fb2a:aa29 with SMTP id
 t18-20020a6b0912000000b007b7fb2aaa29mr789152ioi.25.1704381049836; 
 Thu, 04 Jan 2024 07:10:49 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 z14-20020a02938e000000b0046d710cef38sm4937310jah.159.2024.01.04.07.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:10:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Fabio Estevam <festevam@denx.de>,
 Nikhil M Jain <n-jain1@ti.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v6 4/7] x86: Enable SSE in 64-bit mode
Date: Thu,  4 Jan 2024 08:10:39 -0700
Message-Id: <20240104151042.695717-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151042.695717-1-sjg@chromium.org>
References: <20240104151042.695717-1-sjg@chromium.org>
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

This is needed to support Truetype fonts. In any case, the compiler
expects SSE to be available in 64-bit mode. Provide an option to enable
SSE so that hardware floating-point arithmetic works.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Suggested-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v4)

Changes in v4:
- Use a Kconfig option

 arch/x86/Kconfig          |  8 ++++++++
 arch/x86/config.mk        |  4 ++++
 arch/x86/cpu/x86_64/cpu.c | 12 ++++++++++++
 drivers/video/Kconfig     |  1 +
 4 files changed, 25 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 99e59d94c60..6b532d712ee 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -723,6 +723,14 @@ config ROM_TABLE_SIZE
 	hex
 	default 0x10000
 
+config X86_HARDFP
+	bool "Support hardware floating point"
+	help
+	  U-Boot generally does not make use of floating point. Where this is
+	  needed, it can be enabled using this option. This adjusts the
+	  start-up code for 64-bit mode and changes the compiler options for
+	  64-bit to enable SSE.
+
 config HAVE_ITSS
 	bool "Enable ITSS"
 	help
diff --git a/arch/x86/config.mk b/arch/x86/config.mk
index 26ec1af2f0b..2e3a7119e79 100644
--- a/arch/x86/config.mk
+++ b/arch/x86/config.mk
@@ -27,9 +27,13 @@ ifeq ($(IS_32BIT),y)
 PLATFORM_CPPFLAGS += -march=i386 -m32
 else
 PLATFORM_CPPFLAGS += $(if $(CONFIG_SPL_BUILD),,-fpic) -fno-common -march=core2 -m64
+
+ifndef CONFIG_X86_HARDFP
 PLATFORM_CPPFLAGS += -mno-mmx -mno-sse
 endif
 
+endif # IS_32BIT
+
 PLATFORM_RELFLAGS += -fdata-sections -ffunction-sections -fvisibility=hidden
 
 KBUILD_LDFLAGS += -Bsymbolic -Bsymbolic-functions
diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
index 2647bff891f..5ea746ecce4 100644
--- a/arch/x86/cpu/x86_64/cpu.c
+++ b/arch/x86/cpu/x86_64/cpu.c
@@ -10,6 +10,7 @@
 #include <init.h>
 #include <asm/cpu.h>
 #include <asm/global_data.h>
+#include <asm/processor-flags.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -39,11 +40,22 @@ int x86_mp_init(void)
 	return 0;
 }
 
+/* enable SSE features for hardware floating point */
+static void setup_sse_features(void)
+{
+	asm ("mov %%cr4, %%rax\n" \
+	"or  %0, %%rax\n" \
+	"mov %%rax, %%cr4\n" \
+	: : "i" (X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT) : "eax");
+}
+
 int x86_cpu_reinit_f(void)
 {
 	/* set the vendor to Intel so that native_calibrate_tsc() works */
 	gd->arch.x86_vendor = X86_VENDOR_INTEL;
 	gd->arch.has_mtrr = true;
+	if (IS_ENABLED(CONFIG_X86_HARDFP))
+		setup_sse_features();
 
 	return 0;
 }
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6f319ba0d54..39c82521be1 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -180,6 +180,7 @@ config CONSOLE_ROTATION
 
 config CONSOLE_TRUETYPE
 	bool "Support a console that uses TrueType fonts"
+	select X86_HARDFP if X86
 	help
 	  TrueTrype fonts can provide outline-drawing capability rather than
 	  needing to provide a bitmap for each font and size that is needed.
-- 
2.34.1

