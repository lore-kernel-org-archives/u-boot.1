Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10146F99C63
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 21:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B8383BC8;
	Fri, 17 Apr 2026 23:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ei3gKI5M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC3AE841C8; Fri, 17 Apr 2026 23:55:37 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5489B83015
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 23:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6830f4f34c9so669429eaf.3
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776462934; x=1777067734;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOYqbvVAHLOunxAkov+ID5rC/2n5xkIXcbCX+L70kgY=;
 b=ei3gKI5M9a3FFsXo7m6LMnomDHCMoAJDaaQe9O8kWAsrSnbQCfaOR4Mk368dBbE/Mk
 LqZwu49gieGPi7Cd8xGo7hDifXWXcLA+QrKQIQd52Kz6LmNnRqm6AeFQGg6b50rV2R31
 Jjn+WIUrApgc5k+PEGGIKH6FlucQORzJQj+j3Nqmg1N4FjC6n4/ewVaFRYkQeWG3YwkZ
 K4aGfz/CYfOGa/JBn+dDl/olXJKkyZEbu/Ee+JqHzY+jx2gZw3klkV2Ty1opvR0GKW2L
 IUS8sOPiUwiiJ19Z08kBljOwGxVd9y+VERXAPjvhzv8k5BIH7bEZno40hdu1CIHOQ2+c
 ckUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776462934; x=1777067734;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MOYqbvVAHLOunxAkov+ID5rC/2n5xkIXcbCX+L70kgY=;
 b=Z24cvZHYs3f0QeeHqvEiwx5GiIYMPp27kHPucyTzElVf1HRS/uxPZPz+9z+jtHM0xM
 8/cY3SwmINs52M5795UdMBKVYNMo1puvFrwLjBWFnebkO3bR5cIu2V6dNG5f1cDy0kuE
 D9kmTtn8cl4QWS1UwYOBk2kFOrfPdPJnSIxi0MY+gh5lYnLUf7PvmZklD9S+zkHWlMko
 dOLVo3Kwng7ACCjC5cF7wqFdnfWYxw8iEFAzm2wvlZKQUuA9w2Pg9P6k09BODp/YqciI
 EfPa/YSEWDPQatlIaq6J1GlsxfKqcQmmkOACpoav9MQOo4JcN8nPn3LF4yRmz8qS0oWo
 QtJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gUUfpCml4J7dYNuB0jiz1iGgErzXHJYzH0m/ypXQdnwGpz7rJLWMI8OMcm2gNEfe/mLkAOH4=@lists.denx.de
X-Gm-Message-State: AOJu0YwTm3wek057uClMyK004OZnUotN8M1wYc5s+CWwThS5FDM60tyJ
 NJ/9n3BtD85z5EDt4StC1Xp/ikzecVakYZO9+fFERE7qv6uKCQcJqXwK/nTOMbz5OkU=
X-Gm-Gg: AeBDievngxoQfWLeORQ++/tAbpg4K5Jn1HPQ7U/8ZfrYG61fwiRnD62uez6ZH2z5JIb
 P3IcbCH/YVVL9AA23Z/zU62digsBt4THYU2LtVYheu2HMUoH37mEXdsCuk7cxbn2lXID1H2V91M
 RXx99M9fI8OSFChe/46wdS3P7KOtsbpBx9FtQ6m532m2ZXsXHpC2cvNld0OoM1VEguwZsze4Xz0
 B3DYczIHBliPpV3vt8uDyH5QEFcT5CDGQxt1NPb2PthJIwFzoQfV0Z7KakUb17ZCb6IS9yLMFO8
 bMg0xhatyfFZpSa0v2ttVHNRbtDKXzFssUbqPOKqNk7/sKcHVYEDDcM1dSu+E5ePuPh4r61ENMp
 XpgIn6iB0Pq6sFrgc5L3WrnDKz/Q8nsaUxi7CqW/vT4500t2FAgi71kgD5VrSWyBnEQP98ide81
 AkIGFduf1G95KI6/82NTTX3kmwF6bzHmVNrAQFAhE8RnV5SruE
X-Received: by 2002:a05:6820:290e:b0:67e:1b5c:8761 with SMTP id
 006d021491bc7-69462eed682mr2834074eaf.44.1776462934081; 
 Fri, 17 Apr 2026 14:55:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ef27:3314:b886:cd3])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b93046dcesm2514420fac.3.2026.04.17.14.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 14:55:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260401-mtk-mt8189-usb-v1-0-a4bf951aa8ad@baylibre.com>
References: <20260401-mtk-mt8189-usb-v1-0-a4bf951aa8ad@baylibre.com>
Subject: Re: [PATCH 0/3] arm: mediatek: mt8189: enable USB support
Message-Id: <177646292300.59267.18213346214473248748.b4-ty@b4>
Date: Fri, 17 Apr 2026 16:55:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=743; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=KguNPNqTino9uFje86zR0le9ZOIq9lFxdCzEfjdE4/w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp4qxNWh4vit9xm2eWBrutvMX+IfbrdYR975Pz5
 2OSTeTaeMOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaeKsTRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AfO8H/i1MRO4TeSYIKjkCvK37We8zWs6GGaVbN3Aes+Z
 JSNjqU2hkerwR1QepKcmgQvV28ECZqDTHdC6g0fgo7mpkaRQhr70aMaBmv/tM08gSLR+eu1WEE+
 GYphNZEmfGShY76/mMOY4BBophYnLmA11TFdVlHqxSOnW3nPbg85wCcF2V9ngvelX3y8tUJF0O4
 DVebrdu/Ilm9Hji2VjTt7qmU1s4LlRsaOzWrAXdn8EpOiuto6NFJcxQXTJYgewkiJgFm3sbllM5
 GPYe/fIqU4VweG1rEgxQHTw+UTzlrTuRI3IZCMzi0hfQXiXVGC41LOgLKG3jZh0G/8pAay3eMaH
 DIDc=
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

On Wed, 01 Apr 2026 16:53:44 -0500, David Lechner wrote:
> arm: mediatek: mt8189: enable USB support
> 
> This series is adding USB support to for MT8189 and similar SoCs (i.e.
> Genio 520/720 EVKs).
> 
> USB and T-PHY drivers already exist, but we need to add a new XS-PHY
> driver as well.
> 
> [...]

Applied to mediatek-for-master, thanks!

[1/3] phy: mediatek: new XS-PHY driver
      commit: 1769f88b031a34347d6ed795a5cd7e776298f703
[2/3] arm: dts: mediatek: add USB/PHY nodes for Genio 520/720
      commit: 3b4c8b853ba160ff02b20f218a051508ce880073
[3/3] configs: mediatek: mt8189: enable USB support
      commit: d40c8bc91c3b957bb7de44ebf13d05115972189b

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

