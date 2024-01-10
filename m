Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEB1C4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 12:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 742B187AFB;
	Wed, 10 Jan 2024 13:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="y7lyMrJC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PYlkYNAW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y7lyMrJC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PYlkYNAW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ED4987A7B; Wed, 10 Jan 2024 13:29:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44CB8876F6
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 13:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2FE11F8A6;
 Wed, 10 Jan 2024 12:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704889764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6YcKP/Snu+eEOe5jpzbhZX+QOwUPK8S0NCxm4JP2aO4=;
 b=y7lyMrJCnDkeH7cW5Squ2LXbFEmQApmJKKQg3Ef+vAvgLHg18vwL6RkxKrHlxWJcDMOdPe
 QDzhNRX/iVZMfKi1x0wHA56w9MfhutxGVof7/0fzZCvelEFSQQepeQmln+uQteyTrQO+Ix
 iRNvg3yQgKDmK98jzIQGqwvnJ2x4nAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704889764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6YcKP/Snu+eEOe5jpzbhZX+QOwUPK8S0NCxm4JP2aO4=;
 b=PYlkYNAWMjNoOrqX/eTWlC8sYs8Q4q2I+eOgio5T9u1tf4aeZgmcdC7VfO9mpG1HVReb/r
 gQcId7fcF92O6HDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704889764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6YcKP/Snu+eEOe5jpzbhZX+QOwUPK8S0NCxm4JP2aO4=;
 b=y7lyMrJCnDkeH7cW5Squ2LXbFEmQApmJKKQg3Ef+vAvgLHg18vwL6RkxKrHlxWJcDMOdPe
 QDzhNRX/iVZMfKi1x0wHA56w9MfhutxGVof7/0fzZCvelEFSQQepeQmln+uQteyTrQO+Ix
 iRNvg3yQgKDmK98jzIQGqwvnJ2x4nAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704889764;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6YcKP/Snu+eEOe5jpzbhZX+QOwUPK8S0NCxm4JP2aO4=;
 b=PYlkYNAWMjNoOrqX/eTWlC8sYs8Q4q2I+eOgio5T9u1tf4aeZgmcdC7VfO9mpG1HVReb/r
 gQcId7fcF92O6HDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40EE21398A;
 Wed, 10 Jan 2024 12:29:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gOaQDaSNnmUZPgAAD6G6ig
 (envelope-from <iivanov@suse.de>); Wed, 10 Jan 2024 12:29:24 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH v4 4/6] bcm2835: Dynamically calculate bytes per pixel
 parameter
Date: Wed, 10 Jan 2024 14:29:06 +0200
Message-ID: <20240110122908.31612-5-iivanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110122908.31612-1-iivanov@suse.de>
References: <20240110122908.31612-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.72 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 R_RATELIMIT(0.00)[to_ip_from(RL9dd9h8xg9qpm5f14t9e5w4zz)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.18)[-0.924]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FREEMAIL_TO(0.00)[suse.com,gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de,suse.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[17.43%]
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
2.35.3

