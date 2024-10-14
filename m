Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A655FD18153
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 21:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DBE88918F;
	Mon, 14 Oct 2024 23:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZjIb+B7q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28C708918F; Mon, 14 Oct 2024 23:55:03 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF65D87DC7
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 23:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-46042895816so58980321cf.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 14:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728942900; x=1729547700; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=17JyVeRJe+zqcCiLRv2KB1aQ6HtSCzBoW8BnOb/nIK0=;
 b=ZjIb+B7qalM7aFiOg9Sawake1BHzTmy8Hs7m28zCoCpJ7LsNMSgoujBDV6j/T/lNcM
 5uEX7BSS7EvHxoQu52OlCYvYW+FZ003ZSh3KXsvcZL0A/CoHAHSce7CH1KHMaR7G6Y1w
 AV+r+EdfOHYUQlUhkGmw08zD3pXrY94bwqRrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728942900; x=1729547700;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17JyVeRJe+zqcCiLRv2KB1aQ6HtSCzBoW8BnOb/nIK0=;
 b=r95YIKIuzIhlX5zrxZNwReuv0f2gFra5bEqIgky/gDhw94f5DUeF3lNwhe6uS6Qk95
 pXbMBaBl35Zj6vf5QRG2at9zxK/cEJbM7M/7X8DDX09thQASVgEndRGqfroYEV92nped
 5VVEC0XYNEv7v0RPuC6LrmJK5vBVsEmba41AI/JRuHs1TgJsByv6n2exfLvbclyh1laA
 ml6LE8C1BjQIez/CFpC2YugXM6ix6o3JeTs0zPDuwuKlHJ1aH+Fm2ODDq8aO4HHWNpR3
 gWbCU7Ww9Bn8cuhedK9CdfooQBoRxljnF3hxV9abUN2LnZYmTtb7bo4G+IefngGElViG
 M83A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQiVlMaPXXmRAKqBp327Ip7UCxqvV+zdhNliAY+rItvVqjE3EkIRCMRiE0ANl4DD2XOyIincM=@lists.denx.de
X-Gm-Message-State: AOJu0Yyqy+RVXm8hc/RvfWjtzKTsG/4MSjOWfUISSBa/7KVI/t/QcD9i
 MfPf5ngFyLa/8xB8Oa4BPn/fjuUdaLIhj6bGOosNd/hZYylrp7HHJTAFcPGQAJw=
X-Google-Smtp-Source: AGHT+IG0JUVUawnblk3VIw3qgz3p4o/KWvKtgTiBkYQrp8QhOI9If69v5Z4MMflMjjFpOh21oulikw==
X-Received: by 2002:ac8:5dca:0:b0:458:3c2a:1d6f with SMTP id
 d75a77b69052e-4605846ed60mr153259511cf.31.1728942899665; 
 Mon, 14 Oct 2024 14:54:59 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b114955fcesm460689085a.73.2024.10.14.14.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 14:54:58 -0700 (PDT)
Date: Mon, 14 Oct 2024 15:54:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: Re: [PATCH v4 4/5] efi: Reserve some memory for initial use
Message-ID: <20241014215454.GF53053@bill-the-cat>
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-5-sjg@chromium.org>
 <71ECC011-77EC-4308-AFE5-0E301BC27F84@gmx.de>
 <20241012012716.GE14210@bill-the-cat>
 <CAC_iWjL_YQ24ZecbN7oC-37PRR6iuUiiui-a0VPqSSVRunepdQ@mail.gmail.com>
 <CAFLszTjzHBtR8vzk0wT-nNiwbsotqskVhVEX0ibh-Uea1+Da6Q@mail.gmail.com>
 <20241014214236.GB53053@bill-the-cat>
 <CAFLszTi8iJRMBVd79JLumPVz3VB0A8w1v_ZM2pP9D_cp_nx3yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WAU+0UTGEy7SBTPT"
