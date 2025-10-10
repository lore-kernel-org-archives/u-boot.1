Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7055CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 453DE845C1;
	Fri, 10 Oct 2025 16:35:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Mn8nBF42";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF40845BA; Fri, 10 Oct 2025 16:35:35 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57EA98455B
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-38627e78203so1172935fac.0
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760106932; x=1760711732; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=V4reRm0hPltb+FEoCOXsY9nNS+WS57cemb8WivxsAeo=;
 b=Mn8nBF42LXglXMCGZHi+QXi/fzU9k/YEXDIdzntYnimQw9b7eXUuUFu7NMgk1BaBxd
 8zj9QcoUOlZRwYjtWoab578wtoH4cxN6J6PMNucIRKUVhc2IsH1A9PLb4MI8cdzuyHV7
 RzDmsgMh9c5Iec18+QJmvjYtF2agd3SSkos5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760106932; x=1760711732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4reRm0hPltb+FEoCOXsY9nNS+WS57cemb8WivxsAeo=;
 b=vo9K5RRS2SorrSD9RJPPo5byUecS5ZgICs9JgHJvNXRvcqpE3QKyxnpAAeT7n6mnF1
 DEgo2j3xzVmOulfLBlivkyVRMNVs8aPYw26wAmMP2dCwKygMmUsE8E+7vFHXP6JDjTgL
 o3mwXD25aGFPhb65D42oT1CXpb+3QYq3mBk40qvvQZGprmORzotm4whhAsTqJfuOxEDR
 S+/jCPNPe/eNzccr6VE2UFLKMY3wGy4pUFUzZ0mTfSzZnVFWXWs1UU3bVyEA7Z0bGloh
 EhbtGfhhqwIeStrUh8wYEdeztm2jZSqbWPpUdr0lf4ESJfFPAWn6hOl8W2+woRQp8f8k
 v28w==
X-Gm-Message-State: AOJu0YxzbnJ9zjMwmsPO6GwA+nmf+8tzttA4XzFbjPXgpxk3BIGmsvfu
 t4QE5IIhe6F1ToJOPw6otJWavixoQ/gdGqhKjuBtVgARDbq0Di1LmCmaqXcVxZ6oN10=
X-Gm-Gg: ASbGnct8SNPq65EYVLfsgjEFakLwb3l7s/tdRv/cPQfmlBs7OtzjdzoU3mG5TnLNEWp
 wzoPOyuK2EPYbwcnG0Q+XA/rtL+RjWCI29/iU3+mlRCXwrc6lnxXeJgQU2/LS159sMpv32M/3r/
 blt+2VdBRgipAbPwN0Uzjkmc1qBCzC/Bm1hBnSXUw1pK6Or7Skmj0ougZfYiVbTkSBoMN4Q+8F+
 6Ssyiq8j1q8iFoCiwSsvKjAA8h84cHbtdg+ByTIbTzGO0g24PEzdHV82VShsw8fR8Z8p8WiycKe
 IhyZOraSqEkkqXN1mWymCHpBAQi69KY+Tw5L15ab2v6G6uwBAajc2TgwGOxxbyV24Y+xLXw/EeK
 C0zjOSKxjkIEY+yC8GPJs/c7Mn3gDuAeCAvwG77koEY0qHCNiB97NeWFnMHOYDiI4g+wBElNKy9
 749B8J
X-Google-Smtp-Source: AGHT+IFZvO4zuZEldC57YpE0efLO8a3qjKZqZky5rzpbE5kIzGdi5/pP5lEbex4YF4lGAXyveKfCrA==
X-Received: by 2002:a05:6870:e38b:b0:322:2712:c89d with SMTP id
 586e51a60fabf-3c0f66f6f29mr5367626fac.11.1760106931934; 
 Fri, 10 Oct 2025 07:35:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8f2e7a9sm913806fac.24.2025.10.10.07.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 07:35:31 -0700 (PDT)
