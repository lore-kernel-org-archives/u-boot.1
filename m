Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BC9C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 15:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DBE982CFD;
	Fri,  2 May 2025 17:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WxzmkiI8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64C8182D06; Fri,  2 May 2025 17:06:48 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26FE382CC9
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 17:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3fefbbc7dd4so1446781b6e.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 08:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746198405; x=1746803205; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xPVSx63nRZ0ZAxVy1rvh76t9vHzUuL6d0LPRPctIjds=;
 b=WxzmkiI8QyIcB+uFIZ2wgC6xXmzRWUqqh2i5UbBPPQR+3FxQbK5sFBio0pDVFMjnBM
 cuP2punawbgVhzsz67O/9KnH6+41vKDgP7RTpsvVXA8t0ex5QpTq9bHaHS/MDOEryriK
 HOyaKZ0AEL93I28zIdh5NIfsvM/phaAnjjxhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746198405; x=1746803205;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xPVSx63nRZ0ZAxVy1rvh76t9vHzUuL6d0LPRPctIjds=;
 b=IXhqzh/4WFqS6Phz8hef1bWNG+lBtRpsdfnwqPdj0nqxHSmIdzQuz7NCsFagzugnbC
 0CI0S9dCfY5F8c8zcKvIY4FblX8M5kun5ByqMxEkXZJ7GljfHSSvoEG1249AWO7ODEg5
 kJO08SZUG+loByTcdCAFd2/X7ZgVK2hrKra6WVeAhxcqXrSjzuE5o+C1/7TzYRE2G1sM
 H0YlUQV/owOJBeKD0P7t1gU+RW+YJ7GZ7/o7Unttc4Z6KzYmvcnRjnmEWgQZknnWoqRZ
 9AWSSE/9Dnu1piET6W/0Aj4UFKSbmFzVzP691CzHW18YZPc2EDVrYcGr1e3HHEzFpxNK
 gZ6A==
X-Gm-Message-State: AOJu0Yy4VxeaXkVpOhJ0XdQ0w4RrLxeXfKaNF2ypUsuIK+mL5/z3SZQs
 ZI80D98ytO1c5d1Wk3JZfHxIFYuLPwbVRhBJPQVWgQOxqdQrGWdF5SHGcELQMDs=
X-Gm-Gg: ASbGncvCGu6Kp3IEuMedHktOfjly9FLV8snwNUkHWh6QVInzz9TC6S+3B5pXHDPtzKZ
 y5Y+vZzh+j5wc8L+IldIUlvaNzMaemGpdnrNCEtqhS+fm/vMLwQCl01zuTzrtjnmHuDUJVpqmmw
 9T5YaVjoVuZudrOk1WSEfVmVIj2NS4gvLGovTzvmnMO2rORKOwgtrZqxO5ma5+c6RHH8eGO/O2z
 4mjfzDie/V4TSXV/0Nx49zKj3yqViTPaok9EEUPAZIjKyXBvjGcOi+kVUn/xjaP5qlUZ82xHsL6
 IH/YgGMUpcXo1gKlpth9qYaRFNwM+1BrwieEuwj6XR6Y/vu8LK9Oh4TOM0H3ZqqJpdaPzlD9m4s
 G2Q==
X-Google-Smtp-Source: AGHT+IGyhVgIxz3t/VZULeZ1SKf5tjxxTekhZopafWeVKXLjGqk+PpEj7Elxz4VrfskuB+PhtwmSNw==
X-Received: by 2002:a05:6808:1241:b0:3fa:7909:2716 with SMTP id
 5614622812f47-403414b7c7emr1545276b6e.39.1746198404851; 
 Fri, 02 May 2025 08:06:44 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4033d9a5e2asm611732b6e.2.2025.05.02.08.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 08:06:43 -0700 (PDT)
Date: Fri, 2 May 2025 09:06:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
Message-ID: <20250502150641.GW1261075@bill-the-cat>
References: <20250502025026.4140184-1-sjg@chromium.org>
 <20250502143359.GS1261075@bill-the-cat>
 <CAFLszTha1wWDCpi=HR4sE-rKjoPQp+Twvyrsb-fCcF=vPW4d8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QF6BMhZk/QCNVppM"
