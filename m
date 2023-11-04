Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A605C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 19:45:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42DC5870B3;
	Sat,  4 Nov 2023 20:44:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g24op28y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDBE386EEE; Sat,  4 Nov 2023 20:43:57 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 221378712E
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:43:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53e04b17132so5167950a12.0
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 12:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699127032; x=1699731832; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YCoLj9bvOdS97FReR22SF/sNnPJz6koGSIM3juM6tNA=;
 b=g24op28yOuP6oHRBTuXtrtCiHJD6YqZZ55Z/f5OPcWmt9pRK36cB10Clbn+nD+fUmB
 sDAFvGToRrqdAqbpvraYqpTv7BbuvVzLSoF4f6zckaRHf95y8UXimza8gTqcCj77IhAt
 MrA4raUsY4EQ5+/c3KNQ6fwEz7yw40W+iLtv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699127032; x=1699731832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YCoLj9bvOdS97FReR22SF/sNnPJz6koGSIM3juM6tNA=;
 b=NeQB+2Ig4TcXDfEV4GADwDfrLVa+LkJkkGiCVi7A48WOaK9T01mm2KZh4Ah2NmR9Ju
 F/SV9IXHpu2DYF9V2fW8fK87YhBvNE1A7+i6bcp1AMzMSSsC+h2k7obte9FFtrhCOYF8
 wVotuGWbBiM0oE4DkjmY2bhFssmQkLX2BBdhFt5O0E5/MYeO38NDz2xAsmWa236F+/I+
 ncm4+c0i9sQz1N+8zCEn5U6g1wyrKwPPsDXo6N1r/8tvwfI8RF4hvszmXc2Tz/cpDghG
 5+5QH8DW5jux9bCzTVTpoxmEXiyhZd+M4d4g0CTDWJ7MH/TQyEjUWk62dQy/l5eP7HKr
 LZtg==
X-Gm-Message-State: AOJu0YzOgqmJJkU1NeSkO0rN7MlCbLjd1J1TXjIgDwXHdo4EZXfOgdeq
 oNoN2E3TCY85np2iLdxajpVnGZZ3Mh+G/m57iqSFZw==
X-Google-Smtp-Source: AGHT+IF37tMFsoyKKtoQpG6ClLwH3KUVuQbKSZRcr+3ABQf7xRBbjLdfIYOy3NhCM9CFKmrJ6JySPDiOR5VBem4J4Rs=
X-Received: by 2002:a05:6402:b6c:b0:53f:8ef:1b22 with SMTP id
 cb12-20020a0564020b6c00b0053f08ef1b22mr18980637edb.2.1699127031660; Sat, 04
 Nov 2023 12:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-2-rasmus.villemoes@prevas.dk>
 <6ac71b7e-d84e-10d5-e500-0d54e5d6c191@gmail.com>
 <3fd4d611-891a-fc3d-7385-c2d621cf2eac@prevas.dk>
 <8d3ef056-1d72-727f-f158-f034c34d5786@gmail.com>
In-Reply-To: <8d3ef056-1d72-727f-f158-f034c34d5786@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 4 Nov 2023 19:43:40 +0000
Message-ID: <CAPnjgZ1kFjsZ96fkOu9KgOMiSG8W_YcO7ERJcRtdD1OOkPYY5A@mail.gmail.com>
Subject: Re: [PATCH 1/4] mkimage: also honour -B even without external data
To: Sean Anderson <seanga2@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
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

Hi Rasmus,

