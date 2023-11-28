Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4C4C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 17:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F498870D2;
	Tue, 28 Nov 2023 18:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ufqaPfob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E7A686D93; Tue, 28 Nov 2023 18:00:48 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C5586314
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 18:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ASH0eFP002007;
 Tue, 28 Nov 2023 11:00:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701190840;
 bh=iwShDGim/dtCwXcAhNslgn7fOpDOmceqjlewezxaO0Q=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ufqaPfobRT39I+X7NwHj/l2piycl0XuAq9AVclVODIxItHM1dC0Wz6F85ShzY/C14
 j8IEiUXh3JJnX+T/hXg//OWSnOXw/ganpM2I3RdFxfO9oJFnycWx9L++Ez4a4opUjh
 hpv4gJHAGqrDmZE7qicEGq0D4ehY8os38NKVFbdk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ASH0eW0031988
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 Nov 2023 11:00:40 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 11:00:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 11:00:39 -0600
Received: from [10.250.33.151] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ASH0di3119849;
 Tue, 28 Nov 2023 11:00:39 -0600
Message-ID: <fc5a4b86-6f93-4a9c-904f-05e60dcfd237@ti.com>
Date: Tue, 28 Nov 2023 11:00:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm: mach-k3: Remove non-cached memory map areas
To: Nishanth Menon <nm@ti.com>, "Raghavendra, Vignesh" <vigneshr@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Apurva Nandan <a-nandan@ti.com>,
 <u-boot@lists.denx.de>
References: <20231123172214.653268-1-afd@ti.com>
 <20231123172214.653268-3-afd@ti.com>
 <fdce61c7-6517-4965-94ba-90fc8dbd2bdd@ti.com>
 <20231127154755.duf5xciqrp5mg23j@reopen>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231127154755.duf5xciqrp5mg23j@reopen>
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

On 11/27/23 9:47 AM, Nishanth Menon wrote:
> On 23:04-20231123, Vignesh Raghavendra wrote:
>>
>>
>> On 11/23/2023 10:52 PM, Andrew Davis wrote:
>>> @@ -219,16 +177,9 @@ struct mm_region am62_mem_map[] = {
>>>   	}, {
>>>   		.virt = 0x80000000UL,
>>>   		.phys = 0x80000000UL,
>>> -		.size = 0x1E780000UL,
>>> -		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>> -			PTE_BLOCK_INNER_SHARE
>>> -	}, {
>>> -		.virt = 0xA0000000UL,
>>> -		.phys = 0xA0000000UL,
>>> -		.size = 0x60000000UL,
>>> +		.size = 0x80000000UL,
>>>   		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>>   			 PTE_BLOCK_INNER_SHARE
>>> -
>>>   	}, {
>>>   		.virt = 0x880000000UL,
>>>   		.phys = 0x880000000UL,
>>
>>
>> This causes issues when TF-A region @0x9e780000 is firewalled off from
>> non-secure world. A53 does speculative accesses to this region from EL1
>> leading to FW exceptions being reported on TIFS log (although A53 itself
>> doesn't seem to abort)
> 
> Hmm... Why not just manage the ones that use TFA in DDR seperately? I
> suppose OPTEE will come in the way?
> 
> Looks like the no-map is not honored well.. as you were mentioning, a
> zephyr style generating the map from dts might be much better, but then
> we do support multiple dtbs as well..
> 
> OK - I guess we need to leave this cleanup for now.
> 

We can make the same cleanup while leaving the firewall hole in place
(it is in the same spot for all SoCs today so no problem here). I'll
send a v2 with that.

Andrew
