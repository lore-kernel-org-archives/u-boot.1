Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483C3C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 08:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 109B781E72;
	Fri, 28 Mar 2025 09:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pMMHGXjA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAC3881D6C; Fri, 28 Mar 2025 09:15:55 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC21281E14
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:15:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so20779725e9.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 01:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743149753; x=1743754553;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SF8BTnYQ2hvOjil6Y6XauDCPX1lPLoYwmqO4WBWPteU=;
 b=pMMHGXjAx7aSMKZcfY+a/fmCZJ1MK3f10pmUbs+Q+Hd0FBfVElZac0Ix+ubpKY/ruO
 FvFOVVUDgaGigE/BJDRFDhXB+ZZpyP2tjq9KrppKMiwk7vTzaf5yC6y5iDS+1lOdEUnE
 vLycZ6HCaoyu6/afQPWKHPYx+PyeFX+fhOGJND3hB0EErwfpj0Q+RUSq+knT/wHNPJMG
 oaRikC6ZvLWZN5seBBHIFRsrmoipcaHKjG7X1spBQPBIVu921wjl0ZD5dlRGpO0Yt3lT
 iQ12lHMSUjwtpVhyRF5nRQFRporbkzu+caI2x4SdhL8GD0Aoox+K09LEX2xTK5E/RQ6b
 dEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743149753; x=1743754553;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SF8BTnYQ2hvOjil6Y6XauDCPX1lPLoYwmqO4WBWPteU=;
 b=RGQW43Y6G6OU6A81gf2gJ3CUnBVACtLNp4rGpOtPso4IjvR9LiMPgysAlFoFrr9ep6
 gbKPjIxv4HnkdI/RWSvtIycthlH7tBxnRx/9BS/INJQ2ui7yr7mkiHNIzc2f3jb7f10c
 g2BINwKQSXlX93e/A8Ko2bd+yiXvmkbro4nbGSWf8ieynyQ46hpXVH/jjaZv7J3zXWqG
 +dWqwSrTQl1ARTU8fYMTMQjlO9wSl72fr42hGsbaXZXMQ1EtbnkP1o4hfA92t0W/HRb2
 zUishkKPvwpScRVoku8amiJNEdd1/3gePWDcGG+qL9/uW3lccbaYAyLWu8RjBCY78Fcp
 WPow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPPhJpuSPoEQCpmx5gasoFubK+XlN0qLxyX979q3eKNEHh6zU/etSIiolJwR+UaM4YheWZhA4=@lists.denx.de
X-Gm-Message-State: AOJu0YznHL+x3DCDZMERn6JUJ8YpN6H0W0FAe8Z7b1G9IV4XLO++e3dK
 2GHdqB/nDXKkzdybqDEOfHpmimChqxaKmZHn2ejSjNdpZmovAxj5FV4DqAzJOAzRZ0kfwKWIVa6
 v
X-Gm-Gg: ASbGncs3nZn9tVH82s9djoFoqm3wKp9qt722kSyEXvGQYgj9MRDbJmPGMfi9ss82mpU
 gOVbYHCRT+J7FRP28eN7MldRojvmxu/ixVrnzj2BQq3UQs1vxG0Wy29Otpz433Jj4eYTEwLP3Ee
 /69AV3MzyAC6HS11Tc2Np+Y7OuHG2NB1N70Va0KC/wh/6HeKKtclHuoenNS55O2R7mCgQ2lAl8K
 m0ElUOoSWRT73fKbT/C40ecxa7fvb1mghLhippISk9jdaMJ371ik8JKvjKuFos2IJr8szAnFxNH
 NJ6DuazpnqG2OAniw6FxqU+ZyphG3iRV41dBx595rDow5BGbqJ5w+eh3XUl7Mk4=
X-Google-Smtp-Source: AGHT+IGpdMG6kZSGJhPHq7zYDsi26S00WhvJoEtGuE3G0j1TVVeqjBhhOi1XLXAzn+6ABlHhhY95Bg==
X-Received: by 2002:a05:600c:3107:b0:43d:47b7:b32d with SMTP id
 5b1f17b1804b1-43d850969b1mr44210735e9.25.1743149753336; 
 Fri, 28 Mar 2025 01:15:53 -0700 (PDT)
Received: from [192.168.1.116] ([2a01:cb19:95ba:5000:2b24:7f52:e3f6:e4ef])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fba4c29sm20352065e9.5.2025.03.28.01.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 01:15:52 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 28 Mar 2025 09:15:44 +0100
Subject: [PATCH 4/4] usb: gadget: f_mass_storage: Fix memory leak of fsg
 buffers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250328-ums-gadget-leak-v1-4-3b677db99bde@baylibre.com>
References: <20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com>
In-Reply-To: <20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com>
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de
X-Mailer: b4 0.14.3-dev-94c79
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

In fsg_common_init, we allocate some buffers via memalign().
However, these buffers are never freed.

Because of that, we cannot call => ums command multiple times on boards
with low memory (CONFIG_SYS_MALLOC_LEN=0x81000):

=> ums 0 mmc 2
UMS: LUN 0, dev mmc 2, hwpart 0, sector 0x0, count 0x3a3e000
|crq->brequest:0x0
CTRL+C - Operation aborted
=> ums 0 mmc 2
UMS: LUN 0, dev mmc 2, hwpart 0, sector 0x0, count 0x3a3e000
failed to start <NULL>: -12
g_dnl_register: failed!, error: -12
g_dnl_register failed

Make sure the fsg buffers are freed when the gadget is unbound by
calling fsg_common_release() in fsg_unbind().

Reported-by: Zixun LI <admin@hifiphile.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 drivers/usb/gadget/f_mass_storage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
index fcce6d12f56b..71dc58da3f03 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -2639,6 +2639,7 @@ static void fsg_unbind(struct usb_configuration *c, struct usb_function *f)
 		raise_exception(fsg->common, FSG_STATE_CONFIG_CHANGE);
 	}
 
+	fsg_common_release(fsg->common);
 	free(fsg->function.descriptors);
 	free(fsg->function.hs_descriptors);
 	kfree(fsg);

-- 
2.49.0

