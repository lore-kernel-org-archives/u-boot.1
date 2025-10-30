Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB1CCCF9E3
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 22:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 104B5836D3;
	Thu, 30 Oct 2025 23:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hHFOKU7h";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hXrL8jqS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC95836D1; Thu, 30 Oct 2025 23:36:38 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 278278334F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 23:36:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cyJr368H6z9tMq;
 Thu, 30 Oct 2025 23:36:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761863795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GWy0Hmq5TUlDzkXwz+5FGIrnBQSL7c9ojW1FDnmJbf0=;
 b=hHFOKU7hQm5ax0A8d0NeaCLG15kEQpsL3TQHSAUyRurSl0Z5LcR+kyqEkegzEZZkqD1Dzd
 LMrMDX4TUn3pxl+Trh42Gl2pbwTJu8Sr0rrFwgm/l6okXrVxKcNU8kijIzcWMs51qrrcPe
 9vWjyCU7T7lE0yTU89GfCLNS/RRhYY8LodqikjhHPLTl14/wAMxEy0erI9PlTUK4wTb2uj
 6z1nbJTYyqxcDV+J+jlxM8/oTKpf69DlJjp1drJacgnSYcoApDxewZ3yuU+pSKlXlxbvQy
 BIDzcUQHOahXWBL2Z5bola5REecsyXU9eCPVQ/oW41ydP8YETHFBCsRW8VSoKA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761863793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GWy0Hmq5TUlDzkXwz+5FGIrnBQSL7c9ojW1FDnmJbf0=;
 b=hXrL8jqS6xq9vZ/ICN2gQXiYUSZREcw35Zvqc+p9lwoHkAS8mhENiN7awyKtp7e0V1wrHp
 RT7OR5p4KP06O6ZjQgqMDR/2dTpfccoWA/f06hu7Iasr5bUKJMcFYzFZYFv3jTBDHOLtfd
 GWDWPSr9hXFGrJxedkSDPlyV5rwg+8VPjyjNFUgn3HFUdWYRtg3XdvQPI59bLAYZFLNJXa
 Y5392rDvIabSDNdLZ6n4dLDYhuWaWiV08ng6gHDdE6MErQ0RF8pEoURURbnPIZOyx9s4AK
 7zWSmvIUXu/uIE+9YFQ0Lg+AnB5HV9jxLV+3AAjJ3rRr5EBpRfQCPORXM679/A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anshul Dalal <anshuld@ti.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, u-boot-qcom@groups.io
Subject: [PATCH 1/4] ufs: cadence: Rename CONFIG_CADENCE_UFS to
 CONFIG_UFS_CADENCE
Date: Thu, 30 Oct 2025 23:35:42 +0100
Message-ID: <20251030223626.20005-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 55a43deafcc0286818e
X-MBO-RS-META: a1p5k4nduw1uyqcr4ebsgfewg9jcwo9f
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

Align the Kconfig option with the rest of the subsystem, use
CONFIG_UFS_<vendor> format for the Kconfig option.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Anshul Dalal <anshuld@ti.com>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: u-boot-qcom@groups.io
Cc: u-boot@lists.denx.de
---
 configs/am69_sk_a72_defconfig    |  2 +-
 configs/j7200_evm_a72_defconfig  |  2 +-
 configs/j721e_evm_a72_defconfig  |  2 +-
 configs/j721s2_evm_a72_defconfig |  2 +-
 configs/j784s4_evm_a72_defconfig |  2 +-
 drivers/ufs/Kconfig              | 14 +++++++-------
 drivers/ufs/Makefile             |  2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/configs/am69_sk_a72_defconfig b/configs/am69_sk_a72_defconfig
index bd8aaf7f201..d91cc71aacc 100644
--- a/configs/am69_sk_a72_defconfig
+++ b/configs/am69_sk_a72_defconfig
@@ -7,7 +7,7 @@ CONFIG_TARGET_J784S4_A72_EVM=y
 
 CONFIG_CMD_UFS=n
 CONFIG_UFS=n
-CONFIG_CADENCE_UFS=n
+CONFIG_UFS_CADENCE=n
 CONFIG_TI_J721E_UFS=n
 
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am69-sk"
diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index 826a2db0805..75d7d332d30 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -196,5 +196,5 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6164
 CONFIG_SPL_DFU=y
 CONFIG_UFS=y
-CONFIG_CADENCE_UFS=y
+CONFIG_UFS_CADENCE=y
 CONFIG_TI_J721E_UFS=y
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 42e1dd21d0b..01faa33c042 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -201,7 +201,7 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6163
 CONFIG_SPL_DFU=y
 CONFIG_UFS=y
-CONFIG_CADENCE_UFS=y
+CONFIG_UFS_CADENCE=y
 CONFIG_TI_J721E_UFS=y
 CONFIG_EFI_SET_TIME=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index e373a9f05b7..a231c12d803 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -188,5 +188,5 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6168
 CONFIG_SPL_DFU=y
 CONFIG_UFS=y
-CONFIG_CADENCE_UFS=y
+CONFIG_UFS_CADENCE=y
 CONFIG_TI_J721E_UFS=y
diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index 67aa18a16da..dc6321cd615 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -171,7 +171,7 @@ CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_DFU=y
 CONFIG_CMD_UFS=y
 CONFIG_UFS=y
-CONFIG_CADENCE_UFS=y
+CONFIG_UFS_CADENCE=y
 CONFIG_TI_J721E_UFS=y
 
 #include <configs/k3_efi_capsule.config>
diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 445270e8da1..e77b144a470 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -8,13 +8,6 @@ config UFS
 	  This selects support for Universal Flash Subsystem (UFS).
 	  Say Y here if you want UFS Support.
 
-config CADENCE_UFS
-	bool "Cadence platform driver for UFS"
-	depends on UFS
-        help
-	  This selects the platform driver for the Cadence UFS host
-	  controller present on present TI's J721e devices.
-
 config QCOM_UFS
 	bool "Qualcomm Host Controller driver for UFS"
 	depends on UFS && ARCH_SNAPDRAGON
@@ -45,6 +38,13 @@ config UFS_AMD_VERSAL2
 	  UFS host on AMD needs some vendor specific configuration before accessing
 	  the hardware.
 
+config UFS_CADENCE
+	bool "Cadence platform driver for UFS"
+	depends on UFS
+        help
+	  This selects the platform driver for the Cadence UFS host
+	  controller present on present TI's J721e devices.
+
 config UFS_MEDIATEK
 	tristate "MediaTek UFS Host Controller Driver"
 	depends on UFS && ARCH_MEDIATEK
diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
index 6b2f2ccc9fc..656988ef9ad 100644
--- a/drivers/ufs/Makefile
+++ b/drivers/ufs/Makefile
@@ -4,11 +4,11 @@
 #
 
 obj-$(CONFIG_UFS) += ufs-uclass.o
-obj-$(CONFIG_CADENCE_UFS) += cdns-platform.o
 obj-$(CONFIG_QCOM_UFS) += ufs-qcom.o
 obj-$(CONFIG_ROCKCHIP_UFS) += ufs-rockchip.o
 obj-$(CONFIG_TI_J721E_UFS) += ti-j721e-ufs.o
 obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
+obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
 obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o
 obj-$(CONFIG_UFS_PCI) += ufs-pci.o
 obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
-- 
2.51.0

