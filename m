Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09000C48286
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 00:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99FED87D77;
	Fri,  2 Feb 2024 01:25:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FoTFaGtl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF5D987D6B; Fri,  2 Feb 2024 01:24:57 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B0C287D66
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 01:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4120Oppg029792;
 Thu, 1 Feb 2024 18:24:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706833491;
 bh=8mKvsbXlxW54u6vrxbbpiYdmVJoPgK7sk5P/gou5Vek=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FoTFaGtlWnjrfxHC2HDYLEM1hoY7x5s97lEAvkdr/SEW/7F/z8pmCirAJjd00fs3b
 f3ad763hakCCO26B4hqSCJLAUvHr8NqHW1df66OLPmnEz7eRXtld7RX3WwDWiduM1H
 F6oGxkWq7eRThVWIzqjMbHzfIIRa+YPAXuqynvYQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4120OpMI003078
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 1 Feb 2024 18:24:51 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 18:24:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 18:24:50 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4120OnBk107441;
 Thu, 1 Feb 2024 18:24:50 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 5/6] arm: mach-k3: Move firewall removal into R5 directory
Date: Thu, 1 Feb 2024 18:24:47 -0600
Message-ID: <20240202002448.1116407-5-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202002448.1116407-1-afd@ti.com>
References: <20240202002448.1116407-1-afd@ti.com>
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

Firewalls are only ever removed by the R5 core, move this code into
the R5 directory.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/mach-k3/common.c    | 44 ------------------------------------
 arch/arm/mach-k3/r5/common.c | 44 ++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 8db7ca0725e..ed8aec360c9 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -211,50 +211,6 @@ void board_prep_linux(struct bootm_headers *images)
 }
 #endif
 
-static void remove_fwl_regions(struct fwl_data fwl_data, size_t num_regions,
-			       enum k3_firewall_region_type fwl_type)
-{
-	struct ti_sci_fwl_ops *fwl_ops;
-	struct ti_sci_handle *ti_sci;
-	struct ti_sci_msg_fwl_region region;
-	size_t j;
-
-	ti_sci = get_ti_sci_handle();
-	fwl_ops = &ti_sci->ops.fwl_ops;
-
-	for (j = 0; j < fwl_data.regions; j++) {
-		region.fwl_id = fwl_data.fwl_id;
-		region.region = j;
-		region.n_permission_regs = 3;
-
-		fwl_ops->get_fwl_region(ti_sci, &region);
-
-		/* Don't disable the background regions */
-		if (region.control != 0 &&
-		    ((region.control >> K3_FIREWALL_BACKGROUND_BIT) & 1) == fwl_type) {
-			pr_debug("Attempting to disable firewall %5d (%25s)\n",
-				 region.fwl_id, fwl_data.name);
-			region.control = 0;
-
-			if (fwl_ops->set_fwl_region(ti_sci, &region))
-				pr_err("Could not disable firewall %5d (%25s)\n",
-				       region.fwl_id, fwl_data.name);
-		}
-	}
-}
-
-void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size)
-{
-	size_t i;
-
-	for (i = 0; i < fwl_data_size; i++) {
-		remove_fwl_regions(fwl_data[i], fwl_data[i].regions,
-				   K3_FIREWALL_REGION_FOREGROUND);
-		remove_fwl_regions(fwl_data[i], fwl_data[i].regions,
-				   K3_FIREWALL_REGION_BACKGROUND);
-	}
-}
-
 void spl_enable_cache(void)
 {
 #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
diff --git a/arch/arm/mach-k3/r5/common.c b/arch/arm/mach-k3/r5/common.c
index 87d4712efd4..7309573a3fa 100644
--- a/arch/arm/mach-k3/r5/common.c
+++ b/arch/arm/mach-k3/r5/common.c
@@ -247,6 +247,50 @@ void disable_linefill_optimization(void)
 	asm("mcr p15, 0, %0, c1, c0, 1" : : "r" (actlr));
 }
 
+static void remove_fwl_regions(struct fwl_data fwl_data, size_t num_regions,
+			       enum k3_firewall_region_type fwl_type)
+{
+	struct ti_sci_fwl_ops *fwl_ops;
+	struct ti_sci_handle *ti_sci;
+	struct ti_sci_msg_fwl_region region;
+	size_t j;
+
+	ti_sci = get_ti_sci_handle();
+	fwl_ops = &ti_sci->ops.fwl_ops;
+
+	for (j = 0; j < fwl_data.regions; j++) {
+		region.fwl_id = fwl_data.fwl_id;
+		region.region = j;
+		region.n_permission_regs = 3;
+
+		fwl_ops->get_fwl_region(ti_sci, &region);
+
+		/* Don't disable the background regions */
+		if (region.control != 0 &&
+		    ((region.control >> K3_FIREWALL_BACKGROUND_BIT) & 1) == fwl_type) {
+			pr_debug("Attempting to disable firewall %5d (%25s)\n",
+				 region.fwl_id, fwl_data.name);
+			region.control = 0;
+
+			if (fwl_ops->set_fwl_region(ti_sci, &region))
+				pr_err("Could not disable firewall %5d (%25s)\n",
+				       region.fwl_id, fwl_data.name);
+		}
+	}
+}
+
+void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size)
+{
+	size_t i;
+
+	for (i = 0; i < fwl_data_size; i++) {
+		remove_fwl_regions(fwl_data[i], fwl_data[i].regions,
+				   K3_FIREWALL_REGION_FOREGROUND);
+		remove_fwl_regions(fwl_data[i], fwl_data[i].regions,
+				   K3_FIREWALL_REGION_BACKGROUND);
+	}
+}
+
 #if CONFIG_IS_ENABLED(FIT_IMAGE_POST_PROCESS)
 void board_fit_image_post_process(const void *fit, int node, void **p_image,
 				  size_t *p_size)
-- 
2.39.2

