Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9797CCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 16:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 283AF84051;
	Fri, 10 Oct 2025 18:17:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7A8843F5; Fri, 10 Oct 2025 18:17:29 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9A1C83FF9
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 18:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 658FA227AAE; Fri, 10 Oct 2025 18:17:25 +0200 (CEST)
From: Torsten Duwe <duwe@lst.de>
To: Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>
Cc: Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH 2/4] pci-uclass: respect ofnode_read_pci_vendev retval
In-Reply-To: <20251010161442.410C4227AAE@verein.lst.de>
References: <20251010161442.410C4227AAE@verein.lst.de>
Message-Id: <20251010161725.658FA227AAE@verein.lst.de>
Date: Fri, 10 Oct 2025 18:17:25 +0200 (CEST)
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

The vendor:device read in pci_uclass_child_post_bind() might fail,
which is currently ignored. In that case e.g. the RP1 on the RasPi5
is erroneously being treated as a host bridge.

Mark the device's PCI info as invalid in case of failure.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 drivers/pci/pci-uclass.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index c370f8c6400..4092e8ff5a9 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -1200,6 +1200,7 @@ static int pci_uclass_post_probe(struct udevice *bus)
 static int pci_uclass_child_post_bind(struct udevice *dev)
 {
 	struct pci_child_plat *pplat;
+	int err;
 
 	if (!dev_has_ofnode(dev))
 		return 0;
@@ -1207,7 +1208,13 @@ static int pci_uclass_child_post_bind(struct udevice *dev)
 	pplat = dev_get_parent_plat(dev);
 
 	/* Extract vendor id and device id if available */
-	ofnode_read_pci_vendev(dev_ofnode(dev), &pplat->vendor, &pplat->device);
+	err = ofnode_read_pci_vendev(dev_ofnode(dev), &pplat->vendor,
+				     &pplat->device);
+	if (err) {
+		/* Mark PCI device structure as invalid */
+		pplat->devfn = -1;
+		return 0;
+	}
 
 	/* Extract the devfn from fdt_pci_addr */
 	pplat->devfn = pci_get_devfn(dev);
-- 
2.51.0

