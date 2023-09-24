Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5269BCE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54E5686C20;
	Sun, 24 Sep 2023 22:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="atojI28j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CB3186C0D; Sun, 24 Sep 2023 22:40:41 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 671C386B86
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3511d2f6130so11124755ab.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588038; x=1696192838; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nxR/ttRhDCeJuxVUp+NFJaZ9r84MnHZ3LZNdWsXE+zU=;
 b=atojI28jOjy5PfDFfPjU3YIPEFPq3fSwdbtF6z3/bJBzY8oBcfvpmNP+/CGuwh1j2F
 2CzBUIwK5Xh+RDIxI8h9GThCMemG1HiKhRKWjVQ/1e4dzZ8egJaWxHNG6+dvjslwIt/n
 DPg1HJY6HcSn8j2BhUpGrZKqRf1wP2VkN1uhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588038; x=1696192838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nxR/ttRhDCeJuxVUp+NFJaZ9r84MnHZ3LZNdWsXE+zU=;
 b=BDkV/YC3iHCNnvRMoHR1RY8r55fFskFJsiPovuEo5U2GlY86uiYILm2O2f5OC7p2s7
 sn/YhSvOIIogwriguuT1C2YMwmp4cLpmSH3sGKcUntl/ScR0aL33YqyGmSRfv3IKZHDi
 +FnIBZRRo0NkMn/HDg+Q5QMebWoNcANZFxyXwDJyUGYFfFZUlgETczFsnb/XJF8o+Nik
 dDm6zFxghd8AGAlJyctIEXsziceyELe7hx4q3zi3f2sRvaspD9x0jhN3JwGO2WtX7SUL
 NcThd1fllROqUS/A6ohjvokMflJyua0BQaUpacBrlO9h/hWPSq5lc9wG0HO/HwVl6hZm
 25yw==
X-Gm-Message-State: AOJu0Yw+28okxFr2XArqbjFPGFjxqWWu49WIksc4i4z8jKBHI0lkee9L
 Z67nzaalCyFFLQBAjVONLpcePirvZzty7J1itvc=
X-Google-Smtp-Source: AGHT+IHFR2YxzQK3YEQQ2JoFbU7FCLCfOTqnLWHCiTZEGDHZl+eFN2ZNiYnu2KxpjUXLeWOp2VAaOA==
X-Received: by 2002:a05:6e02:10ce:b0:350:f510:3995 with SMTP id
 s14-20020a056e0210ce00b00350f5103995mr5187529ilj.20.1695588038036; 
 Sun, 24 Sep 2023 13:40:38 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 21/25] video: Dont require the font command
Date: Sun, 24 Sep 2023 14:39:39 -0600
Message-ID: <20230924203953.1829820-22-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

While it is nice to have the font command, using 'select' makes it
impossible to build the console code without it. Change this to use
'imply' instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index ab927641bb7a..21ea5c860cca 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -180,7 +180,7 @@ config CONSOLE_ROTATION
 
 config CONSOLE_TRUETYPE
 	bool "Support a console that uses TrueType fonts"
-	select CMD_SELECT_FONT
+	imply CMD_SELECT_FONT
 	help
 	  TrueTrype fonts can provide outline-drawing capability rather than
 	  needing to provide a bitmap for each font and size that is needed.
-- 
2.42.0.515.g380fc7ccd1-goog

