Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E69C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 19:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9838F874BB;
	Sun, 19 Nov 2023 20:12:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nJws2sD0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6C1C87252; Sun, 19 Nov 2023 20:12:27 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78BF8874C7
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 20:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-35937f2fadeso12702565ab.2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 11:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700421136; x=1701025936; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWP3OYNytmY0ZdZot+gmmzi9Dio5JwvKwKjZzVHUqJc=;
 b=nJws2sD0wRpg59BIUm/u4/STPZSR3LVWQ+OYxsdi7XWWRdR9ffyoP5hyb7Ds60z/7D
 cQuibH6ybfG1pJXYvPADA7hXlxV9iCcWQqIUmd/lYTI61i1hImpffpPPQuHkztz3s3va
 CjqGNEj5IdB4X+KC96VlnVNqV7OCAR1dlK2wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700421136; x=1701025936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oWP3OYNytmY0ZdZot+gmmzi9Dio5JwvKwKjZzVHUqJc=;
 b=H4zTGqeA0ajlrSge9CvkGLKkaVSGO9Pg86sUDFqzt4q/FB2R3tvJ6KoLFhsyWjapuM
 b9EOTwP9F2x07ReiYo75FCJlmJPaoRMqqz/yjmhmaLBzuweSn5/094eaGt9FcV+0/GBG
 wNKx5JayN9jq7WLvX/r7sS9cRouPoPByegGvlpklv0Vtp+dWhBPA/2xkeX8x0/yrmGwb
 H2CFNkhnP6Q7M/o77q123oxxmCrqttXzxIcJDdqHt/enwmC4NIds4BpyeF5gKelJOQT1
 RxBFduj10pUdRMRS6adpNE0FkpOhaSxcUQ7EFLaMb2AnzMMWLsdrKKJEgjnAtOHFsxWY
 VZRw==
X-Gm-Message-State: AOJu0Yz+qrjPRH0LHJYv3K/Jt0lL31BxExfNJ7bF5lS2sXp9MKgJJ8rB
 tgl6aUeSx3tLtT3BwF1SqOb3KuCvg6wiCFOj/I4jwg==
X-Google-Smtp-Source: AGHT+IHsMb0KrVX7iFaNMFo3Mltdk3agNvlvWuN0tAwnhYK/NLgjNrJmZPnqRGPakZ5sUnZD8UOLNw==
X-Received: by 2002:a92:c951:0:b0:35a:ff35:b475 with SMTP id
 i17-20020a92c951000000b0035aff35b475mr1669789ilq.3.1700421136086; 
 Sun, 19 Nov 2023 11:12:16 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a920511000000b0035ab2c7016bsm1951032ile.50.2023.11.19.11.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 11:12:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v5 06/12] expo: Correct background colour
Date: Sun, 19 Nov 2023 12:11:41 -0700
Message-ID: <20231119121144.v5.6.I0229a119165879ecce6bafc8568708326bf5ba78@changeid>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119191202.667180-1-sjg@chromium.org>
References: <20231119191202.667180-1-sjg@chromium.org>
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
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
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
2.43.0.rc0.421.g78406f8d94-goog

