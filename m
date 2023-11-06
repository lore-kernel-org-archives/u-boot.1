Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE1CC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 21:04:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C89886470;
	Mon,  6 Nov 2023 22:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a44QyX8s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E919D865D0; Mon,  6 Nov 2023 22:04:18 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0E2A863F8
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 22:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6d319933f9fso3013372a34.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 13:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699304650; x=1699909450; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0A3/Bg9Gpr7tHDdpQXAxymQ5CA/oK7c7SmAkIkkX/e8=;
 b=a44QyX8se7Dtupkk5HiMIUvkomlPnkLcRXH7//LTZ6RODrhJD0aB5ICjl7QcO9Pwo9
 QNaOanmsKKnNys2f9Ynbn0iTJbXl52jdcXNJKDW775ryk863tpWdNDXv1zsfUrA+LLoM
 zeC2QirICY1x/s2QC05Cu8qxIJZp1YJPrKiUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699304650; x=1699909450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0A3/Bg9Gpr7tHDdpQXAxymQ5CA/oK7c7SmAkIkkX/e8=;
 b=IbJxI+m1fMxf6b4B0G6RRj/mdFp/BDQl3Hh5b7VMI64MjToTF2VKH3RYG23InKYS9g
 SRaij+fGPJjhisPNVWSw7wb33QW/c+OySplsh8QOYpmDaLGew1QTTeZV+JXySPQGFUsR
 MtJ2/QfbFca2Jdibur+ZmJrneGdOmA3mVWpz3nEMR052DpkruX0h5R+scoRFicfr1LmB
 moBFwyTdTrWsCPi88bqrbuktVaScKf8VPf3ZGzyeZCyYNQnCS4uuvuRqJd8aSQTv71Gz
 UPtYy7NK9Jiy/yaIpS2D5dOmfw5cmpU/8r94juOv+3U4G5lmOG4ynhfDgjUJRlzkxcfp
 ENSg==
X-Gm-Message-State: AOJu0YxSb6g+0ETeE5hyJIx65OXTC1cb6mCjZakZ+BKfnp90OFS8b4tJ
 XneRSfoqSV0NzN50ivbfmgdQsA==
X-Google-Smtp-Source: AGHT+IEizIgsop9kH+BANHx+hWIEmLJC8e1BXQqbTrFf8CsFh2EZFBDPTY+8Qy3W/jRZ0qG7AdTh/A==
X-Received: by 2002:a05:6830:1111:b0:6c4:e507:3747 with SMTP id
 w17-20020a056830111100b006c4e5073747mr31724708otq.30.1699304650437; 
 Mon, 06 Nov 2023 13:04:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 y14-20020ac8708e000000b0041803dfb240sm3715460qto.45.2023.11.06.13.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 13:04:09 -0800 (PST)
Date: Mon, 6 Nov 2023 16:04:07 -0500
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,
 Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/5] Convert recently merged T30 boards to use DM PMIC
Message-ID: <20231106210407.GK496310@bill-the-cat>
References: <20231106083229.256322-1-clamor95@gmail.com>
 <CALeDE9P=aUfEvhh-FD_mwRZ+5rgMkQbn+v6skqW7s3EVvnf6eg@mail.gmail.com>
 <CAPVz0n0LDVh-8W=o2Hp-AXU_=Jg5CnuYh54LxsE6XH=DD7nD5A@mail.gmail.com>
 <CALeDE9NLfGRpLxNNqNGOY3S-d9hWP1DWDjL526JNw_8xPqjaXw@mail.gmail.com>
 <CAPVz0n1WepmE6pTxSaeK6yHH2ji6_L+LF7a=TZk6hLWS8GcHKA@mail.gmail.com>
 <CALeDE9NjK3b=OskgsjCvO44M01nRZ6-5LrEgUZtYQfxy7gN5mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x8evWQcJqdez5WVV"
Content-Disposition: inline
In-Reply-To: <CALeDE9NjK3b=OskgsjCvO44M01nRZ6-5LrEgUZtYQfxy7gN5mQ@mail.gmail.com>
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


