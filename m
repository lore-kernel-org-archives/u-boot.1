Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7ABCF3943
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A6428919D;
	Thu, 19 Sep 2024 16:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aQRF7hEI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7692389139; Thu, 19 Sep 2024 16:02:50 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 714E489139
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5e1c49f9b9aso354140eaf.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726754566; x=1727359366; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GFXZhINB5Fcg6IbCA/MnkzAXPDfBKWoPLwwvKeFfGo=;
 b=aQRF7hEInTSZ1iX1mvh1mHmAEwsg10BSUGzCwli28HjOgcqqz0x9VfnrNGehj/2jel
 ecp2A35926ZCVW2w+bgtaCouohTCsiZgtwKilFzek8BJnAfQ3Ou8fsvUfv+RSwfAWjh9
 R4WXRKcHvgATPII8xX5iCVR9C/zc8EFnYOpC3qRZZGcOu0hsvgL0/41hKW5GeTbOmEuA
 sCJh81bZWdYNkRVRDNVac/ZFEd8DiknGB6vvca6Tu1U8zoYAaHjiOgdhZQtXYQRWNhwS
 pt6NkAkIePb+4nwn67f8DZcjRF0LdqjJnFKnYtlsecbJPH8qatx/lvF+01no0u9NolJj
 DdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726754566; x=1727359366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9GFXZhINB5Fcg6IbCA/MnkzAXPDfBKWoPLwwvKeFfGo=;
 b=JjAz8aEujcx/SaipdumAQzCnj3hu0u77X/O//5xVkGQL+75GASfLhUFvb/JVpdUKPr
 9zCmirwn5Asl/iSsD/72RwG2eJQGOi+NcmfXM6OD6+4cy3l9KnyMVkhcSP66eT6AVrO1
 P86Aq7ApgVGUflJ5nokSKe8BNBG4Pe/BFY+PTaNIIrlpgippwF5VuarwKJKQc/dlNHWI
 ySvmIj8r4Q6woBswFpmjbhw4ORUyq5X23eCzUgzCg16OVOIOJrzWDrhmL/TuphoOTe2r
 Hp9T4t15WjQ09Cz4ea9EqbjpuOcDskvJjBWdoAEfni/fMqYBvhX1NZPavuUSwjIzVgc4
 xbjA==
X-Gm-Message-State: AOJu0Yw4ZzLsJFrghIZ2zddgLZ1QikuOSkvsysJ/9VhDiwyNtP5K4kFJ
 aLnl1zSCKCQcAOCcxCE1VbrK+b60Ug23ACqnyc4ct8zdi+Du/I7/cJ0uxE0K
X-Google-Smtp-Source: AGHT+IEB9+PiBNmHNGZ+rJNBKajYjBDEy4diSuiGSjfwzy7/+V4miqjOGN807l2lP+e1NB8Y7H2UMQ==
X-Received: by 2002:a05:6820:1c96:b0:5e1:eba9:8ff4 with SMTP id
 006d021491bc7-5e20c1ed0c1mr11676979eaf.2.1726754565812; 
 Thu, 19 Sep 2024 07:02:45 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5e3b0d6ae98sm1941649eaf.5.2024.09.19.07.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 07:02:45 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: jonas@kwiboo.se, trini@konsulko.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, dsimic@manjaro.org,
 quentin.schulz@cherry.de, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 1/4] board: rockchip: Convert Anbernic RGxx3 to OF_UPSTREAM
Date: Thu, 19 Sep 2024 09:00:19 -0500
Message-Id: <20240919140022.511067-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919140022.511067-1-macroalpha82@gmail.com>
References: <20240919140022.511067-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Refactor the board detection logic (again) to make it compatible with
the upstream device-trees, and switch to OF_UPSTREAM.

Now the device boots with the device-tree for the 353P, and then
loads the correct device tree (of 10) in the later stages of SPL.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../dts/rk3566-anbernic-rg353p-u-boot.dtsi    |  34 +++
 .../arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi |  52 -----
 arch/arm/dts/rk3566-anbernic-rgxx3.dts        |  28 ---
 board/anbernic/rgxx3_rk3566/MAINTAINERS       |   4 +-
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c    | 214 +++++++++++++-----
 configs/anbernic-rgxx3-rk3566_defconfig       |  10 +-
 6 files changed, 195 insertions(+), 147 deletions(-)
 create mode 100644 arch/arm/dts/rk3566-anbernic-rg353p-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
 delete mode 100644 arch/arm/dts/rk3566-anbernic-rgxx3.dts

