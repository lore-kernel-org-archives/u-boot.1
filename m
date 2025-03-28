Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F65C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA61D81ECD;
	Fri, 28 Mar 2025 14:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dbgkawO1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 813AC820E3; Fri, 28 Mar 2025 14:08:12 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1687081273
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-85ae4dc67e5so77353839f.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167288; x=1743772088; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6AfbQctFtF3xRPFu4tl+nd3ph+YsNMWNFJa0S0fvcUQ=;
 b=dbgkawO1y1yZI/y9oDqY9JC3P98N8swm5tNrAJXocI6zocOxhCWPkTovvIP0rdPOU1
 mw9kitneYAcfbYLZmDM3pUwUanYQXLPYf0bhLB6SP1j6YIZPfB0kPFzm6/i1B6IEjgOM
 bbK/QSkaDh0d5o/HYunhcbroquyXO8IER/hFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167288; x=1743772088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6AfbQctFtF3xRPFu4tl+nd3ph+YsNMWNFJa0S0fvcUQ=;
 b=Xlr6g2CrD1YvibpnbJIZvzBeOSr6Z8Gw3QC369F83VMWKBcdjGtXoHUDp2vA+5wvz9
 exXvp3gFxjM3eW4G0s/RSgBhkdUUwNrdOfomqOspuj2y5smflNUEqaw9t7s+wav03+GD
 l8GO/0uZGcmT8JY5YYpIw2rUY8xxlmJey2o3GIHmqKSj8cVVUlUyccLhztihveUpNrrd
 7N1ZaW3GmYbvbgoGHGGUz9bgnHW+XWSZuDzS6ZoFjRm+U2YKekQcP0EivNJpF214cX3c
 jZhzxV3PX3WVnlbidWJavh+O57W5mlFirsyux5Xp+b6bDR8ssKTa1MHNwu/XMUgI/pda
 SN2Q==
X-Gm-Message-State: AOJu0Ywc6H5IxGDX/gfsi2Pen7FBgIoOpmRZE918NVLwBd/ZkhZ6GbUB
 XIh/b4boixhurqGcT8XS49oUVEggMutuKxAq8qAn0OT4miCzYaxWQvJeuDObqh5cEI/an4qlDWQ
 =
X-Gm-Gg: ASbGnculJ4/l+SZSMu6ruqMncS9EzA2dJfXC1nuNaE5v8dBF+t1QLcZF0KD7rCEC496
 c7I4JAzZbdDRQ2nJza5W7p+xD6IAXqKviJwCWkxwicT/J9sQPHMee0ya8nU/vcK0qcdqT6wgQ3Y
 qGOeli9yr5DDDrLUcBTBCNgdicSppPSDCtihwjXvWdB6di0u0sPgXFU8K6XpidWr+/X54H+oNKS
 /Pm2Fb+fTXT/Gxr9Xm+jmgNF9sl2toHK7AViGgS45Qy1vbK4yB+eoCoxte1Ajt2TkDiGoJLtHJs
 KsZ1ZTe2SeTEFy49RmRqG1umLxoBWeUGAvF+OlDEfIKz+ncaO1TsRqqHmN6wTbTnrxixJU9Ou+w
 CWsifsw==
X-Google-Smtp-Source: AGHT+IGLn4cGjmNIXpxU/j9xdhZ+yQEwI2VwtHP9yg7g/m1fZfb0Zz7CjzbCMfvd7an5gn8G9QhNfw==
X-Received: by 2002:a05:6e02:17cd:b0:3d2:b0f1:f5bd with SMTP id
 e9e14a558f8ab-3d5ccdc061emr69341375ab.3.1743167288024; 
 Fri, 28 Mar 2025 06:08:08 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 27/56] expo: Allow adding a single bootflow to a menu
Date: Fri, 28 Mar 2025 07:06:14 -0600
Message-ID: <20250328130713.2612648-28-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

Refactor bootflow_menu_add_all() to call a new bootflow_menu_add() to
add each of its bootflows.

Move the last_bootdev value into struct menu_priv to make this work.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 102 ++++++++++++++++++++++++-------------------
 include/bootflow.h   |  16 +++++++
 2 files changed, 73 insertions(+), 45 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 9b97156d943..19cd84e6454 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -25,9 +25,11 @@
  * struct menu_priv - information about the menu
  *
  * @num_bootflows: Number of bootflows in the menu
+ * @last_bootdev: bootdev of the last bootflow added to the menu, NULL if none
  */
 struct menu_priv {
 	int num_bootflows;
+	struct udevice *last_bootdev;
 };
 
 int bootflow_menu_new(struct expo **expp)
@@ -77,14 +79,16 @@ int bootflow_menu_new(struct expo **expp)
 	return 0;
 }
 
