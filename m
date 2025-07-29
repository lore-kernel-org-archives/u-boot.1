Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2550FC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 07:21:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA2582D06;
	Tue, 29 Jul 2025 09:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="r1RVUv2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FFC782D21; Tue, 29 Jul 2025 09:21:22 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39C8A80050
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=030572d2a8=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T6bKaX030155;
 Tue, 29 Jul 2025 09:21:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Sv2xldQtzkoI/gtB5+jb/R4h6uQmwahEiRhT6IAOcmk=; b=r1RVUv2W+18sqJa3
 CorOqzZejX6Pa6TTQOCwPGAoA9F6VJaumaMCIA0wyzWQiRXkygnIuzg+dIyuPndF
 mMB0i83gaPKheBD+vsSUbdwGugRdzxVcC7m0Vgmcgb2eM84iexYVCiMwscmLXfDI
 0/zoP2L7URfiooQspr4JSOPz7458BJy+l3bSQa54bl7LroSC5saIbf6Z6C9BFJA1
 I8Zbz8RMTv1U1mVH7g+zOjocZ7AZVuGiY9ws0Fp07uo3+kbBZqLTHxxN5TIsOpdm
 SZXYv+90j8W1JXY2T6IsQ2kkl+wtqjOl0dE9hWNJCEstoYaH7L/7D5zjtA/aRwRH
 jKQ/WA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 484memkwnh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Jul 2025 09:21:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6A75640057;
 Tue, 29 Jul 2025 09:20:03 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8BC4D6B8C9D;
 Tue, 29 Jul 2025 09:19:29 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 09:19:28 +0200
Message-ID: <d7c98212-4226-4326-a020-024889b0df2e@foss.st.com>
Date: Tue, 29 Jul 2025 09:19:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] ARM: stm32: Add STM32MP13xx SPL Kconfig options
To: Marek Vasut <marek.vasut@mailbox.org>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: Cheick Traore <cheick.traore@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Pascal Zimmermann <pzimmermann@dh-electronics.com>, Simon Glass
 <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250512172149.150214-1-marek.vasut@mailbox.org>
 <20250512172149.150214-2-marek.vasut@mailbox.org>
 <ce033305-387b-4732-a711-5a4a9f4237e3@foss.st.com>
 <43ba9ad2-e2df-44e3-9bc0-1b7e343ff1b3@mailbox.org>
 <7211233b-a1dd-489a-82fb-73e2d5dbb0cf@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <7211233b-a1dd-489a-82fb-73e2d5dbb0cf@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
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



On 7/29/25 06:05, Marek Vasut wrote:
> On 6/29/25 9:08 PM, Marek Vasut wrote:
> 
> Hi,
> 
>>>> diff --git a/arch/arm/mach-stm32mp/Kconfig.13x b/arch/arm/mach- stm32mp/Kconfig.13x
>>>> index bc8b3f8cf77..cecf9e3b8c7 100644
>>>> --- a/arch/arm/mach-stm32mp/Kconfig.13x
>>>> +++ b/arch/arm/mach-stm32mp/Kconfig.13x
>>>> @@ -20,7 +20,8 @@ config TARGET_ST_STM32MP13X
>>>>   endchoice
>>>>   config TEXT_BASE
>>>> -    default 0xC0000000
>>>> +    default 0xC0000000 if TFABOOT
>>>> +    default 0xC0100000 if !TFABOOT
>>>>   config PRE_CON_BUF_ADDR
>>>>       default 0xC0800000
>>>
>>>
>>> I don't understood  why you modify TEXT_BASE here.
>> Loading of data to the very beginning of DRAM may fail in case the data are wrapped in various container image types, because the image loader in SPL may use the area before the data load address to load for example image header(s) in there. This is one example of such header loading, which is triggered on STM32MP13xx in SPL:
>>
>> https://source.denx.de/u-boot/u-boot/-/blob/master/include/spl_load.h#L18
>>
>> "
>>   18         struct legacy_img_hdr *header =
>>   19                 spl_get_load_buffer(-sizeof(*header), sizeof(*header));
>>   20         ulong base_offset, image_offset, overhead;
>>   21         int read, ret;
>>   22
>>   23         log_debug("\nloading hdr from %lx to %p\n", (ulong)offset, header);
>>   24         read = info->read(info, offset, ALIGN(sizeof(*header),
>>   25 spl_get_bl_len(info)), header);
>> "
>>
>> The header is loaded at CONFIG_TEXT_BASE - sizeof(*header). If CONFIG_TEXT_BASE is start of DRAM with no usable memory right below it AND sizeof(*header) is non-zero, then this loading will fail.
>>
>> That's why the TEXT_BASE is shifted a bit higher in this patch.
> 
> Any news on this series ? It would be good to move this along.
> 
Hi Marek

Sorry for the delay, i am back from vacation. I will prepare pull request soon.

Thanks
Patrice
