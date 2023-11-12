Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2032BC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1BC687103;
	Sun, 12 Nov 2023 21:03:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Tftf/9aa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DDAA87251; Sun, 12 Nov 2023 21:03:16 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E0968700D
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-35aa43c92daso5289375ab.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819387; x=1700424187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ic/gkscK8Q7brXXGXKycJ8/SmY5zC+Ogqjkm53uveHg=;
 b=Tftf/9aaRingEo0NWdLyuvA5Tpuk7X3XCqQz8CZz4YrahbaY0dUnPEzgJ5aaHFpBEm
 U3pgE4IBOrNmUtEqewrer1AFFGCKJoBmDMkcq6t8aVI/k9fHfwmkbHwpgEt98qMS+C/8
 d4yQHdNzXPkNAJ41eS52nqJOk3Wuli9beZA5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819387; x=1700424187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ic/gkscK8Q7brXXGXKycJ8/SmY5zC+Ogqjkm53uveHg=;
 b=CYQzBX1ChhPYyI2YbZlifOaCCj/ZD6Lg6ritilRD1sM+NgAnskqSyMwXZmEEpuDXdh
 MuC7i25P2xJ/9V1T2brdWsqlMSFthY/D334gymXVR/VSAiDVCTD76PuqGF+Mo7bDjEkO
 Dr0b77g4Ag4we9nfDo0NWbdM9rfVjLga0WMlqYTaPfo1uJgLwtvaigWfRyOO5JZuF+9S
 XdBY6McAsRhk0KHWFBX9tdju8Ib7LrQHjyfCQNrekzNbrBYbvQfWhSl2T8U5FJfUkLDf
 IqPaupCk4pvfnD/UK2gSm+xXwVPZKBpbiYvYIZin0SpTeFhrv21/4BuPm17AVu5X5Zxq
 swfw==
X-Gm-Message-State: AOJu0YyeBhied0faFqIpDURX+TTTLe0imtx5W5IDY+vyd+PidJ3QAwAo
 TtNZhpI8LZCoAWzhfJpkxVPws4hWpDFF5noXk5eBFQ==
X-Google-Smtp-Source: AGHT+IFUttkfOAkw11vwIds8apSeeVGouDupkQpHpqreNFwe1rWTD1TYCnwtG6Ur1Rn6bRQcYO9Kcw==
X-Received: by 2002:a05:6e02:174f:b0:351:e6e:7729 with SMTP id
 y15-20020a056e02174f00b003510e6e7729mr4791737ill.12.1699819387192; 
 Sun, 12 Nov 2023 12:03:07 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a923204000000b0035761b749casm1208256ile.46.2023.11.12.12.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:03:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v4 09/12] x86: Enable SSE in 64-bit mode
Date: Sun, 12 Nov 2023 13:02:46 -0700
Message-ID: <20231112200255.172351-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112200255.172351-1-sjg@chromium.org>
References: <20231112200255.172351-1-sjg@chromium.org>
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
Suggested-by: Bin Meng <bmeng.cn@gmail.com>
---

Changes in v4:
- Use a Kconfig option

 arch/x86/Kconfig          |  8 ++++++++
 arch/x86/config.mk        |  4 ++++
 arch/x86/cpu/x86_64/cpu.c | 12 ++++++++++++
 drivers/video/Kconfig     |  1 +
 4 files changed, 25 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 99e59d94c606..6b532d712ee8 100644
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
index 26ec1af2f0b0..2e3a7119e798 100644
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
index 2647bff891f8..5ea746ecce4d 100644
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
index 6f319ba0d544..39c82521be16 100644
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
2.42.0.869.gea05f2083d-goog

