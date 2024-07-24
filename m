Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976B1C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 262C6889B4;
	Wed, 24 Jul 2024 17:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PPz+zekO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA8E588971; Wed, 24 Jul 2024 17:09:45 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9ACA88937
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-398039f8b7bso23909235ab.3
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833782; x=1722438582; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fM2thlPm+51/Wv9sw6R7iyRrrX69x8OUoAgUNfbBmk4=;
 b=PPz+zekO9s+unF6SGt2bqgC6cXS+ZwGnF69MfuDsnjv5yTX8ethBm81tXhZiocSPyw
 EpwUN+kfjuamF0fi9Ce77ioFCtFxmHoOtrwlBPcz0NclEfXp1Fvypj3s8sQr2Dpay12g
 TVRlVHIBU24RPZPKAnjMfz2hB+xIdUMQOBD1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833782; x=1722438582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fM2thlPm+51/Wv9sw6R7iyRrrX69x8OUoAgUNfbBmk4=;
 b=k9inXZ2pM/lOiW2j5A8KX9pyZ98JCU7avPk433NuWICuVWGL1z+wJtUJAi++XVsL67
 azmuLIByiJkhtwxebKO/TH152nokOhl7CCSHiFMVM8kmoQYMPBdY72UROCm3QZucTRsg
 aN4r5YlqHNs9FyfQy7nvlfzhYQIF75w+myeA+Eo4txb+W8ZEB7yeLB2okVPeX4umJsJj
 FYRjK9T2yxnrR5re1zMjrFuCgBQSCZiL4x/HxNaSNt7lDLiGnxDok6h3Wl20q+8lj2OK
 s5N7GU8Sfb9K+O97H5mHhIz0zcJx4LgJ/noK99PuGeJtk+jqEdV8JsGdtVf4ewSTR1R7
 Hegg==
X-Gm-Message-State: AOJu0YwPXAK+C6hY+h7Pu/bHBRZNz9J5gkCwV9Ysl28XmeBi0dGQtzgc
 IpsoFudjWnSFi3d8gVw51jVxT9S4lN7gwpjzVdFlQCVuuLeGaPDSKX2SQEjZ1VzWpA3Tks9JuDI
 =
X-Google-Smtp-Source: AGHT+IH0fWfp3Lur4rorO0rZDxqqC6Gcl32NAx36rVMvhWyIK0Tr304tEleDjvFBcD4Hho1nV5l5fA==
X-Received: by 2002:a05:6e02:1a81:b0:396:ba86:318f with SMTP id
 e9e14a558f8ab-39a194d7b69mr27933775ab.24.1721833782478; 
 Wed, 24 Jul 2024 08:09:42 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Ilko Iliev <iliev@ronetix.at>
Subject: [PATCH 07/35] arm: ronetix: Avoid accessing global_data fb_base
Date: Wed, 24 Jul 2024 09:08:54 -0600
Message-Id: <20240724150922.2343249-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

Use the new video function to get the framebuffer base.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 board/ronetix/pm9263/pm9263.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/board/ronetix/pm9263/pm9263.c b/board/ronetix/pm9263/pm9263.c
index 1de1bd68701..8125f064cf1 100644
--- a/board/ronetix/pm9263/pm9263.c
+++ b/board/ronetix/pm9263/pm9263.c
@@ -9,6 +9,7 @@
 
 #include <config.h>
 #include <init.h>
+#include <video.h>
 #include <asm/global_data.h>
 #include <linux/sizes.h>
 #include <asm/io.h>
@@ -110,11 +111,12 @@ int dram_init_banksize(void)
 #ifdef CONFIG_DISPLAY_BOARDINFO
 int checkboard (void)
 {
+	ulong fb_base = video_get_fb();
 	char *ss;
 
 	printf ("Board : Ronetix PM9263\n");
 
-	switch (gd->fb_base) {
+	switch (fb_base) {
 	case PHYS_PSRAM:
 		ss = "(PSRAM)";
 		break;
@@ -127,7 +129,7 @@ int checkboard (void)
 		ss = "";
 		break;
 	}
-	printf("Video memory : 0x%08lX %s\n", gd->fb_base, ss );
+	printf("Video memory : 0x%08lX %s\n", fb_base, ss);
 
 	printf ("\n");
 	return 0;
-- 
2.34.1

