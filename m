Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD2ED5CC9F
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 12:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F055688DFE;
	Wed, 30 Oct 2024 13:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MYenxnLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 658DF88DFE; Wed, 30 Oct 2024 13:15:53 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E63F788B9F
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 13:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49UCFmmR046577;
 Wed, 30 Oct 2024 07:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1730290548;
 bh=kE41iflDlcNyyGqqtEXYmRWRqCCLCBpqh+yn5Q2Wk4A=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=MYenxnLr+KR4TJ+HPAnGf3JZVYNZnjKgj1P6mTn9r3fP3CSidVlZVlzEvzzA55UER
 o1kxvMBsSeXRH+LdDSqpiA8FXBNJteKQ1M30Wk6iLU9K1QARHsPHl97E44M5Ug/mrr
 GKLAB00LnXGnVaCDHRON3wj/8+AkAiv2kFq27L4U=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49UCFm2i105998
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Oct 2024 07:15:48 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Oct 2024 07:15:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Oct 2024 07:15:47 -0500
Received: from [172.24.227.91] (psdkl-workstation0.dhcp.ti.com [172.24.227.91])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49UCFjWM025858;
 Wed, 30 Oct 2024 07:15:46 -0500
Message-ID: <cc186025-c70b-428e-a19f-0581d6a88fa8@ti.com>
Date: Wed, 30 Oct 2024 17:45:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm: mach-k3: j721e-init.c: J7200: Add support for
 CONFIG_K3_OPP_LOW
To: Manorit Chawdhry <m-chawdhry@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <nm@ti.com>
References: <20241023130033.1826413-1-a-limaye@ti.com>
 <20241023130033.1826413-5-a-limaye@ti.com>
 <20241029101025.n6xioxbqqwhpbbmz@uda0497581>
 <20241030080100.em6zd5xfhu64xsdp@uda0497581>
 <20241030082845.7gmdwicixpjoh7zi@uda0497581>
Content-Language: en-US
From: Aniket Limaye <a-limaye@ti.com>
In-Reply-To: <20241030082845.7gmdwicixpjoh7zi@uda0497581>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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



On 30/10/24 13:58, Manorit Chawdhry wrote:
> Hi Neha, Aniket,
> 
> On 13:31-20241030, Manorit Chawdhry wrote:
>> Hi Aniket,
>>
>> On 15:40-20241029, Manorit Chawdhry wrote:
>>> Hi Aniket,
>>>
>>> On 18:27-20241023, Aniket Limaye wrote:
>>>> From: Reid Tonking <reidt@ti.com>
>>>>
>>>> The default j7200 devicetree and k3_avs driver set 2GHz/1GHz frequency
>>>> for A72/MSMC clks and the OPP_NOM voltage.
>>>>
>>>> J7200 SOCs may support OPP_LOW Operating Performance Point:
>>>> 1GHz/500MHz clks for A72/MSMC and OPP_LOW AVS voltage read from efuse.
>>>>
>>>> Hence, add a config check to select OPP_LOW specs:
>>>> - Check if OPP_LOW AVS voltage read from efuse is valid.
>>>> - Update the clock frequencies in devicetree.
>>>> - Program the OPP_LOW AVS voltage for VDD_CPU.
>>>>
>>>> Signed-off-by: Reid Tonking <reidt@ti.com>
>>>> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
>>>>
>>>> ---
> [...]
>>>>   
>>>> +int fix_freq(const void *fdt)
>>
>> I think this can be static as well btw, maybe rename it to something
>> more descriptive as well. fdt_fixup_a72_clock_frequency?
> 
> Do you think ft_system_setup is a good place for doing this fixup btw?
> Was wondering that it would be good to know what all DT fixups are being
> done at some common place instead of multiple scattered places but not
> sure when does ft_system_setup kick in, would it be before we startup
> a72?


So it looks like ft_system_setup is being called only before booting 
into linux Kernel.

As discussed offline, another place to handle fdt_fixups cleanly could 
be spl_perform_fixups() in board/ti/j721e/evm.c

I would agree that this dt fixup would be better placed there instead of 
in board_init_f() directly. Will try doing that.

Thanks,
Aniket

> 
> Regards,
> Manorit
