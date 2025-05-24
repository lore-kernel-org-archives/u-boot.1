Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217A2C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 15:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E97D82F67;
	Sat, 24 May 2025 17:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cEiaBFht";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 575C582D06; Sat, 24 May 2025 17:41:26 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23EEB82B70
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 17:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3dc8265b9b5so7544375ab.1
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748101282; x=1748706082; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/Lv5fMlQTsoT7rGddNOWjuMZbJfQJ8yBWJwo744fNr4=;
 b=cEiaBFhtZe1Nqi0jqjtOGtUVI2Vzr+8eahfLEfxrYTKwRcdZ6hReyEbuKOqe4IwkVR
 1jAehBIcp7okNQTUvot7DG9m2KR760WfQlYQVMmTT3ES5dFpncguci+U2b5wXruo2LPw
 6FEGP9wrFQwz+5e6XdD3+ov0J81HaM2qcdIes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748101282; x=1748706082;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Lv5fMlQTsoT7rGddNOWjuMZbJfQJ8yBWJwo744fNr4=;
 b=G5+n82Dh2zLj7acgCQZSnlkHhF/gQMJuGjpUjksO+t4erzWMw+cCShBx7Oih7WXaVx
 w1YzTcbReznuW+gWO1gyaZ7vWGeAQxmL0XUH8dbW88C9VnaeYF6X0yqhGzetdtMlXc1B
 Z6m/H60QNpqOc7LIaHMscmRENT7veAtBwWgw9A79Rp7qLRzVzr+bWkdi4cZ20Vz56hu1
 /nOUB7tFRKePkW+jim8oxSSTcjp2hp5IuZiHTA1U9Kk4Z7TEVfsvd3N57kjuDRK64y//
 mi18FTg/4s+4qHmuy2tCwfNPeUNvuZhgGW0xCf6Qj4lNfv+g2lrgCBllyhMqIfkAqY2Z
 /4ZQ==
X-Gm-Message-State: AOJu0YzvSzY491nLbYq2VetYjOsPiPFD2l7l03xEqqQkK5FYH4uZkeoW
 n0KKlip7iIgzrEqmPwo8R/1/cPT+GrgN9qnRkJ4pREolc9k1ksevBVwW3hGxsaFdxi8CjBXiHXf
 nnMeFdxIT
X-Gm-Gg: ASbGncubdNmvs0Wz90wGxF7wDeLZUl4NC0NKRTsn3N6M5K0scuIV8+9TcBfZg4la60K
 W17kNwMahtNyftx2mwm3J652VOqPEM9DwnEgPbaCENfaACZmu+Lnp08VsUFzn4gHFfATXX+oADA
 eyDkMcOCjkYZnScDDu+z3ziyJUp73DzVyrBMkRI/khaAopM+9OCR494CpO3eOYkSMuoqHQjIAMh
 5+DcqJVyVuNIpPX2TtH2NUfxcen4SuAAqmmIG3RtXL0zboyGHVRu6En/voIkiLuuBUGRuquQmPN
 BJ+747XpgzxVz7qHBRJNGNnTBfeS6XA9rlWKStgFqlI4IBqpDYdI3D8DRmZJdv+NgF5A1Xw2zLh
 RzV8tfQd9BaLZ
X-Google-Smtp-Source: AGHT+IHh9wSmg1nuukE94bE2ZfNqnlPaAUxBW9+a1bxR1vq+wlHOBMCVLLHFoN5gYTREeu1cHJt2iA==
X-Received: by 2002:a05:6e02:b45:b0:3dc:8a5f:7cbe with SMTP id
 e9e14a558f8ab-3dc9b549069mr26522775ab.0.1748101282325; 
 Sat, 24 May 2025 08:41:22 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc4b1543sm4040779173.121.2025.05.24.08.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 08:41:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/6] expo: Allow the nominal display-size to be selected
Date: Sat, 24 May 2025 09:41:07 -0600
Message-ID: <20250524154117.1217190-1-sjg@chromium.org>
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

At present all coordinates are absolute and must fit within the display.
This makes it hard to create an expo which can work on any size of
display, a key goal of expo.

Add the concept of a nominal size, to which all coordinates conform. Once
the real display-size is known, expo can in principle (i.e. with later
work) scale the coordinates and objects according.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow_menu.c |  1 +
 boot/expo.c          |  6 ++++++
 include/expo.h       | 17 +++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index a0437177364..1966e38a6d6 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -49,6 +49,7 @@ int bootflow_menu_new(struct expo **expp)
 	ret = expo_new("bootflows", priv, &exp);
 	if (ret)
 		return log_msg_ret("exp", ret);
+	expo_req_size(exp, 1366, 768);
 
 	ret = scene_new(exp, "main", MAIN, &scn);
 	if (ret < 0)
diff --git a/boot/expo.c b/boot/expo.c
index 035c3de5a0a..6f05c47aba6 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -376,3 +376,9 @@ int expo_poll(struct expo *exp, struct expo_action *act)
 
 	return 0;
 }
+
+void expo_req_size(struct expo *exp, int width, int height)
+{
+	exp->req_width = width;
+	exp->req_height = height;
+}
diff --git a/include/expo.h b/include/expo.h
index e383872b307..5eb3299284c 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -109,6 +109,8 @@ struct expo_theme {
  * @scene_id: Current scene ID (0 if none)
  * @next_id: Next ID number to use, for automatic allocation
  * @action: Action selected by user. At present only one is supported, with the
+ * @req_width: Requested width of the display
+ * @req_height: Requested height of the display
  * type set to EXPOACT_NONE if there is no action
  * @text_mode: true to use text mode for the menu (no vidconsole)
  * @popup: true to use popup menus, instead of showing all items
@@ -128,6 +130,8 @@ struct expo {
 	uint scene_id;
 	uint next_id;
 	struct expo_action action;
+	int req_width;
+	int req_height;
 	bool text_mode;
 	bool popup;
 	bool show_highlight;
@@ -1081,4 +1085,17 @@ int cb_expo_build(struct expo **expp);
  */
 int expo_poll(struct expo *exp, struct expo_action *act);
 
+/**
+ * expo_req_size() - Request a size for the expo display
+ *
+ * Set the width and height of the display, so far as requested positions and
+ * size are concerned. The actual display may be larger or smaller, in which
+ * case expo scales the objects to fit
+ *
+ * @exp: Expo to update
+ * @width: Requested display width
+ * @height: Requested display height
+ */
+void expo_req_size(struct expo *exp, int width, int height);
+
 #endif /*__EXPO_H */
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: expa
