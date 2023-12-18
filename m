Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7274BC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 21:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC5CE87656;
	Mon, 18 Dec 2023 22:03:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="MuifTv9w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J2WonmZQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="driIaEaW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ENBj4l6/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24B3087578; Mon, 18 Dec 2023 22:03:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34BC9875A0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 22:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=iivanov@suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B98772226F;
 Mon, 18 Dec 2023 21:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702933431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHScQy8dlQ4zBcmmXyg7xTO2N+HoZRyPs/mSsXUaidA=;
 b=MuifTv9wBEOLgWscWoGcXg+RGB8+btC5sRFciLLURyCkDcUQuguKCF0MB5CUHbvIFDKQTs
 3cu6hcIxZ1sJPOhJYAQlW90dBLsORX0sI25Eq4VgPGCsldwfrQ6KFwJmGJHKAf1t3bAtsp
 bXmOjkuzkGiYTERqgRtFHlM+jbjtULk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702933431;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHScQy8dlQ4zBcmmXyg7xTO2N+HoZRyPs/mSsXUaidA=;
 b=J2WonmZQu47jTWrv+1hYLdw1tZ+mNBDcST4N3FHxlTW7EY6hSg3i0FkVDYqumfQMZdddMp
 jagUtFA6k1hguwCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702933430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHScQy8dlQ4zBcmmXyg7xTO2N+HoZRyPs/mSsXUaidA=;
 b=driIaEaWsaR+g9AcK8SGiaVWp2t8QtO7GFM918C1n2Mg0Ag01KOyoFkVXAvjXENou/caP6
 mszp+EvY1mp+ZR5gwQMkbkHBxQ10VWiFHcSdpA6ZicAD8PbXnb4DO5mEFRyVbxDu6b9fHp
 mNp6oBcymc5k4gJFdfomnV1ubqgcp38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702933430;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHScQy8dlQ4zBcmmXyg7xTO2N+HoZRyPs/mSsXUaidA=;
 b=ENBj4l6/3jkDUxi4yY5WR8ECQN9jENKPjLTTKM7yT4ET1rZJ3jbU297szl97aZN4oQ41A9
 z8StT2qNvcfjYQCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AC2D13C93;
 Mon, 18 Dec 2023 21:03:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EE/zB7azgGUtZAAAD6G6ig
 (envelope-from <iivanov@suse.de>); Mon, 18 Dec 2023 21:03:50 +0000
From: "Ivan T. Ivanov" <iivanov@suse.de>
To: Matthias Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de,
 "Ivan T. Ivanov" <iivanov@suse.de>
Subject: [PATCH v3 3/7] rpi5: Use devicetree to retrieve board revision
Date: Mon, 18 Dec 2023 23:03:37 +0200
Message-ID: <20231218210341.30073-4-iivanov@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218210341.30073-1-iivanov@suse.de>
References: <20231218210341.30073-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.14 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_RATELIMIT(0.00)[to_ip_from(RL9dd9h8xg9qpm5f14t9e5w4zz)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FREEMAIL_TO(0.00)[suse.com,gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[bedrocksystems.com,fitzsim.org,nxp.com,samsung.com,denx.de,gmx.net,broadcom.com,lists.denx.de,suse.de];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.56)[98.03%]
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

Firmware on RPi5 return error on board revision query
through firmware interface, but on the other hand it fills
"linux,revision" in "system" node, so use it to detect board
revision.

	system {
		linux,revision = <0xc04170>;
		linux,serial = <0x6cf44e80 0x3c533ede>;
	};

Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
---
 board/raspberrypi/rpi/rpi.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index cd823ad746..2851ebc985 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -171,6 +171,11 @@ static const struct rpi_model rpi_models_new_scheme[] = {
 		DTB_DIR "bcm2711-rpi-cm4.dtb",
 		true,
 	},
+	[0x17] = {
+		"5 Model B",
+		DTB_DIR "bcm2712-rpi-5-b.dtb",
+		true,
+	},
 };
 
 static const struct rpi_model rpi_models_old_scheme[] = {
@@ -429,15 +434,27 @@ static void get_board_revision(void)
 	int ret;
 	const struct rpi_model *models;
 	uint32_t models_count;
+	ofnode node;
 
 	BCM2835_MBOX_INIT_HDR(msg);
 	BCM2835_MBOX_INIT_TAG(&msg->get_board_rev, GET_BOARD_REV);
 
 	ret = bcm2835_mbox_call_prop(BCM2835_MBOX_PROP_CHAN, &msg->hdr);
 	if (ret) {
-		printf("bcm2835: Could not query board revision\n");
 		/* Ignore error; not critical */
-		return;
+		node = ofnode_path("/system");
+		if (!ofnode_valid(node)) {
+			printf("bcm2835: Could not find /system node\n");
+			return;
+		}
+
+		ret = ofnode_read_u32(node, "linux,revision", &revision);
+		if (ret) {
+			printf("bcm2835: Could not find linux,revision\n");
+			return;
+		}
+	} else {
+		revision = msg->get_board_rev.body.resp.rev;
 	}
 
 	/*
@@ -451,7 +468,6 @@ static void get_board_revision(void)
 	 * http://www.raspberrypi.org/forums/viewtopic.php?f=63&t=98367&start=250
 	 * http://www.raspberrypi.org/forums/viewtopic.php?f=31&t=20594
 	 */
-	revision = msg->get_board_rev.body.resp.rev;
 	if (revision & 0x800000) {
 		rev_scheme = 1;
 		rev_type = (revision >> 4) & 0xff;
-- 
2.35.3

