Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2934CC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF4408786E;
	Mon,  4 Dec 2023 01:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rtk87a3S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C869887717; Mon,  4 Dec 2023 01:32:26 +0100 (CET)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 924038771E
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so2012960a12.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649943; x=1702254743; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kQtT5sSBogbuxA4cvFqZrEpDFm2UAbSz6pwfQhjapXA=;
 b=Rtk87a3SCoYmwJAFNa8iY9TRdb0C5hB3ya0NlBx+kwnrNijfQour5wVSgVKSsfXXEX
 tpr3Knm3JiJ2c42OtY1mnpUp7LbBaNz23Cmko4FF/1XXXKqXLUlYskz6Dj+ME4AeYkBR
 4zOi5iCwM8zMczo3871TduUeZjRgsZPHweLKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649943; x=1702254743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kQtT5sSBogbuxA4cvFqZrEpDFm2UAbSz6pwfQhjapXA=;
 b=YIUbREFNkj8gcD/n0/XVt1A4m4TcYtcVbOiVCwuYdpxEnxGK5nMv/kqJ6SpE9mUBjc
 VGMpJImc5GDseFXy/cxXbZ/pli70Tl2jyQxEI1S86st41DPAGuBa5vMDx46eoSWU1v+d
 hfsXVYE9tsHH3d0S31LOyGumxL5bZ0CEiV9oz6Txja/mencFqmTVDhKIH9kfukvtYWP2
 NAYcrekGO7HZHWfhEGD05c7x/RN/DSwdsDEuWcvjxV5oXJ70Qs8rTM52vncMvrBtbhQC
 QIAKh5WoVgbmBvusgaCqBYV0bVx5lHh8UQ2rUO9wtO8e4nN10WePinUkxrHpIlIIYtRP
 vUDw==
X-Gm-Message-State: AOJu0YznxRmFTvIubGtzSTP89HCi/s7O9OB1V8/if0J2mCF2qhqOHrrO
 F2F65rMaQxXvEmyrlwoof+gUUhcXSb2YzcV+St+5vQ==
X-Google-Smtp-Source: AGHT+IHAfD/ewmKNjd/GgbiJMr1Cw8blUIQdMhvFpOktiei6txrwp5CwWWY3JAxrhkY0er9gn6OYJQ==
X-Received: by 2002:a05:6a21:1c86:b0:18c:28e8:d55f with SMTP id
 sf6-20020a056a211c8600b0018c28e8d55fmr3264642pzb.8.1701649942751; 
 Sun, 03 Dec 2023 16:32:22 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 x13-20020aa79a4d000000b006cb9f436232sm6337525pfj.114.2023.12.03.16.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:32:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 01/14] boot: Reorder FIT and BOOTSTD to be first
Date: Sun,  3 Dec 2023 17:31:25 -0700
Message-ID: <20231204003144.899097-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204003144.899097-1-sjg@chromium.org>
References: <20231204003144.899097-1-sjg@chromium.org>
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
2.43.0.rc2.451.g8631bc7472-goog

