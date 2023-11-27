Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C023C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 10:29:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F71E8751F;
	Mon, 27 Nov 2023 11:29:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="M9UsphDT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDF0C87525; Mon, 27 Nov 2023 11:29:25 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14D1587515
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ARATJLL002152;
 Mon, 27 Nov 2023 04:29:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701080959;
 bh=zJLFg50Z64PDuXrjOPTs1BlY0Et2K8N+0pQFQ3cPNO8=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=M9UsphDTQluQVBwMnmbf9E45nLJL3m2rsuZ2nRG5P5qjiIl0wKlUUSptaaq5mDI0u
 tyZ3LnkelkDYOQ4NCID/BZFfJX03XHdsZVOzJIwClqyk7+/69BcCNy+Sj7BOVq5kiB
 DSWVCMEJpF9iw3RRLyDltVSxBZkZCHjSH49Uf0DQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ARATJY2005543
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Nov 2023 04:29:19 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 04:29:19 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 04:29:19 -0600
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ARATDlb089434;
 Mon, 27 Nov 2023 04:29:17 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 27 Nov 2023 15:59:12 +0530
Subject: [PATCH v2 1/3] remoteproc: k3-r5: Extend support for R5F clusters
 on J721S2 SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231127-b4-upstream-j721e-rproc-support-v2-1-22ee7c8ef53c@ti.com>
References: <20231127-b4-upstream-j721e-rproc-support-v2-0-22ee7c8ef53c@ti.com>
In-Reply-To: <20231127-b4-upstream-j721e-rproc-support-v2-0-22ee7c8ef53c@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Apurva Nandan <a-nandan@ti.com>, Udit Kumar <u-kumar1@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Hari Nagalla <hnagalla@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701080953; l=1685;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=A3uIaHh9ghYb2iQMMxA+aaDHFAeyDD6Ms4ypis1F/cw=;
 b=6OJKZRSJuXpbpiSzct6ucUl46iQEs9hFLqK88TKk3ZS54TZ9wbHGDT692D4qSRru4LolVXut9
 yV6F4HZHjErAEsoUyqR35IIvI63kQL84Qp13NytXfgxa/DEqwjBacW3
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

From: Hari Nagalla <hnagalla@ti.com>

The K3 J721S2 SoCs have three dual-core R5F subsystems, one in MCU
voltage domain and the other two in MAIN voltage domain. These R5F
clusters are similar to the R5F clusters in J7200 SoCs.

Compatible Info is updated to support J721S2 SoCs.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 drivers/remoteproc/ti_k3_r5f_rproc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
index 6f3e12d915e6..631e548dccef 100644
--- a/drivers/remoteproc/ti_k3_r5f_rproc.c
+++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
@@ -855,7 +855,7 @@ static const struct k3_r5f_ip_data k3_data = {
 	.tcm_ecc_autoinit = false,
 };
 
-static const struct k3_r5f_ip_data j7200_data = {
+static const struct k3_r5f_ip_data j7200_j721s2_data = {
 	.tcm_is_double = true,
 	.tcm_ecc_autoinit = true,
 };
@@ -863,7 +863,8 @@ static const struct k3_r5f_ip_data j7200_data = {
 static const struct udevice_id k3_r5f_rproc_ids[] = {
 	{ .compatible = "ti,am654-r5f", .data = (ulong)&k3_data, },
 	{ .compatible = "ti,j721e-r5f", .data = (ulong)&k3_data, },
-	{ .compatible = "ti,j7200-r5f", .data = (ulong)&j7200_data, },
+	{ .compatible = "ti,j7200-r5f", .data = (ulong)&j7200_j721s2_data, },
+	{ .compatible = "ti,j721s2-r5f", .data = (ulong)&j7200_j721s2_data, },
 	{}
 };
 
@@ -901,6 +902,7 @@ static const struct udevice_id k3_r5fss_ids[] = {
 	{ .compatible = "ti,am654-r5fss"},
 	{ .compatible = "ti,j721e-r5fss"},
 	{ .compatible = "ti,j7200-r5fss"},
+	{ .compatible = "ti,j721s2-r5fss"},
 	{}
 };
 

-- 
2.41.0

