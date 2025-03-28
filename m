Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E864FC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF4DE8206E;
	Fri, 28 Mar 2025 14:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c6OPpAFy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 236F7820E3; Fri, 28 Mar 2025 14:08:12 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B6E982033
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-85db3475637so100011339f.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167286; x=1743772086; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXn7pN/mWBgoxVmi+Zll8fNmlBjiENKA1/vV4n4OWyg=;
 b=c6OPpAFylX1cAFX2x4MVOUhdurW72m7Jlxk2zOvb+xKp+XQ9OP4p2++MKwHjwaeXPF
 Kfp5MLNBRvJRBVzaBXmsekI1O7YkAF6o8lYtja/1PmG9EOnGDwGsxFF2FYTfXWX9ZbLC
 9738x46h1knTgws/jdt4fTPNfeHkqHyRXt7tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167286; x=1743772086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TXn7pN/mWBgoxVmi+Zll8fNmlBjiENKA1/vV4n4OWyg=;
 b=jrv2JWbMfF66Uwvl9mA3eyzRDN9ZHjM2g6M2pyuhUmN674bjN2n3KaKffmF257dVG3
 xf+1ShB2OdnKSftokTGS/nX+fGjzd6VReiQi8Y2oi3ZsfToTEHzokzNTgfhZVWXeZiD/
 eHsUYeZ9nyr/4bNwo+BUkZmXSNUf0teFkPiB84/DrtexGc4kM9+H/mrqIwxwcSuzr/RK
 J1kU+NgTWi7fK/eSYdUDU/U7MXXBQn/OxTCyLCx5c1H6rLWTx5nCsxgYL/ExVTxRnNxE
 L6USUJ3rCOoOvYev8u+WCQRI0eCLUbKJBqWyMFxFTjO2x/blyA8FpUhpno6MXUeRAAiF
 areA==
X-Gm-Message-State: AOJu0Yz3FBoJmR4HCAZe+8QowQkdAWypqehXTp0nq3UGfzJrYVMMW4SA
 lzqeDtl8SUBtaBUkaNKkmIKT1JHkJhzmFz2xuJvRnMZXD/Bsw8nolFgUNR1baZbzFVENc3WMkys
 =
X-Gm-Gg: ASbGncu254mrMa/7n0KRtv4hVUxbVGzHcZfm1M3YlS3iMj7KJGr6HpCLPUPg6/KsRTi
 jSgr3828uytauIDwTZlhNrLNFnZraiABNXSLNKw5uA8isSbgS+dYv183PZT3t8qdZM5phs/GPf6
 umva5W3DpqIVhRbHlR58W3Dv6+n90E5HEYGSHrRf7S7Ew+6InxXF4DAnEznn00QvY0ZQIvBfEVu
 +SMfFx9j2BGQapZOCzMseO7UhCbGM8WCSN17ALYVK3APUeD+zvlZmudna9zKytB+ReZMec6cao4
 TTxBJNP7K1etxdxJdFqE7hUGatVjptAw7JjQmYkOlhJOVIJPc5p3tCFvWVN29LKc8TUhQGkKjvE
 q/3YrgQ==
X-Google-Smtp-Source: AGHT+IG90pzWzKcVLBcpby+2oGVjiQKIw5rehkvemdvPor3r2rh9pGyLsaL4DpmcoMQ2qUVQa8tSoA==
X-Received: by 2002:a05:6602:180b:b0:85e:73da:c56a with SMTP id
 ca18e2360f4ac-85e91e10d2emr210384939f.3.1743167286383; 
 Fri, 28 Mar 2025 06:08:06 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 26/56] expo: Split bootflow_menu_new() into two pieces
Date: Fri, 28 Mar 2025 07:06:13 -0600
Message-ID: <20250328130713.2612648-27-sjg@chromium.org>
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

Split the iteration piece of this function into bootflow_menu_add_all()
so that it is possible for the caller to be in control of adding items
to the menu.

Move the expo_destroy() call into the caller.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 31 +++++++++++++++++++++++--------
 include/bootflow.h   | 13 +++++++++++++
 test/boot/bootflow.c |  1 +
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 018910c65b8..9b97156d943 100644
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
 
@@ -182,9 +198,8 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 	struct expo *exp;
 	int ret;
 
-	ret = bootflow_menu_new(&exp);
-	if (ret)
-		return log_msg_ret("exp", ret);
+	LOGR("bmn", bootflow_menu_new(&exp));
+	LOGR("bma", bootflow_menu_add_all(exp));
 
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

