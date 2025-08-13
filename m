Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28102CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 23:22:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A4E683775;
	Thu, 14 Aug 2025 01:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kkRY4Blx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3674837B9; Wed, 13 Aug 2025 23:47:13 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD39E83775
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 23:47:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hnagalla@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DLl87P1789439;
 Wed, 13 Aug 2025 16:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755121628;
 bh=BDft3S5kQb7Td1+lHeDKZyT1Y+dMknoY0i+wCIJr4oo=;
 h=From:To:CC:Subject:Date;
 b=kkRY4Blx+WCCs4dkRtWNWXOA/hQ+dXSJwpKi+rynYn53aYwFZUovsJLCVps1rdNRR
 PFwkWa4BSYwVeHai314Rk+TtT5pDgVfNhwv865mFEF7F0oM6Xg1CqItitTngXCEt4X
 8xUmY7UG+05kNflleo38lDZGkuwI53UnjZrXixuM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DLl8KG356348
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 13 Aug 2025 16:47:08 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 16:47:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 16:47:08 -0500
Received: from localhost ([10.249.48.175])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DLl8YW2921933;
 Wed, 13 Aug 2025 16:47:08 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <trini@konsulko.com>
CC: <vigneshr@ti.com>, <afd@ti.com>, <b-padhi@ti.com>, <jm@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>, Hari Nagalla <hnagalla@ti.com>
Subject: [PATCH] remoteproc: k3-r5: Add support for single cpu mode
Date: Wed, 13 Aug 2025 16:47:05 -0500
Message-ID: <20250813214705.12774-1-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Thu, 14 Aug 2025 01:22:55 +0200
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

Add early boot support for AM64 single cpu mode configuration.
In single CPU mode the 2nd core of the R5F cluster can't be used or
unavailable.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
logs: https://paste.sr.ht/~hnagalla/d8a941e1949c2558e10cf28bcb91c0dfa73ef037

 drivers/remoteproc/ti_k3_r5f_rproc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index f4bab6868ee..2986e5ccad7 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -233,7 +233,7 @@ static int k3_r5f_prepare(struct udevice *dev)
 
 	dev_dbg(dev, "%s\n", __func__);
 
-	if (cluster->mode == CLUSTER_MODE_LOCKSTEP)
+	if ((cluster->mode == CLUSTER_MODE_LOCKSTEP) || (cluster->mode == CLUSTER_MODE_SINGLECPU))
 		ret = k3_r5f_lockstep_release(cluster);
 	else
 		ret = k3_r5f_split_release(core);
@@ -269,6 +269,13 @@ static int k3_r5f_core_sanity_check(struct k3_r5f_core *core)
 		return -EINVAL;
 	}
 
+	if (cluster->mode == CLUSTER_MODE_SINGLECPU && !is_primary_core(core)) {
+		dev_err(core->dev,
+			"Invalid op: Trying to start secondary core %d in single CPU mode\n",
+			core->tsp.proc_id);
+		return -EINVAL;
+	}
+
 	if (cluster->mode == CLUSTER_MODE_SPLIT && !is_primary_core(core)) {
 		if (!core->cluster->cores[0]->in_use) {
 			dev_err(core->dev,
@@ -768,7 +775,7 @@ static void k3_r5f_core_adjust_tcm_sizes(struct k3_r5f_core *core)
 {
 	struct k3_r5f_cluster *cluster = core->cluster;
 
-	if (cluster->mode == CLUSTER_MODE_LOCKSTEP)
+	if ((cluster->mode == CLUSTER_MODE_LOCKSTEP) || (cluster->mode == CLUSTER_MODE_SINGLECPU))
 		return;
 
 	if (!core->ipdata->tcm_is_double)
-- 
2.34.1

