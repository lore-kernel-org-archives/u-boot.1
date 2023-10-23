Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B636CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 12:11:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1781787854;
	Mon, 23 Oct 2023 14:11:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pF/DvmFo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B56D2878AE; Mon, 23 Oct 2023 14:11:24 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FA678786B
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 14:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39NCBG4u076309;
 Mon, 23 Oct 2023 07:11:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698063076;
 bh=nMbw97rt7ZZB8cjTgTn6jDWU9BcYyxT3mjIPx8cC41Y=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=pF/DvmFoe2WqM8TPh3NLH6tWuC0AF8JrppYJQOceMErNN5TIV1vQviGC93a/F4g6m
 I+vJ1NYaPr+2EBr5hdaOUwEQk8t6NRIMrWNEcX/ej5ZCmz6mko/1kvUqo3HSApkUk3
 plR2cmIqm8MNPm2WasmWL+x0DKT49dUr6qeT6cfA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39NCBGDJ059595
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 23 Oct 2023 07:11:16 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Oct 2023 07:11:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Oct 2023 07:11:15 -0500
Received: from [172.24.227.6] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39NCBAkI072227;
 Mon, 23 Oct 2023 07:11:11 -0500
Message-ID: <ab69f5bc-763c-6c0f-13d5-af10c56faaf6@ti.com>
Date: Mon, 23 Oct 2023 17:41:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 1/5] arm: mach-k3: common: Reserve video memory from
 end of the RAM
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <agust@denx.de>, <trini@konsulko.com>,
 <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>,
 <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>
References: <20231016160611.1353458-1-devarsht@ti.com>
 <20231016160611.1353458-2-devarsht@ti.com>
 <CAPnjgZ1y1Strc7-qiDA6hG6sQaFKarYGaQZ1dGv_NSCyMbzK-Q@mail.gmail.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <CAPnjgZ1y1Strc7-qiDA6hG6sQaFKarYGaQZ1dGv_NSCyMbzK-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On 19/10/23 19:26, Simon Glass wrote:
> Hi Devarsh,
> 
> On Mon, 16 Oct 2023 at 10:06, Devarsh Thakkar <devarsht@ti.com> wrote:
>>
>> Move the function to setup video memory before page table
>> reservation so that framebuffer memory gets reserved from
>> the end of RAM.
>>
>> This is as per the new policy being discussed for passing
>> blobs where each of the reserved areas for bloblists
>> to be passed need to be reserved at the end of RAM.
>>
>> This is to enable the next stage to directly skip
>> the pre-reserved area from previous stage without
>> having to making any gaps/holes to accomodate those
>> regions which was the case if previous stage
>> reserved region say somewhere in the middle and not at
>> the end of RAM.
>>
>> Suggested-by: Simon Glass <sjg@chromium.org>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> ---
>>  arch/arm/mach-k3/common.c | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
>> index cc755dd1bf..3978b9ccca 100644
>> --- a/arch/arm/mach-k3/common.c
>> +++ b/arch/arm/mach-k3/common.c
>> @@ -27,6 +27,7 @@
>>  #include <env.h>
>>  #include <elf.h>
>>  #include <soc.h>
>> +#include <video.h>
>>
>>  #if IS_ENABLED(CONFIG_SYS_K3_SPL_ATF)
>>  enum {
>> @@ -522,6 +523,24 @@ void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size)
>>         }
>>  }
>>
>> +static int video_setup(void)
> 
> Shouldn't this be in generic code?
> 

The reason I kept it here instead of video-uclass was since this function also
uses and updates gd->relocaddr and not just reserves the memory region and I
don't see any function in video-uclass playing with gd->relocaddr
and this is inspired by and parallel to reserve_video from common/board_f.c
which is also static function defined in board_f instead of video-uclass.

This basically is a wrapper function which calls video_reserve and also
uses/updates gd->relocaddr, since I am calling this for SPL I could not find
any common layer to define this since most vendors call board_init_f from
platform specific file which in turn call this function.

Could you please share your opinion and suggestions for generic location if
above still not look good?

Regards
Devarsh

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
>>  void spl_enable_dcache(void)
>>  {
>>  #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
>> @@ -537,6 +556,8 @@ void spl_enable_dcache(void)
>>         if (ram_top >= 0x100000000)
>>                 ram_top = (phys_addr_t) 0x100000000;
>>
>> +       gd->relocaddr = ram_top;
>> +       video_setup();
>>         gd->arch.tlb_addr = ram_top - gd->arch.tlb_size;
>>         gd->arch.tlb_addr &= ~(0x10000 - 1);
>>         debug("TLB table from %08lx to %08lx\n", gd->arch.tlb_addr,
>> --
>> 2.34.1
>>
> 
> Regards,
> Simon
