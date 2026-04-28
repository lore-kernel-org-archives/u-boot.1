Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABFBFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 20:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 525EB846A8;
	Tue, 28 Apr 2026 22:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="l2rK8fB3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAC37846AC; Tue, 28 Apr 2026 22:51:17 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45179846A5
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 22:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-479fc1fc048so5196918b6e.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 13:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777409474; x=1778014274;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sWfXsbIVLXcLHbRWgQNN6N3sZrfYpUTMdKjK132lBeE=;
 b=l2rK8fB3cXE5IfN0H9g1SgAvFqOKkDg7IQ/e6zc0Td+oSmHafvMiJ0abMWOfo0vuHN
 UIOOnQTj9IFaMZ0t/pRph3q+x2InwRghUpjSRqAYpV0e1Cp2G5z230CzA9dJW16OdECY
 Zq2A8VVLm062zYsi3dx//YFSmC2rGGC8JLuAT8i+0P+3KyHv2J9XO/1r+kz2MMwSmI1c
 6orW5FGKNtG1r/5RK1UFmQcBECQpTrwyuADL1QAwp6B6+Ssc9iK3HvHSe92TUcFeoc1s
 zOEu8NrUWo4LEJ5e2xQkqiWwZtzmm8x5Hgt1IvhlHMjk12Bh5MxD+jUWCp+U9W1CrLfE
 f5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777409474; x=1778014274;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sWfXsbIVLXcLHbRWgQNN6N3sZrfYpUTMdKjK132lBeE=;
 b=shwggpnb0MMw+yEjNGMvuOS6if8cSfr+dI8LauxL53ZKOVG4hckDSpy28IdCBSfK/J
 OONui5Hl/4TGkLCLKaIKktvWQtfQA0/8eaZkIi/USlbcmj8aCDhaPxL1Tin9/9nUxQOP
 lSWr/kLFIpOoSwA2PWuH/nmBJOytLa7GngCCX+C/EYwq+LbQRb/Fkl95UeHr/e0XLfxW
 gleXMbLR2sVV4DT9mHcyEiCmMs2Wnq/eC1YgMlwX6fNNOJYone5W0pBRkVV1zI+OmdHQ
 VAr+KHatKkHvT/tIRW748X4FS+4Dh6opW2Dl00U8PIIJU0RG+7G/gFhbLQl9gT0n5deu
 6wyw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fDGNZmiz4jAQIghB4AK0rhX69YyBIsYM9FjSC7p3hGDOcKa6UpSMERGrLdor9gZIxIZ/thvU=@lists.denx.de
X-Gm-Message-State: AOJu0YwI8ZL+0dyFF40sMi8B+3Uvyvl7nLtIDR3Rs7ZK3Oh5eFZa4/D1
 bicqs+V0+GHG2R12hrXaEEkmk9x4FI3KE/81AKY+rseXLO6ghsLKTAX0OMOXTOxBZt4=
X-Gm-Gg: AeBDietcDJAUh5Y5WWWEO1pkloWwTOG1cLczZDvUG4538jIotmI7L9g4jWGHLpYFNUq
 R11e8yIshh38zvIOddDkBd9tXmHDmAXpxDCF98jwOg8dWAbspAO3RjhaQt1m+Kh+FeBitZ67pNe
 wWzOOfzdzylLhOHWV/C8lviB5sdvFGxGH8Ffe7B7HNDKvHVo0bQIp+F2+IETGl22u+OEjsLZmP4
 mG/Y3OiYL2J1x02ozkzRIbW33rBqZGXSrOFuymVIR+vra0n6hEuJ6VYH/3E9HCg/ZlXG6KHZ5tl
 /JL3Yi6qWpLw7AHaTkvPPL4CIVGVCjS+fN/R23WkoAzKZPqKMlIPBxlaxMoOoMDWKWNsbJNOzF2
 5bxvHMrkI07mLWTpLEuthRrjSR7V6r7/ij1NBPtU2yYOMMRyJxQYUQh8cjRqtn5+cjRzOy+oLAM
 tmZZDj7PYoLK39U5bnEWZjEy/qklE3WErX4T8qlg3rWv0COCGOK8mMJj4pEZ8CHmoPvZ34xa/0t
 JWKgIz4orzO
X-Received: by 2002:a05:6870:818e:b0:42f:ee6c:35fb with SMTP id
 586e51a60fabf-433f3a15d13mr2644547fac.20.1777409473993; 
 Tue, 28 Apr 2026 13:51:13 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1770:76c1:cfc7:3a0c?
 ([2600:8803:e7e4:500:1770:76c1:cfc7:3a0c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4340e6b4744sm238678fac.4.2026.04.28.13.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 13:51:13 -0700 (PDT)
Message-ID: <22b116d3-4d6a-4375-9f83-9fda31c6f060@baylibre.com>
Date: Tue, 28 Apr 2026 15:51:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] configs: airoha: an7581: enable pinctrl/gpio
 support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Anis Chali <chalianis1@gmail.com>,
 u-boot@lists.denx.de, Lorenzo Bianconi <lorenzo@kernel.org>,
 Markus Gothe <markus.gothe@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>
References: <20260428153448.980150-1-mikhail.kshevetskiy@iopsys.eu>
 <20260428153448.980150-6-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260428153448.980150-6-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 4/28/26 10:34 AM, Mikhail Kshevetskiy wrote:
> This enables AN7581 pin controller and gpio driver.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  configs/an7581_evb_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
> index a94730cf564..e50216babb5 100644
> --- a/configs/an7581_evb_defconfig
> +++ b/configs/an7581_evb_defconfig
> @@ -73,6 +73,7 @@ CONFIG_PHYLIB=y
>  CONFIG_PHY=y


>  CONFIG_PINCTRL=y
>  CONFIG_PINCONF=y

I think these two are not needed anymore because they are selected by the
option below. Did you do `savedefconfig` to make these changes?

> +CONFIG_PINCTRL_AIROHA_AN7581=y
>  CONFIG_POWER_DOMAIN=y
>  CONFIG_DM_REGULATOR=y
>  CONFIG_DM_REGULATOR_FIXED=y