diff --git a/arch/arm/dts/rk3566-anbernic-rg353p-u-boot.dtsi b/arch/arm/dts/rk3566-anbernic-rg353p-u-boot.dtsi
new file mode 100644
index 00000000000..fa3fbe6c810
--- /dev/null
+++ b/arch/arm/dts/rk3566-anbernic-rg353p-u-boot.dtsi
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk356x-u-boot.dtsi"
+
+/ {
+	chosen {
+		u-boot,spl-boot-order = &sdmmc0, &sdhci;
+	};
+
+	/*
+	 * Adding fixed regulator to work around driver regulator
+	 * requirements. Note that the correct regulator is on by
+	 * default at boot and that saradc regulator gets corrected
+	 * when proper device-tree is loaded.
+	 */
+	vcc_1v8_dummy: vcc-1v8-dummy {
+		bootph-pre-ram;
+		bootph-some-ram;
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-name = "vcc_1v8_dummy";
+		status = "okay";
+	};
+};
+
+&saradc {
+	bootph-pre-ram;
+	bootph-some-ram;
+	vref-supply = <&vcc_1v8_dummy>;
+	status = "okay";
+};
diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
deleted file mode 100644
index c7e849816a6..00000000000
--- a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
+++ /dev/null
@@ -1,52 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-
-#include "rk356x-u-boot.dtsi"
-
-/ {
-	chosen {
-		u-boot,spl-boot-order = &sdmmc0, &sdhci;
-	};
-};
-
-&dsi_dphy0 {
-	status = "okay";
-};
-
-&dsi0 {
-	status = "okay";
-};
-
-&i2c2 {
-	pinctrl-0 = <&i2c2m1_xfer>;
-	pinctrl-names = "default";
-	status = "okay";
-};
-
-&pmucru {
-	assigned-clocks = <&pmucru SCLK_32K_IOE>;
-	assigned-clock-parents = <&pmucru CLK_RTC_32K>;
-};
-
-/*
- * We don't need the clocks, but if they are present they may cause
- * probing to fail so we remove them for U-Boot.
- */
-&rk817 {
-	/delete-property/ assigned-clocks;
-	/delete-property/ assigned-clock-parents;
-	/delete-property/ clocks;
-	/delete-property/ clock-names;
-};
-
-&sdhci {
-	pinctrl-0 = <&emmc_bus8>, <&emmc_clk>, <&emmc_cmd>,
-		    <&emmc_datastrobe>, <&emmc_rstnout>;
-	pinctrl-names = "default";
-	bus-width = <8>;
-	max-frequency = <200000000>;
-	mmc-hs200-1_8v;
-	non-removable;
-	vmmc-supply = <&vcc_3v3>;
-	vqmmc-supply = <&vcc_1v8>;
-	status = "okay";
-};
diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3.dts b/arch/arm/dts/rk3566-anbernic-rgxx3.dts
deleted file mode 100644
index c393c8d07af..00000000000
--- a/arch/arm/dts/rk3566-anbernic-rgxx3.dts
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-
-/dts-v1/;
-
-#include "rk3566-anbernic-rgxx3.dtsi"
-
-/ {
-
-/*
- * Note this is a pseudo-model that doesn't exist in mainline Linux.
- * This model is used for all RGXX3 devices and the board.c file will
- * set the correct dtb name for loading mainline Linux automatically.
- */
-	model = "RGXX3";
-	compatible = "anbernic,rg-arc-d", "anbernic,rg-arc-s",
-		     "anbernic,rg353m", "anbernic,rg353p",
-		     "anbernic,rg353ps", "anbernic,rg353v",
-		     "anbernic,rg353vs", "anbernic,rg503",
-		     "powkiddy,rgb10max3", "powkiddy,rgb30",
-		     "powkiddy,rk2023", "rockchip,rk3566";
-};
-
-&cru {
-	assigned-clocks = <&pmucru CLK_RTC_32K>, <&cru PLL_GPLL>,
-			  <&pmucru PLL_PPLL>, <&cru PLL_VPLL>;
-	assigned-clock-rates = <32768>, <1200000000>,
-			       <200000000>, <241500000>;
-};
diff --git a/board/anbernic/rgxx3_rk3566/MAINTAINERS b/board/anbernic/rgxx3_rk3566/MAINTAINERS
index 7970e5a4aad..75a1e8076ca 100644
--- a/board/anbernic/rgxx3_rk3566/MAINTAINERS
+++ b/board/anbernic/rgxx3_rk3566/MAINTAINERS
@@ -4,6 +4,4 @@ S:	Maintained
 F:	board/anbernic/rgxx3_rk3566
 F:	include/configs/anbernic-rgxx3-rk3566.h
 F:	configs/anbernic-rgxx3-rk3566_defconfig
