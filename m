Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6C7F94CC0
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 03:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A01183936;
	Wed, 22 Apr 2026 05:13:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ORiXmwcC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74F5284198; Wed, 22 Apr 2026 05:13:17 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48B978352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 05:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso4753942a34.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 20:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776827594; cv=none;
 d=google.com; s=arc-20240605;
 b=I1DyNUhFdhOI6EsVGALiCNx/fFMavMdGmIgRbhbvmaJXzte2+qCXAHIVzY2DvCnWV8
 Wu7/pobwcOqfhfs8ort+NFlWA1NQZKBE3zKgiPSlWfWf9PRgxa3+F3EU5Bsri0R+ZGkt
 DjgVLTcs8h+st68Yc4TJrjOiJjh9iPOBcoOQP0wRoh+gqquG7szly6z+mtkd1n6LJsRe
 dh3Ynj8V6yseK34/VeNZZydZ0bGDc8/28lXQ3iaaGiJFxrOoEglHq3iduWgsBG3dZLFP
 0iw70HrWIOH578iKIs3aYcPzTz23iqlj98I9LQBKtghaI9WcR2HKMCZzOuwIzlMOC7zH
 G76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HVVC0qLH7g9+gqfB8kwnvICXBTbSWYRu0cCM7P826NI=;
 fh=XmvCthC/BjXYU0ZrHKfxQew09xn0WtefmKj6MWJpbfI=;
 b=isQe8kitk9gNV78hAK0n2ncPyERhFv2Gm0Z+IbptLYiH9vWCFj6aJSCjzgnI45MLBh
 5dOTL/1DnduR6WchyLlYS+Ppk6bFSCrS3cgN1ib1eOej8CCVZdXEn0reVaNrReMWhJ4x
 Nb6dEf/8ZeKUWrqBQylC0bI9fca5wTacyyPU+lUJzaV9A9uNFKctVmm487rrE1sm7E6y
 dR3Y7ziwZwQfm87OGPwZrPlOGn9QwIX1/0OK4LbTRB8RbXHIzsLn8WwtvggeJ2ZoU4Nr
 o4/S1UYLX7FatyF0rn9fq9Dm9qoHgZSzLPoRdeMoOpIOCYlooAOJdomGtPz6bbeSrlu6
 CLRQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776827594; x=1777432394; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HVVC0qLH7g9+gqfB8kwnvICXBTbSWYRu0cCM7P826NI=;
 b=ORiXmwcCaWI9TH855ShOLgWahvHDYHVYJtyZO7Oha5uqSeZwRTWIR8v6BKLupHK9m5
 0DeYRo1OBRoIzzdZxdNYldKd5mkqHZKnfR3PZ1mOKxN7b6QR2qh5wnpGFN5/EJxIF7SO
 36pnXpTu6fos5H1rEpoU8J+CA/FA3fMr+qn7rqkFFNNTjxal723pekRVpkgWRc5aoJv8
 8Vz2EhT7qGqjpQRWQE05sslWfc2eQiMs56+JjPGLsTDcCdzAjXCaIElDLXty2yzyJOin
 t7OaoCPR/X/nOj1z2Y0DlGySrRe1QdvmSwsimBkKjF+5ty8tVaf6VDd36KinXGKXzAZg
 I23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776827594; x=1777432394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HVVC0qLH7g9+gqfB8kwnvICXBTbSWYRu0cCM7P826NI=;
 b=QjQxu3VhsM1tS8Ts1SGp9/cr6zUQ8DGa8eWVS9sCfomzBsqKgf2+GL9DmEH51VTkAo
 NkFnMsBz6S7V5JPZ2+wgXNhW+WGVWerU6TWH9h1xQxN9YAcoR+5jjMqdpgAVqpTOTrc8
 vbNwf1gsQ+FQnjHEmXRI5JYhU0ytRlp80PrLOdPBXuYdgk9UUtQcfG+f82tQsdBb38ZS
 K+hxxD3pXzZYMc0qBHX2h+qh9oE40ENKiCHqOy3Suwi+7zyuCKQVJ/k1iUPm18qmaRKI
 mmbxkc9hl8dFvH8tepb+jz5ledKJV1z3U4ECSc79OK8h5XVzq/XswcFBuT7UWewgyg+O
 TRPg==
X-Gm-Message-State: AOJu0YwU+IHwMpJ/L4DywOskgT6nGwS64GgwYxb+/erRkg3qC0bYnYEJ
 tk/PjuSgrTM6tfD5Oh0jjovqaew8wxs05jMlBO7oJR8gG/J52rmUtLgtRifVGc7E8UdkYjOVxSi
 pKUl5/r3P6eFHs2UzrMThihRGO50IQMK1rvPIS6Tvsg==
