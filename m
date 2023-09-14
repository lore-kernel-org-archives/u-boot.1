Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A1AEEAA58
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3C0987080;
	Thu, 14 Sep 2023 18:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WrJRnPem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E114387092; Thu, 14 Sep 2023 18:56:38 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E5CB8708F
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-795547f055fso40780839f.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710594; x=1695315394; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZBljZRue8CHwpjr4aeuYnAsGteEY3eBe5VB7+EoTPQ=;
 b=WrJRnPemUjIy2exOIyzUR94dCrsVXKnTKwVToWY1mlHmYjT/2Lzwmfz1aeLiVOq0rG
 oS0V47hrOgq1KbI2ID5agZoTmD0sHsJnixOIGjdGRDJlbHhxRQwJpfPS/TdVzC8XNry4
 ddlU5ggosCibO6cuCEMyzvdCjzVCrM0TlvF+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710594; x=1695315394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dZBljZRue8CHwpjr4aeuYnAsGteEY3eBe5VB7+EoTPQ=;
 b=uvqQKMYSTg3YTXGU/jA8miD2P0HSAqNmzjKlsxiT3ftl+czyKWMuV5pr0YlnJIb+mU
 uH5JOjoUPnhhvQyI93aY7VGJio/hkM/0lALlsldqks+r/kmCqAGUd/eGGXdDag2iDniF
 E9L7bBvjmRQOPAjk80hETobmtO047XHXdA3vYlc/tBPpHHOvbMmNtt8niXf8MYljxO9G
 uqWvgzaFCyJpGDKu1gEj8q3mfUy713NqAvhhuy+d9zuFhUoMk+so7kKhPPa2q3thk3YC
 M/MFGD/UHnhUCWUnZaagvr+Ej8+Dwjc/Ktj7LQY0U0U/uVLe4KCBtVvbU6+Dgnt7+rMD
 4xew==
X-Gm-Message-State: AOJu0YwcfdgPFBsXMxbTVZO/9VRzQaXO1JPACo0e1BtoIex0Z9l8xFsq
 ZwuI76wYuhT7mz+mnNNHAFarBmle4oQV08VNwG8=
X-Google-Smtp-Source: AGHT+IHApTnVZWTSX+wm6+OISMmj2ahMa9Kr++wHofqxX0QIlindzf38n0pq6clCnBcZy5F65GVYIQ==
X-Received: by 2002:a6b:4001:0:b0:792:9333:2cbf with SMTP id
 k1-20020a6b4001000000b0079293332cbfmr6522082ioa.6.1694710594044; 
 Thu, 14 Sep 2023 09:56:34 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>, Harald Seiler <hws@denx.de>,
 Marek Vasut <marex@denx.de>, Nikhil M Jain <n-jain1@ti.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH v5 04/21] video: Move the BMP options
Date: Thu, 14 Sep 2023 10:55:42 -0600
Message-ID: <20230914165615.1058529-4-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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

These appear prominently in the main menu at present. Move them to the
video Kconfig where they belong.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Just move these options to driver/video for later consideration

 common/Kconfig        | 11 -----------
 drivers/video/Kconfig | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index d916194b942..d11292f52c2 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -1168,14 +1168,3 @@ config FDT_SIMPLEFB
 
 config IO_TRACE
 	bool
-
-config BMP
-	bool "Enable bmp image display"
-	help
-	  Enable bmp functions to display bmp image and get bmp info.
-
-config SPL_BMP
-	bool "Enable bmp image display at SPL"
-	depends on SPL_VIDEO
-	help
-	  Enable bmp functions to display bmp image and get bmp info at SPL.
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 09f2cb1a732..ab927641bb7 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -959,6 +959,14 @@ config SPLASH_SOURCE
 
 endif # SPLASH_SCREEN
 
+config BMP
+	bool "Enable bmp image display"
+	help
+	  Enable bmp functions to display bmp image and get bmp info.
+
+	  BMP is a simple graphics-image file format designed to store bitmap
+	  images. It is primarily used on Windows devices.
+
 config VIDEO_BMP_GZIP
 	bool "Gzip compressed BMP image support"
 	depends on BMP || SPLASH_SCREEN
@@ -1162,6 +1170,14 @@ config SPL_SPLASH_SOURCE
 
 endif # SPL_SPLASH_SCREEN
 
+config SPL_BMP
+	bool "Enable bmp image display at SPL"
+	help
+	  Enable bmp functions to display bmp image and get bmp info in SPL.
+
+	  BMP is a simple graphics-image file format designed to store bitmap
+	  images. It is primarily used on Windows devices.
+
 config SPL_VIDEO_BMP_GZIP
 	bool "Gzip compressed BMP image support at SPL"
 	depends on SPL_SPLASH_SCREEN || SPL_BMP
-- 
2.42.0.459.ge4e396fd5e-goog

