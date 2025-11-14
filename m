Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17C2CE7B11
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 14:18:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F4023840B5;
	Fri, 14 Nov 2025 15:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M8AH3u/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39FB6840CF; Fri, 14 Nov 2025 15:18:06 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0764D83EF2
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 15:18:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-3e8372e33a2so1185006fac.2
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 06:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763129883; x=1763734683; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BDUtU/GKOOsZOanbX+5AKd98Y7YenIqve2fT3zYpDMQ=;
 b=M8AH3u/TqEqP8tGHc+FfoKrY3re4IT/GLksw5Ilo01LB1SpMUI4i5czgSGUFYTLzyv
 HG5OLLgI5FcSNTU3aLMKl8fsXGLHFFrnoj4XR4hiGfK3hJFeq5PiJdgpeK+b67ycz3Y8
 k7dJ13akYGsr0b37pojiqK8nJ/MqCtYh9AIuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763129883; x=1763734683;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BDUtU/GKOOsZOanbX+5AKd98Y7YenIqve2fT3zYpDMQ=;
 b=fInF0hMYlgU/0WZLRtQbzDGolO/uq3q2ccWUjvpv8eOHvV1cNvE8iYXtHnCJk/ylHZ
 mhqeLbxlh4AM+7IMjJGqz3U//aFUVo4AHmB6d2rOwQBYcUyhJUw2voY9lKZcBAghYUKd
 saowyb3AvMhkZF6N59ttBUbZQ6N0TYuZUmk0eqXJ/r/euNKmY7Mxr/Jo/hXEM3knVI69
 uxfldOx+IZGwXbF8dne7p4T0asUVCmGgVoLYDqdjdahb7ngzw64kit5JxdYc1i2wxfFB
 XOgsj8hGcLtNbPJOT3Sh7pTx0urTbj8q+DInuy+GQjPNRJANHZFXI+4q9aFHTs530+mk
 zKMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKiCz/+UqajU23/RzQxKwkNNjz3sDhUoz/OvIIkh3UHNIbpEgajUblUPd0V9UFvCPWGrUvjHs=@lists.denx.de
X-Gm-Message-State: AOJu0YxaBqU2A1TpDIM8DkEG4Qr2G2FW1Rh3ObaIv3kEqH0i9y6JMHa+
 tXyPaO3JrnBcEwcVs0ysZsPZtWVQn9lmRJNDi57hGGknOjJeA+KbDgByRmFZb5UHHAi5QDuRmov
 W8csNmHe/eA==
X-Gm-Gg: ASbGncs8VU+GagPS99hF80nz0uvEoInb/5QrdQ773mYWozzmtAK+7HLZa2ET2/vMeLl
 QRrDoTBJfnxSAh7z6f4HQnc1sN5l8VBun/ongSU8Bncq3kSVVirUNd/Vvm8/z7Z+60J0/jEQ2gU
 RPrL95k1ugJsIurSWCHb/hSFxGsih+c/Ldd2EGmOkWXSTPxcdq0knBhrYQH0ugBZb2auQZS9oke
 cL3WwXMzZuN89A2GdQni4roCRME9sVJCfHEZRE/WGG/WwpUBRkBf8XzvDtHt6RhUv3p1f9VWEkI
 iMGkqX8c1NdM0pZEwEj9k3Y1h9I94QJq5VRByS3Qr7zU2y6MTdwk+6nRbGXwxqRA+5vRgmCN2Oy
 O7mKQVW3MX/OX1lqwcfmT11Aq0ovcvx919spXk61XcqLeRT84ARhDaG4VAtZKOb0alzatYhmKB2
 B7bWwGVTGgqmP+ose4jTwWlcOTwUO4QhkblA7vDVc=
X-Google-Smtp-Source: AGHT+IHdojII53Atqd58FJBCK/vl0Zih6swhj9k1eSxrQSa/58496GLaV59KODOmdv34Qz0ZwbjyrA==
X-Received: by 2002:a05:6871:cf02:b0:3d1:b55c:3612 with SMTP id
 586e51a60fabf-3e86911f3c2mr1325908fac.27.1763129882634; 
 Fri, 14 Nov 2025 06:18:02 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8522b012asm2773986fac.19.2025.11.14.06.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 06:18:02 -0800 (PST)
Date: Fri, 14 Nov 2025 08:18:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] test: do not write to 0x0 except on sandbox
Message-ID: <20251114141800.GU6688@bill-the-cat>
References: <20251105180748.115441-1-heinrich.schuchardt@canonical.com>
 <20251105192601.GT6688@bill-the-cat>
 <20251105193307.GU6688@bill-the-cat>
 <0a146dc8-f1bd-4a92-ab42-29909da4e7c0@canonical.com>
 <20251105230901.GV6688@bill-the-cat>
 <CAFLszTj6Hsh7omf=AQbLjOqvN=VrX=1ZQXYwaXhVJfNdqfQm_Q@mail.gmail.com>
 <CAFLszTjiNBMbJG=DWER+DPQTJNe-SsdzxFP_76=iyyGhNVkrCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zlGJNlGRT2HQVHNW"
