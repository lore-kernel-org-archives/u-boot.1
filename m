Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F63C43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 14:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05831849BA;
	Fri, 26 Jun 2026 16:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QJFIgHU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4882D84979; Fri, 26 Jun 2026 16:45:47 +0200 (CEST)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com
 [IPv6:2607:f8b0:4864:20::122b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEA288404D
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 16:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-13986d61b4eso2848521c88.0
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 07:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782485143; x=1783089943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1unF0JUP4AZB9ESUYEk/RgIE11hqaDD+VDJ49OWguE=;
 b=QJFIgHU9zU+H+D5b6GX0loINgb8CDTEZh07iPM6jqLyAUA6WAGEay1RbQYHqh2bVn1
 35B6bVfBS49d4Q1UnikmCspvMlGnxU50U7BEt6qJBQ4117ypzNmHZ1TssvVNkBfM1Rct
 pyGKKR5Gut7kuEyp4GMeHnaKq65Bm2LR6vplVynWon7b+G/Qj0Z4ylDtDumJtgRdTgF1
 Yk06/uler8lqVsNSmfkKUfEGgaH2KkvM9sgJG37q/wF1/qBqLNXOa5yXsHkaFTeBy8GX
 qHS82i6kF2Y0yKe3HDZnjsgC1xlWdKFAI8iR/gSdVDxzjFRpkq56elKhDUJQehev9g0F
 r+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782485143; x=1783089943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G1unF0JUP4AZB9ESUYEk/RgIE11hqaDD+VDJ49OWguE=;
 b=BBMsYiV/tTlvULnRZViS96UQF+0Q9cIjvGSR9ZrZphY22T/CJWDTlCJNubk8ZH9kS2
 HH0gFfkRAdvYql/moVmOIgNjulduqv8t8vY44f07KVuVv2TCpmub9rA92EuaKsdWmm/P
 YicT0piLeO+kpuZ6hUIq9flJYk7Q5EGdUZAYJ2MQ00fjHU6cz+Xa4xMuHL7iDShvwA/G
 RrYoZqXrtpkTb+U8vzvPNkxzdTqsMq2gpIMvbLiCWJzS/53rr1OaOJMoEYe3AQAJzL0Q
 DebPRPQoJEPLxYUikl1HCA9E41ojDvdd+mGWSOxC1aQEZM/RGqli9BAvD2FwJvdOcJKa
 m9aw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9AFAIORpTpYRmAHkB+l28Kvqs7XQs60Sy60lGHQS1HdCGQnW3CpDxSM+bBMiXwoBxv+228vl4=@lists.denx.de
X-Gm-Message-State: AOJu0YwT2enMw6RAOLt48yLHaxvY7FMP5DgC+uHpheDzXvkYNBgzijCD
 e/mG9BH3hgLoivOfVIQ5DoHKVijA8qEzjxs7ZEDHXAo8T7Mf9dxWPeRlYlhLtQ==
X-Gm-Gg: AfdE7ckEjMg1abGL0IrIap3LD5BphswbCJN3VyPQv/tzbzqzsbByZ+E3eria315I+hQ
 H8PtzhrP3SZuSe5u/U6oUpYg4ZWuGoJJ9pHRTTlr5ZFTMkoZnk/q9B25ZsGbxyUK5fCMLIN75pS
 5wsNeJS4iYKBY4w8X4Gpspw/+n2jDgVmdUiuiigEXB+jI58aPHcDVaeJWYRgQRBau39F4cH89d3
 vLRYIEM/zA6yqQcOU/kALzfqlkDYb1RH8fYA1xT+K0CFNKxGD6ZDjjOJO58lzmZ7p11J5i4swPt
 an4h7wUHZHPO9LcshYGazjUeLT0wq2ZqBu5+qsOr+y+FSLYAtzp3kC3nJg/AvW4Yn5mWR6eccUi
 8lEowS7I7gFsJrVav+7tTxzWxu252kmAWi4Ppho6nY6J7FWMI4YVfZKZtnN1WE4BIAC4fpNsn8F
 Fv4J0UOqbsDhBHYW5GdNg7Lsp4seWgpZVhvj8KfrOS/8qQdORlRp61IiHh+1k=
X-Received: by 2002:a05:7022:527:b0:138:4f8f:e2f3 with SMTP id
 a92af1059eb24-139eb40d2d8mr614602c88.32.1782485142963; 
 Fri, 26 Jun 2026 07:45:42 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a800:24b8:381f:62d1:5cfb:ac63])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d9105b57sm18823739c88.14.2026.06.26.07.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 07:45:42 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: djw@t-chip.com.cn, sunil@amarulasolutions.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH 2/5] roc-pc-rk3399: Introduce a common defconfig
Date: Fri, 26 Jun 2026 11:45:30 -0300
Message-ID: <20260626144533.2925490-2-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626144533.2925490-1-festevam@gmail.com>
References: <20260626144533.2925490-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

Introduce a common roc-pc-rk3399_common.config file to make it easier
to introduce new roc-pc-rk3399 board variants.

No functional change.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 configs/roc-pc-rk3399_common.config | 89 ++++++++++++++++++++++++++++
 configs/roc-pc-rk3399_defconfig     | 90 +----------------------------
 2 files changed, 90 insertions(+), 89 deletions(-)
 create mode 100644 configs/roc-pc-rk3399_common.config

