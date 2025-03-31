Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575BBC3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 17:01:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3225081F7B;
	Mon, 31 Mar 2025 19:00:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="zQXcnqK4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF12581DE3; Mon, 31 Mar 2025 18:26:29 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D63481E1C
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 18:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so28025625e9.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1743438385; x=1744043185;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JsG5DX39Vs1kepZul4q8lbXU2H+JkT/ho5USfAFNaSY=;
 b=zQXcnqK4+8/AjeilJ5Cwu2Jlhal2TJ2l35GXQ0TGsjy2XpGresualdWLNc+gPBy1z1
 xd8x6cPLRNpruoNzkz+jFtWEd6rBld428d0GTD6YjewvwSl4O61a6XjmHJBHkKcFz+lt
 lyFvMEke29lNSG9tVimoBS9xLVpxo0rcFzqUoNXd+4FWxuMtMKnFJg8cPUrosX2aeoYx
 hbDCeHE/H1Fu1vZgpcShvm7EDMs6ZhGMijrZeXGMbNMAaOAtLcMCIAlVdPbC1XVrt/GY
 AdOEi4E0qPI6q1XS6kheI7CwvA2Wjjqbmns7MeC/wPDnSOT5JPGuapQxUQyViJ266zK/
 ve3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743438385; x=1744043185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JsG5DX39Vs1kepZul4q8lbXU2H+JkT/ho5USfAFNaSY=;
 b=a//enx7/RzHC0HFc7mT91ubCr0UWbvikR41sYTl9/EkQHci0N4dhcwL9Xj9NAkIzHW
 6+xy32Pt/vp7f6SVbUFgJPwlXgNxBG6tl1c3fqe7704aHvILCcR19WbhAQ4uGGJ/afSt
 aoXmMzNIFxVKUL/zYCtwz7usv0n5iklXHYTHVsGA3iwVFamhu0Jt32Qfk7fEbWpMiPvC
 ZWsGYCKjDXh9ZOUjv5H7GvTp522iGAvlGL7CY3p0JXOF7KY6b1YI9m53wiVyK6HBwEVM
 70DZL9qoP0iz+Bd8xgDS1SZGQMeO8KSMOUlcIpHbioDjq56cGSN5BmYis/gEAmZV/cnn
 s2tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoLTaGyulbCD0WWzwFzJyAgh8sQ0TIKfCEEJa714jrEkOwQHGRUksvbgSTXBSHDUk5HSMMsUw=@lists.denx.de
X-Gm-Message-State: AOJu0YwP3JrRYJVmUV6tAw5XHD3p9XcFwDPqfKGVcJ2RPXSM/dUqW05c
 bNac7czCvbKuqYqUTAwZdlyQrJbBoxBaA4a/hG0iqxA9ozSxxahZiTjFsMFxuhs=
X-Gm-Gg: ASbGncvu2ycsPhJO1I1L9MHQfB91B6c7aiji2Gjb0mySTAMtKfkSRZ/54C8RLvRBE/j
 PyUDECYJ0Jvfw80LINTV1+u6Y+RjZrpxDaLTErc5iIQ8fH0wjOkRT8OvkeaqTtt1Q6lFGJCFmKD
 rDU3D1qiUO66IjkPZIy+esZR9zleqv+teXy529q/GFOhin/CdwPkPjTaqI6ThJPF6ZH2u71KbNH
 fWkrGNQSLWKuuro+AjglSJIUwsJWu/eJqc7Lx19Pq2idKnrhMrJxccVwJmiA+pF/SUSE+Bz2sUt
 nH6kBU6nu6LfZhQ0N4XVPeS9q7OH4X0+SfQBqKuPZwAyrwXiJqxT6dBt
X-Google-Smtp-Source: AGHT+IH/+wQY5ys01IOOrw9qr1A8SWQ95Zec5d7OYxXbXlU1PK7kAn+UJZ5jNNPZxSkrQcW+2HRF9w==
X-Received: by 2002:a05:600c:1d9d:b0:43d:1bf6:15e1 with SMTP id
 5b1f17b1804b1-43db61d894amr95093545e9.1.1743438384571; 
 Mon, 31 Mar 2025 09:26:24 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43d8fccfd9bsm127267695e9.20.2025.03.31.09.26.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 09:26:24 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/3] usb: gadget: atmel: Add SAM9X60 support
Date: Mon, 31 Mar 2025 18:26:07 +0200
Message-ID: <20250331162611.1557759-2-admin@hifiphile.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331162611.1557759-1-admin@hifiphile.com>
References: <20250331162611.1557759-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Mar 2025 19:00:14 +0200
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

Compared to SAM9X5 the only difference is the DPRAM memory from the
USB High Speed Device Port (UDPHS) hardware block was increased,
so we can reuse the same endpoint data.

Also add compatible "microchip,sam9x60-udc".

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 arch/arm/mach-at91/include/mach/atmel_usba_udc.h | 2 +-
 drivers/usb/gadget/atmel_usba_udc.c              | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/include/mach/atmel_usba_udc.h b/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
index 835b47d91ba..23c71985c90 100644
--- a/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
+++ b/arch/arm/mach-at91/include/mach/atmel_usba_udc.h
@@ -20,7 +20,7 @@
 	}
 
 #if defined(CONFIG_AT91SAM9G45) || defined(CONFIG_AT91SAM9M10G45) || \
-	defined(CONFIG_AT91SAM9X5)
+	defined(CONFIG_AT91SAM9X5) || defined(CONFIG_SAM9X60)
 static struct usba_ep_data usba_udc_ep[] = {
 	EP("ep0", 0, 64, 1, 0, 0),
 	EP("ep1", 1, 1024, 2, 1, 1),
diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index a77037a7094..f9326f0a7e7 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1443,6 +1443,7 @@ static const struct udevice_id usba_udc_ids[] = {
 	{ .compatible = "atmel,at91sam9rl-udc" },
 	{ .compatible = "atmel,at91sam9g45-udc" },
 	{ .compatible = "atmel,sama5d3-udc" },
+	{ .compatible = "microchip,sam9x60-udc" },
 	{}
 };
 
-- 
2.49.0

