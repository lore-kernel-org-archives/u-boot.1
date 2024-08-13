Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20586C52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 10:56:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D9B8889B4;
	Tue, 13 Aug 2024 12:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BwcWyhFi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3355988747; Tue, 13 Aug 2024 12:54:45 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD9E889C3
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 12:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DAsHko099591;
 Tue, 13 Aug 2024 05:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723546457;
 bh=UTM++YMopMqBNgLG932pWwg7E24Nd61P00sK7F2fICA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=BwcWyhFiIRhTuvCUBTVw2642HCDFfLUtdaRd6teMyZMawKdtR5pfnH1bGHVhhKjx7
 YOMljRKrhVoEdZivij7H4ijQHT7tQtBRTa6Rsy1uib6A51bSZ2tukoyxZ8ARQeqR62
 2I7qWKM5jS2KQJ5HvbELcT42awJTo0WQMrE9GapI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DAsH5I071823
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Aug 2024 05:54:17 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 05:54:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 05:54:17 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DAsGl3075547;
 Tue, 13 Aug 2024 05:54:17 -0500
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
Subject: [PATCH v5 05/10] dma: ti: k3-udma: Add support for native
 configuration of chan/flow
Date: Tue, 13 Aug 2024 16:23:55 +0530
Message-ID: <20240813105400.4054657-6-c-vankar@ti.com>
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

In absence of Device Manager (DM) services such as at R5 SPL stage,
driver will have to natively setup TCHAN/RCHAN/RFLOW cfg registers.
Existing UDMA driver performed the above mentioned configuration
for UDMA. Add similar configuration for PKTDMA here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v4:
https://lore.kernel.org/r/20240812114842.3843676-1-c-vankar@ti.com/

Changes from v4 to v5:
- No Changes.

 drivers/dma/ti/k3-udma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index b7e674f2186..e23d09e6b81 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2118,6 +2118,9 @@ static int bcdma_tisci_tx_channel_config(struct udma_chan *uc)
 	if (ret)
 		dev_err(ud->dev, "tchan%d cfg failed %d\n", tchan->id, ret);
 
+	if (IS_ENABLED(CONFIG_K3_DM_FW))
+		udma_alloc_tchan_raw(uc);
+
 	return ret;
 }
 
@@ -2166,6 +2169,9 @@ static int pktdma_tisci_rx_channel_config(struct udma_chan *uc)
 		dev_err(ud->dev, "flow%d config failed: %d\n", uc->rflow->id,
 			ret);
 
+	if (IS_ENABLED(CONFIG_K3_DM_FW))
+		udma_alloc_rchan_raw(uc);
+
 	return ret;
 }
 
-- 
2.34.1

