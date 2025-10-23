Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16034CCD1BE
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 11:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B742283631;
	Thu, 23 Oct 2025 13:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WC+e4zQm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE4C383631; Thu, 23 Oct 2025 13:46:24 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A992082E34
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 13:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59NBkHlJ1655548;
 Thu, 23 Oct 2025 06:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761219977;
 bh=28g/yn4eeClFE07q3K8CKGkQZVrtv3M09Z2VBy5sr7k=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=WC+e4zQmuO06EobBoObz1j0B8634QJ2MZY6MksUSH+bzgLAQ0yvaduVmzvTN69VTv
 5iYmb2lgjl/0fiBU8R3bSE8eBU7vBY9GjT+X39jHceZiqud9ksSYboLGvsK+CzrYR+
 2hxBkZeDPBCjDafHGNMArve2guPTYYoHUDO3sEaY=
Received: from DFLE201.ent.ti.com (dfle201.ent.ti.com [10.64.6.59])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59NBkHTH2680123
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Oct 2025 06:46:17 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 06:46:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 23 Oct 2025 06:46:16 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59NBk5hq2786743;
 Thu, 23 Oct 2025 06:46:13 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <a-nandan@ti.com>, <trini@konsulko.com>, <rfried.dev@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <s-vadapalli@ti.com>, <semen.protsenko@linaro.org>,
 <jm@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH 2/4] pci_endpoint: pci_cdns_ti_ep: Add SERDES mux
 configuration support
Date: Thu, 23 Oct 2025 17:16:02 +0530
Message-ID: <20251023114604.3655625-3-h-salunke@ti.com>
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

Probe the mux device early in the SERDES configuration flow to ensure
proper lane routing before PHY initialization. This is required for SoCs
where SERDES lanes can be muxed between different controllers
(PCIe, USB, etc), and different mux configurations are required between
different boot phases.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 drivers/pci_endpoint/pcie_cdns_ti_ep.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci_endpoint/pcie_cdns_ti_ep.c b/drivers/pci_endpoint/pcie_cdns_ti_ep.c
index 541616ab7d0..dd3dc939a7e 100644
--- a/drivers/pci_endpoint/pcie_cdns_ti_ep.c
+++ b/drivers/pci_endpoint/pcie_cdns_ti_ep.c
@@ -97,9 +97,20 @@ static int pcie_cdns_reset(struct udevice *dev, struct power_domain *pci_pwrdmn)
 
 static int pcie_cdns_config_serdes(struct udevice *dev)
 {
+	int ret;
+
+	if (CONFIG_IS_ENABLED(MUX_MMIO)) {
+		struct udevice *mux;
+
+		ret = uclass_get_device_by_seq(UCLASS_MUX, 0, &mux);
+		if (ret) {
+			dev_err(dev, "unable to get mux\n");
+			return ret;
+		}
+	}
+
 	if (CONFIG_IS_ENABLED(PHY_CADENCE_TORRENT)) {
 		struct phy serdes;
-		int ret = 7;
 
 		ret = generic_phy_get_by_name(dev,  "pcie-phy", &serdes);
 		if (ret != 0 && ret != -EBUSY) {
-- 
2.34.1

