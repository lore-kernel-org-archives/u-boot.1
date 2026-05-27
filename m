Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B889CD5BDE
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 06:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59F01839A8;
	Wed, 27 May 2026 08:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fEIXUuNh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51FE383FB0; Wed, 27 May 2026 08:28:14 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22AA58341A
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 08:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779863288; x=1780468088; i=xypron.glpk@gmx.de;
 bh=8OrT1GswRMjxZ8g6Auh8xmzIFh1Ubp3pLMGgJOnAWxw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=fEIXUuNh/tH0pyr56MzM7ollAzNwckyYovJ2/Th2DenV4/CZjQlD4noxSF43hG0z
 iKxN3yT+PCROwb89KxCgzTCmusejnlk/MXDXfehhdX4otM27hCgIhqCfGmfVQl3uB
 cFjW3N6iAN49NV5QNbbjFZlLeE77UY22ENTsncoXcl4ExVobNocUVi6IJRqGxRZ8o
 jvLJ3S+KtFKBKeX1smW+Xiotc/laRXHCnMuWYt8DQpzrpz+gXtJmBeELxKY/HPVuZ
 1sJxeZTARsKgUNUm0yVkqJrgcDpPDp2MiTaFj+hp4yHJi/BKGDrY2MpHXxolJq+e7
 9SBW10yGrbsO7QkBUg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGi9-1wsLhD2VOd-00Wl57; Wed, 27
 May 2026 08:28:08 +0200
Message-ID: <42140a02-1e2f-4f83-bf4b-5992640f841b@gmx.de>
Date: Wed, 27 May 2026 08:28:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] efi_loader: validate PE-COFF relocation data
To: Simon Glass <sjg@chromium.org>
Cc: Anas Cherni <anas@calif.io>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260518063020.181443-1-xypron.glpk@gmx.de>
 <CAFLszTgQE2srwjB6MaZDPcRF6+9cZBBQ9VuumqqKgnZviJpZXQ@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CAFLszTgQE2srwjB6MaZDPcRF6+9cZBBQ9VuumqqKgnZviJpZXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7D9yhtMoIUnGwodrRQg+xcyesaFdbz2udkwRbHa1J14QAH4IQ/K
 le9gMh/ByUuVyRnp+UA68M8tsJq9HYpevg0anR0hyrEeTMMl6A/+PKyp1Emcsr2FS8k4XpD
 70Tn7IY8wSRidpnU3qzLMFxidYBqF5wJzSS9vgpvvTF97ajnsItXCK8NzNJTsfQS8Q+rqSt
 7/bOeNATRa8t1YoQU90DQ==
UI-OutboundReport: notjunk:1;M01:P0:UUGVolEv0f0=;al+U5lNG1mc2tRzYVf+g4Kn87gi
 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
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

