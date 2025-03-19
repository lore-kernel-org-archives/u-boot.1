Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61565C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65148827C7;
	Wed, 19 Mar 2025 15:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XTUEFvoI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51AE082014; Wed, 19 Mar 2025 15:57:01 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3566C82115
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-390f5f48eafso4481463f8f.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396218; x=1743001018; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kqedQ2zaMKXDvggA16rak01Y0wu7SCpURs2+ATWKYYA=;
 b=XTUEFvoIHGlme1XgYr14+4BP8Aa8v6+51cTLURyJ6dQvHs0/FXZKZvA0Griw+qtX7e
 Hb97d9mi7wtKPBQUJ2UPaUIBSRuVrEckI5GA8VDjzfhReflqkca0ZjR95ZscX954Jib6
 pcT/qlL8UX2Fg6TxB2lK+rAu8wlECjyK5UIIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396218; x=1743001018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kqedQ2zaMKXDvggA16rak01Y0wu7SCpURs2+ATWKYYA=;
 b=LnskDeYkY2vnJ6dkrBXvGCP6vkLhUufabNKJU3P7keqglYYqrwefNTLnX39Qem9i1V
 jiF2hQd917Y3dL+swglaMZkA19Zc20xhXBrVNH23v1y0fX1MkIscJsy9HfZ44hE32Jzj
 pL5IwG4vj7YFhB3zvc+QVlnKUx4Oum7+/d2wqfEChtcl2s45nWVrKPI9bMs442yyab9d
 bX/DF5o0c4Xdnv7IMJVd+P3pXiAWQJWXSLXsE0U5Lhx3mudEg4af2juPyz1enkAnaaJy
 7NM7HBWnqjOJ2hQ/KOxfxNP/Li1B3ZAOfqoN0j0fRND/nwXaZjly25Y/bMvexwfW5SeX
 K+bw==
X-Gm-Message-State: AOJu0YxpnWb52Q7PY1g1NqAhe8IcePFGWslhfo0izlM3KOOaSXPOYGur
 vKMfGYaVUInbC5ny7qu9n8TpvVQwVBjh8Ihys8hEaK4XCa2MjtGIixgcyXlss/pd4wXGnYiC19Y
 =
X-Gm-Gg: ASbGncuORQvufBDFXeLNlnQnCKgR9maZsP6f/0hmvvb+d5SRhwKka762zY22vXuqG/k
 GhwgLQD5uw3scpIP4poqhFAocR7zATNH81Da/TXgwpjYlaiy6GYvIPKcFFDhoDe0oJyip/UPObL
 shEHKYe9qy9gSBAV3xpOwVInK3oS49B9oQ8wwbybcOu9jQgII+2pLMaeQJQCd1/PDUx/FTeooX3
 eb1Fvn8p7mVUn2WLyEYh5B67aKjra6Es4V6wT9KLyc5Do8jqTcacC7+qceeJrVLKwjLvYkpgvMU
 poWvcbbqs2QMLuV8n81ut60NEmnlcuA1cVPtGRKaFQ==
X-Google-Smtp-Source: AGHT+IE18S3KrvN3AZZr2bauG4rL/yTke+3Fy3qdJdlN2pnsJIih/qEYMg6yxqljY582zMZKVCBfkQ==
X-Received: by 2002:a05:6000:1a8f:b0:391:48f7:bd8a with SMTP id
 ffacd0b85a97d-399739eb225mr2684341f8f.30.1742396218033; 
 Wed, 19 Mar 2025 07:56:58 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 49/52] expo: Update bootflow_menu_poll() to return a sequence
 ID
Date: Wed, 19 Mar 2025 15:54:54 +0100
Message-ID: <20250319145512.2391122-50-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

Rather than returning a bootflow, return the index of the bootflow. This
will allow callers to do their own translation to bootflows or some
other data structure.

Also return a special code when the user tries to move the pointer, so
that the caller can cancel the boot-menu timeout, if this is in use.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow_menu.c | 32 +++++++++++++-------------------
 cmd/bootflow.c       | 12 +++++++-----
 include/bootflow.h   |  8 ++++----
 3 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index a44c340167c..7e131de3f6d 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -290,32 +290,26 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 	return 0;
 }
 
