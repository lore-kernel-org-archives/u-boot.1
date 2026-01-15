Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4D9D44C57
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 14:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE8D3836A3;
	Thu, 15 Jan 2026 15:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HhpbOcvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B89083623; Thu, 15 Jan 2026 15:30:48 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 290A580077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 15:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47d6a1f08bbso3604815e9.2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 06:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768487445; x=1769092245;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x8hM4SW4GzkHRFYERsRcmff1Z0R4q7c7MEioTQJTreU=;
 b=HhpbOcvHumEpnL7OblK6bryfIO157ntdTPZo4vrRbOY837zNZHIiV0W/SrAvJpWAzo
 Q1zCx8IpEgdFXYSi1U/grh7skJA4or5NYIjlR5oK11ydk2xponWCLKSdH9VWuWlyzAKV
 Q5TviwafNC9EUEaW00UgDJ5Lax0PX2q81TFJbIa9W2FhvqIIQRA2dZQ4gZIYLfjVQXn8
 7B8D/PRjdb3Ea0E0cSIfkx7tV2GmfYAkSjbSdYU5c07I7J9DQpvYFF35wyenaDi70WW0
 XKI0ktEvehCqtrY4pMmvZ7KFsbtrerJqJioVF1jWU7lcqE6ocCaOhgNZoZ3zpzpEUGzC
 4NJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768487445; x=1769092245;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x8hM4SW4GzkHRFYERsRcmff1Z0R4q7c7MEioTQJTreU=;
 b=PSVi8Cu5LWwuhNSvH4QGmm85S6gcsEvthOK7S/KvWuRdQmnUUmC1rgptH2MUvcxsbG
 ZAWHvfs5Z2YsBgSSliKNjA1VSDvqV08RxI5MnsEQO7Fd7/W1xpWntxV0/Ow/vOX7zy9L
 /QISRYotYKi1L75xMFBuHZJv9WJBX2lFaB+pChlSqVyijYZnIUtNWDiLPOeEzcGeFbMV
 T0PmQklrrUn5MwiYNX5R0AEz3Y+JbIj6AP5CG3yHTwpZZ5TgywDFdpch0O2TZTxHLqYY
 TfpVcU0ToG/VcXuOKK2z1vrvBpRHvg7bvilWEHCV9RbRGw87gMT0ZM8oml0OXf5hON16
 xn2A==
X-Gm-Message-State: AOJu0Yz/BNILdclPXB2QYoiQu7U9mYxBYCTnONyVhzw0d5C05EFHRBvH
 uL46gk2X8n71n7P9V9+69KLqyxOgZoQNKx0zsr8wryc9ttF+Gxh0Or+MUq/IIE0bYzg=
X-Gm-Gg: AY/fxX6/Gp7YNlOHBoFSMhFI2zCcJVur2T48b5l5S8Ev+zv1cbQ+9bnEJzjovkOg7Hj
 9cLQtDfR7SqYIwSPDKX33fvTVQ/OkLooHUgJncf8x/0/IAoM5SBLCBcukgpaUr0IqXRo/oR5HQ3
 YG/SMjqaUAzKhhmkPlDZ3U+pqhyWJhlTsnqxPjtL7qXbgJFRRjqo6P5K7gy51lWd4WsuBNynBVS
 zYSrF/H9v9COsUAkvQfr5YLmHd+JWI1YPeIclvfAERatfk98hpVZgm7hDKsrmJ+JV3GrvhHJWv7
 JZMR+t4YBSEUSxBitdPDzrsPLtmGs8nu0K88tNb1cv6GNICswk4Mn1lQ5Vyu6Gp5ZV8oyok+ApB
 RBqotbOIMB+H7p/QpavbaAd+JMgPBJA66FIn0CmU2XN7pdpbwy3J3czvl6aTuD+rRwgM1SfUPuE
 3GJKFjwkwu5/Vj58o1qB5paM2sSfKETRZAMyUJWYp0bessxxacyjEzS7EATJTww3G1XrPzs3RM3
 3vjCUY+wFiGCgA0FAP7
X-Received: by 2002:a05:600c:c0d0:b0:47e:e78a:c831 with SMTP id
 5b1f17b1804b1-47ee78ac9e2mr46817625e9.36.1768487445504; 
 Thu, 15 Jan 2026 06:30:45 -0800 (PST)
Received: from [192.168.1.62]
 (2a02-8428-e55b-1101-a95a-db72-930a-81eb.rev.sfr.net.
 [2a02:8428:e55b:1101:a95a:db72:930a:81eb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee27ee45bsm47149925e9.7.2026.01.15.06.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 06:30:44 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v3 0/3] Fix compilation issue on regulator_common file
Date: Thu, 15 Jan 2026 15:30:42 +0100
Message-Id: <20260115-power-regulator-fix-compilation-v3-0-08b329543e13@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNQQ6CMBAF0KuQrq2ZtimCK+9hXLR1gCZISatVQ
 ri7A9GNG5d/8v+bmSWMHhM7FjOLmH3yYaCgdgVznRla5P5KmUmQWkio+RieGHnE9tGbe4i88S/
 uwm30FGnLtVTSgiq1O1hGyhiRKtuH84Vy5xPNpu1hFuv1Ywv4a2fBgTtdNSAQjHbqZM3UextxT
 zW28ll+yRIEVP9JSaQFcFbJsgJd/5DLsrwBWNy7giQBAAA=
X-Change-ID: 20251209-power-regulator-fix-compilation-5232b0365c7b
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Ye Li <ye.li@nxp.com>, 
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 David Lechner <dlechner@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

Hello,

If CONFIG_DM_GPIO is not enabled, compilation of
drivers/power/regulator/regulator_common.c  fails with the following
errors:

aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_of_to_plat':
<...>/u-boot/drivers/power/regulator/regulator_common.c:30: undefined reference to `gpio_request_by_name'
aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_get_enable':
<...>/u-boot/drivers/power/regulator/regulator_common.c:57: undefined reference to `dm_gpio_get_value'
aarch64-none-linux-gnu-ld: drivers/power/regulator/regulator_common.o: in function `regulator_common_set_enable':
<...>/u-boot/drivers/power/regulator/regulator_common.c:92: undefined reference to `dm_gpio_set_value'
make: *** [Makefile:2029: u-boot] Error 139

Since the enable gpio is optional we can conditionally skip these calls.

While at it, use dm_gpio_is_valid() helper function in
regulator_common_get_enable, and remove a debug message that checkpatch
--strict complains about:

  WARNING: Unnecessary ftrace-like logging - prefer using ftrace

The 2 fixes are done before the compilation issue fix in order to easily
cherry-pick them if needed

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v3:
- Picked up review tag
- add back dm_gpio_is_valid lost during v2
- Link to v2: https://lore.kernel.org/r/20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com

Changes in v2:
- Picked up review tag
- Use CONFIG_IS_ENABLED instead of IS_ENABLED
- Link to v1: https://lore.kernel.org/r/20251210-power-regulator-fix-compilation-v1-0-c58f01e0a5c3@baylibre.com

---
Julien Stephan (3):
      power: regulator: common: remove unnecessary debug trace
      power: regulator: common: use dm_gpio_is_valid helper
      power: regulator: common: fix compilation issue

 drivers/power/regulator/regulator_common.c | 89 +++++++++++++++---------------
 1 file changed, 45 insertions(+), 44 deletions(-)
---
base-commit: 141be72e2a9d43aa4e3d1a6a6e0ab8f9eb8784c6
change-id: 20251209-power-regulator-fix-compilation-5232b0365c7b

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

