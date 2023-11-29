Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1625C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 10:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B4C686EA3;
	Wed, 29 Nov 2023 11:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="EkJH7VoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 901A587669; Wed, 29 Nov 2023 11:11:25 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6113687142
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 11:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a178d491014so36947766b.3
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 02:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1701252683; x=1701857483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gM12MWhADOHhUwBXZpVxo+rQNShKuKQcuBDN6a6sZ7I=;
 b=EkJH7VoHEvy81wpOmvTa+t4HiMo4omTGBypi3SLy7wyNUOQ3LMCfaEyQed4KN3MWjx
 j7M0YWG7tlelTa7PB0JnMa/ysrZKmGiarElrf4Eywz9US6W78WwTMAi1EEb820eSVgsb
 LMFJmGSEDS/FKt04gM6zYAcNr829OlkFf7JPOlk4CzyGVifH+0LkqYu7Zu8GpKpNOSot
 9qFgDH8Io6bYoahn50649W+jCFibtvQR7gZXmOip7SJTr4DCbJ8WErHUY5Js8crnZF1G
 1wJJUByzVCkpajM+nZzNoihShJ0/WXlaI6Xoks8mgpjE1HIazFNDAOlcHpaf8U/M0C7B
 QBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701252683; x=1701857483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gM12MWhADOHhUwBXZpVxo+rQNShKuKQcuBDN6a6sZ7I=;
 b=ZpWLNHNuFiMhGEwH5PO+vh9w+R7Vhd5MLfOGmaQzf6Oe41UcxQldyfL9ms23fonWDj
 thwzUgujupPmhQBM1HUxEixBDzVuy7XuCnBKv+YOTEn6j8gOnp6LLfZWgMHl7DCU2gF6
 RrAfBIYo6N+etzZb1jLoev/MzHzpZKSG/jyGd1IvdfMzEZkcjzMpwMd7lJv7uVfKwy0v
 fgXRupCdgKXE2W9pzBaIaCjEle7SgVxeEdcfm/9sE1T1bdd1zX1bNKjejCLbzZxx46ZD
 cwY/I7K3OpNzkhbXtGG6Mo0RQ7bTPj/Jn4qTk2BYQrdWYJYcsMOtLBuRxO0kOVXOXO/o
 U7fg==
X-Gm-Message-State: AOJu0YysqZ1baKZcWj0o/oaFkspjiTCC9NOytz94Qi1AkukMmFXUH1T5
 7y4864+X14dv8PpYdb+zUyFR0u8TO5+IId90jps=
X-Google-Smtp-Source: AGHT+IFZhkrZ/8S4kz6sGu5kWNgyuxIx6VJcuyaulHU4x7KzBBLSkAa/rm+5/I13d2CSD0B0fFedEA==
X-Received: by 2002:a17:906:2511:b0:9c2:2d0a:320c with SMTP id
 i17-20020a170906251100b009c22d0a320cmr13002150ejb.46.1701252682771; 
 Wed, 29 Nov 2023 02:11:22 -0800 (PST)
Received: from fedora.. ([213.149.38.84])
 by smtp.googlemail.com with ESMTPSA id
 t17-20020a170906a11100b00a015eac52dcsm7691384ejy.108.2023.11.29.02.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 02:11:21 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: sr@denx.de,
	u-boot@lists.denx.de
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 3/3] arm: mvebu: eDPU: support new board revision
Date: Wed, 29 Nov 2023 11:11:08 +0100
Message-ID: <20231129101117.60177-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129101117.60177-1-robert.marko@sartura.hr>
References: <20231129101117.60177-1-robert.marko@sartura.hr>
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

There is a new eDPU revision that uses Marvell 88E6361 switch onboard.
We can rely on detecting the switch to enable and fixup the Linux DTS
so a single DTS can be used.

There is currently no support for the 88E6361 switch and thus no working
networking in U-Boot, so we disable both ports.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Stefan Roese <sr@denx.de>
---
Changes in v3:
* Add check for DM_MDIO

 arch/arm/dts/armada-3720-eDPU-u-boot.dtsi |  13 ++-
 arch/arm/dts/armada-3720-eDPU.dts         |  47 ++++++++
 board/Marvell/mvebu_armada-37xx/board.c   | 128 ++++++++++++++++++++++
 configs/eDPU_defconfig                    |   1 +
 4 files changed, 184 insertions(+), 5 deletions(-)

