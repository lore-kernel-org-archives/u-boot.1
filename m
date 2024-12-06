Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D342E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 11:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF6E4895AF;
	Fri,  6 Dec 2024 12:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f/+GbqqB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB32895D7; Fri,  6 Dec 2024 12:04:41 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EA998959D
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 12:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B6B4SMR1901032
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 6 Dec 2024 05:04:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733483068;
 bh=P0Vn3+q48t9mo3HVzL8SI+ukRyGyzgFpjSw0ED7479U=;
 h=From:To:CC:Subject:Date;
 b=f/+GbqqBW+189Pb6P0TbVMHN653wRT5fGsxgXSpjoJUYRK30x/zXLz/QrCHhamJYX
 qndussbQsTLlL//yNBHxszgtUruJZYkOGXnSK7gEkZxqoW2S9lLZaoZ8+6n+uaQ3CZ
 xWCSeMmlSXPXjZzbbgQr/rw1L7DuK5oO3/Dk0UF4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B6B4SDU022506;
 Fri, 6 Dec 2024 05:04:28 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Dec 2024 05:04:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Dec 2024 05:04:28 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B6B4P3B042622;
 Fri, 6 Dec 2024 05:04:25 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <marex@denx.de>, <bmeng.cn@gmail.com>,
 <mkorpershoek@baylibre.com>, <rogerq@kernel.org>, <jonas@kwiboo.se>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH] usb: xhci-dwc3: Bail out if "dr_mode" is "peripheral"
Date: Fri, 6 Dec 2024 16:34:23 +0530
Message-ID: <20241206110424.897283-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
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

Since the compatible "snps,dwc3" can be specified in the device-tree for
the Designware USB Controller configured for not only Host and OTG modes
of operation, but also for Peripheral mode of operation, bail out if
"dr_mode" is "peripheral".

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
448add55297 Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boot-pmic
of the master branch of U-Boot.

Regards,
Siddharth.

 drivers/usb/host/xhci-dwc3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index e3e0ceff43e..7b1311503fe 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -208,6 +208,9 @@ static int xhci_dwc3_probe(struct udevice *dev)
 	writel(reg, &dwc3_reg->g_usb2phycfg[0]);
 
 	dr_mode = usb_get_dr_mode(dev_ofnode(dev));
+	if (dr_mode == USB_DR_MODE_PERIPHERAL)
+		return -ENODEV;
+
 	if (dr_mode == USB_DR_MODE_OTG &&
 	    dev_read_bool(dev, "usb-role-switch")) {
 		dr_mode = usb_get_role_switch_default_mode(dev_ofnode(dev));
-- 
2.43.0