diff --git a/configs/roc-pc-rk3399_common.config b/configs/roc-pc-rk3399_common.config
new file mode 100644
index 000000000000..7ead746cec92
--- /dev/null
+++ b/configs/roc-pc-rk3399_common.config
@@ -0,0 +1,89 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_GPIO=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=30000000
+CONFIG_ENV_SIZE=0x8000
+CONFIG_ENV_OFFSET=0x3F8000
+CONFIG_ENV_SECT_SIZE=0x1000
+CONFIG_DM_RESET=y
+CONFIG_ROCKCHIP_RK3399=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_TARGET_ROC_PC_RK3399=y
+CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_SF_DEFAULT_BUS=1
+CONFIG_DEBUG_UART_BASE=0xFF1A0000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_ENV_OFFSET_REDUND=0x3F8000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_DEBUG_UART=y
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_TPL=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_TIME=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_ENV_REDUNDANT=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_TYPEC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+# CONFIG_RAM_ROCKCHIP_DEBUG is not set
+CONFIG_RAM_ROCKCHIP_LPDDR4=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SPI=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_KEYBOARD=y
+CONFIG_USB_HOST_ETHER=y
+CONFIG_USB_ETHER_ASIX=y
+CONFIG_USB_ETHER_ASIX88179=y
+CONFIG_USB_ETHER_MCS7830=y
+CONFIG_USB_ETHER_RTL8152=y
+CONFIG_USB_ETHER_SMSC95XX=y
+CONFIG_USB_GADGET=y
+CONFIG_VIDEO=y
+CONFIG_DISPLAY=y
+CONFIG_VIDEO_ROCKCHIP=y
+CONFIG_DISPLAY_ROCKCHIP_HDMI=y
+CONFIG_ERRNO_STR=y
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 4c9a5a69b4d0..d72e64db1327 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -1,92 +1,4 @@
-CONFIG_ARM=y
-CONFIG_SKIP_LOWLEVEL_INIT=y
-CONFIG_COUNTER_FREQUENCY=24000000
-CONFIG_ARCH_ROCKCHIP=y
-CONFIG_SPL_GPIO=y
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_SF_DEFAULT_SPEED=30000000
-CONFIG_ENV_SIZE=0x8000
-CONFIG_ENV_OFFSET=0x3F8000
-CONFIG_ENV_SECT_SIZE=0x1000
+#include <configs/roc-pc-rk3399_common.config>
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-roc-pc"
-CONFIG_DM_RESET=y
-CONFIG_ROCKCHIP_RK3399=y
-CONFIG_ROCKCHIP_SPI_IMAGE=y
-CONFIG_TARGET_ROC_PC_RK3399=y
-CONFIG_SYS_LOAD_ADDR=0x800800
-CONFIG_SF_DEFAULT_BUS=1
-CONFIG_DEBUG_UART_BASE=0xFF1A0000
-CONFIG_DEBUG_UART_CLOCK=24000000
-CONFIG_ENV_OFFSET_REDUND=0x3F8000
-CONFIG_SPL_SPI_FLASH_SUPPORT=y
-CONFIG_SPL_SPI=y
-CONFIG_DEBUG_UART=y
-# CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-roc-pc.dtb"
-CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_MAX_SIZE=0x40000
-# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-CONFIG_SPL_ENV_SUPPORT=y
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
-CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
-CONFIG_TPL=y
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_USB=y
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_TIME=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_REDUNDANT=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
-CONFIG_ROCKCHIP_GPIO=y
-CONFIG_SYS_I2C_ROCKCHIP=y
-CONFIG_MMC_DW=y
-CONFIG_MMC_DW_ROCKCHIP=y
-CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_SDMA=y
-CONFIG_MMC_SDHCI_ROCKCHIP=y
-CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_DM_ETH_PHY=y
-CONFIG_ETH_DESIGNWARE=y
-CONFIG_GMAC_ROCKCHIP=y
-CONFIG_PHY_REALTEK=y
-CONFIG_PHY_ROCKCHIP_INNO_USB2=y
-CONFIG_PHY_ROCKCHIP_TYPEC=y
-CONFIG_PMIC_RK8XX=y
-CONFIG_REGULATOR_PWM=y
-CONFIG_SPL_DM_REGULATOR_FIXED=y
-CONFIG_REGULATOR_RK8XX=y
-CONFIG_PWM_ROCKCHIP=y
-# CONFIG_RAM_ROCKCHIP_DEBUG is not set
-CONFIG_RAM_ROCKCHIP_LPDDR4=y
-CONFIG_BAUDRATE=1500000
-CONFIG_DEBUG_UART_SHIFT=2
-CONFIG_SYS_NS16550_MEM32=y
-CONFIG_ROCKCHIP_SPI=y
-CONFIG_SYSRESET=y
-CONFIG_USB=y
-CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_GENERIC=y
-CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_OHCI_GENERIC=y
-CONFIG_USB_DWC3=y
-CONFIG_USB_DWC3_GENERIC=y
-CONFIG_USB_KEYBOARD=y
-CONFIG_USB_HOST_ETHER=y
-CONFIG_USB_ETHER_ASIX=y
-CONFIG_USB_ETHER_ASIX88179=y
-CONFIG_USB_ETHER_MCS7830=y
-CONFIG_USB_ETHER_RTL8152=y
-CONFIG_USB_ETHER_SMSC95XX=y
-CONFIG_USB_GADGET=y
-CONFIG_VIDEO=y
-CONFIG_DISPLAY=y
-CONFIG_VIDEO_ROCKCHIP=y
-CONFIG_DISPLAY_ROCKCHIP_HDMI=y
-CONFIG_ERRNO_STR=y
-- 
2.43.0

