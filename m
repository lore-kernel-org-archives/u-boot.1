Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E54C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 03:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B408080BAA;
	Thu,  6 Mar 2025 04:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JrGR5em9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C1FE80F9E; Thu,  6 Mar 2025 04:47:10 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E359280805
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 04:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso44314266b.2
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 19:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741232827; x=1741837627; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWskwWgieLOB1etg8OFq7Vp5smY6liE4bU9x+pp7QYQ=;
 b=JrGR5em945FWyo791QUy3gQp7ka5/9EwaXJYI9cHezFYfmRwuLPPc4fEOh6mNt4oBT
 6Imj/DFfLrGJbEZjKpowyLseXrNVwAsxgplVpjlnvc/vrntjNAkbPhIWT+0JdGJl62r2
 1bSwL2G6hhqtW6JZSen+rjjcOFVZZfVQ68wEk0udgHg5vJOtZcTWwnvmxevo7RzOCHIR
 Wkrig+/pvbfBv6RE6548ubqjcuhe6Vu4MoNCJ3CYOSgC5O3nVGK4ogOXTxr59wDwoR+Q
 7rnuZteL+30aElaorPP06o576+VPX2lUjwuVg42xEdd3bPaL+knMQ4UpKXYlP+s8dUKo
 6mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741232827; x=1741837627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWskwWgieLOB1etg8OFq7Vp5smY6liE4bU9x+pp7QYQ=;
 b=fK/NgE246ukZB6lj+WsdT/V3JVZS9VBSfA59H8+cZRPRlCrAm+T8/E3zww6W5EXU/r
 BjXYML8UJujkwpMergwa8ki0xuEIsbEAgz0sSZrXGs7jkmW7bsFMiAjwqYrJYtOsnVRs
 oa/HEzkmy34GNQ0FeBEuxhZpeLi0Ac9SF4oVP5CkR+Pea++lY5/k+niYwSJ071rDAmOX
 QC83Xk4U24P+44HXnF+o/r4naKxDQJ+u2xBtbbp/WWXMU86hEYBuGOoKvdV4xFRrVkca
 KZT+CyGGqc4W/sMTedl0XtGH2cK3BolrzNZDprlggYAp5NKab/Dz08j/kvVNof+w3+JL
 cHKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Q/3qL2Fl+rwDQQn6cY6cJb92aeyNBd9AWTDeW6J0TeKKJTBcUAuDRzccXQ27mnfTdu1U+38=@lists.denx.de
X-Gm-Message-State: AOJu0YyZTR/o9ZzXEessadb8Z1ZyPRlae0a1wGUiQ1TQ0M9tGvr7Vv99
 FKGQ6w80DkJ3ENeZCOOBDfDtiKvayamJ3PKvU7K/PuTKZA22ckuDivMZgZgyNmq7UUwa5atgtVk
 ccNQNOYckr1WGs+fA1hcNC7vsRxM=
X-Gm-Gg: ASbGnctvRXyeirpgu7WkJ+fByfeewymMWEGK8m3D6MDvbLHpd5yHiJmN8jJgwok9nRF
 hxPBIA+fxfpmve8ejQUD39RRglncq8HvkrwJHFtlQva991s/l5jVgkpBY6zmDa75u67aIEw03uK
 E7Q9F/9AvLBmqgNFrfK5hxrL02Xlf5dhuS/LATmpclWMV/DloX5cwa2HWS7v4=
X-Google-Smtp-Source: AGHT+IEChmK8D7qtWDkaEzhZn0H/o3tRsz8hqwRtZQRvy0ZHKwagRoltn2pOy3Hr6kQfpl9Xg/52lPk63rauMXetO34=
X-Received: by 2002:a17:907:9816:b0:abf:7776:7e29 with SMTP id
 a640c23a62f3a-ac20e4296c4mr531922466b.53.1741232827008; Wed, 05 Mar 2025
 19:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20250224055524.1334929-1-CFSworks@gmail.com>
In-Reply-To: <20250224055524.1334929-1-CFSworks@gmail.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 5 Mar 2025 19:46:56 -0800
X-Gm-Features: AQ5f1JrE3QerqjmD2OiBP237hRX77cFJJOhZ3RlkDvACMSxHP3SmzIbeu4fui6E
Message-ID: <CAH5Ym4isqLibOv97=9zgYFx-fok-sAa3QetfRgyrQmDQ4MHgmQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] Various toolchain compatibility fixes/improvements
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
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

