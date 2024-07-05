Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855F8C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 04:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 900E48860B;
	Fri,  5 Jul 2024 06:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CSt634/A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6877F8860C; Fri,  5 Jul 2024 06:50:57 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF9BD87D14
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 06:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4654obfl112770;
 Thu, 4 Jul 2024 23:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720155037;
 bh=A6rYlmIbPLl1fz06mtsAwm3mBE2m0Q9j/sOIKpNgiA0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=CSt634/ATT958i0mdHKUu5x4Jor/myu/8oyscVfgqLdk0MJruePNcyZeYBTvU6kaJ
 rG9hUPC4tqD9iLwsqAtGw68Y/2oDPo49r7Lo9+u9iCc2k9LVUCpUuNIWXMPeeTbYPM
 hSpCezRRB/cglS6g5Yc56dOVDh4UsRiPh1d2xGkQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4654obNE006537
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Jul 2024 23:50:37 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Jul 2024 23:50:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Jul 2024 23:50:37 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4654oa6V032608;
 Thu, 4 Jul 2024 23:50:37 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, Bryan Brattlof <bb@ti.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Udit Kumar <u-kumar1@ti.com>, Matthias Schiffer
 <matthias.schiffer@ew.tq-group.com>,
 Andreas Dannenberg <dannenberg@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar <devarsht@ti.com>, "Sean
 Anderson" <seanga2@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>,
 "Nikhil M Jain" <n-jain1@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Wadim Egorov <w.egorov@phytec.de>, Chintan
 Vankar <c-vankar@ti.com>, "Sjoerd Simons" <sjoerd@collabora.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dhruva Gole <d-gole@ti.com>, "Simon
 Glass" <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>, Maxime Ripard
 <mripard@kernel.org>, Nishanth Menon <nm@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <srk@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v3 02/10] firmware: ti_sci: Add No-OP for "RX_FL_CFG"
Date: Fri, 5 Jul 2024 10:20:22 +0530
Message-ID: <20240705045030.1141934-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705045030.1141934-1-c-vankar@ti.com>
References: <20240705045030.1141934-1-c-vankar@ti.com>
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

RX_FL_CFG message should not be forwarded to TIFS and should be
handled within R5 SPL (when DM services are not available). Add
a no-op function to not handle RX_FL_CFG messages.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v2:
https://lore.kernel.org/r/20240425120822.2048012-3-c-vankar@ti.com/

Changes from v2 to v3:
- No changes.

 drivers/firmware/ti_sci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 8ce0f46e70..346656c028 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2451,6 +2451,12 @@ fail:
 	return ret;
 }
 
+static int ti_sci_cmd_rm_udmap_rx_flow_cfg_noop(const struct ti_sci_handle *handle,
+						const struct ti_sci_msg_rm_udmap_flow_cfg *params)
+{
+	return 0;
+}
+
 /**
  * ti_sci_cmd_set_fwl_region() - Request for configuring a firewall region
  * @handle:    pointer to TI SCI handle
@@ -2896,7 +2902,7 @@ static __maybe_unused int ti_sci_dm_probe(struct udevice *dev)
 	udmap_ops = &ops->rm_udmap_ops;
 	udmap_ops->tx_ch_cfg = ti_sci_cmd_rm_udmap_tx_ch_cfg;
 	udmap_ops->rx_ch_cfg = ti_sci_cmd_rm_udmap_rx_ch_cfg;
-	udmap_ops->rx_flow_cfg = ti_sci_cmd_rm_udmap_rx_flow_cfg;
+	udmap_ops->rx_flow_cfg = ti_sci_cmd_rm_udmap_rx_flow_cfg_noop;
 
 	return ret;
 }
-- 
2.34.1

