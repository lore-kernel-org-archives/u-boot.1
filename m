Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3A3CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 10:56:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 754FF88122;
	Wed, 10 Apr 2024 12:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aatdU3ZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 375A788122; Wed, 10 Apr 2024 12:56:36 +0200 (CEST)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C53A187EEB
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 12:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7e7b787142aso127543241.0
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 03:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712746591; x=1713351391; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oSWEVwS9p7p+wgX5N2CxVL0WG5EmDrvtjR5Twi6fk/c=;
 b=aatdU3ZHYrmacSclGAnNMFKlZBXdqG+NSpkEgeSYSokBJvlBy8LWObY+sC7z9hetme
 xBXuu3pinWyXnEzS4euI6UiqS3+kvb3rBWaJPjscp82Sk1OF8+PFMxeDrJZTkvoVjz2i
 mGAEw3/pGZ/FfO9gZr5yHVxEjspEj7xiljZ5wa2jNEhNNoMzwQ0dw8ozB16/9ebooQIo
 1Y8xGHH/TWWQzbwalGV2avFBiJee+l/2Y+vnRCcZy+pCIwNJEh0+xVsJx4yPfj5U9awM
 Ir3TyPffybTShguwoQS8AVxTOiBbmjURKKtmHeUrc3Q92ET71oS2QGW20RnFt0ZR2zxg
 hycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712746591; x=1713351391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oSWEVwS9p7p+wgX5N2CxVL0WG5EmDrvtjR5Twi6fk/c=;
 b=HJ5v7f/bgUX8q6T3/6I0m+ozXFW7dOZEpWfIXY1aRYm4DYDHdRsijn/IWp3/Nlbyu7
 UpYp6t058HfnR7Cxdfmd58jewojHZZxxIAo8Vv8OK3UVTpG9PO+gSdvq1pIkDgZ4DlaS
 YQCGFC3bye3557uYafPDzd+at4Pn/hA6k6DoVDpR85FHTDozrQ+07zvB8bu0zvCL38gX
 oah0qldX2fjrKw8GmMTay2qHmbmK7VUs7KaNya+d5AwEbyXqkEedJBoF2jOk4Ph1Zivq
 aNpkcbKsY8r70me5eZ30cUBb773pTO6vHJTSlNy6/GQfrKpRhn9uGrxdiSVrzvuYt3WW
 k9BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdS6B40LISSKgX/1J9hTN90gY1gZdaqDZcJ1PoYH0HpD8OAHoj8Mx0ERkSPDdwBF91lVuLX2EZQdFFMTOwvmB6tH6PEQ==
X-Gm-Message-State: AOJu0YwsNNLg1pR1kFhrrK+uLoptMir+r+VRBhPdR1UIbeCrX2mFEUe4
 KU+wFx+hoqiVuUekZO6t0cJEEIhM1P4N+cRycfIRPrFEmlKzyi7srGjaIthvf+na/OjaQZzgkGa
 ohGjlG/Tw3PIKmEwHsQ6EPsZR9eMof0fpc6mgOw==
X-Google-Smtp-Source: AGHT+IEBXqdTMAyvjC/jQR3bTxiavx3O7tpwKm158wP5LRmmS4edv8nG8pRy7paGvEpLIg2Mzilao9VEwCTCk6WYoTw=
X-Received: by 2002:a05:6102:c05:b0:479:dbcf:bfc4 with SMTP id
 x5-20020a0561020c0500b00479dbcfbfc4mr2025190vss.9.1712746591512; Wed, 10 Apr
 2024 03:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
 <20240409-b4-qcom-mmc-fixes-v1-7-5039164ecbf7@linaro.org>
In-Reply-To: <20240409-b4-qcom-mmc-fixes-v1-7-5039164ecbf7@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 10 Apr 2024 16:26:20 +0530
Message-ID: <CAFA6WYOX4AviWiYfwrz=aF7x3iwyGzjwf5ZY1eGBu8kG0j6Hqg@mail.gmail.com>
Subject: Re: [PATCH 7/7] dts: sdm845-db845c-u-boot: adjust MMC clocks
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
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

Hi Caleb,

On Tue, 9 Apr 2024 at 23:33, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Remove the reference to the xo clock which is on the unsupported rpmhcc
> clock controller. It isn't needed for MMC functionality.

Can it rather be handled via a NOP clock driver for rpmhcc? I suppose
this kind of DT modifications would push us away from upstream DT
compatibility.

-Sumit

>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/dts/sdm845-db845c-u-boot.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/dts/sdm845-db845c-u-boot.dtsi b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
> index 906f9faa5451..9e4533e603c5 100644
> --- a/arch/arm/dts/sdm845-db845c-u-boot.dtsi
> +++ b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
> @@ -6,4 +6,11 @@
>   */
>  &pcie0_3p3v_dual {
>         regulator-always-on;
>  };
> +
> +&sdhc_2 {
> +       /* Remove the unsupported rpmhcc xo clock reference */
> +       clocks = <&gcc GCC_SDCC2_AHB_CLK>,
> +                <&gcc GCC_SDCC2_APPS_CLK>;
> +       clock-names = "iface", "core";
> +};
>
> --
> 2.44.0
>
