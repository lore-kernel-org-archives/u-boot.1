Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3943C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4B0380BA9;
	Mon, 10 Feb 2025 21:29:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F9b+7lYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 409EB80AE1; Mon, 10 Feb 2025 21:29:52 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E009E8043C
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51AKTjqm193206
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Feb 2025 14:29:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739219385;
 bh=rnV2ST7s6g68vsUXNqHcgjGWkdYZygkiSooWNIkYtTc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=F9b+7lYjo3/jny5PcXzcpphS10pGo/rs3tMivKX61saOe/EV+D/AF8vHmZn00BS7Z
 M1kn6d0Cupg3w+N4zwVY6jeCgYhMHmG0y+zZTmcnSOCOPPY7g+UTfT8J4JyEVVn1JD
 z4ncRX0RMEqeFfYLsrZY0LE550D+wjeG2w+CzI18=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51AKTiWH042758
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Feb 2025 14:29:45 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Feb 2025 14:29:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Feb 2025 14:29:44 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51AKTiDC022402;
 Mon, 10 Feb 2025 14:29:44 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>, Judith
 Mendez <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v5 02/10] remoteproc: k3-r5: Add support for R5F cores on
 AM64x SoCs
Date: Mon, 10 Feb 2025 14:29:36 -0600
Message-ID: <20250210202944.1071931-3-jm@ti.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250210202944.1071931-1-jm@ti.com>
References: <20250210202944.1071931-1-jm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

From: Hari Nagalla <hnagalla@ti.com>

AM64x SoCs have two R5F clusters in the main power domain.
Extend support for R5F remote proc driver on AM64x with compatible
strings.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Daniel Schultz <d.schultz@phytec.de>
---
Changes since v4:
- No change
---
 drivers/remoteproc/ti_k3_r5f_rproc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index d78b3fa1bbd..57268e7f8ff 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -886,6 +886,7 @@ static const struct udevice_id k3_r5f_rproc_ids[] = {
 	{ .compatible = "ti,j7200-r5f", .data = (ulong)&j7200_j721s2_data, },
 	{ .compatible = "ti,j721s2-r5f", .data = (ulong)&j7200_j721s2_data, },
 	{ .compatible = "ti,am62-r5f", .data = (ulong)&am62_data, },
+	{ .compatible = "ti,am64-r5f", .data = (ulong)&j7200_j721s2_data, },
 	{}
 };
 
@@ -930,6 +931,7 @@ static const struct udevice_id k3_r5fss_ids[] = {
 	{ .compatible = "ti,j7200-r5fss"},
 	{ .compatible = "ti,j721s2-r5fss"},
 	{ .compatible = "ti,am62-r5fss"},
+	{ .compatible = "ti,am64-r5fss"},
 	{}
 };
 
-- 
2.48.0

