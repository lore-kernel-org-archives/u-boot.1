Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1114AC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC98B60638;
	Mon, 24 Aug 2026 13:55:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CoSN-tsBcK_i; Mon, 24 Aug 2026 13:55:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787579750;
	bh=l4zQSFN6zNFbsloFIpUIdp4s2din4r11+UuycVQet8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nnXh6yN/g7y++sI19kXXvN9q4TuD2sUO4xILxm0EnUGGdH3lgIirsSJbPaKQZ3HbH
	 iFfbMf6GpnnbJi3IyEWxrPmcIDoEUWCQnvp/HlkWLIqvPuBFMZ0ZgFfnBfWWfyM1sD
	 rJJcgz1HNyjO5dyjqVacQWpx/v423PbFUUwENMJPQNrNND7EPPXaL9FEMW6ujgFjHx
	 i5NHcxlCxGDqkh8dR2t2RiXHXFM9DiPrv6TKFhwhZ66IE5//V97ukuKeGf6xowzL60
	 wv+t+JCVQnWj5DJCSkhZJAdc9NvkzBGc0QUx9Q1cwV4P85qdL+2gxRg1W2sZpaA6da
	 Ofa+MVqMvVWsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B1ED60624;
	Mon, 24 Aug 2026 13:55:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DB5E279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1FC6040639
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:55:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YibY4DdGcEqn for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:55:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62e; helo=mail-ej1-x62e.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=DyPyjRMT
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F24E940633
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:55:46 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c1f758014b8so376384366b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787579744; x=1788184544;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l4zQSFN6zNFbsloFIpUIdp4s2din4r11+UuycVQet8I=;
 b=DyPyjRMT4itTzcDgP8PC12swHRaIj7rUzxSTo3BNW8qNOnZmARqocRRjcsDcAUqgMo
 x/XoDwdwpoCgOkTBAxHq1odjAEoSSyCcwJgECailopkrRIoDeanTuCiU5brQobDmXy+8
 vDFoJp/PWxR/Q6I/m9YFFW7QufMyzb8xC0rTEw8eEibjr3RrfjV+i/6T8ifbKjxtnf7X
 k9jw7meI7IpTLu7st7Ff4288TqntJxh17ONeigyjkvahyJzdrgVmNzKgsiMBxhz9O4BS
 AJlwkzO3sBqmBcN3GXt6xMWnbaIplnzq+z8fd/6d1xfIth/QtXX7k/igY6B6waq62XoH
 LwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787579744; x=1788184544;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l4zQSFN6zNFbsloFIpUIdp4s2din4r11+UuycVQet8I=;
 b=pcFGmzxY+/tRPm87ewG0OtTEaWvaCnMXrcuVjVJ6067MIUR803sskV2A14olJgd6kS
 1npeOrNs10CeC5HsPXpNYfsvy/OLQiddnK1qWu4NJoIxWueTKuN56M0Vcc+JOSFh/dVZ
 XlMWXGJAWMmvZMipmP40y/KeP2tqPHhGfvhyRDkRt9aR8ShO2W9e8w/8Ehd9YuSlxMIs
 ED0/J/j8aGMFqlw/yL/x9SKCSHQdXnkd/rN7Eu5Fd9V/cGj0Wi9sNVVI4eU1iER4eOm+
 Yj/l+DCA+W4ckRfXDm2IK5b49l5dUMj72GkcTwFXFUR6fjx81+F0hgKjLsamewzKoZNO
 YUxg==
X-Gm-Message-State: AFuF++k8KAqNkGQ97ijfAW+Gd7/WCxg4BGWwOKQkUmYa1QaGy9YuWT7B
 LZlOgzAGOPAm/ki0iBrpzJtb3lyQLach9CDv4h8HwaJEp+XZLUVOLjQkyXu3jt+Bj4StE4sWgSl
 MnWwaggM=
X-Gm-Gg: AR+sD13YD6jlFlY3B1b6W8H+Z+OaZ9OEzv9+ET3okSfgIri3PvzyY5taD3MWXs7gjy8
 JB7je9uquYCRQlrmjB14fLX/nua/jW42IbRtgx+k+ZMaGuZJVmkDF4Y2bhnfwiHsODI3E3NcRHJ
 R0uTmwloIFAxK8YV+BFrCCjUdHDnjD7w/P07BJ9ee2v7U4Wp1uIAlICIj7wYtdEsVnP2Q9MLsg5
 2r9SAgJ3xHmJwY72EWcbgCOOctSPnanB09nZgRUMQY8OloVYFOTlzrISUwPSQxqDhHPOI2jcQDv
 UTfpbITFelBy7WytDJtGdOk4JPTCLYq0C1lAN0PDg+yDQLAIGBFdBCy5+AXDXKV50X4WF8Gpz8f
 CkS+A6JUunxzR029e3BSi0Bznz5iyXiBzsEH15eyc65/ImUR3oaK7fySjG2PFNph+uMxvNSd5Lz
 rX8q4D8YPFvD/Zuf38NRxdyf5oS4VaRz67L7abkL+bwKlak+8Sq7+5o0VWwIEZV0rPxB1L6MRUb
 UozngZRLA==
