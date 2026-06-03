Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE6ECD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 23:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB62C8467E;
	Thu,  4 Jun 2026 01:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PLQTU0j2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B578848A1; Thu,  4 Jun 2026 01:50:37 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F23C783EF9
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 01:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68c201ec1cfso12742a12.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 16:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780530634; x=1781135434; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wpVm9BvyKSHmvvvwtGOZk0Q4sQROi0ZAa8HMw+b9WUs=;
 b=PLQTU0j2LKQuBePevccRS+qQ0S8MJuWXoEM2alTx82vDYk2On5SyQlWsPFdXX8a8mD
 DqEazEqwIFI1qQJ7NAkE4Lm+JFQ84Ej6h6RYUJbfknPwFztlHSE/RuZNVBoK6SiISuHK
 cive/+blrnu3DuYD//iBBzEBt5DCstNQrehQfkkFDqAFgjjNyNOgf+x8CTnwZKFcoQf/
 lQeQHrtwNU+4FpOXwhBzEjQcgep7gWw2PSd7B+ADxb/oCP1HYVUMljwMsBH4ubGd0jdr
 nQO3RFD+F998JOT/pL8J+d99VwTkFCah8UkOxlUWzZZGQKyW64RhVMu1pVnMXVu55MJZ
 hXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780530634; x=1781135434;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wpVm9BvyKSHmvvvwtGOZk0Q4sQROi0ZAa8HMw+b9WUs=;
 b=Qw8qjM9RM1IndqttNvD1HiUBQF0u5DiVXUC0QRYJHla7/dIn/kxRrnbYGanGXoD6/1
 1YjygVHyr987Q3VN/itpfyO2REzd4ltJHdG5wyGzfanhUoBYqzDoHo4ZwvBb2lpZe772
 68rcxtySLlqJ5wcOhESnA6NLiqbJeW6FMQBVn+2r3Ol0Cbh57oSRclSmPBZfZQv79cRd
 IgUXV62yEbWi9DWDZ1DI7NDg9CuWCgZxdYD+WD1lxRur6zHUZfCje4jawjOwLQGUA6kv
 JXhaQ6NF01o+rUagjturqZHGpLyHFtsIsfgZTkd7W7UE+omE2JuZ/+4yL3G3Hsm3lXnb
 tNhA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8o6H13phPXX4fY/9GdD6sCd3Zx1WFph5T5HVFOikuFieSJj4rpoxNJOF5DkqX7WkQRSblFDXo=@lists.denx.de
X-Gm-Message-State: AOJu0YygXmChiYHMRqfqhTdGYjMNk/Mi8gszBQ33m8c52kC419nA4SMj
 L4PlWOjE7ICgMgVUdretZeX+Ut2OHWPcRmsAdXvG89Yfi67sx9VJlGYU
X-Gm-Gg: Acq92OGZdKumyI25UkXnqiqHt87wdeINVc6apFuX59BpVUBnAkvlsSqcaAKnVmifXPM
 A6DjDqB8bfp8j7mmDV2c6iOxYGt1BxYSJdQwCG86ncJjbPomFfrMDRhGf+zu+yhgiQ7//XYMhAw
 Kq7oedHCuppG7hGL9w/MFmVgXDCVvfJ9pVDKPDZQg4Ed5GHsBBCjVg7r9V6Zh4+GRq68yTcXlo4
 HRrsJ5VPrsXVxS9xUiHcgjOay0tV7c6q4nx9OZqnZsCk7NFpxGv91jhZy93fh6GYVJDTWWB1XP7
 McwXvYXfR2SXRjLm2mMPK8FirE7vyNpwhiIRXR6zkOAt8kRFpWZ9ZqLAcKHsahlI3czG4htKYTd
 Taj2/6dOM9c151dyQZHi0CtU7fQkv90LDU4xlbpdvfGYNML7HFjXGjLeuAPzxM7jYYvfTq9nJ0S
 NYGD4gycPqHYr9EYKt1k/WlhjrSR6a704aIVBY5YnTJRwWc+qwxvkq9+2oxTt5o1UrObQ0bAH2e
 hSerIKBybw=
X-Received: by 2002:a17:907:728f:b0:bed:19af:f8a3 with SMTP id
 a640c23a62f3a-bf226b88149mr7725966b.4.1780530634316; 
 Wed, 03 Jun 2026 16:50:34 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf051e9b1fasm224509566b.23.2026.06.03.16.50.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 16:50:32 -0700 (PDT)
Message-ID: <0436a1f3-a29a-44cb-9011-06205199742e@gmail.com>
Date: Thu, 4 Jun 2026 01:50:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 06/10] rockchip: configs: use phy-rockchip-usb2 DM driver
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
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
 configs/firefly-rk3288_defconfig    | 4 ++--
 configs/miqi-rk3288_defconfig       | 4 ++--
 configs/mk808_defconfig             | 2 +-
 configs/phycore-rk3288_defconfig    | 2 +-
 configs/popmetal-rk3288_defconfig   | 2 +-
 configs/rock-pi-n8-rk3288_defconfig | 2 +-
 configs/rock2_defconfig             | 2 +-
 configs/rock_defconfig              | 2 +-
 configs/tinker-rk3288_defconfig     | 4 ++--
 configs/tinker-s-rk3288_defconfig   | 4 ++--
 configs/vyasa-rk3288_defconfig      | 2 +-
 16 files changed, 20 insertions(+), 20 deletions(-)

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
index a374f90982e0..6002d67cbe90 100644
--- a/configs/phycore-rk3288_defconfig
+++ b/configs/phycore-rk3288_defconfig
@@ -68,6 +68,7 @@ CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
@@ -82,7 +83,6 @@ CONFIG_SYS_NS16550_MEM32=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_ROCKCHIP_USB2_PHY=y
 CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_ETHER_ASIX=y
 CONFIG_USB_ETHER_SMSC95XX=y
diff --git a/configs/popmetal-rk3288_defconfig b/configs/popmetal-rk3288_defconfig
index 52d38f4108c3..7eae4ebc2555 100644
--- a/configs/popmetal-rk3288_defconfig
+++ b/configs/popmetal-rk3288_defconfig
@@ -64,6 +64,7 @@ CONFIG_MMC_DW=y
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
index 025b55e2171b..cc8470214422 100644
--- a/configs/rock2_defconfig
+++ b/configs/rock2_defconfig
@@ -65,6 +65,7 @@ CONFIG_MMC_DW=y
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
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
diff --git a/configs/rock_defconfig b/configs/rock_defconfig
index 71e504713c16..b50c90af8108 100644
--- a/configs/rock_defconfig
+++ b/configs/rock_defconfig
@@ -53,6 +53,7 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_LED=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_DM_PMIC=y
 # CONFIG_SPL_PMIC_CHILDREN is not set
@@ -68,7 +69,6 @@ CONFIG_TIMER=y
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
--
2.39.5

