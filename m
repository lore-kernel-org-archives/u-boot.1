Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63ABC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0474C885B0;
	Mon, 10 Jun 2024 17:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D3aTUnQt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F88E8852E; Mon, 10 Jun 2024 17:17:58 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EE33885CF
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 17:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57c685bfd86so2957122a12.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 08:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718032675; x=1718637475; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLwPMcfKJdalWGM4BQftb7IZQ/9ARB4d3evykudvB1M=;
 b=D3aTUnQtQ3NyWkOxqXYBBhscnBZ9F9Azj/nlLJxgLWHaj84rWOebdj0CrPOWFal4of
 DMUQOTvtun3XvYtClZ5JT1lOwdU9SQrHbCaqLqhTpQf9/pgwzWMEjBtSxsn2tda+qGfB
 2a3btB2TUGjf6w1oTiOtT1TG/spcOPAMNecO3oJQpMtWuK5hjlmVhQri1IFIAbo4c2l8
 n7rGKJUTJ565VKf/yC6n5wOT1UtH+OpBz4qFPIAfRwGbJZl933wIisEAjk1lPG9rKyVb
 R9YSEk9xkzggEi1rPw1AXMSxnaRoPeRFHy+AW4Bwn4oE2A1NOK2uNpnULiV/b2LKI2Sf
 cErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718032675; x=1718637475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dLwPMcfKJdalWGM4BQftb7IZQ/9ARB4d3evykudvB1M=;
 b=KvPdL3HYzevI+FLiUNi0MOKZIVGWWNFpUwIdwLlUXZHc6j90686QCiWv59UeLBsKVj
 +9qji46aiCJH3YIeWu6h3ZiMwepRo63u6qC1lkdnnUwYd9zdDZboKwhGluJVPlSd8mEp
 UoAAsHNMuysUuHFZHfsKL6k3kkSIDhEpqYu2ViaGNMALwiwEAO4qJmuOtKhVKG676oNc
 JMonaYOHzccU91D1fnmbU3oE5t4C7eBscMnuzx6Q2x7NllapFgZF2l07WBXKzpyTSY/t
 m9Upm4idaMOsYTWQd7CxVB9Ev1lNbA23RsVziyaRqw97rdi9Gdd0e204uuecpF+lkVoE
 UDAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUe12LSTzIdLKek956pf19B1tdFQDYXvJXHNszTTcBgkphRkSZ7BD2zTvCcYAnXRB7eCIynIFplc3M7qXGVVzPv6GxYw==
X-Gm-Message-State: AOJu0YzaEz7mXPF7mNkNMHqdDWgBp6oLF1566hNj/idJECi6JXaEgvog
 qKeaHU2Q4JWa8ItArVN24kRJCOuJTA9a6XZcqdCNHAq8ErWsTTwrqAIS4OU9u/g766s8a1jKf4Y
 MIkcxROsA3oo8uqvYpGQpC78ObIZI+dS6Ld5HIQ==
