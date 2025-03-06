Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2715C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 13:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16570808A2;
	Thu,  6 Mar 2025 14:15:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wNCpc43B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E09980F4C; Thu,  6 Mar 2025 14:15:45 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C576F805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 14:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6f6c90b51c3so6034117b3.2
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 05:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741266941; x=1741871741; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=euBWZkfeqr3OElKf2N8SQm7Set9H23SO33zoLW6KxW4=;
 b=wNCpc43BeD7pi47vBwzNCace/gqpL5903+h1jfN8Rdpt7Y41f+L7gKm986oNugv3b+
 V/DO1XXLR00Whj/NP6gJmTF0svPyRuNvSbroQUsZBs49hbvVD5G6OWPKwSD+qgkxIpUF
 eNpM5YMUZwX2cuhCgpBN/rXFhgh4GSV863tmJjnVnK5A6KgbzTe5NI42ALIBs9mqPZeN
 lpzoD96QY1ilcgMKJMNWQOVi3THOSWnH48oIpelvjWLCLDXFZVJnzcen3tr8ldEe6KqA
 aydgdnpvpEYyAmmHHDNHKLgzmIAf2NkBq1HgvFlXZWhxiGKfOEw297z3LezfuGS0bmUo
 jaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741266941; x=1741871741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=euBWZkfeqr3OElKf2N8SQm7Set9H23SO33zoLW6KxW4=;
 b=WFcyjRVp0xYWOE99r/2u7Co2kOeo0L9TB4jWe26f3kRsha0vmeqfHnaXJZ9bY2uyTs
 ggCvAfTTUKcY52RVdzlC5TIEjuP6YvbduRNzLC6uCULTTr8P4YsknjwqaFML+7eyuL/5
 HyYc7RmuiOXVNvo4xT8tRxCowS2rFqp/4C+f+86MsUzkIhXMUfMlfxAzVnryNpUYEuiM
 4GHTo4XPBVxDMFuO5q75J3+RlfGnEYnhp9C93OzJZSN33wb7wb/xlHe0mZ5Cx8nc6eJu
 nmBMKti8eyJuXydPQmxH7vk5M5mSWVgJ5y5N+wfHybT+OGIUKupSS7t8dQsO+YOVCM6n
 IubA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXka5/3QvKhvJeCw2LuY8EUflrcDyi/eFvmb50XEwdhKA0EmQO13xSzo9Yq0lnpOFwT6RV0LZk=@lists.denx.de
X-Gm-Message-State: AOJu0YytDGMH3jwwcpkApmNIoOG0VybRN2h4nrJZoiGI/SmJjqY139KW
 vIbUso1O+C5qRo1MjG8PVFgsTRbQHzyeasEu24YsPi62CwdEKo+Iivqm5rLtTvIdh9ECOW7oz7/
 gcDctvGl9TfFTM4aLcdakSKSHnTLfXI0rxqeWCQ==
X-Gm-Gg: ASbGnctIgcB7IcCXiK5YIsCvNnF7zOzoWW89QB/0Modl0wUXWoS+hUbUKY8+wDlnXwV
 rKAhz8+p8+ErVr5PEO8kzNunHtVfRsWDm7yaGPK51vtSpmZQ5CrrCw6VSMSnWyIc01JgghhFRJr
 wSMyHPjNB0ivdU4X4oMt2K+kxX
X-Google-Smtp-Source: AGHT+IHN8GbOsUR69xSrLh5C8EdhYbLxithRdPMY7rpuneAvT02cBLcRUuZKykrkSWkBrh8mMfcLlBr8BTml3ki42bY=
X-Received: by 2002:a05:690c:74c6:b0:6fd:42c8:3c6a with SMTP id
 00721157ae682-6fda31b124cmr93509407b3.34.1741266941610; Thu, 06 Mar 2025
 05:15:41 -0800 (PST)
MIME-Version: 1.0
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <CAH5Ym4isqLibOv97=9zgYFx-fok-sAa3QetfRgyrQmDQ4MHgmQ@mail.gmail.com>
In-Reply-To: <CAH5Ym4isqLibOv97=9zgYFx-fok-sAa3QetfRgyrQmDQ4MHgmQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 6 Mar 2025 13:15:05 +0000
X-Gm-Features: AQ5f1Jo8gf9cekS4KWc-jQZxS50SVz76pZXKQtyoF88Al3L10MAkzU7y9GlqqXw
Message-ID: <CAC_iWj+cLyO=QkA4E_LYhYoQaedj4w613Z+BO_eS8ieFHJ73Ww@mail.gmail.com>
Subject: Re: [PATCH 00/17] Various toolchain compatibility fixes/improvements
To: Sam Edwards <cfsworks@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
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

