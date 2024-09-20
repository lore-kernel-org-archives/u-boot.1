Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14867CF9C5A
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 16:34:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EF9588753;
	Fri, 20 Sep 2024 18:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lSROUIQD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09496887D1; Fri, 20 Sep 2024 18:34:20 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D894F886DF
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 18:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6c358b725feso15117376d6.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726850057; x=1727454857; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fvo0TY2birhXxxpc7EHY/nU7G2BaiMeEzsYYmds/D0E=;
 b=lSROUIQD+OacMJxd5kbDmVCCV+wQw62OOdVuNhuJOexE/pgs19ucJMSYGTIV6RmcSh
 YPFS73bvo6Sw9VJ2p6GZYtWY7A1EmdE89VCoqS0MSVXeDmSXEyKf/smo2lTPYJW59Nul
 EgaPN+SbSNHCUUDOielO7g0nVl2flEt0kbegk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726850057; x=1727454857;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fvo0TY2birhXxxpc7EHY/nU7G2BaiMeEzsYYmds/D0E=;
 b=el4ne1W1Its8Wni74ZJ73joJZr9Jm3jJy1hB3e4zgCuR4v9i0Qm10ai2UXbjWo8G1f
 PfVOF2eHSXjCNWTGHb0YMcuZ9pfybaOmOSfLg7s0LB9ZIrOtAoh487mIS4cTvtUnmyJu
 lveyJJVgbeUtBh4Mq8Df7E4PIfNpBsRFfakzojpgZAVJ9ewPrhxIBieNwLITBNSlnkvt
 n04DPksIr8htwzDYXmphNc+3AT9CBaXpTxmzdvZGfOCKRhEF1FshfgooD2ucuoJhun7x
 b8h5Rhk/IDDKCUefzt8qK+3cRuMn4qG7pLJ5twOhz3h98tLzXxLNmZTWwesBWcJe/yK4
 tuaQ==
X-Gm-Message-State: AOJu0YxBSXTOpw2P2ttf1hZ1t2zKiylueIG/iQWQECj2pCBN5svHWzOJ
 gaU9JqScMH0N4p7VoY2A9hsWGVTV4nAj0rDqU1PkhLUybqhSLf6Ve66LF130wOE=
X-Google-Smtp-Source: AGHT+IEE/iazq2Vfx77/y0Oc3KF7WP3OLDbIdjR9unrRQHaFB50legPkETE8NfxcZBBx5VEABhXAGA==
X-Received: by 2002:a05:6214:2d41:b0:6c5:9df9:58f9 with SMTP id
 6a1803df08f44-6c7bc6a627amr52400306d6.7.1726850056581; 
 Fri, 20 Sep 2024 09:34:16 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e44bf85sm19641236d6.13.2024.09.20.09.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 09:34:14 -0700 (PDT)
Date: Fri, 20 Sep 2024 10:34:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>
Subject: Re: [PATCH 03/19] boot: Allow FIT to fall back from best-match option
Message-ID: <20240920163410.GF4252@bill-the-cat>
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-4-sjg@chromium.org>
 <20240904222531.GA2479150@bill-the-cat>
 <CAFLszTieSjNrzT4i8pbjDXza==+VhHOG8sSHmU8aDykR3ypZzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="doQDuVUr3BI1xGLU"
Content-Disposition: inline
In-Reply-To: <CAFLszTieSjNrzT4i8pbjDXza==+VhHOG8sSHmU8aDykR3ypZzQ@mail.gmail.com>
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


--doQDuVUr3BI1xGLU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 05:59:00PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 5 Sept 2024 at 00:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 29, 2024 at 08:57:46AM -0600, Simon Glass wrote:
> > > When the best-match feature fails to find something, use the provided
> > > config name as a fallback. The allows SPL to select a suitable config
> > > when best-match is enabled.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  boot/image-fit.c | 19 ++++++++++---------
> > >  include/image.h  |  4 +++-
> > >  2 files changed, 13 insertions(+), 10 deletions(-)
> >
> > Don't we need a documentation update? If no, because this mechanism
> > isn't well documented, can you please follow up with that? Thanks.
>=20
> CONFIG_FIT_BEST_MATCH is mentioned in the spec [1]
>=20
> But re the fallback, I'm not sure where that should be documented.
> Perhaps add a note at [2]?

Should we be using the mechanism that I'd swear the documentation build
process has, to fetch an external document? I think we would have a
better user/developer experience if our documentation explained how to
use a feature, as that's where people will tend to look first.

--=20
Tom

--doQDuVUr3BI1xGLU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbto/8ACgkQFHw5/5Y0
tyz7dQv9EGE2ZE52C07jVhXNxmsMjIwMorTMZGehf4E6KWVrc+OSjc4ueWkaTh/U
sGqm6Ni0UWtTPhomdpHDbYvyJrVQIUzHujY1kdEAyloIdTEoWeCWb+j7Zby1ksjE
zSWRw2z2RGTlELJrM2QXVnYy8kOSrGdbJZqjKF6V/Nx36WOcmcgp8ackblWHkBSy
IiS2V/jCQihRIaFdqcIMwScuBSlk3jJjqj4SseaSuGtHg1zEzqQA0fxGTmnSc8I6
67RTyb7CVQ/GGxpvNX38q211U4HH/vOPAAZE2BMI85ETqcGGUZZq+pp6ZEq475qr
nm8jC4/eJ35cMmHmKby09nnCYmSk3F/0ndI24JkeKedHyEggu98tueO2umeSsAkf
Nkx8Ivm5gF2/4ojNNj8vxglU6cH9PfHAU4jTiWw01j1gen/gT7tjE15gsSlzsJlN
FpYasXzmsuNkWv0uhgpGGHumHIGkuYjXw/GkKfevITxVy1hbcNb2hdnwd33iDVFN
rInIhNlZ
=/pt8
-----END PGP SIGNATURE-----

--doQDuVUr3BI1xGLU--
