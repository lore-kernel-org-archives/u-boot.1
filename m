Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65B4E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 18:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 257A680288;
	Mon, 16 Dec 2024 19:08:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RGDaWTgC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C9BD80243; Mon, 16 Dec 2024 19:08:02 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A959800D2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 19:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so19456695e9.0
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 10:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734372480; x=1734977280; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vk4iBr15zLQgE+1FM98EfUozqGmLtNvi8mXrwnjrWx0=;
 b=RGDaWTgC3vzFbzOFGBZvOFoLQo6MV8yo3NolW3cEABJS3rkJ7lxX51b9Bo8oTxOE3n
 b+hLIdH/A56ymhf1VjB6dXlH1Q2nC52V6agElfz+DfVVljQx1yBha73naVSVNrwn+S1g
 ifgkbZZd0lXYNxrsrVMlw1IjDE0Vx13rYe3PzkM89nj9iL/qgZBHsaTJzoSzdcVjWA0r
 +YQZA9gN/9Lq/QwmcRQKU73zDo3fCI/j8TPjCBqkiYwar5aFrHi/QltAbUGxuJnqvclH
 5vemc0YQJlx5FG/sf5LTDry5YnrLMVLDxs+fNC4evDCKLnC0TruDtfPkYEv0nTk2FpJ7
 KGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734372480; x=1734977280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vk4iBr15zLQgE+1FM98EfUozqGmLtNvi8mXrwnjrWx0=;
 b=JYziFRvOWKssqJKkPCLZh/bq+1W2/H1BzD8AE+0zKePSECWi5fv0d+MwuPuqqDv7mc
 74HqzP5W168fYmn+3a3nQ38BR3AP72IkM5J/+S8yisvh6W3C/06EOgQXItWkJm8XmSNo
 aFF69UVTSCpdocfwrrqXJ9EN5zJcgyUKFd3xbn/veGgs8Q4/gmiY/YJM/2qC6QPEjmfT
 f8ytjFJH/s7cUotfeeCfx4pFZ05kBftr2cE3g6pLcC6eOMPPyEkY6yJugsygEeUuYbjF
 eOgiFyWg7mup7D5szs/50FNKysZ9eQG+cQigOJ2jLlC+6OkF/TWNRSXkGbGrzbzHRFtR
 +3bA==
X-Gm-Message-State: AOJu0YxsAULGJ0tpnlBKrdYRLcmNMozCT3Ha9QYoUx6go/4d9v4IeLTM
 QcZPIaM0hDENOQQ52YC89JUhQS2hq11bgKiTQ/I354gtqYSI5XpHAFv89m7p2nN6YvbfKtrYtlB
 EvI8=
X-Gm-Gg: ASbGncvfZxHFIZfB4Cm4s2rtA3RTx8S1DV4iUSPHiU6esrRn3DItYv+WS+KEPIM0cWx
 LIRurVgk53R8vSQmCohPyYKH699qhDxV+KLqjY0DRTAP/+2Qm2bJxVTKBvsefQ86XTSZMd3fJPb
 JkcbdgZoo7tsCLYs1YuDRoW/1OXjiwH6O5Y1HffVPq8SlPoR/JLVT9Hd0JNh72ktnQzOizxx+nF
 73mE9ygCwuVH0qK1xC4fmJcpLjNSXdoposI+922OF2LpJmKrDfiP+1u92k7StR2jkTdKtMghCMw
X-Google-Smtp-Source: AGHT+IHynwRiQfWtH/gWGK2RcmPTvkmMwH8Q8xrOrtyQ4Jn0twLPehBDiyB7pkauuNAJRZygLsQIfQ==
X-Received: by 2002:a05:600c:4e4e:b0:435:192:63ca with SMTP id
 5b1f17b1804b1-4362aaa4969mr124772685e9.21.1734372479667; 
 Mon, 16 Dec 2024 10:07:59 -0800 (PST)
Received: from artemis2.broadband ([2a0a:ef40:ee3:c001:477a:6a2a:86f6:a454])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436360154absm91501605e9.2.2024.12.16.10.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 10:07:59 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v5 3/4] x86: select CONFIG_64BIT for X86_64
Date: Mon, 16 Dec 2024 18:07:35 +0000
Message-Id: <20241216180736.1933807-4-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216180736.1933807-1-andrew.goodbody@linaro.org>
References: <20241216180736.1933807-1-andrew.goodbody@linaro.org>
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

Select CONFIG_64BIT so that we pass the -m64 option (instead of -m32) to
static analysis tools.
Introduce CONFIG_SPL_64BIT and select it for architectures other than
x86 with 64 bit builds. Do not select it for x86 builds as x86 uses
a 32 bit SPL.
Ensure that when limits are set they use CONFIG_64BIT for U-Boot
proper and CONFIG_SPL_64BIT for SPL. This is to allow for the 32 bit
SPL build used by x86.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

Changes in v5:
 - The change to bloblist.c in the previous version was mistakenly
   simplified and no longer contained the needed fix which was to use
   a variable that could hold a 64bit value when compiled as 64bit. This
   version reinstates the full fix from V3 when it was a separate patch.

Changes in v4:
 - Add help text to describe new symbol CONFIG_SPL_64BIT
 - Split statement in bloblist.c to make it more readable

Changes in v3:
Introduce CONFIG_SPL_64BIT to allow for x86 building a 32 bit SPL and
a 64 bit U-Boot proper.

