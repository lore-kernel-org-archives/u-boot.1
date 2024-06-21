Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E81C2BB85
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 19:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D228885C5;
	Fri, 21 Jun 2024 21:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NDpYvdy3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FB3F87D10; Fri, 21 Jun 2024 21:52:24 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E05048856B
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 21:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7e8dcad116fso96947939f.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718999540; x=1719604340; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/BrGCttK0D/bhbJe5rvYXokoCvR8XBVm1DG5Ii3qYzE=;
 b=NDpYvdy3N5nHDnRDIPaePjmUU3MbNY4RkpcOUkyJ3C4lyo6x06w3AHvXJ6tINMSdkj
 hczV/LoPxOQAA+L4QzNTMdrFbtK7gZl14sj3xSwQGzq3knJRhPTwtRfqNf2Kz4D+ExLf
 n5HkFDTu7b1ujhRVSV1NQg6QHteEMHMhJ5fF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718999540; x=1719604340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/BrGCttK0D/bhbJe5rvYXokoCvR8XBVm1DG5Ii3qYzE=;
 b=ezp/2dWTJrcCXDzrIpqoJU/rTo75aC/4HmUbcG3WJ5V8GTyFRvPVZqH83GLcY0+7Q9
 MqpXOxmrLiUuLIg1hIiWoYHQPCil/x/jLo7Tsgo7xpnQCj95h9lRlTvJYSwDlKCuhrUI
 9U3Cl9rF7WGAGI4CqnvyiqhnsTQVyB/dmjgluGyiEyGJXluWPlye0FFqRVXjqPQpe77A
 hJ2HK4rU+aNy8RISCYIBXuprsSx1w11RjSZ4pVB9np5gOMX3L8iEUbMdMe4T+1Jt4JRQ
 arWGq/qL1MatsKcF7qVSXc8qDmvkkkpMOZCgHswqRxO8dU7QSkfxjYnaCJJ5jj1BxmTt
 19/w==
X-Gm-Message-State: AOJu0YwgTftVDkf+5FnqDaxPOnTP7sS6QULhmKR161DPRIlToakejMNE
 BP4daknmVo3+QWcMWknRbTVkFbWjdDD5Lkx9z6BQq2gD1Wa2grqH1N/5J6Kc/I6pd3UJkAFf7Tr
 x6g==
X-Google-Smtp-Source: AGHT+IEhPgU+WXEHmT910OGa9kADEuCYnqpn4fXpkBPG6DqQPd1V0yWd1XegKi6IhN4w309/H1+EPA==
X-Received: by 2002:a05:6602:3424:b0:7eb:842a:7191 with SMTP id
 ca18e2360f4ac-7f39abb6ba1mr56112939f.3.1718999540598; 
 Fri, 21 Jun 2024 12:52:20 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f39203deb7sm48801139f.47.2024.06.21.12.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 12:52:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 13/43] dm: core: Enhance comments on bind_drivers_pass()
Date: Fri, 21 Jun 2024 13:51:34 -0600
Message-Id: <20240621195204.2675252-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621195204.2675252-1-sjg@chromium.org>
References: <20240621195204.2675252-1-sjg@chromium.org>
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