On 5/25/26 17:13, Simon Glass wrote:
> Hi Heinrich,
>=20
> On 2026-05-18T06:30:20, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>> efi_loader: validate PE-COFF relocation data
>>
>> When applying base relocations from a PE-COFF binary all data must
>> be treated as untrusted. Add the following checks to
>> efi_loader_relocate():
>>
>> * Reject relocation blocks that don't start on a 32-bit aligned
>>    address.
>> * Reject relocation blocks whose SizeOfBlock is smaller than the
>>    block header, which would cause an unsigned underflow when computing
>>    the entry count.
>> * A block with SizeOfBlock =3D=3D 0 is invalid and does not mark the en=
d of
>>    the relocation table.
>> * Reject relocation blocks that extend beyond the end of the
>>    relocation section.
>> * Reject individual relocation entries whose target offset, together
>>    with the access width, exceeds the mapped image size, preventing
>>    out-of-bounds writes.
>>
>> Pass virt_size to efi_loader_relocate() from efi_load_pe() to enable
>> [...]
>>
>> lib/efi_loader/efi_image_loader.c | 76 ++++++++++++++++++++++++++++++++=
+------
>>   1 file changed, 65 insertions(+), 11 deletions(-)
>=20
>> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_ima=
ge_loader.c
>> @@ -122,34 +123,86 @@ static efi_status_t efi_loader_relocate(const IMA=
GE_BASE_RELOCATION *rel,
>> +                     /*
>> +                      * This first check covers VirtualAddress + Offse=
t
>> +                      * resulting in an overflow.
>> +                      */
>> +                     if (rel->VirtualAddress > virt_size ||
>> +                         entry_offset > virt_size - rel->VirtualAddres=
s) {
>> +                             log_debug("relocation address out of boun=
ds\n");
>> +                             return EFI_LOAD_ERROR;
>> +                     }
>=20
> The rel->VirtualAddress > virt_size half is invariant for the whole
> block - so it should be out of the while (i--) loop so it runs once
> per block, not per entry. The per-entry overflow check on entry_offset
> stays inside.

Hello Simon,

Thanks for reviewing.

ok

>=20
>> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_ima=
ge_loader.c
>> @@ -122,34 +123,86 @@ static efi_status_t efi_loader_relocate(const IMA=
GE_BASE_RELOCATION *rel,
>>                        case IMAGE_REL_BASED_HIGH:
>> +                             if (sizeof(uint16_t) > virt_size - offset=
) {
>> +                                     log_debug("relocation address out=
 of bounds\n");
>> +                                     return EFI_LOAD_ERROR;
>> +                             }
>>                                *x16 +=3D ((uint32_t)delta) >> 16;
>>                                break;
>>                        case IMAGE_REL_BASED_LOW:
>> +                             if (sizeof(uint16_t) > virt_size - offset=
) {
>> +                                     log_debug("relocation address out=
 of bounds\n");
>> +                                     return EFI_LOAD_ERROR;
>> +                             }
>>                                *x16 +=3D (uint16_t)delta;
>>                                break;
>>                        case IMAGE_REL_BASED_HIGHLOW:
>> +                             if (sizeof(uint32_t) > virt_size - offset=
) {
>> +                                     log_debug("relocation address out=
 of bounds\n");
>> +                                     return EFI_LOAD_ERROR;
>> +                             }
>>                                *x32 +=3D (uint32_t)delta;
>>                                break;
>>                        case IMAGE_REL_BASED_DIR64:
>> +                             if (sizeof(uint64_t) > virt_size - offset=
) {
>> +                                     log_debug("relocation address out=
 of bounds\n");
>> +                                     return EFI_LOAD_ERROR;
>> +                             }
>>                                *x64 +=3D (uint64_t)delta;
>>                                break;
>>   #ifdef __riscv
>>                        case IMAGE_REL_BASED_RISCV_HI20:
>> +                             if (sizeof(uint32_t) > virt_size - offset=
) {
>> +                                     log_debug("relocation address out=
 of bounds\n");
>> +                                     return EFI_LOAD_ERROR;
>> +                             }
>=20
> Five copies of the same check make the switch hard to read. Please set
> a width per case and do the bounds check once, e.g.
>=20
>     size_t width;
>=20
>     switch (type) {
>     case IMAGE_REL_BASED_ABSOLUTE:
>         continue;
>     case IMAGE_REL_BASED_HIGH:
>     case IMAGE_REL_BASED_LOW:
>         width =3D sizeof(uint16_t);
>         break;
>     case IMAGE_REL_BASED_HIGHLOW:
>     case IMAGE_REL_BASED_RISCV_HI20:
>         width =3D sizeof(uint32_t);
>         break;
>     case IMAGE_REL_BASED_DIR64:
>         width =3D sizeof(uint64_t);
>         break;
>     ...
>     }
>     if (width > virt_size - offset) {
>         log_debug("relocation address out of bounds\n");
>         return EFI_LOAD_ERROR;
>     }
 > > Then a second switch (or if-ladder) does the write. That keeps the
> duplication out of the hot path and stops anyone adding a new case
> without the bounds check.

This neither makes the code easier to read nor the code faster nor the=20
resulting binary image smaller.

>=20
>> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_ima=
ge_loader.c
>> @@ -122,34 +123,86 @@ static efi_status_t efi_loader_relocate(const IMA=
GE_BASE_RELOCATION *rel,
>> -     while (rel + 1 < end && rel->SizeOfBlock) {
>> +     while (rel + 1 < end) {
>=20
> Since this plugs a security hole driven by malformed input, please add
> a py (or an lib/efi_selftest case) that feeds at least one rejected
> shape - short SizeOfBlock, unaligned block, out-of-bounds
> VirtualAddress - through efi_load_pe() and confirms EFI_LOAD_ERROR.
> Without coverage there's nothing to stop a regression.
>=20
>> @@ -163,7 +216,7 @@ static efi_status_t efi_loader_relocate(const IMAGE=
_BASE_RELOCATION *rel,
>>   #endif
>>                        default:
>> -                             log_err("Unknown Relocation off %x type %=
x\n",
>> +                             log_err("Unknown Relocation off %lx type =
%x\n",
>>                                        offset, type);
>=20
> Just to check - every other new diagnostic here uses log_debug(), but
> the default arm keeps log_err(). I'm fine with that split, but the
> other new "out of bounds" messages probably want log_err() too: a
> refused image is something the user will want to see without enabling
> debug logs, otherwise they just see the load fail with no clue why.

We originally introduced log_err() here when we were not sure if U-Boot=20
covered all relocation types.

efi_loader_relocate() is invoked by EFI applications like GRUB. It=20
probably would be better to convert the log_err() to log_debug() as we=20
should not output anything inside an EFI application.

But this is beyond the scope of this patch.

Best regards

Heinrich
