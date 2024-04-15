Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61769C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 21:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED9D88274;
	Mon, 15 Apr 2024 23:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nQNCtLyh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E08258812F; Mon, 15 Apr 2024 23:27:54 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B9F8812F
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 23:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43FLRmsC000651;
 Mon, 15 Apr 2024 16:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713216468;
 bh=b2qKd1QOYj4vKpF4SUCh/9kl44XiyuhiAspGvGyG/mg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=nQNCtLyhmDHErK0FIlrGKI3EclCd4aKfeqWhKZCdNKaAKpE/QqgKhf8QpL3MaE4cI
 47SY7xWHa140TdTbwkSzzHUJaca7/a0esdrlRwl8sQZJkHLdzVtiOfbPTw0xqXLO0Y
 vrDrhsOITtQy0FwWVTcckai4M2kYGvILbuddkcLY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43FLRmtO067169
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 15 Apr 2024 16:27:48 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 16:27:47 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 16:27:47 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43FLRlu8070400;
 Mon, 15 Apr 2024 16:27:47 -0500
From: Judith Mendez <jm@ti.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>
CC: Nitin Yadav <n-yadav@ti.com>, Simon Glass <sjg@chromium.org>,
 <u-boot@lists.denx.de>
Subject: [PATCH 4/5] mmc: am654_sdhci: Set ENDLL=1 for DDR52 mode
Date: Mon, 15 Apr 2024 16:27:46 -0500
Message-ID: <20240415212747.2678974-5-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240415212747.2678974-1-jm@ti.com>
References: <20240415212747.2678974-1-jm@ti.com>
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

According to the device datasheet [0], ENDLL=1 for
DDR52 mode, so call am654_sdhci_setup_dll() and write
itapdly after since we do not carry out tuning.

[0] https://www.ti.com/lit/ds/symlink/am62p.pdf
Fixes: c964447ea3d6 ("mmc: am654_sdhci: Add support for input tap delay")
Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/am654_sdhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/am654_sdhci.c b/drivers/mmc/am654_sdhci.c
index 38f1ad28ec4..dee56dfdbaa 100644
--- a/drivers/mmc/am654_sdhci.c
+++ b/drivers/mmc/am654_sdhci.c
@@ -287,12 +287,14 @@ static int am654_sdhci_set_ios_post(struct sdhci_host *host)
 
 	regmap_update_bits(plat->base, PHY_CTRL4, mask, val);
 
-	if (mode > UHS_SDR25 && speed >= CLOCK_TOO_SLOW_HZ) {
+	if ((mode > UHS_SDR25 || mode == MMC_DDR_52) && speed >= CLOCK_TOO_SLOW_HZ) {
 		ret = am654_sdhci_setup_dll(plat, speed);
 		if (ret)
 			return ret;
 
 		plat->dll_enable = true;
+		am654_sdhci_write_itapdly(plat, plat->itap_del_sel[mode],
+					  plat->itap_del_ena[mode]);
 	} else {
 		am654_sdhci_setup_delay_chain(plat, mode);
 		plat->dll_enable = false;
-- 
2.43.2

