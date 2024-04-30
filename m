Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F260C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 15:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53FAB88A78;
	Tue, 30 Apr 2024 17:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="RsBWuxRc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10ECC88A68; Tue, 30 Apr 2024 17:34:26 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DDC888A6A
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 17:34:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b89=ME=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714491160; bh=g4CxLnfN3zAQrVKwwsslMs6pk80vs2B3AWiaCQrgvLM=;
 b=RsBWuxRcaV7FcPTM46nAefq4KpVV5x0Uz7RpfBwwe+yH7qS9Djhr/aa2nob5xMCyCoFIep+z9
 pDNQAXskqj6Yupab16/3jMQAPttthqVVZri7I6RCxYgkbSD+EYS4vvYBfofbOckdoYQTIueNCzh
 x5EyV4SjeMHmZIUFafrXBvL+NVoJtauqglUyNA/Rt0wttpoWNVA83+mgDltFTMe9OlW1UIaWe/L
 oFbLiFXLnyR6U9x+AYcQvAP2bVhfMetDs4FMyLssuWcQUwbxg/+w0IAIBJ2Be0ZVqwVaWyO0Q6I
 szg+f+wi41boQtH5XpjUvgW8fBgNMTBeX5BPDNdwHF6Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Peter Robinson
 <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Levin Du <djw@t-chip.com.cn>, Suniel
 Mahesh <sunil@amarulasolutions.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Andy Yan
 <andy.yan@rock-chips.com>, Nick Xie <nick@khadas.com>, Deepak Das
 <deepakdas.linux@gmail.com>, Alexandre Vicenzi <linux@alxd.me>, Xiaobo
 Tian <peterwillcn@gmail.com>, Christopher Obbard
 <chris.obbard@collabora.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 17/18] rockchip: rk3399: Fix loading FIT from SD-card when
 booting from eMMC
Date: Tue, 30 Apr 2024 15:30:24 +0000
Message-ID: <20240430153053.308788-18-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240430153053.308788-1-jonas@kwiboo.se>
References: <20240430153053.308788-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 66310f05d99e42224315b937
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

When RK3399 boards run SPL from eMMC and fail to load FIT from eMMC due
to it being missing or checksum validation fails there can be a fallback
to read FIT from SD-card. However, without proper pinctrl configuration
reading FIT from SD-card may fail:

  U-Boot SPL 2024.04-rc4 (Mar 17 2024 - 22:54:45 +0000)
  Trying to boot from MMC2
  mmc_load_image_raw_sector: mmc block read error
  Trying to boot from MMC2
  mmc_load_image_raw_sector: mmc block read error
  Trying to boot from MMC1
  Card did not respond to voltage select! : -110
  mmc_init: -95, time 12
  spl: mmc init failed with error: -95
  SPL: failed to boot from all boot devices (err=-6)
  ### ERROR ### Please RESET the board ###

Fix this by tagging related sdhci, sdmmc and spi flash pinctrl nodes
with bootph props. Also move bootph for common nodes shared by all
boards to the SoC u-boot.dtsi.

eMMC, SD-Card and SPI flash nodes are also changed to only be tagged
with bootph props for SPL and U-Boot pre-reloc phases.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Split patch, only keep sdhci, sdmmc and spi1 bootph/pinctrl changes
    in this patch
