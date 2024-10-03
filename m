Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B104CCF34A9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 13:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA26488C78;
	Thu,  3 Oct 2024 15:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727961599;
	bh=qMItSw8Ok4fBK8kIBePhHMwOO2oDzNiElGQenycfDoQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wdi0FeX2AQSpNoFwaxbhBgTaZ5Qq3qhqHMJdIAGAcKe37coLRQewid4FZax8AONDb
	 O98YOWBgUI2IbFezigRmc1KV0xqfZHK92wOlls7JQsKVCOmpQrDLFbWTI7r4Uow16d
	 wPdNQ7fp1eUdY/ezqKPuL2SJ4Yxy6c/mAllgKwc7SbQFPxEJEmicKN8dZU+RvM8aFj
	 FKW+fIqYrEhxOz5KfDWqAV5rESDDMkRM2x6FxlOXGWtnuG7YFoqoY7t+3KQJUpoBfC
	 Jm64Nqq7gZNXimnCwqlc8CND2XrQcB6jtpJkj6vOQMQBJSqBinV5dfIOFaBJfJMbyW
	 OwC1ICpFmPbUw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id E387088B5F;
 Thu,  3 Oct 2024 15:19:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727961599;
 bh=qMItSw8Ok4fBK8kIBePhHMwOO2oDzNiElGQenycfDoQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jtSpJBXV2SPWZLTEwsExMi3vJPlfzESNttRiJRfUsfOZUMTPgtp5J+6owrM0Vzn7k
 nsr0fMMQuhAIV6m69qpoiXMqnyGlkvU+pSthKjEpVI02jn5q7aU7lMJ5OLSaqec3RS
 viwVqgfk0S36XAqYjXkkifLYPXpgqFK1togLS4CXX8DjYtSzj0lbvF0k3oVPAvFnxe
 SObbhmOgbcYZY8rzwQ2PrEKoUFxX3vPqwY2b4SEPkI/dWHxJBwSYjtxFuFM1dUWQlK
 gr0q7To1B6s2Y/nBSzuUT7Icl9rXqK+E5o756zswW99W7AF857FnlA37wb6Nv2U34q
 lJnf2GbAp/M4g==
Message-ID: <ed50e1a7-193c-493c-a1ee-42d404049c59@denx.de>
Date: Thu, 3 Oct 2024 15:19:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] usb: dwc3: fix dcache flush range calculation
To: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-0-5398088ef93c@linaro.org>
 <20241002-u-boot-dwc3-gadget-dcache-fixup-v3-2-5398088ef93c@linaro.org>
 <e895c917-ca32-4b59-a5d6-7d8e9ce19d84@denx.de>
 <0643911e-e0fa-4faa-aee6-36f536691129@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <0643911e-e0fa-4faa-aee6-36f536691129@linaro.org>
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

On 10/3/24 2:49 PM, Neil Armstrong wrote:
> On 02/10/2024 16:55, Marek Vasut wrote:
>> On 10/2/24 4:39 PM, Neil Armstrong wrote:
>>> The current flush operation will omit doing a flush/invalidate on
>>> the first and last bytes if the base address and size are not aligned
>>> with DMA_MINALIGN.
>>>
>>> This causes operation failures Qualcomm platforms.
>>>
>>> Take in account the alignment and size of the buffer and also
>>> flush the previous and last cacheline.
>>>
>>> Remove CACHELINE_SIZE which was the same as DMA_MINALIGN.
>>
>> It isn't the same, CACHELINE_SIZE was set to CONFIG_SYS_CACHELINE_SIZE 
>> (CPU L1 cache cacheline length) while ARCH_DMA_MINALIGN is DMA engine 
>> alignment requirement (from times where there used to be one DMA 
>> engine on most devices). You likely want a 
>> max(CONFIG_SYS_CACHELINE_SIZE, dwc3-buffer-alignment-requirement) to 
>> really correctly align the buffer.
> 
> It is definitely true for platforms declaring dma_alloc_coherent() (arm, 
> riscv, x86)
> except nios2 but there's 0 chance dwc3 appears on a nios2 platform.
There is real chance of that, because on modern SoCFPGA platforms 
(Agilex) you can have the FPGA content access the SoC peripherals, and 
one of the SoC peripherals is DWC3 controller. If anyone would actually 
synthesize it is another question ... but it is an FPGA, so that option 
exists.
