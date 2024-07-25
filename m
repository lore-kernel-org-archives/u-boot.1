Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB86C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 17:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 101C388100;
	Thu, 25 Jul 2024 19:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="DOm771aJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76F7288361; Thu, 25 Jul 2024 17:32:29 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DB8B87F19
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 17:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3687fb526b9so583572f8f.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721921545; x=1722526345;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4H4x0sd+lSnEtwFCDx1D8Kr87RPs7u7vfc2N38v238=;
 b=DOm771aJELEGSCf0DGx92GIzrdabcjXCZKUcNlVnZnlHXjpaYIe7u0yQqhkJ8end56
 15FgAJFP4xmKBXc1w4FdiiDExyYXlAzWbtXMSrW9KeerrdNaNQTSKY3orJcTapDxtR3e
 fjr9q5uDHQUDHqJHDpJHf8EZV4SGB2FOnxLpEHVd8Ek6iV9u2KS1hXAkrgLHLeDTMnVa
 B0ZzgWkw7OE4lWr1pxmy4MrsmycicIwRlSCodJRgGj7ymQLV5LMo1a5/YvKUd+puV6Op
 Wnmq6s71QVXRcMziwOGJ1Q/8CUFtuyrn+7iGcBzlWF2hU8O6wBsHP9nAE6CLQR8JpzsF
 4inA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721921545; x=1722526345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4H4x0sd+lSnEtwFCDx1D8Kr87RPs7u7vfc2N38v238=;
 b=wAvsxGdQ201BmOAeAMqDNWyn1L14FK4RHrSRsOixnUFBiEvq4LgOZHVOK6p8HlOPz+
 iF7tLyH6D+6QIHjt8ChXEr3fG8g9C8VRed9wWF1SjVywDw168WAC1FyDOFGVJ1XzfF1m
 KcR61zOmd/EKGx6MP6i02/cTqOnQlQQSDBghiGw5K3pnYZz6ELrICbwGQp0cHpfEsf1m
 YmFCXIt27K+vRDo4eSdhy6JZtFyQGaCu4KHNxRLgQF/+lUMEFnbgdc47XYrFUPzyAJR8
 Jzft9TiXZujaAOVS/o/37CqUSnUzdVB7Pq+gG02qVqdDMWvSOy7BqR6zpcEQb58YeeGV
 0URw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+57DT+4ey6TL1LifkS9yPzy19vUubFijFJ/9sA0nCyTe45cDe96G3L+rd3y2w0nOoq8j1PrKYY68Tz432PaPfXcxmsw==
X-Gm-Message-State: AOJu0YxLCOjNuFR1ljoOkWO/irDqebEZ8IdL97FYJc6ZMCLUiPKdHEYb
 wiNvVSDQ057BKiVuNhf2U8U2OWL/FlmOtqtMaOYdVS6yIfFQRBlG+xOjaZ8LuAY=
X-Google-Smtp-Source: AGHT+IHIfrNXDXqbt5kN1Ql+UsW++lac6n5ZMa/dOptkRtnkvWabT+ohGUggUsGQ5QyFQlfk3PZGEA==
X-Received: by 2002:a05:6000:128e:b0:367:9329:246b with SMTP id
 ffacd0b85a97d-36b363920e0mr1601137f8f.25.1721921545420; 
 Thu, 25 Jul 2024 08:32:25 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b54sm2530805f8f.95.2024.07.25.08.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 08:32:25 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH v4 1/7] usb: gadget: atmel: Sort includes
Date: Thu, 25 Jul 2024 17:31:55 +0200
Message-ID: <20240725153204.358925-2-admin@hifiphile.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725153204.358925-1-admin@hifiphile.com>
References: <20240725153204.358925-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jul 2024 19:14:03 +0200
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

Sort includes in alphabetical order.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/usb/gadget/atmel_usba_udc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index f99553df8d..5f78251fdb 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -7,16 +7,16 @@
  *			   Bo Shen <voice.shen@atmel.com>
  */
 
-#include <linux/bitops.h>
-#include <linux/errno.h>
+#include <malloc.h>
 #include <asm/gpio.h>
 #include <asm/hardware.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
 #include <linux/list.h>
 #include <linux/printk.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/atmel_usba_udc.h>
-#include <malloc.h>
 
 #include "atmel_usba_udc.h"
 
-- 
2.45.2