diff --git a/arch/arm/dts/armada-3720-eDPU-u-boot.dtsi b/arch/arm/dts/armada-3720-eDPU-u-boot.dtsi
index cb02b70e54..c3d450dd83 100644
--- a/arch/arm/dts/armada-3720-eDPU-u-boot.dtsi
+++ b/arch/arm/dts/armada-3720-eDPU-u-boot.dtsi
@@ -32,14 +32,17 @@
 	bootph-all;
 };
 
-&eth0 {
-	/* G.hn does not work without additional configuration */
-	status = "disabled";
-};
-
 &eth1 {
 	fixed-link {
 		speed = <1000>;
 		full-duplex;
 	};
 };
+
+/*
+ * eDPU v2 has a MV88E6361 switch on the MDIO bus and U-boot is used
+ * to patch the Linux DTS if its found so enable MDIO by default.
+ */
+&mdio {
+	status = "okay";
+};
diff --git a/arch/arm/dts/armada-3720-eDPU.dts b/arch/arm/dts/armada-3720-eDPU.dts
index 57fc698e55..d6d37a1f6f 100644
--- a/arch/arm/dts/armada-3720-eDPU.dts
+++ b/arch/arm/dts/armada-3720-eDPU.dts
@@ -12,3 +12,50 @@
 &eth0 {
 	phy-mode = "2500base-x";
 };
+
+/*
+ * External MV88E6361 switch is only available on v2 of the board.
+ * U-Boot will enable the MDIO bus and switch nodes.
+ */
+&mdio {
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&smi_pins>;
+
+	/* Actual device is MV88E6361 */
+	switch: switch@0 {
+		compatible = "marvell,mv88e6190";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				label = "cpu";
+				phy-mode = "2500base-x";
+				managed = "in-band-status";
+				ethernet = <&eth0>;
+			};
+
+			port@9 {
+				reg = <9>;
+				label = "downlink";
+				phy-mode = "2500base-x";
+				managed = "in-band-status";
+			};
+
+			port@a {
+				reg = <10>;
+				label = "uplink";
+				phy-mode = "2500base-x";
+				managed = "in-band-status";
+				sfp = <&sfp_eth1>;
+			};
+		};
+	};
+};
diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
index f532486b70..1685b12b84 100644
--- a/board/Marvell/mvebu_armada-37xx/board.c
+++ b/board/Marvell/mvebu_armada-37xx/board.c
@@ -14,6 +14,7 @@
 #include <mmc.h>
 #include <miiphy.h>
 #include <phy.h>
+#include <fdt_support.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
@@ -50,6 +51,7 @@ DECLARE_GLOBAL_DATA_PTR;
 /* Single-chip mode */
 /* Switch Port Registers */
 #define MVEBU_SW_LINK_CTRL_REG		(1)
+#define MVEBU_SW_PORT_SWITCH_ID		(3)
 #define MVEBU_SW_PORT_CTRL_REG		(4)
 #define MVEBU_SW_PORT_BASE_VLAN		(6)
 
@@ -57,6 +59,8 @@ DECLARE_GLOBAL_DATA_PTR;
 #define MVEBU_G2_SMI_PHY_CMD_REG	(24)
 #define MVEBU_G2_SMI_PHY_DATA_REG	(25)
 
