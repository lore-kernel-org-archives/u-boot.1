Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FB9C25B76
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 09:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C264A87D40;
	Mon,  3 Jun 2024 11:05:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OO1lMyLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9FE18813A; Mon,  3 Jun 2024 11:05:11 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AB5E87D46
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 11:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2e964acff1aso44766931fa.0
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 02:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717405509; x=1718010309;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3nFCDRlv2Pj7haWHo08Z708RGDMeb1svYiQzyQQRvko=;
 b=OO1lMyLXy4LSIQ6rP/6vilme9aOW2T+z0L6uR9I3Fn93946F/zX49ZVpaYj6lj6bJI
 QI4DpsKuER+Zr/v2r4EDrj1SC3g/BHMmcJnHiuneTR4hpKUmnPQF3QHa5uHq0vS4ajdz
 bGfjHhNEqRKMWdOHrGeEflTc1FGUk9y1Ccr8ioUwSVbqiI28OIF1molseRgLOW6NZWho
 sT0h7cSzKO0uAJfjr8EgmrLFt+oJZrL8AvZLW1a88DlsOeO8RMQdK4GYqsftiZx/cvZ6
 wEog4QFRrtXnork7JmgsvdNeDaMvmCUcmkvJrebQy8fkFClF1WL0tMmPCKm2AiNf1HFo
 QQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717405509; x=1718010309;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3nFCDRlv2Pj7haWHo08Z708RGDMeb1svYiQzyQQRvko=;
 b=MQK6AKSWMPtdkFlKrz3o8eHbYqgjoEupsfCsgODP3z1K/2wH1VbC9pH6J/Z4q1Iaou
 AYUBPavw8zkjsEI2HGrXUN1iTzmy5Ovk++ka5hMbhGlIKKprVx7dZf5CBtqbnN+QKX9W
 e/G6PixER5gV/zxXgiw9MIUT3u5O5MXuEjHfPyTjQsFYiiu/efx1J2MPPDj3mKCvdC0A
 C02m4WFvsaRNFfLIinC23TCSfk/FUPKlLEOxdyCmgNlFpxBZEZM8SJ3ewTqWwjVaHdSb
 ryMyRloS3ymLHT/Dj0Bd1TDZMw4Z/TYKFlateWtwYs5sEg7cDOT+f4VQUjWpmprL+Mhh
 I68g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpjztc8ncTociHX8+lvM26J1HFEiskDPPDZpVQYjgYy1O+lHukEM2D+z4c/zLRhQerdzgvc2m3Rx0IGj6t3+hhrFX9JQ==
X-Gm-Message-State: AOJu0YxMZ7CERqOwsldneh4CjyFec3BDBpZ/cErqa1rbQIfbo6WhILQX
 BdGcKZ2k5ky+9lM76+GJ83NI6mR7Q17reZEP5UcXBHAeqj0j2T4EzmUhj0gG93s=
X-Google-Smtp-Source: AGHT+IGm40uqFP4UVMb7UdWNDmzKuBHGpJL8VCXun7acnVbQgD1S0BnWkCYf+DqrsyS67yHpjQaV1g==
X-Received: by 2002:a2e:a496:0:b0:2ea:82a3:2f0e with SMTP id
 38308e7fff4ca-2ea950fd7cemr50309021fa.1.1717405508643; 
 Mon, 03 Jun 2024 02:05:08 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b838b55sm110772535e9.5.2024.06.03.02.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 02:05:08 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Mon, 03 Jun 2024 11:04:58 +0200
Subject: [PATCH] cmd: bcb: Fix bcb compilation when CONFIG_CMD_BCB=n
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-bcb-compil-v1-1-4edc2c77eed3@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADmHXWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwNj3aTkJN3k/NyCzBzdFIvUxDRzA3MTE3NTJaCGgqLUtMwKsGHRsbW
 1ABuVMxZcAAAA
To: Tom Rini <trini@konsulko.com>, Dmitrii Merkurev <dimorinny@google.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Cody Schuffelen <schuffelen@google.com>, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev-bf739
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

commit dfeb4f0d7935 ("cmd: bcb: extend BCB C API to allow read/write the fields")
introduced the bcb_get() function.

When CONFIG_CMD_BCB=n, that function is stubbed.
The stubbed function has a wrong prototype: value_size arg is missing.

Add the missing argument to fix build when CONFIG_CMD_BCB=n.

Fixes: dfeb4f0d7935 ("cmd: bcb: extend BCB C API to allow read/write the fields")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
 include/bcb.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/bcb.h b/include/bcb.h
index 1941d8c28b4f..a56b547595a6 100644
--- a/include/bcb.h
+++ b/include/bcb.h
@@ -58,7 +58,8 @@ static inline int bcb_set(enum bcb_field field, const char *value)
 	return -EOPNOTSUPP;
 }
 
-static inline int bcb_get(enum bcb_field field, char *value_out)
+static inline int bcb_get(enum bcb_field field,
+			  char *value_out, size_t value_size)
 {
 	return -EOPNOTSUPP;
 }

---
base-commit: ea722aa5eb33740ae77e8816aeb72b385e621cd0
change-id: 20240603-bcb-compil-d8eaf7074475

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

