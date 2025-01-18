Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74290C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D84398063E;
	Sat, 18 Jan 2025 07:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="M4z7spk+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ySyWJehp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 445C08070C; Sat, 18 Jan 2025 07:15:00 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D589480077
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YZmXx36Wmz9sm9;
 Sat, 18 Jan 2025 07:14:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737180897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vrNA+DFT6FSdgTp/FDxr+ROYWz8+Ru4/OdiR3dd6v3I=;
 b=M4z7spk+F8nF3fMh83xJ3/y80STNPAmZnDS+DmciS6ne3hko16wYAMYDxrKbgDUFZlektt
 6xR0lRznZIk6NUSR+z1QOlyzzhZjrPy6+yJL1idUBR3DQaNMXLbcaDFsFy/dQy7p16Ir8Z
 fIx/HILW85Zzkd9EX1YIdLrhrQxJWM+ejZJgLh1jfCCM/xoQIdmZaxAGHJgqQeG9yE4XzM
 bxt8IqVouDMm6D8iFqVGTuO/jBy4I14jvUp6XGYWyrZFeQ8rSl50QD6hRI+2aRe8Idmxr9
 LHBGmbgHqOHuOUZ0jKNmIF9Gb7LAJ5H9YIs5fQfYNXC4HhWA2v9bcX7LScltQQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737180895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vrNA+DFT6FSdgTp/FDxr+ROYWz8+Ru4/OdiR3dd6v3I=;
 b=ySyWJehpMCuUcluNin36PedxrybF5KSnyfovfrxZjJkQF4Oj6Z13myOkDcvEiBRfrMOU6/
 PBKZn3ZcoCmiei63bVx/K2hLrqgwx8DUexZC7WJIHazzNNA6R7KvrQxUwF2w56Wqdt59lh
 8M1ilWwoD6CluDBBAweffy10QNS+2EX+WFqkMIaoTr+fMM1FQXbTtWFeBeMyy2GPpHS4Gg
 quemhb6h4H756hxTlBagMzGW5sSKc2MxKeECXD4fbe16UpiTpq8x7QddpCrwt5AEuFRTXE
 MyvG47sI4EwSmN/ORV1JMrTG7suy9/guOySl2/KpU5DI0a2QmbQSoTFkNJY2dw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: miiphybb: configs: Drop CONFIG_BITBANGMII_MULTI
Date: Sat, 18 Jan 2025 07:14:35 +0100
Message-ID: <20250118061445.124932-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3k4bhmin6o5k8y7ap4efjn7rxkqbe8tg
X-MBO-RS-ID: f13b8adf0f005f68cf2
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

It seems that every remaining system which enables BITBANGMII also
enables BITBANGMII_MULTI . Remove the BITBANGMII_MULTI symbol and
assume it is always enabled. This allows removal of a bit of legacy
code. No functional change intended.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 configs/alt_defconfig                |  1 -
 configs/controlcenterdc_defconfig    |  1 -
 configs/gose_defconfig               |  1 -
 configs/grpeach_defconfig            |  1 -
 configs/koelsch_defconfig            |  1 -
 configs/lager_defconfig              |  1 -
 configs/porter_defconfig             |  1 -
 configs/r8a779a0_falcon_defconfig    |  1 -
 configs/r8a779g0_whitehawk_defconfig |  1 -
 configs/r8a779h0_grayhawk_defconfig  |  1 -
 configs/renesas_rcar3.config         |  1 -
 configs/silk_defconfig               |  1 -
 configs/stout_defconfig              |  1 -
 doc/README.bitbangMII                | 25 ++------
 drivers/net/phy/Kconfig              |  4 --
 drivers/net/phy/miiphybb.c           | 89 ----------------------------
 include/miiphy.h                     |  2 -
 17 files changed, 4 insertions(+), 129 deletions(-)

