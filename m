Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE791C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 16:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E484A88307;
	Tue, 18 Jun 2024 18:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="Ingxgl+f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F69E8824C; Tue, 18 Jun 2024 18:46:09 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD5788307
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 18:46:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6f1da33826so784637066b.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1718729165; x=1719333965; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8E/YPFtarOQhyyy0HibvZxLFrFBG+n1PIJt1DVWOG28=;
 b=Ingxgl+fZTmgyqsy+qvA7gg494s9ecUK2hZjkrsaR2HPzg6IwSsvhfL09Cy8nQOavn
 j8EipnRrl7m3NbB3Ug7jlziQWtUVzqzlXO+rQi1ZKHz2AL6uQ9W5jfp4Z7GndgLrmLd8
 Da12xL/kxMY/b+6De9ub21fasbeBaS7QHp5Wl0VUhx6CEgqSAtGABtSv9e9CdiTiqmtg
 KiyWYOJTMqaIRaoo0rOez/tohpDcZfMLwHbIlYN7d/b5mAqNs0HBiqajMdjJBDLPeMOy
 n4kXme51Qv2iGct25OkJRj5y9SHeamhqn6xJ3KZi6hvb0AXouz5eV5xDBmJ9EOookXA9
 SyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718729165; x=1719333965;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8E/YPFtarOQhyyy0HibvZxLFrFBG+n1PIJt1DVWOG28=;
 b=qZpyctwDCAWTXU2sVeEYy9DF7N+1LqraTZ4sQ/aSAtqXUeDhUg8yUdjDngYJVDa1xQ
 skQvkrcS3QpGarvkiQkeV1f4Lma00AJYnErxv+Da4BsiQddI77Cx5Vh25GS2OsVZOJs/
 8q0UJ3XNzwKb/lqvVWfkseMR0SZO1TuqPmpfxS2+6nNjVA+lCM1OcqvgDxGEYooQtMUu
 paQ5ENWZKCCmQ4oPx/m7jrnW/FcFwokLUefl3o6ISVRXyL3U2X7wrYtsSC3q/oyG2S/h
 sbha77PJCUkoYJyETFk800P7bBb+8QaPYSOvBAfV7uOHiuFE6QSFVuC8lWyax+tujiHm
 /fjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRkHi+mtnTdSCjC+eHvSud3hdtHWDn6qiLFJpmhgSBW5DrMjdBFc5UV1Z54a52G+78OoMdSgux+MHTaCyZPSXSz7dbXQ==
X-Gm-Message-State: AOJu0YwfglL4mbwQsZP9S/6BRVVhb0zVjnnjV/3AzCbdnaWzv4BGIHhP
 GprxMMIlhMlWye5nE87L3iZ8omclghi3uZsIKepmor4vOlxQ/nQRHsv+2H0122POKBpNVrKmb3u
 jC9rc1JJ//3x4b80NRcuw1wjgbPf//rYkciuZmA==
X-Google-Smtp-Source: AGHT+IGEZiI99JLP6YLER4j2qwFiy+EDdr4c3paHKPab+d6wxucrVrDY9iSmaZ91JeGDUpoKxt933PGvmFuKCHxcGpw=
X-Received: by 2002:a17:906:f759:b0:a6f:796d:c741 with SMTP id
 a640c23a62f3a-a6fab60a13bmr5592366b.10.1718729164271; Tue, 18 Jun 2024
 09:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240617191416.1351790-1-tharvey@gateworks.com>
 <20240617191416.1351790-5-tharvey@gateworks.com>
 <626fe70e-ff61-46f6-84de-e9b8486ac5ed@gmx.de>
 <CAJ+vNU3rtrGkL3gQwEZW0x=ivSPqv-jxsdUX59bCcYRofe7Wxw@mail.gmail.com>
