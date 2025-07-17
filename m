Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150A3C83F22
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 08:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 587768338B;
	Thu, 17 Jul 2025 10:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RCiyalcP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF6508339C; Thu, 17 Jul 2025 10:43:33 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA7088334A
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 10:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-455ecacfc32so2698605e9.3
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 01:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752741811; x=1753346611; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qx5WW/BVTDw4nrvbee4hwZgjAdva/fNerlRZmvr3MBo=;
 b=RCiyalcPwWGlmAOMzHYog0s/JK0IOoDTqLloyC5O0eqgAwrKpUnbAn0a3oUBcPNB5P
 q+X2kpUJUfbKFO1FqSCEJ+Q/CW63Op+CKyDM/zjdDN2PQQklaQDfBkmuO8nhCecFDQzw
 8LDrWZd5Q26t/ysGW0xXbqtzy5AH8JubXn4RS9T9rFP8mpXT6uKBbDrld02uct+4f3nZ
 oqnF4GOkAUcYm0KvdHe/2FLEyy9u9D3NapmM8QJXRLdgxHh0ComveN3MxtCwKpF5FAjv
 eEMHYFDfYaGbCLgVSKTblMmtY4Efx24aQq9w241iASUnQdopqNeP8/g66BTZLMSFg8e5
 qHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752741811; x=1753346611;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qx5WW/BVTDw4nrvbee4hwZgjAdva/fNerlRZmvr3MBo=;
 b=goH3w6dM2lD6PGXnruEYUPAb+Y3CUV6jYm55lymj7Fq1c4rg3c5or2fQOSd8EP7+9r
 YXPT4fiJ9j8CyGl2vJdJ1Xdy4M9oQDXTQcaP1l4kTfq1qVNfuYnmQWBe04fABMF1CPWx
 Lje/7A9b7IjBT5DVrJMieS3NjPW2rTYE2V+Z4Rq405Ok3gejDQdVqQpG+pItUxYJnhi6
 jvHMttT+J3MjUg6aIWY/uCdS6XkPcQp8aLoc92vv7q1Fd8EnWS8NyjY8SKhLmaaVAtj3
 BzcTnCcuTyydO3Z5V4PUbb6Igdznno+ojY5JuM2iDJS4EElh+vSG+HjWjqOXRspfyKP/
 ePzg==
X-Gm-Message-State: AOJu0YxKJwn+MQ2QD3Yd8Jx4c604NdNx+lrJHMr+hrLrNkRPGKD7heW1
 Mb1UgPl7xnCmlE93XefMFAxf2HTz4rKdwc8XAm6hBZbO+UHgUp1eubPNA1blaw4Cpm0eJpkzsBx
 ip/V9
X-Gm-Gg: ASbGncvorK/yetyxYznYb0D00bPbBxrJuU0qt9AdRPPL06Til9to4GhwaNieKpFVHN/
 xDHd6NCvo6W0s4fJmOhRMeDcb9hAi12YU/TeRZ088BLGHLT1N9LvRfyz1oNq4bt4vxxh/XCjjCp
 aTNMwm/RSxv/f45IZxkVuquDOkUw3WXvLR+FXhvbmOaOEqGVVdCxmJCJ1J9ZdhH3id4FDFHd8dD
 35Z20IGu4xY+6X9WdFplZABfDorZsoisTRaQQXm7MoBsR8rfc3cI0OUCSNtoDfKwxTLUro/F7b/
 la+FS8kKN5ziK+1fa2VTxW5/4lYvOq3vjAJ12B7uhdatJkCokBW+gfMsFE57T3x19HBj4oBQc46
 6B4+xqI+uvkQfBdnVgPx9BoWTpYmTv9X3IpX8YWNjQamDcD/2/xKzyevnpv4=
X-Google-Smtp-Source: AGHT+IEAK6TIHWwNgEnEeudRzgrYI/VjiGzvQ+HqUvCdKMTGDCFwoKUdz7w8JXdYT0j+uqv/R5JmCQ==
X-Received: by 2002:a05:600c:8b85:b0:456:2347:3f01 with SMTP id
 5b1f17b1804b1-456355c60d3mr14571535e9.20.1752741811163; 
 Thu, 17 Jul 2025 01:43:31 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:1903:ee1:3e05:76f7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1a15sm19825514f8f.6.2025.07.17.01.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 01:43:30 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 17 Jul 2025 09:43:29 +0100
Subject: [PATCH] fastboot: Fix off by 1 error
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-fb_command-v1-1-97695943666b@linaro.org>
X-B4-Tracking: v=1; b=H4sIALC3eGgC/x2NQQqDMBAAvyJ7biCJSMCvSJFN3OgeEsuulIL49
 0aPwzDMCUrCpDB2Jwh9WXmvDdyrg7RhXcnw0hi89YMNLpgc57SXgnUxPgwJbR9dtj20IKKSiYI
 1bXdSUA+SW3yEMv+ey/S+rj89WWhFdQAAAA==
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

strlen only reports length of string not including terminating 0 byte
but this has to be included in length of receiving buffer on copy so
adjust length check to be correct.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/fastboot/fb_command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 2cdbac50ac4..df6e2a81cd5 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -405,7 +405,7 @@ static void __maybe_unused run_acmd(char *cmd_parameter, char *response)
 		return;
 	}
 
-	if (strlen(cmd_parameter) > sizeof(g_a_cmd_buff)) {
+	if (strlen(cmd_parameter) >= sizeof(g_a_cmd_buff)) {
 		pr_err("too long command\n");
 		fastboot_fail("too long command", response);
 		return;

---
base-commit: 3b4604a40b9fd61b87e9d059fc56f04d36f1a380
change-id: 20250717-fb_command-275ca03b1f03

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

