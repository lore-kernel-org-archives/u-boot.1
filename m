Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF288C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 10:46:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22202889B7;
	Tue, 30 Apr 2024 12:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="t7mmAj5s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D913880FB; Tue, 30 Apr 2024 12:46:45 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F7498899F
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 12:46:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43UAkdFX002546;
 Tue, 30 Apr 2024 05:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714473999;
 bh=9oqZsyG/6koXNnYrtS4QL3+JiIef54SQirrHCaSNHAA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=t7mmAj5sjQcFRZNvX016Sg3Dqg0QXSBzRaU6vpveA2ZfLFslc1Z3uxCgzHAFQS4Nr
 2aKuJVxLHOZc2HPOZJiEsUHg0244Op3taZKYFdPTuc2HrTbyVxfGFVlFiiIQv9ZeNP
 4tFrYlgwPTtUnjPF4zQYKSNW7L63B6cxE/N/4GOQ=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43UAkdla027335
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Apr 2024 05:46:39 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Apr 2024 05:46:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Apr 2024 05:46:39 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43UAkcGd027165;
 Tue, 30 Apr 2024 05:46:38 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 43UAkc0E010444;
 Tue, 30 Apr 2024 05:46:38 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Nishanth Menon <nm@ti.com>, MD Danish Anwar <danishanwar@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 1/2] remoteproc: pru: Add support for AM64x PRU / RTU cores
Date: Tue, 30 Apr 2024 16:16:32 +0530
Message-ID: <20240430104633.1445311-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430104633.1445311-1-danishanwar@ti.com>
References: <20240430104633.1445311-1-danishanwar@ti.com>
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

Add support for AM64x PRU cores by adding compatibles for AM64x.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/remoteproc/pru_rproc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 6ec55e27d9..5e9334e117 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -399,10 +399,12 @@ static void pru_set_id(struct pru_privdata *priv, struct udevice *dev)
 {
 	u32 mask2 = 0x38000;
 
-	if (device_is_compatible(dev, "ti,am654-rtu"))
+	if (device_is_compatible(dev, "ti,am654-rtu") ||
+	    device_is_compatible(dev, "ti,am642-rtu"))
 		mask2 = 0x6000;
 
-	if (device_is_compatible(dev, "ti,am654-tx-pru"))
+	if (device_is_compatible(dev, "ti,am654-tx-pru") ||
+	    device_is_compatible(dev, "ti,am642-tx-pru"))
 		mask2 = 0xc000;
 
 	if ((priv->pru_iram & mask2) == mask2)
@@ -448,6 +450,9 @@ static const struct udevice_id pru_ids[] = {
 	{ .compatible = "ti,am654-pru"},
 	{ .compatible = "ti,am654-rtu"},
 	{ .compatible = "ti,am654-tx-pru" },
+	{ .compatible = "ti,am642-pru"},
+	{ .compatible = "ti,am642-rtu"},
+	{ .compatible = "ti,am642-tx-pru" },
 	{}
 };
 
-- 
2.34.1