v2: Also include sdhci, sdmmc and spi1 nodes at pre-reloc phase
v2: Update commit message
---
 arch/arm/dts/rk3399-ficus-u-boot.dtsi        | 10 ++++
 arch/arm/dts/rk3399-gru-u-boot.dtsi          | 24 +++++++++
 arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi |  3 +-
 arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi  | 23 +-------
 arch/arm/dts/rk3399-roc-pc-u-boot.dtsi       |  5 +-
 arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi | 10 ++++
 arch/arm/dts/rk3399-rock960-u-boot.dtsi      | 10 ++++
 arch/arm/dts/rk3399-rockpro64-u-boot.dtsi    |  7 ++-
 arch/arm/dts/rk3399-u-boot.dtsi              | 57 ++++++++++++++++++--
 configs/eaidk-610-rk3399_defconfig           |  2 +-
 configs/evb-rk3399_defconfig                 |  2 +-
 configs/ficus-rk3399_defconfig               |  2 +-
 configs/firefly-rk3399_defconfig             |  2 +-
 configs/khadas-edge-captain-rk3399_defconfig |  2 +-
 configs/khadas-edge-rk3399_defconfig         |  2 +-
 configs/khadas-edge-v-rk3399_defconfig       |  2 +-
 configs/leez-rk3399_defconfig                |  2 +-
 configs/nanopc-t4-rk3399_defconfig           |  2 +-
 configs/nanopi-m4-2gb-rk3399_defconfig       |  2 +-
 configs/nanopi-m4-rk3399_defconfig           |  2 +-
 configs/nanopi-m4b-rk3399_defconfig          |  2 +-
 configs/nanopi-neo4-rk3399_defconfig         |  2 +-
 configs/nanopi-r4s-rk3399_defconfig          |  2 +-
 configs/orangepi-rk3399_defconfig            |  2 +-
 configs/pinebook-pro-rk3399_defconfig        |  2 +-
 configs/pinephone-pro-rk3399_defconfig       |  2 +-
 configs/roc-pc-mezzanine-rk3399_defconfig    |  2 +-
 configs/roc-pc-rk3399_defconfig              |  2 +-
 configs/rock-4c-plus-rk3399_defconfig        |  2 +-
 configs/rock-4se-rk3399_defconfig            |  2 +-
 configs/rock-pi-4-rk3399_defconfig           |  2 +-
 configs/rock-pi-4c-rk3399_defconfig          |  2 +-
 configs/rock-pi-n10-rk3399pro_defconfig      |  2 +-
 configs/rock960-rk3399_defconfig             |  2 +-
 configs/rockpro64-rk3399_defconfig           |  2 +-
 35 files changed, 142 insertions(+), 59 deletions(-)

diff --git a/arch/arm/dts/rk3399-ficus-u-boot.dtsi b/arch/arm/dts/rk3399-ficus-u-boot.dtsi
index 67b63a835238..ac924d6dc592 100644
--- a/arch/arm/dts/rk3399-ficus-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-ficus-u-boot.dtsi
@@ -5,3 +5,13 @@
 
 #include "rk3399-u-boot.dtsi"
 #include "rk3399-sdram-ddr3-1600.dtsi"
