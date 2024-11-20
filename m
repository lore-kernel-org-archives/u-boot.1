Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E9ED60D17
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 10:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE73689681;
	Wed, 20 Nov 2024 11:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SUsEkArZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EDE089694; Wed, 20 Nov 2024 11:02:38 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61DBA895D2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:02:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso16164955e9.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 02:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732096956; x=1732701756; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DcCy6LcEN9eqC9LR6FwyJJzbKMsED+IC+514Elp5/3k=;
 b=SUsEkArZfspwxt5IRtO7qwC79LM3MtUfaQ2KQpRMGFtnAI+iAcqZVnG5d+FjatScKh
 rGvIHdbsRL/fCFQ//I2LIElC3/9SzoI4ivjJ28tb6jsza4lZrLZu9cmAcIHqOz7ffWCp
 Ij+1K+Xf459CLB7D7xvPUsW+jFgCdHe54FWhbeNCvFFBWZlesGBo0fQ7040LEnQFVT78
 U8EaLO/UucHShE9uboWBKr4ACwM11EQgXgMR5+nGpsX8oqs746KP4FtSrr3yo8bNX7zW
 yNcsX8939u3G/fNr9PFYQnVb0iK4oiVEyWupP5BTlQZVLQebU5FctayyYi9KZNVyY3PQ
 J9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732096956; x=1732701756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DcCy6LcEN9eqC9LR6FwyJJzbKMsED+IC+514Elp5/3k=;
 b=oS61rP+3IUjGUyefWdGChF1rJQIFb39GQoU9Kmp4hTgrSDr+Od/DpFvqpbPY2RiZVH
 0AsnhFDthLenZcKT5fCQj4UIJ2WxgUyNsb3CW3BeTN4FMab1rCjXCvRV+ikptqb+9c0R
 gC4/v/sJIL2Fojc9t96j8uqk3gzN9pzFxxjWrj290MGhLAfsboEhXsTFdKAuVj7+bV0l
 Z68SpSPrCAmr+/7Pz6ow/qv6Ak1CHQ60DdiqM3sFQl2ULh1XqIm45ipwSTSerqUSXY+h
 I+lQVr47k8w1ouQ+7sNujJJCBYRNmXw+Zkuut9clWiv7xynC16pk1LUU+Zt+k7DuAQ2d
 zBQQ==
X-Gm-Message-State: AOJu0Yyzy3Dhgnnmv490696OyfbrgehvQwdbq8JuwR8Se1gUm9YLS06Q
 jI878MadTnFWY1P09B8YnwWR0jgoHKBUawIqt05MMfYsmLpBdXAj6wKwG8loarhrYIJacW50YrC
 /Gk87fA==
X-Google-Smtp-Source: AGHT+IGm8lmN67xjxdZ/E2y+f2lV+F/m+mHo/V7oXFn49yZyO3YT55xb9oSF+t46vG+piyW9B1MX4Q==
X-Received: by 2002:a05:600c:19ca:b0:432:d866:f45e with SMTP id
 5b1f17b1804b1-4334f027ad7mr15971085e9.33.1732096955776; 
 Wed, 20 Nov 2024 02:02:35 -0800 (PST)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:24e0:2f5f:4be2:4309])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45fa706sm13572655e9.16.2024.11.20.02.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 02:02:35 -0800 (PST)
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
 Kongyang Liu <seashell11234455@gmail.com>,
 LekKit <50500857+LekKit@users.noreply.github.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v3 3/4] x86: select CONFIG_64BIT for X86_64
Date: Wed, 20 Nov 2024 10:01:56 +0000
Message-Id: <20241120100157.485418-4-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241120100157.485418-1-andrew.goodbody@linaro.org>
References: <20241120100157.485418-1-andrew.goodbody@linaro.org>
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

Changes in v3:
Introduce CONFIG_SPL_64BIT to allow for x86 building a 32 bit SPL and
a 64 bit U-Boot proper.

Changes in v2:
Corrected commit title to be x86 not sandbox

 arch/Kconfig         | 3 +++
 arch/arm/Kconfig     | 1 +
 arch/mips/Kconfig    | 4 ++++
 arch/riscv/Kconfig   | 1 +
 arch/sandbox/Kconfig | 1 +
 arch/x86/Kconfig     | 1 +
 common/bloblist.c    | 3 ++-
 include/limits.h     | 3 ++-
 8 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6258788f53..c726ac5fc7 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -38,6 +38,9 @@ config 32BIT
 config 64BIT
 	bool
 
+config SPL_64BIT
+	bool
+
 config SYS_CACHELINE_SIZE
 	int
 	default 128 if SYS_CACHE_SHIFT_7
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
index ec6ff7a5a9..30fe1cb4b3 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -579,7 +579,8 @@ int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig)
 	ulong version = BLOBLIST_REGCONV_VER;
 	ulong sigval;
 
-	sigval = (IS_ENABLED(CONFIG_64BIT)) ?
+	sigval = ((IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_SPL_BUILD)) ||
+			(IS_ENABLED(CONFIG_SPL_64BIT) && IS_ENABLED(CONFIG_SPL_BUILD)))	?
 			((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
 			 ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_64)) :
 			((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_32) - 1)) |
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

