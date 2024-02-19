Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DEDC48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 17:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B23287F29;
	Mon, 19 Feb 2024 18:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="BBXoqrSA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAF9687F3F; Mon, 19 Feb 2024 18:05:53 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32BC887DDA
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 18:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rc75G-0007wX-2j; Mon, 19 Feb 2024 12:05:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=cvb9gh5zVhgsYqsnGRWidz1vlRoybGxU9Lbqh/CQ/dU=; b=BBXoqrSAcysjyW
 mgQM+3boeeytalzagLObBEJ1cyAWGDpWQm9A+8rmhN4AzJSUga1E+AJWfVYJYAApkHUSPOPOEg+m4
 dvhB68wcqpfjer4PGBGNY7q//Wa94e4pb0U37aOPPgZL05jBAqg8TU0h6LR6qzY7gkNupeSMuncg8
 tKO0MhT9yDv713TNksXKs8mB4sB9z6AULe7hrpLeF23BVn1xGD+HOPAJg8c1bTEiwhOOCmxYiQDlV
 G07YsfmydZ+4KFBvovqlAu94HuJ41vpPIaqH7UKjhIXCOScGgoztW6iw7mwy3eWs9QzL6IDAlSsVj
 S8rG0wT6Lhz7GoXteFvw==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Shiji Yang <yangshiji66@outlook.com>,
 Ye Li <ye.li@nxp.com>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de,
	Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v2] usb: ehci-mx6: Add i.MX93 support
Date: Mon, 19 Feb 2024 18:05:31 +0100
Message-ID: <20240219170531.14959-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Feb 2024 18:06:30 +0100
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

i.MX93 uses the same USB IP as i.MX8MM. It can then reuse the ehci-mx6
driver.

Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 drivers/usb/host/Kconfig    | 6 +++---
 drivers/usb/host/ehci-mx6.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 0dd5736433c..f96027d7bd2 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -210,10 +210,10 @@ config USB_EHCI_MX6
 
 config USB_EHCI_MX7
 	bool "Support for i.MX7 on-chip EHCI USB controller"
-	depends on ARCH_MX7 || IMX8M
+	depends on ARCH_MX7 || IMX8M || IMX93
 	select EHCI_HCD_INIT_AFTER_RESET if ARCH_MX7
-	select PHY if IMX8M
-	select NOP_PHY if IMX8M
+	select PHY if IMX8M || IMX93
+	select NOP_PHY if IMX8M || IMX93
 	default y
 	---help---
 	  Enables support for the on-chip EHCI controller on i.MX7 SoCs.
diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index a9ed5e7a0d5..a35fcca43a2 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -538,7 +538,7 @@ static int ehci_usb_phy_mode(struct udevice *dev)
 			plat->init_type = USB_INIT_DEVICE;
 		else
 			plat->init_type = USB_INIT_HOST;
-	} else if (is_mx7() || is_imx8mm() || is_imx8mn()) {
+	} else if (is_mx7() || is_imx8mm() || is_imx8mn() || is_imx93()) {
 		phy_status = (void __iomem *)(addr +
 					      USBNC_PHY_STATUS_OFFSET);
 		val = readl(phy_status);
-- 
2.41.0

