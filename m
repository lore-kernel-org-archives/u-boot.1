Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51079C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 20:31:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B74318845A;
	Sun, 23 Jun 2024 22:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fr1gBYep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17DE387D07; Sun, 23 Jun 2024 22:30:42 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02D7F87572
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 22:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-7ebe508fa34so209019839f.2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 13:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719174638; x=1719779438; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/BrGCttK0D/bhbJe5rvYXokoCvR8XBVm1DG5Ii3qYzE=;
 b=fr1gBYepPz8xFv5C46QlCZw5PTmhfTHsqGOE9en+yyUcXZL+X3Yl/iAmDQGJ2XLxx3
 Oi6YnjdbcN7u0ASRfjZvElCr+kmV+o17XDa5FOJeOUMrnM7vweDXVzn7AOUaVMg5kfyM
 eNfMpvPU+6i1QTumkGpq/F9Qwya2GJY4Wpeb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719174638; x=1719779438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/BrGCttK0D/bhbJe5rvYXokoCvR8XBVm1DG5Ii3qYzE=;
 b=iOG5qiicSCaIOaQ511ZhPMPKwnxy/gLJUn9n547MC2xHdeyVYadg2KYUA6JK7wQSxF
 UTaET1bxFDb+/De7MURAVI9OnjIbjJnY1Xn6OsMTQHmjD7AUM1jC8yryo6rvJrg99smu
 avriWrMxDVvB+mEba2og1LBTmyyevK03xbEYZmrsJIUnxm0z3Amg9P1o9xVsdmOVM7d5
 tduSf27HhwAJueXDqja2qjFtabqTYetJoLvI4H6IM0NJ4bapdL3gS2QEA3+Ry67eKwug
 Zau+EBfHG3IgeTsFabgLZ2pKCKmh+VWVlkOtRhWhD2IuP0etwQjsMPbZelGmzZ40N0rZ
 fhqw==
X-Gm-Message-State: AOJu0Yyp4DYyivo92IftLskt5ehTpfZeu+kuTfjWdzJFW7dswxSrqIEl
 n95HsovAbv2mgv9y0tM5t38VFGFYtArGo70GcmRtbm6OGFz5AghYb3uM3KWq6WDIc9B+NZQpqdb
 Vtw==
X-Google-Smtp-Source: AGHT+IHHeVfAlNGIbJ54k+eeoXk8Q2yT1QloSLT7wGyDKs/YwvpHxR94vH6SXRGoTrWEsu0sCmsP2Q==
X-Received: by 2002:a05:6602:150d:b0:7f1:3e1a:db4c with SMTP id
 ca18e2360f4ac-7f3a78044e1mr440442339f.16.1719174638693; 
 Sun, 23 Jun 2024 13:30:38 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110ffb6sm1627335173.58.2024.06.23.13.30.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 13:30:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH 02/14] dm: core: Enhance comments on bind_drivers_pass()
Date: Sun, 23 Jun 2024 14:30:21 -0600
Message-Id: <20240623203033.1566505-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623203033.1566505-1-sjg@chromium.org>
References: <20240623203033.1566505-1-sjg@chromium.org>
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

This part of driver model is a little subtle, so add some more comments
to promote better understanding.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/core/lists.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/core/lists.c b/drivers/core/lists.c
index 2839a9b7371..a84e6a98cb1 100644
--- a/drivers/core/lists.c
+++ b/drivers/core/lists.c
@@ -8,6 +8,7 @@
 
 #define LOG_CATEGORY LOGC_DM
 
+#include <debug_uart.h>
 #include <errno.h>
 #include <log.h>
 #include <dm/device.h>
@@ -50,6 +51,21 @@ struct uclass_driver *lists_uclass_lookup(enum uclass_id id)
 	return NULL;
 }
 
+/**
+ * bind_drivers_pass() - Perform a pass of driver binding
+ *
+ * Work through the driver_info records binding a driver for each one. If the
+ * binding fails, continue binding others, but return the error.
+ *
+ * For OF_PLATDATA we must bind parent devices before their children. So only
+ * children of bound parents are bound on each call to this function. When a
+ * child is left unbound, -EAGAIN is returned, indicating that this function
+ * should be called again
+ *
+ * @parent: Parent device to use when binding each child device
+ * Return: 0 if OK, -EAGAIN if unbound children exist, -ENOENT if there is no
+ * driver for one of the devices, other -ve on other error
+ */
 static int bind_drivers_pass(struct udevice *parent, bool pre_reloc_only)
 {
 	struct driver_info *info =
-- 
2.34.1

