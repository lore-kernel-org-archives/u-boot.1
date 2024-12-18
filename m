Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B9FE77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 10:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E23B0802F2;
	Wed, 18 Dec 2024 11:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1734518963;
	bh=YtaPYyEaqySG5+65bd8xHn0IoFkBjSzrZ9D+mhxL1/k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fha1VrpQuW/NYhqzFGbaqFCymRYGKf93aRntD28hcfxxtdlmfKR1L7RKATqzlM4cn
	 OBn8CtTaRt3pCR3HfmcvTS7Zoz9c5Qmk3n3cMOpo889ea2eBPaR6lbZlvPYhcGRaYh
	 xoNYlcOjgrLbWJAQS3V1Sm8l9cIJinl1+5sBegRfIxkKDnK6TZ0ve1i73p2jhKcCE2
	 1U95DuQPHF08fEVlpKLOiT/2YVoR/zaNAAneBerugo7VLHIrrFetAX3ACa1fMwJVEr
	 ZqrTmgpRp/J9nUePuAOG/eblQ7MhXKR0mf9FgH05aCfFCguGTlL6+qWm//grGRlfMS
	 DKVxpjAQuaoyQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A124180239; Wed, 18 Dec 2024 11:49:22 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB5D80274
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 11:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="MAtk9MGM"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D31DF10485894; Wed, 18 Dec 2024 11:49:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1734518959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YtaPYyEaqySG5+65bd8xHn0IoFkBjSzrZ9D+mhxL1/k=;
 b=MAtk9MGMbEBbgkJIOjHr6mYzzuI2/8HxHDLmsBNJEaI3Cz5nOKOeR1bJUjNxj4ZPWYcTw4
 EZaF25eYTUuq1bpEV7pkSWRp6MDU6AQjQZk1bDh0rENvxDXpIiDKOR9O8o8lYcYx+G66M8
 IMixoY/x3s44BHTlbKQO3tnllV8eT09lDLoTmATo0qENluRVLoZRKZkgE4GTMy2BNO9Hw6
 9meLYqOjAxzaKo70U8QD10zTLq6+McJ4CruaPkSZgtUIyX7uATaMAhoY5SiLsKP25vuBeV
 mGFiDJtAh7R7K/WdX8RCwx7YLMMNvoOb0nuogniUSWBZiTZqli3Kv81WjftsPQ==
Message-ID: <69112757-7ed3-4501-993d-9bbe29871ea1@denx.de>
Date: Wed, 18 Dec 2024 11:48:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ARM: dts: stm32: Reinstate SPL_SYS_MMCSD_RAW_MODE on
 DH STM32MP15xx DHSOM
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
References: <20241215233011.569287-1-marex@denx.de>
 <20241215233011.569287-2-marex@denx.de>
 <c78cd5dd-1e98-4c63-ba6a-dc97d4a91c7a@foss.st.com>
 <4dc85e80-3c73-4db0-8c47-2aaf7c35373a@foss.st.com>
 <782a079c-36e1-4f18-856e-35bbafca4e03@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <782a079c-36e1-4f18-856e-35bbafca4e03@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 12/18/24 11:38 AM, Patrice CHOTARD wrote:
> 
> 
> On 12/18/24 11:32, Patrice CHOTARD wrote:
>>
>>
>> On 12/16/24 09:54, Patrice CHOTARD wrote:
>>>
>>>
>>> On 12/16/24 00:29, Marek Vasut wrote:
>>>> Commit 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
>>>> broke booting from SD card on STM32MP15xx , reinstate raw mode SD
>>>> boot configuration options and select the correct raw mode partition
>>>> for STM32MP15xx to fix SD boot on STM32MP15xx DHSOM.
>>>>
>>>> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
>>>> Reported-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>> ---
>>>> NOTE: For 2025.01
>>>> ---
>>>> Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
>>>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>>>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>>> Cc: Simon Glass <sjg@chromium.org>
>>>> Cc: Tom Rini <trini@konsulko.com>
>>>> Cc: u-boot@dh-electronics.com
>>>> Cc: u-boot@lists.denx.de
>>>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>>>> ---
>>>>   configs/stm32mp15_dhsom.config | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/configs/stm32mp15_dhsom.config b/configs/stm32mp15_dhsom.config
>>>> index efc149577ea..04ee9bfc444 100644
>>>> --- a/configs/stm32mp15_dhsom.config
>>>> +++ b/configs/stm32mp15_dhsom.config
>>>> @@ -57,11 +57,14 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
>>>>   CONFIG_SPL_STACK=0x30000000
>>>>   CONFIG_SPL_SYS_MALLOC=y
>>>>   CONFIG_SPL_SYS_MALLOC_SIZE=0x1d00000
>>>> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
>>>>   CONFIG_SPL_TEXT_BASE=0x2FFC2500
>>>>   CONFIG_SPL_USB_GADGET=y
>>>>   CONFIG_STM32_ADC=y
>>>>   CONFIG_SYSRESET_SYSCON=y
>>>>   CONFIG_SYS_BOOTCOUNT_ADDR=0x5C00A14C
>>>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x3
>>>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
>>>>   CONFIG_SYS_MALLOC_F_LEN=0x3000
>>>>   CONFIG_SYS_PBSIZE=1050
>>>>   CONFIG_PREBOOT="run dh_preboot"
>>>
>>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>> Thanks
>>> Patrice
>> Applied to u-boot-stm32/next
>>
>> Thanks
>> Patrice
> 
> Sorry, applied to u-boot-stm32/master
No worries, please ignore my previous email.
