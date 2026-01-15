Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F357D44C54
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 14:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 846E383623;
	Thu, 15 Jan 2026 15:30:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dj7oBiEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41B5D82BF2; Thu, 15 Jan 2026 15:30:51 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5129280077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 15:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so6217385e9.1
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 06:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768487449; x=1769092249;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+OeN+z8QIrh2ZpcUmf9cLYjyBb0+RY6QhsgFo5DjHag=;
 b=dj7oBiEn2+3AIncjXEZe7dREF2BkqzON/VxLyHgqXaV0bbzFXyd1ypE4XRzayXnRxu
 9Bq6gLDYSl+rm4oaL4G/Zu5xosakgbMoWDlLvLWVGVE5Nar6OngdrXKb9ZdWOxcIOWSl
 sP1eZGyhZMS/3Pp4QCBZteSLPQdy5fyhzJUraDX3L9V53TYMcMLmCUROrdcDW5RU+Njb
 EwWYAFPc/E8uw5M5YRxLd4GNFipjVVTlOPzfbhX+jGK6VVJoOJefGjnknCkVw4Mq29Ut
 vIsbiyNkbdYQ+gPYau1CqsFwr1CIoX3BTW2XYwJTJt4nWJbvc9ESsP9Wy1p9esgDYq+2
 ffNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768487449; x=1769092249;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+OeN+z8QIrh2ZpcUmf9cLYjyBb0+RY6QhsgFo5DjHag=;
 b=YVNHbQiu5ruDqRqpiu2Sw6ZW3ML5SMackZQ4TXBmhgfpHAlRk5IQCK7Unnyd5jH7Df
 xnHvLrAebA8986i2VneE6ZPDxDSicwWiTTzRGAcAft/+SUxgERla2QxR2dDYdCcP6BzU
 trXZ3HJEfff5it2VpvVQ6Kq3j/0JU9LL5kxvkJjuNbOqjjIM++jw8qU5npMP2lykkza6
 3qhk/ngjqgkMZSbAUGOpCq9gfUUmtb5pqQHgCo4HMi3k9PsczmmUpx8zcI8FTZ/RV11M
 e/wH5PnYYrviLGvSatx1ETk60bGDav/KvyRXv6oByrGiNYzcRc7X1Oe/8gtrb1sRCixl
 tX+A==
X-Gm-Message-State: AOJu0YzqzqN/8oCfz134o0/NZa0KFA96S+AQOVpf9V/p5btrAp5D2nos
 CDapdOWL+cssewUA2sTj3i67BdUiCJX3mSWAzhCPHtMhafVIddhmIyh6dNm9WanTMn4=
X-Gm-Gg: AY/fxX5Qn7/Qw3CjUmcGSmSgcGzKyifijgXeRtbKrhgU1TC7Wd2VhQ7MBeTj8CLUqhS
 3qA6z6GuGeaknvAxMMC8v30S53AulyBDpBPcs/95Iq980kygbOMyyOpE6TYkHRN0CEDZwPlbqkH
 TJJMGxB9lG5w+rN1Z6AfSlU3iKLEu8DH1LU9JxecdG6XTF6oI7719UFcMTTIfT3UexVSliyKjHv
 P+EfrBNv+kGKW1XuwohnYEXCLHneuA5sG67f68tzMUkR3+umbmeOF/eHwy6+AhU7tN+Q+l7+FGG
 45Z/rzPunfKpFS0xbzzmV9O4lDldHmN+wYrsS8ACHvSPEBPpHLOiQ7byOnFK8t6l6L71mw1Qwzi
 fVVo8FzNS53bEQgnZnpf6dm6KA4ol7ozEpAst+lU+lfngS0sXzDZc1fNvp/A+441yqGmGFXls7R
 TddXJfU/IuqpMTJrLdIMaNRZU6qmwEhS1ZuBDqEhVpCcnp75KCoY3hpBKO76EIkFxs84bvY1ddW
 dQo0QbkKw==
X-Received: by 2002:a05:600c:6218:b0:47d:18b0:bb9a with SMTP id
 5b1f17b1804b1-47ee33997fcmr80955255e9.33.1768487448720; 
 Thu, 15 Jan 2026 06:30:48 -0800 (PST)
Received: from [192.168.1.62]
 (2a02-8428-e55b-1101-a95a-db72-930a-81eb.rev.sfr.net.
 [2a02:8428:e55b:1101:a95a:db72:930a:81eb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee27ee45bsm47149925e9.7.2026.01.15.06.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 06:30:48 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 15 Jan 2026 15:30:44 +0100
Subject: [PATCH v3 2/3] power: regulator: common: use dm_gpio_is_valid helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-power-regulator-fix-compilation-v3-2-08b329543e13@baylibre.com>
References: <20260115-power-regulator-fix-compilation-v3-0-08b329543e13@baylibre.com>
In-Reply-To: <20260115-power-regulator-fix-compilation-v3-0-08b329543e13@baylibre.com>
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

Use dm_gpio_is_valid() helper function instead of manually checking the
gpio.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/regulator/regulator_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index ce3d80670de..cf98998579a 100644
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
2.52.0

