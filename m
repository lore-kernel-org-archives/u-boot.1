Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493C2CD98DA
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 21:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE89F8488B;
	Mon, 15 Jun 2026 23:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lk91fcew";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE056848D7; Mon, 15 Jun 2026 23:08:17 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C32638484C
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-bebe5d8c661so32663466b.2
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781557695; x=1782162495; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=STL7V6VR35EZ+4FLdXJfd22Q5/hQQ4WdzLzOFcYlIv0=;
 b=Lk91fcewisJlXOPUmGERJckZaYZzYxFl9fB1DX7Yl4LfIozyGLvdUl1l57+T/7dvMa
 q06qxg/QHsDLNXE3SAY7M8kPSm9C0oQCN/1bn93PXyLT77egUVDQhk4ujH4TycgmibSs
 JlX8k9NjR4zdPQniwLhGmWWC8UOQWfwOmx43Juprw4BLRNQvPKE7qHkYRFeIn2Oi+MAW
 nnmuheFRYD3JnqcYfJKQdusrORzk+zItFMLvWXNYaJhaJC3WUNSnm4Ek9xrhbcofuI9o
 6dNln+SrbVT3qMV0za/SrVxAKXAzMtUepelqVdmQWUOmEckSiTd5Qo52o6+dQ6wFldm7
 QzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781557695; x=1782162495;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=STL7V6VR35EZ+4FLdXJfd22Q5/hQQ4WdzLzOFcYlIv0=;
 b=Qzgk2GDAwBeNy2AKYnwWeJmZZ+LEavYAFcK4wdkElNdZHmZpLaeh6UJ2fMmKAzbrJz
 gXYYnMWT5UTc+54g5aLQPoc86bIEm7AZ/h3DGRbNyA5E3S/QJX2gamafzFX/mdOd7lNn
 quMEByFVPhfkWdk8AzzC3zlt12MXxW8nNszpcosoU1h2q37CzZkDX0kPaiURwcwLlQyR
 lspvpwVOVq1IureNQTyqI80n04ToTIqQY4uo2zKf5ahKaQ7xaRyDFvFELh5JswNDnjT2
 SbTKdJkVsYGhKW13xVB7OOusEfoqQRWpkitl5Xg6S2SThdEja992HOR5Gs6uiT0X4POO
 bT6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9XX8Moq6JPvB52mqa5068DhRmFwr/2SrUr4NuCUpvdY8YNISW1/hdbpiYbvZu3RYoQ0q8AGhE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7gc6DLI7nZGMebTrrZvYgeZIy7krhMs4mzFj5RmUeYTi4IzlN
 V/UCw1+VJ6hN3qWdCmw9kS01F9EHob0LpjRdKiFPbMQjC1y0Q3u8pt8j
X-Gm-Gg: Acq92OEsNRO4JVyG5Hmn1dH20KLqyUa3ZUlG8H/6E3IH87SLLlkDYcCEg2tH6/OyiTw
 0iBE185br2gpEbBzVANErO8ZNApguROf3/LIcgvo0kjhc2EccMUgkR26GAqHvPa9TsTUVBoQIMh
 eW7LQYKs2KGZ9yNQBR4tZZA5mrc3fonSuz0hoMHPdPEbmTFUj6I5ElJ3NvQXrrp4QkEAkY52+le
 TK4TCaWsE3B9Krd2FuDV/37bKSiBx0uNkGWZcBskrXMdukDWUgOnXA+7rsQOzginuBxki7yeHbp
 l4rHuT159GOGZaS2DvvW1cmlHSwxpDmbRnxkHLEW2d8Y/6LGBYiqYmjKPWe8CE6VfEvhakObke4
 1sOyQJrt+pWcROACIUzJQTdjeG8b3SXIprqNDuZ+MKTS8HJ6bOtIkswEomS5itU0EVENbdw0C5y
 tvPQMwVKDJItOF0lCVmAobqYQ6sTzmnaHU/2ZZrF8F/Y9SH94wjZFJxLl3a7QzRg==
X-Received: by 2002:a17:907:d7c9:b0:bee:215e:5477 with SMTP id
 a640c23a62f3a-bfe29331633mr288733966b.2.1781557694866; 
 Mon, 15 Jun 2026 14:08:14 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb5103710sm525518966b.22.2026.06.15.14.08.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 14:08:13 -0700 (PDT)
Message-ID: <0d245d90-db05-487f-a84f-26c62a8a966d@gmail.com>
Date: Mon, 15 Jun 2026 23:08:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 06/10] rockchip: configs: use phy-rockchip-usb2 DM driver
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
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

The new phy-rockchip-usb2 DM driver is now available.
Update defconfigs for RK3066/RK3188/RK3288.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V5:
rebase

Changed V4:
(Jonas)
split patch
remove CONFIG_DM_RESET
---
 configs/chromebit_mickey_defconfig  | 2 +-
 configs/chromebook_jerry_defconfig  | 2 +-
 configs/chromebook_minnie_defconfig | 2 +-
 configs/chromebook_speedy_defconfig | 2 +-
 configs/evb-rk3288-rk808_defconfig  | 2 +-
 configs/firefly-rk3288_defconfig    | 2 +-
 configs/miqi-rk3288_defconfig       | 2 +-
 configs/mk808_defconfig             | 2 +-
 configs/phycore-rk3288_defconfig    | 2 +-
 configs/popmetal-rk3288_defconfig   | 2 +-
 configs/rock-pi-n8-rk3288_defconfig | 2 +-
 configs/rock2_defconfig             | 2 +-
 configs/rock_defconfig              | 2 +-
 configs/tinker-rk3288_defconfig     | 2 +-
 configs/tinker-s-rk3288_defconfig   | 2 +-
 configs/vyasa-rk3288_defconfig      | 2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/configs/chromebit_mickey_defconfig b/configs/chromebit_mickey_defconfig
