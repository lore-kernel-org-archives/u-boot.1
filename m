Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E5CC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 10:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 195A38891A;
	Tue, 13 Aug 2024 12:54:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t4/UkWbO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8C6A88981; Tue, 13 Aug 2024 12:54:29 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41A3188916
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 12:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DAsFID110867;
 Tue, 13 Aug 2024 05:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723546455;
 bh=xIvupy4teGInp3vxVZDFT99GStOARoOJETb0ZNpnf3w=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=t4/UkWbOEDCKqcLqDWvDkDql0BTP6PRHi407OieH/e4xQW2Gk3RlWy2I4sBIs9uBC
 v9gb6ZJ4Lr4LcWA6XXCrw0o8NE1TvnAERiLOXnjD3Qqt011xaZf/K9FLi1Ij/Ns35I
 J5AajM+wJTnBFQ4LmK26eI9Xreapca7+JZi0iW1U=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DAsFFN071812
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Aug 2024 05:54:15 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 05:54:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 05:54:14 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DAsDdZ075491;
 Tue, 13 Aug 2024 05:54:14 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, =?UTF-8?q?Marek=20Beh=C3=BAn?=
 <kabel@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Neha
 Malcom Francis" <n-francis@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Ravi Gunasekaran
 <r-gunasekaran@ti.com>, Udit Kumar <u-kumar1@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Jonas Karlman <jonas@kwiboo.se>, "Devarsh Thakkar" <devarsht@ti.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Davis <afd@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Wadim Egorov <w.egorov@phytec.de>, Dhruva Gole
 <d-gole@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 "Nishanth Menon" <nm@ti.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Kishon Vijay Abraham I <kishon@ti.com>, "Chintan
 Vankar" <c-vankar@ti.com>
Subject: [PATCH v5 03/10] soc: ti: k3-navss-ringacc: Initialize base address
 of ring cfg registers
Date: Tue, 13 Aug 2024 16:23:53 +0530
Message-ID: <20240813105400.4054657-4-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813105400.4054657-1-c-vankar@ti.com>
References: <20240813105400.4054657-1-c-vankar@ti.com>
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

Link to v4:
https://lore.kernel.org/r/20240812114746.3843395-1-c-vankar@ti.com/

Changes from v4 to v5:
- No Changes.

 drivers/soc/ti/k3-navss-ringacc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
index b2643a30d3d..14114a65830 100644
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

