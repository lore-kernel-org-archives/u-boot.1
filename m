Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C73C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:44:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D59786A02;
	Mon,  4 Sep 2023 16:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E9n/+z6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BA4E8693D; Mon,  4 Sep 2023 16:41:59 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1601869F1
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34deefc2016so5397015ab.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838515; x=1694443315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+c63DhxEjEi71ZArTEybo2kx53g5lAOc+XYUwcFlPc=;
 b=E9n/+z6M2BU8pqNa/TEbnlBHRWAQ7WkZh2FU/JaNdu3MNPNQOR/T7dXoub4vKt884Z
 CQpW+5vDxnRq87ekn1PGa0QYSYxFw6F7Gz+nyxlg5EPdUSOIpjGEq4YrBLocG+U2IuVl
 l+bU8iwfnsKHMIRGZc2R/H/6ts7+8lzaIoBtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838515; x=1694443315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n+c63DhxEjEi71ZArTEybo2kx53g5lAOc+XYUwcFlPc=;
 b=Qd1AOr/4SizWSS2V5+ppsMXh+oYgUtlAxnMCHwNwFfukXyjwdcFttydFO5y28rPGRE
 jpMAuVYpI9XFRouG9KN1ds93UAJtqy3C00p4EB88Q1TRnntoyo+00aHSfu4M2zbvYf/w
 UywHO8SncaIuF3eSid6xDf87XHG0Q4yLUS650bEo+5F6H6PDM2NWmO7sUPitiq5WnJWV
 qryD2A22Xx0AZgX501QxTnj7L7r+CvLK6A/o6P288NGnZ7rOifh4nG4N7ogfSSehGZhy
 SEL1G/scdBJ4l+F5ecXMUBW7ebm6dMl55lXn4U6CqeARAgfdVWYMsWvxgYXAIpDBKMiu
 iCDw==
X-Gm-Message-State: AOJu0YzkCmF6ToR3kf4uwAgFdv0vvL9vkJdS76e0VIwLSaA4luyJI3gk
 8NzN5Y+nwa48zOkhZpu+4vVSTfMLfLarbiE5+j8=
X-Google-Smtp-Source: AGHT+IEy2Ci4RHh1ZIrFWv1csqOYGGasE8RCzeZlVnx1pCy2463TO5t5gX5Z0OiWfg0/mzHp5uuJNA==
X-Received: by 2002:a05:6e02:1303:b0:34c:ecc8:98eb with SMTP id
 g3-20020a056e02130300b0034cecc898ebmr10130148ilr.28.1693838515209; 
 Mon, 04 Sep 2023 07:41:55 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 15/20] boot: Make standard boot a menu
Date: Mon,  4 Sep 2023 08:41:18 -0600
Message-ID: <20230904144131.2699824-16-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230904144131.2699824-1-sjg@chromium.org>
References: <20230904144131.2699824-1-sjg@chromium.org>
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

Collect these options into a menu for easier viewing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index c9b7d3f710b6..17f54b926f05 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -372,8 +372,8 @@ config BOOT_DEFAULTS
 	  of U-Boot to boot various images. Currently much functionality is
 	  tied to enabling the command that exercises it.
 
-config BOOTSTD
-	bool "Standard boot support"
+menuconfig BOOTSTD
+	bool "Standard boot"
 	default y
 	depends on DM && OF_CONTROL && BLK
 	help
@@ -393,6 +393,8 @@ config BOOTSTD
 	        U-Boot)
 	    - bootflow - a description of how to boot (owned by the distro)
 
+if BOOTSTD
+
 config SPL_BOOTSTD
 	bool "Standard boot support in SPL"
 	depends on SPL && SPL_DM && SPL_OF_CONTROL && SPL_BLK
@@ -413,8 +415,6 @@ config VPL_BOOTSTD
 	  boot. It is enabled by default since the main purpose of VPL is to
 	  handle the firmware part of VBE.
 
-if BOOTSTD
-
 config BOOTSTD_FULL
 	bool "Enhanced features for standard boot"
 	default y if SANDBOX
@@ -673,7 +673,7 @@ config BOOTMETH_SCRIPT
 	  This provides a way to try out standard boot on an existing boot flow.
 	  It is not enabled by default to save space.
 
-endif
+endif # BOOTSTD
 
 config LEGACY_IMAGE_FORMAT
 	bool "Enable support for the legacy image format"
-- 
2.42.0.283.g2d96d420d3-goog