index 94a744ca005b..0986e99f01c4 100644
--- a/configs/chromebit_mickey_defconfig
+++ b/configs/chromebit_mickey_defconfig
@@ -80,6 +80,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -100,7 +101,6 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
 CONFIG_CONSOLE_TRUETYPE=y
diff --git a/configs/chromebook_jerry_defconfig b/configs/chromebook_jerry_defconfig
index b02db0d41f9c..7fbd72d1b617 100644
--- a/configs/chromebook_jerry_defconfig
+++ b/configs/chromebook_jerry_defconfig
@@ -80,6 +80,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -104,7 +105,6 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
 CONFIG_CONSOLE_TRUETYPE=y
diff --git a/configs/chromebook_minnie_defconfig b/configs/chromebook_minnie_defconfig
index 0bfa2dfd94df..e3f8500352be 100644
--- a/configs/chromebook_minnie_defconfig
+++ b/configs/chromebook_minnie_defconfig
@@ -81,6 +81,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -105,7 +106,6 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
 CONFIG_CONSOLE_TRUETYPE=y
diff --git a/configs/chromebook_speedy_defconfig b/configs/chromebook_speedy_defconfig
index 6bd272444a1c..3a3024930ff3 100644
--- a/configs/chromebook_speedy_defconfig
+++ b/configs/chromebook_speedy_defconfig
@@ -81,6 +81,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
 CONFIG_SPL_PINCTRL=y
@@ -105,7 +106,6 @@ CONFIG_SYSRESET=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_VIDEO=y
 # CONFIG_VIDEO_BPP8 is not set
 CONFIG_CONSOLE_TRUETYPE=y
diff --git a/configs/evb-rk3288-rk808_defconfig b/configs/evb-rk3288-rk808_defconfig
index 2848a5593d24..842df342e6d4 100644
--- a/configs/evb-rk3288-rk808_defconfig
+++ b/configs/evb-rk3288-rk808_defconfig
@@ -69,6 +69,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -83,7 +84,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_VIDEO=y
diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index 58f26f1b1f3c..02b8dcd75899 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -65,6 +65,7 @@ CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -80,7 +81,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
index 1c03bd14b629..18f6a1a09587 100644
--- a/configs/miqi-rk3288_defconfig
+++ b/configs/miqi-rk3288_defconfig
@@ -62,6 +62,7 @@ CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -77,7 +78,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
index 31b18c529134..b8c6f516591a 100644
--- a/configs/mk808_defconfig
+++ b/configs/mk808_defconfig
@@ -86,6 +86,7 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_SPL_MMC_UHS_SUPPORT=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_DM_PMIC=y
 # CONFIG_SPL_PMIC_CHILDREN is not set
@@ -105,7 +106,6 @@ CONFIG_TPL_TIMER=y
 CONFIG_DESIGNWARE_APB_TIMER=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
diff --git a/configs/phycore-rk3288_defconfig b/configs/phycore-rk3288_defconfig
index 0c28e298789b..3f8cccc3a377 100644
--- a/configs/phycore-rk3288_defconfig
+++ b/configs/phycore-rk3288_defconfig
@@ -66,6 +66,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -80,7 +81,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_SMSC95XX=y
diff --git a/configs/popmetal-rk3288_defconfig b/configs/popmetal-rk3288_defconfig
index d9471b0288eb..7ade720d044c 100644
--- a/configs/popmetal-rk3288_defconfig
+++ b/configs/popmetal-rk3288_defconfig
@@ -62,6 +62,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -76,7 +77,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_SMSC95XX=y
diff --git a/configs/rock-pi-n8-rk3288_defconfig b/configs/rock-pi-n8-rk3288_defconfig
index c4fe675920bc..9114184392de 100644
--- a/configs/rock-pi-n8-rk3288_defconfig
+++ b/configs/rock-pi-n8-rk3288_defconfig
@@ -61,6 +61,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -79,7 +80,6 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 # CONFIG_USB_KEYBOARD_FN_KEYS is not set
 CONFIG_USB_GADGET=y
diff --git a/configs/rock2_defconfig b/configs/rock2_defconfig
index 9fca00d179d8..ae306b90a9d2 100644
--- a/configs/rock2_defconfig
+++ b/configs/rock2_defconfig
@@ -63,6 +63,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -78,7 +79,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
diff --git a/configs/rock_defconfig b/configs/rock_defconfig
index 4ad4d34a71fe..703a763de4cc 100644
--- a/configs/rock_defconfig
+++ b/configs/rock_defconfig
@@ -52,6 +52,7 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_DM_PMIC=y
 # CONFIG_SPL_PMIC_CHILDREN is not set
@@ -67,7 +68,6 @@ CONFIG_TIMER=y
 CONFIG_SPL_TIMER=y
 CONFIG_ROCKCHIP_TIMER=y
 CONFIG_USB=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_RANDOM_UUID=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_CMD_DHRYSTONE=y
diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index b22962786b24..3f5bd8c3cd20 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -65,6 +65,7 @@ CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
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
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index 93057cd991b1..9654b346f5ea 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -65,6 +65,7 @@ CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PHY_REALTEK=y
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
diff --git a/configs/vyasa-rk3288_defconfig b/configs/vyasa-rk3288_defconfig
index cfa41d7b35de..30439311c9fd 100644
--- a/configs/vyasa-rk3288_defconfig
+++ b/configs/vyasa-rk3288_defconfig
@@ -70,6 +70,7 @@ CONFIG_MMC_DW=y
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
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
--
2.39.5

