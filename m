Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3494C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 07:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DCA08841D;
	Wed, 17 Apr 2024 09:45:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="UwS08BEs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81E1D8842B; Wed, 17 Apr 2024 09:45:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 863E4882C4
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 09:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713339909; x=1713944709; i=xypron.glpk@gmx.de;
 bh=gEyRWWixr+SHgKPsBYP6F3HIVvpo2AX8oSaqrvYoigk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=UwS08BEsEScx6oU/13mLzSaZwVTzWM1qLvSjJ9OeZWrO9S5iFmrX3EB7vTS+635s
 PnDSahuPE4sgMHuYrecYqCcVUXpHNnQt2qARFMjuHwycjX7KbRS/y9NKLuSTi+jIh
 t9MoSpvffXN2JOgN5Vj945iwYuNc30qmmvdQQwhxBuwuFSCP3/F8yAjVwBpzAid0s
 roLOVQ4F7Flr6VaoLlYl+NJ3j3g6359XQgiFS0Ke6xtP7pDx35sGB6xiSj6s5CNXQ
 vThIxg6G7yF2Q5fpWkPzDEEGs3LoLl2wZgI7dUEejr38AxZluF20lSUG9yNElvBoW
 gIIRyiwuUCrphn4JtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([62.143.245.32]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2nK-1sa8AB2ebi-00n696; Wed, 17
 Apr 2024 09:45:09 +0200
Message-ID: <24c03e51-90f8-4918-8097-2a6ccd6ebf4e@gmx.de>
Date: Wed, 17 Apr 2024 09:45:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stm32mp: Reserve OPTEE area in EFI memory map
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Cc: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Patrice Chotard
 <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
References: <20240308101230.2595220-1-patrice.chotard@foss.st.com>
 <3512e31e-37db-4e03-b133-1914e29fa7ad@foss.st.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <3512e31e-37db-4e03-b133-1914e29fa7ad@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bhugLlrRkQeT3PjK8NIs5kzseL03riWHWLW/59BSfYixL67metj
 5ZHL/T5HF1os3cH0tnBbA8LS7yfPH6BkTuekEdRHITyZNUyJkAJSduvy7dOD0tnafK7mjb8
 I4oJvzYq8mXHXFpnr3NevAe5weKrIkgzE7XDEiEsX9oJdtI+6nDYb8I/mZj6D/am/V4yfJM
 7DZyQZr/QwEex18IFdlug==
UI-OutboundReport: notjunk:1;M01:P0:YoEKvjLONCI=;vhmGq215kNaebWaqxAPFaxWn7TD
 50lKcpoYrwNVP+HpqftU30SFYErKDMZ8kxyWh+3BepJDqF/84aNwSWo9nZoVMnAwqDYfIkKzP
 xjiPpg8r+zeALD0LeyEPwLnmveylRDr0BhRbPnXnoupN4Tgao3fS3l1GNn88TZfsXOq1QO87y
 cBwgWt5V/ue/YJthcK/4A7qpJO3Hc1tHHajn+CCnEhJuGZIb4ZL5N2JAlJNgtxdzMTp7SCdah
 A4B7ka1RObIhmQTu3Q8jXIqXt7GYF9mJTsnJ4N4uyEm2F+ngTX/Q2tLFp8om/VEAaubTxxyiU
 k9newgYMeQWOCSUCi+QWZkyB07GMSsal1Ec7vx04e97fuYZ8irAfqMcjv87DBmpvpqKTHiLU5
 KzlHCBBYm4gZbrchunKawC1TIJOInNO6mib+lrR/1L5IwCoDgoqUVKrSGH6gsMSf1f9ItiG6E
 7qp65zWfDSEeMfy1QoktSJW8K7iEJd84pYq0UXKDXIeaThSiiWPE8m4IvWrCf/5f0l0V1XS0I
 fblw2StW3xLZJK5oolCMPRTWhV+/QNuotj8Y2QtXFi72wvz1St7nOKxEgwpnOG5/3dpZ3OTcj
 8hGOYUAcDhP34fJ9k1+0lsoP+CChKLPeDATdOtqYhXK5VgwmsByigq6l91rc7QxxYXR3vUVhd
 v64QK1TSjWoCjj6kAXG80+xiD2UwfEd8X5p2FmvAL9iLJSB6tPt5pY+BZfjKP2CRDVRTeQrZ2
 t/JsjiL1TURJA3lCCzVmnU9RRrklo0yeQG8xFs8dB6nOvvT2ELejsEZ4jo/l1K9vhwcoEMyUi
 Bb1vauE8xlYXmNnBaPqc3RY0ZCcoABKr282K3HRzZJH0g=
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

On 17.04.24 09:25, Patrick DELAUNAY wrote:
> Hi,
>
> On 3/8/24 11:12, Patrice Chotard wrote:
>> Since commit 7b78d6438a2b3 ("efi_loader: Reserve unaccessible memory")
>> memory region above ram_top is tagged in EFI memory map as
>> EFI_BOOT_SERVICES_DATA.
>> In case of STM32MP1 platform, above ram_top, there is one reserved-memo=
ry
>> region tagged "no-map" dedicated to OP-TEE (addr=3Dde000000 size=3D2000=
000).
>>
>> Before booting kernel, EFI memory map is first built, the OPTEE region =
is
>> tagged as EFI_BOOT_SERVICES_DATA and when reserving LMB, the tag LMB_NO=
NE
>> is used.
>>
>> Then after, the LMB are completed by boot_fdt_add_mem_rsv_regions()
>> which try to add again the same OPTEE region (addr=3Dde000000 size=3D20=
00000)
>> but now with LMB_NOMAP tag which produces the following error message :
>>
>> "ERROR: reserving fdt memory region failed (addr=3Dde000000 size=3D2000=
000
>> flags=3D4)"
>>
>> To avoid this, OPTEE area shouldn't be used by EFI, so we need to mark
>> it as reserved.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>> =C2=A0 arch/arm/mach-stm32mp/dram_init.c | 12 ++++++++++++
>> =C2=A0 1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/mach-stm32mp/dram_init.c
>> b/arch/arm/mach-stm32mp/dram_init.c
>> index fb1208fc5d5..f67f54f2ae0 100644
>> --- a/arch/arm/mach-stm32mp/dram_init.c
>> +++ b/arch/arm/mach-stm32mp/dram_init.c
>> @@ -7,6 +7,7 @@
>> =C2=A0 #include <common.h>
>> =C2=A0 #include <dm.h>
>> +#include <efi_loader.h>
>> =C2=A0 #include <image.h>
>> =C2=A0 #include <init.h>
>> =C2=A0 #include <lmb.h>
>> @@ -75,3 +76,14 @@ phys_addr_t board_get_usable_ram_top(phys_size_t
>> total_size)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return reg + size;
>> =C2=A0 }
>> +
>> +void efi_add_known_memory(void)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (IS_ENABLED(CONFIG_EFI_LOADER))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Memory over ram_top=
 is reserved to OPTEE.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Declare to EFI only=
 memory area below ram_top
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 efi_add_memory_map(gd->ram_=
base, gd->ram_top - gd->ram_base,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 EFI_CONVENTIONAL_MEMORY);

With this change the EFI memory map passed to the operating system will
not contain any memory above gd->ram_top. Is this really your intent?
Don't you have any memory above 0xe0000000?

Best regards

Heinrich

>> +}
>
>
>
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>
> Thanks
> Patrick
>

