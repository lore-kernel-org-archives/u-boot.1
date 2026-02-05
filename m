Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FA1ECD9B0
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 23:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF90F8382A;
	Fri,  6 Feb 2026 00:42:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KdF+kYlL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43546838FA; Fri,  6 Feb 2026 00:42:05 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A74DD800AE
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 00:42:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-45c93313721so1028700b6e.2
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 15:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770334920; x=1770939720; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5iUXu8bv0lTWHLjdMVLhsOJLXzO7RHxzCt7+pJ5vMc8=;
 b=KdF+kYlLrLfhwx9N9P5t+AN1gfll5zQWowkgnIhSLRUB7vSKk28LVP2L6EIdDaBbTI
 Xf0IsYJ5CMaRbUyYsI3Han3rWbhGdu+Db+bNTUATAYYXS5zsDk9C5hSOOobqoJhknYiM
 lx/k/0UxgOTWctPr1GpgCZoRzYCdaO9s9xQA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770334920; x=1770939720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5iUXu8bv0lTWHLjdMVLhsOJLXzO7RHxzCt7+pJ5vMc8=;
 b=au4etTPhhpkmsOLPxrEYkEOY5Z1pkiJLtVqUQ6CZ8RN5GnyPAjzwDfNvlMHqLdsC79
 VHKDwkqDAxPHZ0lEU+ybXB1BLjhB78sYuwswuw4mfwiJxuV4xpRjTQ9iEe1CHo5efmBw
 OzOQ0O3lhcS4EM0f75c65cOGAMbMoR6hqnijvuJ05yA2dr8xCSMjmkyR+Z1W5fymKG6s
 YiWiTL1uGhl6rblDIrcvZAMTik8OOcr0WmTSzgZBU/n1PQVhI0p3HSRNAhiVaxtBfDyY
 qLG/Zi5nDa5bg6pOrSLhVKE55rEwStyKga0T11MGHLDKDFvEAWLHtoecvyVUwxn6XUgX
 Nd8A==
X-Gm-Message-State: AOJu0YzQtwgMGIoeTurgUJYWEDhTjj10+fGQvA4SfK+L+Hx8em81jNm9
 O6eChxdS2w0hwHWWa14w870EUuWeB9vQ7dLe+/aDULqXa6Kbgv3mLqVvkhueVJLdRvenSqftpkz
 yHOo3Zl0=
X-Gm-Gg: AZuq6aKeGrXxkXmG4qGPA2i/O7oJhRMlz1TiBzrREjSWSOwuQX3BrON49AzcMXDhKiG
 XwDoitV1hLyv83Ux9tCD7ER1Ieg3gjq8z7ai9aIFmETRXDrOaGlO6QXOhrmOCWOpGGWiUja9yDv
 f9z/JMOtl61OOqK86vhm6o85qy/UhG1o6FmV6dhbjxhGcvoNyrSXE5rNprguGevXfIKNJIwmPSK
 MZidKoWDoju4Wk6eLlZVZYUHMfCqvSY6sqVzhWPhCi9xWrgs/S2E5qnbZn4VWhMP/9QLdLERTw+
 v5GRMDvppfEseYNmjfisbqtjIPnRavqyFJ4XoFei7DS7dL4qNZgBfKt/yff6GPzzGlQWlxYUoCR
 qHIwysmPXghawka0nIz5Z3aaxzoHlZppCKm6lTDIikDPZVAyxsHcl76TszMTLHUdiztJpe9GhhR
 7ypFM7qdJlQgHUG1uEMcNqvzcDryJBY0JTBPKtzk60aT6djvuRUJtmvUYaGAHxnmNeoADJPHp0H
 glNIchzHzb549HyPE0i8XllCJITcEbqiShA3O/vwg==
X-Received: by 2002:a05:6808:13cb:b0:459:9630:3739 with SMTP id
 5614622812f47-462fcb51059mr573497b6e.18.1770334920052; 
 Thu, 05 Feb 2026 15:42:00 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-462fe9a12d0sm291048b6e.1.2026.02.05.15.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 15:41:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Brian Sune <briansune@gmail.com>, Phil Phil Sutter <phil@nwl.cc>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, adsp-linux@analog.com
Subject: [PATCH v2] arm: spl: Ensure 8 byte alignment of appended DTB without
 separate BSS
Date: Thu,  5 Feb 2026 17:41:58 -0600
Message-ID: <20260205234158.3768337-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260130183635.2612933-1-trini@konsulko.com>
References: <20260130183635.2612933-1-trini@konsulko.com>
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

Historically, when we have an appended device tree and also our
resulting binary will contain the BSS section, we have ensured that
everything will be where it's expected to be by declaring that the BSS
is overlayed with a symbol matches the end of the port of the ELF binary
that is objcopy'd to the binary we concatenate with. This in turn means
that the logic to generate a "pad" file, which is the size found in the
__bss_size symbol, will be correct and then we can concatenate the
device tree and it will begin at __bss_size at run time.

With commit 5ffc1dcc26d3 ("arm: Remove rel.dyn from SPL linker scripts")
we removed this overlay as part of trying to ensure that we met both the
requirements of the device tree to be 8 byte aligned as well as that our
logic to generate the -pad file would match what ended up in the
resulting binary. While it was correct to remove an unused section it
did not solve ultimately solve the problem for all cases.

