Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AEEC27C77
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 14:36:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EE27886E9;
	Tue, 11 Jun 2024 16:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WBomCOyk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A11DB886EE; Tue, 11 Jun 2024 16:36:44 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B41886E9
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 16:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f6fada63a6so22267365ad.3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718116601; x=1718721401; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMTYg7Uakwy1v2akFfpo4DHco0WjKCq6EIUrPd1AoOM=;
 b=WBomCOykdRLJiyVGmkvRunh7dIP7UamgQ8TEv0gs5OXnTVit8O6EaxgPjDj+ZY+K4v
 /Jd84FgqXBJUqeJZhA7944g4mKDqxHaXvBJQwZPR+IaHkG0npS4g3NsS46fCs7XeEiEa
 odCsjOdjXNGFEYGZOHHF6h8zSpfFXOIWZDT4Qtc4Eoc3UgpSjZZ7alD1GGfRsV9yzHiQ
 S1BFPzvBEMAU7YQg2A1GgexUfEU8ztAuAgEsoc7FmrjCvdJ5qkY4xrwjH2bx7B5OcsEb
 9rnpIMJHzsNSz+VRcfmEaNZ72sfy85ppdmmSUnAYV+C4CxK8hVuU1QiA0iaYhYdT7id6
 K7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718116601; x=1718721401;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XMTYg7Uakwy1v2akFfpo4DHco0WjKCq6EIUrPd1AoOM=;
 b=SqBVsej7qI3N9oOpTx4GkAzAZ51BRIBsJD7PmDcy8sugkTmauuswb/99yU+rESPPga
 kvdzTcbd/rc0HqON3zmDJlsmszMevXaYiV707AqPVEObOyPkQJ5R9zBxI7I3ljfQULfX
 Ew0wxMqxxxGkDRdr1wsPXavmAazKDx/1zwaF2RFDuwp2AemktKw77w3QSHnsDw676Gsf
 LoyQCu1nTr7uThWioa3+hHTYrmt5qCJsqmMufqb1n/UMEGgdcykC0jW8w7vUxveopa9c
 yACSQ7ki90bzd6PIDZrR4hefw8VI+nPbQiz0EnlBnO9IOCLS2acbWmOcEaVGFRXoX4ll
 JIlQ==
X-Gm-Message-State: AOJu0YxeOmUx7CBlW+M910Qew5Fzxc3M+aL02pqiy3CiIRv55BDSt3YX
 b50a7HzuHW44I1x8RAKumKNFGAd27Xir3ULXxsdY+e4gKxEwV9t1Qo/XSrY77Nf+0/ngxAng1nA
 BoHa3Fk6sSI0CT4MjBbxH7SHJIKmG5LyuD5R0Nw==
X-Google-Smtp-Source: AGHT+IH/xk+vnzxVcwG0BKhglYSuIQucN8eHZp7EFO6hwDPLjxdPhAiJ0OY2KxcfXgO1iEI/Noa3rcBGH2fkXC7HEXs=
X-Received: by 2002:a17:903:1c6:b0:1f7:1eb:b983 with SMTP id
 d9443c01a7336-1f701ebbb54mr90342665ad.5.1718116600703; Tue, 11 Jun 2024
 07:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240517-mips-efi-v1-0-79096e3ca3b3@flygoat.com>
 <20240517-mips-efi-v1-3-79096e3ca3b3@flygoat.com>
 <CAC_iWjK+KdrYWWfdVVqzyzUia+b7sddKHPF+ziQFp_Am0CbzQQ@mail.gmail.com>
 <c789596e-d676-4fcd-a25b-4311257a9153@app.fastmail.com>
In-Reply-To: <c789596e-d676-4fcd-a25b-4311257a9153@app.fastmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Jun 2024 17:36:04 +0300
Message-ID: <CAC_iWjLzpru3B0ZLVzbi8z8pK6=v9+pD2PEarcewJVB-LTHwbg@mail.gmail.com>
Subject: Re: [PATCH 3/7] Makefile.lib: Preserve .rodata section for EFI file
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 11 Jun 2024 at 17:07, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B46=E6=9C=8811=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8B=
=E5=8D=882:49=EF=BC=8CIlias Apalodimas=E5=86=99=E9=81=93=EF=BC=9A
> > Hi Jiaxun
> >
> >
> > On Fri, 17 May 2024 at 19:33, Jiaxun Yang <jiaxun.yang@flygoat.com> wro=
te:
> >>
> >> This is required in performing objcopy to MIPS EFI files.
> >>
> >
> > This seems not mips specific. What was missing for your case?
>
> So MIPS EFI file would come with .rodata section. If we don't preserve
> it here, the whole section would be stripped away.
>
> .rodata is always necessary in binary if it's in ELF as it contains
> valid program data.
>
> Other architectures won't generate .rodata section in their ELF file
> so it's harmless.
> Besides GNU-EFI's universal strip commands also have
> -j .rodata argument.

Yea I am not arguing that this is useless or dangerous, I was just
wondering if more architectures need .rodata so we could make the
commit message a bit more generic

Cheers
/Ilias
>
> Thanks
> - Jiaxun
> >
> > Thanks
> > /Ilias
> >> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> >> ---
> >>  scripts/Makefile.lib | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> >> index 62f87517c09c..52aed7a65d47 100644
> >> --- a/scripts/Makefile.lib
> >> +++ b/scripts/Makefile.lib
> >> @@ -469,7 +469,7 @@ $(obj)/%_efi.S: $(obj)/%.efi
> >>
> >>  quiet_cmd_efi_objcopy =3D OBJCOPY $@
> >>  cmd_efi_objcopy =3D $(OBJCOPY) -j .header -j .text -j .sdata -j .data=
 -j \
> >> -               .dynamic -j .dynsym  -j .rel* -j .rela* -j .reloc \
> >> +               .dynamic -j .dynsym  -j .rel* -j .rela* -j .reloc -j .=
rodata \
> >>                 $(if $(EFI_TARGET),$(EFI_TARGET),-O binary) $^ $@
> >>
> >>  $(obj)/%.efi: $(obj)/%_efi.so
> >>
> >> --
> >> 2.34.1
> >>
>
> --
> - Jiaxun
