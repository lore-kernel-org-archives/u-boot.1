Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD8AC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 11:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA23980BA8;
	Mon, 10 Feb 2025 12:23:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ni4cewn4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92466801F5; Mon, 10 Feb 2025 12:23:34 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AB4380C8A
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51ABNOgs3399025
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Feb 2025 05:23:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739186604;
 bh=mGpQ+bZlmRZNQFAT1bLJOfxYXPLqP6UgTe45SeDLWBI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Ni4cewn4jHSMmC86wKScgxxSuR6Y8aGAW/An8AF1PUzNrchCTQ+bKQTgwlGRcsryh
 RQRFbvpRiwwnXeTsFimftEYtkepYn+Cg16eKoHxVRdPTt26brktYV/pVc8OAP5U0LD
 sdwo9FdW/GyGPpiYCiVLZ+aZfX0izIAX6ZB2rjzI=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51ABNOk8006583
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Feb 2025 05:23:24 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Feb 2025 05:23:23 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Feb 2025 05:23:23 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51ABMdb8047041; 
 Mon, 10 Feb 2025 05:23:17 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>, <vaishnav.a@ti.com>, 
 <j-choudhary@ti.com>, <mkorpershoek@baylibre.com>, <rogerq@kernel.org>,
 <hnagalla@ti.com>, <glaroque@baylibre.com>, <nm@ti.com>,
 <n-francis@ti.com>, <m-chawdhry@ti.com>, <jm@ti.com>,
 <devarsht@ti.com>, <sjg@chromium.org>, <afd@ti.com>,
 <j-humphreys@ti.com>, <quentin.schulz@cherry.de>,
 <sjoerd@collabora.com>, <martyn.welch@collabora.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 6/7] configs: j722s_evm_a53_defconfig: enable USB DFU
 support
Date: Mon, 10 Feb 2025 16:52:29 +0530
Message-ID: <20250210112239.2639009-7-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250210112239.2639009-1-s-vadapalli@ti.com>
References: <20250210112239.2639009-1-s-vadapalli@ti.com>
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

The USB0 instance of USB on J722S SoC is a Designware USB Controller with
the same glue layer (wrapper) as AM62 SoC. In order to support USB DFU boot
and USB DFU flash with USB0, enable the corresponding glue layer driver.

While at it, sync with savedefconfig.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

This patch has been newly introduced in this series.

Regards,
Siddharth.

 configs/j722s_evm_a53_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configs/j722s_evm_a53_defconfig b/configs/j722s_evm_a53_defconfig
index 81eb934ed6..b53dc3054f 100644
--- a/configs/j722s_evm_a53_defconfig
+++ b/configs/j722s_evm_a53_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
@@ -54,7 +55,6 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_SPL_THERMAL=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_CLK=y
-CONFIG_CMD_DFU=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB_MASS_STORAGE=y
@@ -155,6 +155,8 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
 CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_DWC3_AM62=y
 CONFIG_SPL_USB_STORAGE=y
 CONFIG_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
@@ -163,4 +165,3 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
 CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
-CONFIG_TI_COMMON_CMD_OPTIONS=y
-- 
2.43.0

