Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F798C4167B
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 16:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 800C2874A5;
	Sat, 25 Nov 2023 17:27:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="r7XAidF5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DE31871C0; Sat, 25 Nov 2023 17:27:21 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4853F871AB
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 17:27:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3APGREEa082155;
 Sat, 25 Nov 2023 10:27:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700929634;
 bh=2y813LsxwE2qSxoYkt++ZFH8KeA4VZ20sDNdkv43p64=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=r7XAidF5Ht+40ysl+TGbD2xKFQC3bX7hpiU32sXNPm+LxKAn3DhTJYMuyUOn+7gfY
 CPGabfP6I5V4xP+KNJYbC0cRp8ugRRIe4wMwv44UwJwav8FyIbCJLE5tOKAxADva9q
 MdKO99YvzK7dj+tbnLshQTWb6HH8e5KYuUmqY/Ng=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3APGRDAp036489
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 25 Nov 2023 10:27:14 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 25
 Nov 2023 10:27:13 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 25 Nov 2023 10:27:13 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3APGRCOH003103;
 Sat, 25 Nov 2023 10:27:13 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v4 5/8] video: Skip framebuffer reservation if already reserved
Date: Sat, 25 Nov 2023 21:57:02 +0530
Message-ID: <20231125162705.1383401-6-devarsht@ti.com>
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

Skip framebufer reservation if it was already reserved from previous
stage and whose information was passed using a bloblist.

Return error in case framebuffer information received from bloblist is
invalid i.e NULL or empty.

While at it, improve the debug message to make it more clear that
address in discussion is of framebuffer and not bloblist and also match
it with printing scheme followed in video_reserve function.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
V2:
- Add debug prints
- Fix commenting style
V3:
- Fix commenting style
V4:
- Remove extra checks on gd for video data in video_reserve
- Add check and return error if video handoff provided info is invalid
- Improve debug message
- Remove Reviewed-by due to additional changes per review comments
---
 common/board_f.c             |  8 ++++++--
 drivers/video/video-uclass.c | 10 ++++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index acf802c9cb..442b8349d0 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -407,11 +407,15 @@ static int reserve_video_from_videoblob(void)
 {
 	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL) {
 		struct video_handoff *ho;
+		int ret = 0;
 
 		ho = bloblist_find(BLOBLISTT_U_BOOT_VIDEO, sizeof(*ho));
 		if (!ho)
-			return log_msg_ret("blf", -ENOENT);
-		video_reserve_from_bloblist(ho);
+			return log_msg_ret("Missing video bloblist", -ENOENT);
+
+		ret = video_reserve_from_bloblist(ho);
+		if (ret)
+			return log_msg_ret("Invalid Video handoff info", ret);
 
 		/* Sanity check fb from blob is before current relocaddr */
 		if (likely(gd->relocaddr > (unsigned long)ho->fb))
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index f743ed74c8..378f01f3d7 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -123,6 +123,9 @@ int video_reserve(ulong *addrp)
 	struct udevice *dev;
 	ulong size;
 
+	if (IS_ENABLED(CONFIG_SPL_VIDEO_HANDOFF) && spl_phase() > PHASE_SPL)
+		return 0;
+
 	gd->video_top = *addrp;
 	for (uclass_find_first_device(UCLASS_VIDEO, &dev);
 	     dev;
@@ -208,11 +211,14 @@ int video_fill_part(struct udevice *dev, int xstart, int ystart, int xend,
 
 int video_reserve_from_bloblist(struct video_handoff *ho)
 {
+	if (!ho->fb || ho->size == 0)
+		return -ENOENT;
+
 	gd->video_bottom = ho->fb;
 	gd->fb_base = ho->fb;
 	gd->video_top = ho->fb + ho->size;
-	debug("Reserving %luk for video using blob at: %08x\n",
-	      ((unsigned long)ho->size) >> 10, (u32)ho->fb);
+	debug("%s: Reserving %lx bytes at %08x as per bloblist received\n",
+	      __func__, (unsigned long)ho->size, (u32)ho->fb);
 
 	return 0;
 }
-- 
2.34.1

