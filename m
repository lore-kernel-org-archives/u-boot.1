Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291F6C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 09:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D5D383B27;
	Thu, 10 Apr 2025 11:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="FwgtMkpN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B64D983B05; Thu, 10 Apr 2025 11:01:41 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A574483AE9
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 11:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1u2nn0-0007c4-FU; Thu, 10 Apr 2025 05:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:References:In-Reply-To:Date:Subject:To:
 From; bh=X6wnrp36lUWLTI+fcCdKoaWSzcsFvmtv5CNZOtVjVRs=; b=FwgtMkpNqOpo8mpKBXs2
 Sc9K2AA1kXcEnRmgyVzogsPwPi9wpRtYOL1yd95itz6b+q82q8mltl7ATSU+h8sMaIJ+DAuXDIF3K
 k3Wy1mDd73/zDbM23m8IFpjVKyQMhQkT0UPEmim3kW5fvbLGx24p0u1iDQSGTANan5DJom5nbxk6y
 BBPYu8NUSMiAtmgl4EVu+uy3SYjD4REYjyY6VkMGscee93UW8bpVu1KiBNY2jeT4g133/1aXnJBeU
 KdsVDd3eS+92QU1/p6hBjo1sr+tlmP80ZwXQtn92f7CY087AxLJjdiDk4qWW7od0zLxjCdBdfDhYp
 ShQL+rPe/Nzb+w==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
 u-boot@lists.denx.de, regis.ray@landisgyr.com, pascal.dupuis@landisgyr.com,
 Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH 2/2] mmc: omap_hsmmc: implement send_init_stream callback
Date: Thu, 10 Apr 2025 11:00:21 +0200
Message-ID: <20250410090021.14446-3-othacehe@gnu.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250410090021.14446-1-othacehe@gnu.org>
References: <20250410090021.14446-1-othacehe@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This callback is used to send the 74 clock cycles after power up.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 drivers/mmc/omap_hsmmc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/omap_hsmmc.c b/drivers/mmc/omap_hsmmc.c
index e66ab25d02a..92bc72b267c 100644
--- a/drivers/mmc/omap_hsmmc.c
+++ b/drivers/mmc/omap_hsmmc.c
@@ -780,6 +780,14 @@ tuning_error:
 	return ret;
 }
 #endif
+
+static void omap_hsmmc_send_init_stream(struct udevice *dev)
+{
+	struct omap_hsmmc_data *priv = dev_get_priv(dev);
+	struct hsmmc *mmc_base = priv->base_addr;
+
+	mmc_init_stream(mmc_base);
+}
 #endif
 
 static void mmc_enable_irq(struct mmc *mmc, struct mmc_cmd *cmd)
@@ -1515,9 +1523,10 @@ static const struct dm_mmc_ops omap_hsmmc_ops = {
 	.get_wp		= omap_hsmmc_getwp,
 #endif
 #if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
-	.execute_tuning = omap_hsmmc_execute_tuning,
+	.execute_tuning    = omap_hsmmc_execute_tuning,
 #endif
-	.wait_dat0	= omap_hsmmc_wait_dat0,
+	.send_init_stream  = omap_hsmmc_send_init_stream,
+	.wait_dat0	   = omap_hsmmc_wait_dat0,
 };
 #else
 static const struct mmc_ops omap_hsmmc_ops = {
-- 
2.47.1

