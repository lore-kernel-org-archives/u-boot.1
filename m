Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977D5CEACD5
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 15:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66AEA8922A;
	Tue,  1 Oct 2024 17:27:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727796437;
	bh=I7Oyh0PXcVXdHGgnRfPU0skNt2ZbzEP73IwZE4T55sI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ntmutIRjZvQMfBVJtGKfZ+o9+QVQjO8SJ6pRPTUbdNF88aeDAdNO9PXWrqvw/LTYG
	 VJwqyGiUzkuAGivaWY8csnrvrXz7e/DVxzYgdplz38HxwnAvJy51va+5+hr7aNxh0s
	 Hak3f6aeQlZWvtFAy2+B8zNk97zSgKcgDKlf0z518IHHo1g9diFuImkwZgQomoqZrC
	 MeAvQSMHTwLR2Y5nyzhfD9buX568VhMlZ5nAdkuvFWlcBC3+uA/CvfahVhIQShXXnt
	 Fe0t8hxXUXJ5YRho7zXDnqt29N/ImWqoJKOs2LsKHT8PiQALKlOGw+Tf7NSbdwvOoK
	 ltJWrJ/BeEKSA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 47EC189222;
 Tue,  1 Oct 2024 17:27:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727796435;
 bh=I7Oyh0PXcVXdHGgnRfPU0skNt2ZbzEP73IwZE4T55sI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TF04nGn9GjvpNkQ0JcZZQN694jqoSaWxsQfaY4ENyJMm1/jlA4Mkg+SHVhbYDjaQb
 w1Yx9/BINJzVb1vG5veVI9k4TEz5u7GJJH2CtwWFK9TO58RwSHtPDRqCi99yfNxDOx
 anWXAKFSPyO/kNi26rLOqfF5cnAQfvbm9SGuSJQTaXfd91fJ1iVQrvd1ix+w371PVr
 r4sT0xLLgMydCb3R+BLpv8i9njVzwYLUxN01v5vxSgYo5+FOpUoSrD7OfqKGPVoVak
 GTLEo86+JAnhJxAJEi6/ghTkqxFF4UBDxnZfYMWuwLMIfcBkM46CoNFq4etUadexd0
 PWzeMznMzlrIg==
Message-ID: <fc51702a-1609-4231-984f-fd24bd051c85@denx.de>
Date: Tue, 1 Oct 2024 17:21:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] usb: dwc3: fix dcache flush range calculation
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-0-65836d699a71@linaro.org>
 <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-2-65836d699a71@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-2-65836d699a71@linaro.org>
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

On 7/24/24 5:48 PM, Neil Armstrong wrote:
> The current flush operation will omit doing a flush/invalidate on
> the first and last bytes if the base address and size are not aligned
> with DMA_MINALIGN.
> 
> This causes operation failures Qualcomm platforms.
> 
> Take in account the alignment and size of the buffer and also
> flush the previous and last cacheline.
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/usb/dwc3/io.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
> index 04791d4c9be..1aaf5413c6d 100644
> --- a/drivers/usb/dwc3/io.h
> +++ b/drivers/usb/dwc3/io.h
> @@ -50,6 +50,9 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
>   
>   static inline void dwc3_flush_cache(uintptr_t addr, int length)
>   {
> -	flush_dcache_range(addr, addr + ROUND(length, CACHELINE_SIZE));
> +	uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
> +	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, ARCH_DMA_MINALIGN);
> +
> +	flush_dcache_range(start_addr, end_addr);
include/cpu_func.h:void flush_dcache_range(unsigned long start, unsigned 
long stop);

So you shouldn't be feeding this function uintptr_t , right ?

Also, why change CACHELINE_SIZE to ARCH_DMA_MINALIGN ?
