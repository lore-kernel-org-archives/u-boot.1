Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90086E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 17:57:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBB118973F;
	Fri,  6 Dec 2024 18:57:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eFSzWVrX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9644489737; Fri,  6 Dec 2024 18:57:03 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AD348974C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 18:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b65db9b69fso110576285a.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 09:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733507806; x=1734112606; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SDOyeK6PNzGuyMQ3UD7z5pJdIN3xuR0qYgJqltuf3zI=;
 b=eFSzWVrX4EiWxn84ld19Jp8oVPr0X8YLh9V9xCIzkqbStfA6i1T0Dd4KA4jto4SeWU
 vj9imrVsibVwGRTTcqyDdpbYM0eNXEg48GJ88A7QNBfEMcObAviQepSfg76NBUI6SYbW
 bUSZEocEbAN0axIA81afKphy7beyMxxhd0BNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733507806; x=1734112606;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDOyeK6PNzGuyMQ3UD7z5pJdIN3xuR0qYgJqltuf3zI=;
 b=kJNhNuhC3Nqz3xLYUNG9AJL0dZ39eYEIukLVx/gb2YywWuKRWvXQ7cpQbULl8P2PWb
 hn7kofE91F4TikawvT93/C+U/c+S0LN56I+taKEveuSIJ00bCBDVwGc73+Qt74X0QXob
 dRhRjeKNhT8Ou2z7Jye0PSxrVusfEkAV2SaocRLhRwmvh+Fx4nnIRovQ6eqcR7FGsWqg
 Orw2MKDSt4dkb1JP+OkkezNc/KvXkFnhkYjOXV+XwJk+EN2GpsGCcUaUWa8fTGmDAe3w
 satYv9s81yrK8CdhpRx32q129NcSyRNb8k7e312/pbXNHe5kfK/ML0bQSb/U94Cxf2Nk
 I8nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP+UDB1ycM+RY4O4dJpq8TUns0PB7shWyVspJ4o5fYHWYQtq2IqeRyzn2cwxJSpYgn5x6pp80=@lists.denx.de
X-Gm-Message-State: AOJu0YxRvwVQyPvWa1pl9T5Q/DRJah7+qXyQsWX8k7qQziZr1sVTyrq/
 5hTX66yI1L8YP3KN4bvFKdMOI+aVBuz7F1zcUHjw0cqW+h+W0CyPONbYS8ocVKM=
X-Gm-Gg: ASbGncvuarsGDj91uE/FkBql/3Uaxc3lu5yC+4AehS5XJN8U2BdffzrEW3Qk1eh2RUd
 Zxm3GL/rvfmxRT1Lm1JURBbxIy+tRw5QQQrSP09hA0eWg2UCRBXF24zC+Xkr3CVP5uXKPltrDNm
 k1/oTZcsIRRX3meDIeVEcYrfWcSMPmpiIcFpB9rbnU7yXArk2rGPi613HFA1kOk6GLpwiVdwi57
 kmrFjaGXhZArF4GJn77QXgpb1VSnbxVqYeXx63TvvkUkHXsMA==
X-Google-Smtp-Source: AGHT+IHU2gc6SMYVNUNAyqbYlgDE+KgdYz8TYbyXtF9oXB2W9+4iF0gTYwi41J9Gnk7p/IybplpxQg==
X-Received: by 2002:a05:620a:1a05:b0:7b6:6e3f:49d1 with SMTP id
 af79cd13be357-7b6bcafa407mr434851185a.32.1733507806339; 
 Fri, 06 Dec 2024 09:56:46 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a9e5f3sm194628085a.116.2024.12.06.09.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 09:56:45 -0800 (PST)
Date: Fri, 6 Dec 2024 11:56:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/8] led: update LED boot/activity to new property
 implementation
Message-ID: <20241206175642.GV2457179@bill-the-cat>
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
 <20241113180059.GV3600562@bill-the-cat>
 <67350b1d.5d0a0220.2d4a95.bc9a@mx.google.com>
 <20241123024113.GM3600562@bill-the-cat>
 <6753349b.5d0a0220.d8cca.5513@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MjCxCmlJnCdb754J"
Content-Disposition: inline
In-Reply-To: <6753349b.5d0a0220.d8cca.5513@mx.google.com>
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