Content-Disposition: inline
In-Reply-To: <CAFLszTi8iJRMBVd79JLumPVz3VB0A8w1v_ZM2pP9D_cp_nx3yg@mail.gmail.com>
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


--WAU+0UTGEy7SBTPT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 03:50:51PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 14 Oct 2024 at 15:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 14, 2024 at 02:19:56PM -0600, Simon Glass wrote:
> > > Hi,
> > >
> > > On Fri, 11 Oct 2024 at 23:47, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Tom
> > > >
> > > > On Sat, 12 Oct 2024 at 04:27, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, Oct 12, 2024 at 12:01:54AM +0200, Heinrich Schuchardt wro=
te:
> > > > > >
> > > > > >
> > > > > > Am 11. Oktober 2024 23:21:25 MESZ schrieb Simon Glass <sjg@chro=
mium.org>:
> > > > > > >The 'point of cooperation' is where U-Boot starts allowing EFI=
 to use
> > > > > > >memory outside of the U-Boot region. Until that point, it is d=
esirable
> > > > > > >to keep more below U-Boot free for loading images.
> > > > > > >
> > > > > > >Reserve a small region for this purpose.
> > > > > >
> > > > > > Your commit message provides no clue why this should be needed.
> > >
> > > Yes, I hadn't realised that people didn't understand what I was
> > > getting at. Tom asked the same question on irc.
> > >
> > > It allows us to separate the lmb allocations from the EFI allocations,
> > > so we don't need to have them both in sync. We use lmb for loading
> > > images, then EFI takes over and does what it likes, respecting the
> > > existing lmb reservations.
> >
> > But, again, LMB is not for loading of images. It's for dealing with
> > memory reservations of various types.
>=20
> Up until recently, I believe, my statement was true, but in any case,
> this isn't gemaine to the issue here.
>=20
> The point is, this is a useful distinction, allowing us to avoid the
> complexity of keeping them in sync, and avoid putting this pain on
> people who are not using EFI. We are either in U-Boot code, in which
> case lmb rules, or we are going into an app, in which case EFI rules
> (but must read in the lmb info).
>=20
> We are going to end up with people turning off EFI_LOADER because it
> behaves so badly.

Frankly, in hind sight I should not have agreed to split the LMB rework
between "everything else" and "EFI" in hopes that we would then be able
to get the "EFI" part of this agreed upon. It's "behaving badly" right
now because we merged half of the changes in the hopes that we could get
your agreement on the rest of them fairly quickly. This is not
happening, however.

--=20
Tom

--WAU+0UTGEy7SBTPT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNky4ACgkQFHw5/5Y0
tyzo+Av8CEhujR4CbTrIuk5A9SzfvFTGVNgniE15RMJM8QRIDa15CAOMBWQOiNUt
jkpa0ktrhNvg8TskEmSmZGKktIq8mwuR6v9iaWTfoDrQhMsROfGc1VgzE4of7Aet
eeeulBsln6MnfE0ImDwdg8SrAZsDB+b8UAWt0TCHi93tNvoIdutkTdvorIwoUyq1
Y7cjmGsDf6dZLCPAO4SgT6t/nkoR3mdvpKdu1eRq6SrNdN7zRc5cpf+ycsjgqwAq
iULUWnQlipYxl3w+LAfKb0TxltrJeas6/lsCfjpl85/ABA0/q1Pf/4JO1N9SyUoq
iVDvBTU94YIiRPHmz36M18HCoJW/lIJxt3LLkmsv7oYJ4I73ihHgRI1DOIIh47sF
lXdRFaOXtRAI/Po3MAPcIMagWJHl04p0dnDLNuk8T3IOXzn3oIRjOo0FLedpe8zB
2dtsWpOaYAvotO263P/vY8vzX29A3FezdZJajdocMsWEVtHS7Eiw9Dfjhw/jp4jK
jMqpz0zW
=arb7
-----END PGP SIGNATURE-----

--WAU+0UTGEy7SBTPT--
