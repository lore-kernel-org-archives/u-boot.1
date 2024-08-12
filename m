Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2598AC52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 19:13:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52C1B886A7;
	Mon, 12 Aug 2024 21:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e8JXkvAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C56A886A7; Mon, 12 Aug 2024 21:13:01 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BA6F87E30
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 21:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-428141be2ddso35377685e9.2
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723489975; x=1724094775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=g7dbsCvbcVxZcTCf8u29u7ixViiPR/0NWybzVzBqlJA=;
 b=e8JXkvAaMSdNJ64/8Eiw9a5z4lYieZfEkr5l3igIJZHEJ88FNrJ4xfDi3kwaeff5kI
 9AHh3B3D388idL2391j7sRqIHbP/77qlji19SIu1Nhs3QrW9PIfThE0WyddEsf/89kek
 rT2/cl4OLYIj0wirMW4+3A6pJbZw+pm0r8RBttyXMJmjjRGTQcRUpTu9S3sMauIdi7PV
 A28gVeTT11O1q4Mg1fAo29FIz9JupNFVOM0G3P/Pbb+t9n8I2I/clvd8nFd5GhRkM8Wo
 GzCVQcisfc5nQooxK+INwP4gQaKqrFSLPS+tI+LweC/U1y+z11zDcqx4iS4znz2QNbaJ
 5SKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723489975; x=1724094775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g7dbsCvbcVxZcTCf8u29u7ixViiPR/0NWybzVzBqlJA=;
 b=MC123GCVfiH2RNpzLpkKTFVx0SMB2SG8TTD7aWHncNVGJgqbSorSCXZvBQvm6jY4Ll
 32SKTPabr39KXEpGIzZ4M+yuuFZOv69hDBdSVfHCm28duJqD2leX/jmcGlLdubqkYlER
 FPWN8jMPqqLNVz3/xFX/GxvWzlSHVOtcdBYpztfHccSuvZX6w6XK0/MkcVKJLpNzDC8O
 yfwgRM6fgBmaXxM8RTaAE7iAspdzBtF7roG9xRrHdwGgueoq5ntIC9C9yQCkWRx8xMKn
 hH1jcZqxaqeFQo0leN+M4bbvZDQqm6toX1x58P4RwUcZvqmAd3h53x2KvRIqBRJ6efnB
 P8sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUxUO8+7xyIiK1c77nH32aSFirf7uWNjC+6PNIWQi2mtX5+GXQpgKDASg6wz4NwbQrOKbmIHIBkFTZCUlfewHI4HyxBA==
X-Gm-Message-State: AOJu0YwtWagEUlW5YQvL/aJcNj84GEKZRF1Qi4qf4JlcgL7fDQaBMmaB
 lrnTdCFU/FhqJIRPMjnG11zzlQUwCWFQSV+/zbQtPNyUVHPCXrHE
X-Google-Smtp-Source: AGHT+IE4xH3G080NmQTRwznCe+AzOoxJxQ0PRrmaYXXOdOlxpwRwaWprFxxhZouXcKrJYIc+m62vHg==
X-Received: by 2002:a05:600c:4f12:b0:425:5ec3:570b with SMTP id
 5b1f17b1804b1-429d4895270mr9126625e9.35.1723489975089; 
 Mon, 12 Aug 2024 12:12:55 -0700 (PDT)
Received: from localhost.localdomain
 (host-79-52-250-20.retail.telecomitalia.it. [79.52.250.20])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-429c750379asm111879375e9.10.2024.08.12.12.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 12:12:54 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heiko Schocher <hs@denx.de>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH] pci: mediatek: add support for upstream split PCIe node
Date: Mon, 12 Aug 2024 14:31:48 +0200
Message-ID: <20240812123150.20598-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
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

Add support for upstream linux split PCIe node.

Upstream linux have an alternative way to declare PCIe nodes that splits
them in dedicated nodes for each line instead of putting them all in one
node.

Detect this by checking if the mediatek,generic-pciecfg node is passed
as it's used to reference the common address for all the PCIe lines.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/pcie_mediatek.c | 127 ++++++++++++++++++++++++++++--------
 1 file changed, 100 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/pcie_mediatek.c b/drivers/pci/pcie_mediatek.c
index 04d8cc29afd..d88d850924c 100644
--- a/drivers/pci/pcie_mediatek.c
+++ b/drivers/pci/pcie_mediatek.c
@@ -524,7 +524,7 @@ exit:
 	mtk_pcie_port_free(port);
 }
 
-static int mtk_pcie_parse_port(struct udevice *dev, u32 slot)
+static int mtk_pcie_parse_port(struct udevice *dev, u32 slot, int index)
 {
 	struct mtk_pcie *pcie = dev_get_priv(dev);
 	struct mtk_pcie_port *port;
@@ -545,11 +545,11 @@ static int mtk_pcie_parse_port(struct udevice *dev, u32 slot)
 	if (err)
 		return err;
 
-	err = reset_get_by_index(dev, slot, &port->reset);
+	err = reset_get_by_index(dev, index, &port->reset);
 	if (err)
 		return err;
 
-	err = generic_phy_get_by_index(dev, slot, &port->phy);
+	err = generic_phy_get_by_index(dev, index, &port->phy);
 	if (err)
 		return err;
 
@@ -631,18 +631,58 @@ static int mtk_pcie_parse_port_v2(struct udevice *dev, u32 slot)
 	return 0;
 }
 
