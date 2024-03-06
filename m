Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143F7C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 13:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7603287653;
	Wed,  6 Mar 2024 14:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ABzgh4fB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB42587DA1; Wed,  6 Mar 2024 14:44:33 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6890D86308
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 14:44:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1709732671; x=1712324671;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=14KtJ/TvIo6vLT4Irrb1lZ+p4jQxxPJjDD4o4W9r9CQ=;
 b=ABzgh4fBu9o/w+tBk8byI98FehearuPY8qjVgE2Ylq3dAkBf6Q9qwbnxenX5ARZ2
 +vxEZOQ322/R8s+7c5988uSnFKzgeJE0p4mxTF6TVsqxkWnyNViTJmZMKi+zd3xj
 jAHedKsZ/Q6mgRAEsioSzSm/4Suh23v9gJ4fcW7d1vc=;
X-AuditID: ac14000a-fbefe7000000290d-52-65e8733fb9db
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 7A.D2.10509.F3378E56;
 Wed,  6 Mar 2024 14:44:31 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 6 Mar 2024
 14:44:30 +0100
Message-ID: <68235312-4121-4ffa-a735-6558fe5a3794@phytec.de>
Date: Wed, 6 Mar 2024 14:44:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm: mach-k3: am625: copy bootindex to OCRAM for main
 domain SPL
To: Vignesh Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <upstream@lists.phytec.de>, <bb@ti.com>
References: <20240226133006.3279993-1-w.egorov@phytec.de>
 <20240226133006.3279993-2-w.egorov@phytec.de>
 <eeda9c00-d7c6-444b-ba77-f70b2f19eb2a@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <eeda9c00-d7c6-444b-ba77-f70b2f19eb2a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsWyRpKBR9e++EWqwcobHBZz3xxgtXjz4yyT
 xdu9newW3e/ULf6f/cDuwOpx9s4ORo/+7hZWj+M3tjMFMEdx2aSk5mSWpRbp2yVwZSw83M1c
 cF2z4tXGHrYGxq2KXYycHBICJhKLdm5l6mLk4hASWMwkMa9xEwuEc4dRoufLY2aQKl4BG4ml
 d3axgNgsAioSL5qXs0DEBSVOznwCZosKyEvcvzWDHcQWFoiWaFq7FSwuIuAosX3FFUYQm1nA
 QuLciStsEAtmMkrs6t/EDJEQl7j1ZD4TiM0moC5xZ8M3VhCbU8BKYvvxrXDNi98cZIew5SW2
 v50D1isEZL+4BHGQBJA97dxrZgg7VOLIptVMExiFZyG5dRaSdbOQjJ2FZOwCRpZVjEK5mcnZ
 qUWZ2XoFGZUlqcl6KambGEGxIcLAtYOxb47HIUYmDsZDjBIczEoivDW/nqQK8aYkVlalFuXH
 F5XmpBYfYpTmYFES513dEZwqJJCeWJKanZpakFoEk2Xi4JRqYJwdP217ae0RNfc7PFNltgdm
 u11f97r70XfO3UIfTzP823XxlUXVyzsxFz3cFIRU5fzOHH7zgMfvQvRv8wmV9ZlG0y49+HSk
 7PfmC4fvxjL2x3obnzBjXnRiX/KVKb0i218/O5om9M5E5Hdeoj8fz1H7vTmxkbbvT9Rva5ib
 VlKxKiOj+HDFwholluKMREMt5qLiRAAxmoL+ewIAAA==
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

Hi Vignesh,

Am 04.03.24 um 06:06 schrieb Vignesh Raghavendra:
> Hi Wadim,
>
> On 26/02/24 19:00, Wadim Egorov wrote:
>> Texas Instruments has begun enabling security settings on the SoCs it
>> produces to instruct ROM and TIFS to begin protecting the Security
>> Management Subsystem (SMS) from other binaries we load into the chip by
>> default.
>>
>> One way ROM and TIFS do this is by enabling firewalls to protect the
>> OCSRAM and HSM RAM regions they're using during bootup.
>>
>> The HSM RAM the wakeup SPL is in is firewalled by TIFS to protect
>> itself from the main domain applications. This means the 'bootindex'
>> value in HSM RAM, left by ROM to indicate if we're using the primary
>> or secondary boot-method, must be moved to OCSRAM (that TIFS has open
>> for us) before we make the jump to the main domain so the main domain's
>> bootloaders can keep access to this information.
>>
>> Based on commit
>>    b672e8581070 ("arm: mach-k3: copy bootindex to OCRAM for main domain SPL")
>>
> FYI, this is mostly a problem in non SPL flow (TI prosperity SBL for
> example) where HSM RAM would be used by HSM firmware. This should be a
> issue in R5 SPL flow.  Do you see any issues today? If so, whats the
> TIFS firmware being used?

