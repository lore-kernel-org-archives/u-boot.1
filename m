Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A410D1112246
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 01:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E11A384020;
	Thu,  2 Apr 2026 03:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EwiRUyHz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B245984056; Thu,  2 Apr 2026 03:32:49 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3742680517
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 03:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-66b832bd439so48407a12.3
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 18:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775093567; x=1775698367; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2WNZqqkErTr85DZppPKsaFugJzxmknNbHYoC1x3jFEw=;
 b=EwiRUyHzEnFbK+s8uTsA/JHca6t/XcbinLuPll/QB0lHPqNNy2BmEYNeiy64QlBoq8
 60HG/lXHxBPNNOQ7XsOZLqBeEciDm9jI9l0Z8DWY5m5T5f1oSqSMtfnDjk5bjjg8MDNc
 67Ya2fRRSGAzLXu5hXH27+IMBkv9pezXzwqC7zwC+U/moUq5s33KqhWlknzjKWOoT4BC
 6isn6qTycwKnoFT5d9syB0AGgOLoM+PK+ZXIzA58KT/2v4LFE5Ze01z/odzgycWI9fxD
 N6PVroUvkVgDf+PA98NEATiqkBVvWhZj1TWBXBWYgD5tmmwSczIGmTQasGiquHh9uC/g
 WQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775093567; x=1775698367;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2WNZqqkErTr85DZppPKsaFugJzxmknNbHYoC1x3jFEw=;
 b=XwgK5a2txRn1LcsjfSmFE8r1kg7JznUOQInAgTzxeH6AMAUKRbfwuXWEaO57p3s88C
 K4nvfHwyORg3vGtsmIsaDZyRomDZa0OSW5GLGgj8JbaZ3IGGyCyaOtcOcx3fVUZFNEJq
 buVUM226uRYmdVt2HUNBpb079P87U4rkm+xEpbL8vfUk6PwsppSHssrxIk7d6p3boDDo
 FdEZMKoA5kytxVbul/cnprWK3F2hJAfBVghhwnvHr323SmHAdkZnSYEKMT5h1y9OQFk0
 9UhenQK0Pg0ug1/4UhTD4YnO3nlJB4I1Cb/hKWXQ5xUeKO/UPSTtZR2s81VX5gRoZIOV
 XiLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU2viD/Ne2SCWO3duTOsDe1PJsoY/IL5R8f2ZGhwNpZ7k4TA+1kv3m46lACXqk5oc+rEFlMZE=@lists.denx.de
X-Gm-Message-State: AOJu0YwG1NeyHDZ0JSSneV+w74CClGIZV9VI0nSb9mA/q/6zXpiwqQ+G
 pVh3gT3Dgxs+TaOGYq13gPAjKtuT9Qwp+ZuUq3Ki0NXsXwbzPw/v2bgZ
X-Gm-Gg: ATEYQzxNqAuyx8p/KA9jad/3c5WamY7aTI5eZqmXV5jnsUq1HC0covh+wbUvdd74lwr
 bKyd7Vzd4M3byAZqb4imyJD/Eu4XwVoKdp70tQFPcNLqqG4vLv6G0PPluH/8zydZFceAlW51idA
 w5X+YlV/8qCNSjL2KtAvDd7RjQEts5K89tg3ZieCAx9Gqs7gagcXMSycWeEdIscCxk9MgyIs1F/
 LuJ3JrzekjHYoerFJixrQW9pDzediqN5cy/UNno6F9x1Rkjo15fThsFuNoqmxL90gBCaj4q8lcA
 swEItddIHwzPS4d7Yoa4b+kYwdpQ1XuTILY50D4csfZ9yDJkOof0jxhEbAoV3m9LBFWdIiVcDXf
 T5/EhN2rUTkkozDkf4RQguiHvlBetL1nikJ9sbIYlQkznpFAX+nmulmZ/ElQ9pVEKsVI39m9ZnG
 Yr5WdVxUazFPUkH9754fbTyAR0nzZS1rmG5dy37VLYBo+5OxI0H+vjSluLGmxivg==
X-Received: by 2002:a05:6402:350f:b0:66b:eb29:4195 with SMTP id
 4fb4d7f45d1cf-66daffb12a6mr1344105a12.1.1775093566316; 
 Wed, 01 Apr 2026 18:32:46 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66e034bc112sm269190a12.25.2026.04.01.18.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 18:32:44 -0700 (PDT)
