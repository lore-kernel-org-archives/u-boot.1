Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31A1C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 00:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A65E980646;
	Wed, 19 Feb 2025 01:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tdElwSe6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6F81800D7; Wed, 19 Feb 2025 01:50:35 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADC9C800B3
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 01:50:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so124140995ad.2
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 16:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739926231; x=1740531031; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KJTrd31wTxpPdCliL4eHEvMim9y2wNe7SnOuT9QG+SY=;
 b=tdElwSe6b2copzMguRXZawq8f17TJNWMN/kJ4rhYccUEaiRBr+D/6mK/S4rKjBwWBw
 6iuNt//98Yegs8HXZT9g9Q9rpcYQ3hbrVM3CRwfDH+9q6VuU8LKp023LQwlyXBvFEO/x
 e0vuzWtXhe/lZFLCwTqZIwAxofhgbb9J3drCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739926231; x=1740531031;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KJTrd31wTxpPdCliL4eHEvMim9y2wNe7SnOuT9QG+SY=;
 b=cAqorHrNk5g4xd2M5bRi9vDCYXco9jNcVE9Z69GGYgaY8ZUcqftzCr+6225tFCqBq+
 bmSG34Qf01y08PrcbF5vMa9Szdt/IVwajVfBpcZx0wqgivfMshBbRfv8It87uy6kJT3u
 cm2EmIh8YS88GkF8Mdov+LFsphcN91GENw5fp4sDXCOPVPqhy1SKq3kXd/95kvQ3H5aL
 bDcPwiYyVfHCB+DJH44U4n7eUh3x4z4FSdKajh8NuYqgzSw8E4hY7FymrDkaMGC3FHep
 I9ZmW6fYDPVPKLiZtbAMF8WAJu1RAd+0Mya83FSrhb078Y7t+f4fLB+bPFUmseUA1kXY
 NRFg==
X-Gm-Message-State: AOJu0Yy55n2uf3YpLI8HsjdqmKpe9F8zItZ498clYBlUKFcXs8blzMtk
 j1H9QXbC9S16TrDO33TTm8IxYO66Q9nnzsZP0n+Wih1v/byGm6t9mb68IdtLmRY=
X-Gm-Gg: ASbGnct+Ys2ero9YYKDl7OujJMtGFyZ7VuybMm0IiSTvNsfLWhDXhAQTq2WLPLicxc1
 8MB9R+xark+RNORa2/UcUk9+jhfAFoiTkn26WQ+LwUX10dz+LqLyvVQRLEW4lqNdyLlVjQJkzPd
 aUyabhbd4GfJHH9+eNpMw2CdyfmuCV6L90Qdc4m+tBXAWayqwz9KlHQa92/IT//YLQuaTlCZsIC
 VjZV17p/FqHsK2O8IDccJkM9E+eGBl2+ayoGiIqyLLWLY8eoCi75pxdoll0bD3wfesWlKWO5Sqr
 LJdznxYKYIsKDA==
X-Google-Smtp-Source: AGHT+IH7jBYF9c17ZdWBqxiiJYT5Bz43b5zUPDxB8F2WJ/ftTO4Aq6kQlMTlr5hOJNwtxzpVkeG1Xg==
X-Received: by 2002:a05:6a21:681:b0:1ee:b033:6dc5 with SMTP id
 adf61e73a8af0-1eed4ed2a98mr2510275637.19.1739926231108; 
 Tue, 18 Feb 2025 16:50:31 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adb586187a5sm9839655a12.38.2025.02.18.16.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 16:50:30 -0800 (PST)
Date: Tue, 18 Feb 2025 18:50:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v2 26/28] test/py: Allow tests to be filtered by role
Message-ID: <20250219005027.GQ1233568@bill-the-cat>
References: <20250216204421.3560012-1-sjg@chromium.org>
 <20250216204421.3560012-27-sjg@chromium.org>
 <20250217174805.GQ1233568@bill-the-cat>
 <CAFLszTjr_oNvawcWSgAMC6EVqvTXNntg5fwjp2fm5Enhq_1m0g@mail.gmail.com>
 <20250218151224.GE1233568@bill-the-cat>
 <CAFLszTi132O0-yODOVOZ0_8HOKwA1JPn=xZBMovLma42GM+eng@mail.gmail.com>
 <20250219002526.GP1233568@bill-the-cat>
 <CAFLszThBbe0K5mz3YmkpsWUCFYXys_hp6ERyHpVqPLETntwKaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zniHWhim/EPWCe8h"
Content-Disposition: inline
In-Reply-To: <CAFLszThBbe0K5mz3YmkpsWUCFYXys_hp6ERyHpVqPLETntwKaw@mail.gmail.com>
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


