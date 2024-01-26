Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C33C47DDF
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 12:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD09687C51;
	Fri, 26 Jan 2024 13:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="3eGTlb7+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21B3186784; Fri, 26 Jan 2024 10:26:21 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 264EC879A2
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 10:26:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piotr.wojtaszczyk@timesys.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40eb2f392f0so2173805e9.1
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 01:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1706261178; x=1706865978;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1eLGsOTTLsYbJKwmkTuJYL1GGe/9k/bGvpbbeMKKS3g=;
 b=3eGTlb7+F/vtV7xuch0+a0CBh0Axabt0J7cmpnCPmdqrqoId/aGQrrudkYefhadq8o
 MgLuw7TgGTpZ4uu2gj/x6XQ5VWWNnnpge0JBWmEnVVipTyvzMsZaEDxt1Vbwwi7StxMK
 X1p4YPo7VMsqKG3WRKvUWm+Ck7HfgXl1WK/c6ZKBMuMdVQ6ywJpdcolb6ho5Hev42kF7
 7EC2pFC28I41bc1+b6ulc+QIWKy8Agjkwm3OUy2o3jSkxg8qC6mobijmWPWYKgpUhT9W
 hGjc+6fXhQyDLjdZf+kY6xJZBoyc04ZIkwyTPK8ICVV3amd73s99NYvOzZJoZZq+nObe
 FoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706261178; x=1706865978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1eLGsOTTLsYbJKwmkTuJYL1GGe/9k/bGvpbbeMKKS3g=;
 b=O4WYgiRYFie5sIwOn5tKtgU/js1HFMf2KRyN2SW2VJFv8r1u//YPQRapWMDhjs17yi
 ctvLhfbyZ2+CyJm1ATg7cOVk4OeI4mkkpoZuUZVgRzsgJ+rD9lqd+/XAvIezL9XPXnNy
 AlQ5YnGxv+qsGo2HxLNtKxLAMF8/IJKXnC56ylynumyOqWM08mOD8kiqC3eWV+g0sRSZ
 bV3P0V0Iszv8mjlKN8ZtlxyF5xc/kKN+zWhTAoNOKpYBj/3DAwcuLrEPNnuvoq5JJcd8
 4QG77mOMnM9CNnKngGxZRvSRyxDG+e+a/xUfMMltCamK4W4VeR56lc9d/5zFSitjasLj
 +eOQ==
X-Gm-Message-State: AOJu0YwxMRUMI7WR1huMTXvcnhJmqXdxK+ySxORo8t0wLed1IZhVKvDy
 6quZfZWLZoFJpJpP6HA4k8altjmfN2bVGkgQD+Emm0h6UVUk9kW3A4t4EHApFq9wTaoE2EVqXVL
 vy9s=
X-Google-Smtp-Source: AGHT+IF3HPakt07EatQ9CWj3qgwcifnuKEzq8eJMfuOVj7j3IY84eYU6gUafZibPh1v/4U0cqNlf8Q==
X-Received: by 2002:a05:600c:3798:b0:40e:b21a:7aa0 with SMTP id
 o24-20020a05600c379800b0040eb21a7aa0mr674624wmr.172.1706261178409; 
 Fri, 26 Jan 2024 01:26:18 -0800 (PST)
Received: from localhost.localdomain ([91.216.213.152])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a1709064f1800b00a349a5f9f77sm416208eju.47.2024.01.26.01.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 01:26:18 -0800 (PST)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: u-boot@lists.denx.de
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>
Subject: [PATCH 5/5] usb: lpc32xx: add DM_USB support
Date: Fri, 26 Jan 2024 10:25:32 +0100
Message-Id: <20240126092533.20709-5-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240126092533.20709-1-piotr.wojtaszczyk@timesys.com>
References: <20240126092533.20709-1-piotr.wojtaszczyk@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jan 2024 13:24:57 +0100
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

The legacy USB driver is modified into UCLASS_PHY which works with
drivers/usb/host/ohci-generic.c
This brings back USB functionality for LPC32xx.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---

 arch/arm/dts/lpc3250-ea3250-u-boot.dtsi |  9 +++
 arch/arm/dts/lpc32xx-u-boot.dtsi        |  4 ++
 configs/ea-lpc3250devkitv2_defconfig    |  5 ++
 drivers/usb/host/Kconfig                | 13 ++--
 drivers/usb/host/ohci-lpc32xx.c         | 79 ++++++++++++++-----------
 5 files changed, 71 insertions(+), 39 deletions(-)

