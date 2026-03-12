Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C93106ACE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 20:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82CAA84167;
	Thu, 12 Mar 2026 21:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FcxtaDi4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F4E68407F; Thu, 12 Mar 2026 21:34:18 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2100184166
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 21:34:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-45f053b7b90so972433b6e.0
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 13:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773347655; x=1773952455;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hD1d8J7woBEWXMXyNwcI8N4YYcOjIz0vCo75qO3Ifh0=;
 b=FcxtaDi4GxtIF8SeYqK16AqzukOuOvmZPUIZAnIJPa8KwQyGTvdHlhIoAhLg3qspDl
 wxMtQGXOrDNONXQAWEwRJ/43plji1rRxwA9ufW+TXIfa911FtYt3fuo2QPiNQgeAKv6x
 BtWV4bk0PY+YtJ+jtuFMv6M8u08JRSVFtk2bzEQoy/IuzpNVC7mtbuFCHxXFCKT2AjWV
 i9+sOoRYg8vD5Q9QOywyAyeQ4eS4VQIWJv17Wcjy4EBCOUZ808CovHnN6CGnNBtDn1fw
 kf1AqJuQEiU+R0359rBpW16hKiBwkFTjLq45Tav1zvQ3yfqEpDMyfX9VwfzvQeveyZum
 WnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773347655; x=1773952455;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hD1d8J7woBEWXMXyNwcI8N4YYcOjIz0vCo75qO3Ifh0=;
 b=gwf6eSL35W5trMpoMvFqIvfSmbGMrrw8iKHu9h1pH3vzRKo655nybQA6nKW5ylNCTH
 iU1XRvo2zHmDyNGnidrJmuR9NtTeMqC6lOH7mJv3MrP3LD+xzDSe/Uhb+Gm7jrFhnkAF
 DmAWrDIIQba+BUutQ/Ts5kDcjL5vX2p+eULnmwRwIf3LbBFxCAhjnZWAaHijSTzT7BrM
 nX4qnZjJLSbIW1ux/oiWy0wXXt3dro/q7bVy1fDlL+GPAdVcQFdRT9dsFCyIddCisQ3i
 ciR3vP3VRy4dTuwSXxeYGTziZowrx0PQklchCmVW86Fi2SrUU1p9Efa5vk4ihSQxARmF
 e8KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa26WmpOzLR2KbeXCQ/Edhav/UmKQPI7MNw3wJ+PKNGdl8trkUiB0Kq2so+KuEmiqVeTZXK4A=@lists.denx.de
X-Gm-Message-State: AOJu0YzeWx2HfZJZKI1cQr5PadIuHY+Levw6cMg5P7a1pC0vRLUY5yh0
 Hg2Sliwx1UJlrMdb5ijUj86ns/9wmkapT1yb/qOfk5aFpjYx2RnyNP+kuUKACz6y2DwTpRE/9BV
 bACrB
X-Gm-Gg: ATEYQzzV8o5V08jHLrnaQ5CbpbhCV7YFlJ9JudSSV/9Vcf48sv6Zpw98lw2fB7Imepo
 mPElrtGM84zpDyO0BU4/0Lf6WdpRjxUuKAqclb+GIlxA9sPW4OhlD/y1eMDrV0y1QtScZ7L2Bnt
 LzHeaHcvLrZ/iTKHY8lKv8/GNiSmxzUMI6OSqLsFF+sheAo3Jv7kJh3yHevbhu84Qwz8ZLAPSOA
 HpyP4OdzAR83D5JD2EMAXhtU7OYt8QUrx8JYFPxtDzOP8urXoffZxpFg6cygXJHLVQfIM1auCkl
 cNyVOLZSBzzx4E1JOlSH+EpDLNYOUQjYSa6/XV5/kEmPB/sD/vi1TIPYN0UST4plS22Br2WSbp0
 dzc2cwsTOmpFZj4n1A1BJcX+9t27KbSljLfqklkc5ar6W+oH5szXo8k/ezBjlWvB62haLDuaFhq
 /BSIHboOCgAIj98aQps7ysZ1bRqY7w
X-Received: by 2002:a05:6808:8185:10b0:467:13b5:8af4 with SMTP id
 5614622812f47-4675753d54emr301289b6e.37.1773347654806; 
 Thu, 12 Mar 2026 13:34:14 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1f95:f82e:8747:8137])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5e8185sm6276286fac.12.2026.03.12.13.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 13:34:13 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 12 Mar 2026 15:33:39 -0500
Subject: [PATCH 1/3] test/py: gpio: remove unused imports
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-test-gpio-cleanup-v1-1-bcf549671eb1@baylibre.com>
References: <20260312-test-gpio-cleanup-v1-0-bcf549671eb1@baylibre.com>
In-Reply-To: <20260312-test-gpio-cleanup-v1-0-bcf549671eb1@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=560; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=29O5CXDcRsyuicC71tsdq9zQIICOVA4lUi97mpBFUQg=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsyMvpMNfv1A41JXCBgx4uaEnsxAXQZVQUy6oT
 qG5nZzu8feJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabMjLxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AQPEH/3j9xtQaaSZKghBLVDJoCY6Il5Jga+rlDU44bAR
 otRRxjMmWDDnwcU7HXcFj/wDllqaqJzsmGjnHBYNtbUSm/uu02Z6EekS9lsw6Yzj0/57CgGN8oS
 VbSMpWJiUArHqsIijHzvWgza3bDhpssWKRDts8SNqnO8xcugOHN5AaYio+FxvLO2BT+9CDA6WZo
 T93GVOYzolznL6UwvhP7jIe88+TRHvqB+T6N981sBHfkjJvyNwonGmsEyfQ88roWxLttPRPX9Ia
 I2BG4kLWtS4occLnBsoiLgN0kUYpJLzW9jR2u+SJ19Pe53+Kv0xzBTk3HcD/RpN52lFdHWBcjpd
 MOOc=
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

Remove unused imports in test_gpio.py.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 test/py/tests/test_gpio.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/test/py/tests/test_gpio.py b/test/py/tests/test_gpio.py
index 46b674b7653..2d4a708aa84 100644
--- a/test/py/tests/test_gpio.py
+++ b/test/py/tests/test_gpio.py
@@ -4,8 +4,6 @@
 # Copyright (c) 2020 Alex Kiernan <alex.kiernan@gmail.com>
 
 import pytest
-import time
-import utils
 
 """
 	test_gpio_input is intended to test the fix 4dbc107f4683.

-- 
2.43.0

