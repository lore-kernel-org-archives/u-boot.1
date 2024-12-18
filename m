Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E1DE7718A
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 10:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C64480269;
	Wed, 18 Dec 2024 11:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1734518963;
	bh=GF2IAtkdg4RF37m0GIfVfs10QPQ75NLkO7PQTFRgblw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=glF9v08GUdzJG9UhveU/mii04Sbk5BOIjyK0dFP0STR4t17j+joWxXeD4powpu29o
	 //c8QU3mKN5JDuxlqeOI2aWwsz/GrqtTXC6iYf04wg8TZrQLC9NcAo8o3MBSvPaw2T
	 ZRywQxjriSSCKxBIlZ6sB9qqJOO1oXlDzNEi8irdKLAsDWlPiWGhAFSv20PcaMS72X
	 LKB70y9Lh4czIPRQvvQC14DFtZKE9VMPPjRon60xJEz/Vdk0EbMZzjWoqN1ZVhZwxK
	 IrWQjhk/7cOB91KXYYYYizmc+3+1wsG+jPtiWd/vIvamYvLEHIevvlDZ3JLKKkAGO2
	 inCfsw8DnHdNQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80131802E3; Wed, 18 Dec 2024 11:49:21 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CAD580239
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 11:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="f9bRh/g3"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0D21B10485892; Wed, 18 Dec 2024 11:49:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1734518957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GF2IAtkdg4RF37m0GIfVfs10QPQ75NLkO7PQTFRgblw=;
 b=f9bRh/g31Jn3yZxEij4tQFLmquXoKGvhusRUcSfc/2x0CbgpYNZoOOu71i/0gTDO7DDlSi
 5k6KLF9ga5WR6nAp/l/ZlXmqyowVKbqIlvQ3MoaV1uuREvSEog/MxhpHPahoVbl6n2l1Bb
 MBeIcR5r7omDxu3mEZ8xzQ3/lxe+leRefc9kz+m0Njprovg+w6/aj1WYnxfoZ2QDbDMtou
 +etM8IcVGLoHSvNjjBd0OnD4BXfw2+Hp5T4CU2PKLpBm0rjtWkpJFEoJqxNuHMa2NY+I3v
 DjunxApzQdyybSZ6OtuiT5UnUHfIuo8cL7WhxMpqUWH+uQRIJzxoE2Yu7ulw+A==
Message-ID: <28be5835-46e6-4447-a7c0-d19e3777a98c@denx.de>
Date: Wed, 18 Dec 2024 11:42:11 +0100
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <4dc85e80-3c73-4db0-8c47-2aaf7c35373a@foss.st.com>
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

On 12/18/24 11:32 AM, Patrice CHOTARD wrote:
> 
> 
> On 12/16/24 09:54, Patrice CHOTARD wrote:
>>
>>
>> On 12/16/24 00:29, Marek Vasut wrote:
>>> Commit 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
>>> broke booting from SD card on STM32MP15xx , reinstate raw mode SD
>>> boot configuration options and select the correct raw mode partition
>>> for STM32MP15xx to fix SD boot on STM32MP15xx DHSOM.
>>>
>>> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
>>> Reported-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---
>>> NOTE: For 2025.01
>>> ---
>>> Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
>>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>> Cc: Simon Glass <sjg@chromium.org>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: u-boot@dh-electronics.com
>>> Cc: u-boot@lists.denx.de
>>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>>> ---
>>>   configs/stm32mp15_dhsom.config | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/configs/stm32mp15_dhsom.config b/configs/stm32mp15_dhsom.config
>>> index efc149577ea..04ee9bfc444 100644
>>> --- a/configs/stm32mp15_dhsom.config
>>> +++ b/configs/stm32mp15_dhsom.config
>>> @@ -57,11 +57,14 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
>>>   CONFIG_SPL_STACK=0x30000000
>>>   CONFIG_SPL_SYS_MALLOC=y
>>>   CONFIG_SPL_SYS_MALLOC_SIZE=0x1d00000
>>> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
>>>   CONFIG_SPL_TEXT_BASE=0x2FFC2500
>>>   CONFIG_SPL_USB_GADGET=y
>>>   CONFIG_STM32_ADC=y
>>>   CONFIG_SYSRESET_SYSCON=y
>>>   CONFIG_SYS_BOOTCOUNT_ADDR=0x5C00A14C
>>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x3
>>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
>>>   CONFIG_SYS_MALLOC_F_LEN=0x3000
>>>   CONFIG_SYS_PBSIZE=1050
>>>   CONFIG_PREBOOT="run dh_preboot"
>>
>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Thanks
>> Patrice
> Applied to u-boot-stm32/next
u-boot-stm32/master, right ?
              ^^^^^^

This is for 2025.01 .
