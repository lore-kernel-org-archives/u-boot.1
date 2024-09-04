Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548F2CD37AE
	for <u-boot@archiver.kernel.org>; Wed,  4 Sep 2024 04:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 485B988C7A;
	Wed,  4 Sep 2024 06:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tbopxldA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7974588C85; Wed,  4 Sep 2024 06:32:31 +0200 (CEST)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C61B88381
 for <u-boot@lists.denx.de>; Wed,  4 Sep 2024 06:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-498de7a11b9so1805027137.2
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 21:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725424348; x=1726029148; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vDTiMfJF3DDpkOx3owE9OtkZtJw3D1E7ou3gexcxvQc=;
 b=tbopxldAG/E9bjkzYdzdz6bwGZb9p707zulYx794Ob9n0tUM3ENXm3efiistxl8PIc
 AOO5Froc4knu2UrR5/24MQGzBTZAdBNK4zXgaf6pylomoSgv7Cf5hoLv+z1YiacchL4n
 1SfXcNSIi8LLF3PZgEaa9vYggw9boW+j57CEoXs4RXg0mDkU7h8QV4KyL+tUSKjHOVhi
 axjTvaYSLka7ZkF9Z3aAVVC8jrGfwu7DFoPZC3GeydwlsEIw2dOWRdI3KjhQtDk9qMZn
 1/ey/r9l4bZ3LOe6zhR0LnemEFr0qi4NDBTr1ws7GaRDcNBQIlspL/8fsZEv+c+3PIV5
 SMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725424348; x=1726029148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vDTiMfJF3DDpkOx3owE9OtkZtJw3D1E7ou3gexcxvQc=;
 b=Dq4DRqPcLiLhgj530tdqPXsx1ZnyHoQexnY819Dk3CsGSJ6p5zGnlVP8W4hlmgRstG
 P/aUUxmXUVgh0Im7PqsGMgeI7fUjBN+VtlBDI7xz6ZTPchxgUJ/paimWmaGIiMXRjijk
 0YYQ2WLJqZ4dp3Ta50sKV5cTJctIolLnyjlEfLPnpB66VHO2ADjcJq/Z8hrhZjYbnuUw
 2T/Du1Mx0sTXUJTTC8Wfkd4LV4BJsmIoHrESsJ/b/8PDDWzKvfOixe0T23veyLU+w0+Z
 8Va6qGlunFfbOeVw+yTlcV/eSe23SfoSwC3lKDhxs2w1csiimmYq/3lKoukn/cGt7iWR
 j7yg==
X-Gm-Message-State: AOJu0Yz2XAzwWo+avJnY4gO7ky9JDKIqqEQgUDJIlvXNW8AgSJIeloCM
 GT4DIFCX/ifPZLKEmlRdqzDEiH+aydU1xSR2d2P+Gdz3HBDgIL6B8eaHeKHjozYwK0NjzokXut9
 g5Gh0r5je1JUBBw47raOZbHEoBUBOWQCEIP2KXA==
X-Google-Smtp-Source: AGHT+IFruzJugnK83FYEv0Rwoud/UXtaAS/o2W27A6w4tcDOzMh8dnkmG/NhddS0jSDflyzWTIHnr9k+p2x1bgrI2/I=
X-Received: by 2002:a05:6102:3f15:b0:48f:de85:2b4c with SMTP id
 ada2fe7eead31-49a7783c896mr17561977137.23.1725424347611; Tue, 03 Sep 2024
 21:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240830155514.481410-1-macroalpha82@gmail.com>
 <20240830155514.481410-8-macroalpha82@gmail.com>
In-Reply-To: <20240830155514.481410-8-macroalpha82@gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 4 Sep 2024 10:02:16 +0530
Message-ID: <CAFA6WYOQqt1qiN+B2jEDk2drtt2DxckO-yYwf+b58svFiSwR4g@mail.gmail.com>
Subject: Re: [PATCH V3 7/9] arm64: dts: allwinner: h616: Add r_i2c pinctrl
 nodes
To: Chris Morgan <macroalpha82@gmail.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jernej.skrabec@gmail.com, 
 neil.armstrong@linaro.org, hdegoede@redhat.com, andre.przywara@arm.com, 
 jagan@amarulasolutions.com, trini@konsulko.com, ryan@testtoast.com, 
 iuncuim@gmail.com, Chris Morgan <macromorgan@hotmail.com>
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

Hi Chris,

On Fri, 30 Aug 2024 at 21:27, Chris Morgan <macroalpha82@gmail.com> wrote:
>
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Add pinctrl nodes for the r_i2c node. Without the pinmux defined the
> r_i2c bus may fail to work, possibly if the bootloader uses rsb mode
> for the PMIC.
>
> Link: https://lore.kernel.org/linux-sunxi/172252952262.1669767.7675865282122079154.b4-ty@csie.org/
>
> [ upstream commit: 7c9ea4ab76176f65f4f55aa144f9145a4bccaacb ]
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  arch/arm/dts/sun50i-h616.dtsi                     | 2 ++
>  dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/arm/dts/sun50i-h616.dtsi b/arch/arm/dts/sun50i-h616.dtsi
> index 921d5f61d8..41f2c23e07 100644
> --- a/arch/arm/dts/sun50i-h616.dtsi
> +++ b/arch/arm/dts/sun50i-h616.dtsi
> @@ -836,6 +836,8 @@
>                         clocks = <&r_ccu CLK_R_APB2_I2C>;
>                         dmas = <&dma 48>, <&dma 48>;
>                         dma-names = "rx", "tx";
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&r_i2c_pins>;

This change is sufficient with !OF_UPSTREAM.

>                         resets = <&r_ccu RST_R_APB2_I2C>;
>                         status = "disabled";
>                         #address-cells = <1>;
> diff --git a/dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi b/dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi
> index 921d5f61d8..41f2c23e07 100644
> --- a/dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi
> +++ b/dts/upstream/src/arm64/allwinner/sun50i-h616.dtsi
> @@ -836,6 +836,8 @@
>                         clocks = <&r_ccu CLK_R_APB2_I2C>;
>                         dmas = <&dma 48>, <&dma 48>;
>                         dma-names = "rx", "tx";
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&r_i2c_pins>;

Please don't manually patch dts/upstream subtree. It is meant to be
updated only with tools/update-subtree.sh script. Also, it isn't
needed as well since you haven't converted to OF_UPSTREAM at this
point. Same applies to patch #8 as well.

-Sumit

>                         resets = <&r_ccu RST_R_APB2_I2C>;
>                         status = "disabled";
>                         #address-cells = <1>;
> --
> 2.34.1
>
