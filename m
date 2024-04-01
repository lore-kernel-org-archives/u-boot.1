Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27236CD1283
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 09:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DFA88801E;
	Mon,  1 Apr 2024 11:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="nZF7Xt6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1B01882E0; Mon,  1 Apr 2024 11:24:20 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4521E8810D
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 11:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1711963457; x=1714555457;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IKtxA7g+QNHCEnPDIBGILrS5Mg+2mlSPZN/T+wFaq90=;
 b=nZF7Xt6ZgLjxc3jdg4I4GDt755a95mQFO4vlCxtswRHd2un1iErfnwf4ikJUMJk4
 7F5WcGGiDMVREDWDQPR7VAliZ7q0RgiRxkxTcWLuxhojmKjGUesKEkXwKK0dLuR9
 GVzKbuqABALcjTR2fUqYvP2HlbvsApe4uXqrTwAGUAg=;
X-AuditID: ac14000a-fbefe7000000290d-5e-660a7d41ecad
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id FF.97.10509.14D7A066;
 Mon,  1 Apr 2024 11:24:17 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 1 Apr 2024
 11:24:16 +0200
Message-ID: <dba27c99-b160-4e45-ab68-d5fdb69ef984@phytec.de>
Date: Mon, 1 Apr 2024 11:24:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm: mach-k3: am625: copy bootindex to OCRAM for main
 domain SPL
To: "Raghavendra, Vignesh" <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <upstream@lists.phytec.de>
References: <20240226133006.3279993-1-w.egorov@phytec.de>
 <20240226133006.3279993-2-w.egorov@phytec.de>
 <eeda9c00-d7c6-444b-ba77-f70b2f19eb2a@ti.com>
 <20240304202717.7ruiozbuzy4bv5iz@bryanbrattlof.com>
 <2428cd68-f69f-4915-bd94-f7b6bb84152c@ti.com>
 <20240305173457.ir564jlw3euux54n@bryanbrattlof.com>
 <c6e446a6-c767-4c61-87f5-8cc310c7178a@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <c6e446a6-c767-4c61-87f5-8cc310c7178a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWyRpKBR9exlivN4PIdZYu5bw6wWrz5cZbJ
 4u3eTnaL7nfqFv/PfmB3YPU4e2cHo0d/dwurx/Eb25kCmKO4bFJSczLLUov07RK4Mk7NuslU
 sMW4ouH9CZYGxhuaXYwcHBICJhKnLzB1MXJxCAksYZJYtPsBlHOHUaJ752b2LkZODl4BG4kZ
 UyeygNgsAioS0572s0DEBSVOznwCZosKyEvcvzUDrF5YIFqiae1WsLiIgIdE39F7YDazgLPE
 5FUfGEFsIYGnTBIv3wdBxMUlbj2ZzwRiswmoS9zZ8I0VxOYUsJKYtqyRCaLGQmLxm4PsELa8
 RPPW2cwQc+QlXlxaDjZfAsiedu41M4QdKrH1y3amCYzCs5CcOgvJullIxs5CMnYBI8sqRqHc
 zOTs1KLMbL2CjMqS1GS9lNRNjKC4EGHg2sHYN8fjECMTB+MhRgkOZiUR3p/enGlCvCmJlVWp
 RfnxRaU5qcWHGKU5WJTEeVd3BKcKCaQnlqRmp6YWpBbBZJk4OKUaGMXXnlxwfx/bpFctM9tK
 0y1rCxesaRFh2n5yAtfmeVsmctx343t21uG6fw6rjOjOuKjaay0u+QIX3j5xb44UcvKqdji6
 /aX9jSu/FBzLkmqLnZxe2z9LvvOpfHvgzsuLpD4E3Vtnp9vt/6l7xh6TltveYv3JPBnrXma+
 Wy4ct3zakd1XDkV6zlBiKc5INNRiLipOBADUPFVReQIAAA==
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

Hi Vignesh, Hi Bryan,


