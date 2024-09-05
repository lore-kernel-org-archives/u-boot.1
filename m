Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1669CD98FE
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 18:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22E9788CC4;
	Thu,  5 Sep 2024 20:28:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725560933;
	bh=pAwIbnhXZV41uTIoBT3yJlNRF4et1bhQ/eQUgeKAKPI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pHXF16n8pPpawPURE89r2h+JXY1mOsfHHItHtCO/hbspINF9p2kXsSNXsWSjq7YDp
	 Gfhe/N9KKVOE3u7RX/JyonTjjV4I4ECKIo3fekrVPeAb/1cADUm2ti+H2HIQ2QA41t
	 VxJ9XBVkr7mqmoB6yGuRe7r+rE1grM3qnNcnp1+L0ccDeEgbltsXsglIeY271dC1ih
	 KrCfWVCF/kQBb7o71WUnqaz3UYnIpxoajLs9DSHuww9vZ4KI6YDV+irtAUmj0N9gZ/
	 SWitl/unlUrHZvzIPyj7K6/43H2mSf6Bh8QUBv2MS13PDi78Qa2mBMomQV2Ww8ShIu
	 GsErSltYGYrAw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id AD484889C3;
 Thu,  5 Sep 2024 20:28:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1725560932;
 bh=pAwIbnhXZV41uTIoBT3yJlNRF4et1bhQ/eQUgeKAKPI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ofvNB5Y81i5rVpkglRTCvWwQIRtub3LO8KewWS3GZs6kV2zZcyy9zHydqExun4qxk
 haKkQL5Csfqo68k6C+e3+f9cfdDYD86XiGHZ17ABp1p3MiAUhBvz3AP9fbe/k6MKyK
 CuPctZKoHPuECbye7CnYPenNI/p5fPt47fY25LN6uxuy4NOdPj4dxzoFW4WmGZibJk
 hLqsDAI3VDGt4DTTvLyTtJapHJFjDWvlMcU5OIIV3AlqsGD1xY/ZCWZq56t2TJ2uSy
 +B/lAz3wvWr+d57uYZK74vkJQKFutiy14RJ9AyrVQxmK4VGIMMd4xovlMfkOAveD+7
 jG5+neYhdv+Ag==
Message-ID: <dbcdcc5e-6f93-4f5e-911d-50b54bc584fa@denx.de>
Date: Thu, 5 Sep 2024 17:36:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: imx: Enable MMU and dcache very early on i.MX8M
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20240827200400.217058-1-marex@denx.de>
 <CAOMZO5CXfVAXnyZ9s5dZdHbK+QLJZvmP5UeUaz=Bkv3mtbxc4g@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5CXfVAXnyZ9s5dZdHbK+QLJZvmP5UeUaz=Bkv3mtbxc4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/31/24 1:16 PM, Fabio Estevam wrote:
> Hi Marek,
> 
> On Tue, Aug 27, 2024 at 5:04 PM Marek Vasut <marex@denx.de> wrote:
> 
>> +/*
>> + * Place early TLB into the .data section so that it will not
>> + * get cleared, use 16 kiB alignment.
>> + */
>> +#define EARLY_TLB_SIZE SZ_64K
>> +u8 early_tlb[EARLY_TLB_SIZE] __section(".data") __aligned(0x4000);
> 
> This causes a CI failure:
> 
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/895190/raw
> 
>     aarch64:  +   imx8mp_beacon
> +arch/arm/mach-imx/imx8m/soc.c:602:24: error: 'SZ_64K' undeclared here
> (not in a function)
> +  602 | #define EARLY_TLB_SIZE SZ_64K
> +      |                        ^~~~~~
> +arch/arm/mach-imx/imx8m/soc.c:603:14: note: in expansion of macro
> 'EARLY_TLB_SIZE'
> +  603 | u8 early_tlb[EARLY_TLB_SIZE] __section(".data") __aligned(0x4000);
> +      |              ^~~~~~~~~~~~~~
> +make[3]: *** [scripts/Makefile.build:257:
> arch/arm/mach-imx/imx8m/soc.o] Error 1
> +make[2]: *** [scripts/Makefile.build:397: arch/arm/mach-imx/imx8m] Error 2
> +make[1]: *** [Makefile:1897: arch/arm/mach-imx] Error 2
> +make: *** [Makefile:177: sub-make] Error 2
> 
> Please take a look.

Missing linux/sizes.h , fixed in V2, thanks.
