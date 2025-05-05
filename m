Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C362C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:44:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7F1C81F66;
	Mon,  5 May 2025 17:44:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d8hnDWpv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7896681F66; Mon,  5 May 2025 17:44:03 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EBAC82724
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:43:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e5bc066283so6793765a12.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459835; x=1747064635; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4zJ0SeiFccx3wcGisKQ873oZ91OXCukSX16NUqAjbk=;
 b=d8hnDWpvBe75x5Xrj0tKexcK9VCHq2bPZT/6kCr41Wmw1Rfbgq9sP4Kqmf0wN8TWss
 4SVvvTZaDIyGE10fTVTF8evLzpDfUIzQek7UQLlRZoXEkVJg9T+2fq1g1Y5titVxqgZ/
 IkXCvECyC3/880i5Y5cgUeF56mlw/6PtxzrIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459835; x=1747064635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4zJ0SeiFccx3wcGisKQ873oZ91OXCukSX16NUqAjbk=;
 b=ATRvf8s19xtsbsWQKWaZW5Cr4l7XbF/XovvJtdjm+P26pEB7CtHkBLhwVgXD0cqcp8
 X95q/uFDXCNT6BLP+MqTh4gGeoBvBiWRiGLmvjdT4VJxtZfb0dMfmtx0bkiJkK5YEJWt
 jgJBOMHQj+SWu7lEjzxw3w+faUlHQNg7ZtXPnkhoWK+l5xEx0p3MDZMIz26dgP7skyyD
 R0OL3DrLjOzMqfV9ldBqEe6NjeQclcJX6zZGRKQBhyojs2qksDAEnZ4s6qXgU2+FucwZ
 uDElN9KjV7meBrmsDS/7EDHifdzWv6vyqmvlWOV1JFE19vsEJkxyHajmCpNny0d1nc66
 CjtQ==
X-Gm-Message-State: AOJu0YwafRAGN6gc34DUCIHeHqVAD/Ckiqgj/CYwM/I/Q9MeFQwJ0I9t
 UMrIYg6LwUved5nS7XMxveloxakoiQlHEE0UZwBSnTdLzLNPOT+HQPt+6Y4hv4HD+eoSm6f8ZpE
 dhqtcKPw=
X-Gm-Gg: ASbGncsXmAumHmxyeCHwo+vQKySCXhagpOOfw6TJxJBFSRCDZTtDXi9u3nVwJ08jjAn
 yCWAkU0fsv9qP6p14134OfLa0ZUhi64D1/9mQE5nu7YK0Wem3Gz/469FywHJ9aNu/chODUIDMPY
 SAedg85wss+fCiic8V4sRc+sVc2Ct/oAPb8RRvPoSVYHA4h3hE1zDdF4WqmQSBCm8T+A7MLka7b
 UQjXlO4SEUlVzQs+hkenqZAQw3AiOxzVpi7UOSqDFPr9tktdMZSt0tL7GIe4jyUAoxlnIl0fW1j
 yFXFRnflNLVCh++ywjjsAC5wMei1KF7MMukG
X-Google-Smtp-Source: AGHT+IGEEf+NsBNtgq82MqDO6nrAK15dn77s+t+bQCCIxu34vpNWlmdbPAZWmO9YVHOSfVkWzS4UQg==
X-Received: by 2002:a50:c909:0:b0:5fa:f7ee:66d4 with SMTP id
 4fb4d7f45d1cf-5faf7ee6ca1mr3758934a12.6.1746459835134; 
 Mon, 05 May 2025 08:43:55 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.43.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:43:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/19] expo: Create a function to arrange the current scene
Date: Mon,  5 May 2025 17:42:41 +0200
Message-ID: <20250505154308.2911248-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505154308.2911248-1-sjg@chromium.org>
References: <20250505154308.2911248-1-sjg@chromium.org>
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

Provide a convenient function which arranges the current scene in an
expo. Make use of this in bootflow_menu

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow_menu.c | 12 +-----------
 boot/expo.c          | 19 +++++++++++++++++++
 include/expo.h       | 11 +++++++++++
 3 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 5d77a0eaea8..934165d2855 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -249,9 +249,7 @@ int bootflow_menu_setup(struct bootstd_priv *std, bool text_mode,
 int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 			struct expo **expp)
 {
-	struct scene *scn;
 	struct expo *exp;
-	uint scene_id;
 	int ret;
 
 	ret = bootflow_menu_setup(std, text_mode, &exp);
@@ -272,15 +270,7 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 	if (ret)
 		return log_msg_ret("bmd", ret);
 
-	ret = expo_first_scene_id(exp);
-	if (ret < 0)
-		return log_msg_ret("scn", ret);
-	scene_id = ret;
-	scn = expo_lookup_scene_id(exp, scene_id);
-
-	scene_set_highlight_id(scn, OBJ_MENU);
-
-	ret = scene_arrange(scn);
+	ret = expo_arrange(exp);
 	if (ret)
 		return log_msg_ret("arr", ret);
 
diff --git a/boot/expo.c b/boot/expo.c
index 94413acd381..3e79cbca04b 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -211,6 +211,25 @@ int expo_first_scene_id(struct expo *exp)
 	return scn->id;
 }
 
+int expo_arrange(struct expo *exp)
+{
+	struct scene *scn;
+	int ret;
+
+	if (!exp->scene_id)
+		return 0;
+
+	scn = expo_lookup_scene_id(exp, exp->scene_id);
+	if (!scn)
+		return log_msg_ret("scn", -ENOENT);
+
+	ret = scene_arrange(scn);
+	if (ret)
+		return log_msg_ret("ear", ret);
+
+	return 0;
+}
+
 int expo_render(struct expo *exp)
 {
 	struct udevice *dev = exp->display;
diff --git a/include/expo.h b/include/expo.h
index 6b191815ded..75ff1df3cfc 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -620,6 +620,17 @@ int expo_first_scene_id(struct expo *exp);
  */
 int expo_render(struct expo *exp);
 
+/**
+ * expo_arrange() - Arrange the current scene to deal with object sizes
+ *
+ * Updates any menus in the current scene so that their objects are in the right
+ * place. Does nothing if there is no scene
+ *
+ * @exp: Expo to arrange
+ * Returns: 0 if OK, -ve on error
+ */
+int expo_arrange(struct expo *exp);
+
 /**
  * expo_set_text_mode() - Controls whether the expo renders in text mode
  *
-- 
2.43.0

