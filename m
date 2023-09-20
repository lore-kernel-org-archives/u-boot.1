Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1BFCE79A8
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 190EB86C0E;
	Wed, 20 Sep 2023 05:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eASAzkuH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B26E86C16; Wed, 20 Sep 2023 05:00:42 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 170C886C24
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-34f6c725d94so19792995ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178838; x=1695783638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0sRI343GvqzYFDxWMILmwgFvZaS020FNFioeiUle4sM=;
 b=eASAzkuHESpBNAngu8Gb6GNWDr7Ry45p9c+YTGy49qQamJrsLl45ZnR1bJSi3mHmPi
 rJx0k+tnjxZ5OK5MPbKaeLqqwl6BTNdovrOMpO8HsNA91ayWp9krGunxLfiwrvxs4rB4
 5uCi0heQXjndumHCo7jgo4oJ6QZwc5+WQt55M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178838; x=1695783638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0sRI343GvqzYFDxWMILmwgFvZaS020FNFioeiUle4sM=;
 b=ZSlgNN246E6jUdyCOMbUNOitkyS5MhkuzHLbCg4/gvA07KP1YQUnhyWfHFbBAtdVa2
 BT+47wcbxwRWkCeUbwXvxn78YQlqQ2LWE2ea65Ghdf9KB1L1X/PDhP/ljQJjie20Fi00
 3g/DY5Xr+47A/cnkCT6wukosXZEg0kd8yGAi3d6ROBgsMwiw93n0VrlHhXXk1ZO6Ajsp
 QCyHCAbhQemXSc97y+I6BLYcJZ43kMpIO3QBUy7f11QZllM5El70k6ZdP8DCg0kwfwNB
 QG4NZ/T8vtlQz1l424nqwaHp2Q8QPlL457QY2hVNp/oVsJsWgXI19P6/RHK5LO3uUxhC
 EYKw==
X-Gm-Message-State: AOJu0YzQvxbA1C/CtoUsJcc0NIWeYANnibxzRy0nRbx+tWWywPtAo4Fq
 4qrrM48J0GeJXQHyG5ohYQG1093aQzIg/HIzRqg=
X-Google-Smtp-Source: AGHT+IEWBuTsA1AQ2lBob9RJ6E9k+n6YPAi7RND5dMO7fMpVuwRJ0AzzmD1opFNAKooltArNqwLhbg==
X-Received: by 2002:a05:6e02:10c6:b0:34a:c4ae:1937 with SMTP id
 s6-20020a056e0210c600b0034ac4ae1937mr1526002ilj.13.1695178838722; 
 Tue, 19 Sep 2023 20:00:38 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 08/20] x86: coreboot: Drop USB init on startup
Date: Tue, 19 Sep 2023 21:00:09 -0600
Message-ID: <20230920030027.1385833-9-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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

Changes in v5:
- Make use of the uSE_PREBOOT mechanism

 arch/x86/cpu/coreboot/Kconfig    | 1 +
 arch/x86/cpu/coreboot/coreboot.c | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

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
-- 
2.42.0.459.ge4e396fd5e-goog

