Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731D2C83F2B
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 03:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69CD28658D;
	Thu, 31 Aug 2023 05:53:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gLGuxV24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE09A8659F; Thu, 31 Aug 2023 05:53:42 +0200 (CEST)
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4520486597
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 05:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-48d0ceedda1so160128e0c.3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693454019; x=1694058819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97Ivjip78i6z+Z1ICdsur5dgttq/2kaArMPS8AYyVFs=;
 b=gLGuxV24/4SXB8ES3ROsf1Lw9P19qp73uEwFQdEsoA+um9YDAL8/WXqypadJFzuy6j
 RGmgLqCZSBoD5KynUuVRcpnGfxxmKB40TKcGrHwjDJASTVQc7ivwywgXgrqz+rFzrG/o
 O4VgMP/k+yQCDlbjk0dyFI2hbZaEO657wGq/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454019; x=1694058819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97Ivjip78i6z+Z1ICdsur5dgttq/2kaArMPS8AYyVFs=;
 b=aC3nf79GLcWHeTFP+XzKl6IzS5tjGYPQFbj8QWmHinc5ou/G18u0oOLs0RNBPfYbZc
 NXtT3BNXwl1HOiX6THlIHhJJ0NX0Dy+D+8XmPtROkPRWJXZWIkprIUwC+A72MpGFJ3aL
 Hv0eQlgE0S+qcI60TzaqJAj2d5AsN2ob0PLE4NBrp4PGSa1rCi9iPRZ4n4AM7ArXcXFa
 wMfmDZMd5UyGIB2ORJZSWxbTZNauojwr07lSPDHClNZREfIgdBmkuUWym8qrZ1eq9V9P
 9MhHlf7lknYp7WQeyMgbCuSBqF1cNYUVuQkBr8+FWWVeSDlYSxY9pmPa2dq0wdtD5GYY
 FxVg==
X-Gm-Message-State: AOJu0YwtaL2YZ663u7Cahk4Fw/Et1y7sW6IGeXGq9/1RBZPkE+vkLqHX
 jNvm/CZf+vKcFxl/2JYSp8LxAIsI78T0syx8xLg=
X-Google-Smtp-Source: AGHT+IEn98wjCk+Zb5TXIY363WdH/gEhoczdF7msORutCJRXxhlUyjj+lFL4ZKrGuGODCwFGl2ejnw==
X-Received: by 2002:a1f:cb01:0:b0:48d:1071:efd5 with SMTP id
 b1-20020a1fcb01000000b0048d1071efd5mr3579516vkg.13.1693454018991; 
 Wed, 30 Aug 2023 20:53:38 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 dy47-20020a0566381d6f00b0042036f06b24sm160002jab.163.2023.08.30.20.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:53:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 11/19] boot: Rename Android-boot text
Date: Wed, 30 Aug 2023 21:53:05 -0600
Message-ID: <20230831035319.2316665-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230831035319.2316665-1-sjg@chromium.org>
References: <20230831035319.2316665-1-sjg@chromium.org>
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
index 70cbcc38fdd4..f603a64a23de 100644
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
2.42.0.rc2.253.gd59a3bf2b4-goog

