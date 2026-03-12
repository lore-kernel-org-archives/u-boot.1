Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86901106ACE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 20:34:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E5C841C8;
	Thu, 12 Mar 2026 21:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xb2ybmIj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A830841A2; Thu, 12 Mar 2026 21:34:20 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D750F83F00
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 21:34:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-46704fbf62dso992288b6e.1
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773347656; x=1773952456;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LqgPFJmTARHSlQBDJMb4B6eq2zE2+Dj4dVGA6AnxSqA=;
 b=xb2ybmIj9dDtxY26Qj2DyPhwSioHOxkQHswm57fQKtzGrAwUYPRE//0OWdYLxxufvQ
 NMD2Bi0PvXJyM7U/CmbqVd7BmfgDAIOs6pooCBIKqXk8mFONDDrLHNMkK6bQHv0+8kkW
 UTIlAx2EMn/VZA0H3LGyoGqn8mEpMSRRZGVSwsNoQaeH46oOfqB+eN82Ao9k0lAWTo2l
 FQwLzb9vbxGrNozj9GU/bvd40M+7FQIQl/2BhIC3k0ITnfc3m29XwIr7Tq3uxaoKiC9z
 B3ZRD63bGYZYpeR4RxI4jExO40+dhDyRqCMv4W+ejmJwS5J+L93TZHNFX7OyQzuVGB9b
 bNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773347656; x=1773952456;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LqgPFJmTARHSlQBDJMb4B6eq2zE2+Dj4dVGA6AnxSqA=;
 b=MG8YDVVq/hcQq9AO7Ppe4DBCpor0zN5W3ajlLLhkdZo81diUDK+VjJox7Egt1bONe1
 mlk94pv6l3hIxq3OOhTwt27XhoBrP4u4cCNVKfzeJkmSRddAFE0NcFAKe0youQz/37Z4
 l1HvVrU8ROiPb4gKzBpEcy0UiCvJ+I7Xt9iL3D6pXl2nYnmzwtQI/uxIHS7b2mGRRuBO
 WwTP6FSAACBFUQozBFcwqtQbax2epPkFQQoNjqLJeiN6g6nY6oTRg7hMshtQ2R5eNNrh
 IWc9YInNbjTUv4+x45xJ6zqWWiNkvU9lGc1yFk1ld8DO5qMLb0d6hsb7FZvTiagxMQ6E
 jagw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6jqMQ/zkD0g07En/cIqAokw+tdu+R+r8nc1223Tz89+5/P9coTP23z4z7wvOANoxywO5CzL4=@lists.denx.de
X-Gm-Message-State: AOJu0YwfMBt8WeW8zrT+B6gbJUbp+kcMfj8gNq8DzDV34SKXSqvix8sz
 XLKbOjiy2jOg0AbGxEB1sjASUi7i3EdwguZHIdCLdLFxDWI4YYX9z3fr0WreZo+8O71sXzdU34x
 9HcOc
X-Gm-Gg: ATEYQzyugVprHznDv6ndAbJEocE0mLsNNZSJHD/gO9gpnz9zrZELxclBDFo7/LB/wzT
 V3HGLBXe2OlN5EkoYD5cdUHikMOVdVTGoDaO33lKYqqAxHqbFL+haYrwqkQ6j0JTc4GIpN3wn7K
 paQ55Q10VMfIueO+GwcaUSVXqmAn47cE+zq92YdwlRQloMVVlP7Bih4sjbpjjF8FWIYA1iOhzBZ
 zrYnmJm6NWaGx21QWw4tReq3iJxomFoextWo2cT5CnBUArXg4914/3+CuAqIM8KnzLrq2RCdpkr
 9uwDbJUq+aCd+xI278GDzdPvcLzqX95jMB0B+csKc+mwGSy51b83RkKkwECqgeIC7PiYsg0llKw
 Hlw0A9NGgPRVUpAdqd+54Vhdr7j9/aLOJsiGGJiqJBCXykEylvHUiV61ZwLyM2g2BLgEvVWug35
 TgAJZd58Hbvg08qfHJV0/G7M+/Xa96
X-Received: by 2002:a05:6808:1c0e:b0:45f:434:9c1c with SMTP id
 5614622812f47-467570a0bbdmr365269b6e.12.1773347656450; 
 Thu, 12 Mar 2026 13:34:16 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1f95:f82e:8747:8137])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5e8185sm6276286fac.12.2026.03.12.13.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 13:34:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 12 Mar 2026 15:33:40 -0500
