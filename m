Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98FAE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:25:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1221A87126;
	Mon,  2 Oct 2023 03:15:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bt33rclW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4C5387100; Mon,  2 Oct 2023 03:14:29 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D92D870E3
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-77acb04309dso576019939f.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209251; x=1696814051; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=myG+gM+lnJljGmOjDNFrLvwHPNhCs2X7pFqQwDCDaT4=;
 b=Bt33rclW1YrTQDoLAU7khU8P7L1wRQyrXsrapUJcFwptVagHvr9tmt4OuDz26h/Yw5
 Kxtg58A3hZl0ZDqPJ+hT8a7ABaFYU/VXV1/E0DILuC1CDxRv0Sm86181z0szNOJ7IHZ1
 NQ56Jc1KHAIjUefzJNqA4R2V0Z2n+uDE436as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209251; x=1696814051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=myG+gM+lnJljGmOjDNFrLvwHPNhCs2X7pFqQwDCDaT4=;
 b=vBMAybmaWC3OOnK7EixbT+qj+AcusGEf4FFNScsZMExj1esgEo6ypRM5aEM7pJjsoE
 XbwrX+Bz/ONs4/EJoKWwBw/MGIFmIdi5pqYvxHExiDaW5ymV2Ql4ozfTfsgOaUMAluVI
 fmDZ2s27Kcq7fb/2eLjAlO4cPfG74WrJujkxEVN42xVgh2rbJMpiOyK31auhJwV0DFjK
 FLv1/YGN6+sK2AEQLhAoxH8xNGj8zuBsT9Qrypybt/IJs/Rzfip+lB8ltb3jw897595P
 gEoMo6QRPD8FnqrJWjD/mLR3gOyQmPt0STj0BU7JJc0BFn1RoJbzmKtCQw/fgiFNRTKB
 oBLw==
X-Gm-Message-State: AOJu0Yw7AwRij8elcpQ1j0Apaw2/WySiMM3SdeuJ9+Pa55hiZY4L73WL
 G6Q70rpUFbkuRvKJlzaQSDwN74ad9EqqtnoHua8=
X-Google-Smtp-Source: AGHT+IHWwsJekPZ5H7oO5pSCjNVNGQjtUz/JX4PBax5pC4blARfkDjIhpic9VlL3EsET6CZKVSo6oA==
X-Received: by 2002:a6b:dc10:0:b0:790:9728:4014 with SMTP id
 s16-20020a6bdc10000000b0079097284014mr11696339ioc.11.1696209251157; 
 Sun, 01 Oct 2023 18:14:11 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 21/36] expo: Correct some swallowed errors in scene
Date: Sun,  1 Oct 2023 19:13:25 -0600
Message-ID: <20231002011349.461284-22-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

Return the reported error, rather than assuming it is -ENOMEM

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 08ed85e9188c..9c4466c1a47a 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -137,7 +137,7 @@ int scene_img(struct scene *scn, const char *name, uint id, char *data,
 			    sizeof(struct scene_obj_img),
 			    (struct scene_obj **)&img);
 	if (ret < 0)
-		return log_msg_ret("obj", -ENOMEM);
+		return log_msg_ret("obj", ret);
 
 	img->data = data;
 
@@ -157,7 +157,7 @@ int scene_txt(struct scene *scn, const char *name, uint id, uint str_id,
 			    sizeof(struct scene_obj_txt),
 			    (struct scene_obj **)&txt);
 	if (ret < 0)
-		return log_msg_ret("obj", -ENOMEM);
+		return log_msg_ret("obj", ret);
 
 	txt->str_id = str_id;
 
@@ -183,7 +183,7 @@ int scene_txt_str(struct scene *scn, const char *name, uint id, uint str_id,
 			    sizeof(struct scene_obj_txt),
 			    (struct scene_obj **)&txt);
 	if (ret < 0)
-		return log_msg_ret("obj", -ENOMEM);
+		return log_msg_ret("obj", ret);
 
 	txt->str_id = str_id;
 
-- 
2.42.0.582.g8ccd20d70d-goog