--zniHWhim/EPWCe8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 05:39:53PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 18 Feb 2025 at 17:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 18, 2025 at 05:04:09PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 18 Feb 2025 at 08:12, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Feb 18, 2025 at 05:09:06AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 17 Feb 2025 at 10:48, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Sun, Feb 16, 2025 at 01:44:11PM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > Some test can only be run by a particular board in a lab, e.g=
=2E because
> > > > > > > they are loaded with an OS image used by the test. Add a way =
to specify
> > > > > > > this in tests.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Add new patch to allow tests to be filtered by role
> > > > > > >
> > > > > > >  test/py/conftest.py | 22 ++++++++++++++++++++++
> > > > > > >  test/py/pytest.ini  |  1 +
> > > > > > >  2 files changed, 23 insertions(+)
> > > > > >
> > > > > > This seems duplicative of the existing functionality we have, a=
ll
> > > > > > hardware tests can only be run on platforms which configure wha=
t the
> > > > > > test requires, in the boardenv file.
> > > > >
> > > > > I was afraid you would say that, and yes you are right, it is dup=
licative.
> > > > >
> > > > > With my lab I am trying to use Labgrid's configuration and not ne=
ed
> > > > > anything else. For example, the params on how to launch QEMU and =
where
> > > > > to find the OS file are there, rather than in u-boot-test-hooks. =
It
> > > > > allows me to run a session interactively just as easily (and with=
 the
> > > > > same flow) as I run the pytests and gitlab.
> > > > >
> > > > > In my lab, I actually don't have any Python things, apart from wh=
at I
> > > > > added for that tftp test.
> > > > >
> > > > > I wonder if I could create a way to pass the env__ stuff in from =
Labgrid?
> > > >
> > > > Well, I was also afraid that was going to be part of your answer. A
> > > > challenge I see with the way you're using labgrid is that details a=
re
> > > > kept there, instead. Is there some way to publish your configs so
> > > > they're also available for reference? I indeed have been lax in doi=
ng so
> > > > for the way I use it and so posted:
> > > > https://patchwork.ozlabs.org/project/uboot/patch/20250217200638.356=
583-1-trini@konsulko.com/
> > > > yesterday.
> > >
> > > Yes, that's great. It is a big help to have all the lab stuff in one
> > > place and not being able to get things into that repo was one reason I
> > > gave up with my local lab that used the hook scripts. Just too many
> > > local branches and hacks, and too hard.
> > >
> > > Anyway, yes I'd like to get it in u-boot-test-hooks. I last pushesd it
> > > to Labgrid 7 months ago [1]. I thought I did it at the end of November
> > > but must have imagined it. Perhaps I could put the config files, etc.
> > > into u-boot-test somewhere, like in a labgrid/sjg directory? Could you
> > > give me access to that repo?
> >
> > I've updated the permissions and you should update the "bin/ellesmere"
> > directory and add "py/ellesmere".
>=20
> OK, thanks, will do. Where should the labgrid config go? It is three
> files and perhaps a few systemd scripts. See [2]

Well, we have a "udev" directory. So I guess a "labgrid-sjg" directory
and you can populate under that?

--=20
Tom

--zniHWhim/EPWCe8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme1KtAACgkQFHw5/5Y0
tyzwpAv/ZuZ/VlqFT/cWK9QTqLBZeg2tonCF77bzeg8nxrTWu0MdTvAPl6UMqsEd
7Z8gHq4Kg8Ph5tiN8T83SuWiFapakM/tv54d6IGopc7JUrqyxA/zIn4w881vx5Uw
SSSjU6YbTYr/Anly4sfMqafv1NK4qLKVFxxgZD9RjEjvUq2mPgyfmb4dr4yMkL+U
DgbrB7wrAkOEbnOwp5K2NFLR9aVvCLsQu+0D5c8ahaHUOIAz31dogXCxKq/VkAl7
uJS8LcCcH+b7FDFQmFXxpwQGWi6tV86YNEw+FGJBGC+ZgjZZe6D4ciecQWwKv0CG
8XBv/qGv/g+SO8NFO8olW5ygsPZ49quY0hALtZS81lUNdMktaaKNEexyxK7UXNaf
PUPrwx8oTdniU6QlfAHt62wNUNs73VpakKGXdcVfMVC3Pc/Kld9SH8aYSRfBTwtK
T7Z/LvC6X83NkR+yWH8gA3jMACBuCJu2FmFkI0hLxx4Cs9u/AdWTpfkWChHNvFXr
hgWzaePX
=igak
-----END PGP SIGNATURE-----

--zniHWhim/EPWCe8h--
