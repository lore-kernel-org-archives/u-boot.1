Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64343C4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 06:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A113F8798F;
	Fri, 12 Jan 2024 07:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SbV2oWvT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A455C8799E; Fri, 12 Jan 2024 07:48:17 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92C668798E
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 07:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40C6mDsO094674;
 Fri, 12 Jan 2024 00:48:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705042093;
 bh=d9u/AqpZqs0n0x1J4sUr6VdO43UBVu6Xsme13IIbkg0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=SbV2oWvTFAAB6MicdfSBN6C/ZipfFIRX5VRfPv6MkOLbP4UPnlHYXt2h0qMruw+9/
 VLV2DtjwiU7O6HVUSUYOLcxudlP4r2BFYhfCZiBEntZnhtcpY5OqbDfFBvP9wcrlDe
 13gaBJCNssb97ddJudUYRK/xJAjQbixr7mRvo4rU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40C6mDH9071742
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 00:48:13 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 00:48:12 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 00:48:12 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40C6lxsA063681; 
 Fri, 12 Jan 2024 00:48:10 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <sjg@chromium.org>, <afd@ti.com>,
 <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: [PATCH 03/10] soc: ti: k3-navss-ringacc: Initialize base address of
 ring cfg registers
Date: Fri, 12 Jan 2024 12:17:52 +0530
Message-ID: <20240112064759.1801600-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240112064759.1801600-1-s-vadapalli@ti.com>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
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
at R5 SPL stage.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/soc/ti/k3-navss-ringacc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
index 7a2fbb0db6..31e9b372ee 100644
--- a/drivers/soc/ti/k3-navss-ringacc.c
+++ b/drivers/soc/ti/k3-navss-ringacc.c
@@ -1030,8 +1030,8 @@ static int k3_nav_ringacc_init(struct udevice *dev, struct k3_nav_ringacc *ringa
 struct k3_nav_ringacc *k3_ringacc_dmarings_init(struct udevice *dev,
 						struct k3_ringacc_init_data *data)
 {
+	void __iomem *base_rt, *base_cfg;
 	struct k3_nav_ringacc *ringacc;
-	void __iomem *base_rt;
 	int i;
 
 	ringacc = devm_kzalloc(dev, sizeof(*ringacc), GFP_KERNEL);
@@ -1049,6 +1049,10 @@ struct k3_nav_ringacc *k3_ringacc_dmarings_init(struct udevice *dev,
 	if (!base_rt)
 		return ERR_PTR(-EINVAL);
 
+	base_cfg = dev_read_addr_name_ptr(dev, "cfg");
+	if (!base_cfg)
+		return ERR_PTR(-EINVAL);
+
 	ringacc->rings = devm_kzalloc(dev,
 				      sizeof(*ringacc->rings) *
 				      ringacc->num_rings * 2,
@@ -1063,6 +1067,7 @@ struct k3_nav_ringacc *k3_ringacc_dmarings_init(struct udevice *dev,
 	for (i = 0; i < ringacc->num_rings; i++) {
 		struct k3_nav_ring *ring = &ringacc->rings[i];
 
+		ring->cfg = base_cfg + KNAV_RINGACC_CFG_REGS_STEP * i;
 		ring->rt = base_rt + K3_DMARING_RING_RT_REGS_STEP * i;
 		ring->parent = ringacc;
 		ring->ring_id = i;
-- 
2.34.1

