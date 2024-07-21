Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2BBC3DA5D
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 14:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB6F187D87;
	Sun, 21 Jul 2024 16:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cpOZLVIW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A806887EFA; Sun, 21 Jul 2024 16:54:00 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B51008752A
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 16:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maximmosk4@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52f0277daa5so484290e87.0
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721573638; x=1722178438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DxAmc5ZQroZfNkXb6VwhzYveaQYz91vFlropyc8vyOc=;
 b=cpOZLVIWZxFIew4sQP7GfbSuWn4WFzQlyTSGApcxWai37BQR5nyMFBjkKHAMfSaOL3
 iT1DvMxXDEgz1x7/dooqSbWZ5HUzXdg7l+9AV1Ai/F+7E/PQFvON4zgrHeSR2GP5mGjH
 6zP7EEc1UOz537ROTEvOmIuXiaLasKpOdT8ZUDcl9A3qilAIlB1NQCItRpjZYMdlyOyZ
 lJxoPYAMjdbQx6uXzs3cSkTcZhJFtnytafiwu0EtjiiWMXzSnEbao9bnIEL6LZEJRpH0
 cefZDhuHwFeEEtHKsxTCWtvEkhxy6ZxtGsKAjFQNGfyLkM49+DTa2U3O7OpGn9mk4J4S
 ohpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721573638; x=1722178438;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DxAmc5ZQroZfNkXb6VwhzYveaQYz91vFlropyc8vyOc=;
 b=gyskd57yqn3wLEse7wmmsQWikb720daawLAGYO3fUbuMEdssUYRf0SOzW6oTMBGbJj
 kEQDTqf9AWAzqgTAADQkQqas+9Yw4mkCst5BcnRxbpr22rGt4Ob6fiJALYn2ad0tjZ+h
 IEDhmaGq4XDla9Lpcw+a2YN5cm/tx/Th2E74vQJN+iVrKLJdDltx236IYOwlHcrnxrja
 sKFPy2R+t3G5oZ5dLFS8e2wWh8xXTH5ufLBHbENwuE9hcxAT4k2ElPraNKyV5BDbhP3v
 1wl4+DB8ehNsMOlOwu8mZSuVCwyOvdnBC+Uuqol6SQlwV93JXyb+Hs7IU73b9T5ROEyP
 Qi7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEsogx2wpOce1GqibYepihAcCT1GGughALyhgBNzTin6uT6v3OlcblVZNXfR6l9d20JdXAwl93q71kl8Aki/FlQgpczQ==
X-Gm-Message-State: AOJu0YwH7QQdNaaJKcH/Yj2GwCsQd4Dkgn+Lat/lfRgcTyTTMHSk4F8A
 Z70iWtjQ/97/5XjryGB0lxa306iBTFN1LLdHmEvW+2+yVopR0HTN
X-Google-Smtp-Source: AGHT+IH2kBJEXhDb+IdgfJbAihhKjDEWmYbTJglck2ZT8s8VnTaNAxqE46mNvufTgpJUMhorRVXYTw==
X-Received: by 2002:a05:6512:1047:b0:52b:9c8a:734f with SMTP id
 2adb3069b0e04-52efb801e5bmr2612112e87.50.1721573637636; 
 Sun, 21 Jul 2024 07:53:57 -0700 (PDT)
Received: from localhost.localdomain (109-252-15-116.nat.spd-mgts.ru.
 [109.252.15.116]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-52ef5577dafsm867091e87.270.2024.07.21.07.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 07:53:57 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: trini@konsulko.com,
	u-boot@lists.denx.de,
	sjg@chromium.org
Cc: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>,
 Maxim Moskalets <maximmosk4@gmail.com>
Subject: [PATCH v2] rockchip: bring-up to Radxa Rock 3C board
Date: Sun, 21 Jul 2024 17:53:53 +0300
Message-Id: <20240721145353.6817-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
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

Just copy of rock-3a-rk3568_defconfig with dts for rock-3c-rk3566.
Separated from the original due to the use of different DTS, than
fixed primarily network support.

Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>
---
 configs/rock-3c-rk3566_defconfig | 93 ++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 configs/rock-3c-rk3566_defconfig

diff --git a/configs/rock-3c-rk3566_defconfig b/configs/rock-3c-rk3566_defconfig
new file mode 100644
index 00000000000..53a98029783
--- /dev/null
+++ b/configs/rock-3c-rk3566_defconfig
@@ -0,0 +1,93 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SF_DEFAULT_SPEED=24000000
+CONFIG_SF_DEFAULT_MODE=0x2000
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-rock-3c"
+CONFIG_ROCKCHIP_RK3568=y
+CONFIG_ROCKCHIP_SPI_IMAGE=y
+CONFIG_SPL_SERIAL=y
+CONFIG_DEBUG_UART_BASE=0xFE660000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_PCI=y
+CONFIG_DEBUG_UART=y
+CONFIG_AHCI=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-rock-3a.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SCSI_AHCI=y
+CONFIG_AHCI_PCI=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SF_DEFAULT_BUS=4
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_XTX=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_NVME_PCI=y
+CONFIG_PCIE_DW_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_SCSI=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ROCKCHIP_SFC=y
+CONFIG_SYSRESET=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_ERRNO_STR=y
-- 
2.39.2

