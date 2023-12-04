Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E331AC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5512D87900;
	Mon,  4 Dec 2023 01:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ttc8R5A8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F9C887717; Mon,  4 Dec 2023 01:33:25 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 509F387900
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:33:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6d986a75337so531764a34.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701650002; x=1702254802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p40d57gUz++J0Oy93EeFeFMnQY3fm8FZ08MbC2I83k4=;
 b=Ttc8R5A87G4JB+rh9SM0dUQqrztKA4tKjPyxDHtho6R2tTDNxTB36KLlIWM7s45Uth
 mHG93IhUkg/XIYvM3AuNzQGaa89FDNrhYw34J9u8GOa35TjQa/MJP6Y1wgv6oEV2KDvo
 wC4j93Gx91RIj4dBbgQZn3cx638Qydv5EwF6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701650002; x=1702254802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p40d57gUz++J0Oy93EeFeFMnQY3fm8FZ08MbC2I83k4=;
 b=J0AYs8nz/dTe5hteaxSKV+7cpZj3oO+AcmcZIDIIH6efGeEyFXw+1N0bNe3P2IpH2P
 ncO4+NS2ElNVq0eW6yYo16qUm4NtVwcjNCPJa6BJYW1jjIrbIn0jT0d+qIijlWkTMFyB
 2g4C+pWDwCJAwQeYbPo98+IU3rjSfW0bxxKHdXLPZZGBDV0+l8RfGagA8ojhxjBunChR
 hiwlMYITBOUg82rsiCvPiq+YytqqYwZ7KoxTampIoMcFCPqoGU3pjHMHpa1AP/Iyhzdu
 N4XFPKw442fab7JM68ev17y4ZFnwE5XlofIGH3H5SDy5ImtkA1m68cwRxUOK2gMRiRHG
 5Fhg==
X-Gm-Message-State: AOJu0Yyzk2PxwG1hQ1ilsX3fHKzdUCQFX/pJxKUdgTsT0gD4W/EY1LzQ
 TB5kI6lRePrIsTVjW135GC1YkQE0V9JxqXZA6Z+IIQ==
X-Google-Smtp-Source: AGHT+IHhgQT9jX8C6s3KptWbLTB6+tNuy4d76V5nVWfU4Pej0Eh8CwMtRdcMoupVrJ5QiWbJxgynaw==
X-Received: by 2002:a05:6830:2905:b0:6d8:119d:a0a8 with SMTP id
 z5-20020a056830290500b006d8119da0a8mr4012588otu.13.1701650001953; 
 Sun, 03 Dec 2023 16:33:21 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 x13-20020aa79a4d000000b006cb9f436232sm6337525pfj.114.2023.12.03.16.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:33:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Shiji Yang <yangshiji66@outlook.com>, Soeren Moch <smoch@web.de>
Subject: [PATCH 14/14] x86: Drop message about features being missing with
 64-bit
Date: Sun,  3 Dec 2023 17:31:38 -0700
Message-ID: <20231203173130.14.Ia810a48e8e8cf895dea87336ae124701e9c72167@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204003144.899097-1-sjg@chromium.org>
References: <20231204003144.899097-1-sjg@chromium.org>
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

At this point most things work, including booting a distro, so drop
this message.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/spl.c               | 2 +-
 doc/board/emulation/qemu-x86.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index c15f11f8cdf4..4e4cf18dec5c 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -283,7 +283,7 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 {
 	int ret;
 
-	printf("Jumping to 64-bit U-Boot: Note many features are missing\n");
+	printf("Jumping to 64-bit U-Boot\n");
 	ret = cpu_jump_to_64bit_uboot(spl_image->entry_point);
 	debug("ret=%d\n", ret);
 	hang();
diff --git a/doc/board/emulation/qemu-x86.rst b/doc/board/emulation/qemu-x86.rst
index c604e42990ed..4eeba46ba7a9 100644
--- a/doc/board/emulation/qemu-x86.rst
+++ b/doc/board/emulation/qemu-x86.rst
@@ -134,7 +134,7 @@ The output will be something like this::
 
    U-Boot SPL 2023.07 (Jul 23 2023 - 08:00:12 -0600)
    Trying to boot from SPI
-   Jumping to 64-bit U-Boot: Note many features are missing
+   Jumping to 64-bit U-Boot
 
 
    U-Boot 2023.07 (Jul 23 2023 - 08:00:12 -0600)
-- 
2.43.0.rc2.451.g8631bc7472-goog