Message-ID: <b127c1c7-61e8-49fc-b10b-a1acd23644eb@gmail.com>
Date: Thu, 2 Apr 2026 03:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [RFC PATCH v1 2/2] usb: phy: remove rockchip_usb2_phy.c
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <1e443ab0-129b-42db-b224-253ba8a2f80f@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <1e443ab0-129b-42db-b224-253ba8a2f80f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Remove rockchip_usb2_phy.c and replace it by phy-rockchip-usb2.c
Adjust defconfigs. Enable CONFIG_DM_RESET where needed to compile
th phy driver. Move usbphy node to the DT root in order to be found
by the generic_phy_get_by_index() function. Remove a variable no
longer needed from an include file.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/dts/rk3066a-u-boot.dtsi    |  29 +++++++
 arch/arm/dts/rk3188-u-boot.dtsi     |  29 +++++++
 arch/arm/dts/rk3288-u-boot.dtsi     |  40 ++++++++++
 arch/arm/mach-rockchip/board.c      |  28 -------
 configs/chromebit_mickey_defconfig  |   2 +-
 configs/chromebook_jerry_defconfig  |   2 +-
 configs/chromebook_minnie_defconfig |   2 +-
 configs/chromebook_speedy_defconfig |   2 +-
 configs/evb-rk3288-rk808_defconfig  |   2 +-
 configs/firefly-rk3288_defconfig    |   4 +-
 configs/miqi-rk3288_defconfig       |   4 +-
 configs/mk808_defconfig             |   2 +-
 configs/phycore-rk3288_defconfig    |   3 +-
 configs/popmetal-rk3288_defconfig   |   3 +-
 configs/rock-pi-n8-rk3288_defconfig |   2 +-
 configs/rock2_defconfig             |   3 +-
 configs/rock_defconfig              |   3 +-
 configs/tinker-rk3288_defconfig     |   4 +-
 configs/tinker-s-rk3288_defconfig   |   4 +-
 configs/vyasa-rk3288_defconfig      |   2 +-
 drivers/usb/phy/Kconfig             |   3 -
 drivers/usb/phy/Makefile            |   1 -
 drivers/usb/phy/rockchip_usb2_phy.c | 113 ----------------------------
 include/usb/dwc2_udc.h              |   1 -
 24 files changed, 122 insertions(+), 166 deletions(-)
 delete mode 100644 drivers/usb/phy/rockchip_usb2_phy.c

diff --git a/arch/arm/dts/rk3066a-u-boot.dtsi b/arch/arm/dts/rk3066a-u-boot.dtsi
index d99db7853b59..994c0d44f3f5 100644
--- a/arch/arm/dts/rk3066a-u-boot.dtsi
+++ b/arch/arm/dts/rk3066a-u-boot.dtsi
@@ -7,3 +7,32 @@
 	status = "disabled";
 };

+&grf {
+	/delete-node/ usbphy;
+};
+
+/ {
+	usbphy: usbphy {
+		compatible = "rockchip,rk3066a-usb-phy";
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbphy0: usb-phy@17c {
+			reg = <0x17c>;
+			clocks = <&cru SCLK_OTGPHY0>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+		};
+
+		usbphy1: usb-phy@188 {
+			reg = <0x188>;
+			clocks = <&cru SCLK_OTGPHY1>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+		};
+	};
+};
+
diff --git a/arch/arm/dts/rk3188-u-boot.dtsi b/arch/arm/dts/rk3188-u-boot.dtsi
index 8f2849dda241..905ebaea7915 100644
--- a/arch/arm/dts/rk3188-u-boot.dtsi
+++ b/arch/arm/dts/rk3188-u-boot.dtsi
@@ -10,7 +10,36 @@
 	compatible = "rockchip,gpio-bank";
 };

+&grf {
+	/delete-node/ usbphy;
+};
+
 &pmu {
 	compatible = "rockchip,rk3188-pmu", "syscon", "simple-mfd";
 };

