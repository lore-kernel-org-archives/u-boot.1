Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B53FC5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 10:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 242F288A5F;
	Mon, 26 Aug 2024 12:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="htbh0Va5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C72288AB1; Mon, 26 Aug 2024 12:25:44 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B655587FA7
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 12:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QAPT9s001356;
 Mon, 26 Aug 2024 05:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1724667929;
 bh=IROkLeokncTgqtzu4BhXBBsfrS+UpO8y7HVxeLVcHR0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=htbh0Va5D00keBwBLHNcFbluS7/A0zfnDyYEFihfY+Ubgf6UR4cvJJ57XpzeIM8Wn
 2B/0kNjT178TPx6uUeM8/JQAT9Ji9zRDUtlEZXBaH+5NJHU4EutXytyHh6KzekHv7f
 O+NUIWUwKjp/p6VAojee3vF5ZMfA/rm2srEwOC4w=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QAPTsc084134
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Aug 2024 05:25:29 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 05:25:28 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 05:25:28 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QAPS9V041809;
 Mon, 26 Aug 2024 05:25:28 -0500
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
Subject: [PATCH v6 04/11] soc: ti: k3-navss-ringacc: Fix reset ring API
Date: Mon, 26 Aug 2024 15:55:08 +0530
Message-ID: <20240826102515.2774296-5-c-vankar@ti.com>
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

From: Vignesh Raghavendra <vigneshr@ti.com>

Expectation of k3_ringacc_ring_reset_raw() is to reset the ring to
requested size and not to 0. Fix this.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Link to v5:
https://lore.kernel.org/r/20240813105400.4054657-5-c-vankar@ti.com/

Changes from v5 to v6:
- Updated function "k3_ringacc_ring_reset_raw" to reset only ring
  size field in ring configuration register as pointed out by Alexander
  Sverdlin.

 drivers/soc/ti/k3-navss-ringacc-u-boot.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-navss-ringacc-u-boot.c b/drivers/soc/ti/k3-navss-ringacc-u-boot.c
index f958239c2af..2799f214c77 100644
--- a/drivers/soc/ti/k3-navss-ringacc-u-boot.c
+++ b/drivers/soc/ti/k3-navss-ringacc-u-boot.c
@@ -25,9 +25,16 @@ struct k3_nav_ring_cfg_regs {
 #define KNAV_RINGACC_CFG_RING_SIZE_ELSIZE_MASK		GENMASK(26, 24)
 #define KNAV_RINGACC_CFG_RING_SIZE_ELSIZE_SHIFT		(24)
 
+#define KNAV_RINGACC_CFG_RING_SIZE_MASK			GENMASK(19, 0)
+
 static void k3_ringacc_ring_reset_raw(struct k3_nav_ring *ring)
 {
-	writel(0, &ring->cfg->size);
+	u32 reg;
+
+	reg = readl(&ring->cfg->size);
+	reg &= ~KNAV_RINGACC_CFG_RING_SIZE_MASK;
+	reg |= ring->size;
+	writel(reg, &ring->cfg->size);
 }
 
 static void k3_ringacc_ring_reconfig_qmode_raw(struct k3_nav_ring *ring, enum k3_nav_ring_mode mode)
-- 
2.34.1

