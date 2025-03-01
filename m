Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12D0C021B8
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 08:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 713C781111;
	Sat,  1 Mar 2025 09:01:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N4+CfSL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F71081111; Sat,  1 Mar 2025 09:01:00 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB691810F4
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 09:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52180tRb2830745
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 1 Mar 2025 02:00:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740816055;
 bh=IPFkCk10Ak20LnRaObi2cZA1xpXSnrre4R0UJVFL+kM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=N4+CfSL1lbEiHxL5wCovutsymL/H01Yi0mU257sWITEq/WXDiB1k++lvxI/bRksTj
 Go7tU4bzMihG334w7F6FYNBnI1pvYNw5LtRMRGR3r2JwxCnqa+rf5+uek8QF0/AAIW
 j6IsuBd2eGSa+KNsc73UbBunRJdjijmoz2L9GQy4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52180tUW033791
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 1 Mar 2025 02:00:55 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 1
 Mar 2025 02:00:54 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 1 Mar 2025 02:00:55 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52180n7X117507; 
 Sat, 1 Mar 2025 02:00:52 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <j-humphreys@ti.com>, <javier.tia@linaro.org>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 1/2] configs: am62x_r5: introduce fragment for USB MSC boot
Date: Sat, 1 Mar 2025 13:30:48 +0530
Message-ID: <20250301080049.965438-2-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250301080049.965438-1-s-vadapalli@ti.com>
References: <20250301080049.965438-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Introduce the config fragment for enabling USB MSC boot. USB MSC boot
involves fetching the next stage of the bootloader from a USB Mass Storage
device such as a USB Flash Drive with the USB controller on the SoC acting
as the USB Host.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v1 of this patch is at:
https://patchwork.ozlabs.org/project/uboot/patch/20250226103504.1841697-2-s-vadapalli@ti.com/
Changes since v1:
- Enabled CONFIG_USB_STORAGE based on the feedback provided by
  Jonathan Humphreys <j-humphreys@ti.com>
  at:
  https://patchwork.ozlabs.org/project/uboot/patch/20250226103504.1841697-2-s-vadapalli@ti.com/#3470589
- Since enabling CONFIG_USB_STORAGE led to exceeding the size limit for
  tiboot3.bin, I disabled CONFIG_SPL_RAM_DEVICE in am62x_r5_usbmsc.config.

Regards,
Siddharth.

 configs/am62x_r5_usbmsc.config | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 configs/am62x_r5_usbmsc.config

diff --git a/configs/am62x_r5_usbmsc.config b/configs/am62x_r5_usbmsc.config
new file mode 100644
index 00000000000..09f94511d28
--- /dev/null
+++ b/configs/am62x_r5_usbmsc.config
@@ -0,0 +1,24 @@
+CONFIG_USB=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_MISC=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_DWC3=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_STORAGE=y
+CONFIG_SPL_USB_STORAGE=y
+# CONFIG_CMD_DFU is not set
+# CONFIG_CMD_FAT is not set
+# CONFIG_CMD_GPT is not set
+# CONFIG_CMD_MMC is not set
+# CONFIG_DFU is not set
+# CONFIG_SPL_LIBDISK_SUPPORT is not set
+# CONFIG_SPL_MMC is not set
+# CONFIG_SPL_MTD is not set
+# CONFIG_SPL_RAM_DEVICE is not set
+# CONFIG_SPL_SPI is not set
+# CONFIG_SPL_SYS_MALLOC is not set
+# CONFIG_MMC_SDHCI is not set
-- 
2.34.1

