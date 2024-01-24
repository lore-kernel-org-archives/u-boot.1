Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86A5C47DDF
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 12:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F6C587C66;
	Wed, 24 Jan 2024 13:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qtwTaLzc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6392F87BBA; Wed, 24 Jan 2024 07:49:59 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55F5487BE8
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 07:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40O6ncto046242;
 Wed, 24 Jan 2024 00:49:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706078978;
 bh=vu8KjV24vjq7BffiG1/1xHaK2er2ksotIvKTZ8mjc8Q=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=qtwTaLzc0ArQVc66MRq7Dm7fXCGUZyqofGjJs12zl/TiAua6NTclaOm1FtBB7HDDs
 fDEalaASx8od7D7DPF5/U9drOsRqLKsMDT1gBUBtnWNlbsBsEEuO2z1fYRCDQQ97v3
 qMJpB/VxdvSGULPkgaYcLicTpCkHt9tbrBmu1bgg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40O6nb9l068639
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 00:49:37 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 00:49:37 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 00:49:37 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
 by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40O6nbH3059687;
 Wed, 24 Jan 2024 00:49:37 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 40O6na5Y024463;
 Wed, 24 Jan 2024 00:49:37 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>, Bryan Brattlof
 <bb@ti.com>, Sean Anderson <seanga2@gmail.com>, Martyn Welch
 <martyn.welch@collabora.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Simon
 Glass <sjg@chromium.org>, MD Danish Anwar <danishanwar@ti.com>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Christian Hewitt <christianshewitt@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Jonas
 Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Kever Yang <kever.yang@rock-chips.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH v3 01/15] dma: ti: k3-udma: Use ring_idx to pair k3 nav
 rings
Date: Wed, 24 Jan 2024 12:19:16 +0530
Message-ID: <20240124064930.1787929-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124064930.1787929-1-danishanwar@ti.com>
References: <20240124064930.1787929-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 24 Jan 2024 13:42:05 +0100
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

Use ring_idx to pair rings. ring_idx will be same as tx flow_id for all
non-negative flow_ids. For negative flow_ids, ring_idx will be tchan->id
added with bchan_cnt.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/dma/ti/k3-udma.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 8a62d63dfe..eea9ec9659 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -876,13 +876,20 @@ static int udma_alloc_tx_resources(struct udma_chan *uc)
 {
 	struct k3_nav_ring_cfg ring_cfg;
 	struct udma_dev *ud = uc->ud;
-	int ret;
+	struct udma_tchan *tchan;
+	int ring_idx, ret;
 
 	ret = udma_get_tchan(uc);
 	if (ret)
 		return ret;
 
-	ret = k3_nav_ringacc_request_rings_pair(ud->ringacc, uc->tchan->id, -1,
+	tchan = uc->tchan;
+	if (tchan->tflow_id >= 0)
+		ring_idx = tchan->tflow_id;
+	else
+		ring_idx = ud->bchan_cnt + tchan->id;
+
+	ret = k3_nav_ringacc_request_rings_pair(ud->ringacc, ring_idx, -1,
 						&uc->tchan->t_ring,
 						&uc->tchan->tc_ring);
 	if (ret) {
-- 
2.34.1

