Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBC6C10DC3
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 15:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A525B87885;
	Tue,  5 Dec 2023 16:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tQlwBfno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36EB2871A0; Tue,  5 Dec 2023 16:55:41 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D29408789A
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 16:55:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5FtXDY033501;
 Tue, 5 Dec 2023 09:55:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701791733;
 bh=0B8srvgoXdTAGGFJoL5MJuv56sUQG1gMD8Iw2YNF34I=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=tQlwBfnob/Pf4W2L+vwgH++hEKH54bhIx0BNMyRAOfMUiYsw33bWrktHVbegMPtH2
 ohFk2cZftU2Fy+lNiRbfQv3yqKn8SHpdctumFBw2rmiaM0e7nt+ylIjT6J3cbw9Jlj
 NU8GAbHS4WZLE7RUpI1eeOK0iQ7uWZdcubMMjZqA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5FtXOf001180
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Dec 2023 09:55:33 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 09:55:33 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 09:55:33 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5FtWgE130793;
 Tue, 5 Dec 2023 09:55:33 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v5 6/8] video: Fill video handoff in video post probe
Date: Tue, 5 Dec 2023 21:25:21 +0530
Message-ID: <20231205155523.721784-7-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205155523.721784-1-devarsht@ti.com>
References: <20231205155523.721784-1-devarsht@ti.com>
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

While filling framebuffer size in video hand-off structure use the
actual framebuffer region size as derived from gd->video_top and
gd->video_bottom instead of directly using the size populated in
video_uc_plat as it contains unaligned size.

Reported-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
V2:
- No change

V3:
- Fix commit message per review comment
- Add a note explaining assumption of single framebuffer

V4:
- Wrap message to 72 chars

V5:
- Add Reviewed-by and comments for framebuffer size usage
---
 drivers/video/video-uclass.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index d620a29c25..3571e62ba2 100644
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
 
@@ -552,6 +542,26 @@ static int video_post_probe(struct udevice *dev)
 
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
+		/* Fill aligned size here as calculated in video_reserve() */
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