-F:	arch/arm/dts/rk3566-anbernic-rgxx3.dts
-F:	arch/arm/dts/rk3566-anbernic-rgxx3.dtsi
-F:	arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
+F:	arch/arm/dts/rk3566-anbernic-rg353p-u-boot.dtsi
diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
index 5c57b902d14..224019f9ba3 100644
--- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
+++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
@@ -11,6 +11,7 @@
 #include <dm/lists.h>
 #include <env.h>
 #include <fdt_support.h>
+#include <i2c.h>
 #include <linux/delay.h>
 #include <mipi_dsi.h>
 #include <mmc.h>
@@ -19,6 +20,8 @@
 #include <stdlib.h>
 #include <video_bridge.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 #define GPIO0_BASE		0xfdd60000
 #define GPIO4_BASE		0xfe770000
 #define GPIO_SWPORT_DR_L	0x0000
@@ -40,10 +43,11 @@ struct rg3xx_model {
 	const char *board_name;
 	const char *fdtfile;
 	const bool detect_panel;
+	const bool uart_con;
 };
 
 enum rgxx3_device_id {
-	RG353M,
+	RG353M = 1,
 	RG353P,
 	RG353V,
 	RG503,
@@ -61,45 +65,51 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 	[RG353M] = {
 		.adc_value = 517, /* Observed average from device */
 		.board = "rk3566-anbernic-rg353m",
-		.board_name = "RG353M",
+		.board_name = "Anbernic RG353M",
 		/* Device is identical to RG353P. */
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg353p.dtb",
 		.detect_panel = 1,
+		.uart_con = 1,
 	},
 	[RG353P] = {
 		.adc_value = 860, /* Documented value of 860 */
 		.board = "rk3566-anbernic-rg353p",
-		.board_name = "RG353P",
+		.board_name = "Anbernic RG353P",
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg353p.dtb",
 		.detect_panel = 1,
+		.uart_con = 1,
 	},
 	[RG353V] = {
 		.adc_value = 695, /* Observed average from device */
 		.board = "rk3566-anbernic-rg353v",
-		.board_name = "RG353V",
+		.board_name = "Anbernic RG353V",
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg353v.dtb",
 		.detect_panel = 1,
+		.uart_con = 1,
 	},
 	[RG503] = {
 		.adc_value = 1023, /* Observed average from device */
 		.board = "rk3566-anbernic-rg503",
-		.board_name = "RG503",
+		.board_name = "Anbernic RG503",
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg503.dtb",
 		.detect_panel = 0,
+		.uart_con = 1,
 	},
 	[RGB30] = {
 		.adc_value = 383, /* Gathered from second hand information */
 		.board = "rk3566-powkiddy-rgb30",
-		.board_name = "RGB30",
+		.board_name = "Powkiddy RGB30",
 		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb30.dtb",
 		.detect_panel = 0,
+		.uart_con = 0,
 	},
 	[RK2023] = {
 		.adc_value = 635, /* Observed average from device */
 		.board = "rk3566-powkiddy-rk2023",
-		.board_name = "RK2023",
+		.board_name = "Powkiddy RK2023",
 		.fdtfile = DTB_DIR "rk3566-powkiddy-rk2023.dtb",
 		.detect_panel = 0,
+		.uart_con = 0,
 	},
 	[RGARCD] = {
 		.adc_value = 183, /* Observed average from device */
@@ -107,6 +117,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.board_name = "Anbernic RG ARC-D",
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-d.dtb",
 		.detect_panel = 0,
+		.uart_con = 1,
 	},
 	[RGB10MAX3] = {
 		.adc_value = 765, /* Observed average from device */
@@ -114,21 +125,24 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.board_name = "Powkiddy RGB10MAX3",
 		.fdtfile = DTB_DIR "rk3566-powkiddy-rgb10max3.dtb",
 		.detect_panel = 0,
+		.uart_con = 0,
 	},
 	/* Devices with duplicate ADC value */
 	[RG353PS] = {
 		.adc_value = 860, /* Observed average from device */
 		.board = "rk3566-anbernic-rg353ps",
-		.board_name = "RG353PS",
+		.board_name = "Anbernic RG353PS",
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg353ps.dtb",
 		.detect_panel = 1,
+		.uart_con = 1,
 	},
 	[RG353VS] = {
 		.adc_value = 695, /* Gathered from second hand information */
 		.board = "rk3566-anbernic-rg353vs",
-		.board_name = "RG353VS",
+		.board_name = "Anbernic RG353VS",
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg353vs.dtb",
 		.detect_panel = 1,
+		.uart_con = 1,
 	},
 	[RGARCS] = {
 		.adc_value = 183, /* Observed average from device */
@@ -136,6 +150,7 @@ static const struct rg3xx_model rg3xx_model_details[] = {
 		.board_name = "Anbernic RG ARC-S",
 		.fdtfile = DTB_DIR "rk3566-anbernic-rg-arc-s.dtb",
 		.detect_panel = 0,
+		.uart_con = 1,
 	},
 };
 
@@ -164,7 +179,7 @@ static const struct rg353_panel rg353_panel_details[] = {
 void spl_board_init(void)
 {
 	/* Set GPIO0_C5, GPIO0_C6, and GPIO0_C7 to output. */
-	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | \
+	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) |
 	       (GPIO_C7 | GPIO_C6 | GPIO_C5),
 	       (GPIO0_BASE + GPIO_SWPORT_DDR_H));
 	/* Set GPIO0_C5 and GPIO_C6 to 0 and GPIO0_C7 to 1. */
@@ -174,16 +189,22 @@ void spl_board_init(void)
 
 /*
  * Buzz the buzzer so the user knows something is going on. Make it
- * optional in case PWM is disabled.
+ * optional in case PWM is disabled or if CONFIG_DM_PWM is not
+ * enabled.
  */
 void __maybe_unused startup_buzz(void)
 {
 	struct udevice *dev;
 	int err;
 
-	err = uclass_get_device(UCLASS_PWM, 0, &dev);
+	if (!IS_ENABLED(CONFIG_DM_PWM))
+		return;
+
+	/* Probe the PWM controller. */
+	err = uclass_get_device_by_name(UCLASS_PWM,
+					"pwm@fe6e0010", &dev);
 	if (err)
-		printf("pwm not found\n");
+		return;
 
 	pwm_set_enable(dev, 0, 1);
 	mdelay(200);
@@ -245,6 +266,13 @@ U_BOOT_DRIVER(anbernic_rg353_panel) = {
 	.plat_auto	= sizeof(struct mipi_dsi_panel_plat),
 };
 
+/*
+ * The Anbernic 353 series shipped with 2 distinct displays requiring
+ * 2 distinct drivers, with no way for a user to know which panel is
+ * which. This function queries the DSI panel for the panel ID to
+ * determine which panel is present so the device-tree can be corrected
+ * automatically.
+ */
 int rgxx3_detect_display(void)
 {
 	struct udevice *dev;
@@ -333,17 +361,10 @@ int rgxx3_detect_display(void)
 	return 0;
 }
 
-/* Detect which Anbernic RGXX3 device we are using so as to load the
- * correct devicetree for Linux. Set an environment variable once
- * found. The detection depends on the value of ADC channel 1, the
- * presence of an eMMC on mmc0, and querying the DSI panel.
- */
-int rgxx3_detect_device(void)
+int rgxx3_read_board_id(void)
 {
 	u32 adc_info;
-	int ret, i;
-	int board_id = -ENXIO;
-	struct mmc *mmc;
+	int ret;
 
 	ret = adc_channel_single_shot("saradc@fe720000", 1, &adc_info);
 	if (ret) {
@@ -357,16 +378,32 @@ int rgxx3_detect_device(void)
 	 * design calls for no more than a 1% variance on the
 	 * resistor, so assume a +- value of 15 should be enough.
 	 */
-	for (i = 0; i < ARRAY_SIZE(rg3xx_model_details); i++) {
+	for (int i = 0; i < ARRAY_SIZE(rg3xx_model_details); i++) {
 		u32 adc_min = rg3xx_model_details[i].adc_value - 15;
 		u32 adc_max = rg3xx_model_details[i].adc_value + 15;
 
-		if (adc_min < adc_info && adc_max > adc_info) {
-			board_id = i;
-			break;
-		}
+		if (adc_min < adc_info && adc_max > adc_info)
+			return i;
 	}
 
+	return -ENODEV;
+}
+
+/* Detect which Anbernic RGXX3 device we are using so as to load the
+ * correct devicetree for Linux. Set an environment variable once
+ * found. The detection depends on the value of ADC channel 1 and the
+ * presence of an eMMC on mmc0.
+ */
+int rgxx3_detect_device(void)
+{
+	int ret;
+	int board_id;
+	struct mmc *mmc;
+
+	board_id = rgxx3_read_board_id();
+	if (board_id < 0)
+		return board_id;
+
 	/*
 	 * Try to access the eMMC on an RG353V, RG353P, or RG Arc D.
 	 * If it's missing, it's an RG353VS, RG353PS, or RG Arc S.
@@ -387,67 +424,87 @@ int rgxx3_detect_device(void)
 		}
 	}
 
-	if (board_id < 0)
-		return board_id;
+	return board_id;
+}
 
-	env_set("board", rg3xx_model_details[board_id].board);
-	env_set("board_name",
-		rg3xx_model_details[board_id].board_name);
-	env_set("fdtfile", rg3xx_model_details[board_id].fdtfile);
+/*
+ * Check the loaded device tree to set the correct gd->board_type.
+ * Disable the console if the board doesn't support a console.
+ */
+int set_gd_value(void)
+{
+	const char *model;
 
-	/* Skip panel detection for when it is not needed. */
-	if (!rg3xx_model_details[board_id].detect_panel)
-		return 0;
+	model = fdt_getprop(gd->fdt_blob, 0, "model", NULL);
 
-	/* Warn but don't fail for errors in auto-detection of the panel. */
-	ret = rgxx3_detect_display();
-	if (ret)
-		printf("Failed to detect panel type\n");
+	for (int i = 0; i < ARRAY_SIZE(rg3xx_model_details); i++) {
+		if (strcmp(rg3xx_model_details[i].board_name, model) == 0) {
+			gd->board_type = i;
+			if (!rg3xx_model_details[i].uart_con)
+				gd->flags |= GD_FLG_SILENT |
+					     GD_FLG_DISABLE_CONSOLE;
+			return 0;
+		}
+	}
 
-	return 0;
+	return -ENODEV;
 }
 
 int rk_board_late_init(void)
 {
 	int ret;
 
-	ret = rgxx3_detect_device();
+	ret = set_gd_value();
 	if (ret) {
-		printf("Unable to detect device type: %d\n", ret);
-		return ret;
+		printf("Unable to auto-detect device\n");
+		goto end;
 	}
 
+	/*
+	 * Change the model number on the RG353M since it uses the same
+	 * tree as the RG353P.
+	 */
+	if (gd->board_type == RG353P) {
+		ret = rgxx3_read_board_id();
+		if (ret > 0)
+			gd->board_type = ret;
+	}
+
+	env_set("board", rg3xx_model_details[gd->board_type].board);
+	env_set("board_name",
+		rg3xx_model_details[gd->board_type].board_name);
+	env_set("fdtfile", rg3xx_model_details[gd->board_type].fdtfile);
+
+	/*
+	 * Skip panel detection if not needed. Warn but don't fail for
+	 * errors in auto-detection of the panel.
+	 */
+	if (rg3xx_model_details[gd->board_type].detect_panel) {
+		ret = rgxx3_detect_display();
+		if (ret)
+			printf("Failed to detect panel type\n");
+	}
+
+end:
 	/* Turn off red LED and turn on orange LED. */
 	writel(GPIO_WRITEMASK(GPIO_C7 | GPIO_C6 | GPIO_C5) | GPIO_C6,
 	       (GPIO0_BASE + GPIO_SWPORT_DR_H));
 
-	if (IS_ENABLED(CONFIG_DM_PWM))
-		startup_buzz();
+	startup_buzz();
 
 	return 0;
 }
 
-int ft_board_setup(void *blob, struct bd_info *bd)
+int rgxx3_panel_fixup(void *blob)
 {
 	const struct rg353_panel *panel = NULL;
-	int node, ret, i;
+	int node, ret;
 	char *env;
 
-	/* No fixups necessary for the RG503 */
-	env = env_get("board_name");
-	if (env && (!strcmp(env, rg3xx_model_details[RG503].board_name)))
-		return 0;
-
-	/* Change the model name of the RG353M */
-	if (env && (!strcmp(env, rg3xx_model_details[RG353M].board_name)))
-		fdt_setprop(blob, 0, "model",
-			    rg3xx_model_details[RG353M].board_name,
-			    sizeof(rg3xx_model_details[RG353M].board_name));
-
 	env = env_get("panel");
 	if (!env) {
 		printf("Can't get panel env\n");
-		return 0;
+		return -EINVAL;
 	}
 
 	/*
@@ -469,7 +526,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 		return 0;
 
 	/* Panels don't match, search by first compatible value. */
-	for (i = 0; i < ARRAY_SIZE(rg353_panel_details); i++) {
+	for (int i = 0; i < ARRAY_SIZE(rg353_panel_details); i++) {
 		if (!strcmp(env, rg353_panel_details[i].panel_compat[0])) {
 			panel = &rg353_panel_details[i];
 			break;
@@ -489,3 +546,38 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 
 	return 0;
 }
+
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	int ret;
+
+	if (gd->board_type == RG353M)
+		fdt_setprop(blob, 0, "model",
+			    rg3xx_model_details[RG353M].board_name,
+			    sizeof(rg3xx_model_details[RG353M].board_name));
+
+	if (rg3xx_model_details[gd->board_type].detect_panel) {
+		ret = rgxx3_panel_fixup(blob);
+		if (ret)
+			printf("Unable to update panel compat\n");
+	}
+
+	return 0;
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	int ret;
+
+	if (gd->board_type == 0) {
+		ret = rgxx3_detect_device();
+		if (ret < 0)
+			return ret;
+		gd->board_type = ret;
+	}
+
+	if (strcmp(name, rg3xx_model_details[gd->board_type].fdtfile) == 0)
+		return 0;
+
+	return -ENXIO;
+}
diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index a03509bf467..f5e5470df8c 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -3,7 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SPL_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="rk3566-anbernic-rgxx3"
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-anbernic-rg353p"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
 CONFIG_SPL_SERIAL=y
@@ -19,8 +19,10 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_STDOUT_VIA_ALIAS=y
-CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-anbernic-rgxx3.dtb"
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-anbernic-rg353p.dtb"
+CONFIG_DISABLE_CONSOLE=y
 # CONFIG_CONSOLE_MUX is not set
+CONFIG_BOARD_TYPES=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_RNG_SEED=y
@@ -38,13 +40,14 @@ CONFIG_CMD_MMC=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-# CONFIG_OF_UPSTREAM is not set
+CONFIG_OF_LIST="rockchip/rk3566-anbernic-rg353p rockchip/rk3566-anbernic-rg353v rockchip/rk3566-anbernic-rg503 rockchip/rk3566-anbernic-rg-arc-d rockchip/rk3566-anbernic-rg353ps rockchip/rk3566-anbernic-rg353vs rockchip/rk3566-anbernic-rg-arc-s rockchip/rk3566-powkiddy-rgb30 rockchip/rk3566-powkiddy-rk2023 rockchip/rk3566-powkiddy-rgb10max3"
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 # CONFIG_NET is not set
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
+CONFIG_SPL_ADC=y
 CONFIG_SPL_CLK=y
 CONFIG_ARM_SMCCC_FEATURES=y
 CONFIG_SCMI_FIRMWARE=y
@@ -70,6 +73,7 @@ CONFIG_SPL_RAM=y
 # CONFIG_RAM_ROCKCHIP_DEBUG is not set
 # CONFIG_RNG_SMCCC_TRNG is not set
 CONFIG_BAUDRATE=1500000
+# CONFIG_REQUIRE_SERIAL_CONSOLE is not set
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
-- 
2.34.1

