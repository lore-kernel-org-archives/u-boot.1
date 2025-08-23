Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3952ACA0EE4
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 14:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3828081D5D;
	Sat, 23 Aug 2025 16:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="ctXF8w32";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 851EB82E37; Sat, 23 Aug 2025 16:04:03 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A04E80422
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 16:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: 5d263a89-802a-11f0-8592-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 5d263a89-802a-11f0-8592-00505699b430;
 Sat, 23 Aug 2025 16:06:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=mF7/WhrSUdpZZPzzuuW4B6uS1OetKdtkWKmahzepZ3g=;
 b=ctXF8w32CziG2dxdhxa4vFj6tWmg02AYnhZ3MLJn9CMkEcdAfKu8k5BnMsePWbEVpvvz0aO65OxwA
 c/XuVhK3BZisQrVdPAHMrPLmw7s7bu0QVx0hqCNNP4AUAxQ+RIIX1aiRtqsvWrB0Y53L40x67L8zFa
 zDQ+Zm2Toogrc+20=
X-KPN-MID: 33|WFoKiMViZHoeLpwZlBmtgioRLDZQNHtS++d1HwfVS8aI4ZzGkvtNOZhptOG7kM5
 MIFA8lVqN2azVPisAx8cSRQymvBmOrEesdqkBsZy6Z7U=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|w4PRzhaR5NAq3iuEPIcQqwd0hbGk2h2x68zJ7U57V/GTDAo2+gW8PwCVfS7KJXF
 qRXjmrF9nvTKOz+u+tXj65A==
X-Originating-IP: 80.61.163.207
Received: from korngold.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 041ce766-802a-11f0-88a7-00505699d6e5;
 Sat, 23 Aug 2025 16:03:59 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, j@jannau.net, maz@kernel.org,
 Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH] pci: apple: Fix use of uninitialized variable
Date: Sat, 23 Aug 2025 16:03:56 +0200
Message-ID: <20250823140356.11344-1-kettenis@openbsd.org>
X-Mailer: git-send-email 2.50.1
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

Replace use of uninitialized variable with the PCI device number
in an error message as this is what we use elsewhere to derive
the PCIe port number.  Use ofnode_read_pci_addr() to read the
PCI address of the node and derive the device number from that.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 drivers/pci/pcie_apple.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie_apple.c b/drivers/pci/pcie_apple.c
index 6a8e715d4b6..f5fda9835dc 100644
--- a/drivers/pci/pcie_apple.c
+++ b/drivers/pci/pcie_apple.c
@@ -246,8 +246,9 @@ static int apple_pcie_setup_port(struct apple_pcie_priv *pcie, ofnode np)
 {
 	struct apple_pcie_port *port;
 	struct gpio_desc reset;
+	struct fdt_pci_addr pci_addr;
 	fdt_addr_t addr;
-	u32 stat, idx;
+	u32 stat;
 	int ret;
 	char name[16];
 
@@ -259,12 +260,13 @@ static int apple_pcie_setup_port(struct apple_pcie_priv *pcie, ofnode np)
 	if (!port)
 		return -ENOMEM;
 
-	ret = ofnode_read_u32_index(np, "reg", 0, &idx);
+	ret = ofnode_read_pci_addr(np, FDT_PCI_SPACE_CONFIG, "reg",
+				   &pci_addr, NULL);
 	if (ret)
 		return ret;
 
 	/* Use the first reg entry to work out the port index */
-	port->idx = idx >> 11;
+	port->idx = PCI_DEV(pci_addr.phys_hi);
 	port->pcie = pcie;
 	port->reset = reset;
 	port->np = np;
@@ -333,9 +335,10 @@ static int apple_pcie_setup_port(struct apple_pcie_priv *pcie, ofnode np)
 static int apple_pcie_probe(struct udevice *dev)
 {
 	struct apple_pcie_priv *pcie = dev_get_priv(dev);
+	struct fdt_pci_addr pci_addr;
 	fdt_addr_t addr;
 	ofnode of_port;
-	int i, ret;
+	int ret;
 
 	pcie->hw = (struct reg_info *)dev_get_driver_data(dev);
 
@@ -357,9 +360,14 @@ static int apple_pcie_probe(struct udevice *dev)
 	     of_port = ofnode_next_subnode(of_port)) {
 		if (!ofnode_is_enabled(of_port))
 			continue;
+		ret = ofnode_read_pci_addr(of_port, FDT_PCI_SPACE_CONFIG,
+					   "reg", &pci_addr, NULL);
+		if (ret)
+			continue;
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
-			dev_err(pcie->dev, "Port %d setup fail: %d\n", i, ret);
+			dev_err(pcie->dev, "Port %d setup fail: %d\n",
+				PCI_DEV(pci_addr.phys_hi), ret);
 			return ret;
 		}
 	}
-- 
2.50.1

