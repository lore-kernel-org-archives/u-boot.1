Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E2AC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 13:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42AC487CD0;
	Tue, 31 Oct 2023 14:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="b2pYkmYm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7DDF87610; Tue, 31 Oct 2023 14:12:24 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5927D87CC2
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:12:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39VDCHAn086536;
 Tue, 31 Oct 2023 08:12:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698757937;
 bh=Fgr1aCZQAZ8NNdrDegVMdDVRILEWoB4R4BHiaKc3MSY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=b2pYkmYmmaxUmKm9cCwNHQR7Ey1Wl6SwLjkq1D0tFrYF53kagsbdYDv9XLMcaB1ih
 5fl5UhThedqiAKbkYdgYWxm4PPuVSMems037xK0JAmVFchOMCehShGLQ4wcryF98NG
 TWrhUatV1KLyshlTvaaoY5+46kcWTQvSka+NSi60=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39VDCHkR000331
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 31 Oct 2023 08:12:17 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 08:12:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 08:12:17 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39VDCGF0067144;
 Tue, 31 Oct 2023 08:12:16 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v2 5/5] video: Fill video handoff in video post probe
Date: Tue, 31 Oct 2023 18:42:08 +0530
Message-ID: <20231031131208.435268-6-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031131208.435268-1-devarsht@ti.com>
References: <20231031131208.435268-1-devarsht@ti.com>
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
V2: No change
---
 drivers/video/video-uclass.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 335a1a1828..635b70f668 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -153,16 +153,6 @@ int video_reserve(ulong *addrp)
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
 
@@ -558,6 +548,21 @@ static int video_post_probe(struct udevice *dev)
 
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

