Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52BBD3E77B
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 21:24:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2143483CCF;
	Wed, 10 Dec 2025 22:24:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vJ7L/0H3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4266983CD2; Wed, 10 Dec 2025 22:24:31 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5739F83A91
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 22:24:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42b3c965cc4so127542f8f.0
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 13:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765401869; x=1766006669;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qb0sUO20JmLINMvWg9zP8LlMQVa1eM1OnZBSv9luYrA=;
 b=vJ7L/0H3yYumgfkOS7QSMeOhijLCUqNvqHJQ8KyuRb+zsvxlXNBvq195YzyncdPLUS
 O/YULTh6Lv9YKXy+MP4kqA7C5150qUMlauigULog3+7s+17AB9JVK7e0dKGOGI3zd1D9
 ULhn9DRH9uPsin0PXb/bXZ0R5r14KBzGeda8i+42jwwPTy1wprWTiuoFbI/dcvrUnu3D
 fYyxyT1UdOkxibqRmHHWztUxImSjHbV81keMmCDDXgioU/7vf/U7BiCPDdf++sBnk0cd
 P686vsnP/Zxn6NuXqiruuhmIxcQAhShII9c2+jn6JE+DK4ZP3AQERBhUs0tLi6G2zgpk
 ssUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765401869; x=1766006669;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qb0sUO20JmLINMvWg9zP8LlMQVa1eM1OnZBSv9luYrA=;
 b=lGWIGrG54jS4xL8H+y2MLxzLUrwg+Bp/UF1EhSatDohkwMcIidPbjtkO9OjPlWCLbu
 gEhePzF0hpDcf6AwMYcxw86WTLYRgIwC5mQdM3d6l1Q5KnDP1eTLj0/PipSlFmTuE4Lh
 2BpdEb1IELSZu9uThkGZD2sTPS61kQ/1nE2Wel5uHsIuG0LAmg8u+jLykFMo+s7EOtcx
 sdLQT79eqb8RVvR0+GU6NUgYoXSENuN+gs+tq8Po/qm5boEjvtwfDq+C7T7sTRzMAXAx
 mjz1J8eRaDsZMHNV/+Yl/nA9BuyuK26bT1V1yPW0BsX78jiP4AjaLJBV2+M3pWYVSAi1
 BtBw==
X-Gm-Message-State: AOJu0YwWWCJ1KV96Z0Qqt4xhZrga4OBlqbsr0/3CfqTLyiArtFm7V6ef
 X38mqeM9I9jLjhAjXZpSTfhXiQCVHJ8yskSSHjOd3ycI/VTmpYcD8lEuKHOCzGwOC2s=
X-Gm-Gg: AY/fxX5TfsM/5Z6sDvUvvsIcyPsBAcRjpn10TDVbf2LlqmEXNR4/Ul3fQM2jgALeRvh
 T0/X/v3k8i2nO+D7kZyBBmeUzuyUe3XH138zX00bgkbGKFddb4D+o6mrY4lBcFthyie9OBH0wzh
 S0N0fj0wnsEYtyqX5f2VUnNGLUcG9SwKu0oG1Q+cULQk316BbA/CycOH1gm9E7r78iEVlvCpEl+
 J+HNYlHL7kFX3yY8jA8+5xc43+4l3su3xtDDTaxQywFZJzswl/zmSOvDtDRAQPMrXaiooJ80p/R
 LCDVKgGbTLyVQ8SRcprzDpQZ+wQts+pO7/bj0wjSAYL2PDbqaaHPm+OIWef88meNaWfSeLIbXaG
 C5SEeNVwFlmBQHK/U7Tc1DJ1vnIIFiSApOY13BiU3VavRSfIhrN9pkmUIg68NcpjsPKkHN8ghHZ
 os8fnZFCFSrmO9J4eCIGGMCOEJ+yWrqk3YprGJY4UVlQjgU40cRuowQr9eyBIIwGMP9gMKpI8GQ
 bK4FyIKeSSawGlZhqlq
X-Google-Smtp-Source: AGHT+IHyelsjOLRIqcFDj4VIfRS+BYoLuXs0ULFWj/aerBQupOh8kItQiAmcG9J3IUZabULLnh4rmQ==
X-Received: by 2002:a05:6000:2485:b0:426:fb27:974a with SMTP id
 ffacd0b85a97d-42fa89f7345mr777240f8f.27.1765401868668; 
 Wed, 10 Dec 2025 13:24:28 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-f92a-5586-f2e9-b313.rev.sfr.net.
 [2a02:842a:d52e:6101:f92a:5586:f2e9:b313])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b96c70sm1122254f8f.37.2025.12.10.13.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 13:24:28 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/3] Fix compilation issue on regulator_common file
Date: Wed, 10 Dec 2025 22:24:21 +0100
Message-Id: <20251210-power-regulator-fix-compilation-v1-0-c58f01e0a5c3@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAXlOWkC/x3NSwqDQAwG4KtI1g2MkVHaq5QudBo1YJ0h4wvEu
 ze4/OB/nJBZhTO8ihOUN8kSZ0P5KCCM7TwwytcM5MiX5J6Y4s6KysM6tUtU7OXAEH9JjNZFTxV
 1rqp9aDqwlaRskfvh/bmuP2mqBrJxAAAA
X-Change-ID: 20251209-power-regulator-fix-compilation-5232b0365c7b
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Ye Li <ye.li@nxp.com>, 
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 David Lechner <dlechner@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2
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
Julien Stephan (3):
      power: regulator: common: remove unnecessary debug trace
      power: regulator: common: use dm_gpio_is_valid helper
      power: regulator: common: fix compilation issue

 drivers/power/regulator/regulator_common.c | 89 +++++++++++++++---------------
 1 file changed, 45 insertions(+), 44 deletions(-)
---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251209-power-regulator-fix-compilation-5232b0365c7b

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

