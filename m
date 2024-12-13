Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D5EE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 10:09:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7213E80104;
	Fri, 13 Dec 2024 11:09:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="6TtCXM9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B939980104; Fri, 13 Dec 2024 11:09:13 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C0D6800DF
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 11:09:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2077089778=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD9wWQE020845;
 Fri, 13 Dec 2024 11:09:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Vu3z8jWRqc8r0DYaeC9MQrfislYLU9tJjqw6yKiBLcM=; b=6TtCXM9GY96qmIvM
 5lbFYqSfJXvC6wpAGQSuy+uCKdFhmagSf0jBumCnL3XdUVehssGTkJKdoYabIbND
 4UZX/sRZU50bG1Gz5bOczHKRNZbcaJYPpfatd6WvrI+7ml7qnyeKf53fjt+n67vz
 gwp4Mba2hu6HoqFwdA/YrygwRZDvZudLyRnrIqkHDpzSYNN+moTIgiUPlB4gIvVY
 M54qwaTVo65I8VsLryikt/mvQM10DIbe4A/0f2ZXcUawa8oHp2/MGeCeAiHcxUah
 8OElacjVnDq4h2yye/QR9zqLcWjOS26PsEShkdKrTdLY2y6IoTzcoJEuA9NIePOT
 LKBrXA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ccnmmb7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Dec 2024 11:09:06 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4583140047;
 Fri, 13 Dec 2024 11:08:02 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC2FC258D8C;
 Fri, 13 Dec 2024 11:06:18 +0100 (CET)
Received: from [10.252.14.115] (10.252.14.115) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 13 Dec
 2024 11:06:18 +0100
Message-ID: <a2d0b313-35fa-4ab8-a09a-da2913a2f130@foss.st.com>
Date: Fri, 13 Dec 2024 11:06:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: prohibit allocations above ram_top even from same
 bank
To: Sughosh Ganu <sughosh.ganu@linaro.org>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, E
 Shattow <lucent@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <mark.kettenis@xs4all.nl>
References: <20241202070624.1295497-1-sughosh.ganu@linaro.org>
 <173358702572.3722028.2684286775587826268.b4-ty@konsulko.com>
 <092f9d73-c0c5-419e-b6e5-e671f8227753@foss.st.com>
 <20241212191822.GK1505244@bill-the-cat>
 <CADg8p94h9rdV+gLxuhmNTi7yWhdDjOy32SpJwGSugTovtq39Rw@mail.gmail.com>
 <5d2c7448-11a7-436e-b04b-4e510b440e26@foss.st.com>
 <CADg8p955sefs1kZiyMAwp6N7=w13VCidFoK1Lv5NbLH-katvoQ@mail.gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CADg8p955sefs1kZiyMAwp6N7=w13VCidFoK1Lv5NbLH-katvoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.14.115]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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



On 12/13/24 10:54, Sughosh Ganu wrote:
> On Fri, 13 Dec 2024 at 14:44, Patrice CHOTARD
> <patrice.chotard@foss.st.com> wrote:
>>
>>
>>
>> On 12/12/24 20:50, Sughosh Ganu wrote:
>>> On Fri, 13 Dec 2024 at 00:48, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Wed, Dec 11, 2024 at 05:18:28PM +0100, Patrice CHOTARD wrote:
>>>>
>>>>>
>>>>>
>>>>> On 12/7/24 16:57, Tom Rini wrote:
>>>>>> On Mon, 02 Dec 2024 12:36:24 +0530, Sughosh Ganu wrote:
>>>>>>
>>>>>>> There are platforms which set the value of ram_top based on certain
>>>>>>> restrictions that the platform might have in accessing memory above
>>>>>>> ram_top, even when the memory region is in the same DRAM bank. So,
>>>>>>> even though the LMB allocator works as expected, when trying to
>>>>>>> allocate memory above ram_top, prohibit this by marking all memory
>>>>>>> above ram_top as reserved, even if the said memory region is from the
>>>>>>> same bank.
>>>>>>>
>>>>>>> [...]
>>>>>>
>>>>>> Applied to u-boot/master, thanks!
>>>>>>
>>>>> Hello
>>>>>
>>>>> This patch is breaking the boot on STM32MP135F-DK.
>>>>>
>>>>> On this platform, we got an area above gd->ram_top,
>>>>> this area, reserved for OPTEE, is tagged with LMB_NOMAP in boot_fdt_add_mem_rsv_regions().
>>>>>
>>>>> Since this commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank"),
>>>>> this area is no more tagged as LMB_NOMAP, because it's previously been
>>>>> tagged with LMB_NOOVERWRITE in lmb_add_memory().
>>>>>
>>>>> By not being tagged LMB_NOMAP, the MMU configuration is impacted and leads to a panic.
>>>>>
>>>>> I suggest to revert this patch.
>>>>
>>>> Hi Patrice. Can you please re-test current top of tree? I believe Sam's
>>>> series should resolve this problem as well. Thanks!
>>>
>>> Tom, that won't happen. This is a separate issue from what is being
>>> fixed by Sam's series.
>>
>> Hi All
>>
>> I confirm, Sam's series didn't help here as Sughosh said.
>>
>>>
>>> Patrice, please let me know if the hang is being fixed by the change
>>> that I had suggested earlier in this thread. For some reason I don't
>>> see a hang on the DK2 board despite the board having a similar memory
>>> map of memory being reserved for the op-tee image above ram_top with
>>> no-map property.
>>
>> On my side i didn't see the issue on STM32MP157C-DK2 board, but
>> i got it systematically on STM2MP135F-DK.
>>
>> Your suggested patch is fixing the hang observed, i will send a patch.
> 
> Patrice, thanks much for testing and confirming the fix. I suspect
> that the cpu's being used on the two boards might be different. Looks
> like one implementation is speculatively prefetching data from the
> op-tee memory region while other is not, which might explain why this
> is not seen on all ST boards. Just a hunch though :)

That's exactly what we think too ;-)

> 
> -sughosh
> 
>>
>> Thanks all ;-)
>>
>> Patrice
>>
>>
>>>
>>> -sughosh
>>>
>>>>
>>>> --
>>>> Tom
