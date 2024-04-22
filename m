Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547C7C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 11:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70C4D886CF;
	Mon, 22 Apr 2024 13:16:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zGn9EAPV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 375CD886DE; Mon, 22 Apr 2024 13:16:17 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 089AA88436
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 13:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43MBG9DW082735;
 Mon, 22 Apr 2024 06:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713784569;
 bh=8sYOo0bdvkvza8ktgxl8V+Xq203+HsLC+qs2+Zca7/w=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=zGn9EAPVuocOIYU0rSBkCBroVQNFPQMvkQdQVUiZA+pp4VX3CqXRCLuEPnkJ8rRWc
 Tv3A2RKxYbfav1VMVZvBDlePt4berjqyFypMFDZOhxIKz4c8s/g0F9emlEUDe5hzAd
 8YAEF1QviMsyP1fVAkJqCoBi+Ym9oOY7IobeilFI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43MBG97n112015
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 22 Apr 2024 06:16:09 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Apr 2024 06:16:09 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Apr 2024 06:16:09 -0500
Received: from [172.24.227.220] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.227.220])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43MBG53V092209;
 Mon, 22 Apr 2024 06:16:05 -0500
Message-ID: <8997eeb9-c5a7-4bc6-84c0-78693010ccc7@ti.com>
Date: Mon, 22 Apr 2024 16:46:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] board: ti: am62x: Init DRAM size in R5/A53 SPL
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 <nm@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <dannenberg@ti.com>,
 <srk@ti.com>
CC: Sughosh Ganu <sughosh.ganu@linaro.org>, <joe.hershberger@ni.com>,
 <simon.k.r.goldschmidt@gmail.com>, <sjg@chromium.org>, <marex@denx.de>,
 <u-boot@lists.denx.de>
References: <20240112132607.GO1610741@bill-the-cat>
 <a1d7ca85-8723-4d73-8e1c-357c6aa6294f@ti.com>
 <20240120164141.GA3652023@bill-the-cat>
 <48c63fc4-9f06-4066-b206-a0a548936dcd@ti.com>
 <892b473b-5b76-4e44-af27-52d50cb24877@ti.com>
 <20240411220741.GJ2493117@bill-the-cat>
 <2406c7be-114c-4082-9c14-1cd59917b9d8@ti.com>
 <20240416170027.GQ1054907@bill-the-cat>
 <97f84067-ba36-47f6-befa-221be47a1d25@ti.com>
 <CADg8p97udLbFvbZ_FZf9Hfwg3R4=YJMNWrAtqvu97mL7vVYREQ@mail.gmail.com>
 <20240417160446.GF1054907@bill-the-cat>
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20240417160446.GF1054907@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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



