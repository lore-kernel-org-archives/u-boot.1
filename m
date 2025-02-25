Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6995C021B6
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 02:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BAE9807B1;
	Tue, 25 Feb 2025 03:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jIxu+NC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAF1280805; Tue, 25 Feb 2025 03:48:44 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93C33805C3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 03:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5deb956aa5eso6702765a12.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 18:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740451722; x=1741056522; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zulxL0f+ABl8ekCRw5Rnt1AQ9ZwmsjoFlG8JWZerSfQ=;
 b=jIxu+NC3xjLoux7gNFGHo6mOD36P7V8By0dhDat/Yp0sG+AW0+xzQyUPKCQemOrKBf
 0xEqjmSoE0rRBYqwuBoGBx6XHM6AKDE7Fk2Kr4EgBH9yse0K0mbHQoSXlIrfYLX3mM1s
 z40RA8wu/oBR90LcHiH0Fa2O5UQWeq28YAuSgt49dWUf2lyKqjXhI83CDyW+nrmhxVb7
 E6aqdIb6Ou844WOdh6Vxzmai3G9Axi/y0A+8N54EndzF0uEm4nrFGXVQd+1UTEoZFe/C
 q4i2PIKgpQ27BlmSaqNEnGV6XVcmseX8Pn1olVEzhF+UFhJClcYfniJCGsm8PViUBx0A
 WZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740451722; x=1741056522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zulxL0f+ABl8ekCRw5Rnt1AQ9ZwmsjoFlG8JWZerSfQ=;
 b=pCSPMY93ZJimQLn+gBLxsRcBPrMVg6CmaRpzkiDWSf/1j1slPBEzHouUlP2gNDt+bA
 xY+2SoDXzMzoPoQ5lO061Sc0evzuTXVuZwKqxQDwjR4fv1TxHGu1PdNyTFbx+Ct0B2oK
 Ske7JsiDglV35ZGQ0YKbSZ+weM/77fD1vH3pKvuNgiQf8mRVb5B2iBYbUrqNH2IavW/C
 T952AEfcdP+u7G4AbVjlsa6jn+Td3hgUkx6Vi7/wqRLdYhK7tC6EcvdrUlSdOUwDw8Fs
 SJWbUPc8SjFxl5S/EC8RDUL+C2rL5ymowOAHDJ28zFPp1bV+Eg6CeNTf/P9mYgKyZmQb
 7rUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeiyusf63oipD0qfVgSp2EpIC867m00D2tStCRlIHmbab556WxoaGS66RD8AzvEo70cCducFg=@lists.denx.de
X-Gm-Message-State: AOJu0YzTPGJcLwzSCjeffEPrtMWnPF2+PPjWHxoAL/9PXWj1lrGZwnWA
 xH3UnHXfojboRvWrUtyKxBhkfib1U35UAo6k7oAsH9pizx902amiGlsLpyOfX2wCcl6hJTshPJZ
 vj7DdukpmQcgGAp1XWSFm5brK4Ip2LOFjnC8=
X-Gm-Gg: ASbGncsdVdvTRfDuxR700oDqnfjgANnzaMCifshRllvnQa7gUD4lZri5duU24dI7MEJ
 V0Pr8Pcmdz6AxP81PBP7F0m4R1lP5pNLRZv+uBciR4z7mww7iZ+wBHpz1VwrRyaaC3WncMdomR2
 pBm38yRl+Ugyq+rr2MAfVbhVYKuhq7nwLqS5N79gie
X-Google-Smtp-Source: AGHT+IGNk5LEi/IOLF3WUYPwQIbKUxHEahpJsYBaI9bCrtCSCBoucw1lRJ5B1982mU0jh+eO/pm7lGovg+4G/Hxt0eY=
X-Received: by 2002:a05:6402:50c8:b0:5e0:2d53:b2a with SMTP id
 4fb4d7f45d1cf-5e44475f4d3mr3083643a12.3.1740451721834; Mon, 24 Feb 2025
 18:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-11-CFSworks@gmail.com>
 <2cd9e4dd-cb85-4661-92d2-fae4bc54ad05@gmx.de>
 <20250224145657.GD1233568@bill-the-cat>
 <31342144-345b-4dd8-b80e-f53376a591d8@gmx.de>
 <20250224160305.GG1233568@bill-the-cat>
