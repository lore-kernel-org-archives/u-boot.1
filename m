Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE60C18E7C
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 14:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F92C807EE;
	Wed, 26 Feb 2025 15:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pjgo9zQe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE4180F92; Wed, 26 Feb 2025 15:47:20 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A59B0805C3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 15:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so46380195e9.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 06:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740581238; x=1741186038;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kfh5LMw8bu78Y8SofL7w/n512dpalX5kQb1SQ5QbkgM=;
 b=pjgo9zQe/otJy55LRv/dQN56o7H+Ry02i1OOzCI1condKzP67xpTIughUbOtqy8Hmv
 0+04KrQGF06HfMQI+us4gLeVr0EmKQm9PNOxQapiZBd/HAbQ9X4JZr5XzvQnuQlN+O7M
 xefuMPLWex6gjgaGsuyr+eJ1+cGuD5SU412RDgrVn6/1zuqALaGncND8/8O8Dx9NSd4Q
 gxZEXzmBm+QKbhWZgCmF54zqfCx24nvpFgM7+WOhoE/Nje9qpTlMWA+H+kx/vmkGqNXc
 fTs7aNiORbPBIEcFYa1wXTB8B/HpzIjFu1x0eJ4DLWu329mRzolNVqKOa5gXrm9lygGj
 usvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740581238; x=1741186038;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kfh5LMw8bu78Y8SofL7w/n512dpalX5kQb1SQ5QbkgM=;
 b=NMWzRNf0fa9r6W1Py1bmR0h8x8PtketCy23EIMT9zBkJvO8ErfElpPn5Zg7KeUhKiU
 bREk+xQdJ03IltfPdoQTODIO0smvav3fwmeHZmMGzYkYVAqeySkJW547mL0y6Vz78qCY
 w0lC88nqGjYHzoVDQL9Ss8R2PWsBwOrW2o7UJs89bJLKvMM129H0w0HgJEZIyCvR+Ymn
 JkTfKC4ZAjkstcuqknNNMaXSKKY9jR8NzzAQckzjMPCEG9u5ttPV/1LXx3wpZFCwPHvl
 Q6t2BBZkWY31SrSI30lWT1oavp9gzuRufpybEy7gheQ3PrMOC+3pdgqBB6zWIHdGZpxs
 uPcQ==
X-Gm-Message-State: AOJu0YyW0PVYejQYdojvkU5NBxN+hYAJQWxA/9s8XjNyxeMZcPFJTnsR
 0B4k8k9WUsNWnRQ6G3VJa4mrmU2bdlcGnIIlm54xNXaIGZLBtnlW68TkT/udIfo=
X-Gm-Gg: ASbGncsd+dFGXB3xbqiAa7AOW6old0iGSe/J7XzthrxvBc4DwAZ1VNYqDHaNUXXCvX4
 9OZl/4H4jq//xc9oyBnNGJfXdyAtg6Zn/iz8GzePY/GawArlwftCc2/7T1Q3OlFmZX13SGOjf21
 JCjJI2Mr8Q0Xn2mm3UvZACePOheyEF07vhG1wmiLFJPdx+sk1h73uHMaeQdXMM7ChsaNRiEG7+3
 vrJbeJ8uUj2GOA9iLdoFcpoLMAJmEYMiK7GF4oM4O2czBSZww2eg5q9VIgemh48403iN1+BU8Ss
 alz44lBeoq/cKbi+xMDi79LPnQMDFTMTEgPT5zWZ2w==
X-Google-Smtp-Source: AGHT+IHbiN4hZnXqUxIOUQadm95LXSM4E2jGTXlHzlw61UypdYXW1R9GGNDUGORUJRSWM6v4QhRZ5A==
X-Received: by 2002:a05:600c:5106:b0:439:a25a:1686 with SMTP id
 5b1f17b1804b1-439aebda0bbmr157901315e9.25.1740581238067; 
 Wed, 26 Feb 2025 06:47:18 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba52bbb0sm24243935e9.5.2025.02.26.06.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:47:17 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Wed, 26 Feb 2025 15:47:11 +0100
Subject: [PATCH] usb: dwc3: am62: Use UCLASS_NOP for glue driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-dwc3-am62-gadget-nop-v1-1-baff88b15ba0@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAG4pv2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMz3ZTyZGPdxFwzI930xJT01BLdvPwCXZMkY+Nkc8sUixTTVCWg1oK
 i1LTMCrCx0bG1tQBlvvwFZgAAAA==
X-Change-ID: 20250226-dwc3-am62-gadget-nop-4b33c79d8d5e
To: Marek Vasut <marex@denx.de>, Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.3-dev-86319
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

The dwc3 driver allows SoC-specific configuration via the dwc3_glue_ops
structure.
These glue drivers usually just implement the .glue_configure function.

For such glue drivers, we don't need to be a SIMPLE_BUS, since we
don't interact with any child devices.

Use UCLASS_NOP instead as done in the dwc3-generic-wrapper.

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
This is a small cleanup intended for next.

This has been tested on AM62X SK EVM using:
=> fastboot usb 0

$ fastboot devices
????????????     Android Fastboot
---
 drivers/usb/dwc3/dwc3-am62.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 99519602eb2c66299445163fafcdb3e065c89eda..66164d0a80c0264bfc400426782324f8a57b8bd8 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -116,7 +116,7 @@ static const struct udevice_id dwc3_am62_match[] = {
 
 U_BOOT_DRIVER(dwc3_am62_wrapper) = {
 	.name	= "dwc3-am62",
-	.id	= UCLASS_SIMPLE_BUS,
+	.id	= UCLASS_NOP,
 	.of_match = dwc3_am62_match,
 	.bind = dwc3_glue_bind,
 	.probe = dwc3_glue_probe,

---
base-commit: 8dd7186ca7821446c6f46b6cccefab502912f2e0
change-id: 20250226-dwc3-am62-gadget-nop-4b33c79d8d5e

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