X-Gm-Gg: AeBDieseuOP9AQHxIxrrf9eSYS9lbmu9kBLxOPNHj+IB9LYr94piM4dtcceGnT1TAWz
 loX43w5VjBADfZeMj/nnqgU2pgXgTTqKezAXsTcIBrdqf/smURjDMfPkU37E5QHXoBA75q1WQXk
 GNSfisH5Yln0hf1fiEhSB6KNaJRTJrV6GO+sl49i+/OWh6/nV2DHC/zPKfkLqJ98bXTpf3yD68L
 Yup+qljWfuJYHEKV4NM77P+90eoNSAEjkowx/s38zwQYStFOgVaYAajWJSv8AQRb+l+gz7EkHnm
 x+1O2QsTa1JzoTJR1g==
X-Received: by 2002:a05:6830:264a:b0:7d9:ad90:5670 with SMTP id
 46e09a7af769-7dc9518c0f3mr14930333a34.18.1776827593834; Tue, 21 Apr 2026
 20:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260421004719.73491-1-briansune@gmail.com>
 <CAFLszTjJOfcddrdbN7oMPGAVZJRmj689-1bN5bY2gGiFdc=RGg@mail.gmail.com>
In-Reply-To: <CAFLszTjJOfcddrdbN7oMPGAVZJRmj689-1bN5bY2gGiFdc=RGg@mail.gmail.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 22 Apr 2026 11:13:02 +0800
X-Gm-Features: AQROBzCw14rY7143LDlkqgHe3RfJMRZUhvGTn8oQuL4A_mnapEhuGTDLtMRINtM
Message-ID: <CAN7C2SAJYbMFmRorV7w6XphPh24iuTTeobW6q66Dk9_q1s61jg@mail.gmail.com>
Subject: Re: [PATCH v4] Improve handoff prepare on SoCFPGA
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Chee Tien Fong <tien.fong.chee@altera.com>
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

On Wed, Apr 22, 2026 at 10:54=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Brian,
>
> On 2026-04-21T00:47:19, Sune Brian <briansune@gmail.com> wrote:
> > Improve handoff prepare on SoCFPGA
> >
> > There are some cases that the Python scripts
> > are run and the qts files are not replaced.
> >
> > This patch introduces:
> > 1) TMP folder for Python script
> > 2) TMP folder will automatically remove on exit
> > 3) If PY script fails, the replace will not conduct.
> > 4) Only when PY script passed the replace with keep
> > or without keep will be done via NEW HANDOFF_KEEP=3Dxxx
> > 5) When keep is selected the old files are renamed to
> > xxx.h.handoff.<timestamp>
> >
> > As such this ensure qts folder h files are properly
> > updated.
> >
> > Signed-off-by: Brian Sune <briansune@gmail.com>
> >
> > arch/arm/mach-socfpga/config.mk | 27 ++++++++++++++++++++++++---
> >  1 file changed, 24 insertions(+), 3 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Some thoughts though.
>

Hi Simon.

> We try to add a change log for each revision and use imperative
> present tense (Introduce a temp folder... rather than This patch
> introduces...). Spell out Python script rather than PY script, and
> reword as prose or a bullet list instead of 1), 2), ... You could also
> explain *why* the qts files were sometimes not being replaced - the

Because it is not fully traceable, git pull sometimes could introduce
some kind of unknown cases that even run make prepare will not update
the h files or the python script itself does not fully replace it from
first place.
So the easiest way to play safe in any possible condition is
[remove and replace] or simply [rename and create].

And I don't even fully confirm the cases, while this patch does improve
the previous .mk operation no matter if it is solving the unreplacing issue
or not.

So the motivation was explained from the title itself.

> motivation paragraph currently just says some cases without saying
> what goes wrong.
>
> The message says kept files are renamed to xxx.h.handoff.<timestamp>
> but the code uses .h.handoff_backup.<timestamp> - they should match.

That my mistake on the description, indeed it should be
.h.handoff_backup.<timestamp>

The idea just follows T.F. previous optional idea so I don't fully pay atte=
ntion
to the wordings.

>
> > diff --git a/arch/arm/mach-socfpga/config.mk b/arch/arm/mach-socfpga/co=
nfig.mk
> > @@ -43,6 +43,27 @@ socfpga_g5_handoff_prepare:
> > +                     if [ -n '$${HANDOFF_KEEP+x}' ] && [ '$${HANDOFF_K=
EEP:-1}' !=3D '0' ]; then \
>
> How about:
>

No I don't like this because you ignored my original idea on:
1) HANDOFF_KEEP=3D should run keep
because HANDOFF_KEEP cannot without =3D in .mk usage
2) When users use this flag, hence,  it is telling that they want to
keep the thingy.
So it makes no sense to =3D1 or =3D0 to further control it from first place=
.
This flag is inherently boolean logic.
But due to your suggestion I further elaborated this boolean flag to
support =3D0 or =3D1 or =3Dx cases.

Sorry for this part, I will not change.

Cheers,
Brian

> if [ '$${HANDOFF_KEEP:-0}' !=3D '0' ] ; then \
>
> Regards,
> Simon
