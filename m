Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5D2C4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 11:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4892E88059;
	Sun, 14 Apr 2024 13:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZuzgZGku";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 533338808B; Sun, 14 Apr 2024 13:10:26 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E758D87DEA
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 13:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43EBAEoo075474;
 Sun, 14 Apr 2024 06:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713093014;
 bh=zFnGkalkfKCzoN+QaM6zTv/mP9hne0nYR7cW7EYaMdE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ZuzgZGkuaEFjbeohZwcfAiVBvDbWC2IcgQLyGMerr1hnuJs06sCmcT4Gn46Xp0Dul
 /Xbyk9Yp9LjWJks/OdjToL3dvyTg2r1uEWPVLyq1laFZU5e96xNkkC0VZK3iLj4BsA
 7swX2aHplI1WlFI2WIubb5f0XsXCA8OWMC9SCTqo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43EBAEPB022691
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 14 Apr 2024 06:10:14 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 14
 Apr 2024 06:10:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 14 Apr 2024 06:10:14 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43EBABxV059006;
 Sun, 14 Apr 2024 06:10:11 -0500
Message-ID: <8c825b9d-7bb6-47e4-915d-a852df60bbc5@ti.com>
Date: Sun, 14 Apr 2024 16:40:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] lmb: Fix adjacent region merge in
 lmb_add_region_flags()
To: Patrice CHOTARD <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>, tom
 Rini <trini@konsulko.com>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Kumar Gala
 <galak@kernel.crashing.org>,
 Simon Glass <sjg@chromium.org>, <u-kumar1@ti.com>
References: <20240412155307.735631-1-patrice.chotard@foss.st.com>
 <20240412155307.735631-2-patrice.chotard@foss.st.com>
 <fc509f7b-78ba-425b-8a33-7768a4f58bd0@foss.st.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <fc509f7b-78ba-425b-8a33-7768a4f58bd0@foss.st.com>
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

Hello Patrice,

On 4/13/2024 1:54 PM, Patrice CHOTARD wrote:
>
> On 4/12/24 17:53, Patrice Chotard wrote:
>> In case a new region is adjacent to a previous region with
>> similar flag, this region is merged with its predecessor, but no
>> check are done if this new added region is overlapping another region
>> present in lmb (see reserved[3] which overlaps reserved[4]).
>>
>> [..]
>> phys_addr_t lmb_alloc(struct lmb *lmb, phys_size_t size, ulong align)
>>   {
>>   	return lmb_alloc_base(lmb, size, align, LMB_ALLOC_ANYWHERE);
>
> I think this series (v2) is not correct even if now the CI tests are OK.
> After re-reading carefully the lib_test_lmb_overlapping_reserve() test
> it appears to me there is a contradiction.
>
> It's indicating that "check that calling lmb_reserve with overlapping regions fails"
>
> but the very last test of lib_test_lmb_overlapping_reserve() has this comment :
> /* allocate 3rd region, coalesce with first and overlap with second */
> and this test allows this overlap case.
>
> It's not clear if LMB region can overlap each other or not ?


I would say partial overlap and coalescing with before one

May be Below can help

/* allocate 2nd region , This should coalesced all region into one

you will get one region as

Address --- Size

0x40010000 --- 0x30000

Next after this  /* allocate 2nd region, which should be added as first 
region */

we will have two region like

Address --- Size

(0x40000000 -- 0x8000)

(0x40010000 --- 0x30000)

Now third request comes in

/* allocate 3rd region, coalesce with first and overlap with second */

which is address of  0x40008000 and size of  0x10000, Now this region to 
be added

is coalescing with first (0x40000000 -- 0x8000) and part of this overlap 
with (0x40010000 --- 0x30000).

So, what this patch does , merge all these into one region

as (0x40000000 -- 0x40000)

> Udit, your patch edb5824be17f ("lmb: remove overlapping region with next range")
> is authorizing LMB overlapping right ?

As said before this is checking overlap and coalescing and acting 
accordingly.

> Patrice
>
>
>
>
>