To really fix the problem, we need to do two things. First, our final
section prior to _image_binary_end must be 8 byte aligned (for the case
of having a separate BSS and so our appended DTB exists at this
location). This cannot be '.binman_sym_table' as it may be empty, and in
turn the ELF type would be NOBITS and so not copied with objcopy. The
__u_boot_list section will never be empty, so it is our final section,
and ends with a '. = ALIGN(8)' statement. Second, as this is the end of
our copied data it is safe to declare that the BSS starts here, so use
the OVERLAY keyword to place the BSS here.

Fixes: 5ffc1dcc26d3 ("arm: Remove rel.dyn from SPL linker scripts")
Reported-by: Brian Sune <briansune@gmail.com>
Reported-by: Phil Phil Sutter <phil@nwl.cc>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc: Greg Malysa <malysagreg@gmail.com>
Cc: Ian Roberts <ian.roberts@timesys.com>
Cc: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Cc: Utsav Agarwal <utsav.agarwal@analog.com>
Cc: Arturs Artamonovs <arturs.artamonovs@analog.com>
Cc: adsp-linux@analog.com

So, first, with the exception of:
axm brppt2 imx28_btt3 imx28_xea mk808 taurus work_92105
all platforms using arch/arm/cpu/u-boot-spl.lds do NOT enable
CONFIG_SPL_SEPARATE_BSS. And of those, only brppt2 enables SPL_OF_REAL.
As an aside, I'm thinking that there is room for a clean-up / merger of
arch/arm/cpu/u-boot-spl.lds and arch/arm/mach-omap2/u-boot-spl.lds
(*widely* used outside of mach-omap2). But for this patch, that one case
is handled correctly, with the first change I explained. All other 32bit
platforms are handled with the second.

Which means second, 64bit ARM platforms. With the exception of:
socfpga_agilex7m socfpga_n5x_atf socfpga_n5x_vab socfpga_stratix10_atf
all ARM64 SPL_FRAMEWORK using platforms use the
arch/arm/cpu/armv8/u-boot-spl.lds explicitly. These other ones set
CONFIG_SPL_LDSCRIPT to a non-existant file and then fall back to using
arch/arm/cpu/armv8/u-boot-spl.lds. There are only 4 platforms which
don't use a separate BSS section and so could trip up the above as well:
r8a779g0_whitehawk r8a779g3_sparrowhawk sc598-som-ezkit-spl sc598-som-ezlite-spl
I have inspected the Renesas platforms manually, and I'm a little unsure
how this case works on the two sc598 platforms.
---
 arch/arm/cpu/armv8/u-boot-spl.lds | 15 ++++++++-------
 arch/arm/cpu/u-boot-spl.lds       | 12 ++++++------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
index b732133ce76d..39020a1fddde 100644
--- a/arch/arm/cpu/armv8/u-boot-spl.lds
+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
@@ -49,12 +49,6 @@ SECTIONS
 	} >.sram
 #endif
 
-	__u_boot_list : {
-		. = ALIGN(8);
-		KEEP(*(SORT(__u_boot_list*)));
-		. = ALIGN(8);
-	} >.sram
-
 	.binman_sym_table : {
 		. = ALIGN(8);
 		__binman_sym_start = .;
@@ -63,6 +57,12 @@ SECTIONS
 		. = ALIGN(8);
 	} > .sram
 
+	__u_boot_list : {
+		. = ALIGN(8);
+		KEEP(*(SORT(__u_boot_list*)));
+		. = ALIGN(8);
+	} >.sram
+
 	__image_copy_end = .;
 	_end = .;
 	_image_binary_end = .;
@@ -75,7 +75,7 @@ SECTIONS
 		__bss_end = .;
 	} >.sdram
 #else
-	.bss (NOLOAD) : {
+	.bss _image_binary_end (OVERLAY) : {
 		__bss_start = .;
 		*(.bss*)
 		 . = ALIGN(8);
@@ -99,5 +99,6 @@ SECTIONS
 
 ASSERT(_image_binary_end % 8 == 0, \
        "_image_binary_end must be 8-byte aligned for device tree");
+
 ASSERT(ADDR(.bss) % 8 == 0, \
        ".bss must be 8-byte aligned");
diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
index c578c3ebf821..97083319d39d 100644
--- a/arch/arm/cpu/u-boot-spl.lds
+++ b/arch/arm/cpu/u-boot-spl.lds
@@ -31,16 +31,16 @@ SECTIONS
 		*(.data*)
 	}
 
-	. = ALIGN(4);
-	__u_boot_list : {
-		KEEP(*(SORT(__u_boot_list*)));
-	}
-
 	. = ALIGN(4);
 	.binman_sym_table : {
 		__binman_sym_start = .;
 		KEEP(*(SORT(.binman_sym*)));
 		__binman_sym_end = .;
+	}
+
+	. = ALIGN(4);
+	__u_boot_list : {
+		KEEP(*(SORT(__u_boot_list*)));
 		. = ALIGN(8);
 	}
 
@@ -48,7 +48,7 @@ SECTIONS
 	_image_binary_end = .;
 	_end = .;
 
-	.bss : {
+	.bss _image_binary_end (OVERLAY) : {
 		__bss_start = .;
 		*(.bss*)
 		 . = ALIGN(8);
-- 
2.43.0

