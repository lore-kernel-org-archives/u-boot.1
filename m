Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AA9FF886F
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 16:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C9E684119;
	Tue, 28 Apr 2026 18:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Zibsv/FD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B5C084255; Tue, 28 Apr 2026 17:59:59 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FBF783A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 17:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-47bfa080d93so1667782b6e.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777391995; x=1777996795;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+k29gyCPdO8dwAm6RBpRkjt+LiHfKQIInPDtMWAVFgc=;
 b=Zibsv/FDsXSs0vF0ibiblOp/bYCMjC4ItsoAfGkSn1KXOTnUp+ckydvbXU7cH7PS86
 VAHBaE1uOmezLArpZJkXzUEofsBgk3nlSqM25d/JPPHwuvl75nmgKba8vL1bBU0ZcWba
 yFoB2HqpQ1HwJ9PEUjISU3GF/t6t0lLz47cXLffCocqd/KInIKBJEJRq1LUAGmr51wBQ
 tbINvG8kPmuWLk6jaY6ZWzuV/4CfbEcPPZzaLlIUmWIWImawMFLWEEzmY2MuB4wvJZtp
 kcSdnxFM2drnEROG/PIiGb0m8OwEQj4JRB1cj2iBBmofU5pdvRFb64+pIACv+u3wEcZ9
 ytHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777391995; x=1777996795;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+k29gyCPdO8dwAm6RBpRkjt+LiHfKQIInPDtMWAVFgc=;
 b=SNGxdasXh6uaE6nuJ8Br8Pq1/AeSr4zBs0MHO8LwJePF2sZyZ4ECh3Ca7kmTrAA6tw
 5cfKG1M09pSV4Cw2TmsEBMwhaj9kXVNi5jS1IHi5rPseJghQit7ZYL44ZQPAJD2meCzV
 3j0UjF/9sGkR2dM4/KtCEr7rRe3JABkBLnuEW+XQrxS6FS8xugAPt62y6rcIC9Eh9jIS
 0esozI1YnrQVvyG4VKDZ1Il5XERwlpm1MhCxT6q5SDGp7c8Br8oaf6csW5n4cylHdEBs
 1aWpKRDAjWyBX2/ffa+FAnfJwMGL3FbUjMNP7gzDRpCWISXi6AH23RIvuYIx+1dwfBxg
 zH7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9W91xyHCd5lfqgnhOrDT3yCC5rDtVrA2grvYPUqBVIVoxLowjoQpS/ExQawipST/UziSqZUwQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyRGu3I6E9EJorhjPY45ExKRTvwtMI+nQ0Ua38ULCx3JYK5TQFY
 Hghvj0/RQUJ6mn1CzcFBdfnLp+qyBv5MdhGricVyMtGYUM4100xRlRYgDdaRL80Fc1zxTVDuXA2
 E2BLd
X-Gm-Gg: AeBDiev804S11nvWFGFhKnbXDYfQuGd7ddgVNk86Po9jfR6vhvtlkfuqmbPtoZYnzC3
 /z5ZU6P/OejssBc+lyaCF1nxChgQKYmB8zCD8h0igbYL6xOIVXdYi47WPuVY2xWYE6Yh6n2ATCr
 G9sZ87nFt44tXidRcsrhHnOgvHOeUmhof/qSJmJ5KbLsomuO2z5IgjqYZnHrEarjd78tM9n2XrS
 pnJY14GbwWlnj81V00yli047js6yjhzj6JTXMNkydFEZKGn6aOHb3eCEu5lawRzyP7jwdKm8Qj7
 U0RSA9IWNRi2lb0Ne+TWFpPlf11msse3vjF7rI6dMMJ6CZ8nGxoETrY0rsbX7aiWdIiNkooYcXY
 1x9s94qss3QV7ZqZ3AD+6IJiYOIO+Ei23+8Rmv1HyiP/49zaDAuKYvNQS046MIyal1Ps9R/7N/s
 IE9G7cimAROoCirkrgE40zYC7pp3EiBeg64qaostg=
X-Received: by 2002:a05:6808:1790:b0:479:d57b:83b0 with SMTP id
 5614622812f47-47c28f63784mr1783025b6e.22.1777391994922; 
 Tue, 28 Apr 2026 08:59:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:efba:bc47:a81b:dd0f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7de9871ceeasm2014593a34.27.2026.04.28.08.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 08:59:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260421-mtk-configs-remove-ident-string-v1-0-66d5fc3d67be@baylibre.com>
References: <20260421-mtk-configs-remove-ident-string-v1-0-66d5fc3d67be@baylibre.com>
Subject: Re: [PATCH 0/5] configs: mediatek: remove CONFIG_IDENT_STRING
Message-Id: <177739198411.3382222.8213846855382011998.b4-ty@b4>
Date: Tue, 28 Apr 2026 10:59:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1440; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=17sQdqxOrLmTIYgx0zLTw/o3+IsRut9CHEjJJUD8oO4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp8NlzGxyZRk48siAJb9FW9KkqoLXsDE4T4hGEr
 hZurdCdsgSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCafDZcxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AsB0H/iLdhcF9ZdOR/HQaOakUmnrS6TySJ6MwAC6ESez
 z9f//9XzzxUAZ7rHjWTehvD6/1wwSrpxrZaUIpsR6JzgOEpizIX9c+7KFXHTio6S3xrAs1cVB2Q
 5AP5baO4WGIJBQJSVRT/zSCtpMZogcyGuYtwx+pUlaT5PJdaGkg1AhMlIQYtzfYHpYtWuhb0/hB
 9HeqxTPHgyTrpgM0UR9LJQfmQzaNVMbMU+G5Le35J8KiyDLJcL/gzYWwaY5z0vOOHaL7L+YFoWi
 aWx8bGvsua2yiqXQYwXNGARjAABhGa2BJyA+GVMzYrAj8HK601pzIE4Kac98b9de0uRSbj1QS2W
 nTp4=
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

On Tue, 21 Apr 2026 09:09:33 -0500, David Lechner wrote:
> configs: mediatek: remove CONFIG_IDENT_STRING
> 
> Until recently, MediaTek defconfigs didn't set CONFIG_IDENT_STRING.
> mt8365 added this and then it was copied to some recently added
> defconfigs.
> 
> This is just appending extra text to the version string that gets
> printed, so it has no functional impact. To keep things consistent for
> all MediaTek defconfigs, let's just remove it from all of them. This
> also frees up the CONFIG_IDENT_STRING option for use by downstream users
> that may want to add their own custom string to the version output to
> help identify their custom builds.
> 
> [...]

Applied to mediatek-for-master, thanks!

[1/5] configs: mediatek: mt8365_evk: remove CONFIG_IDENT_STRING
      commit: ba97dd5c107a844115b8b6a7f63c5e0b773204fb
[2/5] configs: mediatek: mt8370_genio_510_evk: remove CONFIG_IDENT_STRING
      commit: 4c435a7ffb104ef4f13c6c29d784d6a6be247f1e
[3/5] configs: mediatek: mt8390_genio_700_evk: remove CONFIG_IDENT_STRING
      commit: 9b471cb9b2e9c070d27b1ee6c7bd658f5289d31e
[4/5] configs: mediatek: mt8395_genio_1200_evk: remove CONFIG_IDENT_STRING
      commit: eb1551fddc6b50e3053c850814d16d95cf542559
[5/5] configs: mediatek: mt8395_genio_1200_evk_ufs: remove CONFIG_IDENT_STRING
      commit: 95c06da44f83f5db523433d04b5518b4fe62f906

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

