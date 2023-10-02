Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12574E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5954187120;
	Mon,  2 Oct 2023 03:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OOLraasq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A32F871E6; Mon,  2 Oct 2023 03:16:03 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C74E387120
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7a26fbfcf8eso90100839f.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209300; x=1696814100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wesWeF3C8Bzr0xB8C6jjTATDz0tqu+Lu267UNkmBCnY=;
 b=OOLraasqQ1yXuGD4/8P5Zvie3CDBFFn9g7kdI+ASGTTCF6UN3H6/0NffioBMoDkU83
 C7e9Xj2Rf9IrTn/3+xUuw/PdikdOPS/lS8dmSGp8ZHUGI0y8mAGROgMbVMNQKPGbeKc0
 pObfW19wVhf5S+lu4o6uHrq4xdSE6XYYmOlOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209300; x=1696814100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wesWeF3C8Bzr0xB8C6jjTATDz0tqu+Lu267UNkmBCnY=;
 b=O+4X2vWfbUdeHcJCn9W0XiLCCd4ARS0uqYz/u5+dVRD5ocTEZl0NARrijJB3Q30fo0
 0ceBcCWJXciTzK7pzQu5E8xTt6nQVwPMRjLVUhCZL+F8Qgr//Qk78t4GyPVFKzNWi/s8
 Ydr1Vco3zNSpNoNPGETrzprJqaQ/Q4ZHH5RPcu6V2XrZEw0n+qsGY3dgFXoyEG8VOlp1
 jQSE6zurKgjYGYNTev5PlgdNTdXSJEoQI7vERW2C2r2qnNVyDGK7IQti4GPTr5x4AMQs
 89jD52RAi7TCjjS1VbUKjEMkeSl/dttaAERCtNazLXp3kdfoZLWNn1St5EVySpyvWHXA
 QcEA==
X-Gm-Message-State: AOJu0Yy0/W1wH9A+T7wIQTFPVKKJp/Ed9mghbisMrzACiI8BV557M32u
 5SfuDd+X+vPwWKHOqL7DjWgt1cqvSrDD6RUlfXQ=
X-Google-Smtp-Source: AGHT+IGn0L+zUJnQmJJ08gNx5i3YT5nbdj2m7/lTH/2TmSqjPUv8tBPrHDrg3eXVHIDqdtKXmY1lvA==
X-Received: by 2002:a05:6602:2801:b0:783:63d6:4cb with SMTP id
 d1-20020a056602280100b0078363d604cbmr11959884ioe.14.1696209299830; 
 Sun, 01 Oct 2023 18:14:59 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s23-20020a02c517000000b0042b2e309f97sm6522951jam.177.2023.10.01.18.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 06/12] expo: Correct background colour
Date: Sun,  1 Oct 2023 19:14:41 -0600
Message-ID: <20231001191444.v3.6.I0229a119165879ecce6bafc8568708326bf5ba78@changeid>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011450.462468-1-sjg@chromium.org>
References: <20231002011450.462468-1-sjg@chromium.org>
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

Use the correct background colour when using white-on-black.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/expo.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/boot/expo.c b/boot/expo.c
index 139d684f8e6e..cadb6a0ad6e3 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -190,10 +190,12 @@ int expo_render(struct expo *exp)
 	struct udevice *dev = exp->display;
 	struct video_priv *vid_priv = dev_get_uclass_priv(dev);
 	struct scene *scn = NULL;
+	enum colour_idx back;
 	u32 colour;
 	int ret;
 
-	colour = video_index_to_colour(vid_priv, VID_WHITE);
+	back = CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK) ? VID_BLACK : VID_WHITE;
+	colour = video_index_to_colour(vid_priv, back);
 	ret = video_fill(dev, colour);
 	if (ret)
 		return log_msg_ret("fill", ret);
-- 
2.42.0.582.g8ccd20d70d-goog

