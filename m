Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF8FC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 13:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37CBF83847;
	Tue, 22 Jul 2025 15:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j73Y004t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD7318386D; Tue, 22 Jul 2025 15:40:28 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8668B833D1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 15:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-455b002833bso21641555e9.0
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753191626; x=1753796426; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uh1snK/FHV4PWlsYPmDBVC06fj2BIVun0/xi30Xsbhk=;
 b=j73Y004ttyweWCxPRj6xko8NhpK5kcdBAB+G4c/3oWbO7g/wasWwhTt8r81P4XoqT1
 Inxewq2rcBjc7dugs07hxvw1MNBoYT+NvsJVF2c9BozL8+WBK7HSF+bDcMnsPJNmEUt8
 tPeUtAysNmHRLmxvYpiRomsQpG/zjXmq6YAjSRZRulPLLvxImuwdKcMbHm7BDQOuEqtl
 T2LT32qf6kbVetPSVAcA067D71Ni929I42itJg3B04J7SCOZmYFhxo62jOiXkFHMnla4
 IbG5CarPnUoYr8QW3cGudOfTj/XTq/J2bp3TY+vFpDZRR2NwsN2E+iBRHRFmeGqhoChx
 2KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753191626; x=1753796426;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uh1snK/FHV4PWlsYPmDBVC06fj2BIVun0/xi30Xsbhk=;
 b=eVfji7wPfdZ67NlNMIjt6eHhEq5bx6LQvurpKp2OwMTkbc57Njj4Or34SdrGn8VWxx
 lKK1jNwJ1+IipakZwwzvKTuMFzlDYW9v6pXCPKm84WSw5lW+/U8sV0UXMFYTBy8WwnO+
 LW+r18/r4S6eiBbQaVOn77ActG6YpciHFFZniOx2/idW3Zh0TVtOCp4ydv4u8RTM5HET
 buDRKFyJVslTdNot3ukShy6mQMxaRBC5CzyzJsVqHCAFbTkbS4bZg8PHr95TMyw6Q8lC
 x4qs90LJPgzx2BIalEWO+lBHcZa4ehTUBIzp4sVofAn/OSmyLj7+7ylNEttQ9k0YITk4
 QdWA==
X-Gm-Message-State: AOJu0Yxfh2bYmNjtKoN8j+fw0UBYR3tx9uXIIc7osjNXApRUn+TigVYD
 mhQYa/Tft2WedyVlZ+bZqjaGk8JJRl0U4MiihV94mrAl4nFOtz7RMjVR3cMW0svLjK4=
X-Gm-Gg: ASbGnctSSaUiQQc18T4pzOtlM7fTAe6gkZX1o9vHt4jbr9FHCTEOGG5x6xPFj7MMzvi
 X1blTv/Blgm1+VX9IBaZl11vOq+bfCmhvefC5Zq3iuPmQMYVwNrzDz7kdWz1w9HRo8ZwIdqfIMm
 ylnNZd61zKtvjmBGP8c26i156XoM5XbRmVvdY67yojKIajUByAN/+n2IPh9RllUg2rWyoCq4OIS
 hhaB5dR4F8nwlqmZDDOH/J9+3Mr3CHEQ0cYuK+tM6Y/ZKVB7XWka3ijR6c8Yv/aCO3IyN+aVN6G
 GNcYpiDOLQi9InIcsSqcj2rxhsd2R9eZLXDfbJeuv7us0h4Nw1ETQIYk6UesKlYwiYZT2Ocm0Vc
 NFK07kL8xbnmdB+45jensUROC/FVYhizbeAh8+/IBWPOTrA+p4fw=
X-Google-Smtp-Source: AGHT+IElOHSLn9hH9Ibee+5Lqb5ftGcXhJ26DF7/+Ft4wJsHrUNZFEcYw8pdYeIHjj6lqad4gMXj/g==
X-Received: by 2002:a05:600c:310a:b0:456:58e:318e with SMTP id
 5b1f17b1804b1-4562e29c660mr255146175e9.30.1753191625556; 
 Tue, 22 Jul 2025 06:40:25 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:eb9:1701:2943:d0d1:b3a5:d7fb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e89c751sm186581485e9.31.2025.07.22.06.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 06:40:25 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 22 Jul 2025 14:40:24 +0100
Subject: [PATCH] imx93: adc: local variable ret should not be unsigned
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-imx93_adc-v1-1-f7f272b54c6b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMeUf2gC/x2N0QqDMAxFf0XyvEIXp879yhgS21TzYDeSMQTx3
 1d9PNxzORsYq7DBo9pA+Scm71zgeqkgzJQndhILA3psfIfoZFn7eqAY3K1vE2Lyob1HKP5Ixm5
 UymE+HgvZl/UYPspJ1jPyfO37H1Bjnx90AAAA
To: Tom Rini <trini@konsulko.com>
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

Local variable ret is declared as unsigned but is used to receive the
return value of functions that return int. ret is then tested for being
negative which must always fail. Change ret to be an int.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/adc/imx93-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/adc/imx93-adc.c b/drivers/adc/imx93-adc.c
index f593fb6447b..d671df79f68 100644
--- a/drivers/adc/imx93-adc.c
+++ b/drivers/adc/imx93-adc.c
@@ -221,7 +221,7 @@ static int imx93_adc_stop(struct udevice *dev)
 static int imx93_adc_probe(struct udevice *dev)
 {
 	struct imx93_adc_priv *adc = dev_get_priv(dev);
-	unsigned int ret;
+	int ret;
 
 	ret = imx93_adc_calibration(adc);
 	if (ret < 0)
@@ -238,7 +238,7 @@ static int imx93_adc_of_to_plat(struct udevice *dev)
 {
 	struct adc_uclass_plat *uc_pdata = dev_get_uclass_plat(dev);
 	struct imx93_adc_priv *adc = dev_get_priv(dev);
-	unsigned int ret;
+	int ret;
 
 	adc->regs = dev_read_addr_ptr(dev);
 	if (adc->regs == (struct imx93_adc *)FDT_ADDR_T_NONE) {

---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250722-imx93_adc-496f22f0c68d

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

