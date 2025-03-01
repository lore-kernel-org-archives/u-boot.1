Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9254CC021B8
	for <u-boot@archiver.kernel.org>; Sat,  1 Mar 2025 08:01:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2C8281197;
	Sat,  1 Mar 2025 09:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xAQLCYpP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41A8680FE1; Sat,  1 Mar 2025 09:01:02 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7BC881100
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 09:00:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52180vDB2326101
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 1 Mar 2025 02:00:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740816057;
 bh=LHR3qgp8tC7pRv936J1a9+3WxsAYDDdgdFf1oMfTpWg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=xAQLCYpPKDmkHtQlnDkZNWXhCuo+ZCqqI8FGIG4jc9Ji4uAicZRAv09zalj6mfI2f
 hS8/gh3dP9kU5wqfIcXamwOCeaASdnWoiaAtOrLpym8rsqL+qlLz/J/dVCtmY7t38R
 40ojPtwKWdMVZ4112p80k4vV+bncuLEaiL/BYjvM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52180vCP033818
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 1 Mar 2025 02:00:57 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 1
 Mar 2025 02:00:57 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 1 Mar 2025 02:00:57 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52180n7Y117507; 
 Sat, 1 Mar 2025 02:00:55 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <j-humphreys@ti.com>, <javier.tia@linaro.org>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v2 2/2] configs: am62x_a53: introduce fragment for USB MSC boot
Date: Sat, 1 Mar 2025 13:30:49 +0530
Message-ID: <20250301080049.965438-3-s-vadapalli@ti.com>
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
https://patchwork.ozlabs.org/project/uboot/patch/20250226103504.1841697-3-s-vadapalli@ti.com/
No changes since v1.

Regards,
Siddharth.

 configs/am62x_a53_usbmsc.config | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 configs/am62x_a53_usbmsc.config

diff --git a/configs/am62x_a53_usbmsc.config b/configs/am62x_a53_usbmsc.config
new file mode 100644
index 00000000000..873a559986b
--- /dev/null
+++ b/configs/am62x_a53_usbmsc.config
@@ -0,0 +1,20 @@
+CONFIG_USB=y
+CONFIG_USB_HOST=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_SYSCON=y
+CONFIG_SPL_SYSCON=y
+CONFIG_MISC=y
+CONFIG_SPL_MISC=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_USB_DWC3_AM62=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_STORAGE=y
+CONFIG_SPL_USB_STORAGE=y
+# CONFIG_DM_USB_GADGET is not set
+# CONFIG_SPL_DM_USB_GADGET is not set
+# CONFIG_USB_GADGET_DOWNLOAD is not set
-- 
2.34.1

