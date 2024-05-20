Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90848C04FFE
	for <u-boot@archiver.kernel.org>; Mon, 20 May 2024 10:28:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECF5A88692;
	Mon, 20 May 2024 12:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bJwXJhiJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2222D886AB; Mon, 20 May 2024 12:28:27 +0200 (CEST)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A53EE88692
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 12:28:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-481ed99e0bfso450653137.2
 for <u-boot@lists.denx.de>; Mon, 20 May 2024 03:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716200903; x=1716805703; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F62H5fthE0eW1qg+LJiyTwIStNqXV9uEGEQHljlTzWM=;
 b=bJwXJhiJI3+IoFnUAftaqmOuEpww2Bdn0sfHt516FyN4AZNWY2lGzsR4YP49GAJ5EA
 jPEKk+3StBTySWuOaJICojJR0rlht63fmXKCvpmRhEYVeJsi0UWWBcquBPNTnJSv5fCG
 HH9/+M7trZoF9WlyVllIw14Np1SQwXk1zYDfb3crYkn202a/UPudB1PphIo3Jy3Kcc2T
 25LU9LleEGZqe3EoggaxHW+kWU8P84Px6KVCfNE0624Htgejd7sqKBKvqNsPT0zI54En
 XryE7G246bqYFBoqkTsyLGQw3XFNn3wKLahB3tygrcGgwzJEYiVzn0d02oE3rwuhAD7H
 5E6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716200903; x=1716805703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F62H5fthE0eW1qg+LJiyTwIStNqXV9uEGEQHljlTzWM=;
 b=uL/SAuNCfBEmkZpKqWIXcPB/qKzn9IN4i8yqRfCuXeyVHMOl8MjzUJt9EDkdZE1xkO
 F1Cg3nSO2O5HTKjQ+6/wYm+ExCUWi647fLGmzMDXJ5Rxo6hGfy2pJsiLPrzihCJCCCiu
 lYXh6NJIfJ2rbrlOHRrfvReVVi3C5OLtHMRuOaHk7OtIa3SdtugO6jPH3gi86I6g3SRg
 BTCMSQfbR2ZgA+XEN6flPWR+/rv6hkLgrX81F310BbpRRSWRIqKSu498FckikkMg9ZdI
 qvl+8RE5ErdyBv9UwEAQb0HFPnqjvhfEGYMsfNUooMDmMozve+fCohDPXqFkXXPAK3O/
 ee6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+c8B5X6GxJnxa9oG2fmh6VpiHwwEsfaD045i6eoVTklI8op6fYq7JwDHreF8VTiRpGBQwBA0Dg/UwfyDsdW0Rq8vkyw==
X-Gm-Message-State: AOJu0Yz0H9pXKe+1KGa2A/Xbbzvhgy7lDBfkyt/FFGHG5bqVACDwLwtm
 1EcgTXuGT94VxeyOTLRufxy6U9fRo+PMVnzzO5x93BqB3L5uBvWVbSDAhmxIjjVuO2x/+6mVewz
 cZjoiLAWMwNXJi09MXMNzc5jmM4cGUsnMALG4MxoJXghvcP6Kmio=
X-Google-Smtp-Source: AGHT+IFhkZnn7YYVAK9mlCx2GRX15EtR9J0aDmmt8L4VvxUnhmjJ6xkc/+2tWj7gLu9hoqtdXQtAOuSYA+CeIN9eQVU=
X-Received: by 2002:a05:6102:b0f:b0:47c:607:eed2 with SMTP id
 ada2fe7eead31-48077e1b774mr27182897137.18.1716200903404; Mon, 20 May 2024
 03:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240518-pwm_d1-v1-0-311fc5fe2248@jookia.org>
 <20240518-pwm_d1-v1-4-311fc5fe2248@jookia.org>
In-Reply-To: <20240518-pwm_d1-v1-4-311fc5fe2248@jookia.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 20 May 2024 15:58:12 +0530
Message-ID: <CAFA6WYOhb1ke8+ZzFL11RM9Znz9v7NUkf7zQVP-MKAXVeH9Nag@mail.gmail.com>
Subject: Re: [PATCH FOR TESTING ONLY RFC 4/4] sunxi-d1s-t113: Add D1 and T113
 PWM node
To: John Watts <contact@jookia.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
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

On Sat, 18 May 2024 at 09:25, John Watts <contact@jookia.org> wrote:
>
> This is based on the binding from the as yet unmerged kernel series:
>
> https://lore.kernel.org/linux-kernel/20240131125920.2879433-2-privatesub2@gmail.com/
>
> Signed-off-by: John Watts <contact@jookia.org>
> ---
>  arch/riscv/dts/sunxi-d1s-t113.dtsi                   | 12 ++++++++++++
>  dts/upstream/src/riscv/allwinner/sunxi-d1s-t113.dtsi | 12 ++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/arch/riscv/dts/sunxi-d1s-t113.dtsi b/arch/riscv/dts/sunxi-d1s-t113.dtsi
> index 822f022eec..92b6432f77 100644
> --- a/arch/riscv/dts/sunxi-d1s-t113.dtsi
> +++ b/arch/riscv/dts/sunxi-d1s-t113.dtsi
> @@ -145,6 +145,18 @@
>                         };
>                 };
>
> +               pwm: pwm@2000c00 {
> +                       compatible = "allwinner,sun20i-d1-pwm";
> +                       reg = <0x02000c00 0x400>;
> +                       clocks = <&ccu CLK_BUS_PWM>,
> +                                <&dcxo>,
> +                                <&ccu CLK_APB0>;
> +                       clock-names = "bus", "hosc", "apb0";
> +                       resets = <&ccu RST_BUS_PWM>;
> +                       status = "disabled";
> +                       #pwm-cells = <0x3>;
> +               };
> +
>                 ccu: clock-controller@2001000 {
>                         compatible = "allwinner,sun20i-d1-ccu";
>                         reg = <0x2001000 0x1000>;
> diff --git a/dts/upstream/src/riscv/allwinner/sunxi-d1s-t113.dtsi b/dts/upstream/src/riscv/allwinner/sunxi-d1s-t113.dtsi
> index 5a9d7f5a75..435a1e66aa 100644
> --- a/dts/upstream/src/riscv/allwinner/sunxi-d1s-t113.dtsi
> +++ b/dts/upstream/src/riscv/allwinner/sunxi-d1s-t113.dtsi
> @@ -145,6 +145,18 @@
>                         };
>                 };
>
> +               pwm: pwm@2000c00 {
> +                       compatible = "allwinner,sun20i-d1-pwm";
> +                       reg = <0x02000c00 0x400>;
> +                       clocks = <&ccu CLK_BUS_PWM>,
> +                                <&dcxo>,
> +                                <&ccu CLK_APB0>;
> +                       clock-names = "bus", "hosc", "apb0";
> +                       resets = <&ccu RST_BUS_PWM>;
> +                       status = "disabled";
> +                       #pwm-cells = <0x3>;
> +               };
> +

This change shouldn't be needed for your testing purposes too. It only
comes into picture once you enable OF_UPSTREAM. BTW, DT source files
in dts/upstream are strictly following/syncing against Linux kernel DT
sources. So all the custom U-Boot specific DT stuff belongs to
arch/${ARCH}/dts/.

-Sumit

>                 ccu: clock-controller@2001000 {
>                         compatible = "allwinner,sun20i-d1-ccu";
>                         reg = <0x2001000 0x1000>;
>
> --
> 2.45.1
>
