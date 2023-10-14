Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63841CDB482
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D250586FCB;
	Sun, 15 Oct 2023 09:22:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MzcByRUw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9418B86FCA; Sun, 15 Oct 2023 09:21:48 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C80986FAD
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:18:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6c6591642f2so845092a34.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697354285; x=1697959085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GwY7p/tMySsgAZjZKtDFBzF1XElFk7SbjGQ7w0XeLLQ=;
 b=MzcByRUw/crmfC8gm1HDTp6fNOKuWvo+mZiDUuAiEKOFJweLM4+bEBomsDAGxEBZG4
 /uk6Lhzkd1khCmqX+IC2vnPjOwl2jrXJB6pmXCm91/zvt63JOnjL4/ND2kL9Rv7tIo3M
 OtPjDvrlLShqBr1zHsOEIykDLTbhVxos54nPMBAxKGOmzyXylz9psQrT9RAAqoEmf2i8
 UHl5lDxkYkOrN7Q0dr9OVSa+0ozReGXL6maJhrcx4cpgEIiH5DJHeDruEdSDUSSMorhJ
 ofdIACTxoagHMowydHDnFsft6X1PoAbSJR1E4pfh6UPLPD8ygmZ54Lfz7HIeS7LyoD0g
 Qihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697354285; x=1697959085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GwY7p/tMySsgAZjZKtDFBzF1XElFk7SbjGQ7w0XeLLQ=;
 b=qCFUY8gtqsHE0NFx5VllLVjjYqIthxCvxbF5FciRhwgwa6uS430B5QvTfq0gobYsl5
 DHFREhDvKIk030TCOKSMNx5rwcj1mcw4Ch6uL+xMuxR4T49G3+lF/0kCeOtZXZ7WoAPL
 5lnC2tNYRtPRv/8oI7srKLwPhX/MlZUs2SSPyp2XwO0wVCJHsuxoy3CVTg/vu2AufTbW
 622k10GDsBbYSXtO9PUyJKxuFygK2lygZZ7zXCALE9HvtYHAtTasJTeSjmNvhnwrXT2q
 M3xbnheENwLYG343BJ5Nyh1IxJwIe3GHqbaEspeQ3pn5+pqfCtvzMa1Q8PlTSr4+gF+h
 iPGQ==
X-Gm-Message-State: AOJu0YyOUYLZeRD3YW+3+e/6zNDDdLGhsOueoPuAL2RjCp2Ay/xO37Lh
 cZ9EbNKCvL5AzSzsVJ0HjooYY3e/Mpw=
X-Google-Smtp-Source: AGHT+IG3/Jo62MPorkmH81CV2hBOPsH4IZB9rWIYZDiTIYHGwaDBcWwR/SuVQfgdEXmf6PW1dussXg==
X-Received: by 2002:a05:6a20:c18f:b0:16e:26fd:7c02 with SMTP id
 bg15-20020a056a20c18f00b0016e26fd7c02mr22505524pzb.2.1697317937471; 
 Sat, 14 Oct 2023 14:12:17 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a2cf:5352:29eb:c2bb])
 by smtp.gmail.com with ESMTPSA id
 a16-20020a170902ecd000b001c72d5e16acsm623999plh.57.2023.10.14.14.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 14:12:16 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: marex@denx.de, peng.fan@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v2] imx8mp-evk: Add USB0 OTG support
Date: Sat, 14 Oct 2023 18:12:08 -0300
Message-Id: <20231014211208.550381-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Add USB0 OTG support.

Currently, the USB0 OTG nodes are not enabled in the Linux kernel
devicetree.

For this reason, enable the USB0 OTG nodes inside imx8mp-evk-u-boot.dtsi
for now.

Also select several useful options such as USB gadget and fastboot.

Tested by running "ums 0 mmc 2".

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Selected CONFIG_PHY=y and CONFIG_PHY_IMX8MQ_USB=y. Previously the ums
command was working only after booting via USB serial download mode.
Now it also works after booting from SD card.

 arch/arm/dts/imx8mp-evk-u-boot.dtsi | 14 +++++++++++++
 configs/imx8mp_evk_defconfig        | 31 +++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/arm/dts/imx8mp-evk-u-boot.dtsi b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
index 6784ed2e7c92..43f13a9c22f7 100644
--- a/arch/arm/dts/imx8mp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
@@ -111,6 +111,20 @@
 	bootph-pre-ram;
 };
 
+&usb3_phy0 {
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb_dwc3_0 {
+	pinctrl-names = "default";
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index da1f5d1ad2e0..c129170bf83d 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -59,6 +59,9 @@ CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_SDP=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_EXT4_WRITE=y
@@ -74,6 +77,14 @@ CONFIG_ETHPRIME="eth1"
 CONFIG_SPL_DM=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_IMX8MP=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x42800000
+CONFIG_FASTBOOT_BUF_SIZE=0x20000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=2
+CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
+CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
 CONFIG_MXC_GPIO=y
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
@@ -94,10 +105,15 @@ CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_IMX=y
 CONFIG_FEC_MXC=y
 CONFIG_MII=y
+CONFIG_PHY=y
+CONFIG_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_SPL_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
 CONFIG_POWER_PCA9450=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
@@ -109,4 +125,19 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_USB=y
+# CONFIG_SPL_DM_USB is not set
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_MX7 is not set
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_SDP_LOADADDR=0x0
 CONFIG_IMX_WATCHDOG=y
-- 
2.34.1

