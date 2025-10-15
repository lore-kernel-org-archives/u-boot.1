Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33784CCD190
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 06:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C0818313B;
	Wed, 15 Oct 2025 08:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="Gf9Efq9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D67A68323A; Wed, 15 Oct 2025 08:33:53 +0200 (CEST)
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74B3680107
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 08:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GCATA22seekNI6YMNy0bbnJPu/RptgT52+DXecXWPfg=; b=Gf9Efq9xuymxaufmmjOED7SGB7
 pGfEzXcdfD9ill33yiVJPvpatRMXyEjQQnR5rAU+p+kImKSMYAfumDchRU6RyhstZcyN4NEsw5UFN
 Bk2qooq/eRVTl3WJ5Vd9yU2XV79GiOxyIBELdKumEZtUdLB7uwrUC3OrAxBVLgEv1pUeHkzXFl8QY
 HStoIaelg+OxsyrCapC9L8+ivwCybWG7hXwyhmmQOA94wP42nTArB6etESJGxt/3LNx/+rlP+JYlV
 efSdoEwOlbMssnVA755zFfLQs+U7oq6mGlCBE8v48DklYLVUWi8qvhOKJwxwyHAeD3hAfjG7SVloN
 7o3VmH9A==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:46388
 helo=localhost.localdomain)
 by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.2) (envelope-from <primoz.fiser@norik.com>)
 id 1v8v55-0000000HWWp-1ycC; Wed, 15 Oct 2025 08:33:48 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH] thermal: imx_tmu: Always set thermal trips from fuses
Date: Wed, 15 Oct 2025 08:33:47 +0200
Message-Id: <20251015063347.518171-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

NXP i.MX SoCs are available in different temperature grades. By default,
device-tree contains only thermal trips for consumer grade parts. On the
other hand, part temp grade fuse can be used to determine thermal trip
points. We already do this in imx_tmu_bind() function. Now, factor out
this functionality to a standalone function imx_tmu_set_trips() and use
it for both cases. This fixes an issue where 'cpu-thermal' child device
would set different thermal trips than the parent 'tmu@44482000' sensor,
depending on which gets used.

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 drivers/thermal/imx_tmu.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/imx_tmu.c b/drivers/thermal/imx_tmu.c
index 51a072e23c6c..c8389d507ee3 100644
--- a/drivers/thermal/imx_tmu.c
+++ b/drivers/thermal/imx_tmu.c
@@ -532,6 +532,16 @@ static int imx_tmu_enable_msite(struct udevice *dev)
 	return 0;
 }
 
+static void imx_tmu_set_trips(struct imx_tmu_plat *pdata)
+{
+	int minc, maxc;
+
+	/* default alert/crit temps based on temp grade */
+	get_cpu_temp_grade(&minc, &maxc);
+	pdata->critical = maxc * 1000;
+	pdata->alert = (maxc - 10) * 1000;
+}
+
 static int imx_tmu_bind(struct udevice *dev)
 {
 	struct imx_tmu_plat *pdata = dev_get_plat(dev);
@@ -539,7 +549,6 @@ static int imx_tmu_bind(struct udevice *dev)
 	ofnode node, offset;
 	const char *name;
 	const void *prop;
-	int minc, maxc;
 
 	dev_dbg(dev, "%s\n", __func__);
 
@@ -548,10 +557,7 @@ static int imx_tmu_bind(struct udevice *dev)
 		return 0;
 
 	pdata->zone_node = 1;
-	/* default alert/crit temps based on temp grade */
-	get_cpu_temp_grade(&minc, &maxc);
-	pdata->critical = maxc * 1000;
-	pdata->alert = (maxc - 10) * 1000;
+	imx_tmu_set_trips(pdata);
 
 	node = ofnode_path("/thermal-zones");
 	ofnode_for_each_subnode(offset, node) {
@@ -572,7 +578,7 @@ static int imx_tmu_parse_fdt(struct udevice *dev)
 {
 	struct imx_tmu_plat *pdata = dev_get_plat(dev), *p_parent_data;
 	struct ofnode_phandle_args args;
-	ofnode trips_np, cpu_thermal_np;
+	ofnode cpu_thermal_np;
 	int ret;
 
 	dev_dbg(dev, "%s\n", __func__);
@@ -612,20 +618,7 @@ static int imx_tmu_parse_fdt(struct udevice *dev)
 	pdata->polling_delay = dev_read_u32_default(dev, "polling-delay",
 						    IMX_TMU_POLLING_DELAY_MS);
 
-	trips_np = ofnode_path("/thermal-zones/cpu-thermal/trips");
-	ofnode_for_each_subnode(trips_np, trips_np) {
-		const char *type;
-
-		type = ofnode_get_property(trips_np, "type", NULL);
-		if (!type)
-			continue;
-		if (!strcmp(type, "critical"))
-			pdata->critical = ofnode_read_u32_default(trips_np, "temperature", 85);
-		else if (strcmp(type, "passive") == 0)
-			pdata->alert = ofnode_read_u32_default(trips_np, "temperature", 80);
-		else
-			continue;
-	}
+	imx_tmu_set_trips(pdata);
 
 	dev_dbg(dev, "id %d polling_delay %d, critical %d, alert %d\n",
 		pdata->id, pdata->polling_delay, pdata->critical, pdata->alert);
-- 
2.34.1

