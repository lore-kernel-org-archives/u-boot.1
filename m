Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994F1C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BF0088016;
	Tue, 27 Feb 2024 17:10:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="AXBmYO2H";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OjWW2yEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 680F588016; Tue, 27 Feb 2024 17:10:11 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4802387FEB
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TkjB86k9Cz9t2Z;
 Tue, 27 Feb 2024 17:10:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hbps1h+WvKGDFINhOz11+FULn5/852cCIudD//8xn24=;
 b=AXBmYO2HVB97G6R1xMmvrgTzlWtiyPxPZG0W2aWxMM/ga41v+vbhoySOiomXFwRB1CMG3L
 6uRAk+y17dupjHGIeVp50N/MKqULFPuX9azoluVcuZBVXR2cAUQi+ow06KskxwWUjvncQb
 bIYSMjpKRMxWM/JtwO/mJZ8ZKF3HboSxaxaqsYGnRHKdAPjg2BqYlPb/WqWxgvqrAFdKyG
 xY7dqciO7qiWCW/Hm/8E4EKxH5rcXARBez9ulAYKUGyZKDGnZ4Glq7KvpyRBjXGZeKziM5
 FYl6F+VUOKo6hGjqOyQ9sPMeLTR+5ZqDtLXXCS7EERXOFrQSJiwEvJQLXajPGg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hbps1h+WvKGDFINhOz11+FULn5/852cCIudD//8xn24=;
 b=OjWW2yEV/rC9sX6Gk1fIxVxt754+jiujYeEmrUfF2prTV2gaN1AsQovnKaANiYP2B7EUGh
 UfaprddW6cHhQJyCCgbAW2P7v3mAnxY1abNkTPNHtvZ74IurE4Ep8coGRuyU9720qZ06Bj
 hXP8tk2Gi9O6TDtZstcOdlxWo7cW6qI5TbbMQ+6iIJimKaNOY0+RVRVqnTJpFu8PAvOf+g
 1c+4/yDuI3R+lY+Q0+HhKHn2XBzgy1ZraPuQEKzN63zR2xsLw0b/PWmjW9TywLBjrz/pWi
 GBU2yXctx6fTTEW5OwmMidQ8cR8ICNutLPT5ESmhz29ni5a3QR6F1hvLwVGlZA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/19] ARM: renesas: Drop unused sh_sdhi.h
Date: Tue, 27 Feb 2024 17:05:42 +0100
Message-ID: <20240227160912.412181-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jbobu9ijumstprbj943yjqechguttnk9
X-MBO-RS-ID: 2f8097d2d379462e21a
X-Rspamd-Queue-Id: 4TkjB86k9Cz9t2Z
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

This file is no longer used, the SDHI controller driver is long
superseded by drivers/mmc/renesas-sdhi.c which includes all the
details of the hardware. Remove this file include from all board
files and remove the file itself. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-rmobile/include/mach/sh_sdhi.h | 170 -------------------
 board/renesas/alt/alt.c                      |   1 -
 board/renesas/blanche/blanche.c              |   1 -
 board/renesas/draak/draak.c                  |   1 -
 board/renesas/gose/gose.c                    |   1 -
 board/renesas/koelsch/koelsch.c              |   1 -
 board/renesas/lager/lager.c                  |   1 -
 board/renesas/porter/porter.c                |   1 -
 board/renesas/salvator-x/salvator-x.c        |   1 -
 board/renesas/silk/silk.c                    |   1 -
 board/renesas/stout/stout.c                  |   1 -
 board/renesas/ulcb/ulcb.c                    |   1 -
 12 files changed, 181 deletions(-)
 delete mode 100644 arch/arm/mach-rmobile/include/mach/sh_sdhi.h

