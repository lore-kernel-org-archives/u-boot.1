Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B06ACDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4DB386E03;
	Mon, 16 Oct 2023 18:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GAuBQeTM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AABB186DDE; Mon, 16 Oct 2023 18:06:30 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A217586BF2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GG6Kh6079871;
 Mon, 16 Oct 2023 11:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697472380;
 bh=pSG5euxWaBURoWBmUpUHabIFwqsIlnHSMxrABVfU+Ik=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=GAuBQeTMQLtYSLkIi/sMXaE3pRKLpFWtwcX+7z6z4HtlAQO1K5RMvFGGQmz7CAajf
 hlF6ZH0rsrOJPGzakmkDdRqxTOu7ld9e8ypv/RdxqRfWRiMU2hglTLWAvf6+WkwVyI
 Mfxob8e6uY7FBPO+/AJtiRC4uYb+HT9J1haSSAbA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GG6KCB122389
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 16 Oct 2023 11:06:20 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 11:06:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 11:06:19 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GG6Jwp099034;
 Mon, 16 Oct 2023 11:06:19 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <devarsht@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>
Subject: [RFC PATCH 5/5] video: Fill video handoff in video post probe
Date: Mon, 16 Oct 2023 21:36:11 +0530
Message-ID: <20231016160611.1353458-6-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016160611.1353458-1-devarsht@ti.com>
References: <20231016160611.1353458-1-devarsht@ti.com>
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

Fill video handoff fields in video_post_probe
as at this point we have full framebuffer related
information.

Also fill all the fields available in video hand-off
struct as those were missing earlier and u-boot
framework expects them to be filled for some of the
functionalities.

Reported-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 drivers/video/video-uclass.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index bac30187e7..2a605f8339 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -149,16 +149,6 @@ int video_reserve(ulong *addrp)
 	debug("Video frame buffers from %lx to %lx\n", gd->video_bottom,
 	      gd->video_top);
 
-	if (spl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(VIDEO_HANDOFF)) {
-		struct video_handoff *ho;
-
-		ho = bloblist_add(BLOBLISTT_U_BOOT_VIDEO, sizeof(*ho), 0);
-		if (!ho)
-			return log_msg_ret("blf", -ENOENT);
-		ho->fb = *addrp;
-		ho->size = size;
-	}
-
 	return 0;
 }
 
@@ -554,6 +544,21 @@ static int video_post_probe(struct udevice *dev)
 
 	priv->fb_size = priv->line_length * priv->ysize;
 
+	/* Set up video handoff fields for passing video blob to next stage */
+	if (spl_phase() == PHASE_SPL && CONFIG_IS_ENABLED(BLOBLIST)) {
+		struct video_handoff *ho;
+
+		ho = bloblist_add(BLOBLISTT_U_BOOT_VIDEO, sizeof(*ho), 0);
+		if (!ho)
+			return log_msg_ret("blf", -ENOENT);
+		ho->fb = gd->video_bottom;
+		ho->size = gd->video_top - gd->video_bottom;
+		ho->xsize = priv->xsize;
+		ho->ysize = priv->ysize;
+		ho->line_length = priv->line_length;
+		ho->bpix = priv->bpix;
+	}
+
 	if (IS_ENABLED(CONFIG_VIDEO_COPY) && plat->copy_base)
 		priv->copy_fb = map_sysmem(plat->copy_base, plat->size);
 
-- 
2.34.1