-int bootflow_menu_poll(struct expo *exp, struct bootflow **bflowp)
+int bootflow_menu_poll(struct expo *exp, int *seqp)
 {
 	struct bootflow *sel_bflow;
 	struct expo_action act;
-	int ret;
+	struct scene *scn;
+	int item;
 
 	sel_bflow = NULL;
-	*bflowp = NULL;
+
+	scn = expo_lookup_scene_id(exp, exp->scene_id);
+
+	item = scene_menu_get_cur_item(scn, OBJ_MENU);
+	*seqp = item > 0 ? item - ITEM : -1;
 
 	LOGR("bmp", expo_poll(exp, &act));
 
 	switch (act.type) {
-	case EXPOACT_SELECT: {
-		struct bootflow *bflow;
-		int i;
-
-		for (ret = bootflow_first_glob(&bflow), i = 0; !ret && i < 36;
-		     ret = bootflow_next_glob(&bflow), i++) {
-			if (i == act.select.id - ITEM) {
-				*bflowp = bflow;
-				// printf("found %p\n", bflow);
-				return 0;
-			}
-		}
+	case EXPOACT_SELECT:
+		*seqp = act.select.id - ITEM;
 		break;
-	}
 	case EXPOACT_POINT_ITEM: {
 		struct scene *scn = expo_lookup_scene_id(exp, MAIN);
 
@@ -323,13 +317,13 @@ int bootflow_menu_poll(struct expo *exp, struct bootflow **bflowp)
 			return log_msg_ret("bms", -ENOENT);
 		LOGR("bmp", scene_menu_select_item(scn, OBJ_MENU,
 						   act.select.id));
-		break;
+		return -ERESTART;
 	}
 	case EXPOACT_QUIT:
 		return -EPIPE;
 	default:
-		break;
+		return -EAGAIN;
 	}
 
-	return -EAGAIN;
+	return 0;
 }
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index b8f61f966fb..3c367a10c8a 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -109,15 +109,16 @@ __maybe_unused static int bootflow_handle_menu(struct bootstd_priv *std,
 {
 	struct expo *exp;
 	struct bootflow *bflow;
-	int ret;
+	int ret, seq;
 
 	LOGR("bhs", bootflow_menu_start(std, text_mode, &exp));
 
+	ret = -ERESTART;
 	do {
-		LOGR("bhr", expo_render(exp));
-		ret = bootflow_menu_poll(exp, &bflow);
-	} while (ret == -EAGAIN);
-	// printf("ret %d bflow %p\n", ret, bflow);
+		if (ret == -ERESTART)
+			LOGR("bhr", expo_render(exp));
+		ret = bootflow_menu_poll(exp, &seq);
+	} while (ret == -EAGAIN || ret == -ERESTART);
 
 	if (ret == -EPIPE) {
 		printf("Nothing chosen\n");
@@ -125,6 +126,7 @@ __maybe_unused static int bootflow_handle_menu(struct bootstd_priv *std,
 	} else if (ret) {
 		printf("Menu failed (err=%d)\n", ret);
 	} else {
+		bflow = alist_getw(&std->bootflows, seq, struct bootflow);
 		printf("Selected: %s\n", bflow->os_name ? bflow->os_name :
 		       bflow->name);
 		std->cur_bootflow = bflow;
diff --git a/include/bootflow.h b/include/bootflow.h
index aa46cec4979..8362cbe2e69 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -671,10 +671,10 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
  * bootflow_menu_poll() - Poll a menu for user action
  *
  * @exp: Expo to poll
- * @bflowp: Returns chosen bootflow (set to NULL if nothing is chosen)
- * Return 0 if a bootflow was chosen, -EAGAIN if nothing is chosen yet, -EPIPE
- *	if the user quit
+ * @seqp: Returns the bootflow chosen or currently pointed to (numbered from 0)
+ * Return: 0 if a bootflow was chosen, -EAGAIN if nothing is chosen yet, -EPIPE
+ *	if the user quit, -ERESTART if the expo needs refreshing
  */
-int bootflow_menu_poll(struct expo *exp, struct bootflow **bflowp);
+int bootflow_menu_poll(struct expo *exp, int *seqp);
 
 #endif
-- 
2.43.0

