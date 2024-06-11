Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DF7C27C5E
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 14:28:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9236F886DD;
	Tue, 11 Jun 2024 16:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="EENFtxdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D19886DE; Tue, 11 Jun 2024 16:28:14 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9F3188652
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718116087; x=1718720887; i=xypron.glpk@gmx.de;
 bh=aryvaET/OO+eYrEppsZMDliHpQG6WLdux87uAz3HH0s=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=EENFtxdXD7+/18SSDuZowob+z2DYDu5esb1AuRfOvYwAlA0G7UnHohstDBYa+swl
 mFHW0dEqT5Aap7yXXk8q7WdW0urYMWzb/HeS/4Vk6W1XuT8lkA1voWno/pJYXfDiZ
 KneuWgGqlucu9NM6IyB0tKStIGNe25/2EbtPandsVHUmAHr/yPV56Ulpw/5tcu8+m
 nips7HWh1bA4rd/IFaKHhYJavyuX1dCm/YbsTcYowz9cwCagLBO6hiwxy/DK4fsBg
 mQO0Qfz1zeuNHxCXIKand0yl4g1Y+FohEdQHiPBIn8jMVhGl2LtPWfGN9SlaULRmy
 D9VN1JUHK1iUtyS3QQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.126] ([109.42.176.212]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel3n-1srkH42P4v-00qhtA; Tue, 11
 Jun 2024 16:28:07 +0200
Message-ID: <85599d13-b610-4735-8461-6793a45eb4ec@gmx.de>
Date: Tue, 11 Jun 2024 16:28:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] Makefile.lib: Preserve .rodata section for EFI file
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <20240517-mips-efi-v1-3-79096e3ca3b3@flygoat.com>
 <CAC_iWjK+KdrYWWfdVVqzyzUia+b7sddKHPF+ziQFp_Am0CbzQQ@mail.gmail.com>
 <c789596e-d676-4fcd-a25b-4311257a9153@app.fastmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <c789596e-d676-4fcd-a25b-4311257a9153@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cfOevitTxUuJ72FJ9xQbHQdrYS/kvrngDGrWQ56zHbLq1R3cLXn
 yEIY7ElWs73A1+DnaJcc5dbJLHR/MiLgEwf5i0P1nnhfhJGOfwz7+ls+sDkZZA97ytJ+mEp
 LX+AS92djSLShnGhkLhtfKB0YVBirm8hMWj/KOhrt+MrnbGipp+imbZ/Htgv/SOm+e0B4XE
 +IQbqHAT22aqSy7EHgAlQ==
UI-OutboundReport: notjunk:1;M01:P0:9shzPB25glc=;fGsF6HyiVymc13iFg1GGFIBDaho
 R8LVFUYRYCdc9ctwgoNzQY098Qy2E1aVP7NERqsv8m1xRj30pKPPLcPOB3yxY0omBjqW9V8wL
 sw3yjGwGYzJLQ+OB6o7HA+8HmcPMw1bBfpXUIGvpIGmI0rj3gEayr1JO2RLdpHkhVHWiDFnm7
 SuqHnmcxoKYtdR9fhUWhD8kAevLEU16csR3DijdsV0RZRrd9oMcSiqN6XHiSAWvdPqmR1BdeW
 DksFMdkSlBD02pVeknD1MiqwI1m/o5Y60DQpL1P2fcuU7wo6n2VGoA+WM+e7CM/5ztxQWBsBw
 pxOCQcNuZu1M3rEVbQ16glc6xy4K7Ae67dJwd7rTt3q/m/NdLnkQrHYrzw/WdJttSKPgLYJn7
 d7MrQNXfr8pu/4d83VDZxaqX0CwQ7CZ5Klf34xuGJfvKmUyh+Q6bZlnExfFqzPxoS5XhkWSDf
 9rln6C0ucDMQBjSMe/G+o8F8F27I36z4F1YGwWDRS3/nZj/BmWkxJWyBvrFuR/cjzrWYeHaDm
 V9Ktf8DAYHJsF5kX784owPd+Hgnk2vuId+lXfidCBYro/faE+kcA/4XxwGMAqNRJ7LaH9196k
 nblsYE/vPqqj85wcXE0S5Euy8CvfPzV+Mgxk8exMv7B6KqdE5PjDSwqA1iGBUcQsnHs1DfRrA
 ba4g2ICbwjbvhq6y6P4E0q3wiQ7BPeOGEVsfwWfv1JMbToRsvnuoFmKamGfQ81sWMVCP2ItSe
 B8RNGtHwUgI6xtKjPjizR6lRwtzhHM3WlW4C/DUxTHvAyft+bJRXkU17VD+l29dG6GtgAjF0+
 D45LPoEKuhpyoDZPCZr/jESdrhdrmviTqfJFRGSBGG0wk=
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

On 11.06.24 16:06, Jiaxun Yang wrote:
>
>
> =E5=9C=A82024=E5=B9=B46=E6=9C=8811=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=
=E5=8D=882:49=EF=BC=8CIlias Apalodimas=E5=86=99=E9=81=93=EF=BC=9A
>> Hi Jiaxun
>>
>>
>> On Fri, 17 May 2024 at 19:33, Jiaxun Yang <jiaxun.yang@flygoat.com> wro=
te:
>>>
>>> This is required in performing objcopy to MIPS EFI files.
>>>
>>
>> This seems not mips specific. What was missing for your case?
>
> So MIPS EFI file would come with .rodata section. If we don't preserve
> it here, the whole section would be stripped away.
>
> .rodata is always necessary in binary if it's in ELF as it contains
> valid program data.
>
> Other architectures won't generate .rodata section in their ELF file
> so it's harmless. Besides GNU-EFI's universal strip commands also have
> -j .rodata argument.
>
> Thanks
> - Jiaxun
>>
>> Thanks
>> /Ilias
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>>   scripts/Makefile.lib | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
>>> index 62f87517c09c..52aed7a65d47 100644
>>> --- a/scripts/Makefile.lib
>>> +++ b/scripts/Makefile.lib
>>> @@ -469,7 +469,7 @@ $(obj)/%_efi.S: $(obj)/%.efi
>>>
>>>   quiet_cmd_efi_objcopy =3D OBJCOPY $@
>>>   cmd_efi_objcopy =3D $(OBJCOPY) -j .header -j .text -j .sdata -j .dat=
a -j \
>>> -               .dynamic -j .dynsym  -j .rel* -j .rela* -j .reloc \
>>> +               .dynamic -j .dynsym  -j .rel* -j .rela* -j .reloc -j .=
rodata \
>>>                  $(if $(EFI_TARGET),$(EFI_TARGET),-O binary) $^ $@
>>>
>>>   $(obj)/%.efi: $(obj)/%_efi.so
>>>
>>> --
>>> 2.34.1
>>>
>

We have:

arch/arm/lib/elf_aarch64_efi.lds:26:            *(.rodata*)
arch/arm/lib/elf_arm_efi.lds:26:                *(.rodata*)
arch/riscv/lib/elf_riscv32_efi.lds:26:          *(.rodata*)
arch/riscv/lib/elf_riscv64_efi.lds:26:          *(.rodata*)
arch/x86/lib/elf_ia32_efi.lds:35:               *(.rodata*)
arch/x86/lib/elf_x86_64_efi.lds:37:             *(.rodata*)

Not considering .rodata in objcopy looks inconsistent.

As we use -fdata-sections wouldn't we expect a .rodata* section per
function with constants on LoongArch? Shouldn't we use:

+ .dynamic -j .dynsym  -j .rel* -j .rela* -j .reloc -j .rodata* \

Best regards

Heinrich



