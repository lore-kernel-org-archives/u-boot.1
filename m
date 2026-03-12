Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8443106ACE4
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 20:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07413841F2;
	Thu, 12 Mar 2026 21:34:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t0ikRpVs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50B8A83F00; Thu, 12 Mar 2026 21:34:21 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 326618418C
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 21:34:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4171ff4cb2cso1010728fac.1
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 13:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773347658; x=1773952458;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N0s5ye33U+Rjd8hQrcsfCelvPY8nP9zjLO3A5+2JMR4=;
 b=t0ikRpVsbohjPGVGXR7ISXBYQc/+BYkISGYhWJWYCmCU6oCKtbiW+/Mr6Bg8+DhlPF
 /cb9s9pojtjTcjZ/beKzfH7hk1NNFY01ftOOChgQPJ5ckl/FsOBqlzfDk5T9jdyjdDQA
 2iAro0GxOC3s6NZjgpBNyTFYLr0VPfG0dX7PwIQESuNwhuvBSd+0HkwRLruJlpXfa7GY
 /v4uhZyuNHNKstNzZPDrh213VWSAB9nwmXxbTRea/Iol/XXLwYzVamwr8xMiSomyCD+D
 StVe2JoUVOMNr5rEde69g2MmwScpv5vWPSoEraqwc6Cplkvx2lYsHuIOVlvxbNZiprU1
 FRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773347658; x=1773952458;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=N0s5ye33U+Rjd8hQrcsfCelvPY8nP9zjLO3A5+2JMR4=;
 b=A/ulvD56LiqkasujliqC5wChFBDnG+LD7pvb6vV+Y5ITWb8bQ9BuVeMFbPVeUGDFVa
 IEj7MbjXpyARfK+QEJT747rrClKFyO5to2hC1TVB6aJBW5AUpFbiHVbMbVdUmd5tFVNZ
 1jyOoUVWX6NSBUUK/UDUGVIhvv7scc+XjxYC8GADkT25pbD/NIe0zINB0V07p4XmQxqo
 Dsh6z4iRRd07q7zX4ok0u3MD8o2Va7zBDNo8kjKggLaa9BtAuYcS181/C39BDhYZg7ym
 ypzAbJEoBe1Tt2Ncimf+//m1Mkta20JoNndi0ursjET/anOwV9xiF648BhbC0M0rlGPz
 Kz8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCL7WQEorCOJwBZSrbJq3AJFhR2Q/JTUI6HapXqw0Knl1yujWRJysuc1to+f8bBLnPbFPlRWE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx84zNeYxKTNs/lV7iH9yZteitJOWtuZkJG0J4XUk/CmlWegnCS
 ZuUlxwq5VPysTeKXW5zfTfI+Pn6g9NdeHBPZeu6jdCyP/37Wj+KoHkATeHN+I16Wmx0heOWWJ6T
 RZHRT
X-Gm-Gg: ATEYQzxGjbsD5hvp+FoH41r7Ncpm4ZQj5zmYrGTPr2Wcqx+QeNJ+ewCdzKYXYgTRpsF
 cIFb4/NAujkQ4Ib+UzD6IsPmWze1b4/wewJAO5WzRGiQGNRiMXMYARfiolmY5KKS4p98SIQLWTV
 5sDylpgEi4pQYE+6Iv/OyNV3/0LMw3+/Xmfd3cBDHP9ZogvMG57GDorHZ+xGUIVUH6JXi3RVi7Z
 unAuV2TWx2GIpx5so3G7dKSpOm3AB4gzEBzxAM1AIOunIk7wbwGHfGNSNxHw494DZmfY//aT09M
 FNRj6lWMHMQ3clkls3vMIXW+w20j3sxThX6Zf+LYpRx/yw4VkxGqwzI3lE/mcI74Hc1uDZ3j1ZO
 h+o5CUSEGoOS9Z7FBVzLnKX/KXHjWs+XttsPyHsHVY4YW8j8Yjy5Y3Ywf0F8n0kqLJyomJX6dP7
 2w3JLzYID0A+X3DyWyz0Kw5zMeWx7c
