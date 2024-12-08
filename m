Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5069AE7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 22:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A472089586;
	Sun,  8 Dec 2024 23:06:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WETRFY3x";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wpAD6Pqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F47189575; Sun,  8 Dec 2024 23:06:26 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4217894BD
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 23:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Y5zbf4SCMz9spH;
 Sun,  8 Dec 2024 23:06:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbUf69NqTt+FHxM46siJIaaPeNAhFj0/8+1ghB7Y5qw=;
 b=WETRFY3xjSS9g7uyLto3PwYR6+5U2QiJNoMd0AsFiElv/t5JN3YFUIVA7sRs1bhg6q1hB7
 EvVw48+4folA1jEF3xeFlFFhmsRw9kKorIoILsxs5HCmkvN83W5EaKbf2SK2AV4WExzEei
 JBVk/brgh0vxxIAoPsnjq8cPNACma3/QhAyLu32nw5TL3WxtSYCxQHI1Soyvl/9txl2AbY
 iXNoPb35/fIs8vMcXI0ZZ7jD9zVCH1jpYCjN1TQHWYXgiM/xcVXEwE6Q2dPJmcu4crp1Rq
 nTBruxJviGWmrMShuRYm3luOjgWvnNFI/67hDI1a9Q82cdu0NmULoVEq1UCmmw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733695580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbUf69NqTt+FHxM46siJIaaPeNAhFj0/8+1ghB7Y5qw=;
 b=wpAD6PqaEwIBGPfYI6aKbKvuM3AILUDqGch68YqgI5yn3Sk9I6+JvRFb11SMJ2Qrp6ONYS
 bB/f5BNg6u9AHMTT/SUQplx7T91U4H7ZpjDvw6f0tvnkyScUhEXlM7ldJrpIWZ3khYpz9c
 JVr50zDfyLg8h4brSGwKmXrxAHPsRadaUBVrr0Ou3cfajdLtXCx97MjiGTlN5rhTk/mqrL
 C1CAUZlNl38ZMaQI7XsIyHvj3d/N+G3vxYBMMzCpectd7boU/U3IWy7wjjUHYJWlWalukx
 d+9+1/KfhOpLF6q9hPNEIN+I1n6mQLvk3kPcDwm9GbsU9to3d4RSHcubqO92SQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/13] ARM: renesas: Fix R-Car spelling
Date: Sun,  8 Dec 2024 23:03:55 +0100
Message-ID: <20241208220551.204743-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
References: <20241208220551.204743-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: z73rfm1dbc8a3giq6w8p59t4egz3o79i
X-MBO-RS-ID: d88f3bbe3064ccd261c
X-Rspamd-Queue-Id: 4Y5zbf4SCMz9spH
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

The correct spelling is R-Car, including the dash, update the usage.
Kconfig strings and comment changes only, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/mach-renesas/Kconfig.32           | 4 ++--
 arch/arm/mach-renesas/include/mach/boot0.h | 2 +-
 arch/arm/mach-renesas/memmap-gen3.c        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-renesas/Kconfig.32 b/arch/arm/mach-renesas/Kconfig.32
index 693a5abba0d..bbc61ccf480 100644
--- a/arch/arm/mach-renesas/Kconfig.32
+++ b/arch/arm/mach-renesas/Kconfig.32
@@ -1,11 +1,11 @@
 if RCAR_32
 
 config ARCH_RENESAS_BOARD_STRING
-	string "Renesas RCar Gen2 board name"
+	string "Renesas R-Car Gen2 board name"
 	default "Board"
 
 config RCAR_GEN2
-	bool "Renesas RCar Gen2"
+	bool "Renesas R-Car Gen2"
 	select PHY
 	select PHY_RCAR_GEN2
 	select TMU_TIMER
diff --git a/arch/arm/mach-renesas/include/mach/boot0.h b/arch/arm/mach-renesas/include/mach/boot0.h
index fe88a2e0373..2128eccd8a4 100644
--- a/arch/arm/mach-renesas/include/mach/boot0.h
+++ b/arch/arm/mach-renesas/include/mach/boot0.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Specialty padding for the RCar Gen2 SPL JTAG loading
+ * Specialty padding for the R-Car Gen2 SPL JTAG loading
  */
 
 #ifndef __BOOT0_H
diff --git a/arch/arm/mach-renesas/memmap-gen3.c b/arch/arm/mach-renesas/memmap-gen3.c
index c50700df078..d24419f5daa 100644
--- a/arch/arm/mach-renesas/memmap-gen3.c
+++ b/arch/arm/mach-renesas/memmap-gen3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Renesas RCar Gen3 memory map tables
+ * Renesas R-Car Gen3 memory map tables
  *
  * Copyright (C) 2017 Marek Vasut <marek.vasut@gmail.com>
  */
-- 
2.45.2

