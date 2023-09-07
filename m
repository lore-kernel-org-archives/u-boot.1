Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EB9EC8730
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 14:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A00869B5;
	Thu,  7 Sep 2023 16:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iSqLsRJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 901F3869B5; Thu,  7 Sep 2023 16:14:21 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F094986722
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 16:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 387EEGJB048337;
 Thu, 7 Sep 2023 09:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694096056;
 bh=Q8FYRYlxkY8fwIEeVkHQcgaUrfuzMX9aObLMliqbL8c=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=iSqLsRJ+LERYT525/sW62qxHZh3zI7yjBhbDQC+nxdK3ndKao1yEVMywyt+rKmhlG
 TPZDmNDE/mPU6lP55ztB5PmKZYr8rzJwGgxx6CZL8VaQlvt+1mbzvdp8aPMZ4FuI0o
 ha3wHdj1zwbW83c3Y66jGO4ubkn3ve56FaEnupGo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 387EEGFQ033740
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Sep 2023 09:14:16 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 09:14:16 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 09:14:16 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 387EE70f046139;
 Thu, 7 Sep 2023 09:14:12 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <sinthu.raja@ti.com>, <gadiyar@ti.com>, <a-nandan@ti.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2 1/7] drivers: misc: k3_avs: Add linux compatible to
 maintain sync
Date: Thu, 7 Sep 2023 19:44:01 +0530
Message-ID: <20230907141407.382215-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907141407.382215-1-n-francis@ti.com>
References: <20230907141407.382215-1-n-francis@ti.com>
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

The U-Boot AVS driver works on the VTM (Voltage and Thermal Management)
module, also used by the Linux TI Bandgap temperature sensor driver
(drivers/thermal/k3_j72xx_bandgap.c). Although the purpose and
functionalities that these two implement are different, the hardware is
the same, so ensure that their compatibles are in sync. Thus, add
ti,j721e-vtm compatible to the AVS driver.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 drivers/misc/k3_avs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
index 840148d090..3008cf9810 100644
--- a/drivers/misc/k3_avs.c
+++ b/drivers/misc/k3_avs.c
@@ -382,6 +382,7 @@ static struct vd_config am654_vd_config = {
 static const struct udevice_id k3_avs_ids[] = {
 	{ .compatible = "ti,am654-avs", .data = (ulong)&am654_vd_config },
 	{ .compatible = "ti,j721e-avs", .data = (ulong)&j721e_vd_config },
+	{ .compatible = "ti,j721e-vtm", .data = (ulong)&j721e_vd_config },
 	{}
 };
 
-- 
2.34.1

