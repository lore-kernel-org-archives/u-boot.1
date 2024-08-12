Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E52C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 11:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4480C884C3;
	Mon, 12 Aug 2024 13:48:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ydtSZ08k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 458318861A; Mon, 12 Aug 2024 13:48:03 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D175887B77
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 13:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47CBlnGQ022779;
 Mon, 12 Aug 2024 06:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723463269;
 bh=x3bORG/lx1guFYd8vpCBRXIaUVvxP/inrgMLfPLnEj8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ydtSZ08khMUiDummcTRL5Jr9oaJz6+ChtVb8er8PkRNrQQsOyd7GvcltSqEeM9zbU
 H7YYJERF2v/z8NiCTYj/f+pKM81wyP5HK9OEJPSriHefgIlZBBUIpIpdbG508/J1nT
 UNhMx/obgQ73QohHUSk2gxOVMDqvZOWp6RN1TSlI=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47CBlnlG008664
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 12 Aug 2024 06:47:49 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Aug 2024 06:47:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Aug 2024 06:47:48 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47CBlm9T128755;
 Mon, 12 Aug 2024 06:47:48 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 "MD Danish Anwar" <danishanwar@ti.com>, Ravi
 Gunasekaran <r-gunasekaran@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>, Sean
 Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Kishon Vijay
 Abraham I <kishon@ti.com>, Andrew Davis <afd@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Dhruva Gole <d-gole@ti.com>, Chintan Vankar
 <c-vankar@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Nishanth Menon <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v4 03/10] soc: ti: k3-navss-ringacc: Initialize base address
 of ring cfg registers
Date: Mon, 12 Aug 2024 17:17:46 +0530
Message-ID: <20240812114746.3843395-1-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812113621.3840652-1-c-vankar@ti.com>
References: <20240812113621.3840652-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

From: Kishon Vijay Abraham I <kishon@ti.com>

Initialize base address of ring config registers required to natively
setup ring cfg registers in the absence of Device Manager (DM) services
at R5 SPL stage. Since register property is defined as "ring" for PKTDMA
and "cfg" for UDMA, configure base address of ring configuration register
accordingly.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v3:
https://lore.kernel.org/r/20240705045030.1141934-4-c-vankar@ti.com/

Changes from v3 to v4:
- No changes.

 drivers/soc/ti/k3-navss-ringacc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
index b2643a30d3..14114a6583 100644
--- a/drivers/soc/ti/k3-navss-ringacc.c
+++ b/drivers/soc/ti/k3-navss-ringacc.c
@@ -1028,8 +1028,8 @@ static int k3_nav_ringacc_init(struct udevice *dev, struct k3_nav_ringacc *ringa
 struct k3_nav_ringacc *k3_ringacc_dmarings_init(struct udevice *dev,
 						struct k3_ringacc_init_data *data)
 {
+	void __iomem *base_rt, *base_cfg;
 	struct k3_nav_ringacc *ringacc;
-	void __iomem *base_rt;
 	int i;
 
 	ringacc = devm_kzalloc(dev, sizeof(*ringacc), GFP_KERNEL);
@@ -1047,6 +1047,20 @@ struct k3_nav_ringacc *k3_ringacc_dmarings_init(struct udevice *dev,
 	if (!base_rt)
 		return ERR_PTR(-EINVAL);
 
+	/*
+	 * Since register property is defined as "ring" for PKTDMA and
+	 * "cfg" for UDMA, configure base address of ring configuration
+	 * register accordingly.
+	 */
+	base_cfg = dev_remap_addr_name(dev, "ring");
+	pr_debug("ring %p\n", base_cfg);
+	if (!base_cfg) {
+		base_cfg = dev_remap_addr_name(dev, "cfg");
+		pr_debug("cfg %p\n", base_cfg);
+		if (!base_cfg)
+			return ERR_PTR(-EINVAL);
+	}
+
 	ringacc->rings = devm_kzalloc(dev,
 				      sizeof(*ringacc->rings) *
 				      ringacc->num_rings * 2,
@@ -1061,6 +1075,7 @@ struct k3_nav_ringacc *k3_ringacc_dmarings_init(struct udevice *dev,
 	for (i = 0; i < ringacc->num_rings; i++) {
 		struct k3_nav_ring *ring = &ringacc->rings[i];
 
+		ring->cfg = base_cfg + KNAV_RINGACC_CFG_REGS_STEP * i;
 		ring->rt = base_rt + K3_DMARING_RING_RT_REGS_STEP * i;
 		ring->parent = ringacc;
 		ring->ring_id = i;
-- 
2.34.1

