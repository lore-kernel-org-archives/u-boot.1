Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76161C4167B
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 16:28:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E902E874BB;
	Sat, 25 Nov 2023 17:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j3WfAu7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD5BA870D9; Sat, 25 Nov 2023 17:27:21 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD828712E
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 17:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3APGRFkM082160;
 Sat, 25 Nov 2023 10:27:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700929635;
 bh=gbfDtZP2thSMOGb6z6Oyk2NWBWICOpI2j4YAEshmQtQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=j3WfAu7rAWKMvu4OrBOrvsI20bTGVu2VD745ik6Sru/rxPOfAixxd2S0cYVqZEpK4
 J2U0MBs3vqZiNcXmiuhy4eTnR7NToYrXa3uEa7FyxI/OwwC8WXSnBndUojAfd4v4LO
 YGyXpZKPIFz/2Udx8jjVtac3eLmRauMsfzmkBn4o=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3APGRFXP036504
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 25 Nov 2023 10:27:15 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 25
 Nov 2023 10:27:14 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 25 Nov 2023 10:27:14 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3APGREKe086071;
 Sat, 25 Nov 2023 10:27:14 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v4 6/8] video: Fill video handoff in video post probe
Date: Sat, 25 Nov 2023 21:57:03 +0530
Message-ID: <20231125162705.1383401-7-devarsht@ti.com>
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

Fill video handoff fields in video_post_probe as at this point we have
full framebuffer-related information.

Also fill all the fields available in video hand-off struct as those
were missing earlier and U-boot framework expects them to be filled for
some of the functionalities.

Reported-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V2:
- No change

V3:
- Fix commit message per review comment
- Add a note explaining assumption of single framebuffer

V4:
- Wrap message to 72 chars
---
 drivers/video/video-uclass.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 378f01f3d7..f4cebf3087 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -144,16 +144,6 @@ int video_reserve(ulong *addrp)
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
 
@@ -552,6 +542,25 @@ static int video_post_probe(struct udevice *dev)
 
 	priv->fb_size = priv->line_length * priv->ysize;
 
+	/*
+	 * Set up video handoff fields for passing video blob to next stage
+	 * NOTE:
+	 * This assumes that reserved video memory only uses a single framebuffer
+	 */
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

