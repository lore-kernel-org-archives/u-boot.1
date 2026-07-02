Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C0AC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 10:29:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E75284A7A;
	Thu,  2 Jul 2026 12:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="APKw2nCM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C506884A47; Thu,  2 Jul 2026 12:29:17 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9942B84A7B
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 12:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c128cc012b4so65862966b.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 03:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782988155; cv=none;
 d=google.com; s=arc-20260327;
 b=coUI1AscVUUJ0nQfGQGlE2jO4cx+w+vPAvc3uYWCpvJJuRSQcRLER8ihAxec2Xts2d
 +E/mgKQh8gQCAg85NJJQDBzrLC82b2E9ArlPxLWOjfFjG4L3Yrbe7tA9OCpfSpVJYDQX
 gVI0a/mnSX17XHC/15JbaAjGJ6dE/V4U9NnsjlX5W4LUHlZgEzpJwSt1Xgb7AJ4ktGC2
 /uOLtMK5Z8uGrh5s2hAfKhZU2eY47pkTW+znXgRtMdOFuMLNmm23tGiBApYWyMavhta9
 xJ38JIREHz4SjdJRIR6ib69MF3sTUkL9P7S63F4HmVwyeyyH71dWvjwr5QjtWaHrhVEp
 LSfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=A3jc0fkpnwTGbIE26eFpaKLc3ji4QnyugVRcGnGeOw8=;
 fh=eFunv4SBTTv+W1b+Uu6EOoqR9yjB/cukjjxT64U3E1A=;
 b=ApbWZJ5nUnHBUf1DRbQ6AlTCuEEHb5e5kBBJKLst5zD5FRCP438x1ZK12H+Fq/eH2t
 Kef8RwsNXQ3SUtbtjdYD2Na4NFnPFj7aIv7ywdJgXY6TjGUFSU7qakh+tCEOlphTeFFC
 AF33h1bAkvoLlks4V9ThBED62UpVo5XBkK07yL5a6n09E1IozLowiDtbaNyS2bVrcbRu
 DTyT3T+zRoDN3cm6b0LtIQ6EfL/qinAhp8bssvBMu2nWbZsXRCiyXZeYTS14zjr/7ymL
 +HvAEbJcL7vhBdivndnbYPl2TV3cMk8jM2OcduyJhVjC07luYZ8XIGkb2sYG16C7Xi+u
 h4wg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782988155; x=1783592955; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A3jc0fkpnwTGbIE26eFpaKLc3ji4QnyugVRcGnGeOw8=;
 b=APKw2nCMRpnoEPJfPbPFLWNFM1BDtgqK0O3QwLpYWzuuuYWfxBCp8rsw5d3w5Q3Ybm
 EPNUkSgOpvQKDoJTWHQGtDHcuNB37HjZgXWBc/3HlDbuu8plKCu/CWsqcYJL3bqmGAm6
 OemBqYkcCB8QaBtyMDwQOjNiS/D8kH1un7vQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782988155; x=1783592955;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A3jc0fkpnwTGbIE26eFpaKLc3ji4QnyugVRcGnGeOw8=;
 b=spgUwLeNNO4QbkiIqH4H126xww1msuYY6nkOtYeE5maRvO2mcZl4zW3pFuqFusDvJG
 3YqPGd9pTclnwzrcfzeMa/Ox52tkT1vGl482iRRs5W60Td+TfEdIZk09jj+u4aL3vlxy
 6gL75mcvidf8lb8ohDd5GeSQVieBxTX0IcIiJHHq+/mVv87ygpe/ZrkBUlhlo5nZDW6u
 xCa6gQcT2dwEiEn/gi5EhLLNmngjYrnzmMSsPiPWclG4zTF3sPa3gATHaO5YKRvWnZ8N
 gVo9060ZhZ0Xn8uticS6XDkkkWKZAaAAfFQuZXZ5IJtc+DyDqLY+ZvBbSL6iIzkh/ERP
 /woQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxVvF6r1NqNvfZoifKvB1DlP1Vs9wQzxN/osS00pf0rtI0CaPNF7CLMbn8mxa6eqvBLJ9wGbE=@lists.denx.de
X-Gm-Message-State: AOJu0YxdRNm2DkxNsXsMOKHCkrf4Ry+A2zcxHkNIzSwGR8WC9H9pCULC
 dDpgky+PEAcpZuNqvnMhsb83I+N+dQ+CYwJTODbCN9t1NRwL4RdEvQ9qpQqqYHYGBYzCsP2Wwm+
 9oSqx5rtPa2kCO64vW/CPhd0P0sWefrlLwnj2g3ww
X-Gm-Gg: AfdE7ckjKipGZdLXpUhsGzvEap3+BgJZ/sbDy/mdZqgGmRa1m4pz2ktOhpGUcYD/+H3
 MKwbvxpoYP1Af2+tWyfbsaf7KdiNX4Ebqd4XJBw5XIlWFTGuCay/6nS+pxQ0hK9O4W5wIOnbcWl
 /Qf6xxhi9vc6g65IFu9EpogqYPIVZeYHEQf2SgT0biOaMmhMLjrbWGW1d06I21ZEojLSdfxKXCk
 bp8FhS9QbbDzXYtqve3VelHaSV5qkYVmQDHZaKozMMzcSxkBtqCghjaPamJtKAncBs3zdkobg==