X-Google-Smtp-Source: AGHT+IFUM7HMOMSzq0317z7KI2q3DcLUXlGPrJQ3XcGa0Xlz5ifAw9nciSXCvJso9CP/aCTsZhApbENnHdhkNiSiyOw=
X-Received: by 2002:a50:cd49:0:b0:57c:5c4f:a356 with SMTP id
 4fb4d7f45d1cf-57c5c4fa4bcmr5472460a12.8.1718032674521; Mon, 10 Jun 2024
 08:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231229154307.GS2652760@bill-the-cat>
 <7CDAA354-803C-4AFD-BD38-F432B811DB96@gmx.de>
 <20231229161744.GU2652760@bill-the-cat>
 <871qb4nbtc.fsf@bloch.sibelius.xs4all.nl>
 <20231229175215.GY2652760@bill-the-cat>
 <CAFLszTjXrmhOBeMvGfpy3mfZujNrCu2BKmUbEYz-rmxwyWdg3A@mail.gmail.com>
 <20231231135357.GZ2652760@bill-the-cat>
 <CAFLszTgCSDsobu9ak495vnRP-bjakK5Ytxd5YXro0-7GmYj9vA@mail.gmail.com>
 <20231231151144.GD2652760@bill-the-cat>
 <5599D28A-0255-4352-93E6-1095743F8983@gmx.de>
 <20231231161630.GE2652760@bill-the-cat>
 <CAFLszTgn2wq-QAEdgseAv7jx6TDyEQ+j6bQZZzdii2gmHtV5VA@mail.gmail.com>
 <CADg8p96jSeXOvkSX9R7g8343k9aJ6bwouSh5WJjy=AnQ+R8Kcw@mail.gmail.com>
 <CAFLszTgQKHXZ89aNz0uxUKGFCXcS5A+6Fqje+ga=gOhjWv=KOw@mail.gmail.com>
 <CADg8p95eRCduZ-HKDsFO-rRpdV3q033nespjCAfAd1oE64iRtw@mail.gmail.com>
 <CAFLszTihZjxsLhROmr=KKqPfqAxsBZs0RzmnKpsgtfmtg8cZog@mail.gmail.com>
In-Reply-To: <CAFLszTihZjxsLhROmr=KKqPfqAxsBZs0RzmnKpsgtfmtg8cZog@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 10 Jun 2024 20:47:43 +0530
Message-ID: <CADg8p97uQrBr_tbHSHkKnQtoj7r=3xaMHYpJnCtcuYE-q7hSCQ@mail.gmail.com>
Subject: Re: Proposal: U-Boot memory management
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de,
 ilias.apalodimas@linaro.org
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

hi Simon,

On Mon, 10 Jun 2024 at 20:33, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Mon, 10 Jun 2024 at 08:40, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >
> > hi Simon,
> >
> > On Mon, 10 Jun 2024 at 19:25, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Thu, 6 Jun 2024 at 13:18, Sughosh Ganu <sughosh.ganu@linaro.org> w=
rote:
> > > >
> > > > hi Simon,
> > > >
> > > > On Wed, 29 May 2024 at 22:00, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > +Sughosh Ganu for reference
> > > > >
> > > > >
> > > > > On Sun, 31 Dec 2023 at 09:16, Tom Rini <trini@konsulko.com> wrote=
:
> > > > > >
> > > > > > On Sun, Dec 31, 2023 at 04:40:06PM +0100, Heinrich Schuchardt w=
rote:
> > > > > > >
> > > > > > >
> > > > > > > Am 31. Dezember 2023 16:11:44 MEZ schrieb Tom Rini <trini@kon=
sulko.com>:
> > > > > > > >On Sun, Dec 31, 2023 at 07:22:10AM -0700, Simon Glass wrote:
> > > > > > > >> Hi Tom,
> > > > > > > >>
> > > > > > > >> On Sun, Dec 31, 2023 at 6:54=E2=80=AFAM Tom Rini <trini@ko=
nsulko.com> wrote:
> > > > > > > >> >
> > > > > > > >> > On Sun, Dec 31, 2023 at 05:48:23AM -0700, Simon Glass wr=
ote:
> > > > > > > >> > > Hi,
> > > > > > > >> > >
> > > > > > > >> > > On Fri, Dec 29, 2023 at 10:52=E2=80=AFAM Tom Rini <tri=
ni@konsulko.com> wrote:
> > > > > > > >> > > >
> > > > > > > >> > > > On Fri, Dec 29, 2023 at 06:44:15PM +0100, Mark Kette=
nis wrote:
> > > > > > > >> > > > > > Date: Fri, 29 Dec 2023 11:17:44 -0500
> > > > > > > >> > > > > > From: Tom Rini <trini@konsulko.com>
> > > > > > > >> > > > > >
> > > > > > > >> > > > > > On Fri, Dec 29, 2023 at 05:05:17PM +0100, Heinri=
ch Schuchardt wrote:
> > > > > > > >> > > > > > >
> > > > > > > >> > > > > > >
> > > > > > > >> > > > > > > Am 29. Dezember 2023 16:43:07 MEZ schrieb Tom =
Rini <trini@konsulko.com>:
> > > > > > > >> > > > > > > >On Fri, Dec 29, 2023 at 05:36:09AM +0000, Sim=
on Glass wrote:
> > > > > > > >> > > > > > > >> Hi,
> > > > > > > >> > > > > > > >>
> > > > > > > >> > > > > > > >> On Sat, Dec 16, 2023 at 6:01=E2=80=AFPM Sim=
on Glass <sjg@chromium.org> wrote:
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > Hi,
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > This records my thoughts after a discussi=
on with Ilias & Heinrich re
> > > > > > > >> > > > > > > >> > memory allocation in U-Boot.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > 1. malloc()
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > malloc() is used for programmatic memory =
allocation. It allows memory
> > > > > > > >> > > > > > > >> > to be freed. It is not designed for very =
large allocations (e.g. a
> > > > > > > >> > > > > > > >> > 10MB kernel or 100MB ramdisk).
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > 2. lmb
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > lmb is used for large blocks of memory, s=
uch as those needed for a
> > > > > > > >> > > > > > > >> > kernel or ramdisk. Allocation is only tra=
nsitory, for the purposes of
> > > > > > > >> > > > > > > >> > loading some images and booting. If the b=
oot fails, then all lmb
> > > > > > > >> > > > > > > >> > allocations go away.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > lmb is set up by getting all available me=
mory and then removing what
> > > > > > > >> > > > > > > >> > is used by U-Boot (code, data, malloc() s=
pace, etc.)
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > lmb reservations have a few flags so that=
 areas of memory can be
