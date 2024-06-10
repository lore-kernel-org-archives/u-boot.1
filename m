Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889ADC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 876F6883C9;
	Mon, 10 Jun 2024 03:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="WsT7bGO1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58E05883F2; Mon, 10 Jun 2024 03:07:55 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 301D1883C9
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1717981672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qd5qHNaCk4E1/YkwHky0+mimLPdvJ7nv7MZ1InQcYTM=;
 b=WsT7bGO1LWbyGxfBhc83fyK5D89pAMHWQo1jk/5HX9am9ATaizpGFzNgPWZdocGZIkcZaP
 9xGmWlE8cbfiVAug9qeLo0bNFvENKnbZLcl8nu6s9X+DBdIVX5kGm9DBCLZVw19ctxo5rf
 4cy06H/XSIJK+KSnLXUbXEijfZ9iI48K4G9kExnMlzBKkpXD49KSq/fDWRV2aWB1vXifNz
 gPG9eHJ0Q7LHCyE9hjPCjO5I3BsiIw5lORoU9uFGdh/TVPuGJFTliFviw+RGUdfuzTrx2D
 uqKnuX2Qc/dfASwHLwQaJmHLkDbIQYYiPDXDc1cWRpmz3xsQC4zT2ZL8e+/TYQ==
Date: Mon, 10 Jun 2024 03:07:52 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] arm: dts: mvebu: Update DTS for Thecus N2350 board
In-Reply-To: <20240610003431.14148-1-mibodhi@gmail.com>
References: <20240610003431.14148-1-mibodhi@gmail.com>
Message-ID: <2f5754a5c9f50ed735d80153f1e72082@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello Tony,

Please see a few comments below.

On 2024-06-10 02:34, Tony Dinh wrote:
> - Change the spi-max-frequency to 50000000 (50 Mhz). According to the
> data sheet[1], the MX25L3205D max frequency is 86 Mhz. Using 50 Mhz in
> the DTS to ensure u-boot is consistent with what Linux kernel expected.
> - Update GPIO fan to conform to the latest DT binding.

There's no need for the bullet points, plain prose will do fine instead.

> [1] 
> MX25L3205D-MX25L1605D-MX25L6405D-Macronix-MX25L3205DM2I-12G-datasheet.pdf

Unless you can provide a real, working URL for the datasheet, this 
reference
should actually be deleted.

> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
> 
>  arch/arm/dts/armada-385-thecus-n2350.dts | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/dts/armada-385-thecus-n2350.dts
> b/arch/arm/dts/armada-385-thecus-n2350.dts
> index 253cf01130..fdaa444e51 100644
> --- a/arch/arm/dts/armada-385-thecus-n2350.dts
> +++ b/arch/arm/dts/armada-385-thecus-n2350.dts
> @@ -2,7 +2,7 @@
>  /*
>   * Device Tree file for Thecus N2350 board
>   *
> - * Copyright (C) 2018-2023 Tony Dinh <mibodhi@gmail.com>
> + * Copyright (C) 2018-2024 Tony Dinh <mibodhi@gmail.com>
>   * Copyright (C) 2018 Manuel Jung <manuel.jung@hotmail.com>
>   */
> 
> @@ -143,9 +143,9 @@
>  	fan {
>  		compatible = "gpio-fan";
>  		gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
> -		gpio-fan,speed-map = <	  0  0
> -					600  1
> -					3000 2 >;
> +		gpio-fan,speed-map = <	  0  0>,
> +					<600  1>,
> +					<3000 2 >;
>  		pinctrl-0 = <&pmx_fan>;
>  		pinctrl-names = "default";
>  	};
> @@ -415,7 +415,7 @@
>  		compatible = "jedec,spi-nor";
>  		reg = <0>;
> 
> -		spi-max-frequency = <108000000>;
> +		spi-max-frequency = <50000000>;
>  		spi-cpha;
> 
>  		partition@0 {
