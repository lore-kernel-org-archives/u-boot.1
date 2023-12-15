Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1C3C4167D
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 04:19:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B7C887ADA;
	Fri, 15 Dec 2023 05:19:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BJQ5m/TN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C585487AEC; Fri, 15 Dec 2023 05:19:31 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B818187ADB
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:19:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6d9dc789f23so267555a34.3
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702613967; x=1703218767; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKub56859e9DPGFt6rOacaF1p1ewqTEhUXOuaKsxM/I=;
 b=BJQ5m/TNvzdvXFhgGggel130l0Uc/da8qyES+xTJvvDcXJ2IVTYMrVdMBQP/6dTZS4
 vNZSK9cS9KbhIidL/9ECpAfL1+tuH6ZLdD5rxzggeMBa88vxLsRLG1dBnKdl+ULoZuqJ
 6EXL1rxngPTitaWbVYizIygI0xDuyBAMwI5hQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702613967; x=1703218767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gKub56859e9DPGFt6rOacaF1p1ewqTEhUXOuaKsxM/I=;
 b=ADcVn+rWhrKYhzVcfkoIGtWMTk3X/QzJPiYOen0EWMWcoXsixYoAc2chz3Y3yluMFv
 AaNMc7fW9hBNPnxvLOJIjcSBA/UMnpOnDw8SWLEmxGZaf9s3//tUELkIhtXLwOpB4/AR
 rBxF+6GtgJxTU3L2aqsX+ogwmVsg57DoL5vjMvFUVo1ka3foEHyKFs4Qmhmvqia9uBIk
 0Nu//nztJDvY6bPISiXkG0PSJVOVM1nZb49XuvrPKN7uyAuZslGiFeOmP9E0pJLx5zWB
 7KtzGguH0qGUOg0BOx3hGN9dih1DosxrKqVbwRiE+roVBHHVP5xMwAewDMS0NIqi+QId
 jJXg==
X-Gm-Message-State: AOJu0Yy8vzCzDKmVA7MvlNyjf3maqZ4WtOOZUZEt8xMlRDrceOSeETMV
 oO4RmonJ6Fy7LGbqC35AeElF6oNveN7EqGzeczJ4OA==
X-Google-Smtp-Source: AGHT+IEiYYBJJCgJ51zems7jIPb/6LTN04kTJ0j0FDU6k1szrN1eYdGB4CQ/JPwN8s66rKTK6kYvDA==
X-Received: by 2002:a05:6808:650b:b0:3ba:a85:429f with SMTP id
 fm11-20020a056808650b00b003ba0a85429fmr7813949oib.115.1702613967098; 
 Thu, 14 Dec 2023 20:19:27 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003b898ffd8fcsm3601492oib.50.2023.12.14.20.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 20:19:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v2 01/16] boot: Reorder FIT and BOOTSTD to be first
Date: Thu, 14 Dec 2023 21:18:59 -0700
Message-ID: <20231215041919.2197788-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231215041919.2197788-1-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
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

The boot menu shows Android first and then a timestamp option. Move
these later since they are less commonly used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index b438002059c3..e0098b3f31d7 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -2,24 +2,6 @@ menu "Boot options"
 
 menu "Boot images"
 
-config ANDROID_BOOT_IMAGE
-	bool "Android Boot Images"
-	default y if FASTBOOT
-	help
-	  This enables support for booting images which use the Android
-	  image format header.
-
-config TIMESTAMP
-	bool "Show image date and time when displaying image information"
-	default y if CMD_DATE
-	help
-	  When CONFIG_TIMESTAMP is selected, the timestamp (date and time) of
-	  an image is printed by image commands like bootm or iminfo. This
-	  is shown as 'Timestamp: xxx' and 'Created: xxx'. If this option is
-	  enabled, then U-Boot requires FITs to have a timestamp. If a FIT is
-	  loaded that does not, the message 'Wrong FIT format: no timestamp'
-	  is shown.
-
 menuconfig FIT
 	bool "Flattened Image Tree (FIT)"
 	select HASH
@@ -695,6 +677,24 @@ config BOOTMETH_SCRIPT
 
 endif # BOOTSTD
 
+config ANDROID_BOOT_IMAGE
+	bool "Android Boot Images"
+	default y if FASTBOOT
+	help
+	  This enables support for booting images which use the Android
+	  image format header.
+
+config TIMESTAMP
+	bool "Show image date and time when displaying image information"
+	default y if CMD_DATE
+	help
+	  When CONFIG_TIMESTAMP is selected, the timestamp (date and time) of
+	  an image is printed by image commands like bootm or iminfo. This
+	  is shown as 'Timestamp: xxx' and 'Created: xxx'. If this option is
+	  enabled, then U-Boot requires FITs to have a timestamp. If a FIT is
+	  loaded that does not, the message 'Wrong FIT format: no timestamp'
+	  is shown.
+
 config LEGACY_IMAGE_FORMAT
 	bool "Enable support for the legacy image format"
 	default y if !FIT_SIGNATURE && !TI_SECURE_DEVICE
-- 
2.43.0.472.g3155946c3a-goog

