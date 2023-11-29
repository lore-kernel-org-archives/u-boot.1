Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7E0C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 15:23:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CE7486D34;
	Wed, 29 Nov 2023 16:23:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Dp2E9kFa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7285386D4C; Wed, 29 Nov 2023 16:23:22 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A24EA86D34
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 16:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ATFND6D097636;
 Wed, 29 Nov 2023 09:23:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701271393;
 bh=jUdfV9jea2KpEXaSAvKmcWd8YVO0utSMHe0peC7VmeM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Dp2E9kFaGKejSHVIjBtl9+zZmqTKmaKW74OJCufRnWtJUde9vCjszsZ4c1mCRQDAW
 vTXCsgVlvpltD0oFvba/U6JPhyW5JewXGD6SjCqH4k+EM+YwcpyGP33XGBOK0GGiH2
 Q3Om3QUjXdSBvox0fmZQXfZf0k4Lmfz1ixqpRtCE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ATFND9B012190
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 Nov 2023 09:23:13 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 Nov 2023 09:23:12 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 Nov 2023 09:23:13 -0600
Received: from [10.249.36.40] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ATFNCgu008606;
 Wed, 29 Nov 2023 09:23:12 -0600
Message-ID: <0769310a-30c9-42f1-9bb6-c70ef606c1ae@ti.com>
Date: Wed, 29 Nov 2023 09:23:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] arm: mach-k3: Do not map ATF and OPTEE regions in
 MMU
To: Manorit Chawdhry <m-chawdhry@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
 <nm@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Apurva Nandan <a-nandan@ti.com>
CC: <u-boot@lists.denx.de>
References: <20231128170528.407707-1-afd@ti.com>
 <20231128170528.407707-3-afd@ti.com>
 <2c6f7369-ff74-455d-a3f3-d40abde033de@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <2c6f7369-ff74-455d-a3f3-d40abde033de@ti.com>
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

On 11/29/23 2:00 AM, Manorit Chawdhry wrote:
> Hi Andrew,
> 
> On 28/11/23 22:35, Andrew Davis wrote:
>> ATF and OPTEE regions may be firewalled from non-secure entities. To
>> prevent access to this area we leave a hole there in the MMU map. This
>> is the same idea as [0] but we complete that patch by adding the same
>> for AM65, J721e, J7200, and J721s2 here.
>>
>> [0] commit 0688ff3ae23c ("arm: mach-k3: arm64-mmu: do not map ATF and OPTEE regions in A53 MMU")
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   arch/arm/mach-k3/arm64-mmu.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-k3/arm64-mmu.c b/arch/arm/mach-k3/arm64-mmu.c
>> index d872ed714c4..5c858ae0f84 100644
>> --- a/arch/arm/mach-k3/arm64-mmu.c
>> +++ b/arch/arm/mach-k3/arm64-mmu.c
>> @@ -24,7 +24,7 @@ struct mm_region am654_mem_map[] = {
>>   	}, {
>>   		.virt = 0x80000000UL,
>>   		.phys = 0x80000000UL,
>> -		.size = 0x20000000UL,
>> +		.size = 0x1e780000UL,
>>   		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>   			 PTE_BLOCK_INNER_SHARE
>>   	}, {
>> @@ -75,7 +75,7 @@ struct mm_region j7200_mem_map[] = {
>>   	}, {
>>   		.virt = 0x80000000UL,
>>   		.phys = 0x80000000UL,
>> -		.size = 0x20000000UL,
>> +		.size = 0x1e780000UL,
> 
> ATF lies 0x70000000 for j7 devices.
> 
> For reference.
> 
> configs/am62ax_evm_a53_defconfig:8:8:CONFIG_K3_ATF_LOAD_ADDR=0x9e780000
>   
> configs/verdin-am62_a53_defconfig:11:8:CONFIG_K3_ATF_LOAD_ADDR=0x9e780000
>   
> configs/am64x_evm_a53_defconfig:11:8:CONFIG_K3_ATF_LOAD_ADDR=0x701c0000  -> This
> is also different
>                                                                                                                 
> 
> configs/am62x_beagleplay_a53_defconfig:9:8:CONFIG_K3_ATF_LOAD_ADDR=0x9e780000
> configs/am62x_evm_a53_defconfig:8:8:CONFIG_K3_ATF_LOAD_ADDR=0x9e780000
> 
> and rest all devices use 0x70000000
> 
> OP-TEE is consistent across all SoCs and lies at 9e800000 and I can see that
> removing the map after 9e780000 does
> handle that but am not sure if I see the ATF being unified with all this flow.
> 

We don't need to carve out ATF in our MMU map when it lives in SRAM as
SRAM is already marked non-caching/device memory and so shouldn't be
touched by U-Boot. Only when in DRAM do we do this carveout, and for all
platforms that have ATF in DRAM it lies at 0x9e780000. So we make the
MMU gap start at this location.

But as you have noticed, for platforms that keep ATF in SRAM this hole in
DRAM is slightly larger than it needs to be (but that doesn't hurt anything,
the OP-TEE hole is ~24MB and this just makes it just 128KB larger. This is
DRAM so no one will care about 128KB).

The benefit of unconditionally leaving the MMU gap in DRAM cover where ATF
would have been, even on SRAM platforms, is it makes the memory map unified
across all platforms allowing us to combine them as in patch [4/4].

Andrew

> Regards,
> Manorit
> 
>>   		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>   			 PTE_BLOCK_INNER_SHARE
>>   	}, {
>> @@ -123,7 +123,7 @@ struct mm_region j721e_mem_map[] = {
>>   	}, {
>>   		.virt = 0x80000000UL,
>>   		.phys = 0x80000000UL,
>> -		.size = 0x20000000UL,
>> +		.size = 0x1e780000UL,
>>   		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>   			 PTE_BLOCK_INNER_SHARE
>>   	}, {
>> @@ -180,7 +180,13 @@ struct mm_region j721s2_mem_map[] = {
>>   	}, {
>>   		.virt = 0x80000000UL,
>>   		.phys = 0x80000000UL,
>> -		.size = 0x80000000UL,
>> +		.size = 0x1e780000UL,
>> +		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>> +			 PTE_BLOCK_INNER_SHARE
>> +	}, {
>> +		.virt = 0xa0000000UL,
>> +		.phys = 0xa0000000UL,
>> +		.size = 0x60000000UL,
>>   		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>>   			 PTE_BLOCK_INNER_SHARE
>>   	}, {
