Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1EAE7E622
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 11:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6008086C35;
	Tue, 26 Sep 2023 13:25:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QrUsmkTl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F261869BC; Tue, 26 Sep 2023 13:25:30 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80E2786BEF
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 13:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38QBPDic081949;
 Tue, 26 Sep 2023 06:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695727514;
 bh=jzzFO5juv3XUUXPrsqY385vd34QEAL2AHYGrU8AifsI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=QrUsmkTlu3j1WJmRrCwpu2rvpsqBN44PdSxv9Gj015Q/AvPEEz+ffLTadI1MZlAu4
 M0V4aBTnYZk7/C1BsfiSVGErCqA/lEzubY0/4dQDqLqZG7mKKC0jLrpqedQLibkqBe
 IADHHzsoP+jShHuzGCvQAoWbmo42YNmKjS2OzXJ4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38QBPDmR112825
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Sep 2023 06:25:13 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 06:25:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 06:25:13 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38QBP3Cf013985;
 Tue, 26 Sep 2023 06:25:09 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <patrick.delaunay@foss.st.com>,
 <sjoerd@collabora.com>, <sjg@google.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <xypron.glpk@gmx.de>, <michal.simek@amd.com>,
 <dsankouski@gmail.com>, <kettenis@openbsd.org>,
 <sumit.garg@linaro.org>, <sam.shih@mediatek.com>,
 <mark.kettenis@xs4all.nl>, <sjg@chromium.org>, Udit
 Kumar <u-kumar1@ti.com>, Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 1/2] lmb: remove overlapping region with next range
Date: Tue, 26 Sep 2023 16:54:42 +0530
Message-ID: <20230926112443.4190471-2-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926112443.4190471-1-u-kumar1@ti.com>
References: <20230926112443.4190471-1-u-kumar1@ti.com>
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

In case of new memory range to be added is coalesced
with any already added non last lmb region.

And there is possibility that, then region in which new memory
range added is not adjacent to next region. But have some
sections are overlapping.

So along with adjacency check with next lmb region,
check for overlap should be done.

In case overlap  is found, adjust and merge these two lmb
region into one.

Reported-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 lib/lmb.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index b2c233edb6..da924c6789 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -74,6 +74,16 @@ static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,
 	return 0;
 }
 
+static long lmb_regions_overlap(struct lmb_region *rgn, unsigned long r1,
+				unsigned long r2)
+{
+	phys_addr_t base1 = rgn->region[r1].base;
+	phys_size_t size1 = rgn->region[r1].size;
+	phys_addr_t base2 = rgn->region[r2].base;
+	phys_size_t size2 = rgn->region[r2].size;
+
+	return lmb_addrs_overlap(base1, size1, base2, size2);
+}
 static long lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r1,
 				 unsigned long r2)
 {
@@ -81,7 +91,6 @@ static long lmb_regions_adjacent(struct lmb_region *rgn, unsigned long r1,
 	phys_size_t size1 = rgn->region[r1].size;
 	phys_addr_t base2 = rgn->region[r2].base;
 	phys_size_t size2 = rgn->region[r2].size;
-
 	return lmb_addrs_adjacent(base1, size1, base2, size2);
 }
 
@@ -105,6 +114,23 @@ static void lmb_coalesce_regions(struct lmb_region *rgn, unsigned long r1,
 	lmb_remove_region(rgn, r2);
 }
 
+/*Assumption : base addr of region 1 < base addr of region 2*/
+static void lmb_fix_over_lap_regions(struct lmb_region *rgn, unsigned long r1,
+				     unsigned long r2)
+{
+	phys_addr_t base1 = rgn->region[r1].base;
+	phys_size_t size1 = rgn->region[r1].size;
+	phys_addr_t base2 = rgn->region[r2].base;
+	phys_size_t size2 = rgn->region[r2].size;
+
+	if (base1 + size1 > base2 + size2) {
+		printf("This will not be a case any time\n");
+		return;
+	}
+	rgn->region[r1].size = base2 + size2 - base1;
+	lmb_remove_region(rgn, r2);
+}
+
 void lmb_init(struct lmb *lmb)
 {
 #if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
@@ -249,7 +275,6 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 		phys_size_t rgnflags = rgn->region[i].flags;
 		phys_addr_t end = base + size - 1;
 		phys_addr_t rgnend = rgnbase + rgnsize - 1;
-
 		if (rgnbase <= base && end <= rgnend) {
 			if (flags == rgnflags)
 				/* Already have this region, so we're done */
@@ -278,10 +303,14 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 		}
 	}
 
-	if ((i < rgn->cnt - 1) && lmb_regions_adjacent(rgn, i, i + 1)) {
-		if (rgn->region[i].flags == rgn->region[i + 1].flags) {
+	if (i < rgn->cnt - 1 && rgn->region[i].flags == rgn->region[i + 1].flags)  {
+		if (lmb_regions_adjacent(rgn, i, i + 1)) {
 			lmb_coalesce_regions(rgn, i, i + 1);
 			coalesced++;
+		} else if (lmb_regions_overlap(rgn, i, i + 1)) {
+			/* fix overlapping area */
+			lmb_fix_over_lap_regions(rgn, i, i + 1);
+			coalesced++;
 		}
 	}
 
-- 
2.34.1