--x8evWQcJqdez5WVV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 02:11:16PM +0000, Peter Robinson wrote:
> On Mon, Nov 6, 2023 at 1:28=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.c=
om> wrote:
> >
> > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =D0=BE 1=
5:13 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Mon, Nov 6, 2023 at 11:58=E2=80=AFAM Svyatoslav Ryhel <clamor95@gm=
ail.com> wrote:
> > > >
> > > > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =D0=
=BE 13:46 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > Hi Svyatoslav,
> > > > >
> > > > > > Since the proposed PMIC patches have been accepted, I see the n=
eed
> > > > > > to convert boards which I maintain to use DM drivers instead of=
 board hacks.
> > > > > >
> > > > > > Svyatoslav Ryhel (5):
> > > > > >   board: lg-x3: convert LG Optimus 4X and Vu to use DM PMIC
> > > > > >   board: endeavoru: convert HTC One X to use DM PMIC
> > > > >
> > > > > Is there a reason why the two above devices don't appear to have =
their
> > > > > .dts files in the upstream kernel?
> > > > >
> > > >
> > > > Yes, there is a reason. Linux maintainers treat submitters as
> > > > existential enemies or as dirt at least. I was trying to work with
> > > > linux but I have no desire to spend any time to upstream endeavoru =
or
> > > > lg_x3.
> > >
> > > The usual policy for acceptance into U-Boot is to have upstream review
> > > in the kernel first.
> > >
> >
> > May you point to a policy which clearly and explicitly states this as
> > a mandatory condition?
>=20
> There have been a number of devices rejected in the past until their
> DT are upstream but I'll leave Tom, who I've explicitly added on cc:,
> to clarify the exact policy.

Well, here is where it's tricky. I brought this up for one of the
Broadcom MIPS platforms a week or two back, and Linus Walleij's point
(and I'm paraphrasing) is there's not really an upstream for it to go.

What we cannot have is device tree bindings[1] that aren't upstream or
worse yet conflict with the official bindings.

So the general way to resolve that is have device tree file be drop-in
=66rom the linux kernel, and what additions we must have be done via
-u-boot.dtsi files. And in turn, some SoCs are better about keeping in
sync with the kernel than other SoCs are.

Now, upstream being actively hostile to dts files, especially for older
platforms? That's unfortunate. So long as we aren't violating the rules
about bindings, the intention is that we don't have device trees that
are either (a) massively out of sync with the kernel[2] or (b) kept
intentionally mismatched from the kernel.

--=20
Tom

[1]: There are both examples like binman that Simon is working on at
least but this is more exception than intentional rule.
[2]: Per our other conversions, I know the tegra ones are in this
unfortunate state in general

--x8evWQcJqdez5WVV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJVMAACgkQFHw5/5Y0
tywKWwwAkoBqaWbextyUf84IKC9Uz1K6ydQ2L286JuimXBHlyA3v66Tf485rumca
Kx+ZjBuyF2PguJ85GZtoqR4t6/y+MjgU0guho7yKW0aev/tJ+0UyoczudDPofdpj
jFFbyCVU/pVyrag4N6tV5XaCfUBK8Aed2JPP6Co6XoBeh2ruvAxgLSW5j9b8Ghp2
l2GUgOfkp7pQvH5lZbPk/TiIWzaRf/jA9EjD+ST0v8G/wjDsvEfvRs6BuuaEMyQI
Ym2omgZ4XZJ66WexKgncfskF61m0dBMnj7P92Yx953rENTsNepcfGjg2QjxruiTQ
YqrZpIaKINB9k3yKHMgGow2sdutt4GdPLjg0KenM5IL/9mDTYoYvTg2qfaAvvRv0
s754V81S3BuaHDypdNHkQpjHb/RtC7C5m9pX/dCm5z+FOieb+85avn4+zfpQgYxe
t6JYSk14Z+FnHxOAdSJwm7CJoNkZzYROxa7CqmAg+NTExJku12p90d+s+ML90WIV
MehaUCXP
=jdTh
-----END PGP SIGNATURE-----

--x8evWQcJqdez5WVV--
