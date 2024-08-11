Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17781C52D7B
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 14:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA5F688986;
	Sun, 11 Aug 2024 16:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wkfx3yOV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0F2288914; Sun, 11 Aug 2024 16:51:22 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94DFF88916
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81f94ce22f2so126809039f.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387878; x=1723992678; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CESaYHHk9fdhaymggqotZEdrBupyGJoR/TzQxDDk3Bw=;
 b=Wkfx3yOVDyUq9QFeKuNiyK93mzKkk09WC5s4VpQaDs/lvLjlYKxvtWxaKDVALrkQxW
 26qTSv2EwV+dvI9qeunQ+BQ0OTH7C++6u/Uf19OAFxk2rJdfypI2tINPniTnbfmh/qTN
 lOyQjm/9V4ZeSLOMin/HLHAxvu0a9HxRoS5rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387878; x=1723992678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CESaYHHk9fdhaymggqotZEdrBupyGJoR/TzQxDDk3Bw=;
 b=QnxyFBXZGZMInbtaIRnIpdLTFZpdlW+MBV/vcIsQj7GN8A+ARsrKZiTNMZrPNEFLpm
 xU+xieOI9j9rB9BA3RjbnykCbPGsMk0pLtgoS6c6B3lGXTzYwYT0y4YZiTPq8oXGiiBu
 rQ+KfYHem+BIet6P4YWSkGIT7wP4Do1wji8U1HDDpVnkzB0+xUfuBmdrLYeRq/mOXclv
 QLpLeVaehyN359HWzL311iLqPh5hRm77p35lbWYd2ZFZAqt+n+NjMleNCUqalTl0quAk
 vBvA6scGItTgWnrf+QuO/kOcJ9i582dgXTNDC+Q7RCiqx6CB6/ikh5sDxL88/UzXegQQ
 x9Tw==
X-Gm-Message-State: AOJu0YyCV62tJPKGH0Nu1aW6b7sT/uRB3ki6f/hVIBQmJ/fMzlmfJCcG
 iu5eLcG7lIKYoRcLMZchym5Favl0AOCe1NkdxqYiGWE0goGUKZ7bYXh9bO8tw7lIv8qscQMuvXE
 =
X-Google-Smtp-Source: AGHT+IF//yTUl9WuloZOhwH6fQQXGGqs4MPUSTc7XQxl89Eb+INunSaNeX0g2E9FyOtR0DKaPApJKQ==
X-Received: by 2002:a05:6602:2dd4:b0:81f:d579:335c with SMTP id
 ca18e2360f4ac-8225eee0b30mr958897239f.17.1723387878186; 
 Sun, 11 Aug 2024 07:51:18 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ca769fbe17sm1076047173.101.2024.08.11.07.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:51:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 06/18] mx28 / mx51: Drop CMD_DATE
Date: Sun, 11 Aug 2024 08:50:35 -0600
Message-Id: <20240811145047.4189460-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145047.4189460-1-sjg@chromium.org>
References: <20240811145047.4189460-1-sjg@chromium.org>
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

These use pre-driver model code and it is several years since the
migration deadline. Disable the 'date' command so that this old code can
be removed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/mx28evk_defconfig | 1 -
 configs/mx51evk_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/mx28evk_defconfig b/configs/mx28evk_defconfig
index 1fe68ef93f9..dddb57efd3e 100644
--- a/configs/mx28evk_defconfig
+++ b/configs/mx28evk_defconfig
@@ -32,7 +32,6 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND_TRIMFFS=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_DATE=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
diff --git a/configs/mx51evk_defconfig b/configs/mx51evk_defconfig
index e5178fb3d6b..5932a15a33d 100644
--- a/configs/mx51evk_defconfig
+++ b/configs/mx51evk_defconfig
@@ -31,7 +31,6 @@ CONFIG_CMD_USB=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
-CONFIG_CMD_DATE=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
-- 
2.34.1

