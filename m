Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99321C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36C1986997;
	Mon,  4 Sep 2023 16:41:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M59cFCDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B383C86936; Mon,  4 Sep 2023 16:41:50 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F18986977
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34b0f3b792dso5363065ab.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838505; x=1694443305; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vEajdKjZC4jHbmtmiAPuIgOet42kRiJgzLo4f2LaWq4=;
 b=M59cFCDkMs5ryNC3/kd5Scq54fHzg29I1rICtJTTD35c/fZ6F77EmH90jx+yfW43X3
 p7lDZ+215dTxIitXazeruDv8EkDFODcpIUtqFUd+3QzY/dig2heL+syvihpYpY2aylQ8
 X4VoO6f0gVMOa9oPWsniltIF4A2ROUPoa51Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838505; x=1694443305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vEajdKjZC4jHbmtmiAPuIgOet42kRiJgzLo4f2LaWq4=;
 b=A7o3fBh90DwxzVOqDZ4DraZ2TEzZX3Cit3p5fG4XwQnatj/l4E4uAdqRguenF37Frc
 nARMOyOiffm+nyv744BOBGkdc1NxwnCHSFunEwmS0/mqdueME2hKU40FvQi4WpPInRPO
 P8SXKPNuXjKFa8XTPzOspt92iTFVNxX4uJC3gFTZkhZ0VAMyLXGKUd37aJhzXqGWI/Pb
 lcP9O8wKhOAftgH+sYbPKGn8lMZdHrDB6vXn8Rt18Xmtr4HJOdEYNPo2ypdTU28iO5nD
 h7e/SeAE+giS1OyugqWcIoZdk78O/usw3npDPP0jirTr2/0L4/JMrHHfh8A2F4ZzY2Uv
 S6LQ==
X-Gm-Message-State: AOJu0YwEbc/KJ9Hjb3M77mbfkZkNpUR5U3hCtjwr2Zr1IgJHfNcJFZlb
 tpuIvJ1Xa1V12XKAT1/qKKFiJ7tzr6Hts2me8Rc=
X-Google-Smtp-Source: AGHT+IEd9XVakWd5vw2IZVylImfGNlE7DFlt6U7Wr0ZS3dR6xvHtPBkSZ+caoYvQ46Xu9QORfudVVA==
X-Received: by 2002:a92:4a0e:0:b0:34b:aec8:e14c with SMTP id
 m14-20020a924a0e000000b0034baec8e14cmr10207080ilf.3.1693838505017; 
 Mon, 04 Sep 2023 07:41:45 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v3 05/20] video: Move BMP options and code to video directory
Date: Mon,  4 Sep 2023 08:41:08 -0600
Message-ID: <20230904144131.2699824-6-sjg@chromium.org>
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

Put the options and the common BMP code with the other related Kconfig
options in the drivers/video directory.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/Kconfig  | 11 +++++++++++
 drivers/video/Makefile |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 4eeb8ce022a6..336508af6a57 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -682,6 +682,11 @@ config BACKLIGHT_LM3533
 	  LM3533 Lighting Power chip. Only Bank A is supported as for now.
 	  Supported backlight level range is from 2 to 255 with step of 1.
 
+config BMP
+	bool # Enable bmp image display
+	help
+	  Enable bmp functions to display bmp image and get bmp info.
+
 source "drivers/video/ti/Kconfig"
 
 source "drivers/video/exynos/Kconfig"
@@ -1125,6 +1130,12 @@ config SPL_VIDEO_REMOVE
 	  if this  option is enabled video driver will be removed at the end of
 	  SPL stage, before loading the next stage.
 
+config SPL_BMP
+	bool # Enable bmp image display at SPL
+	depends on SPL_VIDEO
+	help
+	  Enable bmp functions to display bmp image and get bmp info at SPL.
+
 if SPL_SPLASH_SCREEN
 
 config SPL_SPLASH_SCREEN_ALIGN
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 6841d8965842..88b37b1855c6 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -3,6 +3,8 @@
 # (C) Copyright 2000-2007
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
+obj-$(CONFIG_$(SPL_)BMP) += bmp.o
+
 ifdef CONFIG_DM
 obj-$(CONFIG_$(SPL_TPL_)BACKLIGHT) += backlight-uclass.o
 obj-$(CONFIG_BACKLIGHT_GPIO) += backlight_gpio.o
-- 
2.42.0.283.g2d96d420d3-goog