Hi Sam

On Thu, 6 Mar 2025 at 03:47, Sam Edwards <cfsworks@gmail.com> wrote:
>
> On Sun, Feb 23, 2025 at 9:55=E2=80=AFPM Sam Edwards <cfsworks@gmail.com> =
wrote:
> >
> > Long time no see, U-Boot folks!
> >
> > This patchset consists of various bug fixes and correctness improvement=
s that
> > I discovered while attempting to add first-class LLVM support to the bu=
ild
> > system. These patches are NOT related to LLVM support directly; rather,=
 they
> > address existing issues that should be resolved regardless of future ch=
anges.
> > For the most part, the patches are mutually independent and can be revi=
ewed and
> > applied separately. If any patch is not suitable for merging now, feel =
free to
> > skip it: I will incorporate feedback and revisit those changes as part =
of the
> > upcoming LLVM support patchset. I'd like this patchset to be evaluated =
on its
> > own merits, based on the current state of the code, without considerati=
on for
> > future LLVM support.
> >
> > Note that the issues addressed in this patchset do not occur when U-Boo=
t is
> > built using the GCC/GNU toolchain. These bugs seem to be specific to bu=
ilds
> > using other toolchains, like LLVM, and do not appear to affect users re=
lying on
> > GCC/GNU. Therefore, I see no need to rush these changes into the stable=
 branch.
> >
> > Again, these patches are mostly independent/reorderable...
> > ...except that: "arm: Add aligned-memory aliases to eabi_compat"
> > ...depends on: "arm: Add __aeabi_memclr in eabi_compat"
> >
> > Warm regards,
> > Sam
>
> Hi Tom,
>
> I noticed that all patches in this series have been marked 'Changes
> Requested' on Patchwork. While some patches do need changes, this
> series was intended as a set of independent submissions: each patch
> can be accepted, rejected, or reordered without affecting the others.
> Would it be possible to reconsider the remaining patches for review
> without resending the series?
>
> I'd like to withdraw the following patches:
>
> - [06/17] arm: Use -mstrict-align when the MMU is off (Incorrect approach=
)
> - [11/17] makefile: Fix symbol typo in binary_size_check (Will follow
> Simon's suggestion for a more comprehensive fix across architectures
> in a future submission)
>
> The feedback I've received so far was mostly requests for
> clarification, which I believe I've addressed in my replies. Please
> let me know if anything remains unclear or if further adjustments are
> needed.
>
> Thank you so much for your time!

I am currently on a trip. I had a quick look at the patches and looked
reasonable. I'll have a closer look next week

Cheers
/Ilias
>
> Cheers,
> Sam
>
> >
> > Sam Edwards (17):
> >   arm: Remove stray .mmutable reference in linker script
> >   arm: Exclude eabi_compat from LTO
> >   arm: Add __aeabi_memclr in eabi_compat
> >   arm: Add aligned-memory aliases to eabi_compat
> >   arm: Discard unwanted sections in linker script
> >   arm: Use -mstrict-align when the MMU is off
> >   arm: Replace 'adrl' in EFI crt0
> >   x86: Fix call64's section flags
> >   spl: riscv: opensbi: Error on misaligned FDT
> >   spl: Align FDT load address
> >   makefile: Fix symbol typo in binary_size_check
> >   makefile: Avoid objcopy --gap-fill for .hex/.srec
> >   makefile: Add `norelro` linker option
> >   makefile: Add READELF command variable
> >   efi_loader: Remove ENTRY(_start) from linker script
> >   efi_loader: Move .dynamic out of .text in EFI
> >   scripts/Makefile.lib: efi: Preserve the .dynstr section as well
> >
> >  Makefile                    | 16 +++++++++-------
> >  arch/arm/config.mk          |  4 ++++
> >  arch/arm/cpu/u-boot.lds     | 29 ++++++++++-------------------
> >  arch/arm/lib/Makefile       |  1 +
> >  arch/arm/lib/crt0_arm_efi.S |  3 ++-
> >  arch/arm/lib/eabi_compat.c  | 17 +++++++++++++++++
> >  arch/x86/cpu/i386/call64.S  |  2 +-
> >  common/spl/spl_fit.c        |  2 +-
> >  common/spl/spl_opensbi.c    |  5 +++++
> >  lib/efi_loader/elf_efi.ldsi |  7 +++----
> >  scripts/Makefile.lib        |  4 ++--
> >  11 files changed, 55 insertions(+), 35 deletions(-)
> >
> > --
> > 2.45.2
> >