X-Received: by 2002:a17:906:bf49:b0:c12:a169:989e with SMTP id
 a640c23a62f3a-c12a169994dmr259564266b.19.1782988154941; Thu, 02 Jul 2026
 03:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-17-me@ziyao.cc>
In-Reply-To: <20260701111808.870705-17-me@ziyao.cc>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 11:29:02 +0100
X-Gm-Features: AVVi8CdQVFapbgVM2idJVhDtUJX4GBLA4ZXXKhv8pCpPLD8TfK6_RoXy__BPiE4
Message-ID: <CAFLszTghOmstTTDUaNBd1RaYj9snof1TqyHgDrGGRo+ot8GQPg@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] efi: LoongArch: Implement everything
To: me@ziyao.cc
Cc: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Yao,

On 2026-07-01T11:17:53, Yao Zi <me@ziyao.cc> wrote:
> efi: LoongArch: Implement everything
>
> Implement crt, reloc, linker scripts, wire things up in
> Makefiles and Kconfig.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
>
> arch/loongarch/config.mk                 |   4 +
>  arch/loongarch/lib/Makefile              |  12 ++
>  arch/loongarch/lib/crt0_loongarch_efi.S  | 182 +++++++++++++++++++++++++=
++++
>  arch/loongarch/lib/elf_loongarch_efi.lds |  76 +++++++++++++
>  arch/loongarch/lib/reloc_loongarch_efi.c | 107 ++++++++++++++++++
>  lib/efi_loader/Kconfig                   |   2 +-
>  lib/efi_loader/efi_helper.c              |   3 +
>  lib/efi_loader/efi_image_loader.c        |  26 +++++
>  8 files changed, 411 insertions(+), 1 deletion(-)

>     efi: LoongArch: Implement everything
>
>     Implement crt, reloc, linker scripts, wire things up in
>     Makefiles and Kconfig.

The subject and body do not really say what this patch does. It
also silently adds handling for a new PE relocation type
(IMAGE_REL_BASED_LOONGARCH64_MARK_LA) in the shared EFI loader,
which is not mentioned. Please expand to describe the LoongArch EFI
application entry sequence, the .reloc stub, the MARK_LA relocation
format being decoded, and why it is needed.

> diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image=
_loader.c
> @@ -230,6 +232,30 @@ static efi_status_t efi_loader_relocate(const IMAGE_=
BASE_RELOCATION *rel,
> +#elif defined(__loongarch__) && __loongarch_grlen =3D=3D 64
> +                     case IMAGE_REL_BASED_LOONGARCH64_MARK_LA:

This is a non-trivial change to shared code and would be much
easier to review as its own patch, with a commit message explaining
the four-instruction pcalau12i/addi/lu32i/lu52i sequence being
patched and citing the PE-COFF spec. Please split it out.

> diff --git a/arch/loongarch/lib/crt0_loongarch_efi.S b/arch/loongarch/lib=
/crt0_loongarch_efi.S
> @@ -0,0 +1,182 @@
> + * Copright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>

Typo - Copright -> Copyright (the RISC-V file this was cloned from
has the same typo, but please don't propagate it).

> diff --git a/arch/loongarch/lib/crt0_loongarch_efi.S b/arch/loongarch/lib=
/crt0_loongarch_efi.S
> @@ -0,0 +1,182 @@
> +     bl              _relocate

...
> +     jr                      ra
> +     .end      _start

The whitespace here (mixed tabs and multiple spaces after the
mnemonic) is inconsistent with the rest of the file - please tidy.

> diff --git a/arch/loongarch/lib/reloc_loongarch_efi.c b/arch/loongarch/li=
b/reloc_loongarch_efi.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* reloc_loongarch.c - position independent ELF shared object relocator
> +   Copyright (C) 2018 Alexander Graf <agraf@suse.de>

...
> +    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND

The SPDX tag says GPL-2.0+ but the pasted licence block is
BSD-2-Clause from the RISC-V/ARM copies. Please either drop the BSD
text (relying on SPDX) or reconcile the two =E2=80=94 as-is the file is
self-contradictory. Also the filename in the first line still reads
reloc_loongarch.c.

> diff --git a/arch/loongarch/lib/reloc_loongarch_efi.c b/arch/loongarch/li=
b/reloc_loongarch_efi.c
> @@ -0,0 +1,107 @@
> +             case DT_PLTGOT:
> +                     addr =3D (unsigned long *)
> +                             ((unsigned long)dyn[i].d_un.d_ptr
> +                                     + ldbase);
> +                     break;

The value written to addr here is never read before being
overwritten in the loop below. Dead code inherited from the RISC-V
copy - please drop the DT_PLTGOT case.

> diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
> @@ -12,3 +12,15 @@ ifeq ($(CONFIG_$(SPL_)SYSRESET),)
> +extra-$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE) +=3D $(EFI_CRT0) $(EFI_RELOC)
> +extra-$(CONFIG_CMD_BOOTEFI_SELFTEST) +=3D $(EFI_CRT0) $(EFI_RELOC)
> +extra-$(CONFIG_EFI) +=3D $(EFI_CRT0) $(EFI_RELOC)

Have you built and run the EFI selftest and the hello app on
qemu-loongarch64? The cover letter mentions efistub kernel and grub
but not these. If not, please drop the two lines that pull them in
until they have been exercised, or note in the commit message that
they build but are untested.

Regards,
Simon
