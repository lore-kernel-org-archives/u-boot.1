Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCBAC47258
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 08:09:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026A387BE1;
	Tue, 23 Jan 2024 09:08:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1719887C3B; Tue, 23 Jan 2024 09:08:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3711D87BF9
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C4C732228E;
 Tue, 23 Jan 2024 08:08:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CDBF13786;
 Tue, 23 Jan 2024 08:08:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qL1ZOwZ0r2XOagAAD6G6ig
 (envelope-from <iivanov@suse.de>); Tue, 23 Jan 2024 08:08:38 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH v5 4/7] bcm2835: Dynamically calculate bytes per pixel
 parameter
Date: Tue, 23 Jan 2024 10:07:56 +0200
Message-ID: <20240123080819.13625-5-iivanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123080819.13625-1-iivanov@suse.de>
References: <20240123080819.13625-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: C4C732228E
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

brcm,bcm2708-fb device provided by firmware on RPi5 uses
16 bits per pixel, so lets calculate framebuffer bytes
per pixel dynamically based on queried information.

Tested to work for RPi2b v1.2, RPi3b v1.3, RPi4b v1.1,
RPi2 Zero W, RPi5b v1.0.

Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 drivers/video/bcm2835.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/video/bcm2835.c b/drivers/video/bcm2835.c
index 14942526f1..63efa762db 100644
--- a/drivers/video/bcm2835.c
+++ b/drivers/video/bcm2835.c
@@ -16,7 +16,7 @@ static int bcm2835_video_probe(struct udevice *dev)
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
 	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
 	int ret;
-	int w, h, pitch;
+	int w, h, pitch, bpp;
 	ulong fb_base, fb_size, fb_start, fb_end;
 
 	debug("bcm2835: Query resolution...\n");
@@ -41,9 +41,23 @@ static int bcm2835_video_probe(struct udevice *dev)
 					DCACHE_WRITEBACK);
 	video_set_flush_dcache(dev, true);
 
+	bpp = pitch / w;
+	switch (bpp) {
+	case 2:
+		uc_priv->bpix = VIDEO_BPP16;
+		break;
+	case 4:
+		uc_priv->bpix = VIDEO_BPP32;
+		break;
+	default:
+		printf("bcm2835: unexpected bpp %d, pitch %d, width %d\n",
+		       bpp, pitch, w);
+		uc_priv->bpix = VIDEO_BPP32;
+		break;
+	}
+
 	uc_priv->xsize = w;
 	uc_priv->ysize = h;
-	uc_priv->bpix = VIDEO_BPP32;
 	plat->base = fb_base;
 	plat->size = fb_size;
 
-- 
2.43.0

