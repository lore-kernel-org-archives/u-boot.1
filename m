Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D54BD2127F
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 11:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A053888E5C;
	Thu, 17 Oct 2024 13:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l1OQlRbg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A832888EDD; Thu, 17 Oct 2024 13:32:51 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FD29885C5
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 13:32:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c9c28c1e63so837910a12.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 04:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729164767; x=1729769567; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CquahCZI1ld3FGNqvbWcHBVnZG2WXf2EBT+kXuypGsg=;
 b=l1OQlRbgVJSm5DTStWyWaFdYaQUXSZj8nf833ji31rQFhpLxF9gxubM8PpZZIkV+Fo
 Fqv2HtDFYN89+oQJyTk6h6hGKZf+UwZqb9WFJS6h8YacvS6xSuMtdew86tJw8KcAq8Le
 YQEye5yly36N6ZX9JfS/VSxD83fHPxd+Y7oBEsXZXALQFuSP4p4gVdJM6E5UhxLpIhlo
 jtmQLbv//J/UYeiE5sN7IYSN1KXhepuDOdv/2FwGi1WUG7GUWYMpg+Gi7IO+2I0Ihrg+
 gsrjA8+C0WsBVlfskGqruG2/NOlwiChQigmps2FFzTG63neBwxONT/RrxNUE4wtp/pe/
 tB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729164767; x=1729769567;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CquahCZI1ld3FGNqvbWcHBVnZG2WXf2EBT+kXuypGsg=;
 b=SGLnho3T0tJecERK2lG32ICaicfj04dTbUqqOnWEq+032Xc9iah2JDZs5v9NBZYQYM
 ustVTX9kd9K3LAU+wFr+viml2bZlyE3iBLFfykanHXUrl8qewBL27tjaMPL400hxC4ju
 K10sKoX8jQpE/js+yWFbPPoWAKJhe28nCxQanb6QeLA18eflOplgUdow6HKWb/xHNB/z
 KTlO2KZsZyCr7m0GgRCcDq8GMo6Y/ej0XgT//3Cy0kA3NaeYqD1jF1MH1CbTEEbgP6zS
 eiUscBrCMPXNqr3Q40fUnHWsJ2kV+4RWnbNV17nU1HEu2qPuVMDpfYw2SJm6RDwaRF+c
 QhNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZZFxzCJ42xCh7zbc/5sCLvA9pig2nwuvRzBhMDYKD4f2wtXh0Dzei6fNBaVeWxCPZZkZPQL0=@lists.denx.de
X-Gm-Message-State: AOJu0YwQEwaAcb70Dwln/OuoWX6x4OC10JLcHzRhsJcN1JPBjEMdUvSc
 McLeLqq17NCBSoyKS/uvtBxYfvh5kVaIcTltef1v/CQplZpeB0rwBhwmmYIM6sLzKAG2rd8N82K
 5P5gvRIkxK/C1VimGt8i2++R5B+E=
X-Google-Smtp-Source: AGHT+IHkqva+O46pqHDbK6zve6QzTIPMKSzgeg0lY45kflXAU9nhnuERGi1Qrwwr83i5917xildvHepAH3F945YEHGg=
X-Received: by 2002:a05:6402:27d0:b0:5c9:753f:5aae with SMTP id
 4fb4d7f45d1cf-5c9753f5da6mr11473362a12.15.1729164766892; Thu, 17 Oct 2024
 04:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241016201413.903112-1-jonas@kwiboo.se>
In-Reply-To: <20241016201413.903112-1-jonas@kwiboo.se>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 17 Oct 2024 12:32:35 +0100
Message-ID: <CALeDE9NxwFmhcDEu6gvf4Pd-UFaykegr22i3BkRKegTUis4XGw@mail.gmail.com>
Subject: Re: [PATCH] rockchip: rk3588-rock-5b: Drop upstream props from
 u-boot.dtsi
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Eugen Hristev <eugen.hristev@collabora.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, 16 Oct 2024 at 21:32, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The SPI flash node has been added in upstream DT, drop all props beside
> bootph-* props from the SPI flash related nodes in u-boot.dtsi.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  arch/arm/dts/rk3588-rock-5b-u-boot.dtsi | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> index 4dd17ff408cb..3ff3bb64e4f7 100644
> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
> @@ -16,18 +16,9 @@
>  };
>
>  &sfc {
> -       pinctrl-names = "default";
> -       pinctrl-0 = <&fspim2_pins>;
> -       status = "okay";
> -
>         flash@0 {
> -               compatible = "jedec,spi-nor";
> -               reg = <0>;
>                 bootph-pre-ram;
>                 bootph-some-ram;
> -               spi-max-frequency = <24000000>;
> -               spi-rx-bus-width = <4>;
> -               spi-tx-bus-width = <1>;
>         };
>  };
>
> --
> 2.46.2
>
