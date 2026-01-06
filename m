Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6990CEFD15
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 22:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0FE683936;
	Tue,  6 Jan 2026 23:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="i3ZBxEoT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82AB783942; Tue,  6 Jan 2026 23:09:04 +0100 (CET)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com
 [95.215.58.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADDDA83935
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 23:09:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1767737340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hVMYDf838TEaJcxU55z27Qc5c65JOnuPvKj9szXM7zA=;
 b=i3ZBxEoTf9Fr5wpWQ0msm9a9yBtlFkK+sjzSp0oCqXBPZqrudJaLC2nfph1zt5up4yZyxM
 XGkt1mV0NeDaQb77vGPK3YlcQafbPKo4/VUi6yTt9GNC/krg23qAy1agt8UztO8+d+BkQg
 g7IClctHkXCr58aqUmDlF85M2Yl0gS8=
From: Sean Anderson <sean.anderson@linux.dev>
To: Stefan Roese <stefan.roese@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] PCI: xilinx-nwl: Avoid crashing if configuring when the link
 is down
Date: Tue,  6 Jan 2026 17:08:53 -0500
Message-Id: <20260106220853.731358-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

The ECAM will return a slave error if we access non-root devices while
the link is down. Add a check for this like Linux does so we don't
crash.

Fixes: 2f5ad77cfea ("PCI: zynqmp: Add ZynqMP NWL PCIe root port driver")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/pci/pcie-xilinx-nwl.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie-xilinx-nwl.c b/drivers/pci/pcie-xilinx-nwl.c
index e03ab3be912..ab597c83e47 100644
--- a/drivers/pci/pcie-xilinx-nwl.c
+++ b/drivers/pci/pcie-xilinx-nwl.c
@@ -135,6 +135,13 @@ struct nwl_pcie {
 	u32 ecam_value;
 };
 
+static bool nwl_pcie_link_up(struct nwl_pcie *pcie)
+{
+	if (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) & PCIE_PHY_LINKUP_BIT)
+		return true;
+	return false;
+}
+
 static int nwl_pcie_config_address(const struct udevice *bus,
 				   pci_dev_t bdf, uint offset,
 				   void **paddress)
@@ -142,6 +149,9 @@ static int nwl_pcie_config_address(const struct udevice *bus,
 	struct nwl_pcie *pcie = dev_get_priv(bus);
 	void *addr;
 
+	if (PCI_BUS(bdf) != dev_seq(bus) && !nwl_pcie_link_up(pcie))
+		return -EIO;
+
 	addr = pcie->ecam_base;
 	addr += PCIE_ECAM_OFFSET(PCI_BUS(bdf) - dev_seq(bus),
 				 PCI_DEV(bdf), PCI_FUNC(bdf), offset);
@@ -181,13 +191,6 @@ static inline void nwl_bridge_writel(struct nwl_pcie *pcie, u32 val, u32 off)
 	writel(val, pcie->breg_base + off);
 }
 
-static bool nwl_pcie_link_up(struct nwl_pcie *pcie)
-{
-	if (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) & PCIE_PHY_LINKUP_BIT)
-		return true;
-	return false;
-}
-
 static bool nwl_phy_link_up(struct nwl_pcie *pcie)
 {
 	if (readl(pcie->pcireg_base + PS_LINKUP_OFFSET) & PHY_RDY_LINKUP_BIT)
-- 
2.35.1.1320.gc452695387.dirty

base-commit: beab3fe49e1e9209dd32fe2791e7ac706038460f
branch: pcie_nwl_ecam