I remember I was losing the bootindex using ti/downstream u-boot.
But can't figure out the exact version anymore.
Just did a bit of testing and I can not see the Issue with the current 
u-boot.
Boot index in 0x43c3f290 stays intact.

Would it be okay to drop this patch and keep only the 2nd patch that 
factors out into get_boot_device()?

Regards,
Wadim

>
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>> ---
>>   arch/arm/mach-k3/Kconfig                      |  3 ++-
>>   arch/arm/mach-k3/am625_init.c                 | 15 +++++++++++++--
>>   arch/arm/mach-k3/include/mach/am62_hardware.h | 15 +++++++++++++++
>>   3 files changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
>> index 03898424c9..f5d06593f7 100644
>> --- a/arch/arm/mach-k3/Kconfig
>> +++ b/arch/arm/mach-k3/Kconfig
>> @@ -75,7 +75,8 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
>>   	default 0x41cffbfc if SOC_K3_J721E
>>   	default 0x41cfdbfc if SOC_K3_J721S2
>>   	default 0x701bebfc if SOC_K3_AM642
>> -	default 0x43c3f290 if SOC_K3_AM625
>> +	default 0x43c3f290 if SOC_K3_AM625 && CPU_V7R
>> +	default 0x7000f290 if SOC_K3_AM625 && ARM64
>>   	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
>>   	default 0x7000f290 if SOC_K3_AM62A7 && ARM64
>>   	help
>> diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
>> index 6c96e88114..67cf63b103 100644
>> --- a/arch/arm/mach-k3/am625_init.c
>> +++ b/arch/arm/mach-k3/am625_init.c
>> @@ -35,8 +35,10 @@ static struct rom_extended_boot_data bootdata __section(".data");
>>   static void store_boot_info_from_rom(void)
>>   {
>>   	bootindex = *(u32 *)(CONFIG_SYS_K3_BOOT_PARAM_TABLE_INDEX);
>> -	memcpy(&bootdata, (uintptr_t *)ROM_EXTENDED_BOOT_DATA_INFO,
>> -	       sizeof(struct rom_extended_boot_data));
>> +	if (IS_ENABLED(CONFIG_CPU_V7R)) {
>> +		memcpy(&bootdata, (uintptr_t *)ROM_EXTENDED_BOOT_DATA_INFO,
>> +		       sizeof(struct rom_extended_boot_data));
>> +	}
>>   }
>>   
>>   static void ctrl_mmr_unlock(void)
>> @@ -175,6 +177,15 @@ void board_init_f(ulong dummy)
>>   		k3_sysfw_loader(true, NULL, NULL);
>>   	}
>>   
>> +#if defined(CONFIG_CPU_V7R)
>> +	/*
>> +	 * Relocate boot information to OCRAM (after TIFS has opend this
>> +	 * region for us) so the next bootloader stages can keep access to
>> +	 * primary vs backup bootmodes.
>> +	 */
>> +	writel(bootindex, K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
>> +#endif
>> +
>>   	/*
>>   	 * Force probe of clk_k3 driver here to ensure basic default clock
>>   	 * configuration is always done.
>> diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
>> index 54380f36e1..9f504f4642 100644
>> --- a/arch/arm/mach-k3/include/mach/am62_hardware.h
>> +++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
>> @@ -76,8 +76,23 @@
>>   #define CTRLMMR_MCU_RST_CTRL			(MCU_CTRL_MMR0_BASE + 0x18170)
>>   
>>   #define ROM_EXTENDED_BOOT_DATA_INFO		0x43c3f1e0
>> +#define K3_BOOT_PARAM_TABLE_INDEX_OCRAM         0x7000F290
>>   
>> +/*
>> + * During the boot process ROM will kill anything that writes to OCSRAM.
> R5 ROM is long gone when R5 SPL starts, how would it kill anything?
>
>> + * This means the wakeup SPL cannot use this region during boot. To
>> + * complicate things, TIFS will set a firewall between HSM RAM and the
>> + * main domain.
>> + *
>> + * So, during the wakeup SPL, we will need to store the EEPROM data
>> + * somewhere in HSM RAM, and the main domain's SPL will need to store it
>> + * somewhere in OCSRAM
>> + */
>> +#ifdef CONFIG_CPU_V7R
>>   #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x43c30000
>> +#else
>> + #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	0x70000001
> Why not  0x70000000 ?
>
>> +#endif /* CONFIG_CPU_V7R */
>>   
> Can't we store directly in OCRAM in both stages? This RAM should be
> accessible post TIFS is up (ie post k3_sysfw_loader() call)
>
>>   static inline int k3_get_core_nr(void)
>>   {
