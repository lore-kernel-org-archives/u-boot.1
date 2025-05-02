Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8964C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F76582B07;
	Fri,  2 May 2025 16:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hxbevsYC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4927681F7E; Fri,  2 May 2025 16:48:27 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E26B382B16
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85df99da233so217198339f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197303; x=1746802103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jl4oBVPxldiqNRjnjIVGXUtvrRxAqbWtRg0O1eZWOWI=;
 b=hxbevsYC2UwFxnBMdI5+xWVcW07VJkq++qMgUUyOPoae6wlWpMJUcCXZNjO5NljVAO
 zr2EIWcc1GVpNR7zpF17tjEAyNurcZqjJPGJ8rno142jIsqmrjH2SUuNiozgRu62qDFP
 Ph20OlYuxgbHcmr7xgHyAADBLCehP76wWD+nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197303; x=1746802103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jl4oBVPxldiqNRjnjIVGXUtvrRxAqbWtRg0O1eZWOWI=;
 b=D/ZtRiu7/ISW86lGOMDPm2UVcl0/uBERVabCB4h0+9fulE7afaHgZLNrbLyiBbdV8S
 WgMzfCMymyXuGpssX4qQ1uuPFcpwv8RZ6xUQu7Lq54VNqJNXwrTB/zCS6/ce5UEZqIeF
 u14kQVS0lI6NOP73ADTF52HJK44rkSpAe1sPKcFKChcdwaTaI0xsrKLp62JwIILri5w2
 7+eBFuh7CHZvt9gILwD66Rdi8EJDvaA3FHqF62S4NMDdYizHcJLLlGTygRvZEl68+eyT
 KulaFykceJRCVUXxByOW6d1zJ9NZMsnzPvEjIfX/A+P/+9SjghjmRopQDTnBRfwAjc83
 oMaQ==
X-Gm-Message-State: AOJu0Yx0J2RLVhYsujgAFli4Emdg7Gx+UwlZ68nTi7hkAoJuEJzBEoEw
 2xLgrzyigtgipLL/ecwsYOEXs6Tb/fM1/yATo+bzfu/Hqfxeiyv1PjMg7JxJp3d7HLNKNqsKrnw
 =
X-Gm-Gg: ASbGncsP/dwS1GgpdK/tj8H9cnrUUnCOkNevy97BQyEhM4KP2havsyBWVWpsYhMYvGk
 qT9cXwaAgXBWwb/bdGyY9v5WeytXuAt5o1hU7egeEaMW/wTOCoLaPOJX9q/5JRsFQlcQMeT97i/
 krP8MSUlFilgN1H+C1WzrmDv4cBbXcH4eVWfIIcGZKh1zElJ5V8ivbqFJfnl+7+PeU+Xqt7MLpx
 c9V88ayfF+bFA7X5Qho7Fw57Ca2ixgB/+ESnkY7Mfzy3VoptlFy6TF+3N1ggyMLnfO/9c5TsFML
 yo8e8CZqZ9/Wc1BkyKdT9uRqBgWdMRr/6u3v1Y2og65Z21A8vU/7nW6MKQYTEQLARHGCCkOUqu9
 PPg==
X-Google-Smtp-Source: AGHT+IEzB3KYUGRF1I4j0//OADzLao0Y958tYn9lGkBN8O1VJMdb6aZlJJZZ5S9X5vU0INnv5dJRdQ==
X-Received: by 2002:a05:6602:3990:b0:862:ec81:ad2e with SMTP id
 ca18e2360f4ac-8669f988db3mr470857439f.3.1746197302761; 
 Fri, 02 May 2025 07:48:22 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 31/60] expo: Allow adding a single bootflow to a menu
Date: Fri,  2 May 2025 08:46:29 -0600
Message-ID: <20250502144718.313633-32-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

 boot/bootflow_menu.c | 103 +++++++++++++++++++++++++------------------
 include/bootflow.h   |  16 +++++++
 2 files changed, 75 insertions(+), 44 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index f731d7858b2..6a37fa8fa68 100644
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
@@ -108,43 +156,10 @@ int bootflow_menu_add_all(struct expo *exp)
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
+		ret = bootflow_menu_add(exp, bflow, i, &scn);
+		if (ret)
+			return log_msg_ret("bao", ret);
 
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

