Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E44C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 23:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DE22807C0;
	Wed, 12 Feb 2025 00:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FEj40BRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AEBD80842; Wed, 12 Feb 2025 00:28:47 +0100 (CET)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39AB080548
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 00:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jonathanbaror@gmail.com
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-867044e979dso1550282241.3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 15:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739316523; x=1739921323; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQnH5P2GeliKHpjzSCME0Gs+xwrAlvlU/ufLz+3IVsQ=;
 b=FEj40BRFEb5sZQpCIZ2pQ4g1lgswdGGja1HRpjzgYPRaidNmv/RzYdh30oBlvbrDHN
 ZnyolZ17s0ZC+xKbGWsZTzF7YUeRUwNc+K6PEnTaZkKl383rqdtZ+Gf6Tk6tugkTT5eO
 KnG741qJOoEhgGhneRd0EwqplbCFoeteoFmWs9LVD7hgNubDigY4ZflNG3bYniElu2ku
 s6FYg4D46fOtIfUbusucyfHPrROJkaAnUU64+nedCq/IoEpIDbjO6Ov/g0ijTN6WUCJv
 ASQGyLtGJSqb1foN8Dy/TGl1JGtgNEVU06MV1QJzZKMP5vNgydDFdx9UyansPiVRG1Ya
 wXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739316523; x=1739921323;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQnH5P2GeliKHpjzSCME0Gs+xwrAlvlU/ufLz+3IVsQ=;
 b=svGzp7X9YGM4/93UNvt/LepKamYe87CjIHCuqsz9CAsBLcVor0OvkBzStwEVvG1+sG
 k0xHN5stJLBbEYD2XLYe5bOqwPW42VDe7FIPVNrA3A/uyH8ea+/XBaEETdj5q3M+QLMF
 Xgc2mW+HtijJ4EUac12BXlyphtjpz9bJHE7gk03YiISZfj6wZetKPYnBLJb2pjjtzUgc
 ukzQv6+qj4owAzU+88QWN7Lw9PF9w91JoaNYxGFtRM0qo6punfxxQqmj6FWGF/K/Rsv8
 y/vwZmA27rF7yyHdXwHnr+Eq8SjRkWe6LjkqmAQ7ty7iVetaskHZjf8flFdTHAPABVFv
 Qv8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBy5w6tfPPJGtFT0fGPSW7vURAhmI3Yv9j8RpITMQrKFuV7wzPhUqqnaCaanAEBqvEWAIgfoM=@lists.denx.de
X-Gm-Message-State: AOJu0YwH5ZiwXP4DzVBwIpWVAWHDAsE6WDArjGHveQ8dF/vWlfWxvJQm
 DT2y9dPGx+6bx62GjeKxfiIquUEQufF3WfYWVPBEdFgfcK3I5jHMaSYEdfzGkexI6o5Ta/lYk5P
 RBunoRGZaSU0btQZ1jS/HwLm3Mjg=
X-Gm-Gg: ASbGncueAaStP56yAWc2/7dpM7mYxH2H+/B8GfThoEOesJySdMT44htE6H6gYirJzUo
 +/LcawHf7JjFWlDuI4S/6ENkANnWbVm0y1KpafYDjmnj0vhb4YGCUJsXwTlsJZVH/mIIvt6cDDS
 ncdcuel3vs7cGinyryVkr00qaEMzXN
X-Google-Smtp-Source: AGHT+IHM4M9TMOu+WRtw2j+hdcsgiv9ZnObcd9GSSwp8rRqwkq8/a4xgvi2/qLZ6cPgUgTgZYUl+xDdb7mxpUMRTgRg=
X-Received: by 2002:a05:6102:2d02:b0:4ba:9a20:dcff with SMTP id
 ada2fe7eead31-4bbf217a378mr1729167137.11.1739316522993; Tue, 11 Feb 2025
 15:28:42 -0800 (PST)
MIME-Version: 1.0
References: <CABMsoEGyEgWGHYMoL9kH2Os_=krqSTwdLaMu+XSOJd+micYpGQ@mail.gmail.com>
 <20250207155048.GX1233568@bill-the-cat>
 <CABMsoEGLaMGch7gEuGGcyPy5REj4RDAFmX=AGnOmMnnbuSmhWA@mail.gmail.com>
 <20250210164151.GN1233568@bill-the-cat>
 <7e9d99b5-59c9-47ed-a5c9-c4449e3068c0@linux.alibaba.com>
 <CABMsoEGMq0b71ZbukBz5kbiHQhWHdG_dBzbk6eH+6My7MVGEsQ@mail.gmail.com>
 <20250211212909.GI1233568@bill-the-cat>
In-Reply-To: <20250211212909.GI1233568@bill-the-cat>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Tue, 11 Feb 2025 15:28:32 -0800
X-Gm-Features: AWEUYZlZ16m252xxTRccJyCo60a0nbsuSjNk4KsZSrKCO8dPXOXA4rIKe54zACg
Message-ID: <CABMsoEGs5N9Uhz-wW2_cq=HguLf8PivRukXJBLnSO+_-+NsJeg@mail.gmail.com>
Subject: Re: Security vulnerabilities report to Das-U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Huang Jianan <jnhuang95@gmail.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de, 
 linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 12 Feb 2025 00:53:58 +0100
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