On Fri, 29 Sept 2023 at 07:16, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 9/28/23 03:10, Rasmus Villemoes wrote:
> > On 27/09/2023 21.02, Sean Anderson wrote:
> >> On 9/19/23 07:37, Rasmus Villemoes wrote:
> >>> In some cases, using the "external data" feature is impossible or
> >>> undesirable, but one may still want (or need) the FIT image to have a
> >>> certain alignment. Also, given the current 'mkimage -h' output,
> >>>
> >>>     -B =3D> align size in hex for FIT structure and header
> >>>
> >>> it is quite unexpected for -B to be effectively ignored without -E.
> >>
> >> FWIW, this behavior is documented in doc/mkimage.1 (which should also =
be
> >> updated if this behavior is implemented):
> >>
> >> | The alignment, in hexadecimal, that external data will be aligned to=
.
> >> | This option only has an effect when -E is specified.
> >
> > I'll send a follow-up to fix that, thanks.
> >
> >> And, for additional context, the documentation for -E is
> >>
> >> | After processing, move the image data outside the FIT and store a da=
ta
> >> | offset in the FIT. Images will be placed one after the other
> >> | immediately after the FIT, with each one aligned to a 4-byte boundar=
y.
> >> | The existing =E2=80=98data=E2=80=99 property in each image will be r=
eplaced with
> >> | =E2=80=98data-offset=E2=80=99 and =E2=80=98data-size=E2=80=99 proper=
ties. A =E2=80=98data-offset=E2=80=99 of 0
> >> | indicates that it starts in the first (4-byte-aligned) byte after th=
e
> >> | FIT.
> >>
> >> Based on this documentation and my understanding of the code as-is, -B
> >> controls the alignment of the images themselves,
> >
> > Yes, when -E is in effect. My patch does not affect the case where -E i=
s
> > present.
>
> Wherever possible, flags should be orthogonal. That is, they should have =
the
> same effect (or at least the same spirit) regardless of the presence of o=
ther
> flags. This matches their UX, as orthogonally selectable options.
>
> >> not the size multiple of the FIT.
> >
> > It is _also_ that, but mostly as a "necessary side effect" of getting
> > the first image aligned. In order to achieve the desired alignment of
> > the first external image, the FIT structure itself is aligned to the -B
> > value, and each image's size similarly aligned up to that value so the
> > next image ends on a -B multiple again. So with both -E and -B, the FIT
> > structure itself is indeed also padded to the -B value, as the `mkimage
> > -h` output suggests.
>
> The intent of -B is to align images. That the FIT itself is padded is an
> implementation detail.
>
> > What I want, and expected from `mkimage -h`, is to make the whole FIT
> > have a certain size multiple, without using -E, so in that case the
> > alignment of the FIT is the primary goal.
>
> Why does mkimage have to do this? Can't you just use truncate or, in a
> binman context, align-size?
>
> >> However, from what I can tell, this patch does not actually
> >> affect the alignment of the images,
> >
> > No, because the images are (still) embedded within the FIT as ordinary
> > values of the data=3D properties, and it's a basic property of the DTB
> > format that those are always 4-byte aligned, and you can't (easily)
> > change that [1]. Which, I suppose, is one of the reasons U-Boot invente=
d
> > the "external data" mechanism - so for example the .dtbs embedded in th=
e
> > FIT can all be guaranteed to be on an 8-byte boundary, and thus the
> > selected one can be used in-place when passed to linux.
> >
> >> but rather adjusts the size of the
> >> overall FIT to a certain alignment. I find this rather unexpected.
> >
> > Well, as I said, _I_ was surprised by -B having no effect based on the
> > `mkimage -h` output, so the two sources of documentation were not in
> > sync. The man page was/is correct wrt. the actual code.
>
> The mkimage -h putput is too terse to record the complete behavior of
> each option. Perhaps we should add a warning when -B is specified without
> -E.
>
> > Rasmus
> >
> > [1] There's a nop tag one can insert, and I think I saw somebody
> > actually suggesting to do that to align the embedded data=3D properties=
,
> > but it's quite error-prone and inflexible, as any subsequent
> > modification of the .dtb before that property will ruin the alignment.
>
> This would indeed be the way to go. I don't think we should worry about
> further modification of the fdt, as this could also ruin the alignment
> of external images.

Are you planning a new version of this series?

Regards,
Simon
