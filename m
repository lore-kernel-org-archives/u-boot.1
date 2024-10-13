Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D849ACF258E
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 21:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ADF589103;
	Sun, 13 Oct 2024 23:10:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728853846;
	bh=3ydDhu+rCssZMUVUSvszG+5v9Ou6HFWHbcRPlq6AScE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PPLp5e4H3gyXUIBYql3fcdk8JnoShnCg341WbHg93hGWvJiNMjG5zZ/QG2MocHtkd
	 z36jojs8Xu51k3x1PzwmnfyP8PZ0LsBt5JU7dglegRQ4/hMxaeVAXW0pF/V5cvudQy
	 65cRrfFPsPb2Hlr9Ul4363vhh3Lrcze95dlfzhrbh56j2+CC96SW4BJQc7aSDqdZik
	 jHxXL9iqtsfS+gK8bCFxePj/ziA+CkadxHlCjgn/2+iSPjtTaW7hBxZmAtSL9CQ0Oc
	 rFZ5eobK15SOjNCkOFygk4J6+WHQv4GaJheu76td5cHNwfMnYF9Cei+AZ8KddVuZoa
	 lQAZhhmnxnmIA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B8F17890D8;
 Sun, 13 Oct 2024 23:10:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728853844;
 bh=3ydDhu+rCssZMUVUSvszG+5v9Ou6HFWHbcRPlq6AScE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oUvvMtASI12E3+QaIH02xlQU7gRh4d/4nqb9JIsRh6rJhJQQzeETlr2kxmzjIJru6
 WkKU16serfgWbr4LNoWyVqv5DPQ70MtqNk18j21fuuBbDSg8+7laUdYDslqadmBqu2
 CXYpjzhGEycwPTi3uK82GOWfNt/V7UpVHjlHb+MJT/KKjom9Dcvha/Umgmys5Td+eD
 h67l0BuQpeiuClxrkZuO4W6tVGNBHwOsjHRe4iupBgv61k/IWO56zalwNl0LrW36tH
 ht28KD2kDT8tIsmR1ND91HHdipNHMPFuHT4nrgs+SUi7Q5imT+uv6ktJ0OxH59uRUI
 l83sJVMiJ5ZAw==
Message-ID: <39ec8f6b-3700-4a4d-9403-63be32a9c184@denx.de>
Date: Sun, 13 Oct 2024 22:37:49 +0200
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
 <2eaba59e-bc6d-4ffc-b4eb-0eebc0b090a9@denx.de>
 <99d3fe30-78c0-4bed-9bbb-299c5058034b@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <99d3fe30-78c0-4bed-9bbb-299c5058034b@linaro.org>
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

On 10/13/24 6:35 PM, Neil Armstrong wrote:
> Hi,
> 
> Le 12/10/2024 à 05:37, Marek Vasut a écrit :
>> On 10/11/24 4:38 PM, Neil Armstrong wrote:
>>> The current flush operation will omit doing a flush/invalidate on
>>> the first and last bytes if the base address and size are not aligned
>>> with CACHELINE_SIZE.
>>>
>>> This causes operation failures Qualcomm platforms.
>>>
>>> Take in account the alignment and size of the buffer and also
>>> flush the previous and last cacheline.
>>>
>>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>>   drivers/usb/dwc3/io.h | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/dwc3/io.h b/drivers/usb/dwc3/io.h
>>> index 04791d4c9be..0ede323671b 100644
>>> --- a/drivers/usb/dwc3/io.h
>>> +++ b/drivers/usb/dwc3/io.h
>>> @@ -50,6 +50,9 @@ static inline void dwc3_writel(void __iomem *base, 
>>> u32 offset, u32 value)
>>>   static inline void dwc3_flush_cache(uintptr_t addr, int length)
>>>   {
>>> -    flush_dcache_range(addr, addr + ROUND(length, CACHELINE_SIZE));
>>> +    uintptr_t start_addr = (uintptr_t)addr & ~(CACHELINE_SIZE - 1);
>>> +    uintptr_t end_addr = ALIGN((uintptr_t)addr + length, 
>>> CACHELINE_SIZE);
>>> +
>>> +    flush_dcache_range((unsigned long)start_addr, (unsigned 
>>> long)end_addr);
>>>   }
>>>   #endif /* __DRIVERS_USB_DWC3_IO_H */
>>
>> You likely want a max(CONFIG_SYS_CACHELINE_SIZE, dwc3-buffer- 
>> alignment-requirement) to really correctly align the buffer.
> 
> No this change is related to the system cacheline to properly flush/ 
> invalidate the data
> to the system memory, the dwc3 buffer alignment (if there's one) should 
> be handled
> when allocating the memory, but here we're using dma_alloc_coherent() which
> use DMA_MINALIGN.

OK

Reviewed-by: Marek Vasut <marex@denx.de>
