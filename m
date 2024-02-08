Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFDEC48260
	for <u-boot@archiver.kernel.org>; Thu,  8 Feb 2024 03:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FFE087D1F;
	Thu,  8 Feb 2024 04:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Zkq34rnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C25487D22; Thu,  8 Feb 2024 04:53:13 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 091598709C
 for <u-boot@lists.denx.de>; Thu,  8 Feb 2024 04:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707364387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FZ1/bhJD3xfOqBad0bUl0LHhAl2O8QFmg0EXy5MVoqc=;
 b=Zkq34rnKx5+BQB6O1hOAGmUeQOwVOkq8TJ8jqLj6/ToKlQQz4g0Wh7ypRWd+BijftmtsPm
 w7pBOYoldHGxGX4iKZ6vMjZC459VS7dFtfOoi6U6l0B/GZMm70GpWLMDrUevi9b3FHo3U4
 rYy6/74OOMcWpYWGjgbv22vn4zkYAKRc4klnulRrhwRXnr2eTGGiCz12U8e7YcK8Iklw0N
 QDWhcyAyRkrnTzsJoZhv9u3+NGo6Md+cxiR4dqzWaeLrqhyPyG6bDKZ3cfEiSeqedA+u3X
 QUEcqadXsLwlUUP8w8VsqgqonoLXysNYcu2hzU5f12WaBZtS5O+iwvp16JGkzQ==
Date: Thu, 08 Feb 2024 04:53:06 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 13/15] rockchip: rk3328: Add support to build bootable SPI
 image
In-Reply-To: <20240207000301.3270722-14-jonas@kwiboo.se>
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-14-jonas@kwiboo.se>
Message-ID: <72bd1e6d81755da0300a5da9a64b7408@manjaro.org>
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

Hello Jonas,

On 2024-02-07 01:02, Jonas Karlman wrote:
> Similar to RK35xx the BootRom in RK3328 can read all data and look for
> idbloader at 0x8000, same as on SD and eMMC.
> 
> Use the rksd format and modify the mkimage offset to generate a 
> bootable
> u-boot-rockchip-spi.bin that can be written to 0x0 of SPI NOR flash.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Could you, please, clarify a bit why the "rkspi" format isn't used
instead of "rksd"?

> ---
>  arch/arm/dts/rk3328-u-boot.dtsi        | 11 +++++++++++
>  arch/arm/mach-rockchip/rk3328/rk3328.c |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi 
> b/arch/arm/dts/rk3328-u-boot.dtsi
> index b90d78878d77..2a5dca97dd4b 100644
> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> @@ -120,3 +120,14 @@
>  &usb20_otg {
>  	hnp-srp-disable;
>  };
> +
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> +			offset = <0x8000>;
> +		};
> +	};
> +};
> +#endif
> diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c
> b/arch/arm/mach-rockchip/rk3328/rk3328.c
> index b591d38fe412..b82b209de9e2 100644
> --- a/arch/arm/mach-rockchip/rk3328/rk3328.c
> +++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
> @@ -36,6 +36,7 @@
> 
>  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff520000",
> +	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff190000/flash@0",
>  	[BROM_BOOTSOURCE_SD] = "/mmc@ff500000",
>  };