-int bootflow_menu_add_all(struct expo *exp)
+int bootflow_menu_add(struct expo *exp, struct bootflow *bflow, int seq,
+		      struct scene **scnp)
 {
 	struct menu_priv *priv = exp->priv;
-	struct udevice *last_bootdev;
-	struct bootflow *bflow;
+	char str[2], *label, *key;
 	struct scene *scn;
+	uint preview_id;
 	uint scene_id;
-	int ret, i;
+	bool add_gap;
+	int ret;
 
 	ret = expo_first_scene_id(exp);
 	if (ret < 0)
@@ -92,13 +96,57 @@ int bootflow_menu_add_all(struct expo *exp)
 	scene_id = ret;
 	scn = expo_lookup_scene_id(exp, scene_id);
 
-	last_bootdev = NULL;
+	*str = seq < 10 ? '0' + seq : 'A' + seq - 10;
+	str[1] = '\0';
+	key = strdup(str);
+	if (!key)
+		return log_msg_ret("key", -ENOMEM);
+	label = strdup(dev_get_parent(bflow->dev)->name);
+	if (!label) {
+		free(key);
+		return log_msg_ret("nam", -ENOMEM);
+	}
+
+	add_gap = priv->last_bootdev != bflow->dev;
+	priv->last_bootdev = bflow->dev;
+
+	ret = expo_str(exp, "prompt", STR_POINTER, ">");
+	ret |= scene_txt_str(scn, "label", ITEM_LABEL + seq,
+			      STR_LABEL + seq, label, NULL);
+	ret |= scene_txt_str(scn, "desc", ITEM_DESC + seq, STR_DESC + seq,
+			    bflow->os_name ? bflow->os_name :
+			    bflow->name, NULL);
+	ret |= scene_txt_str(scn, "key", ITEM_KEY + seq, STR_KEY + seq, key,
+			      NULL);
+	preview_id = 0;
+	if (bflow->logo) {
+		preview_id = ITEM_PREVIEW + seq;
+		ret |= scene_img(scn, "preview", preview_id,
+				     bflow->logo, NULL);
+	}
+	ret |= scene_menuitem(scn, OBJ_MENU, "item", ITEM + seq,
+				  ITEM_KEY + seq, ITEM_LABEL + seq,
+				  ITEM_DESC + seq, preview_id,
+				  add_gap ? SCENEMIF_GAP_BEFORE : 0,
+				  NULL);
+
+	if (ret < 0)
+		return log_msg_ret("itm", -EINVAL);
+	priv->num_bootflows++;
+	*scnp = scn;
+
+	return 0;
+}
+
+int bootflow_menu_add_all(struct expo *exp)
+{
+	struct bootflow *bflow;
+	struct scene *scn;
+	int ret, i;
+
 	for (ret = bootflow_first_glob(&bflow), i = 0; !ret && i < 36;
 	     ret = bootflow_next_glob(&bflow), i++) {
 		struct bootmeth_uc_plat *ucp;
-		char str[2], *label, *key;
-		uint preview_id;
-		bool add_gap;
 
 		if (bflow->state != BOOTFLOWST_READY)
 			continue;
@@ -108,43 +156,7 @@ int bootflow_menu_add_all(struct expo *exp)
 		if (ucp->flags & BOOTMETHF_GLOBAL)
 			continue;
 
-		*str = i < 10 ? '0' + i : 'A' + i - 10;
-		str[1] = '\0';
-		key = strdup(str);
-		if (!key)
-			return log_msg_ret("key", -ENOMEM);
-		label = strdup(dev_get_parent(bflow->dev)->name);
-		if (!label) {
-			free(key);
-			return log_msg_ret("nam", -ENOMEM);
-		}
-
-		add_gap = last_bootdev != bflow->dev;
-		last_bootdev = bflow->dev;
-
-		ret = expo_str(exp, "prompt", STR_POINTER, ">");
-		ret |= scene_txt_str(scn, "label", ITEM_LABEL + i,
-				      STR_LABEL + i, label, NULL);
-		ret |= scene_txt_str(scn, "desc", ITEM_DESC + i, STR_DESC + i,
-				    bflow->os_name ? bflow->os_name :
-				    bflow->name, NULL);
-		ret |= scene_txt_str(scn, "key", ITEM_KEY + i, STR_KEY + i, key,
-				      NULL);
-		preview_id = 0;
-		if (bflow->logo) {
-			preview_id = ITEM_PREVIEW + i;
-			ret |= scene_img(scn, "preview", preview_id,
-					     bflow->logo, NULL);
-		}
-		ret |= scene_menuitem(scn, OBJ_MENU, "item", ITEM + i,
-					  ITEM_KEY + i, ITEM_LABEL + i,
-					  ITEM_DESC + i, preview_id,
-					  add_gap ? SCENEMIF_GAP_BEFORE : 0,
-					  NULL);
-
-		if (ret < 0)
-			return log_msg_ret("itm", -EINVAL);
-		priv->num_bootflows++;
+		LOGR("bao", bootflow_menu_add(exp, bflow, i, &scn));
 	}
 
 	ret = scene_arrange(scn);
diff --git a/include/bootflow.h b/include/bootflow.h
index 5f65129ca65..aa46cec4979 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -15,6 +15,7 @@
 
 struct bootstd_priv;
 struct expo;
+struct scene;
 
 enum {
 	BOOTFLOW_MAX_USED_DEVS	= 16,
@@ -507,6 +508,21 @@ int bootflow_menu_new(struct expo **expp);
  */
 int bootflow_menu_add_all(struct expo *exp);
 
+/**
+ * bootflow_menu_add() - Add a bootflow to a menu
+ *
+ * Adds a new bootflow to the end of a menu. The caller must be careful to pass
+ * seq=0 for the first bootflow added, 1 for the second, etc.
+ *
+ * @exp: Menu to update
+ * @bflow: Bootflow to add
+ * @seq: Sequence number of this bootflow (0 = first)
+ * @scnp: Returns a pointer to the scene
+ * Return 0 on success, -ve on error
+ */
+int bootflow_menu_add(struct expo *exp, struct bootflow *bflow, int seq,
+		      struct scene **scnp);
+
 /**
  * bootflow_menu_apply_theme() - Apply a theme to a bootmenu
  *
-- 
2.43.0