> > > > > > > >> > > > > > > >> > provided with attributes
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > There are some corner cases...e.g. loadin=
g a file does an lmb
> > > > > > > >> > > > > > > >> > allocation but only for the purpose of av=
oiding a file being loaded
> > > > > > > >> > > > > > > >> > over U-Boot code/data. The allocation is =
dropped immediately after the
> > > > > > > >> > > > > > > >> > file is loaded. Within the bootm command,=
 or when using standard boot,
> > > > > > > >> > > > > > > >> > this would be fairly easy to solve.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > Linux has renamed lmb to memblock. We sho=
uld consider doing the same.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > 3. EFI
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > EFI has its own memory-allocation tables.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > Like lmb, EFI is able to deal with large =
allocations. But via a 'pool'
> > > > > > > >> > > > > > > >> > function it can also do smaller allocatio=
ns similar to malloc(),
> > > > > > > >> > > > > > > >> > although each one uses at least 4KB at pr=
esent.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > EFI allocations do not go away when a boo=
t fails.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > With EFI it is possible to add allocation=
s post facto, in which case
> > > > > > > >> > > > > > > >> > they are added to the allocation table ju=
st as if the memory was
> > > > > > > >> > > > > > > >> > allocated with EFI to begin with.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > The EFI allocations and the lmb allocatio=
ns use the same memory, so in
> > > > > > > >> > > > > > > >> > principle could conflict.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > EFI allocations are sometimes used to all=
ocate internal U-Boot data as
> > > > > > > >> > > > > > > >> > well, if needed by the EFI app. For examp=
le, while efi_image_parse()
> > > > > > > >> > > > > > > >> > uses malloc(), efi_var_mem.c uses EFI all=
ocations since the code runs
> > > > > > > >> > > > > > > >> > in the app context and may need to access=
 the memory after U-Boot has
