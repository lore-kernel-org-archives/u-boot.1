Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FEDC10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 14:21:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB822880AD;
	Thu,  9 May 2024 16:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W/Hk7fD9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F71E87F52; Thu,  9 May 2024 16:20:48 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E246888022
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 16:20:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hnagalla@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 449EKiOV090596;
 Thu, 9 May 2024 09:20:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715264444;
 bh=6IfpozfJD51zNcbB/3tiK8MbUcoZ6kHVsFQjW46jiHM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=W/Hk7fD9h6voradad8C23NCVZy1x/kDu4TVfiK3okEF0rrDD3m2iZCy5NIdqAhx12
 R/09+PwID1Yi4UuVGCxWSRbIQ4QdTvTzMnki9rPMUJeDZAOEnLgr0slmbJ4Fw1mjZP
 opQUOFCc0FZ19N6V5cO2OcLr65l5gNVn2IhSVIvY=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 449EKi08126158
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 09:20:44 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 09:20:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 09:20:43 -0500
Received: from localhost ([10.250.32.135])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 449EKhMm075402;
 Thu, 9 May 2024 09:20:43 -0500
From: Hari Nagalla <hnagalla@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <devarsht@ti.com>, <afd@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <praneeth@ti.com>
Subject: [PATCH 1/4] remoteproc: k3-dsp: Enable C71x support for AM62A
Date: Thu, 9 May 2024 09:20:34 -0500
Message-ID: <20240509142037.32064-2-hnagalla@ti.com>
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

AM62A SoC has a single C71x DSP subsystem with analytics engine in
main voltage domain. Extend support to AM62A with compatible strings.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_rproc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_rproc.c b/drivers/remoteproc/ti_k3_dsp_rproc.c
index e790406324..ed13729c33 100644
--- a/drivers/remoteproc/ti_k3_dsp_rproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_rproc.c
@@ -339,7 +339,8 @@ static int k3_dsp_of_get_memories(struct udevice *dev)
 	for (i = 0; i < dsp->num_mems; i++) {
 		/* C71 cores only have a L1P Cache, there are no L1P SRAMs */
 		if (((device_is_compatible(dev, "ti,j721e-c71-dsp")) ||
-		     (device_is_compatible(dev, "ti,j721s2-c71-dsp"))) &&
+		    (device_is_compatible(dev, "ti,j721s2-c71-dsp")) ||
+		    (device_is_compatible(dev, "ti,am62a-c7xv-dsp"))) &&
 		    !strcmp(mem_names[i], "l1pram")) {
 			dsp->mem[i].bus_addr = FDT_ADDR_T_NONE;
 			dsp->mem[i].dev_addr = FDT_ADDR_T_NONE;
@@ -347,7 +348,14 @@ static int k3_dsp_of_get_memories(struct udevice *dev)
 			dsp->mem[i].size = 0;
 			continue;
 		}
-
+		if (device_is_compatible(dev, "ti,am62a-c7xv-dsp") &&
+		    !strcmp(mem_names[i], "l1dram")) {
+			dsp->mem[i].bus_addr = FDT_ADDR_T_NONE;
+			dsp->mem[i].dev_addr = FDT_ADDR_T_NONE;
+			dsp->mem[i].cpu_addr = NULL;
+			dsp->mem[i].size = 0;
+			continue;
+		}
 		dsp->mem[i].bus_addr = dev_read_addr_size_name(dev, mem_names[i],
 					  (fdt_addr_t *)&dsp->mem[i].size);
 		if (dsp->mem[i].bus_addr == FDT_ADDR_T_NONE) {
@@ -459,6 +467,7 @@ static const struct udevice_id k3_dsp_ids[] = {
 	{ .compatible = "ti,j721e-c66-dsp", .data = (ulong)&c66_data, },
 	{ .compatible = "ti,j721e-c71-dsp", .data = (ulong)&c71_data, },
 	{ .compatible = "ti,j721s2-c71-dsp", .data = (ulong)&c71_data, },
+	{ .compatible = "ti,am62a-c7xv-dsp", .data = (ulong)&c71_data, },
 	{}
 };
 
-- 
2.34.1

