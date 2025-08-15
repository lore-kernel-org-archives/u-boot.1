Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC4DCA0ED1
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 16:53:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C0CA80194;
	Fri, 15 Aug 2025 18:53:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="j3ijLA+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7452F803DF; Fri, 15 Aug 2025 18:53:29 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B80180107
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 18:53:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-61bd4a7b02fso1208513eaf.0
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 09:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1755276805; x=1755881605; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dZexm2w9sL2UyC3J9aiu4UB9lSyBs4J9yUkdQWPuP10=;
 b=j3ijLA+p/2P0h0dwAdbJKui3yQg1dw4qbD2zzC+OzzN4Pi0P1Y9Fxc89D+ZeaQE1fd
 JzfnSsAj3XQalM+lwuybN2cxf7fTU6/yEqWNl93rTVqF1WeqyayVVjXMYOWDPaTy49id
 zLBrkmAlDia+jVqQCYNIyHRQ4iK9+cVdPvf1ov9avBa4mjWgznmeMxHBy0XLcY75xbvQ
 KEhIO3nvmMbQNGqgxMs7koy/wSKZoI4fbOqtnw9+r6sJS0W5BZ3FbbHmXTfGgZ0q1Ej2
 YCqyGJ8qsazr5gVuFDlvTmL8F1E75Q2zpc2FxPsIChqpMMHGGXhbdUQ1BRqLxFClT7+n
 3j2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755276805; x=1755881605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dZexm2w9sL2UyC3J9aiu4UB9lSyBs4J9yUkdQWPuP10=;
 b=YjXI7KKopSAxTwcdAwdKo2ZpkE4/XWglwO5zh/L91LK8Fvd8R6e1C4tYl1g7M27QYh
 huw5Hr5XqvDu12zyl9+Xi0BXv4+m7eqwL18RFQIpsnyj8j/HtZ+A1E19Rp+5MqaQl3pA
 JuGg9jD1qyw++nvMyGDtIMV0QpZTgZXLBFrYjJSm8xqMbFVFwbn0nimrd8BbQnnLUIDU
 /xKN9SHjDkX5cPcOdcaUQ5s5MfiOrZ4gVdQMCJfkh+9HT3zJbZuY0gTcfpasgngb5DvA
 NcK6y/zsd1vyZmQY1fDEdnN6EaWk6haOQv/jzFZWtNmPC+bhu+RHbZbryECaH4/WSs3G
 cErQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5RftTFJzf+rR3fkvKMHIEgaFzT6dAQZ2Njr7FeyMDcez95fra9qqXHGUZYx861z6uW0NC0Q4=@lists.denx.de
X-Gm-Message-State: AOJu0YwBN6VxgEzefkGH5XE74wO4bPkNl9Xn71xjQiTJrT70Lj56Ib52
 NqFioDZjzbRd86hxhq+g4Hpx6TOIswgI5onadq56/Vzrl0xpJO7cin4zTZA2EB7YDlwlFcZUzJu
 bJ9+2Zw7dw9xzFf42VjlXHmwBS9AdppVnaoMv+Lfu9A==
X-Gm-Gg: ASbGncsZCVii9aU3gy1gVzrd26FrUvsJzYWTSHMJDLE/GqyWqeenARjpdoh+Fd1RGJ3
 yXgHJGuhDmm0qaCTNV9o8u4yJ5cG6eNldfs95klsra7ROqnPuIkEjY8DrCpcpJ1ScuOfplA9M14
 Si7BRicznY0Z4wJT+vwf0H/4921BPPso3/zGimqBtzdHOZOxVvQWjz885KVWM99k00xWx0P6t9J
 QV9dzgXUd3ZW9eddA==
X-Google-Smtp-Source: AGHT+IGRQoL9ROQeT8ibI2wyezCzgrAHCRtStYGDcEVCTUlpdQvb7fbft89IFua3DUG1yDQqiDdPXzwiv/p4AFoHiD0=
X-Received: by 2002:a05:6820:1b84:b0:61b:d431:ac96 with SMTP id
 006d021491bc7-61bea7294bamr1754738eaf.2.1755276805218; Fri, 15 Aug 2025
 09:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250613-binman_faked_optional-v3-0-1e23dd7c41a2@phytec.de>
 <175096060477.1879961.6525302263431603846.b4-ty@konsulko.com>
 <CAJ+vNU1c6RchWTjX+A1dUi-WQ+m-60QacY+-dA5ScodFsc95_A@mail.gmail.com>
 <e22d803c78a0e02747be94bac23f02da37bc13fa.camel@phytec.de>
 <5afb0dd2ffa60298890a9778a5e44047a5e39753.camel@phytec.de>
In-Reply-To: <5afb0dd2ffa60298890a9778a5e44047a5e39753.camel@phytec.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 15 Aug 2025 09:53:13 -0700
X-Gm-Features: Ac12FXzcdNUeSHlnK8frhwAajDqFOFsUlF-Y43hF7BKSDK0yk8ljihq87W6F3cQ
Message-ID: <CAJ+vNU2VGS10BwgQEeTOPrmw83OxBV-W6nsvd2w7VwkfFH2SmQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Fix handling of optional blobs in binman
To: Yannic Moog <Y.Moog@phytec.de>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
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

