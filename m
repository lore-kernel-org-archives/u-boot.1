Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060A6CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 10:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D43C87488;
	Fri, 20 Oct 2023 12:21:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="FDKY+9Hz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA5BD87469; Fri, 20 Oct 2023 12:21:25 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D275280F06
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 12:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-991c786369cso99743166b.1
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 03:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1697797283; x=1698402083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KVLbCyuuu61IBmb1+yGoQUkko3ipX0YBEu2ka5e53Y=;
 b=FDKY+9HzDwewu9mwXYnbDuUyygU1DeBmySa9lX6Ba0cod2/iRwTVe93jL2p5DFaPls
 wFbJinaBcSNC3B2ueX+qwA5qaCjZz/wOGnmTja27kfKdZTxXczLKBI4VhKSbRjEcrGjH
 DMadSbKEPYVn0p6ytHzMW0m9818YIrM5Zx9gewqUgSNvR50BqkpUPyh/zOP5A1CNaqGR
 A4Y+0R84u2aPPOC3AjQsT9evPnmWaZMx3btAOMHHIVbG4hOkTh+gCtmdHxUc+FgLC+G/
 VgYVlk/je+wievRQwDLew9qMUTDlf9h/A7VW7EddYC/ALALJkUqJTIp/ZIkhbAZqP8Hz
 AG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697797283; x=1698402083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KVLbCyuuu61IBmb1+yGoQUkko3ipX0YBEu2ka5e53Y=;
 b=bDuExTzLU6Srd/oq4G2K3tMDx+L8J0P2d49pitG1+E5NDFRoNatLADdu2SoYDv+LSi
 jS2aIm+dcX4nded+BWpMCvdEIX5q3dzsnR6+/+v4f3EDUDcSxKJtO395ykWggBlFuxYq
 Y6Z1zyc3TrFII63VAvfIdOosrtUyNR/ik1XVOzbYXwZ7DMZd/aCQzXm/1LUt/n2dLt4K
 IOnpPlY9mkjJVdnp7slQSNWPm3bi4YHbDQfWIivxfCAf9g8e8FNfwmho3yx0mb9T4P/t
 GEBQMcINskEB6i7wXJKvTxgzErVLw/30QM0+6AvlzS6wg8ykBwZPY+1I2dsdtxkH7fxK
 EZAg==
X-Gm-Message-State: AOJu0Yzy+PV4QCiTyJDi6Yjthi5/MFSjagS8e/gCtFoQSk4QZP3vAkhD
 q7Bc8kkVQ6CJAx4h/Md+9m485zC0qNoRw3WN1XA=
X-Google-Smtp-Source: AGHT+IE8xhgGt3OsizT2bJOKxZBT1pB7J6UewZMOuE8CcmGXpfqGbrXIwzOvmzC0yUkdS/IKoxmfHw==
X-Received: by 2002:a17:907:26c2:b0:9ae:6ffd:bdf7 with SMTP id
 bp2-20020a17090726c200b009ae6ffdbdf7mr1072712ejc.39.1697797283268; 
 Fri, 20 Oct 2023 03:21:23 -0700 (PDT)
Received: from fedora.. (dh207-96-32.xnet.hr. [88.207.96.32])
 by smtp.googlemail.com with ESMTPSA id
 e27-20020a170906749b00b009a198078c53sm1204693ejl.214.2023.10.20.03.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 03:21:22 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: sr@denx.de,
	u-boot@lists.denx.de
Cc: Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 3/3] arm: mvebu: eDPU: support new board revision
Date: Fri, 20 Oct 2023 12:20:55 +0200
Message-ID: <20231020102117.1583572-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020102117.1583572-1-robert.marko@sartura.hr>
References: <20231020102117.1583572-1-robert.marko@sartura.hr>
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
 arch/arm/dts/armada-3720-eDPU-u-boot.dtsi |  13 ++-
 arch/arm/dts/armada-3720-eDPU.dts         |  47 ++++++++
 board/Marvell/mvebu_armada-37xx/board.c   | 125 ++++++++++++++++++++++
 configs/eDPU_defconfig                    |   1 +
 4 files changed, 181 insertions(+), 5 deletions(-)

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
index f532486b70..aeddff7468 100644
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
@@ -73,6 +77,27 @@ DECLARE_GLOBAL_DATA_PTR;
 #define A3700_MC_CTRL2_SDRAM_TYPE_DDR3	2
 #define A3700_MC_CTRL2_SDRAM_TYPE_DDR4	3
 
+static bool is_edpu_plus(void)
+{
+	struct udevice *bus;
+	ofnode node;
+	int val;
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
@@ -357,6 +382,41 @@ static int espressobin_last_stage_init(void)
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
@@ -364,6 +424,9 @@ static int last_stage_init(void)
 	if (of_machine_is_compatible("globalscale,espressobin"))
 		return espressobin_last_stage_init();
 
+	if (of_machine_is_compatible("methode,edpu"))
+		return edpu_plus_last_stage_init();
+
 	return 0;
 }
 EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, last_stage_init);
@@ -465,12 +528,74 @@ static int espressobin_fdt_setup(void *blob)
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
index f51df7861a..6bd28f9a1a 100644
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
2.41.0

