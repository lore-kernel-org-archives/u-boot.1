Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8B9D44C54
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 14:30:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CDB980325;
	Thu, 15 Jan 2026 15:30:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sy5db5WF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D43498388D; Thu, 15 Jan 2026 15:30:50 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B5E082BF2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 15:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so9625475e9.2
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 06:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768487448; x=1769092248;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=anRbz1EUlWTH/o32DNS53qBJtTDEEOJFXmKj3wwq6M8=;
 b=sy5db5WFDixqRH45bf/RLNd/xP6C7L0/Z3pE3t9H/3x+EJAFWXmeqULup4Twu/t39X
 pjQbGEwauqT5deXKp1BOSd5n+XieVWQbkRH/TpDdg0OoZv1014kBiV/bxBd1OR6tx5cS
 PxyPIppZrkLYKTqWyod0zVR5PuLhjQNhxMhlVldKtIoqoG5i1FvSLvjutcPlCmQeW/XB
 U8xu0AGS2ZljdZCML7SWvYIWl0Ugdr8+sD9YZCq9hqbQkl3w4LClSbMuU581te7LNfIu
 t2TAYNTjvRqbozXeeBAfhfxgMIDKsU3S2xa2mjSZBE73abXXFQqHlt3N/wI307HR1+AD
 xeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768487448; x=1769092248;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=anRbz1EUlWTH/o32DNS53qBJtTDEEOJFXmKj3wwq6M8=;
 b=lE5NWX5hLdvtB3OIy2jQQ0WkNzRSGAM9hnNzUyID0L+HkqOm68kcgckBAjJljFMn+D
 v68FaUo24xbz+Fh6Fokz25+/TcKqFHf8nc+V9RZFB0wMs2Mduc6puccv4qgAWHwphSNJ
 YA3qxAH9mpJ0d8p4pmpe9R9jbNb1Vsy1PLmjj1yS3Ni9OkaWnRouoq06LZQ6VqLaZxj4
 O/ypzVUXRLa3y/dmvsYVnYYXPz3tCPndUx8VCReTTLRAmYe/r0zrF6LHAJZf4h5TNEHO
 jg86aSF3E4UGwNJ6rzx4f7sIoS4J0COh1dyGyLqIQhxnRl7ZodJ0erb84iRVWOPK0AT2
 y6uQ==
X-Gm-Message-State: AOJu0Yz3pmlMliU091C5TxdtH4QMU7L+DizTf6ip8UuOoVLgNSZfwChp
 oznKsMlkubKGwI/wdLuoUIMf4kFA91QlBkNiL1ths0upr77cSONtKGZIcsvVCNqw0Lo=
X-Gm-Gg: AY/fxX5sxqBbILjwTe6dCdFv6zGY5WJTga3Wt6KdSnymVJuLleNVf8L5Of1SD7ZvhNp
 ATj6Ccct3d9YG9fd31KZfSH7RXCt0BqOla8Gs6EiJqTupbGTPwgklHu8orHpbnyY2HuaCh7Hqpy
 j6E0oG45m6JVGCFI6uceNLVhCFUgjhtsTlVxahnXel9z7WGRHFTHDI/Wfb+cB4h7bqvSKAUWobt
 KjtfdnlFWT/SchcD6oLoTwrNAi/Rs/GxQbJZNCc9RqKxon5DKkg5LJnat7kB/WbGbPBVq5N8UjK
 qJ/baFpFr8kAnxDSnul04qEuJZ2yZBWoI8EGeAZfKelQqcWUM5yp9fSlYsXlVLfSu25n5+jCZUI
 qyi3kCtRRw1KFcDpqJttreAbNhh8ZCGVBaWGkq4MDgskEN1dIJ/Ye3F8352JtBsJzYDkKyFegbR
 QvNzthAafQDtY362OVVz9z21AkazKbKzRp3112UZnDvjl/rVG79JaFZPhwWSAooQlOC03Qr/cTn
 8CM9XkGeQ==
X-Received: by 2002:a05:600c:8208:b0:477:76c2:49c9 with SMTP id
 5b1f17b1804b1-47ee32e5ab7mr70214935e9.2.1768487447841; 
 Thu, 15 Jan 2026 06:30:47 -0800 (PST)
Received: from [192.168.1.62]
 (2a02-8428-e55b-1101-a95a-db72-930a-81eb.rev.sfr.net.
 [2a02:8428:e55b:1101:a95a:db72:930a:81eb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee27ee45bsm47149925e9.7.2026.01.15.06.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 06:30:47 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 15 Jan 2026 15:30:43 +0100
Subject: [PATCH v3 1/3] power: regulator: common: remove unnecessary debug
 trace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-power-regulator-fix-compilation-v3-1-08b329543e13@baylibre.com>
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

Drop the ftrace like debug() that checkpatch --strict complains about:

  WARNING: Unnecessary ftrace-like logging - prefer using ftrace

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/regulator/regulator_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
index 685d8735fa5..ce3d80670de 100644
--- a/drivers/power/regulator/regulator_common.c
+++ b/drivers/power/regulator/regulator_common.c
@@ -98,7 +98,6 @@ int regulator_common_set_enable(const struct udevice *dev,
 
 	if (enable && plat->startup_delay_us)
 		udelay(plat->startup_delay_us);
-	debug("%s: done\n", __func__);
 
 	if (!enable && plat->off_on_delay_us)
 		udelay(plat->off_on_delay_us);

-- 
2.52.0

