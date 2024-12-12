Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5730E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 08:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEB5A801BE;
	Thu, 12 Dec 2024 09:28:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="11fSXWxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72CF2801BF; Thu, 12 Dec 2024 09:28:16 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19425801BD
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 09:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2076b1cc10=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC60JWD011913;
 Thu, 12 Dec 2024 09:28:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 LVufC5JlnsHKFDP1yDdazga37b4w8aLILJ9qIpWhyyo=; b=11fSXWxLf3BV/lXt
 4uSCHnNi+p/RUbjQMcjY38VgKKVsxtS9tImCgW+UH+pNPPoJHYqSurCwoOtXOdyJ
 S91WVZWNjPieJ4MOVpJDu4O9bP0MGzdbnWkNu41yYv23wyiiU7033G8q4zGeLUrl
 vv80JSIWH2gNwvByFR2ve/tRVCAGENtvKTTBmUyc+aR1yBCS/1xiYOR5LQnEfShS
 fRVI9OXF11r/4YuXrqwtpYZG8acHtmHoMFT6Tmxzbq4n0Tco0UsH5mV8j3XKJKe9
 xgC6AazqIQfNzjXTW7BdQ3Wv2aHeJwpHxD9Qv9dxuZxVI560XAMWMktYsPcUmBKo
 72tNCg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43e2w9x0jg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2024 09:28:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3E42C40047;
 Thu, 12 Dec 2024 09:27:12 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B6B7125C23B;
 Thu, 12 Dec 2024 09:23:53 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 12 Dec
 2024 09:23:53 +0100
Message-ID: <a1b49293-7ebd-4590-8311-f3bc2943a6dd@foss.st.com>
Date: Thu, 12 Dec 2024 09:23:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lmb: prohibit allocations above ram_top even from same
 bank
To: Sughosh Ganu <sughosh.ganu@linaro.org>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, E
 Shattow <lucent@gmail.com>
References: <20241202070624.1295497-1-sughosh.ganu@linaro.org>
 <173358702572.3722028.2684286775587826268.b4-ty@konsulko.com>
 <092f9d73-c0c5-419e-b6e5-e671f8227753@foss.st.com>
 <CADg8p96XXRVn6r-9tSu-h1CANgnayQuEVs8XVUb8eAd8d5kz9A@mail.gmail.com>
 <7642b0fc-8383-4877-bbc6-22bcd22536fc@foss.st.com>
 <CADg8p951Y10c_ffDCKZaCS6kG+c8mR2aDrTtDgD3rZsWoBM3Cw@mail.gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CADg8p951Y10c_ffDCKZaCS6kG+c8mR2aDrTtDgD3rZsWoBM3Cw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
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



