Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF98C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 04:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BDEA87BB0;
	Fri, 15 Dec 2023 05:19:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QIqwI2Xt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 024C087B0D; Fri, 15 Dec 2023 05:19:46 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5C0E87AD1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 05:19:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3b9de2332e3so249507b6e.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 20:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702613981; x=1703218781; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ITXlQCMXex9y9kfVhTeJuk5fMOj95vC6GLUfbZdXszM=;
 b=QIqwI2Xtyj4sO7x84DDseJLCi8qAWaK63qqfXGjqSx5aph/9Whfcpfc2DbGqA/J2Be
 PH9zpWa/3rj6RktGyYtkmSiXRJSbra9bEzArSfXZUSo78PiHG/qjj+/I+ite+Eqdbfu2
 eyZ+zAi6fIAVpCy23nGKc+5HSyyPy4IGJSlww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702613981; x=1703218781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ITXlQCMXex9y9kfVhTeJuk5fMOj95vC6GLUfbZdXszM=;
 b=luejZn8V8XY4vM9GtxgQNGp7Q4YLXlAv3WjqTw27AWKL+FQnrMHGVPR2YMKWw3biuy
 lOt/4K2Bh8UU4tz2poCKKWRMxwPpGCTwMtADBT7uQKOwkTg4plEHhDYkvRgOgYoPAjCn
 EqKjxMIfWwpe2LKBCD5+koMVmR3Qz0eJLzCU6571jT+/WcYRMqbRyghXQQn+N68e5gSm
 qooL8cQrNGpimUEnPaejUvV3PCrjFg13/Xb8d5wiigCMNVXIq9xz0mDp0dS2VrT4QAYN
 pNx4lt2OQpTJ8YcLX06UFMynUpJs6lKDmQ21cdpCrkODXiawggCwCLhgSUTdOLImSKAG
 yuZw==
X-Gm-Message-State: AOJu0Yw0iZe9v9XsjO8ftDEz8AEetzBUTZQwXzy8X/I1lyxvkR5lIDlZ
 kjwu20+SZodOOpy1aFnIrzIdEmH2oSkGasxlK+F42Q==
X-Google-Smtp-Source: AGHT+IFJavzSjryBlSAT0Fxoe8oJj0JB3Kfk5GO7tV5ekC0gpxGtCF25ehcDFuYf2ZAMaLjQ5LCF+w==
X-Received: by 2002:a05:6808:1a1d:b0:3b9:e8d0:3b36 with SMTP id
 bk29-20020a0568081a1d00b003b9e8d03b36mr11502819oib.49.1702613981386; 
 Thu, 14 Dec 2023 20:19:41 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 be15-20020a056808218f00b003b898ffd8fcsm3601492oib.50.2023.12.14.20.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 20:19:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Shiji Yang <yangshiji66@outlook.com>, Soeren Moch <smoch@web.de>
Subject: [PATCH v2 16/16] x86: Drop message about features being missing with
 64-bit
Date: Thu, 14 Dec 2023 21:19:14 -0700
Message-ID: <20231214211906.v2.16.Ia810a48e8e8cf895dea87336ae124701e9c72167@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231215041919.2197788-1-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
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

(no changes since v1)

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
2.43.0.472.g3155946c3a-goog

