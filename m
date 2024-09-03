Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A65ACD37AC
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 18:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A71678871E;
	Tue,  3 Sep 2024 20:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="myShs2Bn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45E9288860; Tue,  3 Sep 2024 20:48:13 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F30EA886E5
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 20:48:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6c35618056aso16993816d6.1
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 11:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725389290; x=1725994090; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yy1OD8A+98XrfZDHs05wdwmqXsK9hAcZlt83/tBaVh0=;
 b=myShs2BnRCDqvmhRaaxZEVrHUMFCewNF94BEoAiTYky6ZKOYhh1RFy2FDJoFJFpfxG
 e+uYwXasaeaxUtRXcR3WoIaA3fxsyY26rmbHgIbU4sgusZuo/XNHNJI9StaYUX1EKqUM
 yT6ba7A6M5XHF/CFz/jnnQwqSEcwlLO4dEgiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725389290; x=1725994090;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yy1OD8A+98XrfZDHs05wdwmqXsK9hAcZlt83/tBaVh0=;
 b=gNU2lW1eCsXqYBBGIfRID34Io9X2ffl14lv2TsPCO8LLxiBwSNI2x6xiTEhzqF6Lou
 GzoAYXk1hxr5u7Mtn4N8jUOyk58prlLLcABmenvDWn1WFNh0UCOpH4hvytCYXkU8rtvP
 JYnsRmLrTn9/Dg34T4yNNHjb5lP58+uc6yrGVYizgO4gGhG5UrJYcrRVkLDz/a+2lC8r
 pHV1scCL74b0bOf0PJngoZDd1bhUJbcz4y/PL9wN2u4czU6iHX1b5x6YtXPS+EaMnTMv
 E6qAON/N5Op++cl+0oc4wYn9OMiD4Ch2TaIoqJ+PGCR1mrs0r5fpoA7d0xv604I+bzdp
 CFBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrP8Js42gklBSKEeZjvN4hZfTOgM+9dteC+ZlfbCSn3Que5yH7YMnfxhEBq1G6JqbmAUo/zCg=@lists.denx.de
X-Gm-Message-State: AOJu0YyrVL4/YhbZ9Y5nncQRXsnerRw5XsrlGbjaaHkyOe7zJtD1GxAM
 Fo3o4TkEe5PUKQCZ6JY8IYdAgHsiyVUGFbGkzbpGNV1RGAu+yGlRZ/cGs4zNIZpuUCJW+JQGKYW
 /
X-Google-Smtp-Source: AGHT+IHUCWCDyqHiUFg5aSXBFf7p9QWY3XyzHZLjMUMXJzFSqW35OuUKGzL8/Bc9e75BMahG5VYtdw==
X-Received: by 2002:a05:6214:3984:b0:6c3:5f65:f9d7 with SMTP id
 6a1803df08f44-6c35f65faa0mr97189716d6.36.1725389289750; 
 Tue, 03 Sep 2024 11:48:09 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c36393fd0bsm27852336d6.2.2024.09.03.11.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 11:48:09 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:48:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: neil.armstrong@linaro.org, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 17/20] test: Try to shut down the lab console gracefully
Message-ID: <20240903184805.GK2479150@bill-the-cat>
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-18-sjg@chromium.org>
 <1637be2a-2fa8-4686-8868-077ed430ae8a@linaro.org>
 <CAFLszTjZOjXwY4PXGWkCu-7ehuA_XBCcnjLtmF4hKUC2K-NyNA@mail.gmail.com>
 <20240829165906.GG2479150@bill-the-cat>
 <CAFLszTh4A2NH8d6hocom3pAzYB4ExgVbDRa+6phux7K5P9X4Pg@mail.gmail.com>
 <20240830142620.GS2479150@bill-the-cat>
 <CAFLszTjZmKKQSVTU5rhH_xX-neP1ZWByX96xUNxc-JTOY8R2yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+6fnYWOy08QG3TeH"
