Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4F4E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 10:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 755CA80288;
	Wed, 18 Dec 2024 11:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="0xt5HHHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45965802EF; Wed, 18 Dec 2024 11:31:11 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 381648027E
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 11:31:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2082afbf55=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI7p9Iw007677;
 Wed, 18 Dec 2024 11:30:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 Qj8nYAeLKnxt3XIsgesskRCyvYRpkGFs0X60og4r6hg=; b=0xt5HHHkgmVNx6jP
 yDbowyh1VlJ+JtI+UTrm3x3bWOaMuOjGGWg3y1TdO6l27TCmDw6YZty4PGPGwzth
 d0l06+klkfjNR505VYigIeQvCWyUiLZNiPeOSCBvnNfpYS0tzSC+R7J8FzL6Gb/9
 KeDG5xbEXSbfb1iJ2hpENQxtQs/1K1Gym/53utaSnWvSdorAOUbl/nWjXQrzZrFW
 ryQpJeUWgoQ6OLrnde/o4GCEyWGwcAJaUOo6riqJeScGFE85kzyY5EL3FgnYSp/5
 qUKAoB4Sww5L4P+uoXC69z4pjlcIbwQq87C90Aqh/1gRmDpZwtW3i7JPdHtElW8X
 U7IbnA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ktca0qkp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Dec 2024 11:30:57 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7783F40075;
 Wed, 18 Dec 2024 11:29:07 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E717425C24A;
 Wed, 18 Dec 2024 11:28:08 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 18 Dec
 2024 11:28:08 +0100
Message-ID: <290b3572-bc50-410d-bba0-3e204e68bc56@foss.st.com>
Date: Wed, 18 Dec 2024 11:28:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Kconfig: Set STACK_SIZE to 16KB for STM32 MCUs
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Greg Malysa
 <greg.malysa@timesys.com>, Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>, Masahiro Yamada
 <yamada.masahiro@socionext.com>, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20241218075833.2049241-1-patrice.chotard@foss.st.com>
 <268def1b-0b7f-453b-b079-885ea3e49bb4@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <268def1b-0b7f-453b-b079-885ea3e49bb4@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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



On 12/18/24 10:59, Patrick DELAUNAY wrote:
> Hi
> 
> On 12/18/24 08:58, Patrice Chotard wrote:
>> Since commit 6534d26ee9a5 ("lmb: do away with arch_lmb_reserve()"),
>> STM32F746-disco hangs when loading device tree just before starting
>> kernel:
>>
>> Retrieving file: /stm32f746-disco.dtb
>> Kernel image @ 0xc0008000 [ 0x000000 - 0x19ae00 ]
>> Flattened Device Tree blob at c0408000
>>     Booting using the fdt blob at 0xc0408000
>> Working FDT set to c0408000
>>     Loading Device Tree to c05f8000, end c05ff71c ...
>>
>> Adjust STACK_SIZE to 16KB for STM32 MCUs (F4/F7 and H7) boards
>> to fix kernel boot process as some of these boards embeds a limited
>> amount of memory.
>>
>> Fixes: 6534d26ee9a5 ("lmb: do away with arch_lmb_reserve()")
> 
> 
> I think it is also linked to an other commit
> 
> Fixes:74b869bae74c ("efi_loader: use CONFIG_STACK_SIZE in the UEFI sub-system")
> 
> before the patch CONFIG_SET_STACK_SIZE was not defined for ALL ARM platform
> 
> So CONFIG_STACK_SIZE was not defined  / and was no used in platform
> 
> (U-Boot stack up to end of the U-Boot area)
> 
> after the patch the CONFIG_STACK_SIZEis set a 16MB for all platform, even if EFI is not used
> 
> 
> +config STACK_SIZE
> +    hex "Define max stack size that can be used by U-Boot"
> 
> +    default 0x4000000 if ARCH_VERSAL || ARCH_ZYNQMP
> +    default 0x200000 if MICROBLAZE
> +    default 0x1000000
> 
> 
> 16MB is needed ONLY for EFI loader cases, for other platform that seems huge.
> 
> 
> @Heinrich: do you think you can add this condition CONFIG_EFI_LOADER to avoid issue for other platforms =
> 
> So use 16MB (previously hardcoded in lib/efi_loader/efi_memory.c with add_u_boot_and_runtime() )
> 
>     default 0x1000000 if EFI_LOADER
> 
> 
> and so force the other platforms to define the CONFIG_STACK_SIZE (now used in LMB) with an adequate value ?
> 
> 
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Kconfig b/Kconfig
>> index 1f5b0f1972d..c087a420a24 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -578,6 +578,7 @@ config STACK_SIZE
>>       hex "Define max stack size that can be used by U-Boot"
>>       default 0x4000000 if ARCH_VERSAL_NET || ARCH_VERSAL || ARCH_ZYNQMP
>>       default 0x200000 if MICROBLAZE
>> +    default 0x4000 if ARCH_STM32
>>       default 0x1000000
>>       help
>>         Define Max stack size that can be used by U-Boot. This value is used
> 
> 
> Anyway for this STM32 MCU patch:
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/next

Thanks
Patrice