+static int mtk_pcie_subsys_get(struct udevice *dev)
+{
+	struct mtk_pcie *pcie = dev_get_priv(dev);
+	ofnode cfg_node;
+	fdt_addr_t addr;
+
+	cfg_node = ofnode_by_compatible(ofnode_null(),
+					"mediatek,generic-pciecfg");
+	if (!ofnode_valid(cfg_node))
+		return -ENOENT;
+
+	addr = ofnode_get_addr(cfg_node);
+	if (addr == FDT_ADDR_T_NONE)
+		return -ENODEV;
+
+	pcie->base = map_physmem(addr, 0, MAP_NOCACHE);
+	if (!pcie->base)
+		return -ENOENT;
+
+	return 0;
+}
+
 static int mtk_pcie_probe(struct udevice *dev)
 {
 	struct mtk_pcie *pcie = dev_get_priv(dev);
 	struct mtk_pcie_port *port, *tmp;
+	bool split_pcie_node = false;
 	ofnode subnode;
+	unsigned int slot;
 	int err;
 
 	INIT_LIST_HEAD(&pcie->ports);
 
-	pcie->base = dev_remap_addr_name(dev, "subsys");
-	if (!pcie->base)
-		return -ENOENT;
+	/* Check if upstream implementation is used */
+	err = mtk_pcie_subsys_get(dev);
+	if (!err) {
+		/*
+		 * Assume split port node implementation with "mediatek,generic-pciecfg"
+		 * found. We check reg-names and check if the node is for port0 or port1.
+		 */
+		split_pcie_node = true;
+		if (!strcmp(dev_read_string(dev, "reg-names"), "port0"))
+			slot = 0;
+		else if (!strcmp(dev_read_string(dev, "reg-names"), "port1"))
+			slot = 1;
+		else
+			return -EINVAL;
+	} else {
+		pcie->base = dev_remap_addr_name(dev, "subsys");
+		if (!pcie->base)
+			return -ENOENT;
+	}
 
 	err = clk_get_by_name(dev, "free_ck", &pcie->free_ck);
 	if (err)
@@ -653,20 +693,27 @@ static int mtk_pcie_probe(struct udevice *dev)
 	if (err)
 		return err;
 
-	dev_for_each_subnode(subnode, dev) {
-		struct fdt_pci_addr addr;
-		u32 slot = 0;
+	if (!split_pcie_node) {
+		dev_for_each_subnode(subnode, dev) {
+			struct fdt_pci_addr addr;
 
-		if (!ofnode_is_enabled(subnode))
-			continue;
+			slot = 0;
 
-		err = ofnode_read_pci_addr(subnode, 0, "reg", &addr, NULL);
-		if (err)
-			return err;
+			if (!ofnode_is_enabled(subnode))
+				continue;
 
-		slot = PCI_DEV(addr.phys_hi);
+			err = ofnode_read_pci_addr(subnode, 0, "reg", &addr, NULL);
+			if (err)
+				return err;
 
-		err = mtk_pcie_parse_port(dev, slot);
+			slot = PCI_DEV(addr.phys_hi);
+
+			err = mtk_pcie_parse_port(dev, slot, slot);
+			if (err)
+				return err;
+		}
+	} else {
+		err = mtk_pcie_parse_port(dev, slot, 0);
 		if (err)
 			return err;
 	}
@@ -682,28 +729,54 @@ static int mtk_pcie_probe_v2(struct udevice *dev)
 {
 	struct mtk_pcie *pcie = dev_get_priv(dev);
 	struct mtk_pcie_port *port, *tmp;
-	struct fdt_pci_addr addr;
+	bool split_pcie_node = false;
 	ofnode subnode;
 	unsigned int slot;
 	int err;
 
 	INIT_LIST_HEAD(&pcie->ports);
 
-	pcie->base = dev_remap_addr_name(dev, "subsys");
-	if (!pcie->base)
-		return -ENOENT;
+	/* Check if upstream implementation is used */
+	err = mtk_pcie_subsys_get(dev);
+	if (!err) {
+		/*
+		 * Assume split port node implementation with "mediatek,generic-pciecfg"
+		 * found. We check reg-names and check if the node is for port0 or port1.
+		 */
+		split_pcie_node = true;
+		if (!strcmp(dev_read_string(dev, "reg-names"), "port0"))
+			slot = 0;
+		else if (!strcmp(dev_read_string(dev, "reg-names"), "port1"))
+			slot = 1;
+		else
+			return -EINVAL;
+	} else {
+		pcie->base = dev_remap_addr_name(dev, "subsys");
+		if (!pcie->base)
+			return -ENOENT;
+	}
 
 	pcie->priv = dev;
 
-	dev_for_each_subnode(subnode, dev) {
-		if (!ofnode_is_enabled(subnode))
-			continue;
+	if (!split_pcie_node) {
+		dev_for_each_subnode(subnode, dev) {
+			struct fdt_pci_addr addr;
 
-		err = ofnode_read_pci_addr(subnode, 0, "reg", &addr, NULL);
-		if (err)
-			return err;
+			slot = 0;
 
-		slot = PCI_DEV(addr.phys_hi);
+			if (!ofnode_is_enabled(subnode))
+				continue;
+
+			err = ofnode_read_pci_addr(subnode, 0, "reg", &addr, NULL);
+			if (err)
+				return err;
+
+			slot = PCI_DEV(addr.phys_hi);
+			err = mtk_pcie_parse_port_v2(dev, slot);
+			if (err)
+				return err;
+		}
+	} else {
 		err = mtk_pcie_parse_port_v2(dev, slot);
 		if (err)
 			return err;
-- 
2.45.2

