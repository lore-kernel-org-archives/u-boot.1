Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01ED3C10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 14:21:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD57A8812F;
	Thu,  9 May 2024 16:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TwBA/w4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1018C88074; Thu,  9 May 2024 16:20:50 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60CDC88074
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 16:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hnagalla@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 449EKiEZ124646;
 Thu, 9 May 2024 09:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715264444;
 bh=QO5uG8YpNc+iPyPN+9mF/OE3S3mnQsj54R3LDkEZOfI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=TwBA/w4t/an/WwsgjKgbO7qYPHrjr8aj+YRje34pichJ4Jgl0A7qtqhKc0KvgY8Es
 qhXMTehxPCvWyiv2+pcYCSIqRpmaIt1PlLk3M0RkqQfxCRAIxiIgBJLU+tFltSb+rq
 DJFIGEiz92Y4535erqpkPm4OI0MbbaeLbei0qRys=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 449EKiZg059606
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 09:20:44 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 09:20:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 09:20:44 -0500
Received: from localhost ([10.250.32.135])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 449EKiYq075433;
 Thu, 9 May 2024 09:20:44 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <devarsht@ti.com>, <afd@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [PATCH 2/4] remoteproc: k3-r5: Add support for R5F core on AM62A SoCs
Date: Thu, 9 May 2024 09:20:35 -0500
Message-ID: <20240509142037.32064-3-hnagalla@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240509142037.32064-1-hnagalla@ti.com>
References: <20240509142037.32064-1-hnagalla@ti.com>
MIME-Version: 1.0
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

AM62A has a R5F core in MCU voltage domain.
Extend support for R5F remote proc driver on AM62A with compatible
strings.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 drivers/remoteproc/ti_k3_r5f_rproc.c | 29 ++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index 631e548dcc..35835b2d61 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -40,6 +40,8 @@
 #define PROC_BOOT_CFG_FLAG_GEN_IGN_BOOTVECTOR		0x10000000
 /* Available from J7200 SoCs onwards */
 #define PROC_BOOT_CFG_FLAG_R5_MEM_INIT_DIS		0x00004000
+#define PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE		0x00008000
+
 
 /* R5 TI-SCI Processor Control Flags */
 #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT		0x00000001
@@ -55,6 +57,8 @@
 enum cluster_mode {
 	CLUSTER_MODE_SPLIT = 0,
 	CLUSTER_MODE_LOCKSTEP,
+	CLUSTER_MODE_SINGLECPU,
+	CLUSTER_MODE_SINGLECORE,
 };
 
 /**
@@ -65,6 +69,7 @@ enum cluster_mode {
 struct k3_r5f_ip_data {
 	bool tcm_is_double;
 	bool tcm_ecc_autoinit;
+	bool is_single_core;
 };
 
 /**
@@ -599,8 +604,10 @@ static int k3_r5f_rproc_configure(struct k3_r5f_core *core)
 	/* Sanity check for Lockstep mode */
 	lockstep_permitted = !!(sts &
 				PROC_BOOT_STATUS_FLAG_R5_LOCKSTEP_PERMITTED);
-	if (cluster->mode && is_primary_core(core) && !lockstep_permitted) {
-		dev_err(core->dev, "LockStep mode not permitted on this device\n");
+	if (cluster->mode == CLUSTER_MODE_LOCKSTEP && is_primary_core(core) &&
+	    !lockstep_permitted) {
+		dev_err(core->dev, "LockStep mode not permitted on this \
+			device\n");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -615,6 +622,9 @@ static int k3_r5f_rproc_configure(struct k3_r5f_core *core)
 			clr_cfg |= PROC_BOOT_CFG_FLAG_R5_LOCKSTEP;
 	}
 
+	if (core->ipdata->is_single_core)
+		set_cfg = PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE;
+
 	if (core->atcm_enable)
 		set_cfg |= PROC_BOOT_CFG_FLAG_R5_ATCM_EN;
 	else
@@ -853,11 +863,19 @@ static int k3_r5f_remove(struct udevice *dev)
 static const struct k3_r5f_ip_data k3_data = {
 	.tcm_is_double = false,
 	.tcm_ecc_autoinit = false,
+	.is_single_core = false,
 };
 
 static const struct k3_r5f_ip_data j7200_j721s2_data = {
 	.tcm_is_double = true,
 	.tcm_ecc_autoinit = true,
+	.is_single_core = false,
+};
+
+static const struct k3_r5f_ip_data am62_data = {
+	.tcm_is_double = false,
+	.tcm_ecc_autoinit = false,
+	.is_single_core = true,
 };
 
 static const struct udevice_id k3_r5f_rproc_ids[] = {
@@ -865,6 +883,7 @@ static const struct udevice_id k3_r5f_rproc_ids[] = {
 	{ .compatible = "ti,j721e-r5f", .data = (ulong)&k3_data, },
 	{ .compatible = "ti,j7200-r5f", .data = (ulong)&j7200_j721s2_data, },
 	{ .compatible = "ti,j721s2-r5f", .data = (ulong)&j7200_j721s2_data, },
+	{ .compatible = "ti,am62-r5f", .data = (ulong)&am62_data, },
 	{}
 };
 
@@ -887,6 +906,11 @@ static int k3_r5f_cluster_probe(struct udevice *dev)
 	cluster->mode = dev_read_u32_default(dev, "ti,cluster-mode",
 					     CLUSTER_MODE_LOCKSTEP);
 
+	if (device_is_compatible(dev, "ti,am62-r5fss")) {
+		cluster->mode = CLUSTER_MODE_SINGLECORE;
+		return 0;
+	}
+
 	if (device_get_child_count(dev) != 2) {
 		dev_err(dev, "Invalid number of R5 cores");
 		return -EINVAL;
@@ -903,6 +927,7 @@ static const struct udevice_id k3_r5fss_ids[] = {
 	{ .compatible = "ti,j721e-r5fss"},
 	{ .compatible = "ti,j7200-r5fss"},
 	{ .compatible = "ti,j721s2-r5fss"},
+	{ .compatible = "ti,am62-r5fss"},
 	{}
 };
 
-- 
2.34.1

