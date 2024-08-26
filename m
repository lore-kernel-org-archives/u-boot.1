Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6784EC5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 10:26:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8361888AB2;
	Mon, 26 Aug 2024 12:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bzfRsX/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BD9B88AFB; Mon, 26 Aug 2024 12:25:45 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 083C388A2E
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QAPU5p129913;
 Mon, 26 Aug 2024 05:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1724667930;
 bh=kJHAhW/az0+CwPh7y/dJ2g/LfT0pWai17qFwZlubHy0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=bzfRsX/v/9Am/SgpibITWC7TpL9xLgR0kZGogo2p+1W46kRQm9+VnOYRjKY5ws7T6
 aVCTsot9NG914GH3zsYqYvN9xCUhMr7ZMWIWv5c4Tyt4/zO/te97nv9XP17Js+dd5L
 4FFeEzLFBzF9GissSGzH7QZd8nps9ijAISbl052Y=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QAPUpx015101
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Aug 2024 05:25:30 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 05:25:30 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 05:25:30 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QAPTT6040605;
 Mon, 26 Aug 2024 05:25:30 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Michal Simek <michal.simek@amd.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Dhruva Gole <d-gole@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Matthias Schiffer" <matthias.schiffer@ew.tq-group.com>, Andreas Dannenberg
 <dannenberg@ti.com>, Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar
 <devarsht@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>, Sean Anderson
 <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, Kishon Vijay Abraham I
 <kishon@ti.com>, Andrew Davis <afd@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Wadim Egorov <w.egorov@phytec.de>, "Chintan
 Vankar" <c-vankar@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v6 05/11] soc: ti: k3-navss-ringacc: Fix reconfiguration of
 qmode API
Date: Mon, 26 Aug 2024 15:55:09 +0530
Message-ID: <20240826102515.2774296-6-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826102515.2774296-1-c-vankar@ti.com>
References: <20240826102515.2774296-1-c-vankar@ti.com>
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

Function "k3_ringacc_ring_reconfig_qmode_raw()" should reset qmode to
requested value and should not update other fields in ring configuration
register.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is newely added in this series.

 drivers/soc/ti/k3-navss-ringacc-u-boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-navss-ringacc-u-boot.c b/drivers/soc/ti/k3-navss-ringacc-u-boot.c
index 2799f214c77..8227d8bc3e3 100644
--- a/drivers/soc/ti/k3-navss-ringacc-u-boot.c
+++ b/drivers/soc/ti/k3-navss-ringacc-u-boot.c
@@ -42,7 +42,7 @@ static void k3_ringacc_ring_reconfig_qmode_raw(struct k3_nav_ring *ring, enum k3
 	u32 val;
 
 	val = readl(&ring->cfg->size);
-	val &= KNAV_RINGACC_CFG_RING_SIZE_QMODE_MASK;
+	val &= ~KNAV_RINGACC_CFG_RING_SIZE_QMODE_MASK;
 	val |= mode << KNAV_RINGACC_CFG_RING_SIZE_QMODE_SHIFT;
 	writel(val, &ring->cfg->size);
 }
-- 
2.34.1