Subject: [PATCH 2/3] test/py: gpio: removing trailing semicolons
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-test-gpio-cleanup-v1-2-bcf549671eb1@baylibre.com>
References: <20260312-test-gpio-cleanup-v1-0-bcf549671eb1@baylibre.com>
In-Reply-To: <20260312-test-gpio-cleanup-v1-0-bcf549671eb1@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2283; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=NJdX67HXulKkJe4IhY7aSEVt3oUKNOhuRicNiS28qBo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsyM2MjCI/uvJ968aTh/DuMkO90bNbO9wpunM6
 f3rgDa1awKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabMjNhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AkYgH/jgBmChCZ73HVdnYgCIuI1Gcc5Kd9dxloelmYGe
 BX0t4D3R4K2ZjAxOe0XKM61e0jWhCW5sVghp6nxWQiJAZ1b2+vTkz2aj9WjDRjU0X2ivNv/HJus
 2O9GnbORUF79vv/glvwsWvzBhaR9/tzzoY9B54+84zn/aaZepkU10Xryic91xHg754ujvb+MoN6
 D3cx3HuarPQhNH37Fd1PanHtfRX9y7XkEDYVojJKJ9HHp5MbkeUzW1j/DkjnfJrvOl/5mYX9ijL
 iTbbWKE4VkIjRXQuuaKIRNm7tPFOSkiZ2aO47aiu3NR1WHCmkF0AEE02U5nQhWFIshka15yzy4s
 w0ks=
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

Remove trailing semicolons in test_gpio.py. Python does not require
them and they are considered improper style.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 test/py/tests/test_gpio.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/test/py/tests/test_gpio.py b/test/py/tests/test_gpio.py
index 2d4a708aa84..059b5141b0f 100644
--- a/test/py/tests/test_gpio.py
+++ b/test/py/tests/test_gpio.py
@@ -134,8 +134,8 @@ def test_gpio_set_generic(ubman):
     if not f:
         pytest.skip("gpio not configured")
 
-    gpio_pin_adr = f['gpio_op_pin'];
-    gpio_set_value = f['gpio_set_value'];
+    gpio_pin_adr = f['gpio_op_pin']
+    gpio_set_value = f['gpio_set_value']
 
 
     cmd = 'gpio set ' + gpio_pin_adr
@@ -158,8 +158,8 @@ def test_gpio_clear_generic(ubman):
     if not f:
         pytest.skip("gpio not configured")
 
-    gpio_pin_adr = f['gpio_op_pin'];
-    gpio_clear_value = f['gpio_clear_value'];
+    gpio_pin_adr = f['gpio_op_pin']
+    gpio_clear_value = f['gpio_clear_value']
 
 
     cmd = 'gpio clear ' + gpio_pin_adr
@@ -182,9 +182,9 @@ def test_gpio_toggle_generic(ubman):
     if not f:
         pytest.skip("gpio not configured")
 
-    gpio_pin_adr = f['gpio_op_pin'];
-    gpio_set_value = f['gpio_set_value'];
-    gpio_clear_value = f['gpio_clear_value'];
+    gpio_pin_adr = f['gpio_op_pin']
+    gpio_set_value = f['gpio_set_value']
+    gpio_clear_value = f['gpio_clear_value']
 
     cmd = 'gpio set ' + gpio_pin_adr
     response = ubman.run_command(cmd)
@@ -210,8 +210,8 @@ def test_gpio_input_generic(ubman):
     if not f:
         pytest.skip("gpio not configured")
 
-    gpio_pin_adr = f['gpio_ip_pin_clear'];
-    gpio_clear_value = f['gpio_clear_value'];
+    gpio_pin_adr = f['gpio_ip_pin_clear']
+    gpio_clear_value = f['gpio_clear_value']
 
 
     cmd = 'gpio input ' + gpio_pin_adr
@@ -220,8 +220,8 @@ def test_gpio_input_generic(ubman):
     assert good_response in response
 
 
-    gpio_pin_adr = f['gpio_ip_pin_set'];
-    gpio_set_value = f['gpio_set_value'];
+    gpio_pin_adr = f['gpio_ip_pin_set']
+    gpio_set_value = f['gpio_set_value']
 
 
     cmd = 'gpio input ' + gpio_pin_adr

-- 
2.43.0

