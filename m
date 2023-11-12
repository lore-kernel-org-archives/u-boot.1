Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF7AC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 15:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9095B87654;
	Sun, 12 Nov 2023 16:28:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MIi36tE1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 272C286E24; Sun, 12 Nov 2023 16:28:06 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB1E787136
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:28:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7a66aa8ebb7so151431139f.3
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 07:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699802882; x=1700407682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfbJRhEk6IbzobZjckV//lTNo98AUu5vKu0B4gPjAI4=;
 b=MIi36tE19Rb7MMiQkUCJkQN4GLLOpmiTp7rbW2r4NzZeVAQkrr9u+X912eBQjxKxGQ
 aAzQuecot0W016P5bKB+lpWV8BKmHl6mdOtiFbQlIIWti3q+v51I9zp1RXkLj+hH30S4
 LCy+38AiLI3VYuEJbzobyTg09dsWZL2PLpGF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699802882; x=1700407682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rfbJRhEk6IbzobZjckV//lTNo98AUu5vKu0B4gPjAI4=;
 b=RRw7tX5oYfXgkyfJBxx2e6Gsb6jF4PXFjdEeBswX7KxGtqOXxXDXXvUYC+QI6vkr2G
 M8OJy22qJ+GvsENye6caOqMyZ7Yl3lzV39nWj0fDuI14D3BrQpuE25gmg120jF5dQ+hf
 MiuKCHsklEPkSN6KfloK0CAd96IvqXvTrFNSCLCr657Ig9CNswJnqEpgxJr2wInftAX5
 F//mUTHq3fflvxm/RldKpIJKtWS6/AGAYhPO+M/E93NNPMtu2OK9oAe8T+8JAD7G7U8j
 9YOtNQ97UebDtQv4qnsgaRU6FFXVSMErT3/bfLFYfHo0/eBx0KxDviuIvWUr8Qs3BrJm
 Skpg==
X-Gm-Message-State: AOJu0Yzucxz/kbh0HHg5oQpbV8RoRKmNY6FGCUqK77lNDPqrM9cFOj2o
 TLgj0urGBvHVm+5jW9NmrJn+XyK2pnRLk1P79TJLUQ==
X-Google-Smtp-Source: AGHT+IGn81gn5AjhpVRuvyzVk89uMXfhJboFAxGCimArDn9xSqoUp0Tz1uk4P8YWvpWYo9CDxhvhuw==
X-Received: by 2002:a05:6602:107:b0:7a9:96aa:e01b with SMTP id
 s7-20020a056602010700b007a996aae01bmr4806907iot.20.1699802882545; 
 Sun, 12 Nov 2023 07:28:02 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 76-20020a6b144f000000b0079fdbe2be51sm1226241iou.2.2023.11.12.07.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 07:28:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Edmond <seanedmond@microsoft.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 5/7] boot: Move adding initrd earlier in image_setup_libfdt()
Date: Sun, 12 Nov 2023 08:27:48 -0700
Message-ID: <20231112152754.130399-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112152754.130399-1-sjg@chromium.org>
References: <20231112152754.130399-1-sjg@chromium.org>
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

This may as well happen before the general event is emitted, so move it.
This will allow us to use the livetree for the event part, but the
flattree for the earlier part.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fdt.c      |  5 ++++-
 include/fdt_support.h | 12 +++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 408369d489ca..ac7dc055cc9c 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -664,6 +664,10 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob,
 			goto err;
 		}
 	}
+
+	if (fdt_initrd(blob, *initrd_start, *initrd_end))
+		goto err;
+
 	if (!of_live_active() && CONFIG_IS_ENABLED(EVENT)) {
 		struct event_ft_fixup fixup;
 
@@ -693,7 +697,6 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob,
 	if (lmb)
 		lmb_reserve(lmb, (ulong)blob, of_size);
 
-	fdt_initrd(blob, *initrd_start, *initrd_end);
 	if (!ft_verify_fdt(blob))
 		goto err;
 
diff --git a/include/fdt_support.h b/include/fdt_support.h
index 791258ec7eff..bc249b045302 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -57,7 +57,17 @@ int fdt_chosen(void *fdt);
 /**
  * Add initrd information to the FDT before booting the OS.
  *
- * @param fdt		FDT address in memory
+ * Adds linux,initrd-start and linux,initrd-end properties to the /chosen node,
+ * creating it if necessary.
+ *
+ * A memory reservation for the ramdisk is added to the FDT, or an existing one
+ * (with matching @initrd_start) updated.
+ *
+ * If @initrd_start == @initrd_end this function does nothing and returns 0.
+ *
+ * @fdt: Pointer to FDT in memory
+ * @initrd_start: Start of ramdisk
+ * @initrd_end: End of ramdisk
  * Return: 0 if ok, or -FDT_ERR_... on error
  */
 int fdt_initrd(void *fdt, ulong initrd_start, ulong initrd_end);
-- 
2.42.0.869.gea05f2083d-goog

