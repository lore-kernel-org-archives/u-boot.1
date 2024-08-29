Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7802AC83F2E
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F55B88C69;
	Thu, 29 Aug 2024 16:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q4AE2vGu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B42E488C69; Thu, 29 Aug 2024 16:58:22 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A34AB88C3E
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-82a1abff760so31381439f.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724943499; x=1725548299; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CAyQ5q/rb1NxsQWSkhs8fvm4cK+DeCRQaU1y8WJrLss=;
 b=Q4AE2vGufua1E+10VC7GoY7NSiAx0MSxg5C6YOYmtChi1g2UlZDZmuU9G/GP+TwjSz
 MeEWodp5kUt8uHBGn/YaMIHIRYnJ9CwoHcnk7ThTUfyHH7BpOoDKhUUeub0GsHsx1elP
 /PPUC31Omy8Ip4KdtRLPw6XoxW2ephSVzWMko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943499; x=1725548299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAyQ5q/rb1NxsQWSkhs8fvm4cK+DeCRQaU1y8WJrLss=;
 b=K5Bk/oiYK3Al7coAbAZQEgNtvATd4XFOXPdqqK1LpQGwti6V6jBhzB1gbQEPYpM531
 wL6se3UpQR0qb4yhUuOMfwOoFa7dDr5PvSYPvjlK9vc7H1VXF8Qbo8X1M/e1/FNhZmEI
 miA5m4aw3TZrv59Qir9VqRKkGDVkCKWo5X2MwrKLFNvHP6Z0Aw/XI3z5/Iff611Pohjd
 rIrZeLGEf7quGp9ZMtlSCrK6PpvXuW0V93ZEPg6eunNhgHbaCF6JDUVjiZx9WdX/XcLt
 /CPtzq2UIfi//AU6uD2xk4mbv8Ot0Xf/d9GinevWX8MwFOzxqH1Uo28FnAs0XP6GkXvw
 fFDA==
X-Gm-Message-State: AOJu0Yyqxa6trKnRkapPPhB8JDJXwvUy8kDWaAf4fEyfy5cvYsKX/OjE
 gDjoR4Lh5PURdraN0sqBb+x0/zWk+VzYzq78cQm5IWLDQS8bwX+oepgYhY2HLRiXO6Q8F7Ka7uQ
 =
X-Google-Smtp-Source: AGHT+IFmeTSeq9ewjrvDzUru+YlQSg72Vg/bIhvk7xa0xBOFLSd/X1N+fszr0ZV4pk9grOWAN8vPnQ==
X-Received: by 2002:a05:6602:29cf:b0:803:f97f:59d8 with SMTP id
 ca18e2360f4ac-82a10d7d132mr398362539f.0.1724943499297; 
 Thu, 29 Aug 2024 07:58:19 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2dcdd2bsm284900173.21.2024.08.29.07.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:58:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH 04/19] bootstd: Avoid sprintf() in SPL when creating bootdevs
Date: Thu, 29 Aug 2024 08:57:47 -0600
Message-Id: <20240829145802.1827952-5-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829145802.1827952-1-sjg@chromium.org>
References: <20240829145802.1827952-1-sjg@chromium.org>
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

 boot/bootdev-uclass.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/boot/bootdev-uclass.c b/boot/bootdev-uclass.c
index 7c7bba088c9..6a0d8466e95 100644
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
+	if (spl_phase() < PHASE_BOARD_R) {
+		strlcpy(dev_name, blk->name, sizeof(dev_name) - 4);
+		strcat(dev_name, ".sib");
+	} else {
+		snprintf(dev_name, sizeof(dev_name), "%.*s.%s", len, blk->name,
+			 "bootdev");
+	}
 
 	parent = dev_get_parent(blk);
 	ret = device_find_child_by_name(parent, dev_name, &dev);
-- 
2.34.1

