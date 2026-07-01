Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C43DC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABB0E84C51;
	Wed,  1 Jul 2026 19:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="alIy37T0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00E984C39; Wed,  1 Jul 2026 19:58:21 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98D4E843B6
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-380cda7f00cso223688a91.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782928698; x=1783533498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+gZVOassfYHOSKpjiKFaUJnnOrkgvTtXFSjIjssSMI=;
 b=alIy37T0H1C5vu7w7D83hqu35n9yiejADO39ZHWSzUvkNw3DNd9HpPVtRSawDzMbpm
 vMOJ4Er+nyQ4N8TKKPn5jTKGw7MvVBdm0i58n4g/x9fVfRXy8kpx38Ei4xzee4pcb6CK
 TftfNOfNFwti+EmZjNjgyXlvxVaspg1Nz/5Uq+O2jJdfz4rAo6HjtHyEiXgy5TZQD5+d
 dSLQn8LXfqtjjXRfYqkcyRFukNCjM3v7MKTmNlO8nTy8fGrgKmgmMXgITxLhpsUJLzeN
 mEowqS7c+oy9F7QdDuYsdB5Fo0faOcKNVfWAMsY85oYwMAkrnz4rY3Zu98hWS0c6fF8J
 /Wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782928698; x=1783533498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o+gZVOassfYHOSKpjiKFaUJnnOrkgvTtXFSjIjssSMI=;
 b=rkk8H2jS74prW46agIaQ9LdVPf0t+WbQ1LbMC4YtJIq1fG5eM5BNxQ3qU8nwRKkurC
 keuo+jWS+HMmIzAxB2WxzIvZUM273hXblfUmsgRDmdPFOqqkaxNDDTHYLJWLGI7tk+ML
 I1mITyOZNqASv8U1Xxry82lJG8MpOcGfS6e8WuEzr1bEJnSyIsxnWRnc7ib6pgC13MxN
 Um+3trZxg80XDR0Q8CLutcQ+DWpQbKWKQ5Cbge9ElEZB6uNw590KDqdYo3AOutzW1qV+
 A0zuOgbYKK1wlO8p5WhtbIpRxXAh5ebx4WfYvsoi4RW2QI40VibcRjBuiy1kXv+H/O3R
 rOWg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQ1jIkyan0v0emT6g91c30xtxBnQs1fJElu85gBIAjDFXmwgQ4SIpi3TK59Px8eongaXxrVSA=@lists.denx.de
X-Gm-Message-State: AOJu0YxCQkDbleKdbyH9NCgpUfwxFtrZ5KXBXStdc44LYXo+p7uawvuL
 CkO7tHsZHUmaVVY6e/0v9k/In71I42B7k6nAapD+LQcs69og5OAJmKNNkLq5YA==
X-Gm-Gg: AfdE7ck2HTMp4Snzn8Psvk7kZxN0avIJbNkGYgNs4lzZ+xO9lRGX+9a35i83MoU8ke0
 uRYeHIG43p0AG3jC1fKtSK6MWFUli+BN5tk9wOpiRYiJTLVSK9KHOQgUnL6/89xUuG1pZvNzvA+
 naUTWMDiO9/Dm9ZnLVkD5FMauyHu1iKjIF6pYYLjZZZALCnV3aKPCWqM179ecb+uHsIhdUW7A/n
 gqHvyzVm5bZoWi40PXwnBMOO0yWpE23NaqzcnxYDJvRfnvBoR95+QuewQtZ3m8LLssj96nt5T8F
 YHxMpv+G3Q5FkXvf7aULsCvpe4bR80WUos9XCjrwYxSdh9skf/RHs7/1caBo6afYo8k73LZCqWt
 ZdDYGicNIanvgnrHbzL8C1tcPKMZoR+JVhR5sqG78Z+9QkaToJfLaT9y9W8ZuLb+YRRkY2u+PMp
 SdNdy4d7eO7LMSfBPFkkEpsMELRuUKVa5impFAzrIYUnF8Mg01Twyls7l996I=
X-Received: by 2002:a17:90b:578e:b0:37f:e178:50ac with SMTP id
 98e67ed59e1d1-380baa6b613mr1748097a91.21.1782928697803; 
 Wed, 01 Jul 2026 10:58:17 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a800:5116:3bae:12e8:a7c9:dab9])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bc27e0dsm63078eec.27.2026.07.01.10.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:58:17 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: djw@t-chip.com.cn, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 2/5] roc-pc-rk3399: Introduce a common defconfig
Date: Wed,  1 Jul 2026 14:57:57 -0300
Message-ID: <20260701175800.40141-2-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701175800.40141-1-festevam@gmail.com>
References: <20260701175800.40141-1-festevam@gmail.com>
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
Changes since v1:
- None.

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

