Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B32E6F070
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 17:08:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA11288E3C;
	Fri,  1 Nov 2024 18:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rcvj8XRf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D701F88E94; Fri,  1 Nov 2024 18:08:54 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9ADA88E14
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 18:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b152a923a3so141875685a.3
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 10:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730480931; x=1731085731; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jv0H1N7rUopq4bW9SsB9s77ZWoD9mmJ1slHgZXKMLDs=;
 b=Rcvj8XRf884KbnJFt09IVVueVpVjXgmHfppEKZvWQN7jb+GcYtfWyzxwwNGjUSd8uT
 LQTZdWM4UFFm4Rkx3Tdrt6+IMP0NU9x6sbZ9HgHab1938ExfNPVnwymJ1H47lcmJgsk8
 Zznv3kGyUM0Su9wSxrJhLseFji0cb9vaE/03E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730480931; x=1731085731;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jv0H1N7rUopq4bW9SsB9s77ZWoD9mmJ1slHgZXKMLDs=;
 b=cKsr2YxVRfqKmJ2QybwAAByKboUstwEvlAxqgFiVk3nF/qm3nYEtfmTwIW2iP5MQlz
 dK3GJhbDQcXLNCM1EleXJUBdNkvTJxgHZYbzzXmO6K7qTuPG4LD3KyjDUhtz2RJCBukm
 BYblqNGRH6Tiej5awZeBBGTPJbz5BVfQvCReaiJ4p82PVWNSiMCDF4UEQp10seQuXNgm
 rDnTqHKZxqtqTijEWzSOYMp3OQIIDFxgETvP7PCCAi1x/+MqGZ1MtT1bcCd5z7m1/k0e
 HjFGJfoRQUql9DPyoMz/Su+xbw1kXJq4WzBYzdQFnSn/ySG3DFgJmji1Y2JTOmmaCSY3
 93/Q==
X-Gm-Message-State: AOJu0YxW1zvrr3IwfEYt/yP5+8wHQZwPbcR1cS48bawfl16JljvWqx6m
 fybF1wvlCShKMF1MofPQJ4umfabbK2T3oGMCV6xJ54b/IMTvp6vrmHYfzwRs/PNiDVhhHxdVCsN
 XZLE=
X-Google-Smtp-Source: AGHT+IHK21UkO0jDq+AfA/4zjYGK4p7pND+Y7dXfszkjkVxAPQjT2WQvLi/DqDvriTfTnUI0V66H7A==
X-Received: by 2002:a05:620a:288c:b0:7b1:48ff:6b5f with SMTP id
 af79cd13be357-7b2f25565aemr1068837285a.64.1730480931484; 
 Fri, 01 Nov 2024 10:08:51 -0700 (PDT)
Received: from bill-the-cat ([189.177.122.145])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f39eaaabsm188395585a.19.2024.11.01.10.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 10:08:50 -0700 (PDT)
Date: Fri, 1 Nov 2024 11:08:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 02/11] test: Release board after tests complete
Message-ID: <20241101170847.GR3600562@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-3-sjg@chromium.org>
 <20241029235303.GC2558755@bill-the-cat>
 <CAFLszThVsDEaFr2EYbfBi3u+MLp5D+OW7HkQKAgeJaAoei6gAw@mail.gmail.com>
 <20241031183416.GC3600562@bill-the-cat>
 <CAFLszThHJ8vbL1qsEoL7sh82TFftcVL9LPn14685i-ybkHq9Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Hq/owhdGtCaT07Vi"
Content-Disposition: inline
In-Reply-To: <CAFLszThHJ8vbL1qsEoL7sh82TFftcVL9LPn14685i-ybkHq9Pw@mail.gmail.com>
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


--Hq/owhdGtCaT07Vi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2024 at 04:33:47PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 31 Oct 2024 at 19:34, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Oct 31, 2024 at 07:00:14PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 30 Oct 2024 at 00:53, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Oct 09, 2024 at 07:51:36PM -0600, Simon Glass wrote:
> > > >
> > > > > When a board is finished with, the lab may want to power it off, =
or
> > > > > perform some other function. Add a new script which is called whe=
n tests
> > > > > are complete.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > >
> > > > But please note I don't see an up to date version of the
> > > > u-boot-test-hooks side of this which would include the release wrap=
per,
> > > > and presumably files.
> > >
> > > Please see my patch from late August "Provide some basic scripts for
> > > Labgrid integration"
> >
> > Yes. There was quite a long discussion on patch 3/3 and I'm not 100%
> > sure where the next steps there are on what the next iteration should
> > have. If the release script was it's own patch then I believe the first
> > 3 patches could be merged today and then that leaves the actual labgrid
> > stuff that conflicts with my setup to figure out.
>=20
> I tested my patches with my non-Labgrid setup (pyttest, tbot) and it
> still worked. That's not to say there aren't problems, but I am
> hopeful that it will not affect you.

I can re-name my scripts to labgrid-trini or whatever, sure. But it
wasn't clear if what you were suggesting was flexible enough in general
for how others setup labs too.

--=20
Tom

--Hq/owhdGtCaT07Vi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmclCxsACgkQFHw5/5Y0
tyzcTQv9FHM0uRfWfQa6FxiA5n1wcFutMmqZs8lT2BI1+blRRGk/J0MvhinpDNuF
7EXbkAhC7GxDQP7lpbp/fOPq75jnlgD23LVUVYOziLrWmgjm/Q1qCIIvnlZNqD9l
9upiCZoNLX3sPz6bD83RT1xCfRl9EbgnplyQJSiIKNxDBO8DAb4v6fTV/xSURTQM
0NsZueQLgEbZTDuIdyioKIj+knVVbTBZ4+6RNuPQDshYZTigDtjcM33kgHgUBQA5
dMhFx62qUMGjNA33TQ7s7CM7Swdk/PezL9IVXLpTzLJPJXbQJDzmeVBjKmSm039T
ioYi4mDm8gKL4/EgOP+O1QjmtHWVH5RyiLMW4XAFulssaIDB5xQtQ/hoFtdOukx1
A1kU/UTG0PsbuEECZhM/SdRr6Tv7D0EwqEAY4pYUcO1gfVR08GHsHmt1XtT8EYHD
hEU3PKDLE+SBHGt5CbVQ8vjytNriOWvc1cjDpv3jI7JJq11QjUqgFcFdQQZ6P14P
51KUBJDK
=M1j9
-----END PGP SIGNATURE-----

--Hq/owhdGtCaT07Vi--
