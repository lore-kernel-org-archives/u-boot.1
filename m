Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C613FF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 21:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 970628468B;
	Tue, 28 Apr 2026 23:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="eQ4FbOIc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE39884698; Tue, 28 Apr 2026 23:03:43 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16B4984687
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 23:03:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4756e74f8edso8281001b6e.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 14:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777410220; x=1778015020;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FVCkhxX9SB0/SgvqJrcIAciDETM+XeDEZHrX2RKtLzQ=;
 b=eQ4FbOIcuFndoLsDoGUWku0L5FlPd8sP4bpsXec8njUqaUYIxEE9hHkWJkC1MGYvOL
 HBNaXyS3MvYjaSh0FItvHe6BXIm84CSuVPunDP+Tf0xTLrJccQj7oGof4et2JbLiDylS
 iTDGY0WKintUCc01tbZtXOdi0wWyqWkzn0DRhpQDgjDUs1B4Va+E/dH1UhXvz2N2skGg
 iB8QDwb/CgxpArGHhfqWtU+7Q2JV9Q5L/3AiueTF5xVqcpZlyJl98Xef/cP0O1w2czaU
 ELvMnuMzBVkzfFezyIMNTN7Udis+Hkb9Q0DAyuAO5LhhYksrkZgTh/Fdn4J/V4woPk0V
 FpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777410220; x=1778015020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FVCkhxX9SB0/SgvqJrcIAciDETM+XeDEZHrX2RKtLzQ=;
 b=Z+hF6EW4QD2xehAz8V4gXfBZe6a+XP+vWfATf9gNf7nQO5S/TXRWrnI/XaIMuQuo/Q
 EqJyul5GgUInfZc62XpdVTPwPvr8Sbn7C+YYg6CEsr5WfcRaM+n+P7yaUpk6sCwFhKyz
 FtszVihq8QuHxupcMomnFKFhnY/QjA3ROORqC6BXA1aDYSD0liirdO4cPi7XiMVUSDzp
 1tp18vWd0BD6j3HOP7nr/NLrP1TE74bmKfzjp42de6spEZWFoGrc8ck2V6wN5siQ2byq
 NgLsiYrqJjZ8X+Smeu4s2dtDvrEh75xqCU/vITCC4/9/WRD+hkQEQx2O361SAMISco/7
 ImYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CbuxMlFHLG1GkcD4HIAW9qtwLCvaOYnAJZvd1B/G4aJWXHafr7ZXM5W9PBcGVtey813ShF4w=@lists.denx.de
X-Gm-Message-State: AOJu0YwFKpQrxG1GSWHYj6vpgaeXHCaQR1kZ0tkpQNkJ2ON5NdJAay9/
 sh0ouw12uViTw/6KjvCiocTD0uvMkmHU8lMezLgx/2+IdSv7KqftRcabjYb9rptoxXw=
X-Gm-Gg: AeBDiet1egiU9hSZnN7gGGMPBLOlXv5q89BYF34MeJ4N9zGdRvA5mvvCIJFtdWZ5Mg3
 iz+r/GM8DA8lby9waaLLrN0CnV3XauOOdMqt/zURUWJudjmLqNoXd2gckt6Nwp11AS+IcXZJWrZ
 6kXUYdBCjS6Xisk8LZYWIxpHVRRtLcMTThPJFLHmzGdkOVMnIBk8DWRzcWr3YK5JG2AQOfbdt2/
 JXyoB2BRm4kFvBSGMjInsbQMBft5SMdUfvQyvBUt5Hqsc8dKni1qKaIAzSJwJ6O6NQG8uMut9D5
 Zbn68UbEZoqNPJrJYpl/1J+gbx9QZmL3f+uMEmXfQR76oayIasnG+OiUx8EzY1/lxK1/YUomk8l
 cV1sQDAX8w7rEcWZlN06VvYR/sJaSXWtF4ql7demcQe3ObVl/WEDFBmDv9uKX3EzooqmZhp73P+
 LCECKu5Mt3Dc9d5/sum3u28GkrhfxTVQ7OoJ4mpIhAIOTP4AwHLoUS8tu4kt1i6pohUbGSjnYNt
 nHKpWH+yXlb
X-Received: by 2002:a05:6808:4f11:b0:479:d16e:9619 with SMTP id
 5614622812f47-47c3dc56d41mr673878b6e.43.1777410219711; 
 Tue, 28 Apr 2026 14:03:39 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1770:76c1:cfc7:3a0c?
 ([2600:8803:e7e4:500:1770:76c1:cfc7:3a0c])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c427d4a44sm74999b6e.8.2026.04.28.14.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 14:03:39 -0700 (PDT)
Message-ID: <ba66e9b8-a268-44cc-80f0-63ee41d9e651@baylibre.com>
Date: Tue, 28 Apr 2026 16:03:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] configs: airoha: en7523: enable pinctrl/gpio
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
 <20260428153448.980150-7-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260428153448.980150-7-mikhail.kshevetskiy@iopsys.eu>
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
> This enables EN7523 pin controller and gpio driver.
> 
> This patch also removes existing gpio nodes and replaces them
> with pinctrl node. It should not be very dangerous, because:
>  * No official EN7523 gpio support present in U-Boot
>  * The same driver is planned for upstream linux/openwrt
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  arch/arm/dts/en7523-u-boot.dtsi | 21 +++++++++++++++++++++

probably better to split dts changes into a separate patch

>  configs/en7523_evb_defconfig    |  1 +
>  2 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
> index 62d1a724678..3bd78b373a3 100644
> --- a/arch/arm/dts/en7523-u-boot.dtsi
> +++ b/arch/arm/dts/en7523-u-boot.dtsi
> @@ -2,6 +2,9 @@
>  
>  #include <dt-bindings/reset/airoha,en7523-reset.h>
>  
> +/delete-node/ &gpio0;
> +/delete-node/ &gpio1;
> +
>  / {
>  	reserved-memory {
>  		#address-cells = <1>;
> @@ -22,6 +25,24 @@
>  		#reset-cells = <1>;
>  	};
>  
> +	system-controller@1fbf0200 {
> +		compatible = "syscon", "simple-mfd";
> +		reg = <0x1fbf0200 0xc0>;
> +
> +		en7523_pinctrl: pinctrl {
> +			compatible = "airoha,en7523-pinctrl", "airoha,airoha-pinctrl";

Upstream bindings for other similar pinctrls don't have this fallback.
I would drop it.

> +
> +			interrupt-parent = <&gic>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
>  	eth: ethernet@1fb50000 {
>  		compatible = "airoha,en7523-eth";
>  		reg = <0x1fb50000 0x2600>,
> diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
> index 381d5d05616..e8433c7da12 100644
> --- a/configs/en7523_evb_defconfig
> +++ b/configs/en7523_evb_defconfig
> @@ -56,6 +56,7 @@ CONFIG_AIROHA_ETH=y
>  CONFIG_PHY=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCONF=y
> +CONFIG_PINCTRL_AIROHA_EN7523=y
>  CONFIG_RAM=y
>  CONFIG_DM_SERIAL=y
>  CONFIG_SYS_NS16550=y