Date: Fri, 10 Oct 2025 08:35:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v4 3/4] boot: Add more debugging to iter_incr()
Message-ID: <20251010143528.GZ298503@bill-the-cat>
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-4-sjg@chromium.org>
 <20251009173052.GQ298503@bill-the-cat>
 <CAFLszTi2HuZLmebJB+kUsL3_J+aqVdCdP5XFSEoY1Dy5C3E2wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NVFPUlwLDJJIPqD3"
Content-Disposition: inline
In-Reply-To: <CAFLszTi2HuZLmebJB+kUsL3_J+aqVdCdP5XFSEoY1Dy5C3E2wA@mail.gmail.com>
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


--NVFPUlwLDJJIPqD3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 11:36:10AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 9 Oct 2025 at 18:30, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Oct 09, 2025 at 03:29:54AM -0600, Simon Glass wrote:
> >
> > > This function is the core of the bootstd iteration. Add some debugging
> > > for the decisions it makes along the way, to make it easier to track
> > > what is going on.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  boot/bootflow.c | 23 +++++++++++++++++++----
> > >  1 file changed, 19 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/boot/bootflow.c b/boot/bootflow.c
> > > index 78df09f369d..de69e27bec7 100644
> > > --- a/boot/bootflow.c
> > > +++ b/boot/bootflow.c
> > > @@ -193,8 +193,10 @@ static int iter_incr(struct bootflow_iter *iter)
> > >       log_debug("entry: err=3D%d\n", iter->err);
> > >       global =3D iter->doing_global;
> > >
> > > -     if (iter->err =3D=3D BF_NO_MORE_DEVICES)
> > > +     if (iter->err =3D=3D BF_NO_MORE_DEVICES) {
> > > +             log_debug("-> err: no more devices1\n");
> > >               return BF_NO_MORE_DEVICES;
> > > +     }
> >
> > Thinking more about what I said in the previous iteration about git
> > blame history, ones like this should be log_msg_ret (the history on
> > "when did the test for =3D=3D BF_NO_MORE_DEVICES come from is unchanged=
, but
> > now you can have debug statements when enabled).
>=20
> Yes we can add that as well, but I still want to have the log_debug()
> as this doesn't require enabling CONFIG_LOG_ERROR_RETURN. That feature
> produces a lot of output even in normal operation since it shows
> errors dealt with by higher level code. It is really only designed to
> find the source of a particular error when you are stuck.
>=20
> >
> > [snip]
> > > @@ -228,11 +234,15 @@ static int iter_incr(struct bootflow_iter *iter)
> > >
> > >       if (iter->err !=3D BF_NO_MORE_PARTS) {
> > >               /* ...select next partition  */
> > > -             if (++iter->part <=3D iter->max_part)
> > > +             if (++iter->part <=3D iter->max_part) {
> > > +                     log_debug("-> next partition %d max %d\n", iter=
->part,
> > > +                               iter->max_part);
> > >                       return 0;
> > > +             }
> >
> > Shouldn't this be a debug message instead in the caller?
>=20
> I am trying to log_debug() every exit from this function...so you can
> see the entry and then which path it took.
>=20
> >
> > [snip]
> > > @@ -326,8 +336,13 @@ static int iter_incr(struct bootflow_iter *iter)
> > >       }
> > >
> > >       /* if there are no more bootdevs, give up */
> > > -     if (ret)
> > > +     if (ret) {
> > > +             log_debug("-> no more bootdevs\n");
> > >               return log_msg_ret("incr", BF_NO_MORE_DEVICES);
> > > +     }
> >
> > Then do we actually need both a log_debug and a log_msg_ret?
>=20
> Please see above.

I guess my question is, but why? Is this something that's going to be
debugged frequently? Why doesn't every function have meaningful text
string log_debug messages, just in case? And then why bother with
log_msg_ret at all?

--=20
Tom

--NVFPUlwLDJJIPqD3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOkZsAAKCRAr4qD1Cr/k
CpHoAQCyRCwld3tFZ1RBYiyT2cODxZuvl+B4Hds17rTdylBNDwD+OwMRUHT9IihN
7lHEMwH3VoRA+TAA7jM4ktWSW4G8HwU=
=Rr9/
-----END PGP SIGNATURE-----

--NVFPUlwLDJJIPqD3--