In-Reply-To: <CAJ+vNU3rtrGkL3gQwEZW0x=ivSPqv-jxsdUX59bCcYRofe7Wxw@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 18 Jun 2024 09:45:53 -0700
Message-ID: <CAJ+vNU2KH8NgFkjWt5ZPKMauPjhLXwd-oNfGFy-+QHO6MWKARA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] test: cmd: fdt: fix chosen test for DM_RNG
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Akash Gajjar <gajjar04akash@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Tue, Jun 18, 2024 at 8:48=E2=80=AFAM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> On Tue, Jun 18, 2024 at 4:51=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@=
gmx.de> wrote:
> >
> > On 17.06.24 21:14, Tim Harvey wrote:
> > > Now that kaslr-seed is automatically added to the chosen node if DM_R=
NG
> > > is enabled, adjust the test to expect this.
> >
> > We need to check that if CONFIG_EFI_TCG2_PROTOCOL=3Dy no kaslr-seed nod=
e
> > is passed to EFI binaries.
> >
> > The right location for such a test is lib/efi_selftest/efi_selftest_tcg=
2.c.
> >
>
> Hi Heinrich,
>
> I see you sent a patch for that but I'm not understanding how that
> fits into the ut framework.
>
> > We need as similar check for CONFIG_MEASURED_BOOT=3Dy.
>
> Can you explain more please?
>
> Does this explain the CI failures I see here:
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D8721&view=3D=
logs&j=3D6ebe5bb0-481f-5026-b4e6-2d4192a94e80&t=3D66c5926e-2461-580f-927d-c=
0d0a6120549&l=3D539
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D8721&view=3D=
logs&j=3Da1270dec-081b-5c65-5cd5-5e915a842596&t=3D69f6cf72-86f3-551a-807d-f=
28f62a1426f&l=3D541
>
> I'm still trying to make sense of those.
>
> In order to test this locally I built for sandbox64_defconfig and ran
> "./u-boot -Dc 'ut fdt'" but it seems that doesn't cover enough cases.
>

I believe I understand the Azure pipeline failures now. I don't see
exactly where they pick a defconfig but the failed test cases are
under 'test.py for sandbox sandbox' and 'test.py for sandbox
sandbox_clang' which I've come to understand means they use
'sandbox_defconfig' which defines CONFIG_MEASURED_BOOT where
sandbox64_defconfig which I tested does not.

So I need to update the test to:
+       if (IS_ENABLED(CONFIG_DM_RNG) &&
+           !IS_ENABLED(CONFIG_MEASURED_BOOT) &&
+           !IS_ENABLED(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT))
+               ut_assert_nextlinen("\tkaslr-seed =3D ");

I've issued a PR for v7 to test via CI and will submit if all is well.

Best Regards,

Tim

> Best regards,
>
> Tim
>
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > Cc: Michal Simek <michal.simek@amd.com>
> > > Cc: Andy Yan <andy.yan@rock-chips.com>
> > > Cc: Akash Gajjar <gajjar04akash@gmail.com>
> > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> > > Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> > > Cc: Devarsh Thakkar <devarsht@ti.com>
> > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > Cc: Marek Vasut <marex@denx.de>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: Chris Morgan <macromorgan@hotmail.com>
> > > ---
> > > v6: new patch
> > > ---
> > >   test/cmd/fdt.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >
> > > diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> > > index 547085521758..537d8a338bbf 100644
> > > --- a/test/cmd/fdt.c
> > > +++ b/test/cmd/fdt.c
> > > @@ -1347,6 +1347,8 @@ static int fdt_test_chosen(struct unit_test_sta=
te *uts)
> > >       ut_assert_nextlinen("\tu-boot,version =3D "); /* Ignore the ver=
sion string */
> > >       if (env_bootargs)
> > >               ut_assert_nextline("\tbootargs =3D \"%s\";", env_bootar=
gs);
> > > +     if (CONFIG_IS_ENABLED(DM_RNG))
> > > +             ut_assert_nextlinen("\tkaslr-seed =3D ");
> > >       ut_assert_nextline("};");
> > >       ut_assertok(ut_check_console_end(uts));
> > >
> > > @@ -1363,6 +1365,8 @@ static int fdt_test_chosen(struct unit_test_sta=
te *uts)
> > >       ut_assert_nextlinen("\tu-boot,version =3D "); /* Ignore the ver=
sion string */
> > >       if (env_bootargs)
> > >               ut_assert_nextline("\tbootargs =3D \"%s\";", env_bootar=
gs);
> > > +     if (CONFIG_IS_ENABLED(DM_RNG))
> > > +             ut_assert_nextlinen("\tkaslr-seed =3D ");
> > >       ut_assert_nextline("};");
> > >       ut_assertok(ut_check_console_end(uts));
> > >
> >