On Sun, Feb 23, 2025 at 9:55=E2=80=AFPM Sam Edwards <cfsworks@gmail.com> wr=
ote:
>
> Long time no see, U-Boot folks!
>
> This patchset consists of various bug fixes and correctness improvements =
that
> I discovered while attempting to add first-class LLVM support to the buil=
d
> system. These patches are NOT related to LLVM support directly; rather, t=
hey
> address existing issues that should be resolved regardless of future chan=
ges.
> For the most part, the patches are mutually independent and can be review=
ed and
> applied separately. If any patch is not suitable for merging now, feel fr=
ee to
> skip it: I will incorporate feedback and revisit those changes as part of=
 the
> upcoming LLVM support patchset. I'd like this patchset to be evaluated on=
 its
> own merits, based on the current state of the code, without consideration=
 for
> future LLVM support.
>
> Note that the issues addressed in this patchset do not occur when U-Boot =
is
> built using the GCC/GNU toolchain. These bugs seem to be specific to buil=
ds
> using other toolchains, like LLVM, and do not appear to affect users rely=
ing on
> GCC/GNU. Therefore, I see no need to rush these changes into the stable b=
ranch.
>
> Again, these patches are mostly independent/reorderable...
> ...except that: "arm: Add aligned-memory aliases to eabi_compat"
> ...depends on: "arm: Add __aeabi_memclr in eabi_compat"
>
> Warm regards,
> Sam

Hi Tom,

I noticed that all patches in this series have been marked 'Changes
Requested' on Patchwork. While some patches do need changes, this
series was intended as a set of independent submissions: each patch
can be accepted, rejected, or reordered without affecting the others.
Would it be possible to reconsider the remaining patches for review
without resending the series?

I'd like to withdraw the following patches:

- [06/17] arm: Use -mstrict-align when the MMU is off (Incorrect approach)
- [11/17] makefile: Fix symbol typo in binary_size_check (Will follow
Simon's suggestion for a more comprehensive fix across architectures
in a future submission)

The feedback I've received so far was mostly requests for
clarification, which I believe I've addressed in my replies. Please
let me know if anything remains unclear or if further adjustments are
needed.

Thank you so much for your time!

Cheers,
Sam

>
> Sam Edwards (17):
>   arm: Remove stray .mmutable reference in linker script
>   arm: Exclude eabi_compat from LTO
>   arm: Add __aeabi_memclr in eabi_compat
>   arm: Add aligned-memory aliases to eabi_compat
>   arm: Discard unwanted sections in linker script
>   arm: Use -mstrict-align when the MMU is off
>   arm: Replace 'adrl' in EFI crt0
>   x86: Fix call64's section flags
>   spl: riscv: opensbi: Error on misaligned FDT
>   spl: Align FDT load address
>   makefile: Fix symbol typo in binary_size_check
>   makefile: Avoid objcopy --gap-fill for .hex/.srec
>   makefile: Add `norelro` linker option
>   makefile: Add READELF command variable
>   efi_loader: Remove ENTRY(_start) from linker script
>   efi_loader: Move .dynamic out of .text in EFI
>   scripts/Makefile.lib: efi: Preserve the .dynstr section as well
>
>  Makefile                    | 16 +++++++++-------
>  arch/arm/config.mk          |  4 ++++
>  arch/arm/cpu/u-boot.lds     | 29 ++++++++++-------------------
>  arch/arm/lib/Makefile       |  1 +
>  arch/arm/lib/crt0_arm_efi.S |  3 ++-
>  arch/arm/lib/eabi_compat.c  | 17 +++++++++++++++++
>  arch/x86/cpu/i386/call64.S  |  2 +-
>  common/spl/spl_fit.c        |  2 +-
>  common/spl/spl_opensbi.c    |  5 +++++
>  lib/efi_loader/elf_efi.ldsi |  7 +++----
>  scripts/Makefile.lib        |  4 ++--
>  11 files changed, 55 insertions(+), 35 deletions(-)
>
> --
> 2.45.2
>
