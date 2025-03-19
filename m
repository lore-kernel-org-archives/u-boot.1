Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6098BC35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28BFB8209F;
	Wed, 19 Mar 2025 15:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mrEg3fwC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7B418209C; Wed, 19 Mar 2025 15:56:03 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D59B820A1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-399744f74e9so641781f8f.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396160; x=1743000960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MqTSTHYO5IhcY3FX0WhQGhP4pYNqiCG/X9a4EiMhCl4=;
 b=mrEg3fwCOqLxH8072CUWcoCx7xOUr3CaqwWQfGQJPEMvav/0n98DeA69Dst0erFEok
 h+4fGmB5NL0HW0asvci+v/y/tLrpwiqK814iAYXQnes6jI3dLY0WX6qZimsYYohR4qBG
 1BTpGY9eypeB7Rxt+nboDXhtuiRoKkr7dsgQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396160; x=1743000960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MqTSTHYO5IhcY3FX0WhQGhP4pYNqiCG/X9a4EiMhCl4=;
 b=XvJ4T4a7nwsx3CeEOXJQUkyFtFYI7F/sc3Gal1MKzzTf2l84724ff9Gy/3frX5f0BK
 qSbEi8eOQU//a/SFpU3t+lf+s9LV96SQh9wavvxtjYgl+WiUdNxaWqPBqEgWvtQn3RBU
 Juu2lBqiN6mXSkHQhDLNp9UCE9tVpGRRKqTSqIs0r1wMPEuq3ZScQQVmH4/PjqiDN7HS
 pRct84kqR9wCwIeNaqXWW1RR3QhACSCzh4GNGFBHwDYXMARrejV2Z/zU5Uqo/ad8rvzJ
 jVI3pWrP4X1M/bdzaIPu4ky3LZ3lG4ds+aYh6IEqIccNnPxqsC499+Hm9CUgJDGcw3Qr
 uvRA==
X-Gm-Message-State: AOJu0YxJdl6lWYy6/yASh/7XDLsvs9Yb9y+v+fmx581XS1JnNQPq44u9
 JX1FvUHwiNLlqa6hEmwXTv4VLpcajMUeJoNjr68vG6jgO/YzEtPZQqbeITcWGQPxWddro7/r/9g
 =
X-Gm-Gg: ASbGncvqY1eMYEXrQwAAO3dMj4YWMf+Ey4UZRh1HTGcu8cVijF5nsAqvjRejnnPHllV
 gDIagOle19XnZQFINFSeXhBcLqXp6Crsn4Vu8gBWs2hz6ToMUOMtJNv/CTmqg0dJdeQjfVy+SeC
 hy7FK0aDi/BwI4UJZAWnvjihGEHUo5RJr7A/V1VGTgVXLiQH+5MVQelriklxQUqPApeTa8E7CzP
 DAquQqfqY9unXF0s4szafoRsH5pcNDI2pteDVekVdrL2b3XRp8FS53+L1foZ4MjArAYf+XVAnRj
 1oM6z4rhcCiOXKkZmNWLfO2FIHY2vShZqtAVlFDCkQ==
X-Google-Smtp-Source: AGHT+IHI2h0ny386lVyG6nDNATbM+lzaMWi4vDv6FDTJpkyv9i7++HTeNgE+IhDCmMU4M1T/CQKFqA==
X-Received: by 2002:a5d:598f:0:b0:390:fb37:1ca with SMTP id
 ffacd0b85a97d-39973b04a9amr3810105f8f.53.1742396160184; 
 Wed, 19 Mar 2025 07:56:00 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/52] expo: Move cedit-state fields into expo
Date: Wed, 19 Mar 2025 15:54:22 +0100
Message-ID: <20250319145512.2391122-18-sjg@chromium.org>
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

Move the boolean flags into struct expo so that the state can be
maintained over function calls.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c   | 17 ++++++++---------
 include/expo.h |  4 ++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 9baef39a0cd..3703538e5dc 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -154,7 +154,6 @@ int cedit_run(struct expo *exp)
 	struct video_priv *vid_priv;
 	uint scene_id;
 	struct scene *scn;
-	bool done, save;
 	int ret;
 
 	ret = cedit_prepare(exp, &vid_priv, &scn);
@@ -162,8 +161,8 @@ int cedit_run(struct expo *exp)
 		return log_msg_ret("prep", ret);
 	scene_id = ret;
 
-	done = false;
-	save = false;
+	exp->done = false;
+	exp->save = false;
 	do {
 		struct expo_action act;
 
@@ -179,11 +178,11 @@ int cedit_run(struct expo *exp)
 				cedit_arange(exp, vid_priv, scene_id);
 				switch (scn->highlight_id) {
 				case EXPOID_SAVE:
-					done = true;
-					save = true;
+					exp->done = true;
+					exp->save = true;
 					break;
 				case EXPOID_DISCARD:
-					done = true;
+					exp->done = true;
 					break;
 				}
 				break;
@@ -197,7 +196,7 @@ int cedit_run(struct expo *exp)
 				break;
 			case EXPOACT_QUIT:
 				log_debug("quitting\n");
-				done = true;
+				exp->done = true;
 				break;
 			default:
 				break;
@@ -205,11 +204,11 @@ int cedit_run(struct expo *exp)
 		} else if (ret != -EAGAIN) {
 			LOGR("cep", ret);
 		}
-	} while (!done);
+	} while (!exp->done);
 
 	if (ret)
 		return log_msg_ret("end", ret);
-	if (!save)
+	if (!exp->save)
 		return -EACCES;
 
 	return 0;
diff --git a/include/expo.h b/include/expo.h
index 63452bbdd6a..f8d44c0ea20 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -105,6 +105,8 @@ struct expo_theme {
  * @text_mode: true to use text mode for the menu (no vidconsole)
  * @popup: true to use popup menus, instead of showing all items
  * @priv: Private data for the controller
+ * @done: Indicates that a cedit session is complete and the user has quit
+ * @save: Indicates that cedit data should be saved, rather than discarded
  * @theme: Information about fonts styles, etc.
  * @scene_head: List of scenes
  * @str_head: list of strings
@@ -120,6 +122,8 @@ struct expo {
 	bool text_mode;
 	bool popup;
 	void *priv;
+	bool done;
+	bool save;
 	struct expo_theme theme;
 	struct list_head scene_head;
 	struct list_head str_head;
-- 
2.43.0