diff --git a/configs/alt_defconfig b/configs/alt_defconfig
index 488115d9a5c..7b16923e34d 100644
--- a/configs/alt_defconfig
+++ b/configs/alt_defconfig
@@ -38,7 +38,6 @@ CONFIG_SH_MMCIF=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_BITBANGMII=y
-CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ8XXX=y
 CONFIG_SH_ETHER=y
diff --git a/configs/controlcenterdc_defconfig b/configs/controlcenterdc_defconfig
index 2d6c83a5d5f..e6242e22509 100644
--- a/configs/controlcenterdc_defconfig
+++ b/configs/controlcenterdc_defconfig
@@ -85,7 +85,6 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_MV=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_BITBANGMII=y
-CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PHY_MARVELL=y
 CONFIG_PHY_GIGE=y
diff --git a/configs/gose_defconfig b/configs/gose_defconfig
index d212f91bf83..b53f2f37409 100644
--- a/configs/gose_defconfig
+++ b/configs/gose_defconfig
@@ -36,7 +36,6 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=spi0.0:256k(u-boot-spl),512k(u-boot-env1),512k
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_BITBANGMII=y
-CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ8XXX=y
 CONFIG_SH_ETHER=y
diff --git a/configs/grpeach_defconfig b/configs/grpeach_defconfig
index a4005438c19..d2cc1cf7981 100644
--- a/configs/grpeach_defconfig
+++ b/configs/grpeach_defconfig
@@ -52,7 +52,6 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_BITBANGMII=y
-CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_SMSC=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_SH_ETHER=y
diff --git a/configs/koelsch_defconfig b/configs/koelsch_defconfig
index 9bce9e33104..eeb97474b2a 100644
--- a/configs/koelsch_defconfig
+++ b/configs/koelsch_defconfig
@@ -36,7 +36,6 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=spi0.0:256k(u-boot-spl),512k(u-boot-env1),512k
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_BITBANGMII=y
-CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ8XXX=y
 CONFIG_SH_ETHER=y
diff --git a/configs/lager_defconfig b/configs/lager_defconfig
index 0d4eed0ddf7..b5682526c8c 100644
--- a/configs/lager_defconfig
+++ b/configs/lager_defconfig
@@ -38,7 +38,6 @@ CONFIG_SH_MMCIF=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_BITBANGMII=y
-CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ8XXX=y
 CONFIG_SH_ETHER=y
diff --git a/configs/porter_defconfig b/configs/porter_defconfig
index 98a67bee3e0..cb18024da12 100644
--- a/configs/porter_defconfig
+++ b/configs/porter_defconfig
@@ -36,7 +36,6 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=spi0.0:256k(u-boot-spl),512k(u-boot-env1),512k
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_BITBANGMII=y
-CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ8XXX=y
 CONFIG_SH_ETHER=y
diff --git a/configs/r8a779a0_falcon_defconfig b/configs/r8a779a0_falcon_defconfig
index aae4406bf04..f4f5c57451f 100644
--- a/configs/r8a779a0_falcon_defconfig
+++ b/configs/r8a779a0_falcon_defconfig
@@ -17,7 +17,6 @@ CONFIG_DEFAULT_FDT_FILE="r8a779a0-falcon.dtb"
 CONFIG_SYS_PBSIZE=2068
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_BITBANGMII=y
-CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_RENESAS_RAVB=y
diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
index c74051d1af9..b49a81dcd49 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -19,7 +19,6 @@ CONFIG_SYS_CBSIZE=2048
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BITBANGMII=y
-CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_RENESAS_RAVB=y
diff --git a/configs/r8a779h0_grayhawk_defconfig b/configs/r8a779h0_grayhawk_defconfig
index ef709214f03..5b9ad93a596 100644
--- a/configs/r8a779h0_grayhawk_defconfig
+++ b/configs/r8a779h0_grayhawk_defconfig
@@ -16,7 +16,6 @@ CONFIG_SYS_CBSIZE=2048
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_MMC_ENV_PART=2
 CONFIG_BITBANGMII=y
-CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_RENESAS_RAVB=y
diff --git a/configs/renesas_rcar3.config b/configs/renesas_rcar3.config
index 7f7fab7df1d..9f2413ae928 100644
--- a/configs/renesas_rcar3.config
+++ b/configs/renesas_rcar3.config
@@ -1,5 +1,4 @@
 #include <configs/renesas_rcar64.config>
 
 CONFIG_BITBANGMII=y
-CONFIG_BITBANGMII_MULTI=y
 CONFIG_SYS_PBSIZE=2068
diff --git a/configs/silk_defconfig b/configs/silk_defconfig
index 53597e9dd4d..1c70a16bf5b 100644
--- a/configs/silk_defconfig
+++ b/configs/silk_defconfig
@@ -38,7 +38,6 @@ CONFIG_SH_MMCIF=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_BITBANGMII=y
-CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ8XXX=y
 CONFIG_SH_ETHER=y
diff --git a/configs/stout_defconfig b/configs/stout_defconfig
index a25a5627c2c..59bb7075013 100644
--- a/configs/stout_defconfig
+++ b/configs/stout_defconfig
@@ -36,7 +36,6 @@ CONFIG_MTDPARTS_DEFAULT="mtdparts=spi0.0:256k(u-boot-spl),512k(u-boot-env1),512k
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_BITBANGMII=y
-CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ8XXX=y
 CONFIG_SH_ETHER=y
diff --git a/doc/README.bitbangMII b/doc/README.bitbangMII
index 0a2fa48a56f..05ab20376f3 100644
--- a/doc/README.bitbangMII
+++ b/doc/README.bitbangMII
@@ -7,28 +7,11 @@ The driver requires that the following macros should be defined into the board
 configuration file:
 
 CONFIG_BITBANGMII	- Enable the miiphybb driver
-CONFIG_BITBANGMII_MULTI - Enable the multi bus support
 
