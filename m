Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572D7FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 20:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D9C846A0;
	Tue, 28 Apr 2026 22:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="hQinN6mC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B4DE846A2; Tue, 28 Apr 2026 22:47:39 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E760A84688
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 22:47:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-66f747175d8so6018904eaf.0
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 13:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777409256; x=1778014056;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YicmoZgKdPPAuWi6qWP57xWkEjP2sZatEECTFzsJpPE=;
 b=hQinN6mCF06tbTDEg6+37rRJ2+f/L/Sski0gYDJT6iDVQRpNS1AqhcpfI8OtUdRgu5
 In+fvd/honjAFe8iBL6fSy1EkdcaYBErwAAk12OLnuuDbB4NvkebZ/pRvzJFn666Pbzp
 x9ieE1SCXYkN95y3TtIcleyEusPY4VlMngjCzehZai/tkHs6MMhdh56JUL9iXuuIi6Po
 7S9ZUBDEYV3OMKqaQZliEbdD9+MEfleym5Sln/pxfmU6OBHAlYe/JjqMHoKXPDK2Z+4d
 /toJ6FgHISaJd3VlBr4FI8tROqfSbIbTeEc+81XewsiUZkmdjCBoCdx2tmttFCeOnaGv
 mrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777409256; x=1778014056;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YicmoZgKdPPAuWi6qWP57xWkEjP2sZatEECTFzsJpPE=;
 b=MJhBKms54gt8BTduzdcM0swWPO1uQNTlNqHEQvn4wDthjwZWVizdxJA/uxrQ4/PUSo
 DOMVUq+VfoCbkQ8OGhjw626vSSKJNrVTlKskhVKJ4jP08TPw6PC/u5ibnM5dk8w1LL0L
 jvcdkLUFyZ8/bVOS9aSQBBkyBqMTndNJ9YUaXCrxpGzAEDsTf8FTTWkhuNujUMF6qPqH
 ADOWqCsUlOnZc7A0AZIMVyuZXFHcNymEIvH5gnRmj2Y1yICdJs4b9aBnZGtqyke9sJT2
 IRj9+9uo6cxkTgpNp0Al3SrazcHozPSqCs73JVpHLIAdIs+A21hJeyjB/PjRYJuiDSdI
 JG1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UOe8xpc2mT+619I3d8Y4Y/i+qTYazSPr8J7X5vyAB9ariuRXOpnSqYY4MwmckZupV8J3xWF0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4wcI2ON6UNMXfuwCNLbX6giuqzXw/X1ZKxZp9NfR4vj4XB/4l
 Dh5iBILAM4p3+Kb02b4xY+QsPaBcb1kLhr/VET3Xv1jwoy+15rYyJ0ZICfqAMjbtOGU=
X-Gm-Gg: AeBDies3BjOuZwABm3zn8hkxDDNAkGalCN8UieTexZw9yicR3ZIYKTieG06gBXsjK9V
 i9i1fh9D3YxGDNiOcWPfosRN2u6k6jS4HjIw0GY9V2fn9dvdkiUdQYez/92d+e/Otn9yS7sLrlB
 W87BSaSCyiMSyFLkfcu8Sc5bvNxkd4fMQqlL32owDrFKtp8Ki6YXnSsGsCtppxNM8V4eWg3QYAm
 CYFjw4TJm/SPabIpl+5zsYK1MbA5+Tm6MHWz0FRjdnzdn2KCaZCCg5agdHUHEsicAMLIzS+Fvzb
 xyDmzp5pMGJduGlsjJSGLSGsqcczY51+fB0H5SOTLq95smcjkOa86BVYgbta8e31lhjb454/vHZ
 yVFCvl3N6rjmF3CdU5vKLXGpm9uDhtGceg3xqqVir+XrQuty892M1SLmNji35p+BkiONxF9Mikv
 GbHS5BO8Vosa/Jjyt35Bz8Yd36NnCTlUojI880x4I2ud0TLHN9vjlkRDa2d2xr/Ys78/hQ7Qoi0
 P8wAz+BeM5c
