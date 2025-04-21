Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A7CC369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04AD280FEC;
	Mon, 21 Apr 2025 18:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T5MeFl9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ABA5815D1; Mon, 21 Apr 2025 18:18:39 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D1C980BA8
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 18:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72b82c8230aso1240739a34.2
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 09:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745252316; x=1745857116; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vvg1TByT1E3sMhegEhAfayIA4akwYUrriJ8eUJ3Wjtg=;
 b=T5MeFl9lUCnC+ERrhsYDOEPzz72seB0Sku9ffwpPd7bJFZ8LxtdL2z8D4/nNppthNb
 JVDK70QCLF/qsxfIfn9xooIJbX20q0AgZ3P+ADwcRT98LMEK+dZrJdp0yUPdo9FukINe
 SXjE3reYw6pCyswULumtRlVgxy7bPuwG3wIOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745252316; x=1745857116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vvg1TByT1E3sMhegEhAfayIA4akwYUrriJ8eUJ3Wjtg=;
 b=GyL53JldWuPA2YYIBWFPbetKNYI7dUePXQPdyEYSo3dr7gNUBDoJnivTcZG6Q0N4cm
 zpGpP3nHBiGk130O+7f4GfbBwclQtONiU3HZP50LpAZBOl3OF2wm4Qi/nN5hp/1igRq1
 qe/XYYseSvr7rGVQQDVmBaR0cEsX1vB9aOSDUvt5dNkxfEK4NIlpSCxbHh3XFnVpPya1
 Yyx0inFtEQl2uN7gv7OSBJAWH2K5BmW6Q3UprGzRAapMRmqJkPi9fnuHlbPlGvHmzinA
 mPV13jEbUhxWZRvzTSCzAUkcbGhjQKCvHzYVy8fdueAevsCS07bGjDJ8jJVsowY5baYQ
 YfRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwGq7Kqp6IJP/du0bbhdIANejzOUopbumX7DyXJblahoUJvgwFMZe+5EU2UM+vLOA9Pf+jx8s=@lists.denx.de
X-Gm-Message-State: AOJu0Yxxf5hf97H8GtRWHBhe8RfImeWj7+LVtI4dA/uQ6p6JJkdwgRsU
 H0PaPtIdiD8CchX/SZ9/ORgJA65AlmirnO40D41JXxRPHBKlwO9h8sLpVv3kbSQ=
X-Gm-Gg: ASbGncsCWrR3tOS/TkqHh4zBoxn1Su7l9B17EYqQv8NHXkIOhsAlgmUbw0oH5YlR1zV
 GexshopvWq/AvtuZtNDuL2OCu2u43f2+BMR6nsjEjR4j2D0Acln4Kvv7mDIWQLh0wL/ldZz0+Ou
 jbyOoxCr43+TCBnoHRLKQG/nf/hyA29YJTIf2u81C8jk4RJ4pXu6RKteRp5RB1172aVXmbBR1CB
 dJ+CUZUmmKiKNE1l1nnGV+HHIBLpaQiwEp9Vpfveg3UiHetAJdsRPreC79rnwyn3tRB3M/fTbsZ
 lGc6Rt5RcwaBtu++caHGRTrn6Sqq5z67NvVvcPiVeURy9WxUXPvXF86zUQYDUVjmhZkG7jjxEZF
 Gqw==
X-Google-Smtp-Source: AGHT+IFBaoqq9B/lmSg8xnutpA4Pfy9guodWvU4uQ0x25uXBj1XpYhgfF2qxR+NLRzZR88LwzBNbNw==
X-Received: by 2002:a05:6830:3c0f:b0:72b:9180:cc7e with SMTP id
 46e09a7af769-730061eac98mr7259427a34.4.1745252315635; 
 Mon, 21 Apr 2025 09:18:35 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-605ff6a9694sm1596038eaf.33.2025.04.21.09.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:18:34 -0700 (PDT)
Date: Mon, 21 Apr 2025 10:18:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 1/3] buildman: allow specifying configuration fragments
Message-ID: <20250421161831.GX5495@bill-the-cat>
References: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
 <20250416224032.144791-2-heinrich.schuchardt@canonical.com>
 <d8f9a58a-10cd-4366-bd6f-85f4effc747c@cherry.de>
 <CAFLszThDLbf3fQySO_8u6OD3-BK2abE6NFVhvviRtrNs=PKdsA@mail.gmail.com>
 <d448af91-ebe1-432c-ae20-3e8eb2efddf1@canonical.com>
 <CAFLszTh29kgQ_bE8_gnORWH0PQ=H94=q7757mFOfiopCUL3eTg@mail.gmail.com>
 <CAM=mAOnLTX3ZB6ioyPOoR+wyNKoA2VnxCKFMUHrZyM_wpuGzOA@mail.gmail.com>
 <CAFLszTinquyp9JW=Z+w6BFkGUy3sJJuJH_CfkOdEO0FvPteAbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FiJHDf4Am8F+i1Ta"
