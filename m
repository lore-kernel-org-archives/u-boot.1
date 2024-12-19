Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118C6E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:29:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAFF88033A;
	Thu, 19 Dec 2024 19:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ePsXRo4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69AB180379; Thu, 19 Dec 2024 19:29:27 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39236802EF
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-844bff5ba1dso80524839f.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632963; x=1735237763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWiyTUE+wOvEyhylJTMfiZbAzCgSmiNWdGx3PdaWb5s=;
 b=ePsXRo4B/okewwdEYpbjuA0aui9Zcs0dBhmYfGfogxvHCdQykk9xzI/U/3tmduYlFR
 xMw5iu0J8uxxrgKwawekbPhPRMa75FGUw0q3RjEUXf0AQPhri2qZoAWfyGPxopahgCRO
 UfAb5iNxFnmB5MqLyh9PXOgoFZ+b2DUNtwxKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632963; x=1735237763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWiyTUE+wOvEyhylJTMfiZbAzCgSmiNWdGx3PdaWb5s=;
 b=CW4xkns6ZIfu4RZFq0lG0B7AGaSuEhEGpwCQyatJV/q3tNcRWwHSEFChtmGHQqD4UZ
 n76y+34nsQH10od6EhhxGuwNSyX1ONJCZB9fP0aOMU7hX+Lt8DrTnE5YKEpndT//AZpy
 Jz4WZ9ov/vH0oAtKfw9iZxt2hpkpwDHK6nY1JFrzi2MQfxMHaWsVAXCzhT20vJMV8RCr
 OAvJRLI+BolZxsl2mFzY8WGfsqVwKQDTyMRmrESPJ/+mRZJSzjJMnmmVVjuArqt4s+ni
 moydzdmv+ruD3TNdJVCBhsJIIWwtaR9XIC2JKwIj8pS4SEUPMMLTt974h6BZKUR0oOKx
 muWg==
X-Gm-Message-State: AOJu0YwZVZEXHfBnM3loHEA6HmUaLKfVbmhe+gMQsCQccVy+ViNlY2Us
 +6Q1mz00w0IUFz1r0mkAr9R7u3L3/r9aaqkxV9h60NPRESq8Esj+p85GjXYOnOwjknmMFLMEsIY
 =
X-Gm-Gg: ASbGncv6yQS2kcEgmwsh8wuU5Y9v1l+g/LirCYKsoLDLtPoR8Ovvaxb/R/mrz7fJyiW
 p5FBCCSJa2uY/h0PZFcK9PzGXgxpJK57NaP2xe2Agy3UEEObABM/aplLA/6QKyZm53Eq+O8+0HI
 k6unb5QtCFeW+AMp/L2XP0M/CDTBE5vqvRJP896nXcaGKXoAROCAWwBVgasQLXcLqOMJshAFO40
 ond+fp4TuCfQ5wD2xDOmWV/twziby5TUFpdbUJlDZWxB8M18cBtgOPCZtgPtU6SapVAAhylsSkb
 CmS1KPOcp5IXsgT/tg==
X-Google-Smtp-Source: AGHT+IFpL3Va4RRJXB7vm1ZIGjnKM3ooBfzSEglyi1zXBI2Zvct6k6XdGfGJ45PqVu5MEryZ7igDcg==
X-Received: by 2002:a05:6e02:1fcb:b0:3a7:4e3e:d03a with SMTP id
 e9e14a558f8ab-3c2d5b3786dmr692055ab.22.1734632963413; 
 Thu, 19 Dec 2024 10:29:23 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 04/19] bootstd: Avoid sprintf() in SPL when creating
 bootdevs
Date: Thu, 19 Dec 2024 11:28:52 -0700
Message-Id: <20241219182907.2609704-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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

The name of the bootdev device is not that important, particular in SPL.
Save a little code space by using a simpler name.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Use strlcpy() instead of strncpy()

 boot/bootdev-uclass.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 64ec4fde493..2e61c853142 100644
--- a/boot/bootdev-uclass.c
+++ b/boot/bootdev-uclass.c
@@ -16,6 +16,7 @@
 #include <malloc.h>
 #include <part.h>
 #include <sort.h>
+#include <spl.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <dm/uclass-internal.h>
@@ -278,8 +279,13 @@ int bootdev_setup_for_sibling_blk(struct udevice *blk, const char *drv_name)
 	int ret, len;
 
 	len = bootdev_get_suffix_start(blk, ".blk");
-	snprintf(dev_name, sizeof(dev_name), "%.*s.%s", len, blk->name,
-		 "bootdev");
+	if (xpl_phase() < PHASE_BOARD_R) {
+		strlcpy(dev_name, blk->name, sizeof(dev_name) - 5);
+		strcat(dev_name, ".sib");
+	} else {
+		snprintf(dev_name, sizeof(dev_name), "%.*s.%s", len, blk->name,
+			 "bootdev");
+	}
 
 	parent = dev_get_parent(blk);
 	ret = device_find_child_by_name(parent, dev_name, &dev);
-- 
2.34.1

