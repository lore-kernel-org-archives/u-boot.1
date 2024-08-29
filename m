Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2ACC7115D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 04:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4918288969;
	Thu, 29 Aug 2024 06:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bt4Z5yU+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8BDA88A75; Thu, 29 Aug 2024 06:47:55 +0200 (CEST)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78D3288ACB
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 06:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4fd0d7fe6f6so127937e0c.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 21:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724906872; x=1725511672; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z4L8ctuIvfqM/uOtx+JhLPgQBsAmBSP3dDVMbjdsLHM=;
 b=bt4Z5yU+5MNALjwhNa/EIe5fif0D+3CkLgz6bSXARU+8Jc4qpoZs1i3RNYFS6LfDgp
 b83C8zMHpcQ6nmABe8067Pkz544I8nbw+OzCtCn8jfHRlBlxuJboyjrA6+xQwfhhld+T
 rtZDat3fdFNo/ukM1pVfQjDp1aeMcAxddGR5OlTFOr3Bvo+3Epf8tKAECvZeV11D3odK
 C+yc/+KxV/tyzm4QU97tf1tD92uAzJ9PJOjEfOc0I6XzyY++cVDJAG4RJvugeyPHrMiD
 dS2qR1jL+2UWTQKRENJtM3S72UMO6I3rHU/q1Gfzz1WamTCERbJcTDX8DjcexYMtuPrb
 UIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724906872; x=1725511672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z4L8ctuIvfqM/uOtx+JhLPgQBsAmBSP3dDVMbjdsLHM=;
 b=uxa2Tm6dZCXoA2L7gk8jNazPFM2Dl43OkW9n9WTnRrY6OvGN9sPNBXemPJnO9YIfF7
 kSgB9aD6RlFEdVxkq1o1aUod80LoMq/BF6RPW36o5KJ3thxjMplHENUb6WzTNe1eiB+H
 0XjGou+XswL6iR4LlKEnWzdzEKEG9523ukBz22Na4N3XV1PHnmaJzAKRvKnwWUt7wigp
 sfrV3H9MUS9DwKhH/K5VeQqiN4jgPM8SlD81GuHJPStzLiYqaKCTIwe9sp7o2vZwExJB
 dSDO2WZVeJGOzIW1r2tHU+oRKI09rMoaHPp/U8F8+OX61Bx8V2K3inzxi3ZSBhSBgL6v
 8MDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcKAgZpBOXSryFEC8ZA6KlTiYGk4qVJeJODOa6cmrsARNApcTU8QBIyGJMfKJt86RxqA5oSQQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6kIWf1GvDLnmseb9IhtJ3wW8Ke5Lf7TTsTQUKp6lkgJFFKGoh
 KFs/BEZmWf42tWlihi1QWhpEldgKQboibS8J/JgwcGBjQH8y/NCZKT9fdBACq2ynjrNChBAVokp
 eUwiQA1ApR9F4J76k2S8gUIuh9OlZWHq1zu8MpQ==
X-Google-Smtp-Source: AGHT+IF8YfcA+XSZrDyIjKzOBR8wKnsgZJK0pWXuq9lKcGLrg27aGykbwfSfJcyEy3i1ORoja1xqB80vPxA7Aa6gj5Y=
X-Received: by 2002:a05:6102:3ecc:b0:493:f097:e5b7 with SMTP id
 ada2fe7eead31-49a5b056f6fmr2206870137.1.1724906872131; Wed, 28 Aug 2024
 21:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240829013058.6178-1-minda.chen@starfivetech.com>
 <20240829013058.6178-8-minda.chen@starfivetech.com>
In-Reply-To: <20240829013058.6178-8-minda.chen@starfivetech.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 29 Aug 2024 10:17:41 +0530
Message-ID: <CAFA6WYOFFxO3ob+Fj9YEotLnxwTD1hJwX4oEZtiJjSCkzNkj=g@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] dts: starfive: Add JH7110 Cadence USB dts node
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Roger Quadros <rogerq@kernel.org>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>, 
 Mark Kettenis <kettenis@openbsd.org>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 E Shattow <lucent@gmail.com>
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

Hi,