On 12/11/24 19:16, Sughosh Ganu wrote:
> On Wed, 11 Dec 2024 at 22:20, Patrice CHOTARD
> <patrice.chotard@foss.st.com> wrote:
>>
>>
>>
>> On 12/11/24 17:27, Sughosh Ganu wrote:
>>> On Wed, 11 Dec 2024 at 21:50, Patrice CHOTARD
>>> <patrice.chotard@foss.st.com> wrote:
>>>>
>>>>
>>>>
>>>> On 12/7/24 16:57, Tom Rini wrote:
>>>>> On Mon, 02 Dec 2024 12:36:24 +0530, Sughosh Ganu wrote:
>>>>>
>>>>>> There are platforms which set the value of ram_top based on certain
>>>>>> restrictions that the platform might have in accessing memory above
>>>>>> ram_top, even when the memory region is in the same DRAM bank. So,
>>>>>> even though the LMB allocator works as expected, when trying to
>>>>>> allocate memory above ram_top, prohibit this by marking all memory
>>>>>> above ram_top as reserved, even if the said memory region is from the
>>>>>> same bank.
>>>>>>
>>>>>> [...]
>>>>>
>>>>> Applied to u-boot/master, thanks!
>>>>>
>>>> Hello
>>>>
>>>> This patch is breaking the boot on STM32MP135F-DK.
>>>>
>>>> On this platform, we got an area above gd->ram_top,
>>>> this area, reserved for OPTEE, is tagged with LMB_NOMAP in boot_fdt_add_mem_rsv_regions().
>>>>
>>>> Since this commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from same bank"),
>>>> this area is no more tagged as LMB_NOMAP, because it's previously been
>>>> tagged with LMB_NOOVERWRITE in lmb_add_memory().
>>>>
>>>> By not being tagged LMB_NOMAP, the MMU configuration is impacted and leads to a panic.
>>>>
>>>> I suggest to revert this patch.
>>>
>>> I don't think that this patch should be reverted. If the said platform
>>> has a reserved memory region above ram_top, I would suggest to either
>>> a) move the ram_top on this platform so that the op-tee region gets
>>> marked as no-map in the lmb memory map, or b) do not use the lmb
>>
>> In my explanation above, i indicated that before this commit,
>> this area was marked as LMB_NOMAP in the lmb memory map by boot_fdt_add_mem_rsv_regions().
>> this is exactly what you described in the possible solution "a)".
>>
>> But now with this commit, as lmb_add_memory() is called in lmb_init() the area above ram_top is marked LMB_NOOVERWRITE.
>> Then later, boot_fdt_add_mem_rsv_regions() is executed, but the area above ram_top can't be marked as
>> LMB_NOMAP as previously because it's already marked LMB_NOOVERWRITE.
> 
> This has been done to ensure that memory above ram_top is not taken
> into consideration when it comes to U-Boot. The reason why memory

It was already the case before this commit, ram_top was designed to
indicate to U-Boot the top address of available RAM,
see include/asm-generic/global_data.h :

	/**
	 * @ram_top: top address of RAM used by U-Boot
	 */
	phys_addr_t ram_top;

> above ram_top also needs to be added is to ensure that this memory
> also gets passed on to the OS when booting with EFI. If it has to be
> considered by U-Boot, the value of ram_top needs to be adjusted
> accordingly. Is that not possible on the platform? If not, the only
> other solution is to obtain this memory region from the DT, and then
> configure the MMU.

Currently, ram_top is adjusted on STM32MP platforms, 
for example in stm32mp135f-dk.dts :

	reserved-memory {
		#address-cells = <1>;
		#size-cells = <1>;
		ranges;

		optee@dd000000 {
			reg = <0xdd000000 0x3000000>;
			no-map;
		};
	};

          0xE000 0000  ********************  
                       *                  *  
                       *       OPTEE      *  
                       *    (LMB_NOMAP)   *  
                       *                  *  
ram_top = 0xDD00 0000  ********************  
                       *                  *
                       *                  *
                       *                  *
                       *                  *
                       *                  *
                       *                  *
                       *                  *
                       *                  *
                       *                  *
                       *                  *
          0xC000 0000  ********************

On STM32MP platforms, we already obtain all memory regions from DT with 
property "no-map" and we marked them LMB_NOMAP.

Later we parse the LMB regions, all of these region marked LMB_NOMAP are 
used to configure our MMU accordingly.
So, again, we are doing things as you suggested.

This commit now forbids to mark OPTEE memory region with LMB_NOMAP as 
indicated in DT.

For information, it has impact on all STM32MP platforms (at least 6 boards).

Patrice



> 
>>
>>
>>> memory map to configure the MMU -- can the MMU configuration logic not
>>> read the DT to get which regions are to be marked as no-map?
>>>
>>> As far as the lmb module is concerned, it is being told through this
>>> commit to not consider memory above ram_top for allocations, which is
>>> not an incorrect thing imo.
>>
>> That's the case, we don't consider memory above ram_top for allocations,
>> we only marked it with LMB_NOMAP.
> 
> That was because the lmb scope was local. That meant a platform could
> add any size that it wanted, and then use that map for whatever it
> fancied. The use of lmb for "allocating" addresses for io-va addresses
> by the apple iommu is another such case.
> 
> -sughosh
> 
>>
>> Thanks
>> Patrice
>>
>>>
>>> -sughosh
>>>
>>>>
>>>> Patrice
