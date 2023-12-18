Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAC4C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 21:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 516EE875B6;
	Mon, 18 Dec 2023 22:03:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="v2vbP3rz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DCEhbGvW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v2vbP3rz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DCEhbGvW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3A6E87578; Mon, 18 Dec 2023 22:03:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF6918758C
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 22:03:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 601C222298;
 Mon, 18 Dec 2023 21:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702933431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g18N3OoUCORUbBwvzPY0/IHAtBrY9++PtXkkmDrbHl4=;
 b=v2vbP3rzM/o63ofFdDaxhtUv68QFa8UxlaWLBU0PN+7PKXtZUGyrKBSmhVzxTM42FyEF7w
 9fus9/ORTaMw41AMi4qeWNQkin7gz4BF2qAFQuYSksnSgsT4Jul8n1YBBmIDx1keXZtfAW
 uJZcfMM7pykF11NRMTvI38ZkyYm3ueQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702933431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g18N3OoUCORUbBwvzPY0/IHAtBrY9++PtXkkmDrbHl4=;
 b=DCEhbGvWPmgWKvfaoSUDgZ/cuuHGUnp9FvtlFeMSL2WTlsc5F+jQrl+8kVn2Yr5wDXUi8w
 yyGhdRc4ihbp3tAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702933431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g18N3OoUCORUbBwvzPY0/IHAtBrY9++PtXkkmDrbHl4=;
 b=v2vbP3rzM/o63ofFdDaxhtUv68QFa8UxlaWLBU0PN+7PKXtZUGyrKBSmhVzxTM42FyEF7w
 9fus9/ORTaMw41AMi4qeWNQkin7gz4BF2qAFQuYSksnSgsT4Jul8n1YBBmIDx1keXZtfAW
 uJZcfMM7pykF11NRMTvI38ZkyYm3ueQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702933431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g18N3OoUCORUbBwvzPY0/IHAtBrY9++PtXkkmDrbHl4=;
 b=DCEhbGvWPmgWKvfaoSUDgZ/cuuHGUnp9FvtlFeMSL2WTlsc5F+jQrl+8kVn2Yr5wDXUi8w
 yyGhdRc4ihbp3tAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C77BF133E5;
 Mon, 18 Dec 2023 21:03:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cKI3LrazgGUtZAAAD6G6ig
 (envelope-from <iivanov@suse.de>); Mon, 18 Dec 2023 21:03:50 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH v3 4/7] bcm2835: brcm, bcm2708-fb device is using r5g6b5 format
Date: Mon, 18 Dec 2023 23:03:38 +0200
Message-ID: <20231218210341.30073-5-iivanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218210341.30073-1-iivanov@suse.de>
References: <20231218210341.30073-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 R_RATELIMIT(0.00)[to_ip_from(RL9dd9h8xg9qpm5f14t9e5w4zz)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FREEMAIL_TO(0.00)[suse.com,gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de,suse.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[34.66%]
Authentication-Results: smtp-out1.suse.de;
	none
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
16 bits per pixel. Update driver to properly handle this.

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 drivers/video/bcm2835.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/bcm2835.c b/drivers/video/bcm2835.c
index 14942526f1..245c958b6e 100644
--- a/drivers/video/bcm2835.c
+++ b/drivers/video/bcm2835.c
@@ -43,7 +43,7 @@ static int bcm2835_video_probe(struct udevice *dev)
 
 	uc_priv->xsize = w;
 	uc_priv->ysize = h;
-	uc_priv->bpix = VIDEO_BPP32;
+	uc_priv->bpix = dev_get_driver_data(dev);
 	plat->base = fb_base;
 	plat->size = fb_size;
 
@@ -51,11 +51,11 @@ static int bcm2835_video_probe(struct udevice *dev)
 }
 
 static const struct udevice_id bcm2835_video_ids[] = {
-	{ .compatible = "brcm,bcm2835-hdmi" },
-	{ .compatible = "brcm,bcm2711-hdmi0" },
-	{ .compatible = "brcm,bcm2708-fb" },
+	{ .compatible = "brcm,bcm2835-hdmi",  .data = VIDEO_BPP32},
+	{ .compatible = "brcm,bcm2711-hdmi0", .data = VIDEO_BPP32},
+	{ .compatible = "brcm,bcm2708-fb",    .data = VIDEO_BPP16 },
 #if !IS_ENABLED(CONFIG_VIDEO_DT_SIMPLEFB)
-	{ .compatible = "simple-framebuffer" },
+	{ .compatible = "simple-framebuffer", .data = VIDEO_BPP32},
 #endif
 	{ }
 };
-- 
2.35.3

