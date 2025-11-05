Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD73CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 16:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C971583AEC;
	Wed,  5 Nov 2025 17:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CFE883AC6; Wed,  5 Nov 2025 17:44:45 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1289183AEA
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 17:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 238BB227AB3; Wed,  5 Nov 2025 17:44:39 +0100 (CET)
From: Torsten Duwe <duwe@lst.de>
To: Matthias Brugger <mbrugger@suse.com>, Simon Glass <sjg@chromium.org>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, Christian Marangi <ansuelsmth@gmail.com>,
    Elaine Zhang <zhangqing@rock-chips.com>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
    Heiko Stuebner <heiko@sntech.de>, Huan Zhou <me@per1cycle.org>,
    Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Jan Čermák" <sairon@sairon.cz>,
    Jerome Forissier <jerome.forissier@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
    Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>,
    Kever Yang <kever.yang@rock-chips.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
    Marek Vasut <marek.vasut+renesas@mailbox.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
    Patrick Delaunay <patrick.delaunay@foss.st.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
    Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
    Tom Rini <trini@konsulko.com>, Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
    Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Quentin Schulz <quentin.schulz@cherry.de>,
    u-boot@lists.denx.de
Subject: [RESEND PATCH 4/4] pcie_brcmstb: use bus_base for PCI config devices
In-Reply-To: <20251105163553.15F2A227AAC@verein.lst.de>
References: <20251105163553.15F2A227AAC@verein.lst.de>
Message-Id: <20251105164440.238BB227AB3@verein.lst.de>
Date: Wed,  5 Nov 2025 17:44:39 +0100 (CET)
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
Reviewed-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
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

