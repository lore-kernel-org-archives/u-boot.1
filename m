Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB651C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2309488059;
	Tue, 27 Feb 2024 17:10:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jbri2XpE";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qCummaXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 959238802C; Tue, 27 Feb 2024 17:10:22 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 184B788005
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TkjBM06rHz9str;
 Tue, 27 Feb 2024 17:10:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gl3gZzNoWnxgy7KObnKGlhCKWwfMSIFF5A0Ypl0KXxE=;
 b=jbri2XpE6q5yrlDD5FvODJi8uzcjLXSKNDqpG8FWhEBnE9dmyr7NEn+iog3psdytHW/SS0
 lRAekWbQFYTmba0yjvQkGs0xy6MMAgOepfBuk/bLStjPFHHP2Vzh+4TUxeLnrCDwJrqjCx
 5UEveMEWA5zPH/5lqz1TTQdY/Z07sEgAJvFnzcV3bTIisex4rfsqqewXFa9LA/Lzh9YSjG
 iFL8KIw45A6RqguEh/uYG55YFtDlCU4CI6dL7iGOxHsi76+3N2F2KMG22RLOnXlPh2y4H0
 H8G6WCeHQaZ1QCVxpw53eGe6kRXa6X7k9fF5wTXwq4oD9/i1tudSneY81rFKfA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gl3gZzNoWnxgy7KObnKGlhCKWwfMSIFF5A0Ypl0KXxE=;
 b=qCummaXFe8uSZzf+Ou3Qo4nvXY8HSA9VVPL5knUWveNYnnKtmGy+ld6SU9EJH2p7Dolnkc
 59trXwixSSDbuquyfdlcleDcjwbBcOMTgpswPJMsYnkSJzbln8mCh+NcODIFfXUclKObO0
 ntg/lcYsgyxEYP3q5TxMXGBP/Hf+EP5UdqPmdeKFL07b7KFYO1lh5i68rK+YiK9DvjJzfc
 eaOm9mgIIPqC4+Czcr+LhEQxalYsTfGFIUxlkUk+0Na7WO6GNAswWE/WJv3z5fOxR+hEW2
 KiXe5r2zSHm0ad/Plm0bkLml+eyu34mNl1wlke17V2eftUoD2qA5Ab5mszPL7A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/19] ARM: renesas: Rename ARCH_RMOBILE_BOARD_STRING to
 ARCH_RENESAS_BOARD_STRING
Date: Tue, 27 Feb 2024 17:05:52 +0100
Message-ID: <20240227160912.412181-13-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 07e6f511eeab66f9b95
X-MBO-RS-META: z3wcrciy8x69k8cmsrpoj33ejda9xirs
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

Rename ARCH_RMOBILE_BOARD_STRING to ARCH_RENESAS_BOARD_STRING
because all the chips are made by Renesas, while only a subset
of them is from the R-Mobile line.

Use the following command to perform the rename:

"
$ git grep -l 'ARCH_RMOBILE_BOARD_STRING' | \
  xargs -I {} sed -i 's@ARCH_RMOBILE_BOARD_STRING@ARCH_RENESAS_BOARD_STRING@g' {}
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-rmobile/Kconfig.32 | 2 +-
 arch/arm/mach-rmobile/board.c    | 4 ++--
 configs/alt_defconfig            | 2 +-
 configs/blanche_defconfig        | 2 +-
 configs/gose_defconfig           | 2 +-
 configs/koelsch_defconfig        | 2 +-
 configs/lager_defconfig          | 2 +-
 configs/porter_defconfig         | 2 +-
 configs/silk_defconfig           | 2 +-
 configs/stout_defconfig          | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-rmobile/Kconfig.32 b/arch/arm/mach-rmobile/Kconfig.32
index f7079a26b06..b546e097c34 100644
--- a/arch/arm/mach-rmobile/Kconfig.32
+++ b/arch/arm/mach-rmobile/Kconfig.32
@@ -1,6 +1,6 @@
 if RCAR_32
 
-config ARCH_RMOBILE_BOARD_STRING
+config ARCH_RENESAS_BOARD_STRING
 	string "Renesas RCar Gen2 board name"
 	default "Board"
 
diff --git a/arch/arm/mach-rmobile/board.c b/arch/arm/mach-rmobile/board.c
index 79c7e02671f..f061e41173a 100644
--- a/arch/arm/mach-rmobile/board.c
+++ b/arch/arm/mach-rmobile/board.c
@@ -7,10 +7,10 @@
 #include <init.h>
 #include <asm/io.h>
 
-#ifdef CONFIG_ARCH_RMOBILE_BOARD_STRING
+#ifdef CONFIG_ARCH_RENESAS_BOARD_STRING
 int checkboard(void)
 {
-	printf("Board: %s\n", CONFIG_ARCH_RMOBILE_BOARD_STRING);
+	printf("Board: %s\n", CONFIG_ARCH_RENESAS_BOARD_STRING);
 	return 0;
 }
 #endif
diff --git a/configs/alt_defconfig b/configs/alt_defconfig
index 35707a65960..ff2f7d22bbc 100644
--- a/configs/alt_defconfig
+++ b/configs/alt_defconfig
@@ -18,7 +18,7 @@ CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="r8a7794-alt-u-boot"
 CONFIG_SPL_TEXT_BASE=0xe6300000
