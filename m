Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72491D70E02
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 00:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA68F89427;
	Fri, 29 Nov 2024 01:36:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732840568;
	bh=VCKjpSJqw3F0qjCDxJ+44DLQDOXLnwSFm3xGQHb3Z3U=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cmMNq+nKMZA0xPq+a137bxggrIqxXxRYDos4Fyu08Z+1FE78UAwq2isG90VYySEYV
	 cWzaEZS/FmiEcFivwxQMRWtKZpQBCluPCWxFw6Ap9wxp5+wfVTRjy5vrg1ajtKTleR
	 8qpfZrJz42MZHGq5wNe5L3AupaZwU95s8eUcI9PMxNc9sTewAQ1lOPQEYKuVOs93Y0
	 KxivcYgAZzPQABzJxzcD06SUkjjtih0+CKc90aCjQ6YMAT4J7eLkmIYDoWf2Hi4pab
	 EBMvkWw1jIGsa0y4tRLOIcsQQeLJKvdfsjAJFNrXqeO8jVXVUa2yueEmfFDOwmvx9m
	 U9WCwmsM4oroQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E0C8C8938D;
 Fri, 29 Nov 2024 01:36:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732840566;
 bh=VCKjpSJqw3F0qjCDxJ+44DLQDOXLnwSFm3xGQHb3Z3U=;
 h=From:To:Cc:Subject:Date:From;
 b=NjkTISwAYdvNY+N/4rMNyc02rgRmQUXAOTLtyf8D0BCUFJR290WKHVyhLbmnjSG3H
 2jc4SL4uo4j068PW7/6JJCJbUwp4UiNajc8AwiMaIzHJDwAWA06l3PMOxM0YaVTZ70
 ATV16/+akXgrCcOeNT/2A0zRgtOdykIIpwZemp8BDu5YSfwORw/7JlWxzusFsPUgBS
 6Yx8hVexOxZzriAy/uGKm4Prj5sQqnbOevBv3CtRaxTHbRwQn/MOUY7H1JTKabxIB2
 b77u4FBE5VLVFEUc4jmB+ebGRVKiAe3z3w39yhSNYMZvNTgC35Ji42XaVnNXsc817l
 5liMaORtwXvPA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: dts: imx: Enable PCIe and NVMe on Data Modul i.MX8M Mini
 eDM SBC
Date: Fri, 29 Nov 2024 01:35:43 +0100
Message-ID: <20241129003548.253551-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

Enable PCIe/NVMe support on Data Modul i.MX8M Mini eDM SBC. Except for
the configuration options which are enabled, add slight adjustment
to board u-boot.dtsi, which is necessary as there is currently no
driver for the I2C PCIe clock generator. Since the generator is
strapped to be always on, it is possible to supplant the generator
functionality by fixed-clock.

Signed-off-by: Marek Vasut <marex@denx.de>
---
NOTE: Would be nice to have in v2025.01
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 .../arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi | 15 +++++++++++++++
 configs/imx8mm_data_modul_edm_sbc_defconfig       |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi b/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
index f5e98bf7487..3a4f7d01b9e 100644
--- a/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-data-modul-edm-sbc-u-boot.dtsi
@@ -16,6 +16,12 @@
 		dmo,ram-coding-gpios = <&gpio2 8 0>, <&gpio2 1 0>, <&gpio2 0 0>;
 	};
 
+	clk_pcie100: clk-pcie100 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+	};
+
 	wdt-reboot {
 		compatible = "wdt-reboot";
 		wdt = <&wdog1>;
@@ -35,6 +41,15 @@
 	bootph-pre-ram;
 };
 
+&pcie_phy {
+	clocks = <&clk_pcie100>;
+};
+
+&pcie0 {
+	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&clk IMX8MM_CLK_PCIE1_AUX>,
+		 <&clk_pcie100>;
+};
+
 &pinctrl_hog_sbc {
 	bootph-pre-ram;
 };
diff --git a/configs/imx8mm_data_modul_edm_sbc_defconfig b/configs/imx8mm_data_modul_edm_sbc_defconfig
index 260cdd4a5e3..25795701d54 100644
--- a/configs/imx8mm_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mm_data_modul_edm_sbc_defconfig
@@ -5,12 +5,18 @@ CONFIG_ARCH_IMX8M=y
 CONFIG_TARGET_IMX8MM_DATA_MODUL_EDM_SBC=y
 CONFIG_CI_UDC=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_CMD_PCI=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8mm-data-modul-edm-sbc"
 CONFIG_DEFAULT_FDT_FILE="imx8mm-data-modul-edm-sbc.dtb"
 CONFIG_DM_PMIC_BD71837=y
 CONFIG_DM_REGULATOR_BD71837=y
 CONFIG_IMX_CONFIG="board/data_modul/imx8mm_edm_sbc/imximage.cfg"
+CONFIG_NVME_PCI=y
+CONFIG_PCI=y
+CONFIG_PCIE_DW_IMX=y
+CONFIG_PHY=y
 CONFIG_PHYLIB=y
+CONFIG_PHY_IMX8M_PCIE=y
 CONFIG_PREBOOT="run dmo_preboot"
 CONFIG_SDP_LOADADDR=0x60000000
 CONFIG_SPL_BSS_MAX_SIZE=0x2000
-- 
2.45.2