Content-Disposition: inline
In-Reply-To: <CAFLszTjZmKKQSVTU5rhH_xX-neP1ZWByX96xUNxc-JTOY8R2yA@mail.gmail.com>
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


--+6fnYWOy08QG3TeH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 01, 2024 at 02:09:58PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 30 Aug 2024 at 08:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 29, 2024 at 07:04:36PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 29 Aug 2024 at 10:59, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Aug 29, 2024 at 09:01:17AM -0600, Simon Glass wrote:
> > > > > Hi Neil,
> > > > >
> > > > > On Thu, 29 Aug 2024 at 08:26, <neil.armstrong@linaro.org> wrote:
> > > > > >
> > > > > > On 29/08/2024 00:08, Simon Glass wrote:
> > > > > > > Send the Labgrid quit characters to ask it to exit gracefully=
=2E This
> > > > > > > typically allows it to power off the board being used.
> > > > > >
> > > > > > Sending those characters every time could collide with other CI=
 systems,
> > > > > > I don't think it's a good idea.
> > > > >
> > > > > What systems are you thinking about and what sort of collision wo=
uld occur?
> > > > >
> > > > > What do you suggest instead?
> > > >
> > > > Why do we need this at all? Did I miss where we send picocom the
> > > > disconnect nicely key-combination?
> > >
> > > When labgrid gets a signal, it exits. It doesn't continue its
> > > co-routines and execute the end strategy to power things off, etc. I
> > > suspect it could be made to do that, but I already have 62 Labgrid
> > > patches, so I thought this would be expedient...
> > >
> > > I can make this conditional on the new USE_LABGRID variable.
> >
> > It sounds to me like we need to make generic improvements to our hooks
> > then, if there's not a "now call poweroff" hook.
>=20
> The thing is, Labgrid has its own internal console, which allows me to
> see all the output from reset. If I use picocom or some other program
> then some of the output is gone by the time I connect, particularly
> when using USB download. Because of that, just killing Labgrid, which
> is what pytest does, is a pretty heavy hammer and leaves things in an
> unknown state. So I added this method to give it a software signal.

OK, but we shouldn't care? You can have the console available to pytest
and a terminal at the same time, with labgrid. If you need to see before
pytest grabs it, have the terminal be the first console, not pytest?
This gets back again I think to your specific way of making use of
labgrid contrasting with just generally supporting labgrid with however
another physical lab has set it up. Does killing one connection really
reset all of them? Or was it just a conflict with your
auto-acquire/release?

--=20
Tom

--+6fnYWOy08QG3TeH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbXWeAACgkQFHw5/5Y0
tyzkMAv+INU43z0xggkdN9kvivzU8DGNK5y403Oe2cs/LsKKq3azO5ws7uK4j9qy
CSwmx4eVufuGz5ggrRK0izmP+dyY0pVEctJBmV981/Nv22NrHLaLtezAdFXO8TyO
NlDfRq4aFl9yFCDWhAVeHmMYd/cyEIvBHJPBDqjoH93Mv5UGMM/awtyjyUj9FfEp
mGmiME+A19tz0i+7+IBNQoLTbokicCRPQ7g9HWDhFyLnd6YH0f5D03BW1fAMp4Ti
xBmG9fAPQSopnQxo7yMv6GLMXwvlP8qQCnCAXEIDLTKEDyytr7MAxE4hhxU+YBKf
7LsLAFlTY1Qp6I97QbxM+NOXEgbaxCuxdZ1S5FJVv2lOv8NKW7P72mKCJYYDagju
iDgIbGhtdjEPQAwLPrFQpWld1LdoFWby/oTRdYDal6bj8nvL4zK8Zg3kLOiQ66ef
l+rIOoaiEd8mZZJsmD5BHlSfPcbzD+Kkw4TRWEW8dDl0Hc5ESzEkb5uEG+TTqeLl
R3fef59X
=qfjz
-----END PGP SIGNATURE-----

--+6fnYWOy08QG3TeH--
