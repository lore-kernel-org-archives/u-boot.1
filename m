Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB02E77199
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 15:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66EC8801E8;
	Mon,  6 Jan 2025 16:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VkHOm1z4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 994768036B; Mon,  6 Jan 2025 16:12:44 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05FF5801C3
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 16:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 506FCd3S2717864
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 6 Jan 2025 09:12:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736176359;
 bh=FxGaUE5IV/f8CuRot6Em/dW9cx9Q5HNoQEefsfUYpjg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=VkHOm1z45yMd8KaK6jnhEUvuSwEbp51lBjzsEb94D7JzGSm4I7bXohwTavq20SkK1
 zv67MdVvIEX4QE1DDoh1NB6xnVPwEPczhUyayZ/fV5vt5evsYOHrn+uKTnT7f5Tdsk
 5Jfg2MceX5f3XMmh903Kag0gs2GDOs71mvdiVozE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 506FCdul068770;
 Mon, 6 Jan 2025 09:12:39 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Jan 2025 09:12:39 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Jan 2025 09:12:39 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 506FCclk127297;
 Mon, 6 Jan 2025 09:12:38 -0600
Message-ID: <19b20f10-9718-4c37-bea9-bd36bfff0125@ti.com>
Date: Mon, 6 Jan 2025 09:12:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch: arm: mach-k3: j784s4_init: Set CTRL_MMR for
 AUDIO_REFCLK1 clk_sel
To: Jayesh Choudhary <j-choudhary@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>
CC: <n-francis@ti.com>, <m-chawdhry@ti.com>, <sabiya.d@ti.com>
References: <20250106100400.93799-1-j-choudhary@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250106100400.93799-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 1/6/25 4:04 AM, Jayesh Choudhary wrote:
> The default value for the mux to select the parent clock,
> AUDIO_REFCLK1_CTRL_CLK_SEL is '11111' (31) but the mux input for 31
> is marked as 'Reserved' so the ti-sci-clk call for get-parent fails.
> Mark it to a valid value, '11100' (28) for MAIN_PLL4_HSDIV2_CLKOUT
> to get rid of the linux failures during boot-time like:

So the default value of the mux isn't known by firmware? Sounds like
a firmware issue..

No issue with using the bootloader to making the hardware's default state
more sane. Maybe just add a comment above the writel() line as right now
this is just writing a magic value to a magic address.

Andrew

> "[    1.573193] ti-sci-clk 44083000.system-controller:clock-controller:
>   get-parent failed for dev=157, clk=34, ret=-19"
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>   arch/arm/mach-k3/j784s4/j784s4_init.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/j784s4/j784s4_init.c b/arch/arm/mach-k3/j784s4/j784s4_init.c
> index 8a41cd3bb5..787cf6261e 100644
> --- a/arch/arm/mach-k3/j784s4/j784s4_init.c
> +++ b/arch/arm/mach-k3/j784s4/j784s4_init.c
> @@ -23,6 +23,9 @@
>   
>   #define J784S4_MAX_DDR_CONTROLLERS	4
>   
> +#define CTRL_MMR_CFG0_AUDIO_REFCLK1_CTRL	0x001082e4
> +#define AUDIO_REFCLK1_DEFAULT			0x1c
> +
>   /* NAVSS North Bridge (NB) */
>   #define NAVSS0_NBSS_NB0_CFG_MMRS		0x03702000
>   #define NAVSS0_NBSS_NB1_CFG_MMRS		0x03703000
> @@ -201,6 +204,8 @@ void k3_spl_init(void)
>   		remove_fwl_configs(navss_cbass0_fwls, ARRAY_SIZE(navss_cbass0_fwls));
>   	}
>   
> +	writel(AUDIO_REFCLK1_DEFAULT, (uintptr_t)CTRL_MMR_CFG0_AUDIO_REFCLK1_CTRL);
> +
>   	/* Output System Firmware version info */
>   	k3_sysfw_print_ver();
>   }