Content-Disposition: inline
In-Reply-To: <CAFLszTjiNBMbJG=DWER+DPQTJNe-SsdzxFP_76=iyyGhNVkrCA@mail.gmail.com>
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


--zlGJNlGRT2HQVHNW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 05:44:42AM -0700, Simon Glass wrote:
> uHi,
>=20
> On Fri, 7 Nov 2025 at 05:23, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Heinrich,
> >
> > On Thu, 6 Nov 2025 at 00:09, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Nov 05, 2025 at 11:57:25PM +0100, Heinrich Schuchardt wrote:
> > > > On 11/5/25 20:33, Tom Rini wrote:
> > > > > On Wed, Nov 05, 2025 at 01:26:01PM -0600, Tom Rini wrote:
> > > > > > On Wed, Nov 05, 2025 at 07:07:47PM +0100, Heinrich Schuchardt w=
rote:
> > > > > > > ARM and RISC-V do not have memory at 0x0.
> > > > > > > On X86 interrupt vectors are stored at 0x0.
> > > > > > >
> > > > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canon=
ical.com>
> > > > > > > ---
> > > > > > >   test/cmd/fdt.c      | 4 ++++
> > > > > > >   test/common/print.c | 8 ++++++--
> > > > > > >   2 files changed, 10 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
> > > > > > > index 96a8488e172..6b07999c88f 100644
> > > > > > > --- a/test/cmd/fdt.c
> > > > > > > +++ b/test/cmd/fdt.c
> > > > > > > @@ -269,6 +269,10 @@ static int fdt_test_move(struct unit_tes=
t_state *uts)
> > > > > > >         uint32_t ts;
> > > > > > >         void *buf;
> > > > > > > +       /* This test requires low writable memory */
> > > > > > > +       if (!IS_ENABLED(CONFIG_SANDBOX))
> > > > > > > +               return -EAGAIN;
> > > > > > > +
> > > > > > >         /* Original source DT */
> > > > > > >         ut_assertok(make_test_fdt(uts, fdt, size, &addr));
> > > > > > >         ts =3D fdt_totalsize(fdt);
> > > > > >
> > > > > > In one of those "what is even going on?" moments, just out of c=
ontext we
> > > > > > set newaddr to 0x10000 and then "fdt move addr newaddr ts". Loo=
oking at
> > > > > > my logs for am62x_beagleplay_a53 where memory is not at 0x0, th=
is test
> > > > > > is currently running and passing. I'm going to fire the platfor=
m up and
> > > > > > poke now.
> > > > > >
> > > > > > > diff --git a/test/common/print.c b/test/common/print.c
> > > > > > > index 76ee851fe6a..389d6bf4069 100644
> > > > > > > --- a/test/common/print.c
> > > > > > > +++ b/test/common/print.c
> > > > > >
> > > > > > These tests are also running and passing on am62x_beagleplay_a5=
3 I see
> > > > > > in that same log.
> > > > >
> > > > > I'm poking TI folks about this in that it seems like memory is re=
ally at
> > > > > 0x0 here.
> > > > >
> > > > > But with respect to this patch, NAK, we need to figure out how to=
 change
> > > > > these tests to run elsewhere rather than disable them on all of t=
he
> > > > > platforms they currently run on.
> > > > >
> > > >
> > > > These tests that are not passing on qemu-riscv64_smode_acpi because=
 of
> > > > illegal memory accesses.
> > > >
> > > > Unfortunately Simon has written a lot of tests with the sandbox in =
mind. I
> > > > agree that it is preferable to make tests more generic.
> >
> > So long as we actually want to run them on the target, then maybe. But
> > what failure are you expecting to find? Compiler bugs? Mostly these
> > tests are a waste of time on QEMU.
>=20
> I never really heard back on this one, so I suppose my point is made?
> Should we set as policy of running core tests only on sandbox?

No, and no. Heinrich just fixed this in a cleaner way.

--=20
Tom

--zlGJNlGRT2HQVHNW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRc6FwAKCRAr4qD1Cr/k
Ct2YAPwI3x1NlqUdMmX7hXEKkvt92VUQV5v1prZMYM/DbpaqiAD+PPa9PuxC+YkR
RTQWY04wTcd3HKZkFt6kRB8hxYcnKwM=
=ch8j
-----END PGP SIGNATURE-----

--zlGJNlGRT2HQVHNW--
