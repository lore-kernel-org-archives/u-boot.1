Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22C0EE49A5
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 18:14:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8FF287072;
	Mon, 21 Aug 2023 20:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GJ5Mk5VZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D040F8705D; Mon, 21 Aug 2023 20:13:55 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F20786802
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so34828245e9.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692641632; x=1693246432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UESOwfDyr2zxOdqADMaJvgSddFJtVF9j7tTGno2uk7E=;
 b=GJ5Mk5VZbzT5/kpC4CRPsb9fUuj7MtlL/udxWgTPg7MC1cW0LjXsWDhP3bJbtgF/7x
 fc8QJSrqWqPyD6N+oL1uM5V+gKqhvWL8a1xIZYyDiFffGZoSNuRR9oMQeBEUN28rp8oW
 nIxs2tS5JW35d6cOKwdvdIS4939LVcC6IB7m3qZM/b+yX9bElZshf8u2on3jh/eiWE1V
 1ufGF0lOkPuCqY4oEj0aY0FW99FIUUJJ6AMDogy2o5n57LCU/BGjC7sXW70mqENu0dH3
 +xAufn0VT6lFx2JMpZ/4c2QcWR4iZI6FxDdm10nMvJHZI3DelD0xcGpYRaBqAkEVUKau
 zW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692641632; x=1693246432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UESOwfDyr2zxOdqADMaJvgSddFJtVF9j7tTGno2uk7E=;
 b=R61OOOZGExKC+YU0MeLZcgd6J7aTTshJwsuQ5A6baV1AjP6dTP8KyH3dqcIoPGgMEr
 AjANeyJLwzVbZ7smIg91tUYNs2ReduMahl8CybDr6p4AlON7pgFLvrEwagU/0/LggmYh
 6Bz6+bFWyPqO+g1I33y/Uouu1dyuqEVisK94kryGBn5x3PA4Yru3a752+GwpQvIeYQmu
 irzbsBnC0SG2ej0yxqVLjhr+uf84Gg3Yo7km93vQ5PqDelfLPL5yNCCh59sr9GzVpZvI
 l1gtNnxLHUrAdzGrPYv0GrLyphMjl+BN/24PI5LOOfQXR7CvZTPNYvDKnwjsEQbXbBRu
 mFTg==
X-Gm-Message-State: AOJu0YwSdfqU22O0D8MFyqls2Ff3QpRlf+HJnaZsKsV2htOcbSdWYxZ/
 RfYCL4LwhqWyadibIOgc0wFVGyJkAGk=
X-Google-Smtp-Source: AGHT+IFmExRt5+n5FmCNSFJpPQNGHtAcaRWPDDxUiQHfjH+EPcowYTbDu/m5rWgrjO4lKN3FVV2Pqg==
X-Received: by 2002:adf:f287:0:b0:315:9993:1caa with SMTP id
 k7-20020adff287000000b0031599931caamr5516499wro.12.1692641631913; 
 Mon, 21 Aug 2023 11:13:51 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 z1-20020adfd0c1000000b003143c9beeaesm13192025wrh.44.2023.08.21.11.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 11:13:51 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH 2/5] video: Allow deferring and retrying driver-specific video
 sync
Date: Mon, 21 Aug 2023 21:13:36 +0300
Message-Id: <20230821181339.4135800-3-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230821181339.4135800-1-alpernebiyasak@gmail.com>
References: <20230821181339.4135800-1-alpernebiyasak@gmail.com>
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

The sandbox SDL driver has some code in the video uclass to rate limit
video syncs by postponing them, and forcing a sync nonetheless with a
"force" argument.

Add infrastructure for doing this through driver ops, where the driver
can request to defer a sync with -EAGAIN, and the uclass can force it by
calling the op again it until it does something.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
Alternatively, add "force" argument into the driver ops->video_sync().
But I think it should go away instead. The problem is video_sync() being
called irregularly and too frequently, maybe we can call it only from
cyclic at the hardware refresh rate?

 drivers/video/video-uclass.c | 2 ++
 include/video.h              | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 7cec6362570f..accf486509cb 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -446,6 +446,8 @@ int video_sync(struct udevice *vid, bool force)
 
 	if (ops && ops->video_sync) {
 		ret = ops->video_sync(vid);
+		while (force && ret == -EAGAIN)
+			ret = ops->video_sync(vid);
 		if (ret)
 			return ret;
 	}
diff --git a/include/video.h b/include/video.h
index 42e57b44188d..5c4327d4e455 100644
--- a/include/video.h
+++ b/include/video.h
@@ -137,7 +137,8 @@ struct video_priv {
  *		displays needs synchronization when data in an FB is available.
  *		For these devices implement video_sync hook to call a sync
  *		function. vid is pointer to video device udevice. Function
- *		should return 0 on success video_sync and error code otherwise
+ *		should return 0 on success video_sync, -EAGAIN if it was
+ *		deferred and should be tried again, and error code otherwise
  */
 struct video_ops {
 	int (*video_sync)(struct udevice *vid);
-- 
2.40.1

