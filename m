Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7DDC02181
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 01:08:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6984A807B4;
	Thu, 23 Jan 2025 02:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MtZ0Q1em";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F356D80214; Thu, 23 Jan 2025 02:08:05 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A194E801B0
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 02:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50N17x3M289110
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Jan 2025 19:07:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737594479;
 bh=jH7hN8wlu2wP2hfQw7wudaNB2B4h5UkOjRHQeB39NOw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=MtZ0Q1em2monfkbmkVOOo8a535SnQAkJKg/20lVQy98EP3g/lHGRgkreKOlbVU/8A
 wds8T7kEgbgEvmBNc+TW1h3JuYijSwBGCn63zr6SgKsjlpQyh+SA5bMUpQiyJ9uzMc
 tbBSeqHO8rOsteE+v50L4hAF2dILEMGrEJ/Ioshg=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50N17xoE064006
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 Jan 2025 19:07:59 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Jan 2025 19:07:59 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Jan 2025 19:07:59 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50N17xaR066772;
 Wed, 22 Jan 2025 19:07:59 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 2/4] remoteproc: k3-r5: Add support for R5F cores on AM64x SoCs
Date: Wed, 22 Jan 2025 19:07:57 -0600
Message-ID: <20250123010759.810799-3-jm@ti.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250123010759.810799-1-jm@ti.com>
References: <20250123010759.810799-1-jm@ti.com>
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

