Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928CBC8302F
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 13:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC08B81D6A;
	Mon, 30 Jun 2025 15:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gakbTf1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABBAC81E13; Mon, 30 Jun 2025 15:25:55 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50F2E80B9B
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 15:25:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so3444119f8f.0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 06:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751289945; x=1751894745; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l3qw/Y+LUg2yTb1aoPuNKeDEu/tyfEliixcCdtenZEI=;
 b=gakbTf1PhpxsW2dUVsiBf7mW0h5zH3LcPEiPCWDxzqFdwtfHkATf5/C0VbF0uUF5WH
 fbCVYjOlWN6TpZ1u6hilZvx2ue6lGKyKuXHZ8lF3CgUPyMQqcl96P8M5N0y9EsF+5sd8
 VPSNtqUplFh+8hZzO/X2eF9Q8YXOtMHwJScNtySkUlhyHOUjNwhQ0KiOdqJWodETQhMv
 FwSUTE75QDZ9d/3BqURKyRVP15R9q+GB+nkLP91cp7+vvyodFUEzRNotdutEXJpeHKaF
 lYhIuM9LsrHV9cdJ7KPHNt5iGo57YPm3bjHisqk42TmbN+TiYQaJJSaZcpyqP4RSGWh5
 fYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751289945; x=1751894745;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l3qw/Y+LUg2yTb1aoPuNKeDEu/tyfEliixcCdtenZEI=;
 b=RrlKWUF0SGF7ds1zWPH3OfdsKVPRLhGjK5CNFu1NHJfiS778SZzHQQMrAQN/iPX/is
 K/b4VjxvNSdrfa4x8FQ1BAvUW3grjZ1pUSvUQUYT+5eJYfFgN6cif1DarsiZMvfKoZ0X
 kSwz3XR0ULtSwRIjoX71Tx8cfMoxyhTaZAV4+pYmOiDwQcNPDxgV0sbtofFv/S9Mbl0m
 02thJ+D6ymo8pCkDI0En68A0hZGeqSgqamvSDvFRYCCtNsx04PxcYgWZ7wFm6zXHEuro
 wMUHMjBtTHZnMmq4l+2MOJAKaffrGgF9Mv/TCan7LBS/mNpcNSCRXSS9O3c6EneGxF8d
 vw7w==
X-Gm-Message-State: AOJu0Yw8nU0N6Vuo2GUNPPHUWlNUP0qYT811q+ytXV5Scj4uqowpa/RR
 TTfyE1Hom8c5tDn9y0nk23efwpHS5lYfnLbt1i0F3QDDP6wnouoT5xvXbDIhHH7Ueqty28c8Waf
 4/pOKXzo=
X-Gm-Gg: ASbGncseKYoBrG73KYKJO0HKgtmAROcAzzTjgM8UKCcIVapivMQTf8lOrbjEwA0q1HY
 PLBZG1D4WANaIQFd2vtEK2N5k2GML0hu9/aJ2algUfWAFFJTGtlODJtkNp9oLShexKo6/5JRtH/
 rwM4KTyAnABv7c3Qabxe6JfzslpMGEpxJlRCu2nQuYP7idj3MGUoVnD8xPM8SfyAAfWgtl0xfC2
 k1ZUfG3HSr9HSlBYpdYtLTUP4Tr36FPmJY8qPx1e0+pXECluqLsDfFWXkOC+OF2UV5MMM1zw1Bc
 up/adMxWjlixFPLHeos8xieWlQvpXEe10V/MOy55dIkKOKNUQ5DM3xs4X6rP4AlyT/UfXiI3hEH
 BGUyw24/26SN05bc=
X-Google-Smtp-Source: AGHT+IHSI4Mzi0QHN+hUSfjP2/dwAWcqWBbHCQ3JIKk+BoAO80g93cEobIYo77fj1pmkbVXSYQhm+A==
X-Received: by 2002:a05:6000:2893:b0:3a4:d9d3:b7cc with SMTP id
 ffacd0b85a97d-3a6f316232bmr13770352f8f.28.1751289944642; 
 Mon, 30 Jun 2025 06:25:44 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:10fb:ba4d:cfb6:8c75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823b6e9esm168980155e9.28.2025.06.30.06.25.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 06:25:44 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 30 Jun 2025 14:25:44 +0100
Subject: [PATCH] boot: bootflow: Ensure sel_id is initialised before use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-bootflow_menu_fix-v1-1-5d75ced54484@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFeQYmgC/x2NWQrDMAwFrxL0XYOzQnOVUoIcy42gsYuUpRBy9
 zr9HOYN7wAlYVLoiwOENlZOMUN5K2CcML7IsM8Mla1a29XWuJSW8E77MFNch8Bf0xA2tg7tvfM
 ecudQyTjBOE5XOaMuJJf4COX9/+zxPM8fRwcdGXwAAAA=
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

sel_id is only assigned to in the case of EXPOACT_SELECT, anything
else will leave sel_id uninitialised. Initialise it on declaration
to ensure that it is always valid.

This issue was found with Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 boot/bootflow_menu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 9d0dc352f97..58899a83295 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -182,7 +182,7 @@ int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
 	struct bootflow *sel_bflow;
 	struct udevice *dev;
 	struct expo *exp;
-	uint sel_id;
+	uint sel_id = 0;
 	bool done;
 	int ret;
 

---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250630-bootflow_menu_fix-4ea403f596dd

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

