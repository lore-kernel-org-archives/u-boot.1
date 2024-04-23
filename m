Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64726C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 08:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF5E68851F;
	Tue, 23 Apr 2024 10:24:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YVj4X6BR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00488884F4; Tue, 23 Apr 2024 10:24:34 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86EFC8853C
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 10:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43N8OOsX077918;
 Tue, 23 Apr 2024 03:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713860664;
 bh=2erNpzYTJWDFLDeKwCUkhxSp/BVz7NFrd3TuByBqSfo=;
 h=From:To:CC:Subject:Date;
 b=YVj4X6BRK+sVxHZ0ZJo0Zm53LJ7DHBQOWVTFMhlu6qnzHWZTRroTUIKTJ3stklwxv
 R19hPjeFHlKz7D+qIMLINW7fUDacIGf7i4OzlZws4MTIqY7fsV+jN0EV2mLq112VIG
 eB6/29lLVCAZUPmoQ4pL5s1xWRkGtmhFTa7XSQd8=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43N8OOZC073898
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 23 Apr 2024 03:24:24 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Apr 2024 03:24:24 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Apr 2024 03:24:24 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com
 [172.24.227.88])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43N8OLkh025094;
 Tue, 23 Apr 2024 03:24:22 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <marex@denx.de>, <trini@konsulko.com>
CC: <rogerq@kernel.org>, <u-boot@lists.denx.de>, <pawell@cadence.com>,
 <peter.chen@kernel.org>, <r-gunasekaran@ti.com>, <srk@ti.com>
Subject: [PATCH v2] usb: cdns3: gadget.c: Set fast access bit
Date: Tue, 23 Apr 2024 13:54:20 +0530
Message-ID: <20240423082420.32336-1-r-gunasekaran@ti.com>
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

From: Aswath Govindraju <a-govindraju@ti.com>

When the device port is in a low power state [U3/L2/Not Connected],
accesses to usb device registers may take a long time. This could lead to
potential core hang when the controller registers are accessed after the
port is disabled by setting DEVDS field. Setting the fast register access
bit ensures that the PHY clock is keeping up in active state.

Therefore, set fast access bit to ensure the accesses to device registers
are quick even in low power states.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
v1 was posted and was reviewed as well. But it did not get merged.
This change is present in upstream linux kernel as well.
Upstream Linux kernel commit: b5148d946f45 ("usb: cdns3: gadget: set fast access bit")

Changes since v1:
----------------
* Rebased to tip of -next
* Added Reviewed-by tag

v1: https://lore.kernel.org/u-boot/20230505121353.23486-1-r-gunasekaran@ti.com/

 drivers/usb/cdns3/gadget.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 7aa0c6b2be..d11175dc5b 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2325,6 +2325,9 @@ static void cdns3_gadget_config(struct cdns3_device *priv_dev)
 	writel(USB_IEN_INIT, &regs->usb_ien);
 	writel(USB_CONF_CLK2OFFDS | USB_CONF_L1DS, &regs->usb_conf);
 
+	/* Set the Fast access bit */
+	writel(PUSB_PWR_FST_REG_ACCESS, &priv_dev->regs->usb_pwr);
+
 	cdns3_configure_dmult(priv_dev, NULL);
 
 	cdns3_gadget_pullup(&priv_dev->gadget, 1);
@@ -2383,6 +2386,7 @@ static int cdns3_gadget_udc_stop(struct usb_gadget *gadget)
 
 	/* disable interrupt for device */
 	writel(0, &priv_dev->regs->usb_ien);
+	writel(0, &priv_dev->regs->usb_pwr);
 	writel(USB_CONF_DEVDS, &priv_dev->regs->usb_conf);
 
 	return ret;

base-commit: bc39e06778168a34bb4e0a34fbee4edbde4414d8
-- 
2.17.1

