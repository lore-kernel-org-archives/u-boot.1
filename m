Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C33C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 09:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F1BE86538;
	Sat,  2 Dec 2023 10:39:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UnILTxM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8ABC86E82; Sat,  2 Dec 2023 10:39:58 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB3E686516
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 10:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gilbsgilbert@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3333073c93cso355566f8f.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 01:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701509996; x=1702114796; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CaM8EgSWS/HVQq+gMBHKNB0NaIEwzauVSisoezCQp2o=;
 b=UnILTxM+X6LGmsWkQaLykWhvWvodyZokFL/JoDfJFgYvTJIp+9oLTBiEEZTLJnlNBN
 nkCAdPH5Wyji2crjl7oe+QvTv2tJQDtDGI0CmzLeKaMjg+bHFwjMBBqQMuhodmHQvav2
 p7NZJvB+hpDQIRkBADVVXEeq8kEkxj8XzcbNp5WxkLNDC5kWn4ZnTv1vRUw2i2wtq9h3
 QxAiE3vOBffZDBOJCGI/KsB2Hwhi+cdtBPPtG90TsB/enUasqQRB3HkzcIQCcF/6C0N7
 cDNhgrufgTyjN54n/wLkknyHMRXu78nUaW/VsrnX5wvvCnAAosrKLz+5z/k2qaoP9tpu
 GKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701509996; x=1702114796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CaM8EgSWS/HVQq+gMBHKNB0NaIEwzauVSisoezCQp2o=;
 b=vEUFVtGWZVgyLltYcJxUHGv/pn+UrGKoh+Vl4k1JScuUzKc8/0W9gb+3tnQwCkTSP4
 gxhOuaeDqz0FRH+qhoY1WGlGiesqC8byUwHIjVPeOMDTv1VcLMVbu8/0EJeCsCXTym7X
 Sax1AuAXJKiMbL1oXegyxLdS/bBlb+hwJQtP7+1KmHnPl12keMduwZXzAZHOyyF82Owl
 sltcVgEhoBFHiSI1IQ0+XqnSzcbS/Tgwi/I4KuHCFwtIaj3CFJPgh556spdd0bZMwMJ0
 M61JfC1RZos6u/4CJuvY12eJdVRVOIQW2/F2fkUG1Jut5BlfYSs68OKynZaJdmaCEnIn
 Litg==
X-Gm-Message-State: AOJu0YyynY55sxMX8+G7WRiDFwxIcThk4udeXAf7uO3hwpl6s5Qsgre2
 R1w4s7cUnOkdxlhYJbg+yo7vE0IFQZJFnb7T
X-Google-Smtp-Source: AGHT+IGhyYrTfeg4ukZPgi9e1fGplVNqwjImeagy6M3eFR1JCsc/TQE/CbdRAfDaxKjtg3RP7DM1Gw==
X-Received: by 2002:a05:6000:1569:b0:333:2e28:5e1e with SMTP id
 9-20020a056000156900b003332e285e1emr4713823wrz.0.1701509995916; 
 Sat, 02 Dec 2023 01:39:55 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:233:d260:8a7:51f2:4ba8:885])
 by smtp.gmail.com with ESMTPSA id
 e5-20020a5d4e85000000b0033333bee379sm3011094wru.107.2023.12.02.01.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Dec 2023 01:39:55 -0800 (PST)
From: Nils Le Roux <gilbsgilbert@gmail.com>
To: u-boot@lists.denx.de
Cc: Nils Le Roux <gilbsgilbert@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH v2] net: designware: Support high memory nodes
Date: Sat,  2 Dec 2023 10:39:49 +0100
Message-ID: <20231202093952.33256-1-gilbsgilbert@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Some platforms (such as the Lichee Pi 4A) have their dwmac device
addressable only in high memory space. Storing the node's base address
on 32 bits is not possible in such case.

Use platform's physical address type to store the base address.

Signed-off-by: Nils Le Roux <gilbsgilbert@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>
---

Changes in v2:
- explicitly define and handle ioaddr as a virtual address
- use an intermediate variable to assign the PCI base address
- use appropriate placeholder to print physical addresses
---
 drivers/net/designware.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index a174344b3e..78bfce07f6 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -678,8 +678,8 @@ int designware_eth_probe(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct dw_eth_dev *priv = dev_get_priv(dev);
-	u32 iobase = pdata->iobase;
-	ulong ioaddr;
+	phys_addr_t iobase = pdata->iobase;
+	void *ioaddr;
 	int ret, err;
 	struct reset_ctl_bulk reset_bulk;
 #ifdef CONFIG_CLK
@@ -740,16 +740,18 @@ int designware_eth_probe(struct udevice *dev)
 	 * or via a PCI bridge, fill in plat before we probe the hardware.
 	 */
 	if (IS_ENABLED(CONFIG_PCI) && device_is_on_pci_bus(dev)) {
-		dm_pci_read_config32(dev, PCI_BASE_ADDRESS_0, &iobase);
-		iobase &= PCI_BASE_ADDRESS_MEM_MASK;
-		iobase = dm_pci_mem_to_phys(dev, iobase);
+		u32 pcibase;
 
+		dm_pci_read_config32(dev, PCI_BASE_ADDRESS_0, &pcibase);
+		pcibase &= PCI_BASE_ADDRESS_MEM_MASK;
+
+		iobase = dm_pci_mem_to_phys(dev, pcibase);
 		pdata->iobase = iobase;
 		pdata->phy_interface = PHY_INTERFACE_MODE_RMII;
 	}
 
-	debug("%s, iobase=%x, priv=%p\n", __func__, iobase, priv);
-	ioaddr = iobase;
+	debug("%s, iobase=%pa, priv=%p\n", __func__, &iobase, priv);
+	ioaddr = phys_to_virt(iobase);
 	priv->mac_regs_p = (struct eth_mac_regs *)ioaddr;
 	priv->dma_regs_p = (struct eth_dma_regs *)(ioaddr + DW_DMA_BASE_OFFSET);
 	priv->interface = pdata->phy_interface;
-- 
2.43.0