+/ {
+	usbphy: usbphy {
+		compatible = "rockchip,rk3188-usb-phy";
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbphy0: usb-phy@10c {
+			reg = <0x10c>;
+			clocks = <&cru SCLK_OTGPHY0>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+		};
+
+		usbphy1: usb-phy@11c {
+			reg = <0x11c>;
+			clocks = <&cru SCLK_OTGPHY1>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+		};
+	};
+};
+
diff --git a/arch/arm/dts/rk3288-u-boot.dtsi b/arch/arm/dts/rk3288-u-boot.dtsi
index bb0078588fe8..e61746b5b2a8 100644
--- a/arch/arm/dts/rk3288-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-u-boot.dtsi
@@ -68,6 +68,7 @@

 &grf {
 	bootph-all;
+	/delete-node/ usbphy;
 };

 &pmu {
@@ -105,3 +106,42 @@
 &xin24m {
 	bootph-all;
 };
+
+/ {
+	usbphy: usbphy {
+		compatible = "rockchip,rk3288-usb-phy";
+		rockchip,grf = <&grf>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbphy0: usb-phy@320 {
+			#phy-cells = <0>;
+			reg = <0x320>;
+			clocks = <&cru SCLK_OTGPHY0>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			resets = <&cru SRST_USBOTG_PHY>;
+			reset-names = "phy-reset";
+		};
+
+		usbphy1: usb-phy@334 {
+			#phy-cells = <0>;
+			reg = <0x334>;
+			clocks = <&cru SCLK_OTGPHY1>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			resets = <&cru SRST_USBHOST0_PHY>;
+			reset-names = "phy-reset";
+		};
+
+		usbphy2: usb-phy@348 {
+			#phy-cells = <0>;
+			reg = <0x348>;
+			clocks = <&cru SCLK_OTGPHY2>;
+			clock-names = "phyclk";
+			#clock-cells = <0>;
+			resets = <&cru SRST_USBHOST1_PHY>;
+			reset-names = "phy-reset";
+		};
+	};
+};
diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 2e6bb38b9235..1538f4fef081 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -269,34 +269,6 @@ int board_usb_init(int index, enum usb_init_type init)
 	}
 	otg_data.regs_otg = ofnode_get_addr(node);

-#ifdef CONFIG_ROCKCHIP_USB2_PHY
-	int ret;
-	u32 phandle, offset;
-	ofnode phy_node;
-
-	ret = ofnode_read_u32(node, "phys", &phandle);
-	if (ret)
-		return ret;
-
-	node = ofnode_get_by_phandle(phandle);
-	if (!ofnode_valid(node)) {
-		debug("Not found usb phy device\n");
-		return -ENODEV;
-	}
-
-	phy_node = ofnode_get_parent(node);
-	if (!ofnode_valid(node)) {
-		debug("Not found usb phy device\n");
-		return -ENODEV;
-	}
-
-	otg_data.phy_of_node = phy_node;
-	ret = ofnode_read_u32(node, "reg", &offset);
-	if (ret)
-		return ret;
-	otg_data.regs_phy =  offset +
-		(u32)syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
-#endif
 	return dwc2_udc_probe(&otg_data);
 }

diff --git a/configs/chromebit_mickey_defconfig b/configs/chromebit_mickey_defconfig
index 60ceae8f1531..b574f8bceebd 100644
--- a/configs/chromebit_mickey_defconfig
+++ b/configs/chromebit_mickey_defconfig
@@ -82,6 +82,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -102,7 +103,6 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
 CONFIG_CONSOLE_TRUETYPE=y
diff --git a/configs/chromebook_jerry_defconfig b/configs/chromebook_jerry_defconfig
index 5e89311affe3..9f0d4d94cbca 100644
--- a/configs/chromebook_jerry_defconfig
+++ b/configs/chromebook_jerry_defconfig
@@ -82,6 +82,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -106,7 +107,6 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
 CONFIG_CONSOLE_TRUETYPE=y
diff --git a/configs/chromebook_minnie_defconfig b/configs/chromebook_minnie_defconfig
index 6e0158fd4a9e..ae8c1d3fc9a1 100644
--- a/configs/chromebook_minnie_defconfig
+++ b/configs/chromebook_minnie_defconfig
@@ -83,6 +83,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -107,7 +108,6 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
 CONFIG_CONSOLE_TRUETYPE=y
diff --git a/configs/chromebook_speedy_defconfig b/configs/chromebook_speedy_defconfig
index 86f1399c0e3c..7b4258f18427 100644
--- a/configs/chromebook_speedy_defconfig
+++ b/configs/chromebook_speedy_defconfig
@@ -83,6 +83,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -107,7 +108,6 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
 CONFIG_CONSOLE_TRUETYPE=y
diff --git a/configs/evb-rk3288-rk808_defconfig b/configs/evb-rk3288-rk808_defconfig
index 2112e475ad31..5244c42b7b4e 100644
--- a/configs/evb-rk3288-rk808_defconfig
+++ b/configs/evb-rk3288-rk808_defconfig
@@ -71,6 +71,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -85,7 +86,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_VIDEO=y
diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index 54e3c41f3ccf..0999bf03d60a 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -62,11 +62,12 @@ CONFIG_MISC=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -82,7 +83,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
index 4cbd4b97172a..827f1ae159e1 100644
--- a/configs/miqi-rk3288_defconfig
+++ b/configs/miqi-rk3288_defconfig
@@ -59,11 +59,12 @@ CONFIG_MISC=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -79,7 +80,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
index b983128e1def..3b63e5f930bb 100644
--- a/configs/mk808_defconfig
+++ b/configs/mk808_defconfig
@@ -92,6 +92,7 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_SPL_MMC_UHS_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_DM_PMIC=y
 # CONFIG_SPL_PMIC_CHILDREN is not set
