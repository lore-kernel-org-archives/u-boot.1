Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30986CA1016
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 01:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E9FD80422;
	Tue,  9 Sep 2025 03:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l6Hzity+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5675282A9E; Tue,  9 Sep 2025 03:56:47 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B519800B6
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 03:56:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5891ugWk229483;
 Mon, 8 Sep 2025 20:56:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757383002;
 bh=hE5XncioyMiy9QROH/GzNQiUY/QPgiT8S7GGrgofKgE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=l6Hzity+zKM1nA9tIQJzc6tc4Nv2ndNvGWp2FIz04U25M50HtAuM8MgPrQwHLaxtS
 aJSwdCZdbzg73hCcqI0N4WUYsHpb3F44srUXKqdgnf3jSxV2C/1OMm9ldRpAiiF+Ux
 oizV9ZrBuMQWZva7BEk5Kaq1uylJkiIvxklqjSOs=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5891ugx92814781
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 8 Sep 2025 20:56:42 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 20:56:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 20:56:42 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5891uepj1530336;
 Mon, 8 Sep 2025 20:56:40 -0500
Message-ID: <9b9c1d53-e0ca-455b-b798-447344c9d569@ti.com>
Date: Tue, 9 Sep 2025 07:26:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] configs: j721e_evm_r5: Enable HBMC and MUX_MMIO at
 SPL
To: Tom Rini <trini@konsulko.com>
CC: Anurag Dutta <a-dutta@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
References: <20250902102000.1388848-1-a-dutta@ti.com>
 <20250902102000.1388848-3-a-dutta@ti.com>
 <20250902154656.GE124814@bill-the-cat>
 <5fec7216-9e0a-4d97-af23-60953cc1ef75@ti.com>
 <20250902161257.GF124814@bill-the-cat>
 <380dd6dd-8751-4843-936e-e9da577f376f@ti.com>
 <20250908162020.GR124814@bill-the-cat>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250908162020.GR124814@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Thanks Tom,

On 9/8/2025 9:50 PM, Tom Rini wrote:
> On Wed, Sep 03, 2025 at 09:58:34AM +0530, Kumar, Udit wrote:
>> Hi Tom,
>>
>> On 9/2/2025 9:42 PM, Tom Rini wrote:
>>> On Tue, Sep 02, 2025 at 09:36:25PM +0530, Kumar, Udit wrote:
>>>> Hi Tom
>>>>
>>>> On 9/2/2025 9:16 PM, Tom Rini wrote:
>>>>> On Tue, Sep 02, 2025 at 03:49:59PM +0530, Anurag Dutta wrote:
>>>>>
>>>>>> Commit 0e198ff1a911 ("configs: Resync with savedefconfig") removed
>>>>>> the necessary configs required to boot HyperFlash successfully, due to
>>>>>> missing Kconfig dependencies. Now that the Kconfig dependencies have
>>>>>> been added, re-enable the HBMC and MUX_MMIO configs in the SPL stage.
>>>>>>
>>>>>> Fixes: 0e198ff1a911 ("configs: Resync with savedefconfig")
>>>>>> Signed-off-by: Anurag Dutta <a-dutta@ti.com>
>>>>> Please note that this means it never worked to start with.
>>>>> "savedefconfig" does the equivalent of "make foo_defconfig" and then
>>>> It was working before but due to some boot issues , due to DT sync
>>>>
>>>> we disabled HBMC with commit id 5b2671594b80af116e259313d48bcd580d71f462 .
>>>>
>>>>
>>>> Instead of saying Fixes: 0e198ff1a91,
>>>>
>>>> This patch is fixing sha id 5b2671594b80af116e259313d48bcd580d71f462 by kind
>>>> of revert.
>>>>
>>>> my bad to give R/B , overlooked on sha id of fixes tag.
>>> Again, no, that's not quite how it works. When we do a defconfig resync
>>> like this we're just making the defconfigs reflect the present reality.
>> would need your suggestion here, what should be fixes tag,
>>
>> My comments were not related to defconfig sync
> Ah, yes, sorry, I mis-matched the hashes here.
>
>>> If you checkout 5b2671594b80af116e259313d48bcd580d71f462^ and then look
>>> at the resulting defconfig, that option will be off. Doing a git blame
>>> on drivers/mtd/Kconfig the right fixes tag is for:
>>
>> If you look at sha id d7ef2ef7c87528c359e110d7170e01a98aaecf14 (configs:
>> j721e_evm_defconfig: Add HBMC related configs)
>>
>> is adding support for HBMC. So it was functional before.
> Yes, I see that now, that's good.
>
>> Later due to DT sync and HBMC was broken so we disabled HBMC with sha id
>> 5b2671594b80af116e259313d48bcd580d71f462.
>>
>>
>> After that there was attempt to enable HBMC via below sha ids
>>
>> 8f71d37838ba0b0bfa047f5133877092ee9d1110 (mtd: Kconfig: Change HBMC driver's
>> dependency to MULTIPLEXER and MUX_MMIO)
>>
>> fd7fcd4098d5c1ba9e20dbd72aa5f9a74f0cbe42 (configs: j721e_evm_*_defconfig:
>> Add configs for Hyperflash boot)
>>
>> c9df79ee64d0885277d5061a9426744920c4d6a5 (arm: dts: k3-j721e-r5-common: Add
>> HBMC overrides for R5 SPL)
>>
>> a42b8b0b3fe0ffe69ffb932bf3e709a62ff34a23 (mtd: HBMC-AM654: Changed syscon
>> API to mux APIs)
>>
>> f0558f3a89fe0fa900b162ae2758772e37f72739 (mux: Makefile: Add config for mux
>> drivers)
> I guess my main frustration now is just that it's unclear where along
> the way what was submitted was or wasn't fully tested. We have both
> Kconfig dependency changes and dts additions (but not binding changes).

I understand your frustration,

we will take care of testing part.


>
> At the end of the day however, we don't yet have a linux kernel style
> "backport changes to eveywhere a fixes tag exists in old but supported
> releases" work flow, so we can just drop the fixes tag if it's too
> tricky to see where things did / didn't work. Alternatively, with the
> list of commits above and a board to test on, checkout the tree at the
> commit prior to that, test, then test the commit and see what the
> functional change is.
>
