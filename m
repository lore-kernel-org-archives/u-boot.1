Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F7DCFC296
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:50:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95E8D83A41;
	Fri, 21 Nov 2025 18:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1pvgtdEl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73BE983A5A; Fri, 21 Nov 2025 18:37:01 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3891E839E8
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 18:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4503ee5c160so926275b6e.1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 09:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763746618; x=1764351418;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b7+byumtapao8HYxRkDCxJU7UXbQ9UBBbMszCwTzf6o=;
 b=1pvgtdElS7NCvVU4Rgzu4YwRR2ocV3vNSjUVltKxaLZFFaCmiPbdULNL/SYnSdfuBe
 WT/yNVEV/t9jbvohPLk/XgyD8qp1aJDHxzuojbNhhQf2XbAk66+rBQkL78z/Dpr287cx
 DtEjYEM0VEwUcuXOEvga6pN13ggevsmqyczJ9IW1wBQA2mH3uZNBOWSn5AU+68FieZ/b
 9OCsfJhKDOS3R4nrvMmJeLNb5DKEw8v793Q2jlbnIF95XO9+eOfqYIV1Tux5kPd6Tphl
 7k8bMU87RxAZffccsRWW7haty9FJIuO8oHe9dUmEOEOy27u3bu35y+GM6nkOT/KBNwbD
 5j6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763746618; x=1764351418;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b7+byumtapao8HYxRkDCxJU7UXbQ9UBBbMszCwTzf6o=;
 b=AL12zlh8MWwdoMdaD9U6WFcXOeUFcrDsne0EMFaEl3hPRSAhS00UPqEQpe5qGv8cDr
 CTDmcivjbPVNuxpb4XcK76gxvViE8zvRqLE9rydCIgWhjHlakXgj/HVWsT+m4OWBnF6A
 92J+vbmIdZRBGxkoMSOiMlVncxAqWc93MTQ50ufPztAPSG3aZBeIionrQ8K6HLgyWJgT
 SMcHN2w9+K/PQw/rLlSWu/yNn+KKNYdge4PVHSp30KjUt8QtGw6ANsPnXhxqxAxfogud
 uRS6yX3VYA/Ja6AA25PJBWVUekIWqx/rWfbvvZfruv4DFYGBNXLA3zTq98KZqQUcVJMJ
 ZqnQ==
X-Gm-Message-State: AOJu0Yx9Jolv34TpIThAQmWuf/nKSFI9GOXtazKPttHQ29zLPPQgfQwq
 udHmkI1AfXerjhgDgbAmZ/sClfAx/2nkWBc0a8p9gcACTQdqhaJZ+c70CJqkrpTLC14=
X-Gm-Gg: ASbGncvghQx2gn911E7F//92uADSo5tmiHwhR9cIeLw1jyAg4jV4P5TsEXxHHPQqSVq
 NYu6OzE8tTAdEpd57g4VM5LRIzz18pohbIHbrIxlBjyueiYT5T3kkxZS/mQehK6AKrIyP5/06JS
 7yXSnJVKJcRzar0r6O6WtFBO3nM8fgnE5fqbSIQJ3mHjJyb59FxFZHR+MdimoNDg4Vke+xaAIYE
 Z8xa01Yd8sj+DQH65sM1OSjkZhsMLL/iqyMBXez75ZgUEwnYuwC7XqBbXZ73AeVM0xkFoiYWRk8
 mugeEYupFkkP47+5gDyWDJz5vUeKBYoyTpct4QgNZs09CY/T7N8i2ZEzMDwqPonsogFurLRgTV3
 fPRXE6J1hY1rD0YW4LIaXfOBs390EWrKqJVUtJD9CUO30fHWtyv/FtXQiWfyIdgDV9Wdna/WDTV
 UypCPe40vChwgHfg==
X-Google-Smtp-Source: AGHT+IGMSv9345ITg628fwNX+75C/MnhHtDokqUHfbdvdO5YzwiT+uvvEIN1O32/7dROpKKiHSNVbw==
X-Received: by 2002:a05:6808:c1fb:b0:44f:7289:f4d0 with SMTP id
 5614622812f47-45112d1afdamr1581072b6e.67.1763746617973; 
 Fri, 21 Nov 2025 09:36:57 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:d761:af7:26f5:f16e])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-450ffe2d425sm1843154b6e.4.2025.11.21.09.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 09:36:57 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 21 Nov 2025 11:36:49 -0600
Subject: [PATCH] doc: pytest: fix u-boot-test-flash typo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-doc-pytest-fix-u-boot-test-flash-typo-v1-1-41faecbf72e9@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADCjIGkC/yXN2wqDMBCE4VeRve6AST1AX6X0wuqmLogbsmmpi
 O/eYC8/+JnZyTgJG92qnRJ/xETXAnepaJyH9cWQqZh87VvnvMOkI+KW2TKCfPHGUzXj72WwGXm
 LitCEwDV3bd9fqWzFxKU+f+6P4/gBkvLKf3cAAAA=
X-Change-ID: 20251121-doc-pytest-fix-u-boot-test-flash-typo-f4ffe0e65773
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Martin Schwan <m.schwan@phytec.de>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=jX2znf2tc7XIe9PI8l5qehYlkpGjtLVt1sZPQToI25k=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpIKMyhjlybIjjyIF/HtJD5f+WyKNDtKQ/V7Tym
 jcG174rJ3aJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaSCjMhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Al0MH/j9xtvbkDqc9tCmGtOvzG50Z2PVP4FLdPGUwCiM
 0Qa497k0AyEQQATqREtBTb27ejHjdhNTSzLJdAbtp01dYkVZ7W3vNB4E2O2LwfOwfSpar0EseKZ
 UMMYa3k1E7PudzJoj7HxB+W5Q1xtR7bygrNR4KjUZZw2um2+er+jVOk1QtrrPo4PdtdppQcPcqK
 NracRLfece2pe4aymXVdvhsw5k3DKQcqqTTjKWJKV//74ag+bJflTk7DSWx5osGIzRo5ovJfxDC
 yhrtsb0kXW5qbyhFQD9ytEhWq14lJWhoGPICArlo3EtVaVsXhg34fXZZWPOQensVz6ms/jGUeI9
 BD9c=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Fri, 21 Nov 2025 18:48:59 +0100
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

Fix typo: `s/u-boot-test-flash1/u-boot-test-flash/`. The correct name of
the script doesn't have a "1" in it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 doc/develop/pytest/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/pytest/usage.rst b/doc/develop/pytest/usage.rst
index 800a0323d0ae34d739490b80124949517d2fc5fe..7335a39b9633bb16869dfc976adab32d78dc984f 100644
--- a/doc/develop/pytest/usage.rst
+++ b/doc/develop/pytest/usage.rst
@@ -392,7 +392,7 @@ to flash, pulsing the board's reset signal is likely all this script needs to
 do. However, in some scenarios, this script may perform other actions. For
 example, it may call out to some SoC- or board-specific vendor utility in order
 to download the U-Boot binary directly into RAM and execute it. This would
-avoid the need for ``u-boot-test-flash1`` to actually write U-Boot to flash,
+avoid the need for ``u-boot-test-flash`` to actually write U-Boot to flash,
 thus saving wear on the flash chip(s).
 
 u-boot-test-release

---
base-commit: 2bc0715b558fa1ac5c88b11e250740b16a905837
change-id: 20251121-doc-pytest-fix-u-boot-test-flash-typo-f4ffe0e65773

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

