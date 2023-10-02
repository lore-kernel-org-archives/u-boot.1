Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DA4E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADAFA87187;
	Mon,  2 Oct 2023 03:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WkUvTLKV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4394587106; Mon,  2 Oct 2023 03:14:32 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D1948710C
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7a26fd82847so103348739f.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209252; x=1696814052; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ntnQFvjFEnFc37g1TKn9TGbaZQawEz/0Iobh3h/As94=;
 b=WkUvTLKVyk+5i0nJWAr3afVfp6t+qrw8jM3hXlQGUR/eBA/n/3FfnUEjiPXUGItnAc
 MGEZgseJqNvZNM2S1307QIDtf8YtI5qpKRZLmzGtcMDBT6l1zzWMPhCRJ+9XzvCwZc9P
 7fOMHnj74oECsI0vfCOEfrUhRFTMQRtwRpUJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209252; x=1696814052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ntnQFvjFEnFc37g1TKn9TGbaZQawEz/0Iobh3h/As94=;
 b=CvSQOz0w1O0cY62hiHR0zzGHqu9iOBQT5Yw4TrafWx/4509ZnOmqQWOgJHrwqAMGtb
 NPUJ91V/P4SkSVNATM7cHLpjU8Pnv1JS7H79266cn4EolkeUVaXdS3ccOM2516FIonYl
 dbieCA+Nn1/4hIfMGtqEB/Tl/MjPm93WOOoutCPeWiwVMbVqm5uxUs50PNB5IilCoq78
 Xn9sAXCtnjUEO/HMa90uS24PnpmLrjutOvvNj7iivrMuGk+1aczmK+Q9zph1+Awuys1F
 dL4pbZE7bZjwMBDCUtHb9aUbSEHXd6ZLydSos+9mGLVPCTkMc0QWfRQcAqzmkJPcle4E
 t7WQ==
X-Gm-Message-State: AOJu0YyxeuejDO5Dik1fc2akY+zWZAgzMQXDbNBiM9oQhE0YKFJ7MHdO
 eKB8G6LE+RUBy95O5xhyWI8uX9IwY1R/bQtjJOo=
X-Google-Smtp-Source: AGHT+IErT60Lta+T8Orx6B6N3lQHS7BVFAn35Y12/16BEIz7COcd/gPMBp0mKvQXIXflP5GH08HixA==
X-Received: by 2002:a6b:5b01:0:b0:790:bc17:1c63 with SMTP id
 v1-20020a6b5b01000000b00790bc171c63mr11009990ioh.1.1696209251948; 
 Sun, 01 Oct 2023 18:14:11 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 22/36] expo: Correct the logic for duplicate-ID detection
Date: Sun,  1 Oct 2023 19:13:26 -0600
Message-ID: <20231002011349.461284-23-sjg@chromium.org>
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

Update scene_txt_str() to account for the possibility that the passed-in
str_id may be 0

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/scene.c b/boot/scene.c
index 9c4466c1a47a..8e5d3aa7dc05 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -176,8 +176,9 @@ int scene_txt_str(struct scene *scn, const char *name, uint id, uint str_id,
 	ret = expo_str(scn->expo, name, str_id, str);
 	if (ret < 0)
 		return log_msg_ret("str", ret);
-	else if (ret != str_id)
+	if (str_id && ret != str_id)
 		return log_msg_ret("id", -EEXIST);
+	str_id = ret;
 
 	ret = scene_obj_add(scn, name, id, SCENEOBJT_TEXT,
 			    sizeof(struct scene_obj_txt),
-- 
2.42.0.582.g8ccd20d70d-goog

