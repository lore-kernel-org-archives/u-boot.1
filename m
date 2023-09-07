Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78353EC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51D1286B21;
	Thu,  7 Sep 2023 17:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NReAdRfj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C1EF86A82; Thu,  7 Sep 2023 17:59:55 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A453886AB9
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7926de0478eso57482439f.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102388; x=1694707188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jPUbC6TLjlElNyyhuAg27ehregX2pu5zOcv8hr5CVbI=;
 b=NReAdRfjnaJ3mEYOZSCQZejwn7TfeHs0UcJ98ZU27G1tH7/PGR0SPpfMaclgCZUBlf
 AJ74/Qk8BOCGkC6GnNnzFIv6IxxhUiBSkoz2XVFIniF5EXeOH8hA8JySHDmQfJeIJ660
 JD4BnHDvPcrHUiaZEozGgvyFFs6s1iPYIeFKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102388; x=1694707188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPUbC6TLjlElNyyhuAg27ehregX2pu5zOcv8hr5CVbI=;
 b=K+0uiOwcCJJfyPoL8OYIVXZCsixwgfF0K6Q+hpLEyJStdlY9tkKc6MmKCFC78o5RJo
 zjIMZKQ9fsyDZMt9SvvX7OIJ4m4p2g3qoppsS7wKdcIQ2+WklyI2VV9+jhLcekZZeZf0
 1k+UagUn+UlG6lZ1TFrHNfpV/x8pfpDVxK37Zh4endhvLWhFnNcLTuFO+Xb3XCSOyT7o
 VGOWnpCFBn3uvexyKwZlxmvgDEwixWVOxKsd+Ovwpm+CRm84mJ0jzn8YYzYW/nZjEHuZ
 bwuPvoT6cXDcU44ckgYxQYh9s85S3v/JBUNyCLI/GCYodsjiSzRWwlOJCbqmp21/aAtx
 dEOA==
X-Gm-Message-State: AOJu0YzIfkmrsYRdWo0jciSs3Gbehrm7aMYDhzdKoCImcAo0hRBGl+C3
 19YXGm/Ch1BS0JX16dM4UNuP25FO0U/bY77AE5U=
X-Google-Smtp-Source: AGHT+IFId+PwM8AY5agryGm+mNDHElpV8kjP4b8tcdqTLNmReKm7WoIl7HmdnAT9aoRJQRR4Um97kA==
X-Received: by 2002:a05:6e02:1546:b0:348:7f18:68be with SMTP id
 j6-20020a056e02154600b003487f1868bemr2925665ilu.4.1694102388334; 
 Thu, 07 Sep 2023 08:59:48 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 11/22] boot: Rename Android-boot text
Date: Thu,  7 Sep 2023 09:59:16 -0600
Message-ID: <20230907155933.48511-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155933.48511-1-sjg@chromium.org>
References: <20230907155933.48511-1-sjg@chromium.org>
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

Phrases like 'Enable support for' are pointless since this is an option
which enables things. Drop that part so it is easier to follow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index f8b8d6089511..017f7117d57f 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -3,7 +3,7 @@ menu "Boot options"
 menu "Boot images"
 
 config ANDROID_BOOT_IMAGE
-	bool "Enable support for Android Boot Images"
+	bool "Android Boot Images"
 	default y if FASTBOOT
 	help
 	  This enables support for booting images which use the Android
-- 
2.42.0.283.g2d96d420d3-goog