X-Received: by 2002:a05:6820:16a3:b0:67e:2fcc:fa99 with SMTP id
 006d021491bc7-6966851bb92mr655600eaf.55.1777409255625; 
 Tue, 28 Apr 2026 13:47:35 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1770:76c1:cfc7:3a0c?
 ([2600:8803:e7e4:500:1770:76c1:cfc7:3a0c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4340e915fdcsm212592fac.12.2026.04.28.13.47.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 13:47:35 -0700 (PDT)
Message-ID: <3a684241-f922-44f7-a9f7-445ed8790078@baylibre.com>
Date: Tue, 28 Apr 2026 15:47:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] pinctrl: airoha: add pin controller and gpio
 driver for EN7523 SoC
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
 <20260428153448.980150-5-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260428153448.980150-5-mikhail.kshevetskiy@iopsys.eu>
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

The subject is a bit long on this and other similar commits.

Suggest:

	pinctrl: airoha: add driver for EN7523 SoC

or

	pinctrl: airoha: add pin/gpio driver for EN7523 SoC


On 4/28/26 10:34 AM, Mikhail Kshevetskiy wrote:
> The driver based on official linux airoha pinctrl and gpio driver with
> Matheus Sampaio Queiroga <srherobrine20@gmail.com> changes.
> The changes:
>  * Separate code for each SoC and keep some of the functions in
>    common between them,
>  * Add pinctrl driver for EN7523 SoC.
> 
> The original Matheus Sampaio Queiroga driver can be taken from the repo:
>   https://sirherobrine23.com.br/airoha_an7523/kernel/commits/branch/airoha_an7523_pinctrl
> 
> This patch adds U-Boot pin controller and gpio driver for Airoha EN7523 SoC.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---

Same comments about commit message and general style from core patch apply
here as well.

> +static const struct airoha_pinctrl_func_group en7523_phy3_led1_func_group[] = {
> +	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio7", GPIO_LAN0_LED1_MODE_MASK,
> +				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
> +	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio6", GPIO_LAN1_LED1_MODE_MASK,
> +				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
> +	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio5", GPIO_LAN2_LED1_MODE_MASK,
> +				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
> +	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio4", GPIO_LAN3_LED1_MODE_MASK,
> +				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),
> +};
> +
> +static const struct airoha_pinctrl_func_group en7523_phy4_led1_func_group[] = {
> +	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio7", GPIO_LAN0_LED1_MODE_MASK,
> +				LAN0_LED_MAPPING_MASK, LAN0_PHY_LED_MAP(2)),
> +	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio6", GPIO_LAN1_LED1_MODE_MASK,
> +				LAN1_LED_MAPPING_MASK, LAN1_PHY_LED_MAP(2)),
> +	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio5", GPIO_LAN2_LED1_MODE_MASK,
> +				LAN2_LED_MAPPING_MASK, LAN2_PHY_LED_MAP(2)),
> +	AIROHA_PINCTRL_PHY_LED1(EN7523, "gpio4", GPIO_LAN3_LED1_MODE_MASK,
> +				LAN3_LED_MAPPING_MASK, LAN3_PHY_LED_MAP(2)),
> +};

Are these suppose to be LANX_PHY_LED_MAP(3) instead of 2?


> +U_BOOT_DRIVER(airoha_pinctrl) = {

airoha_en7523_pinctrl

> +	.name = "airoha-en7523-pinctrl",
> +	.id = UCLASS_PINCTRL,
> +	.of_match = of_match_ptr(airoha_pinctrl_of_match),
> +	.probe = airoha_pinctrl_probe,
> +	.bind = airoha_pinctrl_bind,
> +	.priv_auto = sizeof(struct airoha_pinctrl),
> +	.ops = &airoha_pinctrl_ops,
> +};