diff --git a/arch/arm/mach-rmobile/include/mach/sh_sdhi.h b/arch/arm/mach-rmobile/include/mach/sh_sdhi.h
deleted file mode 100644
index 7741718be14..00000000000
--- a/arch/arm/mach-rmobile/include/mach/sh_sdhi.h
+++ /dev/null
@@ -1,170 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * drivers/mmc/sh-sdhi.h
- *
- * SD/MMC driver for Renesas rmobile ARM SoCs
- *
- * Copyright (C) 2013-2017 Renesas Electronics Corporation
- * Copyright (C) 2008-2009 Renesas Solutions Corp.
- */
-
-#ifndef _SH_SDHI_H
-#define _SH_SDHI_H
-
-#include <linux/bitops.h>
-#define SDHI_CMD			(0x0000 >> 1)
-#define SDHI_PORTSEL			(0x0004 >> 1)
-#define SDHI_ARG0			(0x0008 >> 1)
-#define SDHI_ARG1			(0x000C >> 1)
-#define SDHI_STOP			(0x0010 >> 1)
-#define SDHI_SECCNT			(0x0014 >> 1)
-#define SDHI_RSP00			(0x0018 >> 1)
-#define SDHI_RSP01			(0x001C >> 1)
-#define SDHI_RSP02			(0x0020 >> 1)
-#define SDHI_RSP03			(0x0024 >> 1)
-#define SDHI_RSP04			(0x0028 >> 1)
-#define SDHI_RSP05			(0x002C >> 1)
-#define SDHI_RSP06			(0x0030 >> 1)
-#define SDHI_RSP07			(0x0034 >> 1)
-#define SDHI_INFO1			(0x0038 >> 1)
-#define SDHI_INFO2			(0x003C >> 1)
-#define SDHI_INFO1_MASK			(0x0040 >> 1)
-#define SDHI_INFO2_MASK			(0x0044 >> 1)
-#define SDHI_CLK_CTRL			(0x0048 >> 1)
-#define SDHI_SIZE			(0x004C >> 1)
-#define SDHI_OPTION			(0x0050 >> 1)
-#define SDHI_ERR_STS1			(0x0058 >> 1)
-#define SDHI_ERR_STS2			(0x005C >> 1)
-#define SDHI_BUF0			(0x0060 >> 1)
-#define SDHI_SDIO_MODE			(0x0068 >> 1)
-#define SDHI_SDIO_INFO1			(0x006C >> 1)
-#define SDHI_SDIO_INFO1_MASK		(0x0070 >> 1)
-#define SDHI_CC_EXT_MODE		(0x01B0 >> 1)
-#define SDHI_SOFT_RST			(0x01C0 >> 1)
-#define SDHI_VERSION			(0x01C4 >> 1)
-#define SDHI_HOST_MODE			(0x01C8 >> 1)
-#define SDHI_SDIF_MODE			(0x01CC >> 1)
-#define SDHI_EXT_SWAP			(0x01E0 >> 1)
-#define SDHI_SD_DMACR			(0x0324 >> 1)
-
-/* SDHI CMD VALUE */
-#define CMD_MASK			0x0000ffff
-
-/* SDHI_PORTSEL */
-#define USE_1PORT			(1 << 8) /* 1 port */
-
-/* SDHI_ARG */
-#define ARG0_MASK			0x0000ffff
-#define ARG1_MASK			0x0000ffff
-
-/* SDHI_STOP */
-#define STOP_SEC_ENABLE			(1 << 8)
-
-/* SDHI_INFO1 */
-#define INFO1_RESP_END			(1 << 0)
-#define INFO1_ACCESS_END		(1 << 2)
-#define INFO1_CARD_RE			(1 << 3)
-#define INFO1_CARD_IN			(1 << 4)
-#define INFO1_ISD0CD			(1 << 5)
-#define INFO1_WRITE_PRO			(1 << 7)
-#define INFO1_DATA3_CARD_RE		(1 << 8)
-#define INFO1_DATA3_CARD_IN		(1 << 9)
-#define INFO1_DATA3			(1 << 10)
-
-/* SDHI_INFO2 */
-#define INFO2_CMD_ERROR			(1 << 0)
-#define INFO2_CRC_ERROR			(1 << 1)
-#define INFO2_END_ERROR			(1 << 2)
-#define INFO2_TIMEOUT			(1 << 3)
-#define INFO2_BUF_ILL_WRITE		(1 << 4)
-#define INFO2_BUF_ILL_READ		(1 << 5)
-#define INFO2_RESP_TIMEOUT		(1 << 6)
-#define INFO2_SDDAT0			(1 << 7)
-#define INFO2_BRE_ENABLE		(1 << 8)
-#define INFO2_BWE_ENABLE		(1 << 9)
-#define INFO2_CBUSY			(1 << 14)
-#define INFO2_ILA			(1 << 15)
-#define INFO2_ALL_ERR			(0x807f)
-
-/* SDHI_INFO1_MASK */
-#define INFO1M_RESP_END			(1 << 0)
-#define INFO1M_ACCESS_END		(1 << 2)
-#define INFO1M_CARD_RE			(1 << 3)
-#define INFO1M_CARD_IN			(1 << 4)
-#define INFO1M_DATA3_CARD_RE		(1 << 8)
-#define INFO1M_DATA3_CARD_IN		(1 << 9)
-#define INFO1M_ALL			(0xffff)
-#define INFO1M_SET			(INFO1M_RESP_END |	\
-					INFO1M_ACCESS_END |	\
-					INFO1M_DATA3_CARD_RE |	\
-					INFO1M_DATA3_CARD_IN)
-
-/* SDHI_INFO2_MASK */
-#define INFO2M_CMD_ERROR		(1 << 0)
-#define INFO2M_CRC_ERROR		(1 << 1)
-#define INFO2M_END_ERROR		(1 << 2)
-#define INFO2M_TIMEOUT			(1 << 3)
-#define INFO2M_BUF_ILL_WRITE		(1 << 4)
-#define INFO2M_BUF_ILL_READ		(1 << 5)
-#define INFO2M_RESP_TIMEOUT		(1 << 6)
-#define INFO2M_BRE_ENABLE		(1 << 8)
-#define INFO2M_BWE_ENABLE		(1 << 9)
-#define INFO2M_ILA			(1 << 15)
-#define INFO2M_ALL			(0xffff)
-#define INFO2M_ALL_ERR			(0x807f)
-
-/* SDHI_CLK_CTRL */
-#define CLK_ENABLE			(1 << 8)
-
-/* SDHI_OPTION */
-#define OPT_BUS_WIDTH_M			(5 << 13)	/* 101b (15-13bit) */
-#define OPT_BUS_WIDTH_1			(4 << 13)	/* bus width = 1 bit */
-#define OPT_BUS_WIDTH_4			(0 << 13)	/* bus width = 4 bit */
-#define OPT_BUS_WIDTH_8			(1 << 13)	/* bus width = 8 bit */
-
-/* SDHI_ERR_STS1 */
-#define ERR_STS1_CRC_ERROR		((1 << 11) | (1 << 10) | (1 << 9) | \
-					(1 << 8) | (1 << 5))
-#define ERR_STS1_CMD_ERROR		((1 << 4) | (1 << 3) | (1 << 2) | \
-					(1 << 1) | (1 << 0))
-
-/* SDHI_ERR_STS2 */
-#define ERR_STS2_RES_TIMEOUT		(1 << 0)
-#define ERR_STS2_RES_STOP_TIMEOUT	((1 << 0) | (1 << 1))
-#define ERR_STS2_SYS_ERROR		((1 << 6) | (1 << 5) | (1 << 4) | \
-					(1 << 3) | (1 << 2) | (1 << 1) | \
-					(1 << 0))
-
-/* SDHI_SDIO_MODE */
-#define SDIO_MODE_ON			(1 << 0)
-#define SDIO_MODE_OFF			(0 << 0)
-
-/* SDHI_SDIO_INFO1 */
-#define SDIO_INFO1_IOIRQ		(1 << 0)
-#define SDIO_INFO1_EXPUB52		(1 << 14)
-#define SDIO_INFO1_EXWT			(1 << 15)
-
-/* SDHI_SDIO_INFO1_MASK */
-#define SDIO_INFO1M_CLEAR		((1 << 1) | (1 << 2))
-#define SDIO_INFO1M_ON			((1 << 15) | (1 << 14) | (1 << 2) | \
-					 (1 << 1) | (1 << 0))
-
-/* SDHI_EXT_SWAP */
-#define SET_SWAP			((1 << 6) | (1 << 7))	/* SWAP */
-
-/* SDHI_SOFT_RST */
-#define SOFT_RST_ON			(0 << 0)
-#define SOFT_RST_OFF			(1 << 0)
-
-#define	CLKDEV_SD_DATA			25000000	/* 25 MHz */
-#define CLKDEV_HS_DATA			50000000	/* 50 MHz */
-#define CLKDEV_MMC_DATA			20000000	/* 20MHz */
-#define	CLKDEV_INIT			400000		/* 100 - 400 KHz */
-
-/* For quirk */
-#define SH_SDHI_QUIRK_16BIT_BUF		BIT(0)
-#define SH_SDHI_QUIRK_64BIT_BUF		BIT(1)
-
-int sh_sdhi_init(unsigned long addr, int ch, unsigned long quirks);
-
-#endif /* _SH_SDHI_H */
diff --git a/board/renesas/alt/alt.c b/board/renesas/alt/alt.c
index be77cade01b..323ca5d6507 100644
--- a/board/renesas/alt/alt.c
+++ b/board/renesas/alt/alt.c
@@ -25,7 +25,6 @@
 #include <asm/arch/rmobile.h>
 #include <asm/arch/rcar-mstp.h>
 #include <asm/arch/mmc.h>
