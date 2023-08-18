Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E663AC2FC0E
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF4F986C26;
	Fri, 18 Aug 2023 02:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZlcSw11r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3EB686C1E; Fri, 18 Aug 2023 02:27:24 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6CDA86C13
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-349783c5d43so1393895ab.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318440; x=1692923240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8+FJsVNDZ7VRFBk7SEfIPC76wLQi3w6JjLh3SbFliw=;
 b=ZlcSw11rS3TJFjGtuQD6yVPDthlUCoBjy2b5tHvqIo3g6sgSOBNjDxsMIZ9DUD4zYJ
 yg2Xlu1t0S5G3l7EdJtu+8Mbtyt0zi/E6sBUxGzoRPrc9zgYCJHb7xxJs+H40T+W54H/
 CcuzxV5EF6d5IjDFpVeo1OdSxBTimTMhmj5Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318440; x=1692923240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y8+FJsVNDZ7VRFBk7SEfIPC76wLQi3w6JjLh3SbFliw=;
 b=WKdH22UzimCDcGh6L10rjfsOmFiavsTiPTn6DWVHnbSWVnG9k4Or6ETxL2MKH80A3k
 6JdUbphD9XfC7JHz4vIC+FkA+WAXzkSaghiCuYPGqp7CHup1ie53++PzE6fc3a0YSWce
 oimmv0U2i8nu9eQ4iVEGBhQ9hgaPONpDpYaQZRntDxhS3KYELX9juWU4z5R+1ri9NTMx
 9lHTwvgXBSM2U88JMyeTrwuxGpNgGfPsVv9zBTQfo0A8dH8GlmDUTJstK2fjuGo7ZuY5
 wsXjfOI37lx8BMvdYtVeQEbltaUYrF6LDr7hxz+knJaBi7BoNovA+po83FLCD2cIY8Pi
 IPKA==
X-Gm-Message-State: AOJu0YwDItO7ASpW6IUTbeAVcjQvlPYayv92seaxY3fYhwIy4/VpQ5ui
 zAxU4Vpmbd8Hd657aasAaZlVbzswQ4d1/i05R/U=
X-Google-Smtp-Source: AGHT+IGESLreRHAoxCMfcGkTwfqurtfbzTZ0PhLqU4GyVRLwPQcYsb+AbHl8Ag4SKs6QE7ueofTkJA==
X-Received: by 2002:a05:6e02:1152:b0:349:76c3:e8af with SMTP id
 o18-20020a056e02115200b0034976c3e8afmr1205383ill.16.1692318440545; 
 Thu, 17 Aug 2023 17:27:20 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Coreboot ML <coreboot@coreboot.org>
Subject: [PATCH v2 08/20] x86: coreboot: Drop USB init on startup
Date: Thu, 17 Aug 2023 18:26:47 -0600
Message-ID: <20230818002706.853550-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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

This is very annoying as it is quite slow on many machines. Also, U-Boot
has an existing 'preboot' mechanism to enable this feature if desired.

Drop this code so that it is possible to choose whether to init USB or
not.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/cpu/coreboot/coreboot.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index a0c62cce2293..fa3daeff8229 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -82,10 +82,6 @@ static void board_final_init(void)
 
 int last_stage_init(void)
 {
-	/* start usb so that usb keyboard can be used as input device */
-	if (IS_ENABLED(CONFIG_USB_KEYBOARD))
-		usb_init();
-
 	board_final_init();
 
 	return 0;
-- 
2.42.0.rc1.204.g551eb34607-goog