Changes in v2:
Corrected commit title to be x86 not sandbox

 arch/Kconfig         |  8 ++++++++
 arch/arm/Kconfig     |  1 +
 arch/mips/Kconfig    |  4 ++++
 arch/riscv/Kconfig   |  1 +
 arch/sandbox/Kconfig |  1 +
 arch/x86/Kconfig     |  1 +
 common/bloblist.c    | 13 ++++++++-----
 include/limits.h     |  3 ++-
 8 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6258788f53..bb2e7bedd1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -37,6 +37,14 @@ config 32BIT
 
 config 64BIT
 	bool
+	help
+	  Indicates that U-Boot proper will be built for a 64 bit
+	  architecture.
+
+config SPL_64BIT
+	bool
+	help
+	  Indicates that SPL will be built for a 64 bit architecture.
 
 config SYS_CACHELINE_SIZE
 	int
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7282c4123b..055762b0b9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -7,6 +7,7 @@ config SYS_ARCH
 config ARM64
 	bool
 	select 64BIT
+	select SPL_64BIT if SPL
 	select PHYS_64BIT
 	select SYS_CACHE_SHIFT_6
 	imply SPL_SEPARATE_BSS
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 38577af43d..7ea439e857 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -211,6 +211,7 @@ config CPU_MIPS64_R1
 	bool "MIPS64 Release 1"
 	depends on SUPPORTS_CPU_MIPS64_R1
 	select 64BIT
+	select SPL_64BIT if SPL
 	help
 	  Choose this option to build a kernel for release 1 through 5 of the
 	  MIPS64 architecture.
@@ -219,6 +220,7 @@ config CPU_MIPS64_R2
 	bool "MIPS64 Release 2"
 	depends on SUPPORTS_CPU_MIPS64_R2
 	select 64BIT
+	select SPL_64BIT if SPL
 	help
 	  Choose this option to build a kernel for release 2 through 5 of the
 	  MIPS64 architecture.
@@ -227,6 +229,7 @@ config CPU_MIPS64_R6
 	bool "MIPS64 Release 6"
 	depends on SUPPORTS_CPU_MIPS64_R6
 	select 64BIT
+	select SPL_64BIT if SPL
 	help
 	  Choose this option to build a kernel for release 6 or later of the
 	  MIPS64 architecture.
@@ -235,6 +238,7 @@ config CPU_MIPS64_OCTEON
 	bool "Marvell Octeon series of CPUs"
 	depends on SUPPORTS_CPU_MIPS64_OCTEON
 	select 64BIT
+	select SPL_64BIT if SPL
 	help
 	 Choose this option for Marvell Octeon CPUs.  These CPUs are between
 	 MIPS64 R5 and R6 with other extensions.
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 043d963f63..abb7a984c4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -120,6 +120,7 @@ config ARCH_RV32I
 config ARCH_RV64I
 	bool "RV64I"
 	select 64BIT
+	select SPL_64BIT if SPL
 	select PHYS_64BIT
 	help
 	  Choose this option to target the RV64I base integer instruction set.
diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
index db29ca14bd..4c169034d9 100644
--- a/arch/sandbox/Kconfig
+++ b/arch/sandbox/Kconfig
@@ -47,6 +47,7 @@ config HOST_32BIT
 config HOST_64BIT
 	def_bool $(cc-define,_LP64)
 	select 64BIT
+	select SPL_64BIT if SPL
 
 config HOST_HAS_SDL
 	def_bool $(success,sdl2-config --version)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 23a1e21b29..006a59d6fa 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -44,6 +44,7 @@ endchoice
 
 config X86_64
 	bool
+	select 64BIT
 
 config SPL_X86_64
 	bool
diff --git a/common/bloblist.c b/common/bloblist.c
index ec6ff7a5a9..110bb9dc44 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -576,14 +576,17 @@ int bloblist_maybe_init(void)
 
 int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig)
 {
-	ulong version = BLOBLIST_REGCONV_VER;
+	u64 version = BLOBLIST_REGCONV_VER;
 	ulong sigval;
 
-	sigval = (IS_ENABLED(CONFIG_64BIT)) ?
-			((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
-			 ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_64)) :
-			((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_32) - 1)) |
+	if ((IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_SPL_BUILD)) ||
+			(IS_ENABLED(CONFIG_SPL_64BIT) && IS_ENABLED(CONFIG_SPL_BUILD))) {
+		sigval = ((BLOBLIST_MAGIC & ((1ULL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
+			 ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_64));
+	} else {
+		sigval = ((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_32) - 1)) |
 			 ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_32));
+	}
 
 	if (rzero || rsig != sigval ||
 	    rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
diff --git a/include/limits.h b/include/limits.h
index 4700cc7a59..1d0bbf69be 100644
--- a/include/limits.h
+++ b/include/limits.h
@@ -9,7 +9,8 @@
 #define UINT32_MAX  0xffffffffU
 #define UINT64_MAX  0xffffffffffffffffULL
 
-#ifdef CONFIG_64BIT
+#if (defined(CONFIG_64BIT) && !defined(CONFIG_SPL_BUILD)) || \
+	(defined(CONFIG_SPL_64BIT) && defined(CONFIG_SPL_BUILD))
     #define UINTPTR_MAX UINT64_MAX
 #else
     #define UINTPTR_MAX UINT32_MAX
-- 
2.39.5

