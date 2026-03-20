Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F451099B37
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:53:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD0E83CF3;
	Fri, 20 Mar 2026 21:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a3pqS1dS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4478883FF5; Fri, 20 Mar 2026 21:53:31 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA24583F9B
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-408778a8ec4so1590805fac.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040007; x=1774644807; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vEec3tyZL3yDV2BrPbwt63f1S6VK/wOL/ycX6XrW0iw=;
 b=a3pqS1dS0iLNr/sNuSVT5ExL7wu+YpTvuOfdHrj5RHG3IAxZJUuuDJwwzoVFo91o5f
 lgVNedpIYcLNk33v3m5xWbXHWTKz3mGqPb4wDM8WrEdLQSiE9pOQrGO8f7vmcvQY3tbK
 jz0B0VxZxOn3S62u8OW4OIGbNZtKqrIUWb5Q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040007; x=1774644807;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vEec3tyZL3yDV2BrPbwt63f1S6VK/wOL/ycX6XrW0iw=;
 b=bAqBrskbHAW3W0ZFGuPNZ4TXYy+q8Y+RECWTQYDdUe4I+Pk3nDfWg9t51NwbAniw2o
 sOD4aGJHUa3QZupkWoh/Ngg7OJB9LhLBvZXhWTFE+acymsYJb64vmu8F6M9MuoC349R6
 p1o6Bp2t0HMOh+fiSvIa9VF11Bq7fo5ONG9/CDcIdcqsbmuEByIGFYHka6CN8oSA/nsT
 D8a/hVWIFApaoFC+1/BZdUihjCqarvYDY7vWh0NLFbssKEHJ74c0nmaIzs8eUwjmx7vI
 CZyqtjjXAoClf+plJ7sPK5x4Y1PO8/JT5UgTXNXWWsRJgsPlNZ7NUxMCkLbabAtHj/WK
 DTwA==
X-Gm-Message-State: AOJu0Yzvtq4I7ApLvWh9JRYSmA06X6bko+Sq8ijvER5XgujQX+9+owkq
 8Dis0c3hcbJkExXAY90a1Dm6g2n5hqF4E1rHC2Fx+NNcDeStRKlBvSLpVVMU81LB4nlD/2/hsps
 ZY8YIh68=
X-Gm-Gg: ATEYQzzKjvoGSwO1Axye+2yb9yAMENMivk7sDTaRyR/bGNcSx2BG5FN1LqavVAA4YB7
 hFrSof+sxaBzAAapQu65bB1+AWeftKof8nCw9rsvvDhy9gTAD+9PuKTaaK5XxcKSAko2b4Ab1cq
 B/NK0zgjUd9sCZQAO7NdbSz0e7YUjTINC8E0H5x43a9Lj7D9QuKP4d0fPB82z5alUhPrfc9y8JA
 BY4HOHuaY0F+fXVX3G5IpwVhz3QZHAMtilD8mkYYKwlou6PcMYspZqO9pkoYdeSIaRz0dVJuA4a
 B0U5qC9RP0wIHcrdPnCsi6qwqs49qOzc05gPcsCSkqqC3LlU6Otvzxr8aZFlLRXL3uMeLi/EciM
 XXfTtBjUZ8A95kT1ERuE7ERlSkD1Yfe2yGVLXN9mGsKSfoaJlzUN+7Xi1XUp5+OU90gg9EU3+7f
 SedZ17uOIR8gRlwYBmpVrIL1wUIuhHmBJmJRXiz8c5+Ak552sAn5rushH9xSLg2xI3YpPOXSvoK
 QHHXnn5u3VftdkoABlKtJ1pBfVzEe/HEMGO+vbAX5v5n+q6988=
X-Received: by 2002:a05:6870:e08a:b0:41b:e633:baf4 with SMTP id
 586e51a60fabf-41c10ee870cmr2890603fac.3.1774040007496; 
 Fri, 20 Mar 2026 13:53:27 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14ddbcb3sm3034937fac.14.2026.03.20.13.53.26
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] bootcount: Give i2c-eeprom a unique identifier
Date: Fri, 20 Mar 2026 14:53:26 -0600
Message-ID: <20260320205326.3788614-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Every U_BOOT_DRIVER entry must be unique and this driver was re-using
the name of the bootcount_spi_flash driver. Change to
bootcount_i2c_eeprom.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/bootcount/i2c-eeprom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bootcount/i2c-eeprom.c b/drivers/bootcount/i2c-eeprom.c
index 12c430465c98..f54515f451ec 100644
--- a/drivers/bootcount/i2c-eeprom.c
+++ b/drivers/bootcount/i2c-eeprom.c
@@ -85,7 +85,7 @@ static const struct udevice_id bootcount_i2c_eeprom_ids[] = {
 	{ }
 };
 
-U_BOOT_DRIVER(bootcount_spi_flash) = {
+U_BOOT_DRIVER(bootcount_i2c_eeprom) = {
 	.name	= "bootcount-i2c-eeprom",
 	.id	= UCLASS_BOOTCOUNT,
 	.priv_auto	= sizeof(struct bootcount_i2c_eeprom_priv),
-- 
2.43.0

