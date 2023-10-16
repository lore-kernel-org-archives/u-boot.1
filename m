Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01132CDB47E
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 00:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA77086958;
	Mon, 16 Oct 2023 02:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nodpC5Hu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFFDB86BCD; Mon, 16 Oct 2023 02:24:46 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF780867D6
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 02:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6c61dd1c229so755216a34.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 17:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697415883; x=1698020683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h5o/UyDgPpyiZLWQba4p+eRXq+ZZeZBMpfME4g8zRVA=;
 b=nodpC5HuBd2zIrkbgTgqVGC68pHPkGOfxPfK9oTIuVH1w3ojUOxLFVCzkIc0gPGaXf
 GVItjctTb2/S3WHlm6xTnxbKswUnVqCkjKijVuPfrInvM4/7vWxCOWD26fXIRINEYAS6
 CZrV1dqmESObcqcP6ltafZwrJKfMGnPnjhLxW/OJ4hWPXzdk1OtG/SVNDVRXcyYyF2hM
 pVN35rQvNiO8GUyKlNBPjdh3UIVVTfJGvF5F3+rREGHVCd4/cRsOh2GdUn4DdCYeCeK+
 A2RBvTrp4+jF3qnmbFwxjZJxqUhlEICKJn5L1vBMsYVD1j01dWey/redHNLyciZZeo+X
 S2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697415883; x=1698020683;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h5o/UyDgPpyiZLWQba4p+eRXq+ZZeZBMpfME4g8zRVA=;
 b=lqO2Z3hTYAKVUSrYgoYSViI8KQ2BvF7+tIosW8F0hL9tSA8NwRw+hHnJxp/o8tyZ0M
 zH/Wqh0XR4sBjsngRMHQ2Qzjo3sFqSfNEplhr+7rKDMKtqiHCtBxyh6CHbskYeDkG8RS
 5VmtXFierhjKHSxskehml+oMqXGvczPxv4QmaEGIILB2Qo1ebdvK6FB3qHZAMb4e+quj
 elCD9ZiuYbFP4ge1w0iZS0YMKGitH13SSOAsOLWKYHXg4ISAWG1skkx4H7+0q50ZoUHb
 YUXMBzW5/Aq6/9eQVrKXSSytOAa274I8bIGNP1gHu3LaU6rnVUPu+24sqcCV8DvMSZkR
 bZjg==
X-Gm-Message-State: AOJu0YwNDsZ1aFNDhxomnu+YWm2HDBHBCa3BQzX/OZxoqS1g5Mpcvmop
 BPNqYKvi/rSDaAI3XV3y2dc=
X-Google-Smtp-Source: AGHT+IE7+G7ER0GA1vprVv3ohpib4zKUCO3uuo4UHCl+Tw4ucqQCNUG+mIspXhFCrtEw/TEJhiDBiw==
X-Received: by 2002:a05:6830:43ab:b0:6b8:7653:dd66 with SMTP id
 s43-20020a05683043ab00b006b87653dd66mr41277159otv.0.1697415883377; 
 Sun, 15 Oct 2023 17:24:43 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:8216:dd32:2c9d:bf33])
 by smtp.gmail.com with ESMTPSA id
 o27-20020aa7979b000000b006bde8e1f0adsm1369891pfp.98.2023.10.15.17.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 17:24:42 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: marex@denx.de, peng.fan@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH v4] imx8mp-evk: Add USB0 OTG support
Date: Sun, 15 Oct 2023 21:24:37 -0300
Message-Id: <20231016002437.641898-1-festevam@gmail.com>
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
Reviewed-by: Marek Vasut <marex@denx.de>
---
Changes since v3:
- Fixed the alphabetical order once again.

 arch/arm/dts/imx8mp-evk-u-boot.dtsi | 13 ++++++++++++
 configs/imx8mp_evk_defconfig        | 31 +++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/dts/imx8mp-evk-u-boot.dtsi b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
index 6784ed2e7c92..f4fd2432ca8f 100644
--- a/arch/arm/dts/imx8mp-evk-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
@@ -111,6 +111,19 @@
 	bootph-pre-ram;
 };
 
+&usb_dwc3_0 {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&usb3_0 {
+	status = "okay";
+};
+
+&usb3_phy0 {
+	status = "okay";
+};
+
 &usdhc1 {
 	bootph-pre-ram;
 };
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 14c749f44308..820dc36e9cdd 100644
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

