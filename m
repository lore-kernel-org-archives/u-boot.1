Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5755ECD4F52
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 08:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D448B83FEE;
	Mon, 18 May 2026 10:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XQs7tGMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B60AC84119; Mon, 18 May 2026 10:30:11 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96B2B83EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1779093007; x=1779697807; i=xypron.glpk@gmx.de;
 bh=xtDRQArtf+/FvTK7N2IrkbCMAQN2UwwZXsLIph4JLq0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=XQs7tGMrZGZkFbfaotXBF/ODr6bmviXqEbs88/S4JRBMQQpNl+3vEUuUx+HQjKbl
 Ljd9G4Wztrt3WJlc/Ikg33pN83Im6ioKVyohomaMrZzqXrp2UptlNnryPR6J412Sf
 sftaL3sD5HL1k11W5MH9AWnexjs71VZ4BE3ZNpE0vHIR+hHbYmUqHltnw+GAhEV7d
 7VlsYcjNnzzBniCo7ajO795s0Q6vuE2qMjIdorCHu3N/bJDMmDBYJpKbwh5zRducK
 CXySjxOBp9RyPCAIX7/7s/xhXZpFREvsWRk82IwFDGmPPN3b1tkpIOUq53Lwt2tV0
 P+J08RcLsk+3JsobPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHMZ-1x4r1a0McT-00fPWY; Mon, 18
 May 2026 10:30:07 +0200
Date: Mon, 18 May 2026 10:30:05 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Anas Cherni <anas@calif.io>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] efi_loader: validate PE-COFF relocation data
User-Agent: Thunderbird for Android
In-Reply-To: <CA+J-LAz5dYfDAOovThwQZM9u6Yk+0m6m_pAE_UH=U6EMBXw5bw@mail.gmail.com>
References: <20260518063020.181443-1-xypron.glpk@gmx.de>
 <CAC_iWjKwyj5jg=R-kJGi0i26hDrLAmjc+U7ZDVq7r2jLuBbwdA@mail.gmail.com>
 <CA+J-LAz5dYfDAOovThwQZM9u6Yk+0m6m_pAE_UH=U6EMBXw5bw@mail.gmail.com>
Message-ID: <D601FEF7-7223-4B7E-8315-EF020C1B259C@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d7BaIRmX6HynWQ72CaxZOu7kdQAwaYELmJBp22958HsEBjzClFR
 EGYxIyB+IUBqPQiy0s42igxsoQiafo1bOfGCtJcj8Mk3hU2yDr2o3ykhgYS/480B251EuFb
 z6/MUF+A56qH11vKrnYXTurbkXcCI/gEN0iHHGBjWR6tIek3bvoluI/ATO2me1UCIWEeZfy
 rIWQBl5lffCX1dOeItIYg==
UI-OutboundReport: notjunk:1;M01:P0:r+uZMEU/Zic=;0DEKuRPadye/3esmH9MqP08WEar
 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
 ntOoemSrqWEvaEQ==
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

Am 18=2E Mai 2026 10:03:14 MESZ schrieb Anas Cherni <anas@calif=2Eio>:
>Hello,
>
>Could you please change the reporter section to:
>Anthropic Research and Claude, in collaboration with calif=2Eio
>
>Best regards,
>Anas

Reported-by:  needs a name and an email address and you are the person who=
 reported the issue to the U-Boot project=2E=20

Best regards

Heinrich

