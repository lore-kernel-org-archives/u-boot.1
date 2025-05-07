Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F27FC3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 21:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E631820EB;
	Wed,  7 May 2025 23:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="KZCSoO2f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 088DC8210D; Wed,  7 May 2025 23:18:34 +0200 (CEST)
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch
 [109.224.244.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3BA081FAB
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 23:18:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746652710; x=1746911910;
 bh=/8zF6E/rOVE39cjBhhxxcXnEypP6AU/NhVx7MJQYuJ0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=KZCSoO2fzfxnw+TSgX/y6Rn/DRS4b5ZLkRvZ47vBExyMC2GY2kY4uAS3d7on1koJ6
 gfIR2CBwd/ha1cI6e9tPlSecrhF8HCQKC/iPO97GPxwZ49pOj7y1C02ThoD6zsTo9u
 KKp6WmP1Nm3ttoIuv5JVSiTLKPwZatNdQglf0cV3dJFubLnhbmZ1vH53ar1AVcJde0
 P4nPp9KVyAMAjsKju1hWL/QzKtyzCcS6e2P+uxR24y1kiRZDngc2UghWWkWRS6VDuz
 vibwwyGEWjv3WuYzHoHOlUEcmRobVFbB2dArHpK+kew6d3weu7xJbHk9mhbMfAleqn
 D6Xw/IGuFKECg==
Date: Wed, 07 May 2025 21:18:25 +0000
To: Tom Rini <trini@konsulko.com>, patrick.delaunay@foss.st.com,
 patrice.chotard@foss.st.com
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] arm: cpu: armv7m: add required .type name,
 %function directive
Message-ID: <1af2e04f-3d73-471a-8ba3-2f78fcc96ea4@krotti42.com>
In-Reply-To: <a138ecb5-680e-4272-8211-dbb354745247@krotti42.com>
References: <20250507060739.326096-1-johannes@krotti42.com>
 <20250507060739.326096-2-johannes@krotti42.com>
 <20250507165533.GO5430@bill-the-cat>
 <6d3af68a-15a7-4dd4-8095-ee2ac6037c0e@krotti42.com>
 <a138ecb5-680e-4272-8211-dbb354745247@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: fa86c190644cd944e5b9f49b07ea324b6fc7b78b
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hello Tom, Patrick and Patrice!

For the ARMv7-M architecture depended code and for the boards as
example from STMicroelectronics:

There are a few missing but 'maybe' required initialization steps
which I haven't seen yet in the U-Boot code:

1) AHB (Advanced High-performance Bus)

According the TRM from the ARMv7-M architecture, this peripheral
bus should be enabled in the startup code.

2) ITCM/DTCM Tightly Coupled Memory (Instruction/Data)

Some ARMv7-M includes this memory type and should also be enabled
in the startup code.

3) Low-level init (currently not implemented)

STMicroelectronis SoC's need a low-level initialization for
the AXI-SRAM. To use this RAM type, there must be a few steps
done into the PWR (power) register from the SoC. If not
the SoC runs in limited mode (Run*) and write/reads to this
RAM might be corrupted. If U-Boot use this RAM for itself
then this step should be done before any stack usage.

I hope Patrick or Patrice can clarify that. Could also be possible
that I have misunderstood the ST TRM's.

4) Doesn't U-Boot use an ICache and DCache for itself?

Invalidation also missing in the startup code. I have seen the
ICache/DCache will disabled before Linux, but currently I
didn't seen if U-Boot use also the caches.