-#include <asm/arch/sh_sdhi.h>
 #include <netdev.h>
 #include <miiphy.h>
 #include <i2c.h>
diff --git a/board/renesas/blanche/blanche.c b/board/renesas/blanche/blanche.c
index c6ecea2afcf..41dadf942ee 100644
--- a/board/renesas/blanche/blanche.c
+++ b/board/renesas/blanche/blanche.c
@@ -12,7 +12,6 @@
 #include <asm/arch/mmc.h>
 #include <asm/arch/rcar-mstp.h>
 #include <asm/arch/rmobile.h>
-#include <asm/arch/sh_sdhi.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
diff --git a/board/renesas/draak/draak.c b/board/renesas/draak/draak.c
index 06a3a832984..6242d2858dc 100644
--- a/board/renesas/draak/draak.c
+++ b/board/renesas/draak/draak.c
@@ -24,7 +24,6 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/rmobile.h>
 #include <asm/arch/rcar-mstp.h>
-#include <asm/arch/sh_sdhi.h>
 #include <i2c.h>
 #include <mmc.h>
 
diff --git a/board/renesas/gose/gose.c b/board/renesas/gose/gose.c
index 6edbdac3ded..74e6bca7893 100644
--- a/board/renesas/gose/gose.c
+++ b/board/renesas/gose/gose.c
@@ -25,7 +25,6 @@
 #include <asm/gpio.h>
 #include <asm/arch/rmobile.h>
 #include <asm/arch/rcar-mstp.h>
