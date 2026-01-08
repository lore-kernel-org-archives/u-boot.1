Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2DFD1D461
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 582B98423F;
	Thu,  8 Jan 2026 15:42:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QvgyAy6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11DAC84221; Thu,  8 Jan 2026 15:42:50 +0100 (CET)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD4D584221
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x444.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so2514841f8f.1
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767883366; x=1768488166;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A+QgA5HU37c8RSgm34/q6zjUDh0P7GnCWMqieS1bS/M=;
 b=QvgyAy6UQAjWTrvxXFRUMZ9bbjGMB5fE3Il6XylAh5VrlZStEmuYdTD1GKlR/7iCMO
 69ZF+DVtiR0YgTi7dzAxcpf0ngsB0vPMCaP1K9VyygPaGkp4oGHLjnzRW5hQ2IYjNbBS
 aGv1Z2++bqGFjlfPP5mtaZyf4zmMw/+vzM8s50gHE6+fMH6COO5srCxQSmCDZPCTp/Dt
 KDM9HvS2hS2fM9/fGAfI5as6WCK5DrsD+x0a4NtedzTvfs6UtENDKx+V7wX4vucw9S0r
 TgBt4rcXeydyQFs6eQJur7lL0qIyKTGesaSwNn0dI5gOlaD+2XVNsaY6lgG1Qj/txAdZ
 SlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767883366; x=1768488166;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A+QgA5HU37c8RSgm34/q6zjUDh0P7GnCWMqieS1bS/M=;
 b=YXiQVH79KlP9ZFeMCZCuggWOI6GWdqVTwp7XsotYsJnHe9Wtd5OxuZt/kXoaX90BC0
 hZH1SjDy6NWdQ9munkZip5jl8byXhPOQVRDsd12fGB0WwMYBDuL4oQ8ALcHCx4YCty1v
 3qjVmHjncMvYkPv3CN9AEQi6G+8CO98Thqx71h02IJ/E03ljmeMFczpD6n76UZzXN8Nc
 2UmTWI1dQqBcoZboOPkVF9YuDYfIh9wNG/HE9e/pkcmYsybFrLSg+Njet5jIPWlAptmj
 h2CQWP+92BhkQ64Pyr8v6f64yX3AofrD3dBo+sMFnVuJlVoGwJ516IGConyOwkEiuFen
 +kBg==
X-Gm-Message-State: AOJu0YxW6eZtAl74pPGCKccSDygWoyntVGLhls+xPu/fy9vsZ2sWJcSe
 9BV8iP7Cc/fqq8ePTF1sRWxMAFXI2vyAVsZCZI78KOjUnk4VJVFuwKXc4L+nB7U1JQs=
X-Gm-Gg: AY/fxX6J1za4pTJBsy3R2pQ6Z755h4E96ytFJSRPFTmMr4NB4Wo2nHaDRaVbv8yjidm
 eXA4UohR550lICtfP9pn6iIo0Wg6glQdMF6+xW4osH0YSt02vS/VngBs85BtSjS2/Sbd+X0m/I0
 AzbK9UD5vEckoPW11MzAmrzZr49lX+pP2YMA7Ivp71ACU3vvIa3SetDxWSwkJtIcnQz2pqs7ERL
 5Ag5izDVMK2CLna8O5WOORLKbuJwhE7+fsZZVmMNIz80lYJfJsLBwxcY7d+adR6iFcXlbSqDb5s
 PWULdnpw/BxGKgT43X0k2cvQfrnGn3NYYKHWpzTggrfGAEkzNxlTTz5UnU3rK6Zen7RnI0C3ofj
 YiDcHKhfJCcXtIFOuwCcV3acXK3fw/1kY0voelRGA+n4jeHArlkRanEW4iqWRxWefRkF3vM4/jt
 ByPr9369TdAciaMU+IgfIuo7tx3wB3K92oJXmlMhh48sy4mFLdfejJt9LrOGP+Vi+Rky4whXZUF
 sEzdTTN6Vdm32zGJqw=
X-Google-Smtp-Source: AGHT+IFooCpd01rhEsXv50lA414aZRCv+MQn49AdgjxfJbZO4k5n4tetdHrkCgy1IY/qhmx9+jpDSQ==
X-Received: by 2002:a05:6000:2007:b0:42b:396e:2817 with SMTP id
 ffacd0b85a97d-432c37c86c2mr8599748f8f.40.1767883366313; 
 Thu, 08 Jan 2026 06:42:46 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16d2sm17431760f8f.13.2026.01.08.06.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:42:46 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 08 Jan 2026 15:42:48 +0100
Subject: [PATCH v2 2/3] power: regulator: common: use dm_gpio_is_valid helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-power-regulator-fix-compilation-v2-2-b00cb3268059@baylibre.com>
References: <20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com>
In-Reply-To: <20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com>
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

Reviewed-by: Peng Fan <peng.fan@nxp.com>
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