--MjCxCmlJnCdb754J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 06:30:00PM +0100, Christian Marangi wrote:
> On Fri, Nov 22, 2024 at 08:41:13PM -0600, Tom Rini wrote:
> > On Wed, Nov 13, 2024 at 09:24:59PM +0100, Christian Marangi wrote:
> > > On Wed, Nov 13, 2024 at 12:00:59PM -0600, Tom Rini wrote:
> > > > On Sun, Nov 10, 2024 at 12:50:19PM +0100, Christian Marangi wrote:
> > > >=20
> > > > > This series is split in 2 part.
> > > > >=20
> > > > > While adapting the LED boot and activity code to the new property
> > > > > accepted by Rob in dt-schema repository, a big BUG was discovered.
> > > > >=20
> > > > > The reason wasn't clear at start and took me some days to figure =
it
> > > > > out.
> > > > >=20
> > > > > This was triggered by adding a new phandle in the test.dts to
> > > > > introduce test for the new OPs.
> > > > >=20
> > > > > This single addition caused the sandbox CI test to fail in the
> > > > > dm_test_ofnode_phandle_ot test.
> > > > >=20
> > > > > This doesn't make sense as reverting the change made the CI test
> > > > > to correctly finish. Also moving the uboot node down
> > > > > after the first phandle (in test.dts the gpio one) also made
> > > > > the CI test to correctly finish.
> > > > >=20
> > > > > A little bit of searching and debugging made me realize the
> > > > > parse phandle OPs didn't support other.dts at all and they
> > > > > were still referencing phandle index from test.dts.
> > > > > (more info in the related commit)
> > > > >=20
> > > > > In short the test was broken all along and was working by
> > > > > pure luck. The first 4 patch address and fix the problem for good.
> > > > >=20
> > > > > The other 4 patch expand and address the property change for
> > > > > LED boot/activity.
> > > > >=20
> > > > > Posting in a single series as changes are trivial and just
> > > > > to speedup review process. (and also because the second
> > > > > part depends on the first)
> > > > >=20
> > > > > All CI tested with azure pipeline.
> > > > >=20
> > > > > Changes v2:
> > > > > - Fix handling of flat tree for phandle
> > > > > - Fix test and other.dts changes
> > > > >=20
> > > > > Christian Marangi (8):
> > > > >   dm: core: implement oftree variant of parse_phandle OPs
> > > > >   test: dm: fix broken dm_test_ofnode_phandle_ot and get_by_phand=
le_ot
> > > > >   dm: core: implement ofnode/tree_parse_phandle() helper
> > > > >   test: dm: Expand dm_test_ofnode_phandle(_ot) with new
> > > > >     ofnode/tree_parse_phandle
> > > > >   dm: core: implement phandle ofnode_options helper
> > > > >   test: dm: Add test for ofnode options phandle helper
> > > > >   led: update LED boot/activity to new property implementation
> > > > >   test: dm: Update test for LED activity and boot
> > > > >=20
> > > > >  arch/sandbox/dts/other.dts |  31 ++++++++-
> > > > >  arch/sandbox/dts/test.dts  |  16 +++--
> > > > >  drivers/core/of_access.c   |  61 ++++++++++++-----
> > > > >  drivers/core/ofnode.c      | 124 +++++++++++++++++++++++++++++++=
+-
> > > > >  drivers/led/led-uclass.c   |  30 +++++---
> > > > >  include/dm/of_access.h     |  86 +++++++++++++++++++++++
> > > > >  include/dm/ofnode.h        | 107 +++++++++++++++++++++++++++++
> > > > >  test/dm/led.c              |  18 +++--
> > > > >  test/dm/ofnode.c           | 136 +++++++++++++++++++++++++++++++=
+-----
> > > > >  9 files changed, 551 insertions(+), 58 deletions(-)
> > > >=20
> > > > My main issue with the series is a lack of documentation updates, a=
s the
> > > > biggest challenge thus far has been that for example Peter couldn't
> > > > figure out how to make use of this on PinePhone. We generate
> > > > documentation today based on include/led.h for this API, yes? Thank=
s.
> > > >=20
> > >=20
> > > Hi Tom,
> > >=20
> > > actually quite the oppisite, led.h describe how these works and was
> > > instructed to first have the options property merged in dt-schema. [1]
> > >=20
> > > Here we have all the option documented under a yaml.
> > >=20
> > > I notice there is a series from Simon that is also pushing a .yaml
> > > here locally in U-Boot and I was waiting for that to be merged to also
> > > include the additional entry there.
> > >=20
> > > Also led.h description and API have info on where to look about the
> > > handling of /options/u-boot/
> > >=20
> > > I feel the main problem with documentation is currently the fact that=
 we
> > > are migrating to a more robust schema and people are used to using Doc
> > > directory? Anyway happy to get any hint on how to improve this.
> > >=20
> > > [1] https://github.com/devicetree-org/dt-schema
> >=20
> > So Peter, does this bring you what you were asking for in terms of
> > details, or can you explain what's still missing from your point of
> > view? Thanks!
> >=20
>=20
> Hi Tom,
>=20
> any idea how to improve this and get it trought?

I'll pick this up for -next soon, thanks.

--=20
Tom

--MjCxCmlJnCdb754J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTOtYACgkQFHw5/5Y0
tyy9VAwAuhM0D659zXwLhPwJCIWQRKHklGV7xgFc5F7C90M/Nu+1u47biXa1nAOn
t+1Qu+pjMcA5mHM7DJOx+MqFJkNfTUy3QxIfQO6SPFAUEuVjgLQ6Cb2gVeYZ2ycv
Z4QA8Q691Moi/htHjy+mK0VUx6n2/yyPpyExq4WnSKhNRbNnIuHeaCc9cHtK0TKO
4GcvEVRvuIUQymgb7Q00z9mic+oUKZKDSChpew0TpZay2+khQ1gFr56s5OWO4CWT
L1ZjFiSP8SfBDKCIC0rk2cbifQPu7e5tUKk4WHyEjPlxip9UJkO4y3AAPgwl9K0O
nfckqZX2yerVQoB3mKN7Ekd9k8YJmulxB7EobvliEjAU+KL+nCH3FXzpdq6JMB9S
L+UQ3cghI62lO6Qio/S7xpWLJ7muKgez1k8GJoz6T+wqwUppxwVNo7m8VKAvmC9n
+G9x7GaGdYPR4RlL8nwY3mRKtiH3DCak7LY9QWmM1dVHgjQT4bpOD3VuCxTfgSsD
6zdh/rZp
=1xI7
-----END PGP SIGNATURE-----

--MjCxCmlJnCdb754J--
