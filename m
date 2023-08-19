Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03221EE49A5
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BDAC8702D;
	Sat, 19 Aug 2023 23:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T1d+KDHz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59B3186C20; Sat, 19 Aug 2023 23:23:28 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A191B86D9C
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-790fc019c62so52617839f.0
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480204; x=1693085004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8+FJsVNDZ7VRFBk7SEfIPC76wLQi3w6JjLh3SbFliw=;
 b=T1d+KDHzJbCCXLjwL1/dwOYHHDmbXWS/BpU9+TXgGzKfd1R1kyZdq+09HToXj7LV01
 naW70Tcy3bb3rP3cTF2dx8w4dLqTdBpg+453ddtw7A45w+5n7If67cE36YyZGlleiEYw
 sJvVbWL2ANR9C6fdbGu0OZViDy++V//G2tCgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480204; x=1693085004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y8+FJsVNDZ7VRFBk7SEfIPC76wLQi3w6JjLh3SbFliw=;
 b=MJfi1+ZpkZ39XtMTwNEZlDAIZHE6JoIrS+0zRa20pNqkhxmYGPUXNaAfabXnjs7JW9
 V8cNbS2UK1xVBgLSRIbplx44mCe1sOprrh6g+30Lyqp6w6p/ve2lzoFhgMiGMSI5kIyQ
 D+SGiEvd5k2pJ1SQ8MfVcf4kYQMzKhPTKn/5X5vgTjxfPs4D7qE0S9JeYoKweaa308m6
 hX4ysao4Eaoz2ZSR5VPhehAVIitsjZjp9ljPOD7z/X2YrFe+aNFz/8ABV2cpAQF2JwAV
 pm5yDR3xHqbiX7+WOIlTZcYIQK+ZWKTJHlYCyvdO61fid/OontdspAFPPoI2PAOdUCcS
 Abyg==
X-Gm-Message-State: AOJu0YyPcsP35xexp+TnNe5bM+LEOZlPrQApyGTHt3Fa/Jp8LJFOYYcv
 zmQPaEKGSnSgZOZBLqDAJJi2R3wQ9fv+wlkJRQQ=
X-Google-Smtp-Source: AGHT+IHKpMZ5HJbjJacMxt9qrD35fuA3PabR5XsafIJkT0mFp12gbUNPHLc3Wf0EQ5SX892DGMsplg==
X-Received: by 2002:a6b:1494:0:b0:785:cac9:2d49 with SMTP id
 142-20020a6b1494000000b00785cac92d49mr3687488iou.1.1692480204326; 
 Sat, 19 Aug 2023 14:23:24 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 08/19] x86: coreboot: Drop USB init on startup
Date: Sat, 19 Aug 2023 15:22:46 -0600
Message-ID: <20230819212309.1094440-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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