diff --git a/arch/arm/dts/lpc3250-ea3250-u-boot.dtsi b/arch/arm/dts/lpc3250-ea3250-u-boot.dtsi
index 0c82e512c6..5c15302bf7 100644
--- a/arch/arm/dts/lpc3250-ea3250-u-boot.dtsi
+++ b/arch/arm/dts/lpc3250-ea3250-u-boot.dtsi
@@ -13,3 +13,12 @@
 &uart5 {
 	compatible = "nxp,lpc3220-uart", "ns16550a";
 };
+
+&isp1301 {
+	#phy-cells = <0>;
+};
+
+&ohci {
+	phys = <&isp1301>;
+	phy-names = "usb";
+};
diff --git a/arch/arm/dts/lpc32xx-u-boot.dtsi b/arch/arm/dts/lpc32xx-u-boot.dtsi
index 1df71d16a3..d950192eb3 100644
--- a/arch/arm/dts/lpc32xx-u-boot.dtsi
+++ b/arch/arm/dts/lpc32xx-u-boot.dtsi
@@ -6,6 +6,10 @@
 
 #include <config.h>
 
+&ohci {
+	compatible = "generic-ohci";
+};
+
 #ifdef CONFIG_SPL
 / {
 	binman: binman {
diff --git a/configs/ea-lpc3250devkitv2_defconfig b/configs/ea-lpc3250devkitv2_defconfig
index af9fc5f2f5..73108835c9 100644
--- a/configs/ea-lpc3250devkitv2_defconfig
+++ b/configs/ea-lpc3250devkitv2_defconfig
@@ -24,6 +24,7 @@ CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_SYS_PROMPT="EA-LPC3250v2=> "
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_USB=y
 CONFIG_OF_CONTROL=y
 # CONFIG_NET is not set
 CONFIG_LPC32XX_GPIO=y
@@ -32,4 +33,8 @@ CONFIG_SYS_I2C_LPC32XX=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_CONS_INDEX=5
 CONFIG_SYS_NS16550=y
+CONFIG_USB=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_OHCI_LPC32XX=y
 CONFIG_PANIC_HANG=y
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 0dd5736433..b3a2c1c14e 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -363,6 +363,13 @@ config USB_OHCI_DA8XX
 	help
 	  Enable support for the da850 USB controller.
 
+config USB_OHCI_LPC32XX
+	bool "Support for LPC32xx OHCI USB"
+	depends on ARCH_LPC32XX && DM_I2C && USB_OHCI_GENERIC
+	select USB_OHCI_NEW
+	help
+	  Enable support for the LPC32xx USB controller with ISP1301/STOTG04 phy.
+
 config USB_OHCI_NPCM
 	bool "Support for Nuvoton NPCM on-chip OHCI USB controller"
 	depends on ARCH_NPCM
@@ -447,12 +454,6 @@ config USB_ATMEL_CLK_SEL_UPLL
 
 endchoice
 
-config USB_OHCI_LPC32XX
-	bool "LPC32xx USB OHCI support"
-	depends on ARCH_LPC32XX
-	select SYS_USB_OHCI_CPU_INIT
-	select USB_OHCI_NEW
-
 config USB_MAX_CONTROLLER_COUNT
 	int "Maximum number of USB host controllers"
 	depends on USB_EHCI_FSL || USB_XHCI_FSL || \
diff --git a/drivers/usb/host/ohci-lpc32xx.c b/drivers/usb/host/ohci-lpc32xx.c
index a04b2961b9..7163bef71a 100644
--- a/drivers/usb/host/ohci-lpc32xx.c
+++ b/drivers/usb/host/ohci-lpc32xx.c
@@ -5,6 +5,7 @@
  * @Descr: USB driver - Embedded Artists LPC3250 OEM Board support functions
  *
  * Copyright (c) 2015 Tyco Fire Protection Products.
+ * Copyright 2024 Timesys <piotr.wojtaszczyk@timesys.com>
  */
 
 #include <common.h>
@@ -19,6 +20,7 @@
 #include <asm/arch/i2c.h>
 #include <usb.h>
 #include <i2c.h>
+#include <generic-phy.h>
 
 /* OTG I2C controller module register structures */
 struct otgi2c_regs {
@@ -69,8 +71,6 @@ struct otg_regs {
 #define OTG1_DM_PULLDOWN		(1 << 3)
 #define OTG1_VBUS_DRV			(1 << 5)
 
-#define ISP1301_I2C_ADDR		CFG_USB_ISP1301_I2C_ADDR
-
 #define ISP1301_I2C_MODE_CONTROL_1_SET		0x04
 #define ISP1301_I2C_MODE_CONTROL_1_CLR		0x05
 #define ISP1301_I2C_MODE_CONTROL_2_SET		0x12
@@ -86,19 +86,11 @@ static struct clk_pm_regs *clk_pwr = (struct clk_pm_regs *)CLK_PM_BASE;
 
 static int isp1301_set_value(struct udevice *dev, int reg, u8 value)
 {
-#if !CONFIG_IS_ENABLED(DM_I2C)
-	return i2c_write(ISP1301_I2C_ADDR, reg, 1, &value, 1);
-#else
 	return dm_i2c_write(dev, reg, &value, 1);
-#endif
 }
 
 static void isp1301_configure(struct udevice *dev)
 {
-#if !CONFIG_IS_ENABLED(DM_I2C)
-	i2c_set_bus_num(I2C_2);
-#endif
-
 	/*
 	 * LPC32XX only supports DAT_SE0 USB mode
 	 * This sequence is important
@@ -155,18 +147,10 @@ static int usbpll_setup(void)
 	return 0;
 }
 
-int usb_cpu_init(void)
+static int isp1301_phy_init(struct phy *usb_phy)
 {
 	u32 ret;
-	struct udevice *dev = NULL;
-
-#if CONFIG_IS_ENABLED(DM_I2C)
-	ret = i2c_get_chip_for_busnum(I2C_2, ISP1301_I2C_ADDR, 1, &dev);
-	if (ret) {
-		debug("%s: No bus %d\n", __func__, I2C_2);
-		return ret;
-	}
-#endif
+	struct udevice *dev = usb_phy->dev;
 
 	/*
 	 * USB pins routing setup is done by "lpc32xx_usb_init()" and should
@@ -211,21 +195,13 @@ int usb_cpu_init(void)
 	return 0;
 }
 
-int usb_cpu_stop(void)
+int isp1301_phy_exit(struct phy *usb_phy)
 {
-	struct udevice *dev = NULL;
+	struct udevice *dev = usb_phy->dev;
 	int ret = 0;
 
-#if CONFIG_IS_ENABLED(DM_I2C)
-	ret = i2c_get_chip_for_busnum(I2C_2, ISP1301_I2C_ADDR, 1, &dev);
-	if (ret) {
-		debug("%s: No bus %d\n", __func__, I2C_2);
-		return ret;
-	}
-#endif
-
 	/* vbus off */
-	isp1301_set_value(dev, ISP1301_I2C_OTG_CONTROL_1_SET, OTG1_VBUS_DRV);
+	isp1301_set_value(dev, ISP1301_I2C_OTG_CONTROL_1_CLR, OTG1_VBUS_DRV);
 
 	clrbits_le32(&otg->otg_sts_ctrl, OTG_HOST_EN);
 
@@ -234,7 +210,44 @@ int usb_cpu_stop(void)
 	return ret;
 }
 
-int usb_cpu_init_fail(void)
+static int isp1301_phy_set_on(struct phy *usb_phy)
+{
+	struct udevice *dev = usb_phy->dev;
+	int ret;
+	ret = isp1301_set_value(dev, ISP1301_I2C_OTG_CONTROL_1_SET, OTG1_VBUS_DRV);
+	mdelay(10); /* ramp up delay */
+	return ret;
+}
+
+static int isp1301_phy_set_off(struct phy *usb_phy)
+{
+	struct udevice *dev = usb_phy->dev;
+	int ret;
+	ret = isp1301_set_value(dev, ISP1301_I2C_OTG_CONTROL_1_CLR, OTG1_VBUS_DRV);
+	return ret;
+}
+
+int isp1301_probe(struct udevice *dev)
 {
-	return usb_cpu_stop();
+	return 0;
 }
+
+static const struct udevice_id isp1301_usb_phy_of_match[] = {
+	{.compatible = "nxp,isp1301" },
+	{},
+};
+
+struct phy_ops isp1301_usb_phy_ops = {
+	.init = isp1301_phy_init,
+	.power_on = isp1301_phy_set_on,
+	.power_off = isp1301_phy_set_off,
+	.exit = isp1301_phy_exit,
+};
+
+U_BOOT_DRIVER(nxp_isp1301_usb_phy) = {
+	.name = "nxp_isp1301_usb_phy",
+	.id = UCLASS_PHY,
+	.of_match = isp1301_usb_phy_of_match,
+	.probe = isp1301_probe,
+	.ops = &isp1301_usb_phy_ops,
+};
-- 
2.25.1

