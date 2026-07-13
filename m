Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A548FC44508
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 14:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31D6384C3A;
	Mon, 13 Jul 2026 16:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WRmLNEz0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CEA484C4F; Mon, 13 Jul 2026 16:28:30 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E6C84C06
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c12614b81c9so590924566b.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952907; cv=none;
 d=google.com; s=arc-20260327;
 b=NRS8UgG+uH5SUfM+cgnOFp08pnNk4+7q2+jBKglex//b8IPtRqp23b02KEYTNbxaMw
 1FT+woxCRABS8Sk8v9rtrex0DITnaxqMppTGCJK1cVTiqcOK3N3ZUJ0aBNdRdCxr9SWy
 hb2eTXTnQYOeL4RAKHBj4nMjC+MEniRpo9g+Z5TchOs5RGs6Rq5CIqKQI5Nw462n4tmC
 nv8L8emuc5g7wrtOQKJtOyXmfZEuF+jlwSgcESKPJmA7RiyXPtWRbNdxHSg7rmDtLRNu
 c52aaCt/8/inkTeTtZEAsU8wrC23wSVU2J1cQvNae3eGDdF4L3DktStOCRuL4d5iu/LW
 uStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gSyiyT/uZ5/Q/h5ek7TodwyPJHZmF5M1RPythHqCWHs=;
 fh=8blbiRpS5mipyi/DO5sIXO0+46Z74q1ENcuVv9IWduA=;
 b=GDUsbnuHW2klKqofGyOkZxzrsc5vXiiEjcEjhcTFsqoa5rqAkjsBToNaix3ZOpZGdH
 7gNfOneSHw+UqaaAtqddAORX/UnxrXKCUpdRYf759eyuiSwCir60M7DuJm/nKDPvMWnW
 HLtktHV4GHhKCHwWe1xSuhfF8GiJpu0pK/aTx3JFqErbnZxXXopv8AJ8TpIPfIdEWWga
 wCAksNNC28dPKA8bUyGUkSvzr56AxiZ/YBlp+kL4MfSrrcang+C8ktM8TApDrFzlzDgm
 ZDe7cz8zDhnkknNWYkLtFfmjccBijq7Vbsm73xOnzKJRiVipuCeocL00A93/ngKHv2xt
 40EA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783952907; x=1784557707; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gSyiyT/uZ5/Q/h5ek7TodwyPJHZmF5M1RPythHqCWHs=;
 b=WRmLNEz03AH0lEN9e9gSKwq3vCHFz+u8495gYTt54sdtZxt7sHy6h5cgN5E7HSdkAJ
 2SNI4abvLqcYVxiVxwQEP+0bZRx0qsKhjdi2W4W1x4LeMVsfRxlUTUzYHGrNeVnVZOo6
 lj9oCag79zIE1zWuMVDOGSVXx0k4qIdlCdjXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952907; x=1784557707;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gSyiyT/uZ5/Q/h5ek7TodwyPJHZmF5M1RPythHqCWHs=;
 b=mfzl8gNVSV5MiXpW0vQTDhj1oZhYSFOQvUTlmMX8Mxo2ppKPOrSsW6j/N2XGn0kBrE
 2aaw9Tn/yk0HUJSu7FK37D8dT207yGnBI/UXc5UgcoLPDmO/Tb/KL9PLLqpInxRk8yHi
 l/z9S6TQ6Dzdtvr0b6nmFK18kLrvW24ZX/6JvT3iASTmk88UcLRZ2nnq+Q81aql9+QZS
 lSkN7rQV7fIWpjJ5IHI1Bnj2g9oMg7DWHvaQP0l1EHwRWBYL9p5C1ZCDX5CuCFWwDj2x
 iBVTKOUCTLwlHnUXlx4ob0AIpu8OdVV2STLT2vxU6WuoPyxx6HruVEyUWeO2qe1RFkra
 Vzrw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+BmLQSvEsION2MbQdNi8s3ysvtoomhyPOTpv7a40IQ6ZbceD0WuNDbnPzfCh1TROspC3ADrs=@lists.denx.de
X-Gm-Message-State: AOJu0YxA1QakExaxNwoNaWv55UgHWKEBscF/2FbwuiJmwHiKOqmEY3lb
 FrnF8xchtY5dOKHNb3Lh75W5J7U6vUSGggD/pdRAJOGnWVA5lheQc4pwj23cOiA4AMP24IpBnxc
 36ixjubHr8lbOfgkzDfEBAiR698QaG0HJc3ez7ImR
X-Gm-Gg: AfdE7cm6QlSh+dnjK8RIDjYSH2fugQZQYtInwjRbfUQ71xK2+SyeSGoKR/24k+ffmGE
 Y9zjB8N0gGeLo5OlkJaKSSydminmos6bl1xV0umbw9GwFphjAEp87GIHxRIxpezUfbksC0Hbbh+
 V2aV9Ew7MaigIshL7LGyFQJm2qcyh3PeKcMJlQZbVrULDFxG8qIx7EXgxblc730QIUs+Do87/Uq
 TKw65dG/bMh95W7gd/u1VPBdFBF4cyYN/I1YhkMVOu95NZVnRoBPFS960K4S0VqAVWPniM=
X-Received: by 2002:a17:907:3d42:b0:c0f:fb53:9308 with SMTP id
 a640c23a62f3a-c161ea8d4f7mr397497666b.29.1783952907048; Mon, 13 Jul 2026
 07:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-9-jonas@kwiboo.se>
In-Reply-To: <20260708220540.3368825-9-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 08:28:15 -0600
X-Gm-Features: AUfX_mzENQP2aUIksQbAYWJgeQy-jWaTlq4C6AhxL9wiY79lwVxeT45vGSWpfDE
Message-ID: <CAFLszThMyQzP4FaF4DDhdkiJ_Rs6b41tUK36=x6bA2xQBYX-LA@mail.gmail.com>
Subject: Re: [PATCH 08/11] Kconfig: i2c: Depend on correct xPL symbol
To: jonas@kwiboo.se
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Jonas,

On 2026-07-08T22:05:26, Jonas Karlman <jonas@kwiboo.se> wrote:
> Kconfig: i2c: Depend on correct xPL symbol
>
> Change to depend on the xPL symbol instead of the SUPPORT_xPL symbol to
> only make the xPL_SYS_I2C_LEGACY symbols available when xPL is enabled.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> drivers/i2c/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
> @@ -78,14 +78,14 @@ config SYS_I2C_LEGACY
>  config TPL_SYS_I2C_LEGACY
>       bool "Enable legacy I2C subsystem and drivers in TPL"
> -     depends on SUPPORT_TPL && !SPL_DM_I2C
> +     depends on TPL && !TPL_DM_I2C

This also changes !SPL_DM_I2C to !TPL_DM_I2C, which fixes what looks
like a copy-paste error, similar to the DM_SERIAL fix in the next
patch. Please can you mention this in the commit message too? I
checked the boards that enable TPL_SYS_I2C_LEGACY (the mpc85xx
P1010RDB / P1020RDB / P2020RDB NAND configs) and none enables SPL_DM
or TPL_DM, so there should no functional change, but it is worth
recording that this dependency is also being corrected.

With that (assuming you figure out what Tom raised):

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
