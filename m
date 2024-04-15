Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAE8C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 07:36:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAF9A8813C;
	Mon, 15 Apr 2024 09:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h16P8ER1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 290C788134; Mon, 15 Apr 2024 09:36:29 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6D5988179
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 09:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43F7aKCO088947;
 Mon, 15 Apr 2024 02:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713166580;
 bh=L79ZIncU4aU60aAF1oBaHM8MzEfb/BW8SVPJ1geFlsU=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=h16P8ER1lJWb73pw/I6g6/X8SuTkTFCv754kbDRhDf1t9uXIvIMpnCEpm6Qm4zbhb
 WaYWgS2Dkyo17yWUnWIRfjtGZjnlkcP8tvIYRqGEJ7iazMPPuc+iYaQl/12rToGIVg
 K0+kYKe5nAzd3XHhm1t+sAoy0Di69ae6INFBz7SQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43F7aKo7011031
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 15 Apr 2024 02:36:20 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 Apr 2024 02:36:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 Apr 2024 02:36:19 -0500
Received: from [172.24.31.60] (lt5cd2489kgj.dhcp.ti.com [172.24.31.60])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43F7aGfr049938;
 Mon, 15 Apr 2024 02:36:17 -0500
Message-ID: <a6928c71-d9f6-4445-b106-9826b71feab8@ti.com>
Date: Mon, 15 Apr 2024 13:06:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] lmb: Fix adjacent region merge in
 lmb_add_region_flags()
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>, tom
 Rini <trini@konsulko.com>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Kumar Gala
 <galak@kernel.crashing.org>, Simon Glass <sjg@chromium.org>
References: <20240412155307.735631-1-patrice.chotard@foss.st.com>
 <20240412155307.735631-2-patrice.chotard@foss.st.com>
 <fc509f7b-78ba-425b-8a33-7768a4f58bd0@foss.st.com>
 <8c825b9d-7bb6-47e4-915d-a852df60bbc5@ti.com>
 <c0271e2b-517b-414c-95c3-232f280dd833@foss.st.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <c0271e2b-517b-414c-95c3-232f280dd833@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hello Patrice

On 4/15/2024 12:33 PM, Patrice CHOTARD wrote:
>
> On 4/14/24 13:10, Kumar, Udit wrote:
>> Hello Patrice,
>>
>> On 4/13/2024 1:54 PM, Patrice CHOTARD wrote:
>>> On 4/12/24 17:53, Patrice Chotard wrote:
>>>> In case a new region is adjacent to a previous region with
>>>> similar flag, this region is merged with its predecessor, but no
>>>> check are done if this new added region is overlapping another region
>>>> present in lmb (see reserved[3] which overlaps reserved[4]).
>>>>
>>>> [..]
>>>> phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align)
>>>>    {
>>>>        return lmb_alloc_base(lmb, size, align, LMB_ALLOC_ANYWHERE);
>>> I think this series (v2) is not correct even if now the CI tests are OK.
>>> After re-reading carefully the lib_test_lmb_overlapping_reserve() test
>>> it appears to me there is a contradiction.
>>>
>>> It's indicating that "check that calling lmb_reserve with overlapping regions fails"
>>>
>>> but the very last test of lib_test_lmb_overlapping_reserve() has this comment :
>>> /* allocate 3rd region, coalesce with first and overlap with second */
>>> and this test allows this overlap case.
>>>
>>> It's not clear if LMB region can overlap each other or not ?
>>
>> I would say partial overlap and coalescing with before one
>>
>> May be Below can help
>>
>> /* allocate 2nd region , This should coalesced all region into one
>>
>> you will get one region as
>>
>> Address --- Size
>>
>> 0x40010000 --- 0x30000
>>
>> Next after this  /* allocate 2nd region, which should be added as first region */
>>
>> we will have two region like
>>
>> Address --- Size
>>
>> (0x40000000 -- 0x8000)
>>
>> (0x40010000 --- 0x30000)
>>
>> Now third request comes in
>>
>> /* allocate 3rd region, coalesce with first and overlap with second */
>>
>> which is address of  0x40008000 and size of  0x10000, Now this region to be added
>>
>> is coalescing with first (0x40000000 -- 0x8000) and part of this overlap with (0x40010000 --- 0x30000).
>>
>> So, what this patch does , merge all these into one region
>>
>> as (0x40000000 -- 0x40000)
> Hi Udit
>
> Ok, but why the second test done in test/lib/lmb.c test should be considered as failed ?
>
>
> 	ret = lmb_reserve(&lmb, 0x40010000, 0x10000);
> 	ut_asserteq(ret, 0);
> 	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
> 		   0, 0, 0, 0);
> 	/* allocate overlapping region should fail */
> 	ret = lmb_reserve(&lmb, 0x40011000, 0x10000);
> 	ut_asserteq(ret, -1);
>
>
> The 2 area 0x40010000 -- 0x10000   and 0x40011000 -- 0x10000 area overlaps each other and
> should be merged in one 0x40010000 -- 11000 ?
>
> What is the criteria to merge or not 2 overlapping areas ?
>
> For me overlapping shouldn't be authorized.

There are two areas

1) Overlapping : Which are not authorized

2) Overlapping and coalescing , Which is authorized to merge


I am ok if you say 'coalescing and overlapping' should be treated as 
overlapping .

as long as new region is not getting created, for above.

What we see on our J784S4 EVM

without patch bdinfo says , reserved[1] and reserved[2] are overlapping 
and should not be created.

reserved.cnt = 0x4 reserved[0] [0x9e800000-0xabffffff], 0x0d800000 bytes 
flags: 4 reserved[1] [0xfce92000-0xffffffff], 0x0316e000 bytes flags: 0 
reserved[2] [0xfde91ec0-0xfffffffe], 0x0216e13f bytes flags: 0 
reserved[3] [0x880000000-0xfffffefff], 0x77ffff000 bytes flags: 0

>
> Patrice
>
>>> Udit, your patch edb5824be17f ("lmb: remove overlapping region with next range")
>>> is authorizing LMB overlapping right ?
>> As said before this is checking overlap and coalescing and acting accordingly.
>>
>>> Patrice
>>>
>>>
>>>
>>>
>>>
