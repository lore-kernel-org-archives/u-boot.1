Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7323CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68F7786F61;
	Sun, 15 Oct 2023 08:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="klzsP/fk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C0EB86E22; Sun, 15 Oct 2023 08:38:53 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EEDE86ECF
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c746bc3bceso10004515ad.1
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697351881; x=1697956681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4IDRB0BVYUmVGhtZwCOmtVxBqCrISgG1GedIhCB4QGs=;
 b=klzsP/fklTB8K/2EHyZfQnEgnUttcGUXM8+eF6/Gc5Ph1+pdNoxrpf0RbP6DFYcDGB
 9bIM/TilfS6dhXKn4w5HQ5sOr6gjEmR8IqNuSWtrTvl+DwqLbqyVnzeQ94gN+26Sw8WB
 aWlqiq79ZdSxJTWwwzCqFhd0Hw3k/oC3vHLfRDk9ESmeZ6q74gZTRby0WyGBa+UKXspB
 XCPKmbg3ZvRQqLGtovWZvYnd2UZiYWcZC8VqfEL04OAgZnK5LG7ADsq/dsmRWIr6UPkP
 9c5Q2YpKlwswfVOD88JkK6wK+TePU+7JLrzS23LwOdrs9s2/m0ca6Baj+ElAWeafid/q
 sDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697351881; x=1697956681;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4IDRB0BVYUmVGhtZwCOmtVxBqCrISgG1GedIhCB4QGs=;
 b=bkELihOYfbXNOmT6yDu5dutqazIjI2QdW74OfwpzCndBnaQ/TktXBuauCgNJxawugH
 CKfinbeBnhy7lPO+gvMLOpgXJDnGd6IM224VDkeYqd7VX1vAGvr07FlT42uKhwo6bUHT
 8vqGjaumaX1ERd7Y15z93M/uVgVlY7UyJrwLhGSijWxXPvOmhoqWeZeK2KW3CnTrEHKI
 gpfFtV0iY+oIq92nNX2AaPu75fcs87r3JV2q2EuBxvYQWCVJNi9njoXlxGeFFHIcuFFE
 6ClShy5J3N7+OjJFPlB2A2zJZW65BgPVTv8/Zh4wn5hfr7LoDI2hNkJieXlCl0UmeMdW
 Vwpw==
X-Gm-Message-State: AOJu0YxOLnEmOy+ndC1ekjhjczz95E4xb5N417Ht83uQD51RCP9iDHgo
 vBObT6C2PcnlJURtSv7vQmUG8Rvokz4=
X-Google-Smtp-Source: AGHT+IFqlwQgdHIYPHZpyKatojQmdzpIOVA2IZQvzHVUwSGgI/d1qWYzM2ZkcBiL3ZtUURBNV3DZgw==
X-Received: by 2002:a05:6870:509:b0:1bf:9fa2:bfa3 with SMTP id
 j9-20020a056870050900b001bf9fa2bfa3mr32478434oao.1.1697310435503; 
 Sat, 14 Oct 2023 12:07:15 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a2cf:5352:29eb:c2bb])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a656812000000b00563590be25esm1119296pgt.29.2023.10.14.12.07.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 12:07:14 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: marex@denx.de, peng.fan@nxp.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] imx8mp-evk: Add USB0 OTG support
Date: Sat, 14 Oct 2023 16:07:09 -0300
Message-Id: <20231014190709.500334-1-festevam@gmail.com>
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
 arch/arm/dts/imx8mp-evk-u-boot.dtsi | 14 ++++++++++++++
 configs/imx8mp_evk_defconfig        | 29 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/arm/dts/imx8mp-evk-u-boot.dtsi b/arch/arm/dts/imx8mp-evk-u-boot.dtsi
index 6784ed2e7c..43f13a9c22 100644
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
index da1f5d1ad2..88ec41a196 100644
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
@@ -98,6 +109,9 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_SPL_POWER_LEGACY=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
 CONFIG_POWER_PCA9450=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
@@ -109,4 +123,19 @@ CONFIG_SYSRESET=y
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

