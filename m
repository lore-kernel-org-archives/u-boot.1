Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5C0C4167B
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 16:28:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1244F871C0;
	Sat, 25 Nov 2023 17:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rOeh3njp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31CEA87161; Sat, 25 Nov 2023 17:27:20 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B27E871DF
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 17:27:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3APGRCmi053095;
 Sat, 25 Nov 2023 10:27:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700929632;
 bh=WVXQFV83Ss+4Jr2jQIkFz94fwcvfc4Y6nzUbuIx/Fyo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rOeh3njpyknUWlTzwk9L8xylNE5RWWC6FNty43yCea2YI1fUBJH8kvMbQ2rtImEA8
 qDMttWfzWJgNGoAqKO1PmJJlIXp9FF7+uRSBBMWbp+cuiDBbUyjjtHkSvjDSuQRVWq
 n1+iy8gHH414uL/kvM1hWEqu9WMi2438lcgTctrg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3APGRCWK019540
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 25 Nov 2023 10:27:12 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 25
 Nov 2023 10:27:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 25 Nov 2023 10:27:11 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3APGRBWP052378;
 Sat, 25 Nov 2023 10:27:11 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v4 4/8] common/board_f: Catch bloblist before starting
 resevations
Date: Sat, 25 Nov 2023 21:57:01 +0530
Message-ID: <20231125162705.1383401-5-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231125162705.1383401-1-devarsht@ti.com>
References: <20231125162705.1383401-1-devarsht@ti.com>
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

Start reservations needed for init sequence only after catching
bloblists from previous stage.

This is to avoid catching bloblists in the middle causing gaps while
u-boot is reserving.

Adjust the relocaddr as per video hand-off information received from
previous stage so that further reservations start only after regions
reserved for previous stages

Skip reservation for video memory if it was already filled by a
bloblist.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
V2: Fix typo in commit title and checkpatch warnings/checks
V3: No change
V4: Add Reviewed-by
---
 common/board_f.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index d4d7d01f8f..acf802c9cb 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -403,7 +403,7 @@ __weak int arch_reserve_mmu(void)
 	return 0;
 }
 
-static int reserve_video(void)
+static int reserve_video_from_videoblob(void)
 {
 	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL) {
 		struct video_handoff *ho;
@@ -412,8 +412,34 @@ static int reserve_video(void)
 		if (!ho)
 			return log_msg_ret("blf", -ENOENT);
 		video_reserve_from_bloblist(ho);
-		gd->relocaddr = ho->fb;
-	} else if (CONFIG_IS_ENABLED(VIDEO)) {
+
+		/* Sanity check fb from blob is before current relocaddr */
+		if (likely(gd->relocaddr > (unsigned long)ho->fb))
+			gd->relocaddr = ho->fb;
+	}
+
+	return 0;
+}
+
+/*
+ * Check if any bloblist received specifying reserved areas from previous stage and adjust
+ * gd->relocaddr accordingly, so that we start reserving after pre-reserved areas
+ * from previous stage.
+ *
+ * NOTE:
+ * IT is recommended that all bloblists from previous stage are reserved from ram_top
+ * as next stage will simply start reserving further regions after them.
+ */
+static int setup_relocaddr_from_bloblist(void)
+{
+	reserve_video_from_videoblob();
+
+	return 0;
+}
+
+static int reserve_video(void)
+{
+	if (CONFIG_IS_ENABLED(VIDEO)) {
 		ulong addr;
 		int ret;
 
@@ -923,6 +949,7 @@ static const init_fnc_t init_sequence_f[] = {
 	reserve_pram,
 #endif
 	reserve_round_4k,
+	setup_relocaddr_from_bloblist,
 	arch_reserve_mmu,
 	reserve_video,
 	reserve_trace,
-- 
2.34.1