Am 05.03.24 um 18:36 schrieb Raghavendra, Vignesh:
> 
> 
> On 3/5/2024 11:04 PM, Bryan Brattlof wrote:
>> On March  5, 2024 thus sayeth Vignesh Raghavendra:
>>>
>>> On 05/03/24 01:57, Bryan Brattlof wrote:
>>>> Hey Vignesh!
>>>>
>>>> On March  4, 2024 thus sayeth Vignesh Raghavendra:
>>>>> Hi Wadim,
>>>>>
>>>>> On 26/02/24 19:00, Wadim Egorov wrote:
>>>>>> Texas Instruments has begun enabling security settings on the SoCs it
>>>>>> produces to instruct ROM and TIFS to begin protecting the Security
>>>>>> Management Subsystem (SMS) from other binaries we load into the chip by
>>>>>> default.
>>>>>>
>>>>>> One way ROM and TIFS do this is by enabling firewalls to protect the
>>>>>> OCSRAM and HSM RAM regions they're using during bootup.
>>>>>>
>>>>>> The HSM RAM the wakeup SPL is in is firewalled by TIFS to protect
>>>>>> itself from the main domain applications. This means the 'bootindex'
>>>>>> value in HSM RAM, left by ROM to indicate if we're using the primary
>>>>>> or secondary boot-method, must be moved to OCSRAM (that TIFS has open
>>>>>> for us) before we make the jump to the main domain so the main domain's
>>>>>> bootloaders can keep access to this information.
>>>>>>
>>>>>> Based on commit
>>>>>>    b672e8581070 ("arm: mach-k3: copy bootindex to OCRAM for main domain SPL")

I was thinking, even if the reason described here is not right or does 
not apply to the am62x, it is still a valid solution for carrying this 
variable into the context for next stage A53 bootloader.

store_boot_info_from_rom() stores the index to the bootindex (.data) 
variable which makes sure it is valid in R5 SPL context. But the next 
stage bootloader does not know anything about the bootindex variable. So 
from my understanding it needs to be copied to a different region to 
preserve the data for next stage bootloaders.

Or do I miss something?

Regards,
Wadim

