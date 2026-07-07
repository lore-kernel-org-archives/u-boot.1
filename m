Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB4AC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 22:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 237808496E;
	Wed,  8 Jul 2026 00:48:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MvMUSC0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE35F84979; Wed,  8 Jul 2026 00:48:47 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C863984118
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 00:48:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-491f5e6d564so51191b6e.1
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 15:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783464524; x=1784069324; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IVBu1Br53BaG3h3Q+NAAlvdyRfpmFj9sVzAi7LrvEuQ=;
 b=MvMUSC0WsERSkM4PcE8VDigQ3adCpacBGAk4+H4Zjxc6BEFVLiz6Z9MMEg8tlCgVDS
 YEyrlyuOq5upukBUpIFWce8Zs9EndyW6qRAPNXvR9JOOBHRbANOjJjdUJt5lwop3Oe6k
 xWVTkEZCHxJwx+I2RhlXaAoU9m8ycX6kLcrsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783464524; x=1784069324;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IVBu1Br53BaG3h3Q+NAAlvdyRfpmFj9sVzAi7LrvEuQ=;
 b=kCssM3DAi+WCVRi3/jTtbxslxBIrvNxrHuS01L3ZEeSLKLRhsK2Y0/2OCYRd5/nsjB
 YMyXOJ+NDIa4/09cGTQbjcYptHpS9+ca0rXu1OVxrX6zGlF0RljgZoNVA+V0NmZJvX+e
 S6QE1j2TXn/Pb8N8WPdiUCH3Zy3YXKInZLtrbwmSUdAx0YhzVwR1xlXDnqfSsYynrWfi
 FYw4tOMFyfS0amXJtXdc8WiPPntWB1wKftymHvJBEArXscZDXe3JJvEEYNAm0MlVvi4O
 tPRQxhuo5tuIxgwmhniAEhkXuwRkezHbDwlpXt9AH6gLvXDsJZFKmygOb440VVnXLMTO
 29Tg==
X-Gm-Message-State: AOJu0Yw86FERhNVsGAb0/wj7Nh1sWlmsGwXuhm6+byuav+Mk6cuPIGVj
 8HJEUAywX/AJbe4gKfQt4+VhOxXYPOvKJihKKSrzzlh542y1vdiOkaE6AK55eUCAtOnfDnfj8GI
 ohgsSQOo=
X-Gm-Gg: AfdE7cleBUWGQgu6/FC56LQR6deqSWfnlKQF7onXN87cnfoXiIlskjPORSMJepfl3jA
 WUUYOlLMk4YSR/TFyNN81dtgWQzWuHj0+Xmel2KjPk0QleGYWaIyfUA0t6fgf+p4Ib8xde07C7Z
 zSjeHPVGdP7I1rFkGtw75zx08vawEeausp67QynqaHYXq5TMk0Hhj3+VjVK5o33neNynh2BBFzT
 hjAt+WHtIEXpJGhYOOvSA0FzWH6CbJns3EBKDPIwFDOY0ktY2p16TRIYr3I0nJmkg9wwN0R+IPC
 mb9kICwX87JJVv3s2EaCEGGfsFVc72Miwtu4cbv15Z10cCpTMu5CgZ2wE5NPhBjGbEdhA0eFtcY
 FLTlcQInmfcgOufgrcCZA0JPGXe5NuAnfOMoEk/Lvxr7qqfe1QRMlLsJSlkwEvbviEYyo0YDyIC
 n7wH23k+atixklFkO3w+QxYhf8EWrfgrO2ve2SZnSCN2zTZuOLgDnNjBcDXg5u8V3HIndWUZj7m
 e6MLNol8R3NXLH+UWmb6WeF7ZKii8RlhCFMmN8cWosuSlPBeZQlLdMV78BzNg==
X-Received: by 2002:a05:6808:c40d:b0:496:fd2:94e8 with SMTP id
 5614622812f47-49fdc44d378mr5010912b6e.12.1783464524397; 
 Tue, 07 Jul 2026 15:48:44 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a1b07e329dsm487077b6e.17.2026.07.07.15.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 15:48:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymondmaoca@gmail.com>