Thank you, I've reached out to MITRE for CVE numbers, I will
communicate them once assigned (hopefully within a few days).

Best regards,
              Jonathan

On Tue, Feb 11, 2025 at 1:29=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, Feb 11, 2025 at 08:26:37AM -0800, Jonathan Bar Or wrote:
> > Hi Tom and the rest of the team,
> >
> > Please let me know about fix time, whether this is acknowledged and
> > whether you're going to request CVE IDs for those or if I should do
> > it.
> > The reason is that I found similar issues in other bootloaders, so I'm
> > trying to synchronize all of them. For what it's worth, Barebox has
> > similar issues and are currently fixing.
>
> Yes, these seem valid. We don't have a CVE requesting authority so if
> you want them, go ahead and request them. You saw Gao Xiang's response
> for erofs, and I'm hoping one of the squashfs maintainers will chime in.
>
> >
> > Best regards,
> >              Jonathan
> >
> > On Mon, Feb 10, 2025 at 7:51=E2=80=AFPM Gao Xiang <hsiangkao@linux.alib=
aba.com> wrote:
> > >
> > > Hi Tom,
> > >
> > > On 2025/2/11 00:41, Tom Rini wrote:
> > > > On Fri, Feb 07, 2025 at 09:53:01AM -0800, Jonathan Bar Or wrote:
> > > >
> > > >> Thank you.
> > > >>
> > > >> So, I'm attaching my findings in a md file - see attachment.
> > > >> All of those could be avoided by using safe math, such as
> > > >> __builtin_mul_overflow and __builtin_add_overflow, which are used =
in some
> > > >> modules in Das-U-Boot.
> > > >> There are many cases where seemingly unsafe addition and multiplic=
ation can
> > > >> cause integer overflows, but not all are exploitable - I believe t=
he ones I
> > > >> report here are.
> > > >>
> > > >> Let me know your thoughts.
> > > >
> > > > Adding in the eorfs and squashfs maintainers..
> > > >
> > > >>
> > > >> Best regards,
> > > >>              Jonathan
> > > >>
> > > >> On Fri, Feb 7, 2025 at 7:50=E2=80=AFAM Tom Rini <trini@konsulko.co=
m> wrote:
> > > >>
> > > >>> On Thu, Feb 06, 2025 at 07:47:54PM -0800, Jonathan Bar Or wrote:
> > > >>>
> > > >>>> Dear U-boot maintainers,
> > > >>>>
> > > >>>> What is the best way of reporting security vulnerabilities (memo=
ry
> > > >>>> corruption issues) to Das-U-Boot? Is there a PGP key I should be=
 using?
> > > >>>> I have 4 issues that I think are worth fixing (with very easy fi=
xes).
> > > >>>>
> > > >>>> Best regards,
> > > >>>>              Jonathan
> > > >>>
> > > >>> Hey. As per https://docs.u-boot.org/en/latest/develop/security.ht=
ml
> > > >>> please post them to the list in public. If you have possible solu=
tions
> > > >>> for them as well that's even better. Thanks!
> > > >>>
> > > >>> --
> > > >>> Tom
> > > >>>
> > > >
> > > >> Filesystem-based Das-U-Boot issues.
> > > >>
> > > >> =3D=3D erofs
> > > >>
> > > >> =3D=3D=3D Integer overflow leading to buffer overflow in symlink r=
esolution
> > > >> In file `fs.c`, when resolving symlinks, the function `erofs_off_t=
` gets an `erofs_inode` argument and performs a lookup on the symlink.
> > > >> The function blindly trusts the `i_size` member of the input as su=
ch:
> > > >>
> > > >> ```c
> > > >>      size_t len =3D vi->i_size;
> > > >>      char *target;
> > > >>      int err;
> > > >>
> > > >>      target =3D malloc(len + 1);
> > > >>      if (!target)
> > > >>              return -ENOMEM;
> > > >>      target[len] =3D '\0';
> > > >>
> > > >>      err =3D erofs_pread(vi, target, len, 0);
> > > >>      if (err)
> > > >>              goto err_out;
> > > >> ```
> > > >>
> > > >> The `erofs_inode` structure's `i_size` member is defined with the =
type `erofs_off_t` (which is a 64-bit unsigned integer).
> > > >> Thereofre, if supplied as 0xFFFFFFFFFFFFFFFF, the `len + 1` input =
to `malloc` would overflow to 0, allocating a chunk with 0.
> > > >> That chunk (saved in `target`) is later written with `erofs_pread`=
, overriding the chunk with partial data controlled by an attacker.
> > > >> Therefore, we will have a heap buffer overflow due to an integer o=
verflow in `len` calculation.
> > >
> > > Yeah, it's a corner case, I will try to address it later.
> > >
> > > Thanks,
> > > Gao Xiang
>
> --
> Tom
