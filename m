Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE13EE57F8
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 11:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AF4686A17;
	Fri,  8 Sep 2023 13:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RLojS/i1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8693686A21; Fri,  8 Sep 2023 13:04:04 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3DCA86A1A
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 13:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388B3sU5094306;
 Fri, 8 Sep 2023 06:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694171034;
 bh=DYETQ43ylo+Z4DqLRw5zmA3oeBUPs7OrLSFdb6AF1PM=;
 h=From:To:CC:Subject:Date;
 b=RLojS/i1rw/q55RLjK20sDtu9au8hIdUkB0F3TCi0FexmOeJQqE7hC5zBWsvXfBEF
 oAkD/FFxB86nxKE1MXIENc7xE8jLKCkgy4lQwIC4LTxoY5SnQZs4qJtEDmFcD4+y2U
 lCWDkfWtq4We+aqOhJJwBUali90kjy4YM1606DSc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388B3sVx031022
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 06:03:54 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 06:03:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 06:03:54 -0500
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat2.itg.ti.com
 [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388B3pFs035963;
 Fri, 8 Sep 2023 06:03:52 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <u-boot@lists.denx.de>, <rogerq@kernel.org>
CC: <angus@akkea.ca>, <r-gunasekaran@ti.com>, <srk@ti.com>
Subject: [PATCH] configs: am65x_evm_r5_usbmsc_defconfig: Enable DWC3 wrapper
 for SPL
Date: Fri, 8 Sep 2023 16:33:51 +0530
Message-ID: <20230908110351.21369-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

commit 280f45d23977 ("configs: get rid of build warnings due to
SPL_USB_DWC3_GENERIC") missed enabling DWC3 glue layer for
usbmsc_defconfig and this broke boot from USB mass storage.
Fix this by enabling DWC3 glue layer.

Fixes: 280f45d23977 ("configs: get rid of build warnings due to SPL_USB_DWC3_GENERIC")
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
 configs/am65x_evm_r5_usbmsc_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/am65x_evm_r5_usbmsc_defconfig b/configs/am65x_evm_r5_usbmsc_defconfig
index 8da49c78c8..733a1c1874 100644
--- a/configs/am65x_evm_r5_usbmsc_defconfig
+++ b/configs/am65x_evm_r5_usbmsc_defconfig
@@ -85,6 +85,7 @@ CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_MISC=y
+CONFIG_SPL_MISC=y
 CONFIG_K3_AVS0=y
 # CONFIG_MMC is not set
 CONFIG_PHY=y
@@ -122,6 +123,7 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
 CONFIG_USB_STORAGE=y
 CONFIG_SPL_USB_STORAGE=y
 CONFIG_USB_GADGET=y
-- 
2.17.1

