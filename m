Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18201C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 07:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFC1B88DE0;
	Wed, 24 Apr 2024 09:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gZMn1IJA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C7F688DDC; Wed, 24 Apr 2024 09:39:25 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2E2D88DBB
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 09:39:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43O7dF63074537;
 Wed, 24 Apr 2024 02:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713944355;
 bh=lJ63x7TmvQ00TZegpJtvHRumQosL4A23IShQQ8Yt8C4=;
 h=From:To:CC:Subject:Date;
 b=gZMn1IJAvTROR5kmfXtwyeZeljeA8Lbr1QS0FrCGSY8snlayl6cG4Rc+WPGIoWnH3
 di2oOmc1hXaLhNSsdcITkNJ5HKaqyw4HwNUsBIt5SmW8HtEO09DaN7/USDecQfggkl
 ni5Hyw52RghiA9q3dWN+00Ch7k7AncyLPCZm+tfY=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43O7dEet107902
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Apr 2024 02:39:14 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Apr 2024 02:39:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Apr 2024 02:39:14 -0500
Received: from uda0500640.dal.design.ti.com (uda0500640.dhcp.ti.com
 [172.24.227.88])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43O7dB8G124102;
 Wed, 24 Apr 2024 02:39:12 -0500
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
To: <marex@denx.de>, <trini@konsulko.com>
CC: <rogerq@kernel.org>, <u-boot@lists.denx.de>, <pawell@cadence.com>,
 <peter.chen@kernel.org>, <r-gunasekaran@ti.com>, <srk@ti.com>
Subject: [PATCH v3] usb: cdns3: gadget.c: Set fast access bit
Date: Wed, 24 Apr 2024 13:09:11 +0530
Message-ID: <20240424073911.1943-1-r-gunasekaran@ti.com>
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

commit b5148d946f45 ("usb: cdns3: gadget: set fast access bit") in the
upstream kernel is taken as reference.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Marek Vasut <marex@denx.de>
---
Changes since v2:
----------------
* Updated the commit description with reference to upstream kernel commit
* Picked up Marek's Reviewed-by tag from v2

Changes since v1:
-----------------
* Rebased to tip of -next
* Added Reviewed-by tag

v2: https://lore.kernel.org/all/20240423082420.32336-1-r-gunasekaran@ti.com/
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

