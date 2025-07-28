Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6995EC83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 16:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D26D82CBB;
	Mon, 28 Jul 2025 18:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ywv9xgvd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 890E382CBB; Mon, 28 Jul 2025 18:12:16 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E4C082103
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 18:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-454f428038eso40707065e9.2
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753719134; x=1754323934; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F5bZz7xsK8O/kWU4UAx2HoiL5k+OGFP/WEfveSAn9Kw=;
 b=ywv9xgvd4DdS8PHyAvc8sdqomv3utKwQEmiLfWV5yRyOOpVzvJIh9h/XWQr8LWifW4
 LOjRqmYQRJRCmIKokwSbDRQsfmwFaoO7kfyQxZE+oaPXHhNZCSa1+vvgKx4I0SRBjii1
 xJOV0YzS80ut6PW64/mGIOpBvTPwcUNlivqj1fZNuRUACkt2VAVdnpFWAKSkM9yHuYnZ
 6y76Ow9SxQK0dTUgbcwnowIu9ftjHCdifLppyKgoS300dmi9ZhRe0aWrLo2N7nrbJNv3
 pswFKN248jH/ZoB3SkV6+P+aUP8JAsqdwYo/HaZ4lPrqW8AEMorrEKepWg05EOP/SoF6
 YoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753719134; x=1754323934;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F5bZz7xsK8O/kWU4UAx2HoiL5k+OGFP/WEfveSAn9Kw=;
 b=HoTNpjZ0U0BDt9HIvNdrpgCagRo0nbXzEDfDWmUKqLX337UNPymjOTPMWxwcy7GFrz
 U7RJKIWPvPL/NiYw4C7SV2tK62LwxF9Tp2vmCff2c2ywWKYyGiPZQwl5e1xLEId2Yoo1
 ga/HsYc+BdiUHBTnYAlp7yVv0lQCSPx27h43ZH96OOcCzX+oI2uNDrMa+VVLS0dQyzDx
 NfIymtIHALSJ/Ool2UnSs/cV3HPQWGGWSxyIFeRHv/Dfs0M+vccldcWIhL8V3iOjW48j
 UCZg0L26RASZeJDJQsrM14MCovNHIrZZNtRqPw3kLQp2fOCrIApRluYGphZ9CXAmMXfx
 nGAw==
X-Gm-Message-State: AOJu0Ywr7ZLtY6rPqANCbexbwwvDPXo/TF0EcsQ9Sp49SNs6ZzGftsad
 GCYpiR/bDu57Sy4EOtl9RpJrdu5V3hFVodgcvWV8oy3bsWcm6qAQA4IUkC3ww1Ef/zU=
X-Gm-Gg: ASbGncv7mhc4bcEvWS4dwlTJZ0Q1fIp9MuLDh6/VNtPuOZg46gCAHSsaKJNPyf9ONTN
 rL3T8412ZF8oXVVdG/mdiyr7hdfozDG080gmUuMBmOAToBVXBjZ4CheAYfU79DXuIsX1Pzh0JCo
 tKdieQWjFYFHPYMCIpupJX+kPY8P7a2Pg9Fr2SRGUj/4WFisEP/ew2LbrdqKo/kbfdsHgVHh4lt
 7IwhpQ/DHCaf0ne8ff/RFI9TXsD6r0gJuGG8sptb1vi26oIiqAKR3vaG9ARAuGfAxcSvwc6moRj
 cspCY1gyGpk5MZXLw++S6Bd/WURq1I98MLJG5KsMFPWP5PPDrGoos6jGXRYQ+noHG5jb7AyQbO2
 AqFiVPvwCZIZ2QKWci9mfDX0z6fCwDUJxjI0aPCXRfOu9MVIYtg==
X-Google-Smtp-Source: AGHT+IELX5yJnyzI231fnmU6LSKhXH1z19z98yOn9hPj4zb56ewm6XeWYPxgeDxKv9i++hn8feUlLg==
X-Received: by 2002:a05:600c:8b52:b0:456:1156:e5f5 with SMTP id
 5b1f17b1804b1-4588cd345d6mr5211625e9.31.1753719133812; 
 Mon, 28 Jul 2025 09:12:13 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:2df:19e4:8abd:eea3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705c4fcfsm161108335e9.29.2025.07.28.09.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 09:12:13 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 28 Jul 2025 17:12:13 +0100
Subject: [PATCH] mfd: atmel-smc: Ensure match is initialised
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-atmel-smc-v1-1-b3b8e1a4f1ad@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFyhh2gC/x2N0QqDMAxFf0XyvIDrtBN/ZewhrVEDayeJjIH47
 1YfD/dczgbGKmzQVxso/8TkmwvcbxXEmfLEKENhcLVr66frkNbEH7QU0bsmPLrQtH70UPxAxhi
 UcpzPRyJbWc9hUR7lf0Ve730/AO8whV10AAAA
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

If the test in the for loop is never matched then the variable 'match'
will never be assigned to. Provide an initial value so this cannot be a
problem.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/mfd/atmel-smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/atmel-smc.c b/drivers/mfd/atmel-smc.c
index 15296f71a16..94e5e7b67a0 100644
--- a/drivers/mfd/atmel-smc.c
+++ b/drivers/mfd/atmel-smc.c
@@ -347,7 +347,7 @@ const struct atmel_hsmc_reg_layout *
 atmel_hsmc_get_reg_layout(ofnode np)
 {
 	int i;
-	const struct udevice_id *match;
+	const struct udevice_id *match = NULL;
 	const char *name;
 	int len;
 

---
base-commit: 4c3b5fcd810081bd7f3c51859fe1b5f0c159803c
change-id: 20250728-atmel-smc-624b38b456f6

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