-If the CONFIG_BITBANGMII_MULTI is not defined, the board's config file needs
-to define at least the following macros:
-
-MII_INIT      - Generic code to enable the MII bus (optional)
-MDIO_DECLARE  - Declaration needed to access to the MDIO pin (optional)
-MDIO_ACTIVE   - Activate the MDIO pin as out pin
-MDIO_TRISTATE - Activate the MDIO pin as input/tristate pin
-MDIO_READ     - Read the MDIO pin
-MDIO(v)       - Write v on the MDIO pin
-MDC_DECLARE   - Declaration needed to access to the MDC pin (optional)
-MDC(v)	      - Write v on the MDC pin
-
-The previous macros make the driver compatible with the previous version
-(that didn't support the multi-bus).
-
-When the CONFIG_BITBANGMII_MULTI is also defined, the board code needs to fill
-the bb_miiphy_buses[] array with a record for each required bus and declare
-the bb_miiphy_buses_num variable with the number of mii buses.
-The record (struct bb_miiphy_bus) has the following fields/callbacks (see
-miiphy.h for details):
+The board code needs to fill the bb_miiphy_buses[] array with a record for
+each required bus and declare the bb_miiphy_buses_num variable with the
+number of mii buses. The record (struct bb_miiphy_bus) has the following
+fields/callbacks (see miiphy.h for details):
 
 char name[]	       - The symbolic name that must be equal to the MII bus
 			 registered name
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 13e73810ad6..3132718e4f8 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -2,10 +2,6 @@
 config BITBANGMII
 	bool "Bit-banged ethernet MII management channel support"
 
-config BITBANGMII_MULTI
-	bool "Enable the multi bus support"
-	depends on BITBANGMII
-
 config MV88E6352_SWITCH
 	bool "Marvell 88E6352 switch support"
 
diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index b143137893f..171c1719b5b 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -17,90 +17,6 @@
 #include <miiphy.h>
 #include <asm/global_data.h>
 
-#ifndef CONFIG_BITBANGMII_MULTI
-
-/*
- * If CONFIG_BITBANGMII_MULTI is not defined we use a
- * compatibility layer with the previous miiphybb implementation
- * based on macros usage.
- *
- */
-static int bb_mii_init_wrap(struct bb_miiphy_bus *bus)
-{
-#ifdef MII_INIT
-	MII_INIT;
-#endif
-	return 0;
-}
-
-static int bb_mdio_active_wrap(struct bb_miiphy_bus *bus)
-{
-#ifdef MDIO_DECLARE
-	MDIO_DECLARE;
-#endif
-	MDIO_ACTIVE;
-	return 0;
-}
-
-static int bb_mdio_tristate_wrap(struct bb_miiphy_bus *bus)
-{
-#ifdef MDIO_DECLARE
-	MDIO_DECLARE;
-#endif
-	MDIO_TRISTATE;
-	return 0;
-}
-
-static int bb_set_mdio_wrap(struct bb_miiphy_bus *bus, int v)
-{
-#ifdef MDIO_DECLARE
-	MDIO_DECLARE;
-#endif
-	MDIO(v);
-	return 0;
-}
-
-static int bb_get_mdio_wrap(struct bb_miiphy_bus *bus, int *v)
-{
-#ifdef MDIO_DECLARE
-	MDIO_DECLARE;
-#endif
-	*v = MDIO_READ;
-	return 0;
-}
-
-static int bb_set_mdc_wrap(struct bb_miiphy_bus *bus, int v)
-{
-#ifdef MDC_DECLARE
-	MDC_DECLARE;
-#endif
-	MDC(v);
-	return 0;
-}
-
-static int bb_delay_wrap(struct bb_miiphy_bus *bus)
-{
-	MIIDELAY;
-	return 0;
-}
-
-struct bb_miiphy_bus bb_miiphy_buses[] = {
-	{
-		.name = BB_MII_DEVNAME,
-		.init = bb_mii_init_wrap,
-		.mdio_active = bb_mdio_active_wrap,
-		.mdio_tristate = bb_mdio_tristate_wrap,
-		.set_mdio = bb_set_mdio_wrap,
-		.get_mdio = bb_get_mdio_wrap,
-		.set_mdc = bb_set_mdc_wrap,
-		.delay = bb_delay_wrap,
-	}
-};
-
-int bb_miiphy_buses_num = sizeof(bb_miiphy_buses) /
-			  sizeof(bb_miiphy_buses[0]);
-#endif
-
 int bb_miiphy_init(void)
 {
 	int i;
@@ -114,7 +30,6 @@ int bb_miiphy_init(void)
 
 static inline struct bb_miiphy_bus *bb_miiphy_getbus(const char *devname)
 {
-#ifdef CONFIG_BITBANGMII_MULTI
 	int i;
 
 	/* Search the correct bus */
@@ -124,10 +39,6 @@ static inline struct bb_miiphy_bus *bb_miiphy_getbus(const char *devname)
 		}
 	}
 	return NULL;
-#else
-	/* We have just one bitbanging bus */
-	return &bb_miiphy_buses[0];
-#endif
 }
 
 /*****************************************************************************
diff --git a/include/miiphy.h b/include/miiphy.h
index 5abffd8fb6b..2bb4f62ea76 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -72,9 +72,7 @@ struct bb_miiphy_bus {
 	int (*get_mdio)(struct bb_miiphy_bus *bus, int *v);
 	int (*set_mdc)(struct bb_miiphy_bus *bus, int v);
 	int (*delay)(struct bb_miiphy_bus *bus);
-#ifdef CONFIG_BITBANGMII_MULTI
 	void *priv;
-#endif
 };
 
 extern struct bb_miiphy_bus bb_miiphy_buses[];
-- 
2.45.2

