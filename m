Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B02E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 09:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E563C805F0;
	Mon,  6 Jan 2025 10:36:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F8YYZSv+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7228803DC; Mon,  6 Jan 2025 10:36:05 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40FB280612
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 10:36:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5069Zjxu105878;
 Mon, 6 Jan 2025 03:35:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736156145;
 bh=ziHKuPr1wqOJjO35nyVDhw5wNQS+S+ZT3Sp00SHqWQs=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=F8YYZSv+pBWYGMw6odxKQt4BjpSrkEFmkrcNbrA83lAaC4YwzCWPQczIIOLmwB04h
 d/2ZldLynDhQeX5R1S5NdUHZnKJ1Wl2AVxN9tmR9oo85XAhIRm910OpqMgdfru+Ung
 5e0hIz+E1zS8qibqmDL+veq64NW2fedWspaxw9KU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5069ZjA7126114;
 Mon, 6 Jan 2025 03:35:45 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Jan 2025 03:35:45 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Jan 2025 03:35:45 -0600
Received: from [127.0.1.1] (uda0497581-hp.dhcp.ti.com [172.24.227.160])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5069ZJF3028930;
 Mon, 6 Jan 2025 03:35:41 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Mon, 6 Jan 2025 15:05:01 +0530
Subject: [PATCH RFC v2 5/8] arm: mach-k3: j742s2: Introduce clock and
 device files for J742S2 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250106-b4-upstream-j742s2-v2-5-42d6129ce333@ti.com>
References: <20250106-b4-upstream-j742s2-v2-0-42d6129ce333@ti.com>
In-Reply-To: <20250106-b4-upstream-j742s2-v2-0-42d6129ce333@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Aniket
 Limaye <a-limaye@ti.com>, Beleswar Padhi <b-padhi@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736156119; l=1317;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=52KLcOE3TT95Ait5BwvxEIov7HHNKYTO3XTdg7/PCnA=;
 b=icGwy7ekZnWyifhtsfRc0wRzLktGIrWV2yoCTeFoVj9I4lis/3du6KaOKJn3n/bx1jDsgFR5O
 R4dcRdHwvAYBtuXhC2PHny5vXFiTfikr59QK1WyYTZ0bYgg1fGL5BW8
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Re-use j784s4 clocks and power domains for j742s2 family of device.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 drivers/clk/ti/clk-k3.c                | 4 ++++
 drivers/power/domain/ti-power-domain.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/clk/ti/clk-k3.c b/drivers/clk/ti/clk-k3.c
index bf65f573cb86ed30aed96ea59189dd3b2f3b16cf..734a71a8ef00c7d673dfe409a99191b91cd10774 100644
--- a/drivers/clk/ti/clk-k3.c
+++ b/drivers/clk/ti/clk-k3.c
@@ -104,6 +104,10 @@ static const struct soc_attr ti_k3_soc_clk_data[] = {
 		.family = "J784S4",
 		.data = &j784s4_clk_platdata,
 	},
+	{
+		.family = "J742S2",
+		.data = &j784s4_clk_platdata,
+	},
 #endif
 	{ /* sentinel */ }
 };
diff --git a/drivers/power/domain/ti-power-domain.c b/drivers/power/domain/ti-power-domain.c
index 5e7a4c5648d8f94d0f9587213837b31bf7245219..9dafb04a2a1bcd6f04f828812f2841bd8ddc3254 100644
--- a/drivers/power/domain/ti-power-domain.c
+++ b/drivers/power/domain/ti-power-domain.c
@@ -116,6 +116,10 @@ static const struct soc_attr ti_k3_soc_pd_data[] = {
 		.family = "J784S4",
 		.data = &j784s4_pd_platdata,
 	},
+	{
+		.family = "J742S2",
+		.data = &j784s4_pd_platdata,
+	},
 #endif
 	{ /* sentinel */ }
 };

-- 
2.34.1

