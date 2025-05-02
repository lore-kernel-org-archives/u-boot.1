Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB02AC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BEC882A64;
	Fri,  2 May 2025 16:48:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LBTB2o7I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1DC282153; Fri,  2 May 2025 16:48:09 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BB4682A9E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-8647e143f28so187399039f.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197285; x=1746802085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwGMA1PqKz7kDUExhTG9u0IhfdI87nMRJ/RuhxLH3dA=;
 b=LBTB2o7I13pJim2+Gr1cDR8Na7LaprBgn9PeRVwWJcgI3V/Si3LPV48QbnSiLWRHZf
 KPlW3vBKm2OcmpMBe5e0pxMxTmP/DBtUzXkwTOvXa5llDc3PZv7gRYIcPW67FanQ/lyu
 L25G3V8uiF+mvfQiUKpxfDsY2InD+YswF6z2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197285; x=1746802085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dwGMA1PqKz7kDUExhTG9u0IhfdI87nMRJ/RuhxLH3dA=;
 b=Ej3468vZKfQ9LVXJmsVsnvILp6Lt/iZ0lgDgnCslZ+ZwYLtWkJ5B9KaSQ1bZ4lPrCC
 3ug9SJQrpXEm/N5kIGkK1hoH+enGeBe3fCFs4/qMEilE98BchEvOhpJRS6gjp5TnToKL
 rvgmNjhBB2KoV7HAKuqWYxY3ZYX2jTgwHw4UVt8RC9f3wBbDZQHVvWnfXF1w2Thko0OR
 a59iNoehsnyECPg0ug9U2ZcSx9k0imx+f+EPEhiEQ6Q1AH0cdkRUVFAu82WT3clB8PL7
 Jp8b1PLq6yb3XNUfvFzUexbK3+xcpWixreTyd9uug5QHXfT9QLyX/+WHNnzHQDw9P+CS
 PpCg==
X-Gm-Message-State: AOJu0YwZT7yras4Gww2VNRkCdvWqTPxXPU919JXhmiKokpbiqB47dlHO
 29SQWO8cZgkY8qXvfsEHk3oNFYuB5l9Q29llhnoLLEklHZkm4iR4CgwYsFrhq0svAyCawAxiZRQ
 =
X-Gm-Gg: ASbGncuYiz3u6td4+0GDEhczHehurbaxxI63R4iJHCzj+u68KgxVdJSeKILqutm716/
 GrK1mP+yF78f8/q82pRl1PHZqctMkRm1QdKHKxCkQlOnJTF77dYns94rCLbYu6veSRcOUHg812w
 Yk8FGXdcv8kHTuVZHCXYqdFEK8eQLjQGXPIvJLWwkL9PxY6any4SQDJNJiaWJiO3i0UJEbmmb9u
 CU9dNkt9XM+NEQxRaHzgf2OQSFL8T8Tm3uhm5njCVe+c8n0JFzoOXkGTCGzSqyNIt/8InGuHIL9
 C+mXuVt8luNz6Qygc71rSdXh6wK4bC6776joACQmslYCnAEDRWlefwYUgIejhGbHguSXN0c9QVS
 uVA==
X-Google-Smtp-Source: AGHT+IHbiGIE8ecOpQxmQEbmZtq7z8DT3Y6nGBk5Reyz/v1FCFamIhrmX1pDpsgy+HEks+AUyksQdQ==
X-Received: by 2002:a05:6602:4899:b0:85d:f316:fabc with SMTP id
 ca18e2360f4ac-8669f9be1f6mr431652239f.8.1746197284964; 
 Fri, 02 May 2025 07:48:04 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 22/60] expo: Move cedit-state fields into expo
Date: Fri,  2 May 2025 08:46:20 -0600
Message-ID: <20250502144718.313633-23-sjg@chromium.org>
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

Move the boolean flags into struct expo so that the state can be
maintained over function calls.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/cedit.c   | 17 ++++++++---------
 include/expo.h |  4 ++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index b7b9cc510e0..8c6948d1d46 100644
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
 			return log_msg_ret("cep", ret);
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