Subject: [PATCH] bloblist: Rename GD_FLG_BLOBLIST_READY to
 GD_FLG_BLOBLIST_HANDOFF
Date: Tue,  7 Jul 2026 16:48:42 -0600
Message-ID: <20260707224842.261424-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Now that we have made bloblist have distinct "find" and "create"
functions, the global data tag "GD_FLG_BLOBLIST_READY" doesn't quite
make sense anymore. Rename it to GD_FLG_BLOBLIST_HANDOFF.

Suggested-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/bloblist.c                 | 8 ++++----
 include/asm-generic/global_data.h | 4 ++--
 include/bloblist.h                | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 51ae9cc50a5f..846c8047f746 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -448,7 +448,7 @@ int bloblist_new(ulong addr, uint size, uint flags, uint align_log2)
 	hdr->align_log2 = align_log2 ? align_log2 : BLOBLIST_BLOB_ALIGN_LOG2;
 	hdr->chksum = 0;
 	gd->bloblist = hdr;
-	gd->flags |= GD_FLG_BLOBLIST_READY;
+	gd->flags |= GD_FLG_BLOBLIST_HANDOFF;
 
 	return 0;
 }
@@ -476,7 +476,7 @@ int bloblist_check(ulong addr, uint size)
 		return log_msg_ret("Bad checksum", -EIO);
 	}
 	gd->bloblist = hdr;
-	gd->flags |= GD_FLG_BLOBLIST_READY;
+	gd->flags |= GD_FLG_BLOBLIST_HANDOFF;
 
 	return 0;
 }
@@ -627,7 +627,7 @@ int bloblist_init(void)
 	int ret;
 	ulong addr = 0, size = CONFIG_BLOBLIST_SIZE;
 
-	if (gd->flags & GD_FLG_BLOBLIST_READY) {
+	if (gd->flags & GD_FLG_BLOBLIST_HANDOFF) {
 		log_debug("Found existing bloblist size %x at %p\n",
 			  gd->bloblist->total_size, gd->bloblist);
 		return 0;
@@ -689,7 +689,7 @@ int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig, ulong xlist)
 	if (rfdt != (ulong)bloblist_find(BLOBLISTT_CONTROL_FDT, 0)) {
 		/* Remove this bloblist from gd */
 		gd->bloblist = NULL;
-		gd->flags &= ~GD_FLG_BLOBLIST_READY;
+		gd->flags &= ~GD_FLG_BLOBLIST_HANDOFF;
 		return -EIO;
 	}
 
diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index ad7ebb1bbc95..fd116b0cebf2 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -697,9 +697,9 @@ enum gd_flags {
 	 */
 	GD_FLG_DM_DEAD = 0x400000,
 	/**
-	 * @GD_FLG_BLOBLIST_READY: bloblist is ready for use
+	 * @GD_FLG_BLOBLIST_HANDOFF: bloblist has been found.
 	 */
-	GD_FLG_BLOBLIST_READY = 0x800000,
+	GD_FLG_BLOBLIST_HANDOFF = 0x800000,
 	/**
 	 * @GD_FLG_HUSH_OLD_PARSER: Use hush old parser.
 	 */
diff --git a/include/bloblist.h b/include/bloblist.h
index 4c5787729654..fcd290eeb165 100644
--- a/include/bloblist.h
+++ b/include/bloblist.h
@@ -516,7 +516,7 @@ bool bloblist_exists(void);
  * If CONFIG_BLOBLIST_PASSAGE_MANDATORY is selected, bloblist in the incoming
  * standard passage is mandatorily required.
  *
- * Sets GD_FLG_BLOBLIST_READY in global_data flags on success
+ * Sets GD_FLG_BLOBLIST_HANDOFF in global_data flags on success
  *
  * Return: 0 if OK, -ve on error
  */
-- 
2.43.0

