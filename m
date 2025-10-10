Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E915ACCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 16:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE4DF83966;
	Fri, 10 Oct 2025 18:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E72584347; Fri, 10 Oct 2025 18:17:38 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E8BF836D2
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 18:17:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 0A81B227AAF; Fri, 10 Oct 2025 18:17:34 +0200 (CEST)
From: Torsten Duwe <duwe@lst.de>
To: Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>
Cc: Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: [PATCH 4/4] pcie_brcmstb: use bus_base for PCI config devices
In-Reply-To: <20251010161442.410C4227AAE@verein.lst.de>
References: <20251010161442.410C4227AAE@verein.lst.de>
Message-Id: <20251010161734.0A81B227AAF@verein.lst.de>
Date: Fri, 10 Oct 2025 18:17:34 +0200 (CEST)
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

BRCM PCIe controller has different means of accessing to its own
config space and to device's config space. To support this quirk,
its driver uses simple heuristic:
when PCI subsystem probes Bus 0, the driver assumes
that the subsystem tries to accesses PCIe controller config space,
when PCI subsystem probes other busses, the driver uses mechanism
for device config space access. This heuristic works well when
there is only one PCIe controller in the system.
But U-Boot does not support concept of "PCI Segment", so when there
are more than one PCI controller:
- first one gets Bus address 0,
- second one - Bus address 2 and so on.
This breaks the brcm driver, because it tries to access second PCIe
controller config space as if it is device. To fix this, we introduce
additional property bus_base that holds a PCIe controller own Bus
address.
We use this property to calculate "real" Bus address for
underlying devices.
Please note that this fix may not support a case when we have
PCI-to-PCI bridges behind the second PCIe controller.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 drivers/pci/pcie_brcmstb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
index f089c48f028..ca5951974ce 100644
--- a/drivers/pci/pcie_brcmstb.c
+++ b/drivers/pci/pcie_brcmstb.c
@@ -61,6 +61,7 @@ struct brcm_pcie {
 
 	int			gen;
 	bool			ssc;
+	uint16_t		bus_base;
 };
 
 /**
@@ -134,6 +135,7 @@ static int brcm_pcie_config_address(const struct udevice *dev, pci_dev_t bdf,
 	 * Busses 0 (host PCIe bridge) and 1 (its immediate child)
 	 * are limited to a single device each
 	 */
+	pci_bus -= pcie->bus_base;
 	if (pci_bus < 2 && pci_dev > 0)
 		return -EINVAL;
 
@@ -360,6 +362,8 @@ static int brcm_pcie_probe(struct udevice *dev)
 	u16 nlw, cls, lnksta;
 	u32 tmp;
 
+	pcie->bus_base = hose->first_busno;
+
 	/*
 	 * Reset the bridge, assert the fundamental reset. Note for some SoCs,
 	 * e.g. BCM7278, the fundamental reset should not be asserted here.
-- 
2.51.0

