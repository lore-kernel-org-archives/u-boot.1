Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FE8D1813A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 18:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3585988FC8;
	Mon, 14 Oct 2024 20:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728931326;
	bh=c/BlabNeano1Ml1runCGnuy5uoMp9FmXqEPrfbqX6TI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zcO29NuveBr5fiqmOvujD6PTaTP/X+bp3gEXZP7pQpkKrPkDCpulN4itDrIbmnsdM
	 xYTZRXNGX7IskhBHX4IFNj4DxsD3L680rQ9oWwuPMsA8mHsgM96n5tx9gxlRAAp1Z9
	 v3AqDsj0AWPg4xOF80CEHesdwD2tPnRdQms6+Mq3OQFRcG4r45c/1YYvWJKDQOKb46
	 BKlY0doDZpQjQD9ldLTvwYC1hAyNXNR0BgTnvRE/skjR0wfBid5R4Pn2OqJ+J5/uIH
	 14igQL63XJjeSBt1Wohts1GlYxosycsLW10TdIwsqf6aT85yu9woNqoQYb+DJgi6ef
	 AtK8gXX1+Ofkg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A3EF588CA1;
 Mon, 14 Oct 2024 20:42:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728931324;
 bh=c/BlabNeano1Ml1runCGnuy5uoMp9FmXqEPrfbqX6TI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=T8oQCmpNjNeOtv4tPFn5359bEogHKXUBUfzHkXOz2KoAtJpluT7Ep5aklsuHRjSGZ
 x/9yBfjAFVx9eSEGU5NkaLngL+yvptfpE39q1XtERgZX1wwyNDqyeoFbwjXF7T0fy7
 2jo5+N29XyRSf5TQ/pfBbnk+beUxhFewdD8FInn5RUzTRgjepovBzRKn/9tCfZV3wp
 QHnIXfTwN7iA4mGpERH4knlKeiK5wRJLTBAo9TdgNA9cdK+Q1F2HxQKNlCGAgkyh+9
 ZeiKaAdoxchH6XABa3wz+oHfJJKtxdSfEL2oALSRTHuxWKuFtBrIb3yixua6UApyEh
 YCLn6Qx7gmFXw==
Message-ID: <5e52d3d1-51d7-4e93-b5ad-b3782e157dac@denx.de>
Date: Mon, 14 Oct 2024 19:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] ARM: dts: socfpga: add Mercury+ AA1 for u-boot dts
To: Lothar Rubusch <l.rubusch@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, simon.k.r.goldschmidt@gmail.com,
 tien.fong.chee@intel.com, sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
 <20241013143232.2090645-4-l.rubusch@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241013143232.2090645-4-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/13/24 4:32 PM, Lothar Rubusch wrote:

[...]

> diff --git a/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
> new file mode 100644
> index 0000000000..1b29ab9358
> --- /dev/null
> +++ b/arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
> + */
> +
> +/dts-v1/;
> +
> +/* The arria10 family */
> +#include "socfpga/socfpga_arria10_mercury_aa1.dtsi"
> +
> +/ {
> +	aliases {
> +		ethernet0 = &gmac0;
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		i2c0 = &i2c1;
> +		i2c1 = &i2c0;
> +		spi0 = &qspi;
> +	};
> +};
> +
> +&qspi {
> +	bootph-all;
> +	status = "okay";
> +	flash0: s25fl512s@0 {
> +		bootph-all;
> +
> +		cdns,page-size = <256>;
> +		cdns,block-size = <16>;
> +
> +		cdns,tshsl-ns = <200>;
> +		cdns,tsd2d-ns = <255>;
> +		cdns,tchsh-ns = <20>;
> +		cdns,tslch-ns = <20>;
> +	};
> +};
> +
> +/* Carrier board support */
> +#if IS_ENABLED(CONFIG_ENCLUSTRA_PE1)
> +# include "socfpga/socfpga_enclustra_mercury_pe1.dtsi"
> +#elif IS_ENABLED(CONFIG_ENCLUSTRA_PE3)
> +# include "socfpga/socfpga_enclustra_mercury_pe3.dtsi"
> +#elif IS_ENABLED(CONFIG_ENCLUSTRA_ST1)
> +# include "socfpga/socfpga_enclustra_mercury_st1.dtsi"
> +#endif

Can this be moved to socfpga_arria10_mercury_aa1-u-boot.dtsi instead , 
as this is likely not going to be part of the upstream 
socfpga_arria10_mercury_aa1.dts ?

[...]

> diff --git a/board/enclustra/mercury_aa1/MAINTAINERS b/board/enclustra/mercury_aa1/MAINTAINERS
> index 80fcda639a..118968126a 100644
> --- a/board/enclustra/mercury_aa1/MAINTAINERS
> +++ b/board/enclustra/mercury_aa1/MAINTAINERS
> @@ -1,6 +1,8 @@
>   Enclustra Mercury+ AA1
>   M:	Lothar Rubusch <l.rubusch@gmail.com>
>   S:	Maintained
> +F:	arch/arm/dts/socfpga_arria10_enclustra_mercury_aa1.dts
> +F:	arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h

Are the F:s needed with the N:s below ?

>   F:	board/enclustra/mercury_aa1/
>   F:	board/enclustra/common/
>   F:	configs/socfpga_enclustra_mercury_aa1_defconfig

[...]
