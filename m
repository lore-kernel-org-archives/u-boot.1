Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2512D58069
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 11:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFCE89A45;
	Mon, 25 Nov 2024 12:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d0lwLCRy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53AB689A31; Mon, 25 Nov 2024 12:56:54 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D06689A45
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-434a1fe2b43so2400545e9.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 03:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732535810; x=1733140610; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0B+RzZsRYYetICtj6sHsgIWee00UZ8O4qiEExBDSjbs=;
 b=d0lwLCRyoO7LIeG4UKBZCCHd/IpYZADoIGJDfdfyP1OOMzK4hm1pk2DSlbve088y+l
 dxoDFFUJgKv0Ed3NaAWYsSODyx+UzJsj5a6qVYP9Qoh4UznE+W8jRGVjJUEfYd4Zcl05
 CWqLcMHAzmogCV4yicqFZlGzxdKhktc/3yKJduUzdTkgv2pGXf6fMmM9a3T96RfEZOnN
 rm/ER//EDONGA5rS66WfKQ+/YZefhBAeAKC6SU1IobILNztop4Z9+52xbTm4jCgY8+Vq
 YnyvSGet+VVHyQ+WvaBTAqTqSuUDt3xi48UnCixRdbKrKNg5xr3MnY2NIImmM4iGXnkS
 hREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732535810; x=1733140610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0B+RzZsRYYetICtj6sHsgIWee00UZ8O4qiEExBDSjbs=;
 b=jyf6NBvqFZB7xNUDCCX7BVTt2AMAWfBWSYkddptewtHUIfu2scIbkr+IzBgPzScTVz
 zy2zKXKfGCqmOS51/Hlp9Kqalz/sLQAGP9I49TX9y9pe2NJlxrrnMmNz8y07kj+Lh+mX
 MrKcTxdD2/ilIWMFiqkfG1V+t+WDYD750lZ1umIETdaCAmIyNtpjQzlNpsq0t9dKkDHK
 hdZVbX4MPKI8LWoxH+oJYDlsOPdhcmUMb8+94lItydQ4jbi/2xTIIDY2rEcNCh/2qvOr
 oYIOCLwHEkfz2yJ6gGRf1aDfyGImAw1vnWVMrqIau5nVQ+CRo9NWsX3EaEtesFQYUSki
 zRUw==
X-Gm-Message-State: AOJu0Yy0hF/21vxhCBZhJDUKnoC+soITMY+ClpC5PrbD899URJaJPhvP
 Rnbqnc1pwbv3teoY+sDINA5QJ3gHiBraAPr9pfFnQdoHVj983MWm8BlkUcVKspbUz1Td1WOtStd
 M8dQsWQ==
X-Gm-Gg: ASbGncsSTLegXISPLrU+SoWr0ZHYw/RzLXvXiZhptmDGNBjLQyEZpTxFuEtxu6wvAKm
 s3vfjamuZp3f2+zxxQUZUcbhL06QOC7Y+QQAj0QwR8KrxMEb161RWl5OJZdKmWc5/YrloStpYbg
 Xsa5KTe+w0VPzne9q3dIDNzT9O5Hu4MIuDg316ilUruzR8zOu4bseTLR9ObDlSRht2KVdivz7m4
 lsl8zoOLD9eWsgfAe4jHzfxOHEEKP53jiNVBrb7sNHkmWteOEeyQqA1Tf6mFtzY5Ho8kw==
X-Google-Smtp-Source: AGHT+IGP29CVtJKURU5DCABbKSaJBGUmq0qm7bRpDl9RB4rNipQlWrqbk7jShiQqUuMOWCVklzi4Jg==
X-Received: by 2002:a05:6000:1aca:b0:382:3210:4de0 with SMTP id
 ffacd0b85a97d-38260bcba20mr10423224f8f.44.1732535809760; 
 Mon, 25 Nov 2024 03:56:49 -0800 (PST)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:7b40:ce24:60a6:e419])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb271ffsm10139626f8f.53.2024.11.25.03.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 03:56:49 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 3/4] x86: select CONFIG_64BIT for X86_64
Date: Mon, 25 Nov 2024 11:55:53 +0000
Message-Id: <20241125115554.1707080-4-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125115554.1707080-1-andrew.goodbody@linaro.org>
References: <20241125115554.1707080-1-andrew.goodbody@linaro.org>
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

Changes in v4:
 - Add help text to describe new symbol CONFIG_SPL_64BIT
 - Splite statement in bloblist.c to make it more readable

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
 common/bloblist.c    | 11 +++++++----
 include/limits.h     |  3 ++-
 8 files changed, 25 insertions(+), 5 deletions(-)

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
index ec6ff7a5a9..30ca39a8e5 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -579,11 +579,14 @@ int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig)
 	ulong version = BLOBLIST_REGCONV_VER;
 	ulong sigval;
 
-	sigval = (IS_ENABLED(CONFIG_64BIT)) ?
-			((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
-			 ((version  & BLOBLIST_REGCONV_MASK) << BLOBLIST_REGCONV_SHIFT_64)) :
-			((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_32) - 1)) |
+	if ((IS_ENABLED(CONFIG_64BIT) && !IS_ENABLED(CONFIG_SPL_BUILD)) ||
+			(IS_ENABLED(CONFIG_SPL_64BIT) && IS_ENABLED(CONFIG_SPL_BUILD))) {
+		sigval = ((BLOBLIST_MAGIC & ((1UL << BLOBLIST_REGCONV_SHIFT_64) - 1)) |
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

