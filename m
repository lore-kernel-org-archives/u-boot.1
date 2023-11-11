Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344E0C4332F
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 15:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 188B286EEE;
	Sat, 11 Nov 2023 16:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M/LjxF5X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEF2086EF1; Sat, 11 Nov 2023 16:26:23 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 128A286D2E
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:26:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=gilbsgilbert@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40a279663a2so4105095e9.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 07:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699716381; x=1700321181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kmw3pi47Z6l7Y/dJEcuVnfSvADwT894D+nPIVXC26GI=;
 b=M/LjxF5XtKiHz7YAGH5tH6oImp7ttbHN1/YXkwP1qLAY9Kccaj4we/QqvUF21lLnRv
 7a7Jj/uheLmezQ6P1HZ6zBJijEqz0JnuLWpdtlxV64xXiwM1HXCa0WhioA/xyf4l0j7k
 mlz7yB/iV5p3iIAJGBPzdC53uEMxxaGJesirY8K/TP29NqeDIDICX5UwpSt9B/uDx73R
 4pIGGU0v9dKonbPzmOHeqNsKWXgrz/HXXGbDB0K5MriyqpfeNwy/oe6/1psnsPPxfvR4
 iFNrpFm7MrZafoeyau8q15bCqbL++nxrXwbvkBFLB3ORCka+fTSDJffTdKf7+W2OwRVN
 Ip7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699716381; x=1700321181;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kmw3pi47Z6l7Y/dJEcuVnfSvADwT894D+nPIVXC26GI=;
 b=pyBThxkDK3KeEIZBsZjpwnznMDOEpyr7XgpDlDaaf+a4PDaD/uUfnJXL6nBl2WoRU/
 gSVPr8xlH6/FbVTLroyVC/6zT50417CI58NIxP05jlJpPsVq66H+K5XCHTNklf9He0RS
 G3Z5ffAQX7W2IHCNy3UIMChY/sQqFHS5mTkyLfbMgxa/EtU/vrj5yS1BpoJ6m2SVGi8y
 +yAQ5WD0drwYo4EN/oYbWCM/h9hoLt1bU2tOX+K38IBw8RCTeu8daUwyeQPbK2eA1kPh
 4yfoQTikufQZnmvKYKy4BcSZ0JgIIRZ45oJyDDuXZad9W/MJR11fbPeC0KudZeKJz5CQ
 l69A==
X-Gm-Message-State: AOJu0YwTq2Nw6E+L+1udrnT+0NtX9G5b/S8f5Se1yllpgGaFHxLtTLlW
 RNQiaqOv9DRX9RW29xwkBfT+G6PNtkGLaRbC
X-Google-Smtp-Source: AGHT+IHFM6LyVFRbQa4uvSMzn7q97Mkbzh0QCokUAZZDmOh24ev8oKvZw8ddSbDHszYeHA4U8WRAJQ==
X-Received: by 2002:a05:600c:3b07:b0:405:3cc1:e115 with SMTP id
 m7-20020a05600c3b0700b004053cc1e115mr1958952wms.3.1699716381130; 
 Sat, 11 Nov 2023 07:26:21 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:233:d260:f729:1984:660f:8015])
 by smtp.gmail.com with ESMTPSA id
 m16-20020a7bca50000000b0040841e79715sm2402139wml.27.2023.11.11.07.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 07:26:20 -0800 (PST)
From: Nils Le Roux <gilbsgilbert@gmail.com>
To: u-boot@lists.denx.de
Cc: Nils Le Roux <gilbsgilbert@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH] net: designware: Support high memory nodes
Date: Sat, 11 Nov 2023 16:26:14 +0100
Message-ID: <20231111152619.95185-1-gilbsgilbert@gmail.com>
X-Mailer: git-send-email 2.42.1
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
---

 drivers/net/designware.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/designware.c b/drivers/net/designware.c
index a174344b3e..327732fbf7 100644
--- a/drivers/net/designware.c
+++ b/drivers/net/designware.c
@@ -678,8 +678,8 @@ int designware_eth_probe(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct dw_eth_dev *priv = dev_get_priv(dev);
-	u32 iobase = pdata->iobase;
-	ulong ioaddr;
+	phys_addr_t iobase = pdata->iobase;
+	phys_addr_t ioaddr;
 	int ret, err;
 	struct reset_ctl_bulk reset_bulk;
 #ifdef CONFIG_CLK
@@ -740,7 +740,7 @@ int designware_eth_probe(struct udevice *dev)
 	 * or via a PCI bridge, fill in plat before we probe the hardware.
 	 */
 	if (IS_ENABLED(CONFIG_PCI) && device_is_on_pci_bus(dev)) {
-		dm_pci_read_config32(dev, PCI_BASE_ADDRESS_0, &iobase);
+		dm_pci_read_config32(dev, PCI_BASE_ADDRESS_0, (u32 *)&iobase);
 		iobase &= PCI_BASE_ADDRESS_MEM_MASK;
 		iobase = dm_pci_mem_to_phys(dev, iobase);
 
@@ -748,7 +748,7 @@ int designware_eth_probe(struct udevice *dev)
 		pdata->phy_interface = PHY_INTERFACE_MODE_RMII;
 	}
 
-	debug("%s, iobase=%x, priv=%p\n", __func__, iobase, priv);
+	debug("%s, iobase=%llx, priv=%p\n", __func__, (u64)iobase, priv);
 	ioaddr = iobase;
 	priv->mac_regs_p = (struct eth_mac_regs *)ioaddr;
 	priv->dma_regs_p = (struct eth_dma_regs *)(ioaddr + DW_DMA_BASE_OFFSET);
-- 
2.42.1

