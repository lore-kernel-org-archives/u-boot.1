Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930B9CF6D28
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 15:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8907D89323;
	Wed,  2 Oct 2024 17:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727881274;
	bh=arg62nVKG74HPWXpzaDJKAstyelZLMfdHhiX1+MsgBw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mWcxrF4Jj3ZGONFi7BeIIHH5h45+5E1SAHJeNenIF68oAESyitgzLgKdBTkWHJ0xY
	 Kx2nteo31h3HIiZlKlcVl8X593qYRWBqLMQep8f6di1UK+T6uIk1W7iO91IjSeSN0n
	 7Yts6tviooZMCD/GtOtfimY9MhRnkBCzDZy72zVE0zi1aKiCWv0MjbY17eiJaG0egb
	 /tlgRxcpGKLxDQMyY06eMTDonOeenp1+Jr8Ht3srtkunRzGXZfi3S5y5IEzl6trC9z
	 Sb6oVP9eSuqgT3T7/bN244dF2D8YKt94MrU1CZMXf+7qG0yHsojzkvK2TFrZ/W3+c7
	 Tp4OC+8k7JEIg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 77BE189315;
 Wed,  2 Oct 2024 17:01:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727881272;
 bh=arg62nVKG74HPWXpzaDJKAstyelZLMfdHhiX1+MsgBw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=B5det1odNn/2LgvKy1x1l8Ux4ikTJOKFEB1jFQlB5DtcczCu20EX9MV0BPh2Ry0kD
 1lnemryEpuA1c0LOYDp+Q8ZnA+9hOZiURA4rEC/WDrnupg6DtEHxpBQZB5wY//3IfR
 f8ZR1Hj8CBCALjWzgigPOo7lm8CJBJ3tA5rkfXfUf2ofqP4rtyWMLsEpBgWDPzdcAm
 q8qkIZ/ac6VpXm1V6NzctVeZS0P7sp5OyxqT97IeVth12m14AHoiq3MezkzTsUi7hR
 vIqvODarhtxMUm3o7F8LzVj3/GrgTubVs1rSvejI2YjW8+r8DaUG3HSF/5EH3VVagI
 YJHCYocsZA8yQ==
Message-ID: <e895c917-ca32-4b59-a5d6-7d8e9ce19d84@denx.de>
Date: Wed, 2 Oct 2024 16:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] usb: dwc3: fix dcache flush range calculation
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-0-5398088ef93c@linaro.org>
 <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-2-5398088ef93c@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-2-5398088ef93c@linaro.org>
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

On 10/2/24 4:39 PM, Neil Armstrong wrote:
> The current flush operation will omit doing a flush/invalidate on
> the first and last bytes if the base address and size are not aligned
> with DMA_MINALIGN.
> 
> This causes operation failures Qualcomm platforms.
> 
> Take in account the alignment and size of the buffer and also
> flush the previous and last cacheline.
> 
> Remove CACHELINE_SIZE which was the same as DMA_MINALIGN.

It isn't the same, CACHELINE_SIZE was set to CONFIG_SYS_CACHELINE_SIZE 
(CPU L1 cache cacheline length) while ARCH_DMA_MINALIGN is DMA engine 
alignment requirement (from times where there used to be one DMA engine 
on most devices). You likely want a max(CONFIG_SYS_CACHELINE_SIZE, 
dwc3-buffer-alignment-requirement) to really correctly align the buffer.

> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/usb/dwc3/io.h | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
> index 04791d4c9be..a6c2bb0f47d 100644
> --- a/drivers/usb/dwc3/io.h
> +++ b/drivers/usb/dwc3/io.h
> @@ -20,7 +20,6 @@
>   #include <cpu_func.h>
>   #include <asm/io.h>
>   
> -#define	CACHELINE_SIZE		CONFIG_SYS_CACHELINE_SIZE
>   static inline u32 dwc3_readl(void __iomem *base, u32 offset)
>   {
>   	unsigned long offs = offset - DWC3_GLOBALS_REGS_START;
> @@ -50,6 +49,9 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
>   
>   static inline void dwc3_flush_cache(uintptr_t addr, int length)
>   {
> -	flush_dcache_range(addr, addr + ROUND(length, CACHELINE_SIZE));
> +	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
> +	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, ARCH_DMA_MINALIGN);
> +
> +	flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
>   }