Content-Disposition: inline
In-Reply-To: <CAFLszTha1wWDCpi=HR4sE-rKjoPQp+Twvyrsb-fCcF=vPW4d8Q@mail.gmail.com>
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


--QF6BMhZk/QCNVppM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 08:49:12AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 2 May 2025 at 08:34, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, May 01, 2025 at 08:50:16PM -0600, Simon Glass wrote:
> >
> > > During a recent discussion with Heinrich we discussed why the hooks a=
re
> > > kept in a separate repo.
> > >
> > > The amount of code is small, a tenth of the size of the recently added
> > > lwip, just by way of example. Testing is a critical part of U-Boot and
> > > one of the things that distinguishes it from firmware projects that h=
ave
> > > not kept up in this area. By having the tests somewhere else, we are
> > > signalling that it is unusual, or difficult, or optional.
> > >
> > > The hooks mechanism also needs something of an update to take account=
 of
> > > real boards in 2025. That will be much easier to undertake if the code
> > > that test/py talks to is in the same repo.
> > >
> > > This series brings the hook files in as first-class citizens of U-Boo=
t.
> > >
> > > If we do go ahead with this, I will send a different series which has
> > > separate commits (with correct author) in the u-boot-test-hooks repo.
> >
> > I think bringing more projects directly in to the repository is a bad
> > idea. Your example of lwip isn't applicable because it's a read-only
> > subtree that's maintained outside of the project (same as the dts
> > subtree). But sure, lets "Say Yes". That said, we still need to:
> > - Remove needless examples from the tree.
> > - Not include personal labs directly in the tree.
> >
> > That last one is why I really think this is a bad idea. The point of
> > having the hooks standalone is so that any given lab can easily add
> > support for their lab and manage it, without worrying about disclosing
> > internal layout. There's going to be hard coded default passwords there.
> > There's going to be repository secrets there. That kind of information
> > really should not be in a public repository. Integrating the hooks with
> > mainline will make lab management harder, not easier. The point of the
> > existing labs in u-boot-test-hooks is to provide samples.
> >
> > I think this is all why no, we should not go down this path.
>=20
> Is it worth discussing this, or is your mind made up? I have some
> thoughts on the last one.

I think it's a terrible idea that I already said:
> But sure, lets "Say Yes".

But please do spend time explaining your thoughts and perhaps others
will also agree with you and I'll feel less bad taking this in?

--=20
Tom

--QF6BMhZk/QCNVppM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgU34EACgkQFHw5/5Y0
tyxfuQv/e+k9Hq0PYSGmH/melzl5MmgJN1VFJhzDFbUuWQzclTpOZsnph9ALzsBh
vTIxJ11ar2e8INSqxGoX6TtYYjGg2v6Uvv9SSnIyZPloLfagexAvv3xcsp4hMiRe
EwKfCDgvUlwMkaoThY6CZmFJs/NVBiCG3TwhEvX/H6QaFkPbKADizHn+V2gGAMqy
yp72XSvCTGXn/J5jVCsy0KnsQWiGxgXLVXZ7tOQC9K0oOvbS5FFy4sxtJiItamUB
fIwdjfORb/vUGYMgy6U8LnHf0m65PI6rE7ZT1nJe2VQh9w8v1dcxOLQzyozCKteP
VEuAW2xhrhSxkjlLJ04UvnCjAa2t+jKRWAIGOXodSgm7WS1sw88mPkNacW1wa5zT
isM80StnwWLG7igRyhXNPnszTkQMzAHVWkQGRc+w4RoymGyorHKDGseukgOX/n0p
rkeJJFT5PWwRGN7gCksPorPj5Hs0s5lK9ArScI+ihWUiBKR0FCFZjh9NnIirwCKR
UrEh6SZA
=H1o8
-----END PGP SIGNATURE-----

--QF6BMhZk/QCNVppM--
