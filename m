Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF1AC4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 17:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7BFD870E1;
	Fri,  3 Nov 2023 18:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QJ1iiWyO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 244BC87106; Fri,  3 Nov 2023 18:48:56 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3868B86EB5
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 18:48:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A3HmK3k022367;
 Fri, 3 Nov 2023 12:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699033700;
 bh=5G7z9L8/n+kBfBl0AlU/pJxWc+IiZ6kFaQ5/LjfgDNo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=QJ1iiWyOOkl3c5K1gD2XU3OR90Fi96bfrOMTo9JxsWZrokQOAuSxsWNbhRZuDHI1b
 CWJ/uNrtd9d9YSArkdiMHwYcJKDn3RMKun6k9rM9VQaE0ZcaUzxPjj0q+kD0xndiPW
 qZFqhXS/FScu8/1As6ZYUyEPf7vsI6WktZ/xnO6E=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A3HmKMf076007
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 Nov 2023 12:48:20 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 Nov 2023 12:48:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 Nov 2023 12:48:20 -0500
Received: from [10.250.149.140] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A3HmETt028120;
 Fri, 3 Nov 2023 12:48:15 -0500
Message-ID: <24320603-e448-11e1-fb80-74db72fb009c@ti.com>
Date: Fri, 3 Nov 2023 23:18:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/5] arm: mach-k3: common: Reserve video memory from
 end of the RAM
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <agust@denx.de>, <trini@konsulko.com>,
 <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>,
 <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>
References: <20231031131208.435268-1-devarsht@ti.com>
 <20231031131208.435268-2-devarsht@ti.com>
 <CAPnjgZ3U_HDUfm+GBDSm44FZFx7n5nrZbM3gHHYkyYj7P2582w@mail.gmail.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <CAPnjgZ3U_HDUfm+GBDSm44FZFx7n5nrZbM3gHHYkyYj7P2582w@mail.gmail.com>
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

Hi Simon,

Thanks for the review.

On 03/11/23 04:16, Simon Glass wrote:
> Hi Devarsh,
> 
> On Tue, 31 Oct 2023 at 13:12, Devarsh Thakkar <devarsht@ti.com> wrote:
>>
>> Add function spl_reserve_video which is a wrapper
>> around video_reserve to setup video memory and update
>> the relocation address pointer.
>>
>> Setup video memory before page table reservation so that
>> framebuffer memory gets reserved from the end of RAM.
>>
>> This is as per the new policy being discussed for passing
>> blobs where each of the reserved areas for bloblists
>> to be passed need to be reserved at the end of RAM.
>>
>> This is done to enable the next stage to directly skip
>> the pre-reserved area from previous stage right from the end of RAM
>> without having to make any gaps/holes to accommodate those
>> regions which was the case before as previous stage
>> reserved region not from the end of RAM.
>>
>> Suggested-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> ---
>> V2: Make a generic function "spl_reserve_video" under
>>      common/spl which can be re-used by other platforms too
>>      for reserving video memory from spl.
>> ---
>>   arch/arm/mach-k3/common.c |  2 ++
>>   common/spl/spl.c          | 19 +++++++++++++++++++
>>   include/spl.h             |  4 ++++
>>   3 files changed, 25 insertions(+)
> 
>>
>> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
>> index c3006ba387..03e3b46282 100644
>> --- a/arch/arm/mach-k3/common.c
>> +++ b/arch/arm/mach-k3/common.c
>> @@ -537,6 +537,8 @@ void spl_enable_dcache(void)
>>          if (ram_top >= 0x100000000)
>>                  ram_top = (phys_addr_t) 0x100000000;
>>
>> +       gd->relocaddr = ram_top;
>> +       spl_reserve_video();
> 
> Need to check error here
> 

Ok, I can check for error and print a message, but would still proceed 
with build (similar to reserve_video in u-boot proper (from which this 
is derived)), I hope that is fine.

>>          gd->arch.tlb_addr = ram_top - gd->arch.tlb_size;
>>          gd->arch.tlb_addr &= ~(0x10000 - 1);
>>          debug("TLB table from %08lx to %08lx\n", gd->arch.tlb_addr,
>> diff --git a/common/spl/spl.c b/common/spl/spl.c
>> index 732d90d39e..89172f2ebf 100644
>> --- a/common/spl/spl.c
>> +++ b/common/spl/spl.c
>> @@ -41,6 +41,7 @@
>>   #include <fdt_support.h>
>>   #include <bootcount.h>
>>   #include <wdt.h>
>> +#include <video.h>
>>
>>   DECLARE_GLOBAL_DATA_PTR;
>>   DECLARE_BINMAN_MAGIC_SYM;
>> @@ -151,6 +152,24 @@ void spl_fixup_fdt(void *fdt_blob)
>>   #endif
>>   }
>>
>> +int spl_reserve_video(void)
>> +{
>> +       if (CONFIG_IS_ENABLED(VIDEO)) {
>> +               ulong addr;
>> +               int ret;
>> +
>> +               addr = gd->relocaddr;
>> +               ret = video_reserve(&addr);
>> +               if (ret)
>> +                       return ret;
>> +               debug("Reserving %luk for video at: %08lx\n",
>> +                     ((unsigned long)gd->relocaddr - addr) >> 10, addr);
>> +               gd->relocaddr = addr;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   ulong spl_get_image_pos(void)
>>   {
>>          if (!CONFIG_IS_ENABLED(BINMAN_UBOOT_SYMBOLS))
>> diff --git a/include/spl.h b/include/spl.h
>> index 0d49e4a454..9682e51fc1 100644
>> --- a/include/spl.h
>> +++ b/include/spl.h
>> @@ -825,6 +825,10 @@ int spl_usb_load(struct spl_image_info *spl_image,
>>
>>   int spl_ymodem_load_image(struct spl_image_info *spl_image,
>>                            struct spl_boot_device *bootdev);
>> +/**
>> + * spl_reserve_video() - Reserve video and update relocation address
> 
> This needs more detail about:
> - gd->relocaddr

Points to current relocation address which points to region below 
reserved area ?

> - where the video memory is allocated
I didn't get you, allocation is stored in RAM, is that what you mean ?

> - where the allocation is stored (in the video-device plat?)ok

> - return value
> 

Just a point of note, this spl_reserve_video is inspired by 
reserve_video from u-boot proper and we are essentially leaving upto 
users to follow the "guideline" to reserve video from RAM by setting
gd->relocaddr to end of RAM before calling to function.

But if we want to directly enforce the guideline, I can move that logic 
inside this API and we can have spl_reserve_video_from_ramtop, let me 
know your opinion on this if we want to go this way.

Regards
Devarsh

>> + */
>> +int spl_reserve_video(void);
>>
>>   /**
>>    * spl_invoke_atf - boot using an ARM trusted firmware image
>> --
>> 2.34.1
>>
> 
> Regards,
> Simon
