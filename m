Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B044DC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FBDB81DE3;
	Wed, 19 Mar 2025 15:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KoaktSAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1CF081F7B; Wed, 19 Mar 2025 15:56:13 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB4A482075
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so46861365e9.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396171; x=1743000971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/iWeCWAY/mTyLDDPesOMWF3WYvqswlhdDpwOPH0Em0=;
 b=KoaktSAq+vFQ5bMbCAQwtCDqb/BjQeaVeDW72p8M7GgUig1qLLTRjh46brcZ/GE9Lw
 Ha2iuMvtxo80/G4SEgwsKCRnSus8BMKVta7bzKU5kBXYH2Su1idbpGofzBG3OJCkjpB9
 Uwd6USw6MAZqexxl3RFUH5vfWOx4fXfdv/DqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396171; x=1743000971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/iWeCWAY/mTyLDDPesOMWF3WYvqswlhdDpwOPH0Em0=;
 b=kNMrrLu5fMB3wqF/5SdBqA5rHOvGrUw7K34laNrAkDUKfkP0uElwEYV/xcTOU/2lS+
 rnLyqN1G6dEHthqOq/m0yZp1g4Wb4ofLiUnTN/yKMjdcReOLjLpdrLARL3yKng8k6/no
 BaNmoLfiI4wUqvrkrdKxGIO4kDB68YN5m2Ew1YmV6LS9x5kH1WOdzr1s5REXw1oCi1fF
 a5rY1x7TNb4BaF2mTZbxXnWPC55ZNuaTzR21b9GZWKIUfgs3lDv/UL6JaRcFptIZjAjg
 IpskLMNMk2WXYTF4fWFQIeCivFbiUL8OAIgeAstWABi3YzNnNNN69v/PesNBNflskE2j
 jReA==
X-Gm-Message-State: AOJu0YzNr7bHN3naazlBHAaX0+VxDC0FJmWWUBrEeFyHO/ss5RSPHdwv
 /aEaSEEl+hTNlT+nqeacrBsxO3bgqGuDEvhfXb/bGasIo/233SDYj299mjl+J0knddjsQlAhdgM
 =
X-Gm-Gg: ASbGncvRJZyD50GrRY7G07aWt4d0LWSerj0yJX8xvSbQtqAB6apB5Y0GZCntGujNOeo
 VaeuN0AQ3+NRxlEJPvkvubYbKwUzz9/D7E5WZsIMEaQ86aXBMfVecvrMrdYzlJ+cjHVTBM4gpwS
 nkzbMJOgO6Zlc0NRJa+xyDU4xvvBP73FjsGP8BagHFoIiOcdofyouwnPGTh2vGKNWcppfvR6Oi+
 9+iR8dL0sp4fJ+l4tsrCOAFJSqy5jfHhlbAbKbYWH8c5OJWPBqhAwhXRIyd2sI3rbiY1NZodgr7
 pLIofMjus43//j2ub3GieyhMidJFoje68+r/JWIoSA==
X-Google-Smtp-Source: AGHT+IETLy434ujVEtWw424mqmhzq2qnK9bbi4Dl7SVqsUWFbiPkAM6beiWJAuB8jR6z3/r+FhnvVg==
X-Received: by 2002:a05:600c:5250:b0:43c:fc0c:7f33 with SMTP id
 5b1f17b1804b1-43d43781e4emr29601675e9.2.1742396170503; 
 Wed, 19 Mar 2025 07:56:10 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 23/52] expo: Allow adding a single bootflow to a menu
Date: Wed, 19 Mar 2025 15:54:28 +0100
Message-ID: <20250319145512.2391122-24-sjg@chromium.org>
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

Refactor bootflow_menu_add_all() to call a new bootflow_menu_add() to
add each of its bootflows.

Move the last_bootdev value into struct menu_priv to make this work.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

