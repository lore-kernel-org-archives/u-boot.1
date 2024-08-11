Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94E9C52D7C
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 12:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69EC388755;
	Sun, 11 Aug 2024 14:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R4WBP1gw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9274288680; Sun, 11 Aug 2024 14:29:40 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC8188837D
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 14:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-81f9339e534so120451639f.3
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 05:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723379376; x=1723984176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qf7fcrtYbSX8z2HBiPAuNHc7m1MrGdeZ0jMc562veCQ=;
 b=R4WBP1gw6G12740FnK8xzmTOWtbVVNrwspRyn3mNoZErgWH0ncDiTm+ETfESzHDMkd
 R/13iOHXpRQj/qQaaYFA/YIzfX/R3BSWHhNUBjFnDBR2rgryWKJgx77VHP+GGvr8hZzZ
 lF5WP65sbAxDwOCNrTJxLH+pEVfYYgYjEHlsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723379376; x=1723984176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qf7fcrtYbSX8z2HBiPAuNHc7m1MrGdeZ0jMc562veCQ=;
 b=emzcsIQOHBSy6IUaf5aacYOsGBkVy3vJ3T9NdWG65LXMlEdun838E6aLEaVwgzAu+E
 9/CdI7eZkzuY9UJgV6I+I/R/vZndBl7eyf+RmJ67YAm+s9O6DNdeFTTkyHFsbwxCUNmu
 jFd1XsdPyThkRKoeFx3t0+JUusdmBDzudlZgmcrZ12K92O+An7e1T8r7eYAo0Nrcrlac
 nLLO5j0LzpVtJWZgquXmqN7EcbuQEPfZaKRm/vp5dej9VXaDIYwyJ+qUm1F4/xbKNmzq
 zZUrVMOjbqksoVUJa32LoEuI9hJ9gpuWVAX+EQjV7T3DtJvlH7JYqtONIkpVB/VGe138
 40ZA==
X-Gm-Message-State: AOJu0Yw5Xa+tAVa+AUN0/5uM5dU2lGR8yeSPeqPngKXTwJ5MiSUtZrXD
 +/FrOB/NlE6K7riFNmv8gG1gUxcOSvs4iaDe86S4qQqzFe2Oo2R7Lb9bYBIC/2kqwQI6wvL+AQk
 =
X-Google-Smtp-Source: AGHT+IGm1kM7m7CXYLvOry2iNy1QDZKXuJlyX12BuvsfE6YXw49HzNblhI5Je/NUf4M5pO1kTlsqVg==
X-Received: by 2002:a05:6602:13c8:b0:7f6:2d58:8d6a with SMTP id
 ca18e2360f4ac-8225ee7a6a6mr923137139f.7.1723379376467; 
 Sun, 11 Aug 2024 05:29:36 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca76940448sm1017935173.45.2024.08.11.05.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 05:29:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Subject: [PATCH v3 03/15] spl: Correct use of CMD_BOOTI and CMD_BOOTZ
Date: Sun, 11 Aug 2024 06:29:12 -0600
Message-Id: <20240811122924.4035982-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811122924.4035982-1-sjg@chromium.org>
References: <20240811122924.4035982-1-sjg@chromium.org>
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

These should have a CONFIG_ prefix. Add it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 7a0d88076b9 ("Add in the ability to load and boot an uncompr...")
Reviewed-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 common/spl/spl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index d6a364de6ee..028cba964fb 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -322,7 +322,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 #endif
 
 #if CONFIG_IS_ENABLED(OS_BOOT)
-#if defined(CMD_BOOTI)
+#if defined(CONFIG_CMD_BOOTI)
 		ulong start, size;
 
 		if (!booti_setup((ulong)header, &start, &size, 0)) {
@@ -336,7 +336,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 			      spl_image->load_addr, spl_image->size);
 			return 0;
 		}
-#elif defined(CMD_BOOTZ)
+#elif defined(CONFIG_CMD_BOOTZ)
 		ulong start, end;
 
 		if (!bootz_setup((ulong)header, &start, &end)) {
-- 
2.34.1