On Thu, 29 Aug 2024 at 07:01, Minda Chen <minda.chen@starfivetech.com> wrote:
>
> Add Jh7110 Cadence USB dts node, Visionfive2 default setting
> is USB 2.0 device.
>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../dts/jh7110-starfive-visionfive-2.dtsi     |  5 ++
>  arch/riscv/dts/jh7110.dtsi                    | 53 +++++++++++++++++++
>  2 files changed, 58 insertions(+)

Can you try to evaluate if this SoC can support OF_UPSTREAM? I can see
corresponding DT sources well supported by dts/upstream. AFAICS, you
at least need to add a Makefile for RISC-V here:
dts/upstream/src/riscv/ for which you can reference
dts/upstream/src/arm64/Makefile.

This is not something to be considered as a blocker for this series
but kind of follow-up work.

-Sumit

>
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> index e11babc1cd..44785bbee3 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> @@ -378,3 +378,8 @@
>                 };
>         };
>  };
> +
> +&usb_cdns3 {
> +       dr_mode = "peripheral";
> +       status = "okay";
> +};
> diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
> index 2cdc683d49..7bf9b2a03a 100644
> --- a/arch/riscv/dts/jh7110.dtsi
> +++ b/arch/riscv/dts/jh7110.dtsi
> @@ -371,6 +371,59 @@
>                         status = "disabled";
>                 };
>
> +               usb0: usb@10100000 {
> +                       compatible = "starfive,jh7110-usb";
> +                       ranges = <0x0 0x0 0x10100000 0x100000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       starfive,stg-syscon = <&stg_syscon 0x4>;
> +                       clocks = <&stgcrg JH7110_STGCLK_USB_LPM>,
> +                                <&stgcrg JH7110_STGCLK_USB_STB>,
> +                                <&stgcrg JH7110_STGCLK_USB_APB>,
> +                                <&stgcrg JH7110_STGCLK_USB_AXI>,
> +                                <&stgcrg JH7110_STGCLK_USB_UTMI_APB>;
> +                       clock-names = "lpm", "stb", "apb", "axi", "utmi_apb";
> +                       resets = <&stgcrg JH7110_STGRST_USB_PWRUP>,
> +                                <&stgcrg JH7110_STGRST_USB_APB>,
> +                                <&stgcrg JH7110_STGRST_USB_AXI>,
> +                                <&stgcrg JH7110_STGRST_USB_UTMI_APB>;
> +                       reset-names = "pwrup", "apb", "axi", "utmi_apb";
> +
> +                       usb_cdns3: usb@0 {
> +                               compatible = "cdns,usb3";
> +                               reg = <0x0 0x10000>,
> +                                     <0x10000 0x10000>,
> +                                     <0x20000 0x10000>;
> +                               reg-names = "otg", "xhci", "dev";
> +                               interrupts = <100>, <108>, <110>;
> +                               interrupt-names = "host", "peripheral", "otg";
> +                               phys = <&usbphy0>;
> +                               phy-names = "cdns3,usb2-phy";
> +                       };
> +               };
> +
> +               usbphy0: phy@10200000 {
> +                       compatible = "starfive,jh7110-usb-phy";
> +                       reg = <0x0 0x10200000 0x0 0x10000>;
> +                       clocks = <&syscrg JH7110_SYSCLK_USB_125M>,
> +                                <&stgcrg JH7110_STGCLK_USB_APP_125>;
> +                       clock-names = "125m", "app_125m";
> +                       starfive,sys-syscon = <&sys_syscon 0x18>;
> +                       #phy-cells = <0>;
> +               };
> +
> +               pciephy0: phy@10210000 {
> +                       compatible = "starfive,jh7110-pcie-phy";
> +                       reg = <0x0 0x10210000 0x0 0x10000>;
> +                       #phy-cells = <0>;
> +               };
> +
> +               pciephy1: phy@10220000 {
> +                       compatible = "starfive,jh7110-pcie-phy";
> +                       reg = <0x0 0x10220000 0x0 0x10000>;
> +                       #phy-cells = <0>;
> +               };
> +
>                 stgcrg: clock-controller@10230000 {
>                         compatible = "starfive,jh7110-stgcrg";
>                         reg = <0x0 0x10230000 0x0 0x10000>;
> --
> 2.17.1
>
