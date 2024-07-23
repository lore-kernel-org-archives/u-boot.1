Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72457C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6ED48883D;
	Tue, 23 Jul 2024 15:36:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="Km0P6vYh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45AEC887DB; Tue, 23 Jul 2024 15:18:57 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A74887FF
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 15:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so47850575e9.1
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 06:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721740730; x=1722345530;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iYLHDPjDOFxn0HJGyorIeqJ/iWGilv+5T/P+L6gwcZI=;
 b=Km0P6vYhcUl29QpvcXtXJNuOCj5xEq55yR7sLSzw4aAGdVOJd4lGc29Z57/+31lVjr
 TKf8jsUoOK8Xrbw4nJar36zCoaE/hMJamzMgZfLslV9oQSKShdHoMoTc+RDj0Q/Wmi0e
 Kn9sCjddD6mMMoV33NQmrb9zvmkbe2i90cNT/Kmr3nuo8ZYABiHQF7q2TKatbmWVp195
 YrBqRHZ0ZVq62ZSDxVhcAWtba6uQApWnlj5DToDlRSkNkRgcdKbta0BKo5pT8vPyv00y
 OIsePfzbFZQf1xENBoW3fCbD3Frp4JPRLR0lx2QyoeEnQ9Tley2Vgv/ByV8cd0NghJ8b
 romw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721740730; x=1722345530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iYLHDPjDOFxn0HJGyorIeqJ/iWGilv+5T/P+L6gwcZI=;
 b=Eq618HJD3qwdpNsRnnwFrnqjRt8M1baZWTdY0+F7HkoAC8mmoL/hmbTEAIlEQuk+XP
 Lh+AMtASwMzlpoxfCIj+oERDFkXbCNjdc3cJbkIg8gdt3m3p1fwT2Z+iENDubmHt2yf6
 +8Zbly8GVhcOniUqbXQaZvqkRpgLHC0MgXsmA2hvajwzIWPtC3/a1j/B4keHfsI5IJPc
 Li+5DkDxSOhA6Hi1R2dRz8gvjVEx9Jl4eAl2KZhwtwDseazQBDtOFv1e/vxVWnWBFPhL
 suBTAJkQkTyG8jVRxgB6G2CA8iq3zlP+G+QEa400Rah+macO3g9JUYvbnX5IqYxvToQG
 xtUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbCPtaaqTar5LITufUiiLgencR0ehiBKHvYYKcu89EdGjuU2FT9TzubFb7bXaTHOVI7snXWri0AhSfYLOVKkFhXDXSLA==
X-Gm-Message-State: AOJu0Yxo/vQhdF1TpEbQHWxQkifwRZRrLi4A3BQIZYtf1OHOfW2rd4AT
 ACmYjRU/9ABtBmSbzWUyT+MwPFQxf+abpcQyMD2DKvF/TQH67quqBkCiRkTCyIw=
X-Google-Smtp-Source: AGHT+IHZ3Y0tiJm5A203BzyQ3LPKwTTqnDL3B/Ou9bqIId/eO93PjWzl6AKgdzErBT4V3DBAfZPntA==
X-Received: by 2002:a05:600c:1987:b0:426:52a5:1ca4 with SMTP id
 5b1f17b1804b1-427dc5292e6mr83770755e9.21.1721740728475; 
 Tue, 23 Jul 2024 06:18:48 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427db2a4e3bsm140312545e9.44.2024.07.23.06.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 06:18:48 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
X-Google-Original-From: Zixun LI <zli@ogga.fr>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>,
	u-boot@lists.denx.de
Subject: [PATCH v3 3/7] usb: gadget: atmel: Fix typo in
 usb_gadget_register_driver()
Date: Tue, 23 Jul 2024 15:18:10 +0200
Message-ID: <20240723131817.262596-4-zli@ogga.fr>
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

Replace "paramter" by "parameter".

Signed-off-by: Zixun LI <zli@ogga.fr>
---
 drivers/usb/gadget/atmel_usba_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index 83fdc36870..2e3d8f36a2 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1204,7 +1204,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 	int ret;
 
 	if (!driver || !driver->bind || !driver->setup) {
-		log_err("bad paramter\n");
+		log_err("bad parameter\n");
 		return -EINVAL;
 	}
 
-- 
2.45.2

