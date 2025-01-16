Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4802BE77188
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 04:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E40807D7;
	Thu, 16 Jan 2025 05:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737000353;
	bh=rN+H5ocMLf2gSWN6dm2RhtE8hHlf0weePiYh1RZSeCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RNwPR/BYxie0d2flwq0dXHX9ff/nw9GXRW/ZVU/fUhQ6v6N7EVQbW+E1qeRZDr/oF
	 jOX0CC4FVlyI8mcllSCVpRdrY0oeLNoMia3JJT5U4nGoWaqN+CyR5OUIg9r0E0896h
	 d1wsaLem8BvVEkUBbBZrH5+lZwW5Ik69v5JYgpR6alyaxW9K9TM2eQIw2EU4FDqDX2
	 0+BFUQDyxPqBTercG1PU+3uvvz4TbZ58xkEZXO3eecOIGvZIyByA6g4a5Vhvynt9fF
	 fbBN0g9y/umKiiZQ7QYhWFAYUkIN3Tx84fMgHYQ/AdgTv38NXmOdetKPiglfIh87bM
	 VbDm+9AcRGjTg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDF04807B3; Thu, 16 Jan 2025 05:05:52 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA00F8070C
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Clk0cS33"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C8B1A1040DBDB; Thu, 16 Jan 2025 05:05:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737000350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rN+H5ocMLf2gSWN6dm2RhtE8hHlf0weePiYh1RZSeCI=;
 b=Clk0cS33W5ijfoD9tC0Wx+T8EuN8CYTZisJ09RP+UliK2AM5qTAEJEUtQSMi6v8c0jfdI1
 eDg1YP4Ptbi3TQ1RLTl5GHGAmF8Fts2tULcohjb1SC/3nBnq3UHTC0bLRwpylzojLvH5tG
 yBhBT4O7xoLpy2Y6V+tdOcVuT9K9WbNYSLne4m0ntr/W9guoL1z4sxTOigcVUMQo0jjG/y
 DJofJ6/VBXUSWG4Z8qLMkRHbuFVai22Mau50GyJWH5fQmD1mZmvUfl+DvfEaKa+hk6p2qB
 WBx+cY/IAFOJ+CqFGZVzidjKTMenX7kj94UfvhHku0IPPgv+OqgS1dQsVk5m1A==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Alice Guo <alice.guo@nxp.com>, Marek Vasut <marex@denx.de>,
 Ye Li <ye.li@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Peng Fan <peng.fan@nxp.com>,
 Ramon Fried <rfried.dev@gmail.com>, Robert Marko <robert.marko@sartura.hr>,
 Romain Naour <romain.naour@smile.fr>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/13] net: fsl_enetc: add i.MX95 EMDIO support
Date: Thu, 16 Jan 2025 05:03:29 +0100
Message-ID: <20250116040449.306098-12-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250116040449.306098-1-marex@denx.de>
References: <20250116040449.306098-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Alice Guo <alice.guo@nxp.com>

The verdor ID and device ID of i.MX95 EMDIO are different from LS1028A
EMDIO, so add new vendor ID and device ID to pci_device_id table to
support i.MX95 EMDIO.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
Signed-off-by: Marek Vasut <marex@denx.de> # Clean up
Signed-off-by: Ye Li <ye.li@nxp.com>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Markus Gothe <markus.gothe@genexis.eu>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Robert Marko <robert.marko@sartura.hr>
Cc: Romain Naour <romain.naour@smile.fr>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/fsl_enetc.h      |  1 +
 drivers/net/fsl_enetc_mdio.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fsl_enetc.h b/drivers/net/fsl_enetc.h
index b815474c246..82c2476e1fa 100644
--- a/drivers/net/fsl_enetc.h
+++ b/drivers/net/fsl_enetc.h
@@ -13,6 +13,7 @@
 /* PCI function IDs */
 #define PCI_DEVICE_ID_ENETC_ETH		0xE100
 #define PCI_DEVICE_ID_ENETC_MDIO	0xEE01
+#define PCI_DEVICE_ID_ENETC4_EMDIO	0xEE00
 
 /* ENETC Ethernet controller registers */
 /* Station interface register offsets */
diff --git a/drivers/net/fsl_enetc_mdio.c b/drivers/net/fsl_enetc_mdio.c
index 6a628e78883..c1d491f2c5a 100644
--- a/drivers/net/fsl_enetc_mdio.c
+++ b/drivers/net/fsl_enetc_mdio.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * ENETC ethernet controller driver
- * Copyright 2019 NXP
+ * Copyright 2019-2025 NXP
  */
 
 #include <dm.h>
@@ -132,7 +132,9 @@ static int enetc_mdio_bind(struct udevice *dev)
 
 static int enetc_mdio_probe(struct udevice *dev)
 {
+	struct pci_child_plat *pplat = dev_get_parent_plat(dev);
 	struct enetc_mdio_priv *priv = dev_get_priv(dev);
+	u16 cmd = PCI_COMMAND_MEMORY;
 
 	priv->regs_base = dm_pci_map_bar(dev, PCI_BASE_ADDRESS_0, 0, 0, PCI_REGION_TYPE, 0);
 	if (!priv->regs_base) {
@@ -142,7 +144,10 @@ static int enetc_mdio_probe(struct udevice *dev)
 
 	priv->regs_base += ENETC_MDIO_BASE;
 
-	dm_pci_clrset_config16(dev, PCI_COMMAND, 0, PCI_COMMAND_MEMORY);
+	if (pplat->vendor == PCI_VENDOR_ID_PHILIPS)	/* i.MX95 */
+		cmd |= PCI_COMMAND_MASTER;
+
+	dm_pci_clrset_config16(dev, PCI_COMMAND, 0, cmd);
 
 	return 0;
 }
@@ -158,6 +163,7 @@ U_BOOT_DRIVER(enetc_mdio) = {
 
 static struct pci_device_id enetc_mdio_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_ENETC_MDIO) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_PHILIPS, PCI_DEVICE_ID_ENETC4_EMDIO) },
 	{ }
 };
 
-- 
2.45.2