+#define SWITCH_88E6361_PRODUCT_NUMBER	0x2610
+
 /*
  * Memory Controller Registers
  *
@@ -73,6 +77,30 @@ DECLARE_GLOBAL_DATA_PTR;
 #define A3700_MC_CTRL2_SDRAM_TYPE_DDR3	2
 #define A3700_MC_CTRL2_SDRAM_TYPE_DDR4	3
 
+static bool is_edpu_plus(void)
+{
+	struct udevice *bus;
+	ofnode node;
+	int val;
+
+	if (!CONFIG_IS_ENABLED(DM_MDIO))
+		return false;
+
+	node = ofnode_by_compatible(ofnode_null(), "marvell,orion-mdio");
+	if (!ofnode_valid(node) ||
+	    uclass_get_device_by_ofnode(UCLASS_MDIO, node, &bus) ||
+	    device_probe(bus)) {
+		printf("Cannot find MDIO bus\n");
+		return -ENODEV;
+	}
+
+	val = dm_mdio_read(bus, 0x0, MDIO_DEVAD_NONE, MVEBU_SW_PORT_SWITCH_ID);
+	if (val == SWITCH_88E6361_PRODUCT_NUMBER)
+		return true;
+	else
+		return false;
+}
+
 int board_early_init_f(void)
 {
 	return 0;
@@ -357,6 +385,41 @@ static int espressobin_last_stage_init(void)
 	return 0;
 }
 
+static int edpu_plus_last_stage_init(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	if (is_edpu_plus()) {
+		ret = uclass_get_device_by_name(UCLASS_ETH,
+						"ethernet@40000",
+						&dev);
+		if (!ret) {
+			device_remove(dev, DM_REMOVE_NORMAL);
+			device_unbind(dev);
+		}
+
+		/* Currently no networking support on the eDPU+ board */
+		ret = uclass_get_device_by_name(UCLASS_ETH,
+						"ethernet@30000",
+						&dev);
+		if (!ret) {
+			device_remove(dev, DM_REMOVE_NORMAL);
+			device_unbind(dev);
+		}
+	} else {
+		ret = uclass_get_device_by_name(UCLASS_ETH,
+						"ethernet@30000",
+						&dev);
+		if (!ret) {
+			device_remove(dev, DM_REMOVE_NORMAL);
+			device_unbind(dev);
+		}
+	}
+
+	return 0;
+}
+
 /* Bring-up board-specific network stuff */
 static int last_stage_init(void)
 {
@@ -364,6 +427,9 @@ static int last_stage_init(void)
 	if (of_machine_is_compatible("globalscale,espressobin"))
 		return espressobin_last_stage_init();
 
+	if (of_machine_is_compatible("methode,edpu"))
+		return edpu_plus_last_stage_init();
+
 	return 0;
 }
 EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
@@ -465,12 +531,74 @@ static int espressobin_fdt_setup(void *blob)
 	return 0;
 }
 
+static int edpu_plus_fdt_setup(void *blob)
+{
+	const char *ports[] = { "downlink", "uplink" };
+	uint8_t mac[ETH_ALEN];
+	const char *path;
+	int i, ret;
+
+	if (is_edpu_plus()) {
+		ret = fdt_set_status_by_compatible(blob,
+						   "marvell,orion-mdio",
+						   FDT_STATUS_OKAY);
+		if (ret)
+			printf("Failed to enable MDIO!\n");
+
+		ret = fdt_set_status_by_alias(blob,
+					      "ethernet1",
+					      FDT_STATUS_DISABLED);
+		if (ret)
+			printf("Failed to disable ethernet1!\n");
+
+		path = fdt_get_alias(blob, "ethernet0");
+		if (path)
+			do_fixup_by_path_string(blob, path, "phy-mode", "2500base-x");
+		else
+			printf("Failed to update ethernet0 phy-mode to 2500base-x!\n");
+
+		ret = fdt_set_status_by_compatible(blob,
+						   "marvell,mv88e6190",
+						   FDT_STATUS_OKAY);
+		if (ret)
+			printf("Failed to enable MV88E6361!\n");
+
+		/*
+		 * MAC-s for Uplink and Downlink ports are stored under
+		 * non standard variable names, so lets manually fixup the
+		 * switch port nodes to have the desired MAC-s.
+		 */
+		for (i = 0; i < 2; i++) {
+			if (eth_env_get_enetaddr(ports[i], mac)) {
+				do_fixup_by_prop(blob,
+						 "label",
+						 ports[i],
+						 strlen(ports[i]) + 1,
+						 "mac-address",
+						 mac, ARP_HLEN, 1);
+
+				do_fixup_by_prop(blob,
+						 "label",
+						 ports[i],
+						 strlen(ports[i]) + 1,
+						 "local-mac-address",
+						 mac, ARP_HLEN, 1);
+			}
+		}
+	}
+
+	return 0;
+}
+
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
 #ifdef CONFIG_ENV_IS_IN_SPI_FLASH
 	if (of_machine_is_compatible("globalscale,espressobin"))
 		return espressobin_fdt_setup(blob);
 #endif
+	if (of_machine_is_compatible("methode,edpu"))
+		return edpu_plus_fdt_setup(blob);
+
 	return 0;
 }
 #endif
diff --git a/configs/eDPU_defconfig b/configs/eDPU_defconfig
index 238f91cf6b..34c302485b 100644
--- a/configs/eDPU_defconfig
+++ b/configs/eDPU_defconfig
@@ -17,6 +17,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_OF_BOARD_SETUP=y
 CONFIG_USE_PREBOOT=y
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
-- 
2.43.0

