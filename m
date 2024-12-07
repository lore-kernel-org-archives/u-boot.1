Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1561AE7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0F60893C4;
	Sat,  7 Dec 2024 18:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VDRmHTjA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7902F893C4; Sat,  7 Dec 2024 18:26:13 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D7C888FB4
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-843d7f16827so115336439f.0
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592369; x=1734197169; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1XAaNvSedXtzjDytN9G4hPZ8eHtnhbLbBuiU//Exkk=;
 b=VDRmHTjAGn93C25DAst1zb1Yoo+4ooFFBRTKZDtI5uy7mgSJ+g64AbFkg33Wh5uG8A
 f2RMMX3RGli6WRgVAgLVCvGPbaw2hcU/FdAq/XuhE1JCCmD8of089W5MyYlAUYi+rDdO
 G0dtxEzrxyl/9mMZE9cnAu2zfTtNhGVoklpqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592369; x=1734197169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1XAaNvSedXtzjDytN9G4hPZ8eHtnhbLbBuiU//Exkk=;
 b=UFKPOo9lkbPtrDrzgKzpu35SNYJe2SI/8VxIWYKB0/rC1n7XMNQvryV0NwSl3bcU/s
 6uGwqHChNSf+8pjLOPwaCsVkv2uSZPF/huczXyY4s+NH+WyvTYghi8yTFgCIQ+ICNAFl
 P2BV13wYDiVqiVpiy9rick4pYMG1P0BgFxJAmU5eV1R1YOIHSaW7ROC3MdiqUvyXkX6M
 f9BbHn2yUqwgc9IpfyWWfdED9Xgj0jaSmtjFIVkFL+enfdYMRG7Vz+8YvnGVoUolyplJ
 hANqG12+5ly6+Yl5RbG40EQB0pFGdX8Hz3pMn7zz1mMQUqPoY3t0znrmpQAM9glcd2cv
 qesQ==
X-Gm-Message-State: AOJu0Yz07tHCrN0ivPGmuzXDkI5vRUUH165kNZoUtQCzQthiOzv92j7W
 Q7t+NTS8GrYeeE5gJZ7zf6j21pL1PsNTx4VrRE+sKK9OhvOEyjc+2YnHzSJTMnk3giEbBTlUsGI
 =
X-Gm-Gg: ASbGncuZaR9A+LIEIB2dLbp8n2hTz6cAMIMitWov7Epyq3rESKbiwx9ihvJe2FQcVYN
 p+saacqUWOhOwmE9gt4yvc60mAJTzI1NEoHxJhsvMWb9k6TdA62i/m+iNHILinciJcwEggrIwEz
 ERfDsGBEMKILnAduoSHu8sarzL6NX0wzLCIrbm0cUYd7Fnlaf641SL/llV6VMJKPnXS2XLjIbhl
 q/x6erc/uNny1JKAs/V4Ejn7QByXjEAXsocwQBxsoBLxJwGg6ijFpN4D8Q/9IN8s+X8yCeVU/wW
 AvALYvDXvNs=
X-Google-Smtp-Source: AGHT+IEp4aXbzr58ot18Zexek38fTAZsbKy0ZEB7SREG631pfzUMSOmIkaQfS6hLq1dYk47wnAjZBg==
X-Received: by 2002:a05:6602:2b01:b0:832:480d:6fe1 with SMTP id
 ca18e2360f4ac-8447e0ea343mr971409839f.0.1733592368949; 
 Sat, 07 Dec 2024 09:26:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 04/19] bootstd: Avoid sprintf() in SPL when creating
 bootdevs
Date: Sat,  7 Dec 2024 10:23:57 -0700
Message-Id: <20241207172412.1124558-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
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

Changes in v3:
- Use strlcpy() instead of strncpy()

 boot/bootdev-uclass.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 65a3b89e40c..c39147940b6 100644
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
@@ -261,8 +262,13 @@ int bootdev_setup_for_sibling_blk(struct udevice *blk, const char *drv_name)
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

