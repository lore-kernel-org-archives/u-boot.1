Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45C8CEACEC
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 17:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B17B78922F;
	Tue,  1 Oct 2024 19:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727802533;
	bh=+Xc6XnMC82ZUWsikS3I+r9kW9t0fHJdMx09htY3mMUc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EW4aCxCOUzBbfj6EgDx4+i//k6T7R56RtaK7ttZ9YmduqlqkXNMaA0JdyX+jis3BW
	 fwvz3O4WPmjElewl2D4Iy0mkhPlBdOrQnTeXZONp53yJQI3U+gofEDAWsnnAHShbPa
	 3DfJQqu2xNZXkjElT5oQ1wKTMDu7Lz2oWBYLvixllAP+HFs+cvQKQDQEglV6sR1Y4e
	 x6P1Ijn3nrE8lAjPY5Vp7/EvWjmyxEvOB7Lalmy/dgtrcV6zVThF8waKETu72yO5mT
	 WD1DQqVqxUGSWn+F7zbBf0U8sMKwQnkPNgqokqFlakOxlx+vA6YXLrXEfwIwNyYNKt
	 j6h0Esyro40Rw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BF4EC89209;
 Tue,  1 Oct 2024 19:08:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727802533;
 bh=+Xc6XnMC82ZUWsikS3I+r9kW9t0fHJdMx09htY3mMUc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=p+7yuURj7DjF3OS6fPxvi+Lm1tf2Jrxc8xYWNdkDcLfE8AYS+1L7g0FUQ7ClCOMd5
 +qIGI3Oo15p38Kyogz+hoCSzqNclGZ+DtT417Q1s/WWsLu5SPp3r6AukbWRw8lCjXN
 IpkaEL16WuaiBhqx6a8CT3CJ2i5oOxCoX42LPy1dN1Bs+Xxnd8S1LfxdHbUt+7Cte+
 vKF0bi3CdLgV3nM6sfwjTC+TRm1g4SMiT/xeTk0e6HeJkrpm4EUoFeGNhqy7YhAhjJ
 9dKJWcptT5B0o4oCKwrTBL4YH7Qie/6vKrceB7ru3TzISkXSC1Os1ZoH1ZB/J0A+yr
 via5tOohSyLyw==
Message-ID: <19661704-b3ab-428a-902c-8628060ae60d@denx.de>
Date: Tue, 1 Oct 2024 17:47:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] usb: dwc3: fix dcache flush range calculation
To: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-0-65836d699a71@linaro.org>
 <20240724-u-boot-dwc3-gadget-dcache-fixup-v2-2-65836d699a71@linaro.org>
 <fc51702a-1609-4231-984f-fd24bd051c85@denx.de>
 <64a97d38-95bc-4b6f-9b90-33a5e339624e@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <64a97d38-95bc-4b6f-9b90-33a5e339624e@linaro.org>
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

On 10/1/24 5:32 PM, Neil Armstrong wrote:
> On 01/10/2024 17:21, Marek Vasut wrote:
>> On 7/24/24 5:48 PM, Neil Armstrong wrote:
>>> The current flush operation will omit doing a flush/invalidate on
>>> the first and last bytes if the base address and size are not aligned
>>> with DMA_MINALIGN.
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
>>> index 04791d4c9be..1aaf5413c6d 100644
>>> --- a/drivers/usb/dwc3/io.h
>>> +++ b/drivers/usb/dwc3/io.h
>>> @@ -50,6 +50,9 @@ static inline void dwc3_writel(void __iomem *base, 
>>> u32 offset, u32 value)
>>>   static inline void dwc3_flush_cache(uintptr_t addr, int length)
>>>   {
>>> -    flush_dcache_range(addr, addr + ROUND(length, CACHELINE_SIZE));
>>> +    uintptr_t start_addr = (uintptr_t)addr & ~(ARCH_DMA_MINALIGN - 1);
>>> +    uintptr_t end_addr = ALIGN((uintptr_t)addr + length, 
>>> ARCH_DMA_MINALIGN);
>>> +
>>> +    flush_dcache_range(start_addr, end_addr);
>> include/cpu_func.h:void flush_dcache_range(unsigned long start, 
>> unsigned long stop);
>>
>> So you shouldn't be feeding this function uintptr_t , right ?
> 
> uintptr_t is the right type to perform pointer calculation,
> I should probably cast it to unsigned long for flush_dcache_range.

Better fix flush_dcache_range(), using unsigned long there is not great, 
but that's for separate series from this bugfix.

> I'll do this in v2.
> 
>>
>> Also, why change CACHELINE_SIZE to ARCH_DMA_MINALIGN ?
> 
> Because all the memory allocated for DMA was done with dma_alloc_coherent()
> which uses ARCH_DMA_MINALIGN directly or indirectly.
> 
> I should probably remove CACHELINE_SIZE in the same patch.
And document this in the commit message, that's useful information.

Thanks
