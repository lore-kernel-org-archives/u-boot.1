Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F07C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 07:03:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8862880D6;
	Mon, 15 Apr 2024 09:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="nlGFBi7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB47D87B89; Mon, 15 Apr 2024 09:03:42 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C918816D
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 09:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4835aa2b69=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43EMt2b8003792; Mon, 15 Apr 2024 09:03:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=PXbEkI8sFnTwYuU4hulrESpnbAzc5xkde4bSPZef6dQ=; b=nl
 GFBi7O4EBTnYfsjkBmEt6TR2L13xy96suxvr64lEtPYpjrvywW/igmdZ6sns4vmO
 7KqiaclEJCIJE0BxU/ghMfXZ3khwhYaGJ3focCbyVvMkGpozordL9o3o01v2K836
 G+Dcj4+NZ7ew2ISHpE46C68Q6tEES+cLUJHxptdVXackAuIzqlAwuZ+Bll3A/Qb0
 dOBGH1ISHNsKcz8R+7rFAQHd5V0OrG6Sr0aYEF2eplMOKGpEE118gJD9BMO9ABg6
 NhsM21bobT2Rk/eWWN2ClN1nFhNJAaSqkCb+0E5REgEWJyA0OXDTXHD0detwLKuP
 JKoLakQorknXlJvI0Mcw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xffff6632-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Apr 2024 09:03:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A87144002D;
 Mon, 15 Apr 2024 09:03:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5D26320E037;
 Mon, 15 Apr 2024 09:03:02 +0200 (CEST)
Received: from [10.48.86.98] (10.48.86.98) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 15 Apr
 2024 09:03:01 +0200
Message-ID: <c0271e2b-517b-414c-95c3-232f280dd833@foss.st.com>
Date: Mon, 15 Apr 2024 09:03:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] lmb: Fix adjacent region merge in
 lmb_add_region_flags()
Content-Language: en-US
To: "Kumar, Udit" <u-kumar1@ti.com>, <u-boot@lists.denx.de>, tom Rini
 <trini@konsulko.com>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Kumar Gala
 <galak@kernel.crashing.org>, Simon Glass <sjg@chromium.org>
References: <20240412155307.735631-1-patrice.chotard@foss.st.com>
 <20240412155307.735631-2-patrice.chotard@foss.st.com>
 <fc509f7b-78ba-425b-8a33-7768a4f58bd0@foss.st.com>
 <8c825b9d-7bb6-47e4-915d-a852df60bbc5@ti.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <8c825b9d-7bb6-47e4-915d-a852df60bbc5@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.98]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_06,2024-04-09_01,2023-05-22_02
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



On 4/14/24 13:10, Kumar, Udit wrote:
> Hello Patrice,
> 
> On 4/13/2024 1:54 PM, Patrice CHOTARD wrote:
>>
>> On 4/12/24 17:53, Patrice Chotard wrote:
>>> In case a new region is adjacent to a previous region with
>>> similar flag, this region is merged with its predecessor, but no
>>> check are done if this new added region is overlapping another region
>>> present in lmb (see reserved[3] which overlaps reserved[4]).
>>>
>>> [..]
>>> phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align)
>>>   {
>>>       return lmb_alloc_base(lmb, size, align, LMB_ALLOC_ANYWHERE);
>>
>> I think this series (v2) is not correct even if now the CI tests are OK.
>> After re-reading carefully the lib_test_lmb_overlapping_reserve() test
>> it appears to me there is a contradiction.
>>
>> It's indicating that "check that calling lmb_reserve with overlapping regions fails"
>>
>> but the very last test of lib_test_lmb_overlapping_reserve() has this comment :
>> /* allocate 3rd region, coalesce with first and overlap with second */
>> and this test allows this overlap case.
>>
>> It's not clear if LMB region can overlap each other or not ?
> 
> 
> I would say partial overlap and coalescing with before one
> 
> May be Below can help
> 
> /* allocate 2nd region , This should coalesced all region into one
> 
> you will get one region as
> 
> Address --- Size
> 
> 0x40010000 --- 0x30000
> 
> Next after this  /* allocate 2nd region, which should be added as first region */
> 
> we will have two region like
> 
> Address --- Size
> 
> (0x40000000 -- 0x8000)
> 
> (0x40010000 --- 0x30000)
> 
> Now third request comes in
> 
> /* allocate 3rd region, coalesce with first and overlap with second */
> 
> which is address of  0x40008000 and size of  0x10000, Now this region to be added
> 
> is coalescing with first (0x40000000 -- 0x8000) and part of this overlap with (0x40010000 --- 0x30000).
> 
> So, what this patch does , merge all these into one region
> 
> as (0x40000000 -- 0x40000)

Hi Udit

Ok, but why the second test done in test/lib/lmb.c test should be considered as failed ?


	ret = lmb_reserve(&lmb, 0x40010000, 0x10000);
	ut_asserteq(ret, 0);
	ASSERT_LMB(&lmb, ram, ram_size, 1, 0x40010000, 0x10000,
		   0, 0, 0, 0);
	/* allocate overlapping region should fail */
	ret = lmb_reserve(&lmb, 0x40011000, 0x10000);
	ut_asserteq(ret, -1);


The 2 area 0x40010000 -- 0x10000   and 0x40011000 -- 0x10000 area overlaps each other and 
should be merged in one 0x40010000 -- 11000 ?

What is the criteria to merge or not 2 overlapping areas ?

For me overlapping shouldn't be authorized.

Patrice

> 
>> Udit, your patch edb5824be17f ("lmb: remove overlapping region with next range")
>> is authorizing LMB overlapping right ?
> 
> As said before this is checking overlap and coalescing and acting accordingly.
> 
>> Patrice
>>
>>
>>
>>
>>
