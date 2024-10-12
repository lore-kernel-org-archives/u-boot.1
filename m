Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3A2D1A42F
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 03:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1676C88C40;
	Sat, 12 Oct 2024 05:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728704295;
	bh=bf70R09N/UD5oTh40y3rDf1gInc5OuiEgvd0HgydHcc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hXQnDdmrdY+sKvbgqbHGUq00XwjsCSph2JJPJpZ0NmpGa28wWiRAM72Ie4aE5ttbW
	 SWvQ/B2VRZdJClPWx7aaTm3IjhYyuGJI5M0y4Lar3cLYukd50h6pCq9XHA3o8aMn7Q
	 sejf2fxF1V6lUu0WZzzLeDyFlBpkQL1uVYJ2zM/WqgmDe+WgBw1G7rFnTR1fzDu0uF
	 MIsU39ee+s/lhcxZx4JyieY5z9FAUGn/kj+jntYRLCPk1fdE1TjZmx7FDehzYNnqeu
	 ag4cu2OGFuGuhMj0vWukX72txqL6O7fPQoBZxmrx1+iV91JxpkooHQUKQ80YTi0KgM
	 EmFxvGtwF15PA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6A43688C60;
 Sat, 12 Oct 2024 05:38:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728704293;
 bh=bf70R09N/UD5oTh40y3rDf1gInc5OuiEgvd0HgydHcc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=faP4imuELJTarCIYtnqPbFMEeIV3peT2IfwyjPBoIEYFncj0J+O6tm8KuFBzz0Tot
 QZqQ8WncrygqJPPF5VwG7TSAX8Gu5UAsYbSbwqfDjQ1b86DdgSMtEZlEr6yEls9ltO
 LrAbnfifOJCm9ndmNxwr0DbqprxODqPU5mUo2q52jLePsm9QxahtvqIc8Lq3USqwEm
 7/IVwW4ybMIEhnGDADq3ui6p6PzQzPSUNUOzLR/7aE5uX4fDYUn1RpxBAoQ4NkCRj2
 ElqsHC9wlI77yvJ1g8+uvP7MBIZ0EOBz8gWAH9aWUuEGq8n9hzh6bU9tJGyCan0N4r
 9qbrt0Qh0HKTA==
Message-ID: <2eaba59e-bc6d-4ffc-b4eb-0eebc0b090a9@denx.de>
Date: Sat, 12 Oct 2024 05:37:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] usb: dwc3: fix dcache flush range calculation
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-0-5f3498d8035b@linaro.org>
 <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-2-5f3498d8035b@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241011-u-boot-dwc3-gadget-dcache-fixup-v4-2-5f3498d8035b@linaro.org>
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

On 10/11/24 4:38 PM, Neil Armstrong wrote:
> The current flush operation will omit doing a flush/invalidate on
> the first and last bytes if the base address and size are not aligned
> with CACHELINE_SIZE.
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
> index 04791d4c9be..0ede323671b 100644
> --- a/drivers/usb/dwc3/io.h
> +++ b/drivers/usb/dwc3/io.h
> @@ -50,6 +50,9 @@ static inline void dwc3_writel(void __iomem *base, u32 offset, u32 value)
>   
>   static inline void dwc3_flush_cache(uintptr_t addr, int length)
>   {
> -	flush_dcache_range(addr, addr + ROUND(length, CACHELINE_SIZE));
> +	uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
> +	uintptr_t end_addr = ALIGN((uintptr_t)addr + length, CACHELINE_SIZE);
> +
> +	flush_dcache_range((unsigned long)start_addr, (unsigned long)end_addr);
>   }
>   #endif /* __DRIVERS_USB_DWC3_IO_H */

You likely want a max(CONFIG_SYS_CACHELINE_SIZE, 
dwc3-buffer-alignment-requirement) to really correctly align the buffer.
