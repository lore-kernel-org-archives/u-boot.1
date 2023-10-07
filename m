Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5A1E95A66
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 656D686F5C;
	Sun,  8 Oct 2023 01:16:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OByvGNB8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FDB786E22; Sun,  8 Oct 2023 01:14:10 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBB286EF4
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79f82b26abfso123204339f.1
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720392; x=1697325192; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9LGfti9giPvQ69i9t/jK2VoI5oFkbu/Xz9EslvhPFOM=;
 b=OByvGNB8g+iZt+gaYbf64e/haowk7iSpBhd4dd444UUhii6SXgXNJhLm7pTHdK4n+m
 d7TkmMqr7UuzWXDvCOPWRMJY07EO2VCka1ar0u/A1cxGBryUDkRxHVIwNtfipOO4pyEg
 zzYYbymx6xjz64UmuTp5y5nga1xV31rf5LBQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720392; x=1697325192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9LGfti9giPvQ69i9t/jK2VoI5oFkbu/Xz9EslvhPFOM=;
 b=YSq+AWFO7wbRXvT4PiXGvPFjYI0rfMbRiduEcLKFGUE6pI2iqleRo47VlXfMCcsLre
 owlrfIPjmp83Kk2tu+Yq47V/+IO/x0182Kw464dpMcW1TPQpXzKQWAUZxwohsTOP7t4/
 A7lYgGK1zwKj4x5ZUpxB4ZSLvwDqloFqpO42YBBUFvtI7g97Ju9UEe24rFJIjvrcjfTm
 vTvIfyq2AqynOg1EykRAD8VrUGjINSwjDZfE8vk+ULqdCr3nCOytXz5//cYVyLyL+Bzf
 CJX82DK3H1A72bKA6o+V5RiyzAMpkCri748bMShZWBrnjos1u3FqNQwaYJPQ3DhfIs/B
 6Fqg==
X-Gm-Message-State: AOJu0YyXldr4kmvG7q8c9eKdapLl+MCi8OchJGYqasaFhsP3DBV2cd7m
 +Wg2msl4/x8tKCmEOMU0pRt9pGz5pHW+IsG+fso=
X-Google-Smtp-Source: AGHT+IHXknOnMFJmEeaQx2xT1pDqdT8J3eYLvXAtPE79O2g9CkLmEiCTaDMll1+3L/6IgvAw/C0W3Q==
X-Received: by 2002:a05:6e02:930:b0:351:2288:e132 with SMTP id
 o16-20020a056e02093000b003512288e132mr11128448ilt.21.1696720392152; 
 Sat, 07 Oct 2023 16:13:12 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 10/27] cli: Always build cli_getch
Date: Sat,  7 Oct 2023 17:12:29 -0600
Message-ID: <20231007231255.277623-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

This module is used for user input with menus, not just with the command
line. Compile it always, so it is available even when CMDLINE is disabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/Makefile b/common/Makefile
index cdeadf72026c..b21916f15340 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -8,6 +8,7 @@ ifndef CONFIG_SPL_BUILD
 obj-y += init/
 obj-y += main.o
 obj-y += exports.o
+obj-y += cli_getch.o
 obj-$(CONFIG_HUSH_PARSER) += cli_hush.o
 obj-$(CONFIG_AUTOBOOT) += autoboot.o
 
@@ -37,7 +38,7 @@ obj-$(CONFIG_SPLASH_SOURCE) += splash_source.o
 obj-$(CONFIG_MENU) += menu.o
 obj-$(CONFIG_UPDATE_COMMON) += update.o
 obj-$(CONFIG_USB_KEYBOARD) += usb_kbd.o
-obj-$(CONFIG_CMDLINE) += cli_getch.o cli_readline.o cli_simple.o
+obj-$(CONFIG_CMDLINE) += cli_readline.o cli_simple.o
 
 endif # !CONFIG_SPL_BUILD
 
-- 
2.42.0.609.gbb76f46606-goog

