Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9E3C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C49C82114;
	Wed, 19 Mar 2025 15:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ADRjrwD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A967820F0; Wed, 19 Mar 2025 15:56:12 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC6981DCC
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3996af42857so584633f8f.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396169; x=1743000969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3N8QTPYPxSV1NCOm4MKGrSd1/+i5anQSdRxIwyT3FC8=;
 b=ADRjrwD6sg0xhiDuCOiNADBULeH6q8SdTG3qgvdHbFqUS2nj6Ae/CWdwM8sDEXErLA
 l9Xbn2m+avpWsQm2RJ+TuM8nv3TuusBYuWoK/kkKXd9d4eRgIeN5PGouj2M/PZ1K60yN
 Sk+uLH0OLWHNztMHi+MWtLa82QHbbwie3dVb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396169; x=1743000969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3N8QTPYPxSV1NCOm4MKGrSd1/+i5anQSdRxIwyT3FC8=;
 b=XKTdx0ovBN0gGCg+ciOnzcWO6hS/AVbc/ttftfXB0JNCrcFo/lsQKgr3iPmOZ4wGe9
 AZhp+cy8gF6+0nuUd65d8TBmQA24+/HUus9FgfcbWN+RPGqfgAFMHIqBGjIt5IMSG8zo
 dp0ze8YaDUdfe3CizzjGUrp2WaaL1yC7glJqi0fNzQnrg6l/60pTI/Ahryrd0qAa27+w
 +SX5fQfLcvZwnrBML7gWvllRSURuTr/sS6Jq0e5BL90OY+pgBAREm567ibN8yRnD07ci
 xHgzX3b/rpXWgZQhZxt6pgrMJF1ZZD1zAQA1E2sBcbfi85fvo2xwpPllA6qedB8Eqwc5
 4XAg==
X-Gm-Message-State: AOJu0YwR1Iso1rpmj7XJXV/YTanrUXivsD3vAyMKUaK0t/GUf+RXzVcK
 B20JFQkzLQMN2/kaBw/agOvVqsF1H4yZxokoR0Sy5rsVDl0ZYOiY+kb2MgdPtxaNqNUz03qrCqA
 =
X-Gm-Gg: ASbGnctWMuoU5aUWVk+fZ4UFqEs8DPyOnZuAI2lwLEZfl29GbfdlUWr8wxLXwqL7Ioq
 vqhf8kOOjSO788bXWBf8CvZCDZ9PmjbtZ1rItPlIsfV4ex7BDadVKJptTDtKiX9xneiRNM5A/Yt
 ZdrE8Lvb/ip8lfl9pfGYIpBf9AClfWQVth0PDTMPboptmYruHgCB8Kq2t74FBE+2vV7MyHbC7k/
 neO63IOoatYecR6eGgYUEPOsdnk5gXnJxEnHP+H0dDXezeou2Le89XnB2ZRH/q7rDHQbetwCeVs
 ka+vFMwwB94DZlVXsnOIbHndMQDUMgmGgmtaFMB5tdZfeCxsHOCq
X-Google-Smtp-Source: AGHT+IHPv3D+eEui8X6qySickVDbBTW4jb4pIfzks34JMZ9lBKzzx6fhHBSNDH8DZp5iAWc5xq2cVw==
X-Received: by 2002:a05:6000:178c:b0:391:a74:d7e2 with SMTP id
 ffacd0b85a97d-3996bb82a36mr6392533f8f.26.1742396168897; 
 Wed, 19 Mar 2025 07:56:08 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 22/52] expo: Split bootflow_menu_new() into two pieces
Date: Wed, 19 Mar 2025 15:54:27 +0100
Message-ID: <20250319145512.2391122-23-sjg@chromium.org>
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

Split the iteration piece of this function into bootflow_menu_add_all()
so that it is possible for the caller to be in control of adding items
to the menu.

Move the expo_destroy() call into the caller.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