On Thu, Aug 14, 2025 at 11:46=E2=80=AFPM Yannic Moog <Y.Moog@phytec.de> wro=
te:
>
> Am Freitag, dem 15.08.2025 um 05:44 +0000 schrieb Yannic Moog:
> > Hi Tim,
> >
> > Am Donnerstag, dem 14.08.2025 um 12:54 -0700 schrieb Tim Harvey:
> > > On Thu, Jun 26, 2025 at 10:57=E2=80=AFAM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Fri, 13 Jun 2025 14:02:39 +0200, Yannic Moog wrote:
> > > >
> > > > > This series solves a contradiction regarding ext blobs packaged i=
n
> > > > > binman. When they are marked as optional, by default they are fak=
ed, two
> > > > > messages are emitted. One says the image is not functional the ot=
her
> > > > > says the image is still functional. Both concern the same binman
> > > > > entry/blob.
> > > > >
> > > > > Binman is set up to have fake external blobs in case they are mis=
sing.
> > > > > This is regardless on whether they are optional or not.
> > > > > The implementation does not allow different types of entries to o=
verride
> > > > > the faking decision; at least there wouldn't be much sense in doi=
ng so.
> > > > >
> > > > > [...]
> > > >
> > > > Applied to u-boot/next, thanks!
> > > >
> > > > [1/6] binman: drop "faked" return value from check_fake_fname
> > > >       commit: a657d87f08789c4c50423897bd5ee052c6223ee6
> > > > [2/6] binman: mark optional missing blobs as absent
> > > >       commit: 3ae668b9d2101d111d257ee7d8912c19cfb0e102
> > > > [3/6] binman: rework dropping absent entries from packaged image
> > > >       commit: 21bc3433a43d3add3430543c9eee2a95d4dee2f6
> > > > [4/6] binman: add faked optional entry case in CheckForProblems
> > > >       commit: f5817e05efd39dd455c2e6a0f0622d709fe7ea2d
> > > > [5/6] binman: ftest: pass allow_fake_blob to _DoReadFileDtb
> > > >       commit: e749d64b4622806072c56a839cf9a36a5081b575
> > > > [6/6] binman: test: assert optional blobs don't cause non-functiona=
lity
> > > >       commit: 0dbb0a8d1f2aefb2a7fdd8e627edd955e4fe8d3a
> > > > --
> > > > Tom
> > > >
> > > >
> > >
> > > Hi Yannic,
> > >
> > > I haven't had time to dig into it in detail yet but it looks like
> > > imx8m boards are failing again in master due to tee changes again and
> > > perhaps its this series that is causing it.
> >
> > Thanks for reporting,
> >
> > >
> > > Here's what I see with today's mater:
> > > make imx8mm_evk_defconfig
> > > make
> > > ...
> > >   BINMAN  .binman_stamp
> > > Image 'image' is missing optional external blobs but is still functio=
nal:
> > > tee-
> > > os
> > >
> > > binman: module 'importlib.resources' has no attribute 'files'
> > > make: *** [Makefile:1339: .binman_stamp] Error 1
> > >
> > > I thought I had read something about a warning that wasn't an error
> > > but above is clearly a build failure.
> > >
> > > Am I missing something here?
> >
> > My initial gut feeling says it could be related to this series:
> > https://lore.kernel.org/u-boot/20250701-pkg_resoures-removal-v3-1-27018=
8b335ae@phytec.de/
> >
> > Maybe the combination of the 2 series causes this. Anyway, I'll investi=
gate
> > and
> > report back.
>
> So the error you are seeing is encountered here:
> https://github.com/u-boot/u-boot/blob/0c558bbad9e7581808b358091d1fd979f86=
0e8ac/tools/binman/control.py#L98
>
> This is indeed caused by the patch I linked above.
> When writing the patch (i.e. following the migration guide) I foolishly
> overlooked the fact that importlib.resources.files was only introduced in=
 python
> 3.9, yet we support >=3D3.7.
>
> I remember you use python 3.8, so that is why you see the error (and I do=
n't).

Hi Yannic,

I confirmed via docker containers that ubuntu-noble 24.04 (python
3.12.3) and ubuntu-jammy 22.04.04 (python 3.10.12) build ok and that
ubuntu-focal 20.04.6 (python 3.8.10) which I was using fails.

I recall Tom saying we should aim for supporting Python 3.7+

>
> I believe I need some help on finding a good solution.
> For this diff
>
> -    glob_list =3D pkg_resources.resource_listdir(__name__, 'etype')
> -    glob_list =3D [fname for fname in glob_list if fname.endswith('.py')=
]
> +    entries =3D importlib_resources.files(__package__).joinpath('etype')
> +    glob_list =3D [entry.name for entry in entries.iterdir()
> +                 if entry.name.endswith('.py') and entry.is_file()]
>
> I haven't found a good replacement that is python 3.7 compatible.
> Any ideas?

Sorry, I haven't embraced the snake.

I guess I should update my build system to stop hitting this stuff :)

Best Regards,

Tim
