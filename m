Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABEBD3E77B
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 21:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E146683CD3;
	Wed, 10 Dec 2025 22:24:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OAno39Wp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5028083CEE; Wed, 10 Dec 2025 22:24:33 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C59783A91
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 22:24:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-42b3c965cc4so127563f8f.0
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 13:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765401871; x=1766006671;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ovbTyUN5XoS04YkCUk0gP+hx+l3gOqC1j041Jx0EObY=;
 b=OAno39WpIDGN3U6xMlqn7VeTsU2kRsW5Q7Qkge37IPTuYMrBJqioya1tnQe6adYfgx
 mWyJotEH4c6VxCBuhrsRKWhgvDYsLIdHnw8Z+l54WxYuFRQ9Pi5BWDQ8t/6l85hHfGBL
 w43sRmU4C55UPsgsRmsXiwvfDU1UzXhO7+L94SK7ktimYscinjW/pNoIYLLoWrzRNGEO
 8WUDzGIH2s0uoWdp1fGTfGTBL+cRqAfq682Rlbt3wul1t1mZazmUX1dwZNEG6Y7gNd0y
 MboXeASb1pADI/L69RIQhz+FyCwoCn1UD/kPBxXy7yq/F0R2kUjowCebLqi7k69Kuz9e
 D2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765401871; x=1766006671;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ovbTyUN5XoS04YkCUk0gP+hx+l3gOqC1j041Jx0EObY=;
 b=dgLQ1Cp4izlPTPsvt+F/KiMwbYWzkr3ZlaRHxp6cciUAO1JosHfEI+46X6agS5gPya
 DWD8KAC8vX3RNUCP+AaiOAjteDXnoWgojy/S5hV7Ze0zjbNDcLvSYuHnELRKngKrYxwE
 WI4tLkDsviF9u0iixwJ5JLblQlQHE1KH/P/Ze/De82X5Qemgwg4+SzuXck/e1SBzTdFR
 f4Rt+/5OHe5tdFdW0LrzCfKgSqPlV4RB9W99nWvohLQ2B54OqiAgvIhXfwtOEPLpvD7d
 hllMR1+zwtRpxtsgig8rOcLttJUpq6tRjUp+q+FVUWunPfm7t8vLqfLFuy/BnIvu4/wm
 gBGg==
X-Gm-Message-State: AOJu0YwNnQEy9RRlIX7meq5UaQNw5wStxC+uDsj/zcUg0Nx6BKySFhj7
 huazIZHS4YETzFCzYH/JjW0JjbwDFipyUKwZ+FcLOIckW0M/ANnJs4RxzFWPygUfmtA=
X-Gm-Gg: AY/fxX6AGV43YfM9Zrp9oq4kLfxJxJXkay8FCHQGxxHCsAygZOoEyET6m+oXZUiCD3S
 /5TAGearUkmx6pFtPUb1XH06USHzkkmzkU/eItUhX0bdyuaeP4LQ6qSv6LD/lLzLHjalcZVzTIM
 C8yGBN2ZmmItUfXejgwZ7CUx6U9dNsnH5AcE+FwNVU/0O8wAPiD3hkRk4JlwrhxGWY+Ot+hApH9
 1KXfX1Whpcc0VHjM0in/EUiGZbXQ1HLpJE1E6KpiUetRo5QoR+GsIW6/THu+2l5suz/8Bt/2f17
 QZ6tJczMkAe06DGmlrjP4NEPoh6nXUjWqePeUv5sN0/6Vykc93tkXftfuPvLgr5hkwqwwNusnes
 Ne76Gqctp6SqA9bai0CovS63UqqHFKC7jNY2p+46rUaqe8gVHyaak3PR1NPKPq4EquzhFs+nYhf
 7VbC8EZQJfG/wlQfk/ayVFUoMyHkV/ftL891HqGtTkF3lDFMhPn5MXytgZp+65nObmFhBPLPRIx
 pnIolhCpg==
X-Google-Smtp-Source: AGHT+IF4zfN+xjIuJXsUIe+fwrzWUGFpQQiA09lkiD+uWWndxh5JNkZyrugowlIE7aw/3WFfV6p0/A==
X-Received: by 2002:a05:6000:2dc5:b0:429:ccd0:d36c with SMTP id
 ffacd0b85a97d-42fa89ec3d9mr827876f8f.14.1765401870325; 
 Wed, 10 Dec 2025 13:24:30 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-f92a-5586-f2e9-b313.rev.sfr.net.
 [2a02:842a:d52e:6101:f92a:5586:f2e9:b313])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8b96c70sm1122254f8f.37.2025.12.10.13.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 13:24:30 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 10 Dec 2025 22:24:23 +0100
Subject: [PATCH 2/3] power: regulator: common: use dm_gpio_is_valid helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-power-regulator-fix-compilation-v1-2-c58f01e0a5c3@baylibre.com>
References: <20251210-power-regulator-fix-compilation-v1-0-c58f01e0a5c3@baylibre.com>
In-Reply-To: <20251210-power-regulator-fix-compilation-v1-0-c58f01e0a5c3@baylibre.com>
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

Use dm_gpio_is_valid() helper function instead of manually checking the
gpio.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/regulator/regulator_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index ce3d80670de045dde7e263c5301bccd744abd2f5..cf98998579aa8a3cb7f09dccd2124207a58d8b00 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -51,7 +51,7 @@ int regulator_common_get_enable(const struct udevice *dev,
 	struct regulator_common_plat *plat)
 {
 	/* Enable GPIO is optional */
-	if (!plat->gpio.dev)
+	if (!dm_gpio_is_valid(&plat->gpio))
 		return true;
 
 	return dm_gpio_get_value(&plat->gpio);

-- 
2.50.1