-#include <asm/arch/sh_sdhi.h>
 #include <netdev.h>
 #include <miiphy.h>
 #include <i2c.h>
diff --git a/board/renesas/koelsch/koelsch.c b/board/renesas/koelsch/koelsch.c
index ee5597ad3d9..4d59b82a8ad 100644
--- a/board/renesas/koelsch/koelsch.c
+++ b/board/renesas/koelsch/koelsch.c
@@ -26,7 +26,6 @@
 #include <asm/gpio.h>
 #include <asm/arch/rmobile.h>
 #include <asm/arch/rcar-mstp.h>
-#include <asm/arch/sh_sdhi.h>
 #include <netdev.h>
 #include <miiphy.h>
 #include <i2c.h>
diff --git a/board/renesas/lager/lager.c b/board/renesas/lager/lager.c
index 0daad0b1e6d..e60dbc7a68c 100644
--- a/board/renesas/lager/lager.c
+++ b/board/renesas/lager/lager.c
@@ -29,7 +29,6 @@
 #include <asm/arch/rmobile.h>
 #include <asm/arch/rcar-mstp.h>
 #include <asm/arch/mmc.h>
-#include <asm/arch/sh_sdhi.h>
 #include <miiphy.h>
 #include <i2c.h>
 #include <mmc.h>
diff --git a/board/renesas/porter/porter.c b/board/renesas/porter/porter.c
index 2e6051addb1..c0f91c75627 100644
--- a/board/renesas/porter/porter.c
+++ b/board/renesas/porter/porter.c
@@ -26,7 +26,6 @@
 #include <asm/gpio.h>
 #include <asm/arch/rmobile.h>
 #include <asm/arch/rcar-mstp.h>
-#include <asm/arch/sh_sdhi.h>
 #include <netdev.h>
 #include <miiphy.h>
 #include <i2c.h>
diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvator-x/salvator-x.c
index d8312ddb8a9..71b168893f3 100644
--- a/board/renesas/salvator-x/salvator-x.c
+++ b/board/renesas/salvator-x/salvator-x.c
@@ -25,7 +25,6 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/rmobile.h>
 #include <asm/arch/rcar-mstp.h>
-#include <asm/arch/sh_sdhi.h>
 #include <i2c.h>
 #include <mmc.h>
 
diff --git a/board/renesas/silk/silk.c b/board/renesas/silk/silk.c
index 18ff7591228..0ea357a4ba4 100644
--- a/board/renesas/silk/silk.c
+++ b/board/renesas/silk/silk.c
@@ -26,7 +26,6 @@
 #include <asm/arch/rmobile.h>
 #include <asm/arch/rcar-mstp.h>
 #include <asm/arch/mmc.h>
-#include <asm/arch/sh_sdhi.h>
 #include <netdev.h>
 #include <miiphy.h>
 #include <i2c.h>
diff --git a/board/renesas/stout/stout.c b/board/renesas/stout/stout.c
index 131deac1c7a..6fedeb31b38 100644
--- a/board/renesas/stout/stout.c
+++ b/board/renesas/stout/stout.c
@@ -28,7 +28,6 @@
 #include <asm/arch/rmobile.h>
 #include <asm/arch/rcar-mstp.h>
 #include <asm/arch/mmc.h>
-#include <asm/arch/sh_sdhi.h>
 #include <miiphy.h>
 #include <i2c.h>
 #include <mmc.h>
diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
index b2a16b03513..3c2f7c5e815 100644
--- a/board/renesas/ulcb/ulcb.c
+++ b/board/renesas/ulcb/ulcb.c
@@ -23,7 +23,6 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/rmobile.h>
 #include <asm/arch/rcar-mstp.h>
-#include <asm/arch/sh_sdhi.h>
 #include <i2c.h>
 #include <mmc.h>
 
-- 
2.43.0

