Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E00FC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 255D782B27;
	Fri,  2 May 2025 16:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FveIs2xk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF5482B16; Fri,  2 May 2025 16:48:24 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18E8A82AEF
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-864687c830aso195215939f.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197300; x=1746802100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3sqZHSsXG2qPzLj1i5uF8YIs13q+TJO0Ec26erRtmkQ=;
 b=FveIs2xkHlzDZFu2Z/8tIHk6LpCSBy28v7dgu7kzRn1c65GzpKRAsR6LsV8mjwYjuH
 H3H+m8J1lQQEac7LxuZQDz904QxwnFnL1+SOgoHPUUjeFb3+tsp8s9SGKGraT3YOK/rC
 7ySvbn8KVWOnF6gnEGRulDRiRnP9pOAEX2mqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197300; x=1746802100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3sqZHSsXG2qPzLj1i5uF8YIs13q+TJO0Ec26erRtmkQ=;
 b=pNf1Qjbs4e6QUCkgue3p9syo3VvyXK4qVqV5S0NMGIU7NrMYObdDBIu9XB4rvsouw+
 nQk02oLUvIWy9v4CyTMncKskSRdm8E4SWh+cKcBRctTQ8izjbmbPNa16ar56j/8DVGiS
 LCoF69ARcLEkUcwcagOBl37Wpd92zDJr0nsxnrw/7Jh/TQJjlrF2xnJv+grw1L/hBXCQ
 zDU21SLJtye/E3ipGQ/i0FRkUArhGjjdgZozTq/V8rpPX6ep+ndDtnrmJ9upWsTLfzQk
 NWSofNv4nraW2+XPcUDZNLc48QGIKSyFkyjbQs1nQCp6upnG0g4XNj9pbE7lm6dLHGK5
 tdRg==
X-Gm-Message-State: AOJu0YzEDYMMl9yZQqLVDvyuF+XAe0MGIJMrBIHAk4GE7bdGZgQzETxU
 Q1oOBYujqYyuiTTCQF8xrWGC5rVULLsa7o8BFdLDfoaBViE5UlDYJB7KAR2KWnDalIxbLy3sVY4
 =
X-Gm-Gg: ASbGnctOQEK7gCS6LIaJn4p9+vS69CEzi649aR4OM2gKHNkWRhlJsElyDRFbQ+DJ1aw
 ROfqYQEiw+EuhBu2+i7VoXFEcQWmKipLfw7oIOvjEjvAJuQZAMPbTQG6yLT0ZFJvWZW3IyZih6a
 fJPgmnpxq6o9FDbzoHw1kWUxulLk3pA7t4HgOPs+RZlU2iyRazTSnc1OyLrIYma/Aa37n97sK5x
 AxLvX8O4ZcC9rYywLCa5DakR3sQHICnKu0NLlpZ+rKHTHY1XBTZlhvSzB1Vu/fx+lHcUG+JjfJl
 mLAMjp9ulBocM5Uwfz3ufWA/j2sHe+gVvbPMq0SzUo4CAtG03/QHp3Desj0DiJljcoXb2YgQODU
 KJQ==
X-Google-Smtp-Source: AGHT+IGgWT4X+dChS57ltJjsGNWdkK+bBRcH76JykBNd9jp9cbMpdX5iOe4SnQuOM9iKjZOsuLP+Pg==
X-Received: by 2002:a05:6602:3718:b0:85c:c7f9:9a1c with SMTP id
 ca18e2360f4ac-866b4a7c862mr401307839f.13.1746197300138; 
 Fri, 02 May 2025 07:48:20 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 30/60] expo: Split bootflow_menu_new() into two pieces
Date: Fri,  2 May 2025 08:46:28 -0600
Message-ID: <20250502144718.313633-31-sjg@chromium.org>
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

Split the iteration piece of this function into bootflow_menu_add_all()
so that it is possible for the caller to be in control of adding items
to the menu.

Move the expo_destroy() call into the caller.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 31 +++++++++++++++++++++++++------
 include/bootflow.h   | 13 +++++++++++++
 test/boot/bootflow.c |  1 +
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index ed7c0768c7b..f731d7858b2 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -32,14 +32,12 @@ struct menu_priv {
 
 int bootflow_menu_new(struct expo **expp)
 {
-	struct udevice *last_bootdev;
 	struct scene_obj_menu *menu;
 	struct menu_priv *priv;
-	struct bootflow *bflow;
 	struct scene *scn;
 	struct expo *exp;
 	void *logo;
-	int ret, i;
+	int ret;
 
 	priv = calloc(1, sizeof(*priv));
 	if (!priv)
@@ -74,6 +72,26 @@ int bootflow_menu_new(struct expo **expp)
 	if (ret < 0)
 		return log_msg_ret("new", -EINVAL);
 
+	*expp = exp;
+
+	return 0;
+}
+
+int bootflow_menu_add_all(struct expo *exp)
+{
+	struct menu_priv *priv = exp->priv;
+	struct udevice *last_bootdev;
+	struct bootflow *bflow;
+	struct scene *scn;
+	uint scene_id;
+	int ret, i;
+
+	ret = expo_first_scene_id(exp);
+	if (ret < 0)
+		return log_msg_ret("scn", ret);
+	scene_id = ret;
+	scn = expo_lookup_scene_id(exp, scene_id);
+
 	last_bootdev = NULL;
 	for (ret = bootflow_first_glob(&bflow), i = 0; !ret && i < 36;
 	     ret = bootflow_next_glob(&bflow), i++) {
@@ -133,8 +151,6 @@ int bootflow_menu_new(struct expo **expp)
 	if (ret)
 		return log_msg_ret("arr", ret);
 
-	*expp = exp;
-
 	return 0;
 }
 
@@ -184,7 +200,10 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 
 	ret = bootflow_menu_new(&exp);
 	if (ret)
-		return log_msg_ret("exp", ret);
+		return log_msg_ret("bmn", ret);
+	ret = bootflow_menu_add_all(exp);
+	if (ret)
+		return log_msg_ret("bma", ret);
 
 	if (ofnode_valid(std->theme)) {
 		ret = bootflow_menu_apply_theme(exp, std->theme);
diff --git a/include/bootflow.h b/include/bootflow.h
index 72f09304cff..5f65129ca65 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -489,11 +489,24 @@ int bootflow_iter_check_system(const struct bootflow_iter *iter);
 /**
  * bootflow_menu_new() - Create a new bootflow menu
  *
+ * This is initially empty. Call bootflow_menu_add_all() to add all the
+ * bootflows to it.
+ *
  * @expp: Returns the expo created
  * Returns 0 on success, -ve on error
  */
 int bootflow_menu_new(struct expo **expp);
 
+/**
+ * bootflow_menu_add_all() - Add all bootflows to a menu
+ *
+ * Loops through all bootflows and adds them to the menu
+ *
+ * @exp: Menu to update
+ * Return 0 on success, -ve on error
+ */
+int bootflow_menu_add_all(struct expo *exp);
+
 /**
  * bootflow_menu_apply_theme() - Apply a theme to a bootmenu
  *
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index cbb5bcc0cf3..572851761c5 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -881,6 +881,7 @@ static int bootflow_menu_theme(struct unit_test_state *uts)
 	ut_assertok(scan_mmc4_bootdev(uts));
 
 	ut_assertok(bootflow_menu_new(&exp));
+	ut_assertok(bootflow_menu_add_all(exp));
 	node = ofnode_path("/bootstd/theme");
 	ut_assert(ofnode_valid(node));
 	ut_assertok(bootflow_menu_apply_theme(exp, node));
-- 
2.43.0