On 17/04/24 21:34, Tom Rini wrote:
> On Wed, Apr 17, 2024 at 05:48:31PM +0530, Sughosh Ganu wrote:
>> hi Chintan,
>>
>> On Wed, 17 Apr 2024 at 13:21, Chintan Vankar <c-vankar@ti.com> wrote:
>>>
>>>
>>>
>>> On 16/04/24 22:30, Tom Rini wrote:
>>>> On Tue, Apr 16, 2024 at 05:52:58PM +0530, Chintan Vankar wrote:
>>>>>
>>>>>
>>>>> On 12/04/24 03:37, Tom Rini wrote:
>>>>>> On Wed, Apr 03, 2024 at 06:18:01PM +0530, Chintan Vankar wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 22/01/24 10:11, Siddharth Vadapalli wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 20/01/24 22:11, Tom Rini wrote:
>>>>>>>>> On Mon, Jan 15, 2024 at 01:42:51PM +0530, Siddharth Vadapalli wrote:
>>>>>>>>>> Hello Tom,
>>>>>>>>>>
>>>>>>>>>> On 12/01/24 18:56, Tom Rini wrote:
>>>>>>>>
>>>>>>>> ...
>>>>>>>>
>>>>>>>>>>> The list of conditionals in common/spl/spl.c::board_init_r() should be
>>>>>>>>>>> updated and probably use SPL_NET as the option to check for.
>>>>>>>>>>
>>>>>>>>>> Thank you for reviewing the patch and pointing this out. I wasn't aware of it. I
>>>>>>>>>> assume that you are referring to the following change:
>>>>>>>>>>
>>>>>>>>>>             if (IS_ENABLED(CONFIG_SPL_OS_BOOT) || CONFIG_IS_ENABLED(HANDOFF) ||
>>>>>>>>>> -           IS_ENABLED(CONFIG_SPL_ATF))
>>>>>>>>>> +           IS_ENABLED(CONFIG_SPL_ATF) || IS_ENABLED(CONFIG_SPL_NET))
>>>>>>>>>>                     dram_init_banksize();
>>>>>>>>>>
>>>>>>>>>> I shall replace the current patch with the above change in the v2 series. Since
>>>>>>>>>> this is in the common section, is there a generic reason I could provide in the
>>>>>>>>>> commit message rather than the existing commit message which seems to be board
>>>>>>>>>> specific? Also, I hope that the above change will not cause regressions for
>>>>>>>>>> other non-TI devices. Please let me know.
>>>>>>>>>
>>>>>>>>> Yes, that's the area, and just note that networking also requires the
>>>>>>>>> DDR to be initialized.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Thank you for confirming and providing your suggestion for the contents of the
>>>>>>>> commit message.
>>>>>>>>
>>>>>>> Following Tom's Suggestion of adding CONFIG_SPL_NET in common/spl/spl.c
>>>>>>> "dram_init_banksize()", the issue of fetching a file at SPL stage seemed
>>>>>>> to be fixed. However the commit "ba20b2443c29", which sets gd->ram_top
>>>>>>> for the very first time in "spl_enable_cache()" results in
>>>>>>> "arch_lmb_reserve()" function reserving memory region from Stack pointer
>>>>>>> at "0x81FFB820" to gd->ram_top pointing to "0x100000000". Previously
>>>>>>> when gd->ram_top was zero "arch_lmb_reserve()" was noop. Now using TFTP
>>>>>>> to fetch U-Boot image at SPL stage results in "tftp_init_load_addr()"
>>>>>>> function call that invokes "arch_lmb_reserve()" function, which reserves
>>>>>>> entire memory starting from Stack Pointer to gd->ram_top leaving no
>>>>>>> space to load U-Boot image via TFTP since TFTP loads files at pre
>>>>>>> configured memory address at "0x82000000".
>>>>>>>
>>>>>>> As a workaround for this issue, one solution we can propose is to
>>>>>>> disable the checks "lmb_get_free_size()" at SPL and U-Boot stage. For
>>>>>>> that we can define a new config option for LMB reserve checks as
>>>>>>> "SPL_LMB". This config will be enable by default for the backword
>>>>>>> compatibility and disable for our use case at SPL and U-Boot stage.
>>>>>>
>>>>>> The problem here is that we need LMB for booting an OS, which is
>>>>>> something we'll want in SPL in non-cortex-R cases too, which means this
>>>>>> platform, so that's a no-go. I think you need to dig harder and see if
>>>>>> you can correct the logic somewhere so that we don't over reserve?
>>>>>>
>>>>> Since this issue is due to function call "lmb_init_and_reserve()"
>>>>> function invoked from "tftp_init_load_addr()" function. This function
>>>>> is defined by Simon in commit "a156c47e39ad", which fixes
>>>>> "CVE-2018-18439" to prevent overwriting reserved memory. Simon, can you
>>>>> explain why do we need to call "lmb_init_and_reserve()" function here ?
>>>>
>>>> This is indeed a tricky area which is why Sughosh is looking in to
>>>> trying to re-work the LMB mechanic and we've had a few long threads
>>>> about it as well.
>>>>
>>>> I've honestly forgotten the use case you have here, can you please
>>>> remind us?
>>>>
>>> We are trying to boot AM62x using Ethernet for which we need to load
>>> binary files at SPL and U-Boot stage using TFTP. To store the file we
>>> need a free memory in RAM, specifically we are storing these files at
>>> 0x82000000. But we are facing an issue while loading the file since
>>> the memory area having an address 0x82000000 is reserved due to
>>> "lmb_init_and_reserve()" function call. This function is called in
>>> "tftp_init_load_addr()" function which is getting called exactly before
>>> we are trying to get the free memory area by calling
>>> "lmb_get_free_size()".
>>
>> I have no idea about your platform but I was wondering if there is any
>> particular importance of the load address of 0x82000000? It looks as
>> though the current location of the SP when arch_lmb_reserve() gets
>> called means that the load address is getting reserved for the U-Boot
>> image. Do you not have the option of loading the image at a lower
>> address instead?
> 
> Or using a higher address for SPL stack? You might be able to solve this
> just by re-examining which addresses (and RAM size limitations) need to
> be considered here.
> 

Tom,

We changed SPL_STACK_R_ADDR to higher address as you suggested here and
observe that the memory area which was getting reserved by
"lmb_init_and_reserve()" function, when SPL_STACK_R_ADDR was 0x82000000,
is from 0x81FFB820 to gd->ram_top, but when SPL_STACK_R_ADDR is changed
to 0x83000000, stack pointer is pointing to 0x82FFB810 and reserving a
memory area till gd->ram_top. Since memory address 0x82000000 is not
there in reserved memory area region U-Boot proper is successfully
getting fetched and we are able to boot.

Can it be considered of changing "SPL_STACK_R_ADDR" independently for
Ethernet Boot feature ?
