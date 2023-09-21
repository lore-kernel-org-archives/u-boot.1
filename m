Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77005E7106C
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 13:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 561BD866D0;
	Thu, 21 Sep 2023 15:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bgO+jxqw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1719F86660; Thu, 21 Sep 2023 15:37:59 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09A6686530
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 15:37:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-792979d4cb5so39378139f.2
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695303475; x=1695908275; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/MN8L+PtDQyzVfV5/ghsXz9EzeVeEQE1zHwn9ZPihU=;
 b=bgO+jxqwrDGPuPPa8g2mUTO4vvijS8mvwyrld9hUK7yjkcmitm+z0+vDdi3zUJcqIp
 Rifn6zGXCZE2zVejXww6QNYi1U4EOh7IkYAAYmy+BcaM80Jo3ZF38iHf8prZwA3/uaLf
 zyvvWfHxmeMQWAWo4Ibt7aqyMjF9doE2HA6u0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695303475; x=1695908275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/MN8L+PtDQyzVfV5/ghsXz9EzeVeEQE1zHwn9ZPihU=;
 b=J7k6bSY8RpQ7O86oa1ShadLnhUR009l3ENa/osRr3Avm4y7Ag6kIWzo3tZxXMsOCWv
 WRZP1s1N6NGHRsNWeSqCdJPlk0T33gegPoSO5e6FARKkk/E473quU3A0q3sZVAqA+1T7
 teP7RfR4Xy+TnILYRCu0OwhNctEhWrvfVcqMsq7mR1BiyobmFaCGfOpgfMEurU8MJtLe
 MQH0pe0M9JfzACmKu5cToa+cYh8Ziszybk6b+ZgY4y86KvQnCMRvv0Ms2cH42/8sRu2h
 sbF23gEoU4f39mm0KPXzi2ipY3m260ugbB9/RMHkU+J3xTgizSrHJT/o9xyn4/QmNg7B
 v5vw==
X-Gm-Message-State: AOJu0YwuPqNCpSt12twDvQrZuPQEZRdpVZRfUnSR1zEmbS1WSfH4psF6
 MKj28lXIkmVmu+yLw6CYnI/JybadbZbJyy/98dk=
X-Google-Smtp-Source: AGHT+IGPpfTgL1f+KS2l15zH9CrZ7RdlK52Kzf7bZmU8KTzlXl5U7qeAcJqIpNDWz+zdfuuQAGzW5g==
X-Received: by 2002:a5e:d510:0:b0:795:bea:ae13 with SMTP id
 e16-20020a5ed510000000b007950beaae13mr5749593iom.20.1695303475606; 
 Thu, 21 Sep 2023 06:37:55 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 w17-20020a5ed611000000b007835686237asm389786iom.27.2023.09.21.06.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 06:37:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 2/3] x86: coreboot: Drop USB init on startup
Date: Thu, 21 Sep 2023 07:37:44 -0600
Message-ID: <20230921133748.1543007-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921133748.1543007-1-sjg@chromium.org>
References: <20230921133748.1543007-1-sjg@chromium.org>
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

Use the existing USE_PREBOOT mechanism instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v7:
- Add docs about how USB keyboard works on coreboot

Changes in v5:
- Make use of the uSE_PREBOOT mechanism

 arch/x86/cpu/coreboot/Kconfig    | 1 +
 arch/x86/cpu/coreboot/coreboot.c | 4 ----
 doc/board/coreboot/coreboot.rst  | 7 +++++++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/cpu/coreboot/Kconfig b/arch/x86/cpu/coreboot/Kconfig
index b97c27790419..178f8ad18162 100644
--- a/arch/x86/cpu/coreboot/Kconfig
+++ b/arch/x86/cpu/coreboot/Kconfig
@@ -25,6 +25,7 @@ config SYS_COREBOOT
 	imply FS_CBFS
 	imply CBMEM_CONSOLE
 	imply X86_TSC_READ_BASE
+	imply USE_PREBOOT
 	select BINMAN if X86_64
 
 endif
diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index da43d66e95d7..82fe4c71cd27 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -86,10 +86,6 @@ static int last_stage_init(void)
 	if (IS_ENABLED(CONFIG_SPL_BUILD))
 		return 0;
 
-	/* start usb so that usb keyboard can be used as input device */
-	if (IS_ENABLED(CONFIG_USB_KEYBOARD))
-		usb_init();
-
 	board_final_init();
 
 	return 0;
diff --git a/doc/board/coreboot/coreboot.rst b/doc/board/coreboot/coreboot.rst
index 10ef78bb5ada..10a251c2b64f 100644
--- a/doc/board/coreboot/coreboot.rst
+++ b/doc/board/coreboot/coreboot.rst
@@ -85,6 +85,13 @@ build in `$CBDIR`::
 This allows booting and installing various distros, many of which are
 64-bit-only, so cannot work with the 32-bit 'coreboot' build.
 
+USB keyboard
+------------
+
+The `CONFIG_USE_PREBOOT` option is enabled by default, meaning that USB starts
+up just before the command-line starts. This allows user interaction on
+non-laptop devices which use a USB keyboard.
+
 CBFS access
 -----------
 
-- 
2.42.0.515.g380fc7ccd1-goog

