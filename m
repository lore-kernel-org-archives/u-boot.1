Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D62EC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:38:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 710C688829;
	Tue, 23 Jul 2024 15:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="YjwB1kI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADD338880E; Tue, 23 Jul 2024 15:18:51 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A02B887B4
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 15:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266fd39527so41416485e9.1
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721740727; x=1722345527;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9XdfcPQBS5xIn5Nxx9aC2kI/E1yX32bhmjOXKsH09s=;
 b=YjwB1kI36kVZOHchHK3L6sMjY4DOBrNwy+d/89ttqysRSxjFNwb3zkiSKRVvHVX4kW
 HdPiZymsXLWHL4zf5E2Xb1o+CJYbsAoZVa393ANXsxJsIKQTLJuZy5FHpqTRzB+0ook2
 Wu/xVvCdV/csArblvm3eUqB5mtLObqBUBh8nTqbvsjby/INNyS1EDzQgiuIdJ4OWmuOr
 v9tz9bjJh2yNNEf0PvcGcLuHVgbS1aqM98qFOLpZXNoWEyNPIxgPThCUDnB2PG0SSIbU
 LaWWy94XG0o0hbOXU2OGyAg501UnYfUM9SimVh3HMtbCnCjKDz+o76okm6oV+w2GMW/2
 KPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721740727; x=1722345527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9XdfcPQBS5xIn5Nxx9aC2kI/E1yX32bhmjOXKsH09s=;
 b=mIMSnn0nn5/TUCIQdhKNKEsO+hZFLEPKLuiRMlLU5+vGXuNK78PINsVrc0OIUn/A6R
 S3I+cpBd56XnGbuqspMsUL5V8Zhy6PyAuwg0aaw5NiP2Rko/34SoMWdh3l4onT1WSAQ4
 pEhQEy6KmQd3EiJzgSu8omE8P2daEWyvm51GYAOFZ04ick0GeBfzo1SEy1Cc/SU/J43i
 /p4ZNYrnEYlJ2MPxw05oT9J6lNhpWXIrFQsDtParKCNJenTthp8o0jaU+teG7ekC8sJ1
 LTv0f5n+dJnOqPHAgethPC1bEDh75Hdz5u5ltJkRZMTU5+vpuhLsFp1F/LjxMHZxYxM3
 XMwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBjSxn4KZ0hqv2eS5CM1ZvN2kCleW9BNcTH3dotETpilK9pTeFs/D5TyP7whZLgDz0fRpoqmxiUMDAz3Qd6dfecIjYDQ==
X-Gm-Message-State: AOJu0Yz32f6Oz+k4vCbRqvWXrSMeUlXHK0c86Njqf92S5CInWCLROGgn
 8cKDCVTdBGKdp+VACPIqoYnPp+WieThhDCYy++/ufM03+3SxfnU5d7MilRAYZD0=
X-Google-Smtp-Source: AGHT+IG/WSa/ZWQFSEcn6vpl176ScUXiqj9+j7UIqxct+AWGijYLrUQFl295C5p5VZDqEo3pDB2vXw==
X-Received: by 2002:a05:600c:1382:b0:425:5eec:d261 with SMTP id
 5b1f17b1804b1-427ed06844amr22925705e9.34.1721740727401; 
 Tue, 23 Jul 2024 06:18:47 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427db2a4e3bsm140312545e9.44.2024.07.23.06.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 06:18:47 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
X-Google-Original-From: Zixun LI <zli@ogga.fr>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>,
	u-boot@lists.denx.de
Subject: [PATCH v3 1/7] usb: gadget: atmel: Sort includes
Date: Tue, 23 Jul 2024 15:18:08 +0200
Message-ID: <20240723131817.262596-2-zli@ogga.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723131817.262596-1-zli@ogga.fr>
References: <20240723131817.262596-1-zli@ogga.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jul 2024 15:35:55 +0200
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

Signed-off-by: Zixun LI <zli@ogga.fr>
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