> > > > > > > >> > > > > > > >> > exited. Also efi_smbios.c uses allocate_p=
ages() and then adds a new
> > > > > > > >> > > > > > > >> > mapping as well.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > EFI memory has attributes, including what=
 the memory is used for (to
> > > > > > > >> > > > > > > >> > some degree of granularity). See enum efi=
_memory_type and struct
> > > > > > > >> > > > > > > >> > efi_mem_desc. In the latter there are als=
o attribute flags - whether
> > > > > > > >> > > > > > > >> > memory is cacheable, etc.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > EFI also has the x86 idea of 'conventiona=
l' memory, meaning (I
> > > > > > > >> > > > > > > >> > believe) that below 4GB that isn't reserv=
ed for the hardware/system.
> > > > > > > >> > > > > > > >> > This is meaningless, or at least confusin=
g, on ARM systems.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > 4. reservations
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > It is perhaps worth mentioning a fourth m=
ethod of memory management,
> > > > > > > >> > > > > > > >> > where U-Boot reserves chunks of memory be=
fore relocation (in
> > > > > > > >> > > > > > > >> > board_init_f.c), e.g. for the framebuffer=
, U-Boot code, the malloc()
> > > > > > > >> > > > > > > >> > region, etc.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > Problems
> > > > > > > >> > > > > > > >> > =E2=80=94-------
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > There are no urgent problems, but here ar=
e some things that could be improved:
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > 1. EFI should attach most of its data str=
uctures to driver model. This
> > > > > > > >> > > > > > > >> > work has started, with the partition supp=
ort, but more effort would
> > > > > > > >> > > > > > > >> > help. This would make it easier to see wh=
ich memory is related to
> > > > > > > >> > > > > > > >> > devices and which is separate.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > 2. Some drivers do EFI reservations today=
, whether EFI is used for
> > > > > > > >> > > > > > > >> > booting or not (e.g. rockchip video rk_vo=
p_probe()).
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > 3. U-Boot doesn't really map arch-specifi=
c memory attributes (e.g.
> > > > > > > >> > > > > > > >> > armv8's struct mm_region) to EFI ones.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > 4. EFI duplicates some code from bootm, s=
ome of which relates to
> > > > > > > >> > > > > > > >> > memory allocation (e.g. FDT fixup).
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > 5. EFI code is used even if EFI is never =
used to boot
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > 6. EFI allocations can result in the same=
 memory being used as has
> > > > > > > >> > > > > > > >> > already been allocated by lmb. Users may =
load files which overwrite
> > > > > > > >> > > > > > > >> > memory allocated by EFI.
> > > > > > > >> > > > > > > >>
> > > > > > > >> > > > > > > >> 7. We need to support doing an allocation w=
hen a file is loaded (to
> > > > > > > >> > > > > > > >> ensure files do not overlap), without makin=
g it too difficult to load
> > > > > > > >> > > > > > > >> multiple files to the same place, if desire=
d.
> > > > > > > >> > > > > > > >>
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > Lifetime
> > > > > > > >> > > > > > > >> > --------
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > We have three different memory allocators=
 with different purposes. Can
> > > > > > > >> > > > > > > >> > we unify them a little?
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > Within U-Boot:
> > > > > > > >> > > > > > > >> > - malloc() space lives forever
> > > > > > > >> > > > > > > >> > - lmb lives while setting out images for =
booting
> > > > > > > >> > > > > > > >> > - EFI (mostly) lives while booting an EFI=
 app
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > In practice, EFI is set up early in U-Boo=
t. Some of this is necessary,
> > > > > > > >> > > > > > > >> > some not. EFI allocations stay around for=
ever. This works OK since
> > > > > > > >> > > > > > > >> > large allocations are normally not done i=
n EFI, so memory isn't really
> > > > > > > >> > > > > > > >> > consumed to any great degree by the boot =
process.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > What happens to EFI allocations if the ap=
p returns? They are still
> > > > > > > >> > > > > > > >> > present, in case another app is run. This=
 seems fine.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > API
> > > > > > > >> > > > > > > >> > =E2=80=93--
> > > > > > > >> > > > > > > >> > Can we unify some APIs?
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > It should be possible to use lmb for larg=
e EFI memory allocations, so
> > > > > > > >> > > > > > > >> > long as they are only needed for booting.=
 We effectively do this
> > > > > > > >> > > > > > > >> > today, since EFI does not manage the arra=
ngement of loaded images in
> > > > > > > >> > > > > > > >> > memory. for the most part.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > It would not make sense to use EFI alloca=
tion to replace lmb and
> > > > > > > >> > > > > > > >> > malloc(), of course.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > Could we use a common (lower-level) API f=
or allocation, used by both
> > > > > > > >> > > > > > > >> > lmb and EFI? They do have some similariti=
es. However they have
> > > > > > > >> > > > > > > >> > different lifetime constraints (EFI alloc=
ations are never dropped,
> > > > > > > >> > > > > > > >> > unlikely lmb).
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > ** Overall, it seems that the existence o=
f memory allocation in
> > > > > > > >> > > > > > > >> > boot-time services has created confusion.=
 Memory allocation is
> > > > > > > >> > > > > > > >> > muddled, with both U-Boot code and boot-t=
ime services calling the same
> > > > > > > >> > > > > > > >> > memory allocator. This just has not been =
clearly thought out.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > Proposal
> > > > > > > >> > > > > > > >> > =E2=80=94-------
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > Here are some ideas:
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > 1. For video, use the driver model API to=
 locate the video regions, or
> > > > > > > >> > > > > > > >> > block off the entire framebuffer memory, =
for all devices as a whole.
> > > > > > > >> > > > > > > >> > Use efi_add_memory_map()
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > 2. Add memory attributes to UCLASS_RAM an=
d use them in EFI, mapping to
> > > > > > > >> > > > > > > >> > the EFI_MEMORY_... attributes in struct e=
fi_mem_desc.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > 3. Add all EFI reservations just before b=
ooting the app, as we do with
> > > > > > > >> > > > > > > >> > devicetree fixup. With this model, malloc=
() and lmb are used for all
> > > > > > > >> > > > > > > >> > allocation. Then efi_add_memory_map() is =
called for each region in
> > > > > > > >> > > > > > > >> > turn just before booting. Memory attribut=
es are dealt with above. The
> > > > > > > >> > > > > > > >> > type (enum efi_memory_type) can be determ=
ined simply by the data
> > > > > > > >> > > > > > > >> > structure stored in it, as is done today.=
 For example, SMBIOS tables
> > > > > > > >> > > > > > > >> > can use EFI_ACPI_RECLAIM_MEMORY. Very few=
 types are used and EFI code
> > > > > > > >> > > > > > > >> > understands the meaning of each.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > 4. Avoid setting up EFI memory at the sta=
rt of U-Boot. Do it only when
> > > > > > > >> > > > > > > >> > booting. This looks to require very littl=
e effort.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > 5. Avoid calling efi_allocate_pages() and=
 efi_allocate_pool() outside
> > > > > > > >> > > > > > > >> > boot-time services. This solves the probl=
em 6. If memory is needed by
> > > > > > > >> > > > > > > >> > an app, allocate it with malloc() and see=
 3. There are only two
> > > > > > > >> > > > > > > >> > efi_allocate_pages() (smbios and efi_runt=
ime). There are more calls of
> > > > > > > >> > > > > > > >> > efi_allocate_pool(), but most of these se=
em easy to fix up. For
> > > > > > > >> > > > > > > >> > example, efi_init_event_log() allocates a=
 buffer, but this can be
> > > > > > > >> > > > > > > >> > allocated in normal malloc() space or in =
a bloblist.
> > > > > > > >> > > > > > > >> >
> > > > > > > >> > > > > > > >> > 6. Don't worry too much about whether EFI=
 will be used for booting.
> > > > > > > >> > > > > > > >> > The cost is likely not that great: use bo=
otstage to measure it as is
> > > > > > > >> > > > > > > >> > done for driver model. Try to minmise the=
 cost of its tables,
> > > > > > > >> > > > > > > >> > particularly for execution time, but othe=
rwise just rely on the
> > > > > > > >> > > > > > > >> > ability to disable EFI_LOADER.
> > > > > > > >> > > > > > > >>
> > > > > > > >> > > > > > > >> 7. Add a flag to the 'load' command:
> > > > > > > >> > > > > > > >>
> > > > > > > >> > > > > > > >> -m <type> - make an lmb allocation for the =
file
> > > > > > > >> > > > > > > >>    <type> is the image type to use (kernel,=
 ramdisk, flat_dt)
> > > > > > > >> > > > > > > >>
> > > > > > > >> > > > > > > >> any existing allocation for that type will =
be automatically freed
> > > > > > > >> > > > > > > >> first. If <type> is "none" then no freeing =
is possible: any loaded
> > > > > > > >> > > > > > > >> images just stack up in lmb.
> > > > > > > >> > > > > > > >>
> > > > > > > >> > > > > > > >> Add an 'lmb' (or memblock) command to allow=
 listing and clearing allocations.
> > > > > > > >> > > > > > > >
> > > > > > > >> > > > > > > >I would really not like to change the user in=
terface and instead simply
> > > > > > > >> > > > > > > >handle this with flags to whatever mark/alloc=
ation function is called.
> > > > > > > >> > > > > > > >You can always overwrite things that are brou=
ght in to memory, you
> > > > > > > >> > > > > > > >cannot overwrite U-Boot or our internals. Opt=
ionally noting that some
> > > > > > > >> > > > > > > >previous load to memory has been at least par=
tially overwritten could be
> > > > > > > >> > > > > > > >helpful, if it's not too much extra logic.
> > > > > > > >> > > > > > > >
> > > > > > > >> > > > > > >
> > > > > > > >> > > > > > > In most use cases users load exactly one file =
at  each address. An
> > > > > > > >> > > > > > > unload command would be the cleanest way for a=
 user to indicate that
> > > > > > > >> > > > > > > he wants to reuse the memory.
> > > > > > > >> > > > > >
> > > > > > > >> > > > > > I very much do not want to change the API. There=
's untold numbers of
> > > > > > > >> > > > > > scripts out there and they should continue to wo=
rk. I mentioned to Ilias
> > > > > > > >> > > > > > off list just now that I'm not against adding a =
command to add flags to
> > > > > > > >> > > > > > these areas, but I don't think it's worthwhile t=
o prevent overwrites the
> > > > > > > >> > > > > > user did early. The biggest long running problem=
 in this space was that
> > > > > > > >> > > > > > for 32bit ARM we couldn't know where the kernel =
BSS was going to be and
> > > > > > > >> > > > > > so would have ramdisk at the wrong spot and get =
partially eaten, and
> > > > > > > >> > > > > > this was hard to figure out. The current example=
 is "ooops,
> > > > > > > >> > > > > > decompression buffer for Image.gz/etc is too clo=
se to other things"
> > > > > > > >> > > > > > which ends up failing nice and loudly, and in th=
e future once this
> > > > > > > >> > > > > > proposal is done we can just dynamically find an=
d use a spot, since
> > > > > > > >> > > > > > we'll have that ability finally.
> > > > > > > >> > > > >
> > > > > > > >> > > > > In order to keep the existing interfaces we need l=
mb to keep track of
> > > > > > > >> > > > > (at least ) three different states.  I think of th=
ose as "free",
> > > > > > > >> > > > > "allocated" and "reserved".  The load command woul=
d "reserve" memory
> > > > > > > >> > > > > insteaf "allocate".  And it would pass a flag to l=
mb when reserving
> > > > > > > >> > > > > memory to indicate that reserving memory that is a=
lready reserved is
> > > > > > > >> > > > > ok.  Both "reserved" and "allocated" memory should=
 show up as not free
> > > > > > > >> > > > > in the EFI memory map (probably as EfiLoaderData).
> > > > > > > >> > > >
> > > > > > > >> > > > Yes, something like this is what I was getting at, t=
hanks.
> > > > > > > >> > >
> > > > > > > >> > > Yes, that is a good way of putting it. There is defini=
tely a distinction there.
> > > > > > > >> > >
> > > > > > > >> > > If we don't want this flag, we could make U-Boot alway=
s do a
> > > > > > > >> > > reservation on load, with a '-f' command to force load=
ing over an
> > > > > > > >> > > existing reservation / releasing it first?
> > > > > > > >> >
> > > > > > > >> > Again, this is an API change and I don't want to change =
the API.
> > > > > > > >>
> > > > > > > >> The flag is only needed to drop a reservation, since we ap=
parently
> > > > > > > >> want the 'load' command to create a permanent reservation.=
 It should
> > > > > > > >> not affect existing boot scripts since they won't load ove=
rlapping
> > > > > > > >> images.
> > > > > > > >>
> > > > > > > >> Anyway, what do you suggest?
> > > > > > > >
> > > > > > > >That "load" (and sf read and nand read and tftp and wget and=
 ...)
> > > > > > > >"reserve" memory but not "allocate" memory and "reserve" mea=
ns something
> > > > > > > >is there and "allocate" means that it can't be modified agai=
n. For
> > > > > > > >example, running U-Boot and our malloc pool are "allocated" =
but just
> > > > > > > >loading a file to memory is "reserved".  And then yes, I can=
 see use for
> > > > > > > >the command where some cases might want to "reserve" memory =
to fiddle
> > > > > > > >with it and then "allocate" it so something else can't chang=
e it.
> > > > > > > >
> > > > > > > >This is one of those cases where english is terrible to disc=
uss things
> > > > > > > >in as both reserve and allocate can mean similar things.
> > > > > > > >
> > > > > > >
> > > > > > > I have no clue what the semantics of the mentioned "reserved"=
 state might be. Up to now  memory reservations designated address ranges t=
hat U-Boot must not use at all, e.g. the memory used by OpenSBI or TF-A.
> > > > > > >
> > > > > > > Who can and who cannot write into "reserved" memory?
> > > > > > >
> > > > > > > What is wrong about allocating memory for files to forbid any=
 other use until you are done with the file and free the memory?
> > > > > >
> > > > > > So, historically (lets say mid 2010s), you could use "load" to =
bring a
> > > > > > file in to memory, anywhere, and it could even overwrite part o=
f U-Boot
> > > > > > (running, or malloc pool or whatever). You could also use "load=
" to
> > > > > > bring a file in to memory and then bring another file in to tha=
t same
> > > > > > location in memory for whatever reason (assorted development ca=
ses).
> > > > > >
> > > > > > Then later someone noted that using "load" to overwrite U-Boot =
should
> > > > > > get a CVE and instead of ignoring it we decided to use "lmb" to=
 try and
> > > > > > make sure that we couldn't use "load" to overwrite U-Boot itsel=
f, and
> > > > > > that that's a pre-check. This still allows overwriting a previo=
usly
> > > > > > loaded file in memory.
> > > > > >
> > > > > > Overwriting something the user put in memory is part of the ABI=
 and has
> > > > > > some use cases.
> > > > > >
> > > > > > So for whatever future system we setup, a memory location can b=
e:
> > > > > > - Free.
> > > > > > - Readable but not Writable.
> > > > > > - Readable and Writable.
> > > > > >
> > > > > > Something like $loadaddr starts as Free. If someone then uses "=
load" to
> > > > > > bring in an OS image, it's now "Readable and Writable". But if =
someone
> > > > > > does an API call to ask for a new region memory, it wouldn't re=
turn
> > > > > > $loadaddr because it's not Free. On the other hand, $relocaddr =
where
> > > > > > U-Boot is, at least in terms of the API is that it's "Readable =
but not
> > > > > > Writable".
> > > > > >
> > > > > > Does that help?
> > > >
> > > > Thanks for sharing this with me. I have been working on a solution =
for
> > > > this issue [1], and plan to send a rfc series by the end of this we=
ek.
> > > > My primary motivation behind this work is to have some kind of
> > > > synchronisation between the allocations done by the LMB module and =
the
> > > > EFI subsystem. As you are aware, the way things stand today, either=
 of
> > > > the two can make memory allocations overwriting any earlier allocat=
ed
> > > > memory. The primary reasons behind this is 1) the LMB allocations a=
re
> > > > private to their respective callers, so the LMB memory map is not
> > > > global and persistent, and 2) the EFI allocation routines do not ha=
ve
> > > > any view of the allocations that would have been made by the LMB
> > > > module.
> > > >
> > > > To fix these issues, I am working on a solution which 1) makes LMB
> > > > memory map persistent and global, and 2) have notifications between
> > > > the two modules when either of the two has made any changes to it's
> > > > memory map. This way, it would be possible to prohibit one module f=
rom
> > > > allocating memory which is in use.
> > > >
> > > > I am aware that we have a whole bunch of tests and user scripts whi=
ch
> > > > work with an assumption that the memory can be re-used. The solutio=
n
> > > > that I would be proposing takes care of this assumption. Hopefully =
I
> > > > should be in a position to send a rfc series this week. We can disc=
uss
> > > > on the patches. Thanks.
> > >
> > > I actually am not sure what we are on the same page here. I described
> > > the problems in my original email but your series seems to solve
> > > somewhat different problems, while IMO introducing a whole new class
> > > of problems.
> >
> > Can you please describe in a little more detail what "whole new class
> > of problems" are being introduced here. If there are problems being
> > introduced, it is better if they are enumerated, so that I can try to
> > fix them.
>
> Please see my point immediately below:
>
> >
> > >
> > > Making LMB persistent and global is a solution looking for a problem,
> > > IMO. Can we go up a level and figure out exactly what is broken here?
> > > That is what I attempted to do in my original email. Perhaps you coul=
d
> > > reply to that and suggest where you agree / disagree?
> >
> > I have gone through this thread multiple times, and my understanding
> > was that there was no conclusive agreement that was arrived at. I saw
> > a reply from Tom where he broadly mentioned what kind of a solution he
> > is looking for. I am not sure if you have gone through the
> > cover-letter of my RFC series [1], which clearly states the problem my
> > patch series is trying to fix. Like I said above, it would help if you
> > can describe in a little more detail the kind of issues you see with
> > the RFC series. Thanks.
>
> My request was for you to reply to the thread with any thoughts so we
> can agree what to do about it. I believe my original email mostly
> stands as a summary of where things are and what the problems are. If
> it helps, I can update it based on the discussion above. It is
> important to avoid over-complicating U-Boot.
>
> My fundamental expectation is that LMB reservations only apply for a
> particular boot. They should not be global, nor need freeing, nor
> should they be similar to memory allocations. We discussed it in this
> thread.

Please note that I have run the patches through CI, and they pass the
CI run. There are numerous examples in the CI test scripts where the
LMB memory is re-used, and these patches are not changing that
behaviour in any which way. The only reason why the LMB memory needs
to be persistent and global is because it needs to work cohesively
with the EFI memory allocator.

At this point, I guess the EFI maintainers and Tom have to provide
their input on how we go about this. But if we have to have EFI
allocations live alongside LMB, the *only* other solution that I see
is to then break up the memory into two sections, one for LMB and one
for EFI. But then again, that introduces it's own set of issues, for
e.g. a platform might not be able to use some memory region simply
because it is allocated to the other subsystem. But I would let the
maintainers chime in at this point. Thanks.

-sughosh

>
> Regards,
> Simon
