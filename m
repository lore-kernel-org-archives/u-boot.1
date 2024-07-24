Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B2DC3DA61
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BE1288A3A;
	Wed, 24 Jul 2024 17:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YNTeYb5J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 167AD8896B; Wed, 24 Jul 2024 17:10:12 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A04C8897D
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7f99d50c1a6so315746439f.0
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833808; x=1722438608; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+/NkfvOlmHXh5JlBXZSAfYoAOK2BgUyy8RVvcWezvo=;
 b=YNTeYb5Jfft6WMsA/fo85LUmso7BmdBePcBCCoTFc4fyReILmyBDIeIztAC5Rsm7T7
 ZXLwphPO93GtA3igkBy+2+L0ZrL9RZ94oxWKNcehwBarwkgrcA7dEeBb2JxgymQit8jb
 XfBp6yrCaNn6AB/YELW6q9o/JLQd5ic4tuQyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833808; x=1722438608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X+/NkfvOlmHXh5JlBXZSAfYoAOK2BgUyy8RVvcWezvo=;
 b=tn5qJvBEZh02Oep7D9B2oRqUTN7RQlbmOIJ0wMl0o/ZUhRkAYxGKx7RGmYiltA8KiH
 Zog4V88Z73TRMEXTnNMaoFoQiXBbFbqnRd5lcuEwGaaCdioA/MrkKK3zbKT7nb8XIKQV
 f1w8oTySpgu5WFF5yTe9nlZyGjg+OrUezLFvKvAr8sPfhrXtPeMGnqI++jkfx49IUIy2
 b0HPt69zbueWTtbdWagSMf/LeRQv6u+TfhSk57G1WwKOF78riVF0ajqpJjXE9HfPi22U
 c36nLqi+QF7PXIrozkHNlNbuXrK6xaQX1s8SbQWf4km/aHpT3AYOMiCP7puE6XKBlH2t
 DzlA==
X-Gm-Message-State: AOJu0YxWWeQ4A8oQuaEtB3rKiPBdlYm+cNZx6gnho/HZkWVf51ZVWN28
 YWTALF6ApzvWThIka/MK4nbXGyDpcTT7Awbavg3KI2qQaJwOVOypVAvrJpz6+OAog+gCH5YTzGY
 =
X-Google-Smtp-Source: AGHT+IGYV+vm56SQpiTL6rltApQC9nPSMsw6A+ldRvbv36F1cp0TwEZIk9Tvqv89p4rPZPCH2nnZww==
X-Received: by 2002:a92:c241:0:b0:383:5ada:7a65 with SMTP id
 e9e14a558f8ab-39a16d5dc55mr39045995ab.26.1721833808129; 
 Wed, 24 Jul 2024 08:10:08 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:10:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 35/35] doc: Add some guidelines about global data
Date: Wed, 24 Jul 2024 09:09:22 -0600
Message-Id: <20240724150922.2343249-36-sjg@chromium.org>
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

Update the documentation to provide a bit more information about how to
use global data.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/global_data.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/doc/develop/global_data.rst b/doc/develop/global_data.rst
index d143f27eedd..2863154ea42 100644
--- a/doc/develop/global_data.rst
+++ b/doc/develop/global_data.rst
@@ -51,6 +51,31 @@ U-Boot. The value of gd has to be saved every time U-Boot is left and restored
 whenever U-Boot is reentered. This is also relevant for the implementation of
 function tracing. For setting the value of gd function set_gd() can be used.
 
+Guidelines
+----------
+
+The global_data structure is placed in some memory which is available very early
+after boot to allow for a minimum set of global variables during system
+initialisation (until the memory controller is set up and RAM can be used). It
+is the primary data structure passed from pre-relocation U-Boot to
+post-relocation, i.e. ``from board_init_f()`` ``to board_init_r()``.
+
+The global_data struct exists for the lifetime of U-Boot. Since the struct is
+used by all architectures, fields added should be useful for most architectures.
+Fields which are only needed on one or two architectures can be placed in the
+architecture-specific ``struct arch_global_data``.
+
+In any case the struct should be kept small, since it uses precious SRAM on
+many boards.
+
+SPL also uses global data, as well as U-Boot proper, so take care to avoid
+adding fields to SPL which are not actually used by SPL. You can create
+access functions or macros in the header file to avoid filling the C code with
+#ifdefs.
+
+A flags word is available, which provides a convenient means to track the state
+of various initialisation phases within U-Boot.
+
 Global data structure
 ---------------------
 
-- 
2.34.1