>>>>>>
>>>>> FYI, this is mostly a problem in non SPL flow (TI prosperity SBL for
>>>>> example) where HSM RAM would be used by HSM firmware. This should be a
>>>>> issue in R5 SPL flow.  Do you see any issues today? If so, whats the
>>>>> TIFS firmware being used?
>>>>>
>>>>>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>>>>>> ---
>>>>>>   arch/arm/mach-k3/Kconfig                      |  3 ++-
>>>>>>   arch/arm/mach-k3/am625_init.c                 | 15 +++++++++++++--
>>>>>>   arch/arm/mach-k3/include/mach/am62_hardware.h | 15 +++++++++++++++
>>>>>>   3 files changed, 30 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
>>>>>> index 03898424c9..f5d06593f7 100644
>>>>>> --- a/arch/arm/mach-k3/Kconfig
>>>>>> +++ b/arch/arm/mach-k3/Kconfig
>>>>>> @@ -75,7 +75,8 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
>>>>>>   	default 0x41cffbfc if SOC_K3_J721E
>>>>>>   	default 0x41cfdbfc if SOC_K3_J721S2
>>>>>>   	default 0x701bebfc if SOC_K3_AM642
>>>>>> -	default 0x43c3f290 if SOC_K3_AM625
>>>>>> +	default 0x43c3f290 if SOC_K3_AM625 && CPU_V7R
>>>>>> +	default 0x7000f290 if SOC_K3_AM625 && ARM64
>>>>>>   	default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
>>>>>>   	default 0x7000f290 if SOC_K3_AM62A7 && ARM64
>>>>>>   	help
>>>>>> diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
>>>>>> index 6c96e88114..67cf63b103 100644
>>>>>> --- a/arch/arm/mach-k3/am625_init.c
>>>>>> +++ b/arch/arm/mach-k3/am625_init.c
>>>>>> @@ -35,8 +35,10 @@ static struct rom_extended_boot_data bootdata __section(".data");
>>>>>>   static void store_boot_info_from_rom(void)
>>>>>>   {
>>>>>>   	bootindex = *(u32 *)(CONFIG_SYS_K3_BOOT_PARAM_TABLE_INDEX);
>>>>>> -	memcpy(&bootdata, (uintptr_t *)ROM_EXTENDED_BOOT_DATA_INFO,
>>>>>> -	       sizeof(struct rom_extended_boot_data));
>>>>>> +	if (IS_ENABLED(CONFIG_CPU_V7R)) {
>>>>>> +		memcpy(&bootdata, (uintptr_t *)ROM_EXTENDED_BOOT_DATA_INFO,
>>>>>> +		       sizeof(struct rom_extended_boot_data));
>>>>>> +	}
>>>>>>   }
>>>>>>   
>>>>>>   static void ctrl_mmr_unlock(void)
>>>>>> @@ -175,6 +177,15 @@ void board_init_f(ulong dummy)
>>>>>>   		k3_sysfw_loader(true, NULL, NULL);
>>>>>>   	}
>>>>>>   
>>>>>> +#if defined(CONFIG_CPU_V7R)
>>>>>> +	/*
>>>>>> +	 * Relocate boot information to OCRAM (after TIFS has opend this
>>>>>> +	 * region for us) so the next bootloader stages can keep access to
>>>>>> +	 * primary vs backup bootmodes.
>>>>>> +	 */
>>>>>> +	writel(bootindex, K3_BOOT_PARAM_TABLE_INDEX_OCRAM);
>>>>>> +#endif
>>>>>> +
>>>>>>   	/*
>>>>>>   	 * Force probe of clk_k3 driver here to ensure basic default clock
>>>>>>   	 * configuration is always done.
>>>>>> diff --git a/arch/arm/mach-k3/include/mach/am62_hardware.h b/arch/arm/mach-k3/include/mach/am62_hardware.h
>>>>>> index 54380f36e1..9f504f4642 100644
>>>>>> --- a/arch/arm/mach-k3/include/mach/am62_hardware.h
>>>>>> +++ b/arch/arm/mach-k3/include/mach/am62_hardware.h
>>>>>> @@ -76,8 +76,23 @@
>>>>>>   #define CTRLMMR_MCU_RST_CTRL			(MCU_CTRL_MMR0_BASE + 0x18170)
>>>>>>   
>>>>>>   #define ROM_EXTENDED_BOOT_DATA_INFO		0x43c3f1e0
>>>>>> +#define K3_BOOT_PARAM_TABLE_INDEX_OCRAM         0x7000F290
>>>>>>   
>>>>>> +/*
>>>>>> + * During the boot process ROM will kill anything that writes to OCSRAM.
>>>>> R5 ROM is long gone when R5 SPL starts, how would it kill anything?
>>>> Looks like this was based on my patch long ago for the AM62Ax family.
>>>>  From what little I remember about this was ROM is leaving behind a
>>>> firewall that we need TIFS's help to bring down for us. So I just
>>>> blamed ROM 😉
>>> Thats true. ROM does bare minimum and so wont open up firewall around
>>> main SRAM. but TIFS does, so you should be able to access this region
>>> post k3_sysfw_loader().
>>>
>>>> IDK if this is an issue for the AM62x family though.
>>>>
>>> It might be if one tries to "select" DT using EEPROM detect before SYSFW
>>> is up. But that's not the case any more right?
>> Yep we still need to figure out a plan for multiple DDR configs or see
>> if we can move the DDR init to later in the boot as that is the only
>> thing left that still needs the board detection this early on.
>>
>> There is a little race condition here as TIFS can respond to some
>> messages before it's finished its init. IDK if we can send it anything
>> to act like a fence and stall us until the firewalls are down though.
> 
> Firewall configurations should be done before TIFS posts boot
> notification message.
> 
> Regards
> Vignesh
