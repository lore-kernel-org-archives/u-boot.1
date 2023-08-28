Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E80C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 15:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F18FD864D3;
	Mon, 28 Aug 2023 17:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HhFaqKsA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAE3F864F4; Mon, 28 Aug 2023 17:50:15 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D0A7864C4
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 17:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-59205f26e47so38708107b3.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 08:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693237812; x=1693842612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R9cYFTKpPN4u9rogYlWaKkJnQbolGkl/coCRuBa0su0=;
 b=HhFaqKsAmzVKhp5wMgL5JLU/YQ3I4jLhLloC31/5LZnXHv/T4eMB7udoQmvpWQSIcX
 fvZLMfulGS7VJ+hUMChQkQIvzLfhlk5StHMAkrsNYovqcW4rnoURyA7HZuqZ0cckCS+/
 6Q1emlNRjechjOiFacwIpwZwsSMERztRK7RvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693237812; x=1693842612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9cYFTKpPN4u9rogYlWaKkJnQbolGkl/coCRuBa0su0=;
 b=OE1gN70nmrUZTmoyc6qj4q18aUmqkQSU68peCLHwQcfUv22988oR3AEt003udcNYwc
 CqkqsuoE05CDt05Sm1szVlIrXNN0OGE6j2HkKeWpFMc0UthN0KthTJm45WxGrSn4CVN8
 npnp13P9vqrIOf0cVxVpDV+HnXt8mt5aiGN955GWoEfp3z+pTAveYyLTT95OyRZZH/wr
 vLR0buUovDoYo8ptoPPos3xkrTGu4AHf2lBeQFtFw0iB6B5iKMFAp4ebt9BKYaAZdDQ3
 /dCeGKdeiiXuRkugR3Je1RO9exACDYobdfYH/xoT+v52M1nj1JP8pAy0EF4ujX1uzx1o
 dZrw==
X-Gm-Message-State: AOJu0YxJcsMWyZ56opeTLhObGnXk9NL84HJ4b/DdgbnJVxZwswIhVxjc
 sZNI4ssDLsL+pvnShHZuMzfe/A==
X-Google-Smtp-Source: AGHT+IFHk5lYuN2sjJfHU+wxe0iqk3xjgHRJmmnhz5s9ugD7imsjdYJQqhqvIZvrFvddUQOSjGS9ig==
X-Received: by 2002:a25:d2c4:0:b0:d07:5b87:ec56 with SMTP id
 j187-20020a25d2c4000000b00d075b87ec56mr25436016ybg.14.1693237811889; 
 Mon, 28 Aug 2023 08:50:11 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c01a-9a8d-1e42-2ea4.res6.spectrum.com.
 [2603:6081:7b00:6400:c01a:9a8d:1e42:2ea4])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a5b0a02000000b00d43697c429esm1631430ybq.50.2023.08.28.08.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:50:11 -0700 (PDT)
Date: Mon, 28 Aug 2023 11:50:09 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, u-boot@lists.denx.de,
 lukma@denx.de, seanga2@gmail.com, git@amd.com
Subject: Re: [PATCH] clk: Dont return error when assigned-clocks is empty or
 missing
Message-ID: <20230828155009.GG3953269@bill-the-cat>
References: <20230711095128.19086-1-ashok.reddy.soma@amd.com>
 <32e261a0-f4eb-04f4-f31a-33414a292146@amd.com>
 <20230825143959.GH3953269@bill-the-cat>
 <3d815d7d-a091-6f58-9d3d-c65e9eac8f41@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GBfgtF4/a1CJteAv"
Content-Disposition: inline
In-Reply-To: <3d815d7d-a091-6f58-9d3d-c65e9eac8f41@amd.com>
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


--GBfgtF4/a1CJteAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 12:25:30PM +0200, Michal Simek wrote:
>=20
>=20
> On 8/25/23 16:39, Tom Rini wrote:
> > On Fri, Aug 25, 2023 at 09:15:09AM +0200, Michal Simek wrote:
> > > Hi Tom,
> > >=20
> > > On 7/11/23 11:51, Ashok Reddy Soma wrote:
> > > > There is a chance that assigned-clock-rates is given and assigned-c=
locks
> > > > could be empty. Dont return error in that case, because the probe o=
f the
> > > > corresponding driver will not be called at all if this fails.
> > > > Better to continue to look for it and return 0.
> > > >=20
> > > > Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> > > > ---
> > > >=20
> > > >    drivers/clk/clk-uclass.c | 8 +++++++-
> > > >    1 file changed, 7 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> > > > index dc3e9d6a26..f186fcbcdb 100644
> > > > --- a/drivers/clk/clk-uclass.c
> > > > +++ b/drivers/clk/clk-uclass.c
> > > > @@ -329,7 +329,13 @@ static int clk_set_default_rates(struct udevic=
e *dev,
> > > >    			dev_dbg(dev,
> > > >    				"could not get assigned clock %d (err =3D %d)\n",
> > > >    				index, ret);
> > > > -			continue;
> > > > +			/* Skip if it is empty */
> > > > +			if (ret =3D=3D -ENOENT) {
> > > > +				ret =3D 0;
> > > > +				continue;
> > > > +			}
> > > > +
> > > > +			return ret;
> > > >    		}
> > > >    		/* This is clk provider device trying to program itself
> > >=20
> > > What's your take on this one?  I didn't get reply from Sean.
> >=20
> > I guess, what's the validated upstream dts where this is the case?
> >=20
>=20
> It was found by incorrect DT. It means I don't think there is any DT which
> contains this issue.
> But that being said we can extend current clock tests to cover this case.
> Please look below.

Well, if the DT is invalid (and yes, we can't easily run the validation
suite in U-Boot today), I'd rather go with a debug we can optimize out
so that the next person with an invalid DT can more quickly find their
problem and we don't work-around it instead.  Or am I missing something?

--=20
Tom

--GBfgtF4/a1CJteAv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTswjEACgkQFHw5/5Y0
tyxr7gv/e8S23jcVwTTlF8rfp8P9JMQ5dk4PyF6npE2fqFHFzegNaWGVQjb6L9B5
E1pkw3EUbc3A/ryArZLnRZQMU0dk9+Fff3WhyGKvDvn3id/SdA/Gz8AiTT9qQRWj
bMwQXyNrr7ZYygh/cs3G2z5nZZByUpkRxOD/rsAuFesTWclHqI5J0KkVDzlgtXd2
LSe83jhsWPVM/cpDKVI3H4cWJvRgG/djxxrCtxZWcYnmkQfXEL9Z7bdXseOnahcC
sG+479gTiek0KLcnRzdy3qdPnvtQv+dzzItNQftqADOHfv9GFkGpzoMb0aVSe2W2
z0hiA61zFzz3kvFztsMgBxmfNDgkP6XTa1kA6V/2UCfrYVkSFnzQtMtLpE6TDr43
rrdFToSoU5KnTg4YA4GjkAWbeDlV7aIt14qUcrARAko+ecCNIzEFXY38uf5F6sKl
klSwfdilOlOcLr7xQ8LGjb+vbUZ3LCZuBzCd1IuT02llO7/5STpqvXoMHu58baEN
oxmxSzbH
=gyTC
-----END PGP SIGNATURE-----

--GBfgtF4/a1CJteAv--
