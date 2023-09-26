Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B9CE7E638
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7A2886DDF;
	Tue, 26 Sep 2023 16:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nHvXLUdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D91C586E02; Tue, 26 Sep 2023 16:15:41 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8349286DDD
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:15:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-79f96f83270so275245039f.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695737730; x=1696342530; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XR97DPedoFptkO2rXaf6B+4khvNmxK7T4QxDydmDbzU=;
 b=nHvXLUduHSQ8mw6ZNSVt6LdYD9pOsWq06a3/kakdY6LnW5JfxFsrLWxfEgF9e4qYWO
 R2mYq9ZKqktgQyxGk51yA5VKc8Td9onXL8i3fYMhBYUIZkp39+UeJADW0nKmrG1Vl1TB
 ckALQpdA2XawJM2qHcgmXj35Bm0y7cHQiPrD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695737730; x=1696342530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XR97DPedoFptkO2rXaf6B+4khvNmxK7T4QxDydmDbzU=;
 b=dbAUZxU9QFO+tA7NlrQBXdpfMAiSNOQHhKdeerBOFtkeyAzeViw0FJCCLJpYISbhr3
 lTJbQswLM7uRD85v9Fow+X5G3eoYMgA6twTXwApXWErW7kAxUkMEfVWmMAy+8YpR+LrM
 R3X7q/d/6e2i7CJHv6t8Duol5eEp50K+aDAFqeHiQPVbLvbWp3qo9KMZE2UpU3DC2qPL
 Iez2WDrH6pMGOt0mZkrbgfrIgnWMEABLJj+mrjRt9sD5bdQeEK/e7lzI3bIaXJhGAMGL
 ojxVitu1j0GEWdTBsxR8vnLUTSVqIQH1OtPPZ3mG2ECKwLFYXTrSesA4pWDTBMs9dIRq
 g7Fg==
X-Gm-Message-State: AOJu0Yxia0P6JUqRxQZq/OER7oq9DeScX+UVX5h2G3BAjYXCusCZ8tvy
 22twEZ7dGvI/0wM0msJHfoPd5lBY4gW93MwbETE=
X-Google-Smtp-Source: AGHT+IFBcU766upOr+yDjTUrrCmOGx9filU0L2wN+/pgx1+Fp4mVJJ5oAFPtjzcrmJO6ttzYI9A6/w==
X-Received: by 2002:a05:6602:2155:b0:795:1c40:a24e with SMTP id
 y21-20020a056602215500b007951c40a24emr10247244ioy.12.1695737730089; 
 Tue, 26 Sep 2023 07:15:30 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 dp1-20020a0566381c8100b0043193e32c78sm3256764jab.152.2023.09.26.07.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 07:15:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 07/44] spl: Avoid #ifdef with CONFIG_SPL_PAYLOAD_ARGS_ADDR
Date: Tue, 26 Sep 2023 08:14:21 -0600
Message-ID: <20230926141514.2101787-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230926141514.2101787-1-sjg@chromium.org>
References: <20230926141514.2101787-1-sjg@chromium.org>
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

Move the condition to the header file to improve readability.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Change the approach to use the header file

 common/spl/spl.c           | 10 ++++------
 include/system-constants.h |  7 +++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 68e58c930c28..117a6c7952eb 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -810,9 +810,8 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 	}
 
 	memset(&spl_image, '\0', sizeof(spl_image));
-#ifdef CONFIG_SPL_PAYLOAD_ARGS_ADDR
-	spl_image.arg = (void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR;
-#endif
+	if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
+		spl_image.arg = (void *)SPL_PAYLOAD_ARGS_ADDR;
 	spl_image.boot_device = BOOT_DEVICE_NONE;
 	board_boot_order(spl_boot_list);
 
@@ -869,9 +868,8 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 #if CONFIG_IS_ENABLED(OS_BOOT)
 	case IH_OS_LINUX:
 		debug("Jumping to Linux\n");
-#if defined(CONFIG_SPL_PAYLOAD_ARGS_ADDR)
-		spl_fixup_fdt((void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR);
-#endif
+		if (IS_ENABLED(CONFIG_SPL_OS_BOOT))
+			spl_fixup_fdt((void *)SPL_PAYLOAD_ARGS_ADDR);
 		spl_board_prepare_for_linux();
 		jump_to_image_linux(&spl_image);
 #endif
diff --git a/include/system-constants.h b/include/system-constants.h
index dca6a86b01f5..59371568d1e7 100644
--- a/include/system-constants.h
+++ b/include/system-constants.h
@@ -34,4 +34,11 @@
 #define SPL_SYS_MALLOC_SIZE	\
 	IF_ENABLED_INT(CONFIG_SPL_SYS_MALLOC, CONFIG_SPL_SYS_MALLOC_SIZE)
 
+/* deal with an optional value */
+#ifdef CONFIG_SPL_OS_BOOT
+#define SPL_PAYLOAD_ARGS_ADDR	CONFIG_SPL_PAYLOAD_ARGS_ADDR
+#else
+#define SPL_PAYLOAD_ARGS_ADDR	0
+#endif
+
 #endif
-- 
2.42.0.515.g380fc7ccd1-goog

