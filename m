Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72594C4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 12:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E45DD88F21;
	Thu, 25 Apr 2024 14:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IokFyduG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23FD88F19; Thu, 25 Apr 2024 14:09:06 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77CB488F04
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 14:09:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PC8rO7033727;
 Thu, 25 Apr 2024 07:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714046933;
 bh=xWZAT8LlciMwCWo9f1J/WfDcB7z3jyU/uztlDacHtas=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=IokFyduGPAhAUryjuwZMhN7yrDjblENu7Dbjpac2SC+gme0V8jfIYUCp6sTe5mXph
 KJmBuGG8OFg9my4lf0Jk7qhD0gVSAs6yisVubNRcryVFU9pDjPEPsRC67pwCZUy1i3
 o1jPkVQwhp2MKxn2kwFbQuqKtzoujgjvdt2eK0rE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PC8r48011715
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Apr 2024 07:08:53 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 07:08:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 07:08:52 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PC8pKm037358;
 Thu, 25 Apr 2024 07:08:52 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Vignesh Raghavendra <vigneshr@ti.com>, "MD Danish
 Anwar" <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Devarsh Thakkar <devarsht@ti.com>, Bin Meng <bmeng@tinylab.org>, "Sean
 Anderson" <seanga2@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Nikhil M Jain" <n-jain1@ti.com>, Wadim Egorov <w.egorov@phytec.de>, "Joao
 Paulo Goncalves" <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Chintan Vankar <c-vankar@ti.com>, Dhruva Gole
 <d-gole@ti.com>, Francesco Dolcini <francesco.dolcini@toradex.com>, "Andrew
 Davis" <afd@ti.com>, Roger Quadros <rogerq@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Neha Malcom Francis <n-francis@ti.com>, Simon Glass
 <sjg@chromium.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v2 03/10] soc: ti: k3-navss-ringacc: Initialize base address
 of ring cfg registers
Date: Thu, 25 Apr 2024 17:38:15 +0530
Message-ID: <20240425120822.2048012-4-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425120822.2048012-1-c-vankar@ti.com>
References: <20240425120822.2048012-1-c-vankar@ti.com>
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
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v1:
https://lore.kernel.org/r/20240112064759.1801600-4-s-vadapalli@ti.com/

Changes from v1 to v2:
- No changes.

 drivers/soc/ti/k3-navss-ringacc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-navss-ringacc.c b/drivers/soc/ti/k3-navss-ringacc.c
index ed39ff2fa4..0a96ed666c 100644
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

