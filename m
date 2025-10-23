Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F43CCD1BE
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 11:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0664C8334F;
	Thu, 23 Oct 2025 13:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jFXBC2tc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD7B82E34; Thu, 23 Oct 2025 13:46:27 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B67338334F
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 13:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59NBkLkX518122;
 Thu, 23 Oct 2025 06:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761219981;
 bh=osA0X7dl6RbBavQoGg3deqUjPbfYIYRsEJXInZmsJio=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=jFXBC2tcQGXqKcxxaw8Lpefzy/lZtcKm0wKUxM4ByxipGjy8yMVMIC7+xIy0YrpNC
 euBFoaVfQ3BvU208cty7Z/hg2Ot/TEOMgQc9/amXhIZE51mmNemzVOOTceg+wAgTsB
 1HcOhqYPFW5O1KckESxjFgFsSJlJ7uD0OrZwEkEE=
Received: from DFLE214.ent.ti.com (dfle214.ent.ti.com [10.64.6.72])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59NBkK6J2680141
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Oct 2025 06:46:21 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 06:46:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 06:46:20 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59NBk5hr2786743;
 Thu, 23 Oct 2025 06:46:17 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <a-nandan@ti.com>, <trini@konsulko.com>, <rfried.dev@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <s-vadapalli@ti.com>, <semen.protsenko@linaro.org>,
 <jm@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH 3/4] pci_endpoint: pci_cdns_ti_ep: Enable PCIe Endpoint mode
 in J784S4 SoC
Date: Thu, 23 Oct 2025 17:16:03 +0530
Message-ID: <20251023114604.3655625-4-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023114604.3655625-1-h-salunke@ti.com>
References: <20251023114604.3655625-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

TI's J784S4 SoC has two instances of PCIe Controller namely PCIe0 and
PCIe1 which are Cadence PCIe Controllers. Add support to configure PCIe
instances in Endpoint mode of operation.

While at it disable all endpoint functions except function 0 during
probe to prevent the Root Complex from enumerating unconfigured
functions. This ensures only  properly configured endpoint functions
are visible to the host and avoids enumeration issues with
multi-function devices.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 drivers/pci_endpoint/pcie_cdns_ti_ep.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci_endpoint/pcie_cdns_ti_ep.c b/drivers/pci_endpoint/pcie_cdns_ti_ep.c
index dd3dc939a7e..021bd73a383 100644
--- a/drivers/pci_endpoint/pcie_cdns_ti_ep.c
+++ b/drivers/pci_endpoint/pcie_cdns_ti_ep.c
@@ -275,9 +275,11 @@ static int pcie_cdns_ti_ep_probe(struct udevice *dev)
 	struct pcie_cdns_ti_ep *pcie = dev_get_priv(dev);
 	struct pcie_cdns_ti_ep_data *data;
 	struct power_domain pci_pwrdmn;
+	struct cdns_pcie pcie_dev;
 	struct clk *clk;
 	int ret;
 
+	pcie_dev.reg_base = pcie->reg_base;
 	pcie->dev = dev;
 	data = (struct pcie_cdns_ti_ep_data *)dev_get_driver_data(dev);
 	if (!data)
@@ -328,6 +330,13 @@ static int pcie_cdns_ti_ep_probe(struct udevice *dev)
 		return ret;
 	}
 
+	/*
+	 * Disable all the functions except function 0 (anyway BIT(0) is
+	 * hardwired to 1). This is required to avoid RC from enumerating
+	 * those functions which are not even configured.
+	 */
+	cdns_pcie_writel(&pcie_dev, CDNS_PCIE_LM_EP_FUNC_CFG, BIT(0));
+
 	return 0;
 }
 
@@ -389,11 +398,19 @@ static const struct pcie_cdns_ti_ep_data am64_pcie_ep_data = {
 	.max_lanes = 1,
 };
 
+static const struct pcie_cdns_ti_ep_data j784s4_pcie_ep_data = {
+	.max_lanes = 4,
+};
+
 static const struct udevice_id pcie_cdns_ti_ep_ids[] = {
 	{
 		.compatible = "ti,am64-pcie-ep",
 		.data = (ulong)&am64_pcie_ep_data,
 	},
+	{
+		.compatible = "ti,j784s4-pcie-ep",
+		.data = (ulong)&j784s4_pcie_ep_data,
+	},
 	{},
 };
 
-- 
2.34.1

