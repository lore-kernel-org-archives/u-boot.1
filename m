Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14CBCA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 22:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53C4788ABA;
	Tue,  3 Sep 2024 00:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 426C0882EF; Tue,  3 Sep 2024 00:36:33 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 1671288C4A
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 00:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC06FFEC;
 Mon,  2 Sep 2024 15:36:56 -0700 (PDT)
Received: from [192.168.178.92] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 0ED1E3F73F; Mon,  2 Sep 2024 15:36:27 -0700 (PDT)
Message-ID: <da37e3ed-c256-4fd3-b397-e7ad9a17ba42@arm.com>
Date: Mon, 2 Sep 2024 23:36:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH V3 5/9] sunxi: H616: dram: Update mbus priorities
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, jernej.skrabec@gmail.com, neil.armstrong@linaro.org,
 hdegoede@redhat.com, jagan@amarulasolutions.com, trini@konsulko.com,
 ryan@testtoast.com, iuncuim@gmail.com, sumit.garg@linaro.org,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240830155514.481410-1-macroalpha82@gmail.com>
 <20240830155514.481410-6-macroalpha82@gmail.com>
Content-Language: en-US
In-Reply-To: <20240830155514.481410-6-macroalpha82@gmail.com>
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

Hi,

On 30/08/2024 16:55, Chris Morgan wrote:
> From: Jernej Skrabec <jernej.skrabec@gmail.com>
> 
> CSI1 channel (22) is missing and IOMMU (25) has priority flag set in
> vendor bootloader. Fix that.
> 
> While at it, replace bandwidth flag with priority since original flag has
> always value "true".

I cannot confirm what the vendor bootloader does, nor whether this is 
correct, but it seems to still work, and the patch does exactly what the 
commit message claims. So:

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Tested-by: Chris Morgan <macromorgan@hotmail.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>   arch/arm/mach-sunxi/dram_sun50i_h616.c | 41 +++++++++++++-------------
>   1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h616.c b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> index 4782e6fe38..863c4f1d7a 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h616.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h616.c
> @@ -55,8 +55,8 @@ static void mbus_configure_port(u8 port,
>   	writel_relaxed(cfg1, &mctl_com->master[port].cfg1);
>   }
>   
> -#define MBUS_CONF(port, bwlimit, qos, acs, bwl0, bwl1, bwl2)	\
> -	mbus_configure_port(port, bwlimit, false, \
> +#define MBUS_CONF(port, priority, qos, acs, bwl0, bwl1, bwl2)	\
> +	mbus_configure_port(port, true, priority, \
>   			    MBUS_QOS_ ## qos, 0, acs, bwl0, bwl1, bwl2)
>   
>   static void mctl_set_master_priority(void)
> @@ -68,24 +68,25 @@ static void mctl_set_master_priority(void)
>   	writel(399, &mctl_com->tmr);
>   	writel(BIT(16), &mctl_com->bwcr);
>   
> -	MBUS_CONF( 0, true, HIGHEST, 0,  256,  128,  100);
> -	MBUS_CONF( 1, true,    HIGH, 0, 1536, 1400,  256);
> -	MBUS_CONF( 2, true, HIGHEST, 0,  512,  256,   96);
> -	MBUS_CONF( 3, true,    HIGH, 0,  256,  100,   80);
> -	MBUS_CONF( 4, true,    HIGH, 2, 8192, 5500, 5000);
> -	MBUS_CONF( 5, true,    HIGH, 2,  100,   64,   32);
> -	MBUS_CONF( 6, true,    HIGH, 2,  100,   64,   32);
> -	MBUS_CONF( 8, true,    HIGH, 0,  256,  128,   64);
> -	MBUS_CONF(11, true,    HIGH, 0,  256,  128,  100);
> -	MBUS_CONF(14, true,    HIGH, 0, 1024,  256,   64);
> -	MBUS_CONF(16, true, HIGHEST, 6, 8192, 2800, 2400);
> -	MBUS_CONF(21, true, HIGHEST, 6, 2048,  768,  512);
> -	MBUS_CONF(25, true, HIGHEST, 0,  100,   64,   32);
> -	MBUS_CONF(26, true,    HIGH, 2, 8192, 5500, 5000);
> -	MBUS_CONF(37, true,    HIGH, 0,  256,  128,   64);
> -	MBUS_CONF(38, true,    HIGH, 2,  100,   64,   32);
> -	MBUS_CONF(39, true,    HIGH, 2, 8192, 5500, 5000);
> -	MBUS_CONF(40, true,    HIGH, 2,  100,   64,   32);
> +	MBUS_CONF(0, false, HIGHEST, 0,  256,  128,  100);
> +	MBUS_CONF(1, false,    HIGH, 0, 1536, 1400,  256);
> +	MBUS_CONF(2, false, HIGHEST, 0,  512,  256,   96);
> +	MBUS_CONF(3, false,    HIGH, 0,  256,  100,   80);
> +	MBUS_CONF(4, false,    HIGH, 2, 8192, 5500, 5000);
> +	MBUS_CONF(5, false,    HIGH, 2,  100,   64,   32);
> +	MBUS_CONF(6, false,    HIGH, 2,  100,   64,   32);
> +	MBUS_CONF(8, false,    HIGH, 0,  256,  128,   64);
> +	MBUS_CONF(11, false,    HIGH, 0,  256,  128,  100);
> +	MBUS_CONF(14, false,    HIGH, 0, 1024,  256,   64);
> +	MBUS_CONF(16, false, HIGHEST, 6, 8192, 2800, 2400);
> +	MBUS_CONF(21, false, HIGHEST, 6, 2048,  768,  512);
> +	MBUS_CONF(22, false,    HIGH, 0,  256,  128,  100);
> +	MBUS_CONF(25, true,  HIGHEST, 0,  100,   64,   32);
> +	MBUS_CONF(26, false,    HIGH, 2, 8192, 5500, 5000);
> +	MBUS_CONF(37, false,    HIGH, 0,  256,  128,   64);
> +	MBUS_CONF(38, false,    HIGH, 2,  100,   64,   32);
> +	MBUS_CONF(39, false,    HIGH, 2, 8192, 5500, 5000);
> +	MBUS_CONF(40, false,    HIGH, 2,  100,   64,   32);
>   
>   	dmb();
>   }
