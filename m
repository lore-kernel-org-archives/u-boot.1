Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B69EC5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D06488020;
	Tue, 27 Feb 2024 17:10:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="moFegFt4";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tkcr6xmo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C2E888022; Tue, 27 Feb 2024 17:10:13 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E11B8800E
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TkjBB018lz9sl6;
 Tue, 27 Feb 2024 17:10:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9QwfvfZFSHS3CZxK/X0N7s0iIbKMOSKURR3FyTbJeU=;
 b=moFegFt4GzdypNyyHMjY1NEO2UVmKYewrL9O9Sj9aV1f7u6DR/FEDzws5PU1+/C3tg4GaX
 AiLjGGdX9i0UTlfXvOys0ll6yZ7iuawzDGVSI2KttPIOmwod9Y1ADFOFOgdwP/SFHtH6ov
 3X9RNnU1yNCGq1Ii4wb9uxsHLScYrGol2zha6ROX4AXBEJdgDkPzoYqmYtdfpD3sQKwW2K
 W62cfpwVS3n9fI0e5FLUQR8x149uos159+SUO4sw6TPvw+Qez3JyFECzatpwKiOEsU3Xvq
 1Y8iPxAnEr6c+vLrlhSW0x+ZHSoc7YYiaYoRqsZVJG46QyV3tegTBeFxH7CyYQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9QwfvfZFSHS3CZxK/X0N7s0iIbKMOSKURR3FyTbJeU=;
 b=tkcr6xmo9bc2Rmczv6hvUevIa4d+B5ekAOPr3onCEdnbJVdxlcNKSmGopMCMFeTCYNglTm
 fiudBnvIHMKuOa/4SyufFSa9jAsVO05o7/0Q2KXDkUQzektvFgOv5+Ozm6WJSA8m8XceKw
 RLkp0mz7UM2Gd+jKQpEYqSuAFenNQScFsRky5LfwpL5o5cegL9Vn07ztzZv4hn09wodMcL
 Mm7Lj77KSNJTU05XmOOvBuJ2F7w+bSeEWcpYot9dj9ioq73TvLiap8ueDbxRDOWt4TiBQX
 UhrWKBJ0rsLGnAMWp7C4nmO5/BufnlIpETxIviW5EIBCGiHEv6IAifiqeWEEwg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/19] ARM: renesas: Drop unused mmc.h
Date: Tue, 27 Feb 2024 17:05:43 +0100
Message-ID: <20240227160912.412181-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: n5p9irbqzykakymajj95h8pbonbn3xzh
X-MBO-RS-ID: 486a92f24557c412bbf
X-Rspamd-Queue-Id: 4TkjBB018lz9sl6
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

This file is no longer used, the MMCIF controller driver is
superseded by drivers/mmc/sh_mmcif.c which includes all the
details of the hardware. Remove this file include from all
board files and remove the file itself. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-rmobile/include/mach/mmc.h | 13 -------------
 board/renesas/alt/alt.c                  |  1 -
 board/renesas/blanche/blanche.c          |  1 -
 board/renesas/lager/lager.c              |  1 -
 board/renesas/silk/silk.c                |  1 -
 board/renesas/stout/stout.c              |  1 -
 6 files changed, 18 deletions(-)
 delete mode 100644 arch/arm/mach-rmobile/include/mach/mmc.h

diff --git a/arch/arm/mach-rmobile/include/mach/mmc.h b/arch/arm/mach-rmobile/include/mach/mmc.h
deleted file mode 100644
index 7a0e6f0f714..00000000000
--- a/arch/arm/mach-rmobile/include/mach/mmc.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Renesas SuperH MMCIF driver.
- *
- * Copyright (C)  2014 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
- * Copyright (C)  2014 Renesas Electronics Corporation
- */
-#ifndef _RMOBILE_MMC_H_
-#define _RMOBILE_MMC_H_
-
-int mmcif_mmc_init(void);
-
-#endif /* _RMOBILE_MMC_H_ */
diff --git a/board/renesas/alt/alt.c b/board/renesas/alt/alt.c
index 323ca5d6507..c61273489a0 100644
--- a/board/renesas/alt/alt.c
+++ b/board/renesas/alt/alt.c
@@ -24,7 +24,6 @@
 #include <asm/gpio.h>
 #include <asm/arch/rmobile.h>
 #include <asm/arch/rcar-mstp.h>
-#include <asm/arch/mmc.h>
 #include <netdev.h>
 #include <miiphy.h>
 #include <i2c.h>
diff --git a/board/renesas/blanche/blanche.c b/board/renesas/blanche/blanche.c
index 41dadf942ee..faaf42ee901 100644
--- a/board/renesas/blanche/blanche.c
+++ b/board/renesas/blanche/blanche.c
@@ -9,7 +9,6 @@
 #include <cpu_func.h>
 #include <init.h>
 #include <net.h>
-#include <asm/arch/mmc.h>
 #include <asm/arch/rcar-mstp.h>
 #include <asm/arch/rmobile.h>
 #include <asm/arch/sys_proto.h>
diff --git a/board/renesas/lager/lager.c b/board/renesas/lager/lager.c
index e60dbc7a68c..d9d460834b2 100644
--- a/board/renesas/lager/lager.c
+++ b/board/renesas/lager/lager.c
@@ -28,7 +28,6 @@
 #include <asm/gpio.h>
 #include <asm/arch/rmobile.h>
 #include <asm/arch/rcar-mstp.h>
-#include <asm/arch/mmc.h>
 #include <miiphy.h>
 #include <i2c.h>
 #include <mmc.h>
diff --git a/board/renesas/silk/silk.c b/board/renesas/silk/silk.c
index 0ea357a4ba4..7dfbd412f6d 100644
--- a/board/renesas/silk/silk.c
+++ b/board/renesas/silk/silk.c
@@ -25,7 +25,6 @@
 #include <asm/gpio.h>
 #include <asm/arch/rmobile.h>
 #include <asm/arch/rcar-mstp.h>
-#include <asm/arch/mmc.h>
 #include <netdev.h>
 #include <miiphy.h>
 #include <i2c.h>
diff --git a/board/renesas/stout/stout.c b/board/renesas/stout/stout.c
index 6fedeb31b38..46c48dff0a0 100644
--- a/board/renesas/stout/stout.c
+++ b/board/renesas/stout/stout.c
@@ -27,7 +27,6 @@
 #include <asm/gpio.h>
 #include <asm/arch/rmobile.h>
 #include <asm/arch/rcar-mstp.h>
-#include <asm/arch/mmc.h>
 #include <miiphy.h>
 #include <i2c.h>
 #include <mmc.h>
-- 
2.43.0