On 5/7/25 21:07, Johannes Krottmayer wrote:
> Hi Tom!
>=20
> Okay, STT_FUNC is an alternative spelling for %function, didn't
> know that before. So my question is deprecated.
>=20
> Sorry, for wasting your time.
>=20
> BTW, I will add the required macros and also try to add the VFP
> support. But I think it's better in two different patches. First
> patch with the ENTRY/ENDPROC macros and later with the VFP patch.
>=20
> On 5/7/25 20:17, Johannes Krottmayer wrote:
>> Hi Tom!
>>
>> Thanks for the quick response!
>>
>> On 5/7/25 18:55, Tom Rini wrote:
>>> On Wed, May 07, 2025 at 06:07:54AM +0000, Johannes Krottmayer wrote:
>>>
>>>> Since GNU binutils version 2.44, assembly functions must include
>>>> the assembler directive .type name, %function. If not a call to
>>>> these functions fails with the error message 'Unknown destination
>>>> type (ARM/Thumb)' and the error message 'dangerous relocation:
>>>> unsupported relocation' at linking.
>>>>
>>>> Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
>>>> Cc: Tom Rini <trini@konsulko.com>
>>>> ---
>>>>     arch/arm/cpu/armv7m/start.S | 1 +
>>>>     1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/arch/arm/cpu/armv7m/start.S b/arch/arm/cpu/armv7m/start.S
>>>> index 0c07f2140c7..c20f01a0aed 100644
>>>> --- a/arch/arm/cpu/armv7m/start.S
>>>> +++ b/arch/arm/cpu/armv7m/start.S
>>>> @@ -12,5 +12,6 @@ reset:
>>>>     =09W(b)=09_main
>>>>
>>>>     .globl=09c_runtime_cpu_setup
>>>> +.type c_runtime_cpu_setup, %function
>>>>     c_runtime_cpu_setup:
>>>>     =09mov=09pc, lr
>>>
>>> Thanks for making the patch. There's an argument that this should use
>>> the ENTRY / ENDPROC macros from <linux/linkage.h> but that also shows
>>> that we're missing commit 5d4cae5fe2ea ("[ARM] VFP: fix section mismatc=
h
>>> error") from the kernel. And so I'm fine with making a TODO to clean
>>> this up later if you don't want to embark on something a bit more
>>> complicated here.
>>>
>>
>> No problem for me to creating my simple patch. It's also not a problem
>> for me to use the required macros (ENTRY, ENDPROC). Use some similar
>> macros on my own projects too.
>>
>> I have searched for your mentioned commit from Linux, and it's okay
>> when I try to add this too in further patches. For the correct
>> initialization from the floating point unit I must look more
>> precisely into the U-Boot and Linux source code.
>>
>> But I have a question according the ENPROC macro:
>>
>> include/linux/linkage.h (from U-Boot):
>> #ifndef ENDPROC
>> #define ENDPROC(name) \
>> =09.type name STT_FUNC ASM_NL \
>> =09END(name)
>> #endif
>>
>> Especially the macro/define STT_FUNC. I have thought STT_FUNC is
>> %function, but haven't found these in the current U-Boot master
>> branch.
>>
>> Simple search with grep on the shell:
>> "
>> jk@workstation:~/Projects/U-Boot/src> grep -R STT_FUNC
>> include/linux/linkage.h:        .type name STT_FUNC ASM_NL \
>> include/elf.h:#define STT_FUNC  2               /* function */
>> jk@workstation:~/Projects/U-Boot/src>
>> "
>>
>> Also tried a much more comfortable search with the elixir.bootlin
>> identifier search. As you can see STT_FUNC is defined only in the
>> ELF header. 'include/linux/linkage.h' doesn't include the ELF
>> header. And I don't know if the value 2 for STT_FUNC is an alternative
>> usage from the .type directive. 'include/linux/linkage.h' includes
>> 'asm/linkage.h'. I'm still a newbie with the U-Boot build process
>> and I think on build the machine dependent header will included
>> (arch/arm/include/linkage.h). Correct me if I'm wrong please.
>> Also there will be elf.h not included.
>>
>> Maybe the STT_FUNC will defined in build process, but shouldn't
>> I find this in a specific Makefile with a simple search with grep?
>>
>> By the I could change STT_FUNC to %function, but I didn't know
>> (not tried yet) if this has other bad effects.
>>
>> Thanks in advance!
>>
>> Kind regards,
>>
>> Johannes
>>
>>
>>
>>
>=20
>=20


