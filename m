Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD70CD493C
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAAE086D8E;
	Thu, 21 Sep 2023 03:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hb4GMQXp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E718086D86; Thu, 21 Sep 2023 03:57:56 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 525D786D7B
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:57:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79266c8617eso19783139f.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261469; x=1695866269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7vZKLztfXP+Nhx+UYbRCDFhcSLyC7vVGKC4CVn1MpI=;
 b=Hb4GMQXp1lxZuzubpXLiLlU5Z0OlQB0EOFmkiZh4gcIJXx7rfH7Q5wx+mshX/Sf/2o
 /101iipCiT7Sm+8JWskhgYoz/y2aV+tdNHthglvbJw6UJIuXS8EPMtkJukoLCsuiS2Hh
 2KLzKacdpBmEdWrCzpEZNdJ11tcoTMrzYlzec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261469; x=1695866269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c7vZKLztfXP+Nhx+UYbRCDFhcSLyC7vVGKC4CVn1MpI=;
 b=RcKbM0dmf/zx6aUW7+/OKtJI0tedb510dMXBcaPYIwAzVyPJBsDwNh2/Pcj3EwDptF
 4UOzTKvje4Ji4KSqtLV4PXqNrHw0lPCZ7Fpt9+pGrhY1e3EFQEpdBKLU3v4fcmVq2j/Q
 TNAeY8jDvLNajtkMP8IgBSLZo4GBEVyVIatmhjY2XhfiPaJx0/kMEAipzBg9w365lgYG
 z35zSPcHXeQGcCUzK0Od+H+7QHUHONtJ0dOwtYtSWaUUCqiveGqLfA6gJVvflOKRivDr
 PZEvE1/yO8EaxmDmqO1UXyynQOfIpUBajmXtmmT+2NOJdJfiUS/c6/F/WbEc0Ylj/xq0
 RSiA==
X-Gm-Message-State: AOJu0YxkqwShsvFGz2QqUiE1C1FfcYVLTEk/Hkb3Odh2v8YNVmBMSoIC
 ZxtLtn59QFYXwmf/+ATLaXd+7R3fq/ZUcLnISIc=
X-Google-Smtp-Source: AGHT+IHK2MIcDoSAS9lW8t5CcXx1aGGu6QhNwcIiCjnGUtGDkfffSi8UYfZirRWdqT+RtSvWsRRALQ==
X-Received: by 2002:a05:6e02:ee9:b0:349:5e6:4953 with SMTP id
 j9-20020a056e020ee900b0034905e64953mr4224995ilk.7.1695261469000; 
 Wed, 20 Sep 2023 18:57:49 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:57:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Nikhil M Jain <n-jain1@ti.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v2 07/32] spl: Avoid #ifdef with CONFIG_SPL_PAYLOAD_ARGS_ADDR
Date: Wed, 20 Sep 2023 19:56:56 -0600
Message-ID: <20230921015730.1511373-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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

Changes in v2:
- Change the approach to use the header file

 common/spl/spl.c           | 10 ++++------
 include/system-constants.h |  7 +++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 9870e9a65468..703f45cd8044 100644
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