X-Received: by 2002:a17:907:ea8b:b0:c21:2c32:e2da with SMTP id
 a640c23a62f3a-c246a5f4515mr3342721166b.8.1787579743582; 
 Mon, 24 Aug 2026 06:55:43 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:8b5e:6b33:b439:3e9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496734bfcsm1379891366b.43.2026.08.24.06.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:55:42 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:55:36 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v5 10/13] arm: u8500: Switch Stemmy to upstream Janice
 device tree
Message-ID: <aoxNWLhEtchd5Q5X@linaro.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
 <20260823-ux500-external-sdcard-v5-10-07ca794e2b94@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823-ux500-external-sdcard-v5-10-07ca794e2b94@kernel.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sun, Aug 23, 2026 at 10:39:29PM +0200, Linus Walleij wrote:
> Use the upstream Samsung Janice device tree as the initial target for
> the Stemmy configuration. This also prepares the board to share the
> upstream Ux500 Samsung device trees with Linux.
> 
> U-Boot does not yet implement the U8500 clock providers used by the
> upstream device tree. Add a U-Boot-specific overlay with the known MTU
> clock rate and fixed input clocks for the external SD and internal eMMC
> controllers. Remove the superseded downstream Stemmy and DBx500 device
> tree files, and disable the unused WLAN SDIO controller for U-Boot.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  arch/arm/dts/Makefile                     |    1 -
>  arch/arm/dts/ste-dbx5x0-u-boot.dtsi       |   38 -
>  arch/arm/dts/ste-dbx5x0.dtsi              | 1144 -----------------------------
>  arch/arm/dts/ste-ux500-samsung-stemmy.dts |   36 -
>  arch/arm/dts/u8500-u-boot.dtsi            |   30 +
>  configs/stemmy_defconfig                  |    3 +-
>  6 files changed, 32 insertions(+), 1220 deletions(-)
> 
> [...]
> diff --git a/arch/arm/dts/ste-ux500-samsung-stemmy.dts b/arch/arm/dts/ste-ux500-samsung-stemmy.dts
> deleted file mode 100644
> index 14be86086b22..000000000000
> --- a/arch/arm/dts/ste-ux500-samsung-stemmy.dts
> +++ /dev/null
> @@ -1,36 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/dts-v1/;
> -
> -#include "ste-dbx5x0-u-boot.dtsi"
> -#include "ste-ab8500.dtsi"
> -
> -/ {
> -	compatible = "samsung,stemmy", "st-ericsson,u8500";
> -
> -	chosen {
> -		stdout-path = &serial2;
> -	};
> -
> -	soc {
> -		/* eMMC */
> -		mmc@80005000 {
> -			status = "okay";
> -
> -			arm,primecell-periphid = <0x10480180>;
> -			max-frequency = <100000000>;
> -			bus-width = <8>;
> -
> -			non-removable;
> -			cap-mmc-highspeed;
> -		};
> -
> -		/* Debugging console UART */
> -		uart@80007000 {
> -			status = "okay";
> -		};
> -
> -		mcde@a0350000 {
> -			status = "okay";
> -		};
> -	};
> -};
> diff --git a/arch/arm/dts/u8500-u-boot.dtsi b/arch/arm/dts/u8500-u-boot.dtsi
> new file mode 100644
> index 000000000000..9b69b4fd257e
> --- /dev/null
> +++ b/arch/arm/dts/u8500-u-boot.dtsi
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/ {
> +	/* FIXME: Remove this when the U8500 clock driver is implemented */
> +	sdmmcclk: sdmmcclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <100000000>;
> +	};
> +
> +	soc {
> +		mtu@a03c6000 {
> +			clock-frequency = <133000000>;
> +		};
> +
> +		mmc@80126000 {
> +			clocks = <&sdmmcclk>;
> +		};
> +
> +		mmc@80118000 {
> +			status = "disabled";
> +		};

Nitpick: Maybe you can add a comment here to explain this

			/* Typically SDIO, unneeded in U-Boot */

Although long-term I think we should try to drop all of these overrides
and handle workarounds in the board code or drivers if necessary. With
EFI, some people may try to boot generic distro images that don't
override the DTB, in that case Linux will boot with the original U-Boot
DTB. E.g. arch/arm/mach-snapdragon/of_fixup.c has some DTB workarounds
that are applied only to U-Boot and then discarded when booting Linux
with the U-Boot DTB.

But that's something for a future patch series, not this one. :-)

Thanks,
Stephan