@@ -111,7 +112,6 @@ CONFIG_TPL_TIMER=y
 CONFIG_DESIGNWARE_APB_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
diff --git a/configs/phycore-rk3288_defconfig b/configs/phycore-rk3288_defconfig
index a374f90982e0..bafe49818637 100644
--- a/configs/phycore-rk3288_defconfig
+++ b/configs/phycore-rk3288_defconfig
@@ -9,6 +9,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-phycore-rdk"
+CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
@@ -68,6 +69,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -82,7 +84,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_SMSC95XX=y
diff --git a/configs/popmetal-rk3288_defconfig b/configs/popmetal-rk3288_defconfig
index 52d38f4108c3..a4d0bd705fdf 100644
--- a/configs/popmetal-rk3288_defconfig
+++ b/configs/popmetal-rk3288_defconfig
@@ -9,6 +9,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-popmetal"
+CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
@@ -64,6 +65,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -78,7 +80,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_SMSC95XX=y
diff --git a/configs/rock-pi-n8-rk3288_defconfig b/configs/rock-pi-n8-rk3288_defconfig
index 242aa89bcce0..71749c3b8741 100644
--- a/configs/rock-pi-n8-rk3288_defconfig
+++ b/configs/rock-pi-n8-rk3288_defconfig
@@ -63,6 +63,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -81,7 +82,6 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 # CONFIG_USB_KEYBOARD_FN_KEYS is not set
 CONFIG_USB_GADGET=y
diff --git a/configs/rock2_defconfig b/configs/rock2_defconfig
index 025b55e2171b..6ebda3a36992 100644
--- a/configs/rock2_defconfig
+++ b/configs/rock2_defconfig
@@ -9,6 +9,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3288-rock2-square"
+CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
@@ -65,6 +66,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -80,7 +82,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
diff --git a/configs/rock_defconfig b/configs/rock_defconfig
index 71e504713c16..753deb349afd 100644
--- a/configs/rock_defconfig
+++ b/configs/rock_defconfig
@@ -12,6 +12,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x60100000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3188-radxarock"
+CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3188=y
 # CONFIG_ROCKCHIP_STIMER is not set
 CONFIG_TARGET_ROCK=y
@@ -53,6 +54,7 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_DM_PMIC=y
 # CONFIG_SPL_PMIC_CHILDREN is not set
@@ -68,7 +70,6 @@ CONFIG_TIMER=y
 CONFIG_SPL_TIMER=y
 CONFIG_ROCKCHIP_TIMER=y
 CONFIG_USB=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_RANDOM_UUID=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_CMD_DHRYSTONE=y
diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index 2e701a5ff722..a1d8acc70e3c 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -62,11 +62,12 @@ CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -81,7 +82,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index 816903c8430e..902742b73bf0 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -62,11 +62,12 @@ CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_PHY_REALTEK=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -81,7 +82,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/vyasa-rk3288_defconfig b/configs/vyasa-rk3288_defconfig
index 1d7e22653608..a0e160e6d70c 100644
--- a/configs/vyasa-rk3288_defconfig
+++ b/configs/vyasa-rk3288_defconfig
@@ -72,6 +72,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -87,7 +88,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index c505862f1e15..9c91f63786ac 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -7,6 +7,3 @@ comment "USB Phy"

 config TWL4030_USB
 	bool "TWL4030 PHY"
-
-config ROCKCHIP_USB2_PHY
-	bool "Rockchip USB2 PHY"
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index b67a70bbe8ed..cf6109dee610 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -4,4 +4,3 @@
 # Tom Rix <Tom.Rix@windriver.com>

 obj-$(CONFIG_TWL4030_USB) += twl4030.o