+
+&pcfg_pull_none_18ma {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pcfg_pull_up_8ma {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
diff --git a/arch/arm/dts/rk3399-gru-u-boot.dtsi b/arch/arm/dts/rk3399-gru-u-boot.dtsi
index b1604a6872c0..0cc40eb6d6f6 100644
--- a/arch/arm/dts/rk3399-gru-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-gru-u-boot.dtsi
@@ -54,6 +54,30 @@
 	enable-gpios = <&gpio2 2 GPIO_ACTIVE_HIGH>;
 };
 
+&sdhci {
+	/delete-property/ bootph-pre-ram;
+};
+
+&sdmmc {
+	/delete-property/ bootph-pre-ram;
+};
+
+&sdmmc_bus4 {
+	/delete-property/ bootph-pre-ram;
+};
+
+&sdmmc_cd {
+	/delete-property/ bootph-pre-ram;
+};
+
+&sdmmc_clk {
+	/delete-property/ bootph-pre-ram;
+};
+
+&sdmmc_cmd {
+	/delete-property/ bootph-pre-ram;
+};
+
 &spi5 {
 	spi-activate-delay = <100>;
 	spi-max-frequency = <3000000>;
diff --git a/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
index 56fdaf440aea..17af95a114fc 100644
--- a/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-pinebook-pro-u-boot.dtsi
@@ -19,7 +19,8 @@
 };
 
 &spiflash {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &vdd_log {
diff --git a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
index d1912a2ef6a9..1930e5e10353 100644
--- a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
@@ -88,27 +88,8 @@
 };
 
 &norflash {
-	bootph-all;
-};
-
-&pcfg_pull_none {
-	bootph-all;
-};
-
-&pcfg_pull_up {
-	bootph-all;
-};
-
-&sdmmc_bus4 {
-	bootph-all;
-};
-
-&sdmmc_clk {
-	bootph-all;
-};
-
-&sdmmc_cmd {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &uart0 {
diff --git a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
index 58a3c0afcddd..d40daacc7823 100644
--- a/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-roc-pc-u-boot.dtsi
@@ -33,8 +33,9 @@
 };
 
 &spi1 {
-	spi_flash: flash@0 {
-		bootph-all;
+	flash@0 {
+		bootph-pre-ram;
+		bootph-some-ram;
 	};
 };
 
diff --git a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
index 5c1c451b8f85..44dab14dc211 100644
--- a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
@@ -3,3 +3,13 @@
  * Copyright (c) 2023 Radxa Limited
  */
 #include "rk3399-rock-pi-4-u-boot.dtsi"
+
+&pcfg_pull_none_18ma {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pcfg_pull_up_8ma {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
diff --git a/arch/arm/dts/rk3399-rock960-u-boot.dtsi b/arch/arm/dts/rk3399-rock960-u-boot.dtsi
index 55716ba4df73..ef08d8987cee 100644
--- a/arch/arm/dts/rk3399-rock960-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rock960-u-boot.dtsi
@@ -19,3 +19,13 @@
 		vin-supply = <&vcc5v0_sys>;
 	};
 };
+
+&pcfg_pull_none_18ma {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&pcfg_pull_up_8ma {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
index b15e5392c3cf..e280739057df 100644
--- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
@@ -26,8 +26,6 @@
                         };
                 };
         };
-
-
 };
 
 &sdhci {
@@ -36,8 +34,9 @@
 };
 
 &spi1 {
-	spi_flash: flash@0 {
-		bootph-all;
+	flash@0 {
+		bootph-pre-ram;
+		bootph-some-ram;
 	};
 };
 
diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index b39fe39fa2b3..4298552dd999 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -92,13 +92,22 @@
 };
 
 &emmc_phy {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &grf {
 	bootph-all;
 };
 
+&pcfg_pull_none {
+	bootph-all;
+};
+
+&pcfg_pull_up {
+	bootph-all;
+};
+
 &pinctrl {
 	bootph-all;
 };
@@ -116,7 +125,8 @@
 };
 
 &sdhci {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 	max-frequency = <200000000>;
 
 	/* mmc to sram can't do dma, prevent aborts transferring TF-A parts */
@@ -124,14 +134,51 @@
 };
 
 &sdmmc {
-	bootph-all;
+	bootph-pre-ram;
+	bootph-some-ram;
 
 	/* mmc to sram can't do dma, prevent aborts transferring TF-A parts */
 	u-boot,spl-fifo-mode;
 };
 
-&spi1 {
-	bootph-all;
+&sdmmc_bus4 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdmmc_cd {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdmmc_clk {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&sdmmc_cmd {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&spi1_clk {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&spi1_cs0 {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&spi1_rx {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
+&spi1_tx {
+	bootph-pre-ram;
+	bootph-some-ram;
 };
 
 &uart2 {
diff --git a/configs/eaidk-610-rk3399_defconfig b/configs/eaidk-610-rk3399_defconfig
index 4d8b495ccfec..eba6f90c605b 100644
--- a/configs/eaidk-610-rk3399_defconfig
+++ b/configs/eaidk-610-rk3399_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
index c4936768ffb6..afb79987464f 100644
--- a/configs/evb-rk3399_defconfig
+++ b/configs/evb-rk3399_defconfig
@@ -27,7 +27,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
index 3bcd0fd66b91..f4e3ebba8f46 100644
--- a/configs/ficus-rk3399_defconfig
+++ b/configs/ficus-rk3399_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
index 8f68ffbd3a49..db98926b627a 100644
--- a/configs/firefly-rk3399_defconfig
+++ b/configs/firefly-rk3399_defconfig
@@ -29,7 +29,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/khadas-edge-captain-rk3399_defconfig b/configs/khadas-edge-captain-rk3399_defconfig
index 310250ed4a52..230b9d796442 100644
--- a/configs/khadas-edge-captain-rk3399_defconfig
+++ b/configs/khadas-edge-captain-rk3399_defconfig
@@ -27,7 +27,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/khadas-edge-rk3399_defconfig b/configs/khadas-edge-rk3399_defconfig
index 3fe5542d1256..9f13cbf58398 100644
--- a/configs/khadas-edge-rk3399_defconfig
+++ b/configs/khadas-edge-rk3399_defconfig
@@ -27,7 +27,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/khadas-edge-v-rk3399_defconfig b/configs/khadas-edge-v-rk3399_defconfig
index 4b41454d710d..abc4f2054cfd 100644
--- a/configs/khadas-edge-v-rk3399_defconfig
+++ b/configs/khadas-edge-v-rk3399_defconfig
@@ -27,7 +27,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/leez-rk3399_defconfig b/configs/leez-rk3399_defconfig
index 2831cfb36689..13453e523444 100644
--- a/configs/leez-rk3399_defconfig
+++ b/configs/leez-rk3399_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk3399_defconfig
index cdfacb66e678..f935716ccf47 100644
--- a/configs/nanopc-t4-rk3399_defconfig
+++ b/configs/nanopc-t4-rk3399_defconfig
@@ -28,7 +28,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2gb-rk3399_defconfig
index 51596f57ae35..d142b702ce89 100644
--- a/configs/nanopi-m4-2gb-rk3399_defconfig
+++ b/configs/nanopi-m4-2gb-rk3399_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk3399_defconfig
index 2af84fb6ff17..8ce879da4c07 100644
--- a/configs/nanopi-m4-rk3399_defconfig
+++ b/configs/nanopi-m4-rk3399_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk3399_defconfig
index 1b76f98e0df7..33ef74a1f690 100644
--- a/configs/nanopi-m4b-rk3399_defconfig
+++ b/configs/nanopi-m4b-rk3399_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-rk3399_defconfig
index c176c5a12111..45a7d0a3257d 100644
--- a/configs/nanopi-neo4-rk3399_defconfig
+++ b/configs/nanopi-neo4-rk3399_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
index ea01d323541b..a666547fe597 100644
--- a/configs/nanopi-r4s-rk3399_defconfig
+++ b/configs/nanopi-r4s-rk3399_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/orangepi-rk3399_defconfig b/configs/orangepi-rk3399_defconfig
index c6a92b2decf3..337eeab8b42b 100644
--- a/configs/orangepi-rk3399_defconfig
+++ b/configs/orangepi-rk3399_defconfig
@@ -25,7 +25,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
index e4aad1b710cb..a250624dfaa9 100644
--- a/configs/pinebook-pro-rk3399_defconfig
+++ b/configs/pinebook-pro-rk3399_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
index 285c47d76b6e..dcdac6b32d6d 100644
--- a/configs/pinephone-pro-rk3399_defconfig
+++ b/configs/pinephone-pro-rk3399_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
index 1ff4e15c8c10..f281df6c1b12 100644
--- a/configs/roc-pc-mezzanine-rk3399_defconfig
+++ b/configs/roc-pc-mezzanine-rk3399_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 5d6e6b17091f..0d4a03db9e65 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
index 6c69e8bdcb92..2024defb2bf0 100644
--- a/configs/rock-4c-plus-rk3399_defconfig
+++ b/configs/rock-4c-plus-rk3399_defconfig
@@ -34,7 +34,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_MMC=y
diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
index e5ed81022bd6..9b2303fdf792 100644
--- a/configs/rock-4se-rk3399_defconfig
+++ b/configs/rock-4se-rk3399_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_MMC=y
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index 2801becedb4b..6cf445dd6338 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
index 72d37bff9e9a..4a9d1c531c10 100644
--- a/configs/rock-pi-4c-rk3399_defconfig
+++ b/configs/rock-pi-4c-rk3399_defconfig
@@ -34,7 +34,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_DFU_MMC=y
diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
index 6889cdcbf7d8..234d0c9ab0f5 100644
--- a/configs/rock-pi-n10-rk3399pro_defconfig
+++ b/configs/rock-pi-n10-rk3399pro_defconfig
@@ -31,7 +31,7 @@ CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
index 7a4a3df85b1b..3b5ab7dc5781 100644
--- a/configs/rock960-rk3399_defconfig
+++ b/configs/rock960-rk3399_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index 368ef7c4b5db..6c829089fd91 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -38,7 +38,7 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_BOOTSTAGE=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
-- 
2.43.2