In-Reply-To: <20250224160305.GG1233568@bill-the-cat>
From: Sam Edwards <cfsworks@gmail.com>
Date: Mon, 24 Feb 2025 18:48:29 -0800
X-Gm-Features: AWEUYZmO9069QcFJmOAzdj0MzOG7dTnXhqsRt8xQaiF4R66n_7vxPGE0xSLRtWE
Message-ID: <CAH5Ym4heTOztKsfbYRLEqaMc_NHoy=aDHXRxXHPP-VwUaN5VdA@mail.gmail.com>
Subject: Re: [PATCH 10/17] spl: Align FDT load address
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de, 
 Patrice Chotard <patrice.chotard@foss.st.com>
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

On Mon, Feb 24, 2025 at 8:03=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Feb 24, 2025 at 04:54:09PM +0100, Heinrich Schuchardt wrote:
> > On 24.02.25 15:56, Tom Rini wrote:
> > > On Mon, Feb 24, 2025 at 09:59:42AM +0100, Heinrich Schuchardt wrote:
> > > > On 2/24/25 06:55, Sam Edwards wrote:
> > > > > While the image size is generally a multiple of 8 bytes, this is =
not
> > > > > actually guaranteed; some linkers (like LLD) may shave a few byte=
s off
> > > > > of the end of output sections if there are no content bytes there=
. Since
> > > > > libfdt imposes a hard rule of 8-byte alignment, make the SPL also=
 be
> > > > > explicit about the alignment when loading the FDT.
> > > > >
> > > > > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > > > > ---
> > > > >    common/spl/spl_fit.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> > > > > index 49b4df60560..86506d6905c 100644
> > > > > --- a/common/spl/spl_fit.c
> > > > > +++ b/common/spl/spl_fit.c
> > > > > @@ -397,7 +397,7 @@ static int spl_fit_append_fdt(struct spl_imag=
e_info *spl_image,
> > > > >          * Use the address following the image as target address =
for the
> > > > >          * device tree.
> > > > >          */
> > > > > -       image_info.load_addr =3D spl_image->load_addr + spl_image=
->size;
> > > > > +       image_info.load_addr =3D ALIGN(spl_image->load_addr + spl=
_image->size, 8);
> > > >
> > > > We want to keep the SPL code size as small as possible as on many
> > > > platforms it is restricted to the cache size.
> > > >
> > > > Can't we fix this linker issue in the linker script by properly ali=
gning
> > > > the SPL image end address?
> > >
> > > Size growth is always something to watch for, but not at the expense =
of
> > > correctness and saving a few bytes. We really do need to fix the plac=
es
> > > where U-Boot could but doesn't ensure the device tree is correctly
> > > aligned in memory.
> > >
> >
> > Hello Tom,
> >

Hi gents,

> > spl_image->load_addr is always a multiple of 8.

So while spl_image->load_addr is 8-aligned, spl_image->size appears to
have no such guarantees.

When loaded from FIT, the size is simply the data length of the U-Boot
image, which is itself the filesize of `u-boot-nodtb.bin`. That ends
up being determined by the whims of the toolchain (ld+objcopy).

> >
> > Adding
> >
> >    . =3D ALIGN(8)"
> >
> > in arch/riscv/cpu/u-boot-spl.lds before
> >
> >     _end =3D .;
> >     _image_binary_end =3D .;
> >
> > is all it takes.

While that guarantees that `_end` and `_image_binary_end` are aligned
on an 8-byte boundary, that does not necessarily mean that sufficient
padding bytes will be emitted, so the `u-boot-notdb.bin` file may
still end immediately after the last included content byte.

If there is a hard rule that the size must be a multiple of 8, we
should probably be enforcing/padding it when the FIT is generated.
(And then, a comment here in spl_fit.c explaining that it is
guaranteeing the alignment by depending on load_addr/size assumptions
would go a long way toward keeping those assumptions valid.) But if
that rule does not exist, and it's actually valid for the size to be
whatever odd length, then this patch is necessary for correctness.

> But this is generic code and I don't see how we know that in every case
> every way we could be reading the device tree that it will be at an 8
> byte aligned location. There's a number of ways today where it's not,
> which is what Patrice found as part of updating our own libfdt to one
> that enforces the alignment check.

I mentioned in my reply to patch 9/17 of this series that I would also
be fine with a common assert that catches any misaligned FDTs before
they are passed to third-party components for consumption. I suspect
the main reason that many of these cases are slipping through is
because some of those components are tolerant of misaligned FDTs, and
if a developer is only testing against those then they won't notice
the misalignment. Putting something in the unconditional code path of
the SPL that enforces the FDT alignment ought to put a stop to that.

Thoughts?

Cheers,
Sam

>
> --
> Tom