-obj-$(CONFIG_ROCKCHIP_USB2_PHY) += rockchip_usb2_phy.o
diff --git a/drivers/usb/phy/rockchip_usb2_phy.c b/drivers/usb/phy/rockchip_usb2_phy.c
deleted file mode 100644
index bdbd0d44813a..000000000000
--- a/drivers/usb/phy/rockchip_usb2_phy.c
+++ /dev/null
@@ -1,113 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2016 Rockchip Electronics Co., Ltd
- */
-
-#include <hang.h>
-#include <log.h>
-#include <asm/io.h>
-#include <linux/bitops.h>
-#include <linux/delay.h>
-
-#include "../gadget/dwc2_udc_otg_priv.h"
-
-#define BIT_WRITEABLE_SHIFT	16
-
-struct usb2phy_reg {
-	unsigned int offset;
-	unsigned int bitend;
-	unsigned int bitstart;
-	unsigned int disable;
-	unsigned int enable;
-};
-
-/**
- * struct rockchip_usb2_phy_cfg: usb-phy port configuration
- * @port_reset: usb otg per-port reset register
- * @soft_con: software control usb otg register
- * @suspend: phy suspend register
- */
-struct rockchip_usb2_phy_cfg {
-	struct usb2phy_reg port_reset;
-	struct usb2phy_reg soft_con;
-	struct usb2phy_reg suspend;
-};
-
-struct rockchip_usb2_phy_dt_id {
-	char		compatible[128];
-	const void	*data;
-};
-
-static const struct rockchip_usb2_phy_cfg rk3066a_pdata = {
-	.port_reset	= {0x00, 12, 12, 0, 1},
-	.soft_con	= {0x08, 2, 2, 0, 1},
-	.suspend	= {0x08, 8, 3, (0x01 << 3), (0x2A << 3)},
-};
-
-static const struct rockchip_usb2_phy_cfg rk3288_pdata = {
-	.port_reset     = {0x00, 12, 12, 0, 1},
-	.soft_con       = {0x08, 2, 2, 0, 1},
-	.suspend	= {0x0c, 5, 0, 0x01, 0x2A},
-};
-
-static struct rockchip_usb2_phy_dt_id rockchip_usb2_phy_dt_ids[] = {
-	{ .compatible = "rockchip,rk3066a-usb-phy", .data = &rk3066a_pdata },
-	{ .compatible = "rockchip,rk3188-usb-phy", .data = &rk3288_pdata },
-	{ .compatible = "rockchip,rk3288-usb-phy", .data = &rk3288_pdata },
-	{}
-};
-
-static void property_enable(struct dwc2_plat_otg_data *pdata,
-				  const struct usb2phy_reg *reg, bool en)
-{
-	unsigned int val, mask, tmp;
-
-	tmp = en ? reg->enable : reg->disable;
-	mask = GENMASK(reg->bitend, reg->bitstart);
-	val = (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);
-
-	writel(val, pdata->regs_phy + reg->offset);
-}
-
-void otg_phy_init(struct dwc2_udc *dev)
-{
-	struct dwc2_plat_otg_data *pdata = dev->pdata;
-	struct rockchip_usb2_phy_cfg *phy_cfg = NULL;
-	struct rockchip_usb2_phy_dt_id *of_id;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(rockchip_usb2_phy_dt_ids); i++) {
-		of_id = &rockchip_usb2_phy_dt_ids[i];
-		if (ofnode_device_is_compatible(pdata->phy_of_node,
-						of_id->compatible)){
-			phy_cfg = (struct rockchip_usb2_phy_cfg *)of_id->data;
-			break;
-		}
-	}
-	if (!phy_cfg) {
-		debug("Can't find device platform data\n");
-
-		hang();
-		return;
-	}
-	pdata->priv = phy_cfg;
-	/* disable software control */
-	property_enable(pdata, &phy_cfg->soft_con, false);
-
-	/* reset otg port */
-	property_enable(pdata, &phy_cfg->port_reset, true);
-	mdelay(1);
-	property_enable(pdata, &phy_cfg->port_reset, false);
-	udelay(1);
-}
-
-void otg_phy_off(struct dwc2_udc *dev)
-{
-	struct dwc2_plat_otg_data *pdata = dev->pdata;
-	struct rockchip_usb2_phy_cfg *phy_cfg = pdata->priv;
-
-	/* enable software control */
-	property_enable(pdata, &phy_cfg->soft_con, true);
-	/* enter suspend */
-	property_enable(pdata, &phy_cfg->suspend, true);
-}
diff --git a/include/usb/dwc2_udc.h b/include/usb/dwc2_udc.h
index aa37e957b47c..c8610ef8c98a 100644
--- a/include/usb/dwc2_udc.h
+++ b/include/usb/dwc2_udc.h
@@ -15,7 +15,6 @@

 struct dwc2_plat_otg_data {
 	void		*priv;
-	ofnode		phy_of_node;
 	int		(*phy_control)(int on);
 	uintptr_t	regs_phy;
 	uintptr_t	regs_otg;
--
2.39.5

