Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48037C27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99E4888777;
	Tue, 11 Jun 2024 22:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FG8OJ6/Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C139888732; Tue, 11 Jun 2024 22:02:28 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB9E488777
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-37594abcee7so14699975ab.0
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136144; x=1718740944; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1tnGCPRa6aDvFaFRV/tH0I/XqpicUUh3iuN+3XL99U4=;
 b=FG8OJ6/Z/Tq34XuPQlltjt1s07zQeOlmbVuxUiQQPD+fdbnc+ae919wo0zZwf3cRJv
 SEzTmbLNb9CUq+itsycOLjN335xSw67Uzl3BYHQ9y1RzPXkohlJFFOmN3NggRnF3J+Qv
 td9TnMGqLRhIx0cCxYvieaWUunAugjOCl2TUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136144; x=1718740944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1tnGCPRa6aDvFaFRV/tH0I/XqpicUUh3iuN+3XL99U4=;
 b=EkYbukMGm0533ke/zGQapVeo/YMdAqihl8dA+NSYjpRwSthbzR7Tcv+qiI6IFORXiQ
 XNzOjj6Hf/2ro/26E554FW5ayOTzhqeKyJd8nc7IYEr0/GyV1XyqSK9KMGdYJ8rqSFAg
 3lsiizwR+wCRSbaprtaV57WVVZP5BAEErQ0ScUbVFCFoYHlFdAeVDgoAB7JJs8OQw75D
 A30RXnUFwXXQzzMbszJvJ38c/WWo3pEbI7xMiEDDXKm0vIIzXIT5quTH9oduVMsbzo2f
 WT3UecPD6om4T1aPk0P33i4AUniUSnrhCkltdN3hz1QOIenmPrl3uNIk05RBaF7OGiv/
 i1dg==
X-Gm-Message-State: AOJu0Yy/A+uy1wUzJTK+KwtctmIkmgYDnUSvc5nOrvfKAwSKhRrLO8nM
 DJHiLEkRww2pC9FVh+Iy2SSlZSqyIg484UhZeRn2fv48unOPFejmqByiQ91Vqrz3sCgCiLsEOSj
 Mdg==
X-Google-Smtp-Source: AGHT+IHyWdQYphBvIjcnmUUmsA0tOwXGmKqcTAP88VIZtJQCYyv1tEPGdflaKlYXF7QYAl8BSVJsfw==
X-Received: by 2002:a05:6e02:1c24:b0:374:9916:70 with SMTP id
 e9e14a558f8ab-37580333543mr145402425ab.11.1718136144460; 
 Tue, 11 Jun 2024 13:02:24 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH 13/42] dm: core: Enhance comments on bind_drivers_pass()
Date: Tue, 11 Jun 2024 14:01:27 -0600
Message-Id: <20240611200156.2245525-14-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