Content-Disposition: inline
In-Reply-To: <CAFLszTinquyp9JW=Z+w6BFkGUy3sJJuJH_CfkOdEO0FvPteAbg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--FiJHDf4Am8F+i1Ta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 09:31:19AM -0600, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Sat, 19 Apr 2025 at 13:22, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> >
> >
> > Simon Glass <sjg@chromium.org> schrieb am Sa., 19. Apr. 2025, 16:14:
> >>
> >> Hi Heinrich,
> >>
> >> On Sat, 19 Apr 2025 at 04:20, Heinrich Schuchardt
> >> <heinrich.schuchardt@canonical.com> wrote:
> >> >
> >> > On 4/18/25 13:39, Simon Glass wrote:
> >> > > Hi Quentin,
> >> > >
> >> > > On Fri, 18 Apr 2025 at 05:27, Quentin Schulz <quentin.schulz@cherr=
y.de> wrote:
> >> > >>
> >> > >> Hi Heinrich,
> >> > >>
> >> > >> On 4/17/25 12:40 AM, Heinrich Schuchardt wrote:
> >> > >>> Currently we are no able to build with configuration fragments i=
n our CI.
> >> > >>> With this patch buildman gets a new argument --fragments for pas=
sing a
> >> > >>> comma separated list of configuration fragments to add to the bo=
ard
> >> > >>> defconfigs, e.g.
> >> > >>>
> >> > >>>       tools/buildman/buildman \
> >> > >>>       -o build \
> >> > >>>       -k qemu-riscv64_smode \
> >> > >>>       --fragments acpi.config
> >> > >>>
> >> > >>
> >> > >> What about using:
> >> > >>
> >> > >> --fragment acpi.config --fragment fragment2.config
> >> > >>
> >> > >> ?
> >> > >
> >> > > Yes that could be useful. It would also allow wildcards, although =
the
> >> > > code would need to drop the config/ directory prefix. Also, I see =
that
> >> > > -z is available so perhaps that could be a (bad) short option?
> >> >
> >> > Hello Simon,
> >> >
> >> > What do you mean by useful?
> >> >
> >> > --fragments a,b conveys the same information as --fragment a --fragm=
ent b.
> >> >
> >> > We are not passing any config/ directory with the fragment names.
> >> >
> >> > Using wildcards in does not depend on how fragment names are passed.
> >> >
> >> > As maintainer of buildman, please, clearly express how you want the
> >> > fragment names to be passed. "Could be useful" does not indicate any
> >> > decision but let's me hang in limbo.
> >>
> >> NAK
> >>
> >> We need a file which lists the valid boards for each config fragment.
> >> Buildman should parse that and it should be possible (with an argument
> >> like --build-all-fragments) to build all fragments for a board (or all
> >> boards), to make sure that things actually build. See [1]
> >>
> >> So until that is done I'm going to NAK the whole concept[2].
> >
> >
> > Building all possible permutations can easily result in excessive numbe=
rs of CI builds.
> >
> > We have been breaking ACPI builds multiple times and now you block test=
ing.
> >
> > I am not amused.
>=20
> I'm happy to discuss the merits of both approaches, but remember, I am
> your mirror. So if you can be flexible, so can I. Maybe Tom might put
> up with having a file? We only need to list the combinations we want
> to test in CI.

I wish you paid more attention to the mailing lists sometimes Simon.
What we have today for fragments is me having compromised 2 or 3 times
already (and the problems they've caused weren't ones I would have
predicted). But no, what you want is just wrong on so many levels.

And frankly, I think Heinrich's approach shows the problem with using
fragments in some cases. This should have been some defconfigs to start
with. But I'm willing to compromise, again, and take adding some special
build jobs to CI (which slows down the pipelines, as there's non-trivial
constant time bring-up/tear down and we have a hard limit of 10
concurrent Azure jobs) and more arguments for buildman because maybe
there's a use case for fragments as arguments I'm not seeing.

--=20
Tom

--FiJHDf4Am8F+i1Ta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgGb9MACgkQFHw5/5Y0
tywhZQv/dJhpzFWUwuTxqjAWHiiqiHOL6LQWf+5FoYlpPw+7qx6jh7x5lf4lZPi5
HK5pCIgkXA/1t4ngip6vyKkUY7TS1Nzy/SgkChsMbrgAiNxLXKGordCKRZ231K4q
i9rf920A07DoYD2TqXzXsLpxQN+NnyQzdGDQNhJ9QyLchy+Pzbpn1ErSMuCpFGka
SBSz93mq/5xVajaodhnEe8zhu4SMqfgegBESbxPByupKnVN9Ujt/sms/ct1THG6j
BcgIR3bsEw92OlMlRMCB0FGAeDAWDPVqi76asiU6s8DTG50/QetgEELvm1lj8gAw
MqTah4fW0XL480ynOR+am/M6BJqo6d3UQbDLdKFwoFRbrCbrQHYf9rgCeAPajgvd
ZeAu18NZQqC2EGpEXfoN5K2pNCM1AoUD1urXXSSQ/WPxZqn+ZSLA4VY5/UnQwwYl
A2HlB++pGTThQ5HRSgt+MosgLMH19cPdHw6kSs95saI69J5LFKIm66y89rS1PYLY
itvDwAvx
=gy00
-----END PGP SIGNATURE-----

--FiJHDf4Am8F+i1Ta--