>
>
>On Mon, May 18, 2026 at 8:40 Ilias Apalodimas <ilias=2Eapalodimas@linaro=
=2Eorg>
>wrote:
>
>> On Mon, 18 May 2026 at 09:30, Heinrich Schuchardt <xypron=2Eglpk@gmx=2E=
de>
>> wrote:
>> >
>> > When applying base relocations from a PE-COFF binary all data must
>> > be treated as untrusted=2E Add the following checks to
>> > efi_loader_relocate():
>> >
>> > * Reject relocation blocks that don't start on a 32-bit aligned
>> >   address=2E
>> > * Reject relocation blocks whose SizeOfBlock is smaller than the
>> >   block header, which would cause an unsigned underflow when computin=
g
>> >   the entry count=2E
>> > * A block with SizeOfBlock =3D=3D 0 is invalid and does not mark the =
end of
>> >   the relocation table=2E
>> > * Reject relocation blocks that extend beyond the end of the
>> >   relocation section=2E
>> > * Reject individual relocation entries whose target offset, together
>> >   with the access width, exceeds the mapped image size, preventing
>> >   out-of-bounds writes=2E
>> >
>> > Pass virt_size to efi_loader_relocate() from efi_load_pe() to enable
>> > the per-entry bounds check=2E
>> >
>> > Reported-by: Anas Cherni <anas@calif=2Eio>
>> > Signed-off-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>> > ---
>>
>> Reviewed-by: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>>
>> >  lib/efi_loader/efi_image_loader=2Ec | 76 ++++++++++++++++++++++++++-=
----
>> >  1 file changed, 65 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/lib/efi_loader/efi_image_loader=2Ec
>> b/lib/efi_loader/efi_image_loader=2Ec
>> > index d002eb0c744=2E=2E0bc66a0f732 100644
>> > --- a/lib/efi_loader/efi_image_loader=2Ec
>> > +++ b/lib/efi_loader/efi_image_loader=2Ec
>> > @@ -111,8 +111,9 @@ void efi_print_image_infos(void *pc)
>> >   * Return:             status code
>> >   */
>> >  static efi_status_t efi_loader_relocate(const IMAGE_BASE_RELOCATION
>> *rel,
>> > -                       unsigned long rel_size, void *efi_reloc,
>> > -                       unsigned long pref_address)
>> > +                                       unsigned long rel_size, void
>> *efi_reloc,
>> > +                                       unsigned long pref_address,
>> > +                                       unsigned long virt_size)
>> >  {
>> >         unsigned long delta =3D (unsigned long)efi_reloc - pref_addre=
ss;
>> >         const IMAGE_BASE_RELOCATION *end;
>> > @@ -122,34 +123,86 @@ static efi_status_t efi_loader_relocate(const
>> IMAGE_BASE_RELOCATION *rel,
>> >                 return EFI_SUCCESS;
>> >
>> >         end =3D (const IMAGE_BASE_RELOCATION *)((const char *)rel +
>> rel_size);
>> > -       while (rel + 1 < end && rel->SizeOfBlock) {
>> > +       while (rel + 1 < end) {
>> >                 const uint16_t *relocs =3D (const uint16_t *)(rel + 1=
);
>> > +
>> > +               /* Each block must start on a 32-bit boundary */
>> > +               if (!IS_ALIGNED((uintptr_t)rel, sizeof(uint32_t))) {
>> > +                       log_debug("Relocation block not 32-bit
>> aligned\n");
>> > +                       return EFI_LOAD_ERROR;
>> > +               }
>> > +               /* Relocation block cannot be shorter than its header=
 */
>> > +               if (rel->SizeOfBlock < sizeof(*rel)) {
>> > +                       log_debug("Relocation block too small: %u\n",
>> > +                               rel->SizeOfBlock);
>> > +                       return EFI_LOAD_ERROR;
>> > +               }
>> > +               /* All relocation entries must be inside the =2Ereloc
>> section */
>> > +               if ((const char *)rel + rel->SizeOfBlock > (const cha=
r
>> *)end) {
>> > +                       log_debug("Relocation block exceeds relocatio=
n
>> data\n");
>> > +                       return EFI_LOAD_ERROR;
>> > +               }
>> >                 i =3D (rel->SizeOfBlock - sizeof(*rel)) / sizeof(uint=
16_t);
>> >                 while (i--) {
>> > -                       uint32_t offset =3D (uint32_t)(*relocs & 0xff=
f) +
>> > -                                         rel->VirtualAddress;
>> > +                       uint32_t entry_offset =3D *relocs & 0xfff;
>> > +                       unsigned long offset;
>> >                         int type =3D *relocs >> EFI_PAGE_SHIFT;
>> > -                       uint64_t *x64 =3D efi_reloc + offset;
>> > -                       uint32_t *x32 =3D efi_reloc + offset;
>> > -                       uint16_t *x16 =3D efi_reloc + offset;
>> > +                       uint64_t *x64;
>> > +                       uint32_t *x32;
>> > +                       uint16_t *x16;
>> > +
>> > +                       /*
>> > +                        * This first check covers VirtualAddress +
>> Offset
>> > +                        * resulting in an overflow=2E
>> > +                        */
>> > +                       if (rel->VirtualAddress > virt_size ||
>> > +                           entry_offset > virt_size -
>> rel->VirtualAddress) {
>> > +                               log_debug("relocation address out of
>> bounds\n");
>> > +                               return EFI_LOAD_ERROR;
>> > +                       }
>> > +
>> > +                       offset =3D rel->VirtualAddress + entry_offset=
;
>> > +                       x64 =3D efi_reloc + offset;
>> > +                       x32 =3D efi_reloc + offset;
>> > +                       x16 =3D efi_reloc + offset;
>> >
>> >                         switch (type) {
>> >                         case IMAGE_REL_BASED_ABSOLUTE:
>> >                                 break;
>> >                         case IMAGE_REL_BASED_HIGH:
>> > +                               if (sizeof(uint16_t) > virt_size -
>> offset) {
>> > +                                       log_debug("relocation address
>> out of bounds\n");
>> > +                                       return EFI_LOAD_ERROR;
>> > +                               }
>> >                                 *x16 +=3D ((uint32_t)delta) >> 16;
>> >                                 break;
>> >                         case IMAGE_REL_BASED_LOW:
>> > +                               if (sizeof(uint16_t) > virt_size -
>> offset) {
>> > +                                       log_debug("relocation address
>> out of bounds\n");
>> > +                                       return EFI_LOAD_ERROR;
>> > +                               }
>> >                                 *x16 +=3D (uint16_t)delta;
>> >                                 break;
>> >                         case IMAGE_REL_BASED_HIGHLOW:
>> > +                               if (sizeof(uint32_t) > virt_size -
>> offset) {
>> > +                                       log_debug("relocation address
>> out of bounds\n");
>> > +                                       return EFI_LOAD_ERROR;
>> > +                               }
>> >                                 *x32 +=3D (uint32_t)delta;
>> >                                 break;
>> >                         case IMAGE_REL_BASED_DIR64:
>> > +                               if (sizeof(uint64_t) > virt_size -
>> offset) {
>> > +                                       log_debug("relocation address
>> out of bounds\n");
>> > +                                       return EFI_LOAD_ERROR;
>> > +                               }
>> >                                 *x64 +=3D (uint64_t)delta;
>> >                                 break;
>> >  #ifdef __riscv
>> >                         case IMAGE_REL_BASED_RISCV_HI20:
>> > +                               if (sizeof(uint32_t) > virt_size -
>> offset) {
>> > +                                       log_debug("relocation address
>> out of bounds\n");
>> > +                                       return EFI_LOAD_ERROR;
>> > +                               }
>> >                                 *x32 =3D ((*x32 & 0xfffff000) +
>> (uint32_t)delta) |
>> >                                         (*x32 & 0x00000fff);
>> >                                 break;
>> > @@ -163,7 +216,7 @@ static efi_status_t efi_loader_relocate(const
>> IMAGE_BASE_RELOCATION *rel,
>> >                                 break;
>> >  #endif
>> >                         default:
>> > -                               log_err("Unknown Relocation off %x ty=
pe
>> %x\n",
>> > +                               log_err("Unknown Relocation off %lx t=
ype
>> %x\n",
>> >                                         offset, type);
>> >                                 return EFI_LOAD_ERROR;
>> >                         }
>> > @@ -970,8 +1023,9 @@ efi_status_t efi_load_pe(struct
>> efi_loaded_image_obj *handle,
>> >
>> >         /* Run through relocations */
>> >         if (efi_loader_relocate(rel, rel_size, efi_reloc,
>> > -                               (unsigned long)image_base) !=3D
>> EFI_SUCCESS) {
>> > -               efi_free_pages((uintptr_t) efi_reloc,
>> > +                               (unsigned long)image_base,
>> > +                               virt_size) !=3D EFI_SUCCESS) {
>> > +               efi_free_pages((uintptr_t)efi_reloc,
>> >                                (virt_size + EFI_PAGE_MASK) >>
>> EFI_PAGE_SHIFT);
>> >                 ret =3D EFI_LOAD_ERROR;
>> >                 goto err;
>> > --
>> > 2=2E53=2E0
>> >
>>