-CONFIG_ARCH_RMOBILE_BOARD_STRING="Alt"
+CONFIG_ARCH_RENESAS_BOARD_STRING="Alt"
 CONFIG_R8A7794=y
 CONFIG_TARGET_ALT=y
 CONFIG_SYS_MONITOR_LEN=262144
diff --git a/configs/blanche_defconfig b/configs/blanche_defconfig
index f328af84dfa..d8c0f784176 100644
--- a/configs/blanche_defconfig
+++ b/configs/blanche_defconfig
@@ -13,7 +13,7 @@ CONFIG_ENV_OFFSET=0x40000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="r8a7792-blanche-u-boot"
-CONFIG_ARCH_RMOBILE_BOARD_STRING="Blanche"
+CONFIG_ARCH_RENESAS_BOARD_STRING="Blanche"
 CONFIG_R8A7792=y
 CONFIG_TARGET_BLANCHE=y
 CONFIG_SYS_MONITOR_LEN=262144
diff --git a/configs/gose_defconfig b/configs/gose_defconfig
index 92bb5911765..6f2a015d3e9 100644
--- a/configs/gose_defconfig
+++ b/configs/gose_defconfig
@@ -18,7 +18,7 @@ CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="r8a7793-gose-u-boot"
 CONFIG_SPL_TEXT_BASE=0xe6300000
-CONFIG_ARCH_RMOBILE_BOARD_STRING="Gose"
+CONFIG_ARCH_RENESAS_BOARD_STRING="Gose"
 CONFIG_R8A7793=y
 CONFIG_TARGET_GOSE=y
 CONFIG_SYS_MONITOR_LEN=262144
diff --git a/configs/koelsch_defconfig b/configs/koelsch_defconfig
index 8d9c3b94499..37511f8fe9a 100644
--- a/configs/koelsch_defconfig
+++ b/configs/koelsch_defconfig
@@ -18,7 +18,7 @@ CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="r8a7791-koelsch-u-boot"
 CONFIG_SPL_TEXT_BASE=0xe6300000
-CONFIG_ARCH_RMOBILE_BOARD_STRING="Koelsch"
+CONFIG_ARCH_RENESAS_BOARD_STRING="Koelsch"
 CONFIG_R8A7791=y
 CONFIG_TARGET_KOELSCH=y
 CONFIG_SYS_MONITOR_LEN=262144
diff --git a/configs/lager_defconfig b/configs/lager_defconfig
index d00314c60e4..30582bfa3b1 100644
--- a/configs/lager_defconfig
+++ b/configs/lager_defconfig
@@ -18,7 +18,7 @@ CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="r8a7790-lager-u-boot"
 CONFIG_SPL_TEXT_BASE=0xe6300000
-CONFIG_ARCH_RMOBILE_BOARD_STRING="Lager"
+CONFIG_ARCH_RENESAS_BOARD_STRING="Lager"
 CONFIG_R8A7790=y
 CONFIG_TARGET_LAGER=y
 CONFIG_SYS_MONITOR_LEN=262144
diff --git a/configs/porter_defconfig b/configs/porter_defconfig
index a343c8e83de..2f4f03d27f2 100644
--- a/configs/porter_defconfig
+++ b/configs/porter_defconfig
@@ -18,7 +18,7 @@ CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="r8a7791-porter-u-boot"
 CONFIG_SPL_TEXT_BASE=0xe6300000
-CONFIG_ARCH_RMOBILE_BOARD_STRING="Porter"
+CONFIG_ARCH_RENESAS_BOARD_STRING="Porter"
 CONFIG_R8A7791=y
 CONFIG_TARGET_PORTER=y
 CONFIG_SYS_MONITOR_LEN=262144
diff --git a/configs/silk_defconfig b/configs/silk_defconfig
index 5f08ae0fcf9..e0ed90fa7e1 100644
--- a/configs/silk_defconfig
+++ b/configs/silk_defconfig
@@ -18,7 +18,7 @@ CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="r8a7794-silk-u-boot"
 CONFIG_SPL_TEXT_BASE=0xe6300000
-CONFIG_ARCH_RMOBILE_BOARD_STRING="Silk"
+CONFIG_ARCH_RENESAS_BOARD_STRING="Silk"
 CONFIG_R8A7794=y
 CONFIG_TARGET_SILK=y
 CONFIG_SYS_MONITOR_LEN=262144
diff --git a/configs/stout_defconfig b/configs/stout_defconfig
index 0375630adea..9f5c61d0e1d 100644
--- a/configs/stout_defconfig
+++ b/configs/stout_defconfig
@@ -18,7 +18,7 @@ CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="r8a7790-stout-u-boot"
 CONFIG_SPL_TEXT_BASE=0xe6300000
-CONFIG_ARCH_RMOBILE_BOARD_STRING="Stout"
+CONFIG_ARCH_RENESAS_BOARD_STRING="Stout"
 CONFIG_R8A7790=y
 CONFIG_TARGET_STOUT=y
 CONFIG_SYS_MONITOR_LEN=262144
-- 
2.43.0