X-Received: by 2002:a05:6870:c18e:b0:417:70d2:f991 with SMTP id
 586e51a60fabf-417b916b837mr463145fac.8.1773347657772; 
 Thu, 12 Mar 2026 13:34:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1f95:f82e:8747:8137])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5e8185sm6276286fac.12.2026.03.12.13.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 13:34:16 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 12 Mar 2026 15:33:41 -0500
Subject: [PATCH 3/3] test/py: gpio: allow omitting gpio_op_pin
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-test-gpio-cleanup-v1-3-bcf549671eb1@baylibre.com>
References: <20260312-test-gpio-cleanup-v1-0-bcf549671eb1@baylibre.com>
In-Reply-To: <20260312-test-gpio-cleanup-v1-0-bcf549671eb1@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=XxtbyTucQaF+iy57BAWWqcUjNEvNceuqvZzKRQmvgoo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsyM9EbaWiyOVl0YWMlY/ZOPi7hVqtMVeyAnnE
 R4FgyKLz2uJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabMjPRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AkZ0H/iZ5ICFoGCKC203hPnx0LkXkwimvIsl6lXRLWsm
 vakltpMuhezvUw22x3CcBz7PQlonurvdBaH2HGFRKCHHil6n5YUOkFPRURt6ASZ5TktLWMqlwp6
 CJZWjpc7vDXHbX8Mh9u82saqyBAaUjo6akKFo2QYe76SwRaiD0HthQRnvgWUCXaCov/8J6rg++x
 uKR7v9mmwQ6wOZN9hxm92aWoBQoeYWsWsVJyHpaSdd4RfDgg3TW5bsEhK4d8gQQuPPuS2zMQR69
 NW3/QRlOtEeM5W6ZlGi40P9GzMpfRoB14KmXv7cA7e3cxipOGFX0kpJIh1plG75zzyOeqRBKUUg
 KUTg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Modify tests that make use of gpio_op_pin from env__gpio_dev_config to
be skipped if gpio_op_pin is not provided. This is useful in cases where
one might not be sure which GPIOs are safe to use as outputs that can be
toggled without causing problems.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 test/py/tests/test_gpio.py | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/test/py/tests/test_gpio.py b/test/py/tests/test_gpio.py
index 059b5141b0f..eba7bab7589 100644
--- a/test/py/tests/test_gpio.py
+++ b/test/py/tests/test_gpio.py
@@ -134,7 +134,11 @@ def test_gpio_set_generic(ubman):
     if not f:
         pytest.skip("gpio not configured")
 
-    gpio_pin_adr = f['gpio_op_pin']
+    gpio_pin_adr = f.get('gpio_op_pin')
+
+    if gpio_pin_adr is None:
+        pytest.skip("gpio_op_pin is not configured")
+
     gpio_set_value = f['gpio_set_value']
 
 
@@ -158,7 +162,11 @@ def test_gpio_clear_generic(ubman):
     if not f:
         pytest.skip("gpio not configured")
 
-    gpio_pin_adr = f['gpio_op_pin']
+    gpio_pin_adr = f.get('gpio_op_pin')
+
+    if gpio_pin_adr is None:
+        pytest.skip("gpio_op_pin is not configured")
+
     gpio_clear_value = f['gpio_clear_value']
 
 
@@ -182,7 +190,11 @@ def test_gpio_toggle_generic(ubman):
     if not f:
         pytest.skip("gpio not configured")
 
-    gpio_pin_adr = f['gpio_op_pin']
+    gpio_pin_adr = f.get('gpio_op_pin')
+
+    if gpio_pin_adr is None:
+        pytest.skip("gpio_op_pin is not configured")
+
     gpio_set_value = f['gpio_set_value']
     gpio_clear_value = f['gpio_clear_value']
 

-- 
2.43.0

