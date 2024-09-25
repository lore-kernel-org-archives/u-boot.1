Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA337CCF9E8
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 17:26:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED8BE88C1C;
	Wed, 25 Sep 2024 19:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RODprfOH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 707D088363; Wed, 25 Sep 2024 19:26:10 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 739E188B11
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 19:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7a9ad15d11bso9202285a.0
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 10:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727285164; x=1727889964; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k6fDHNqKXkYFiqQqwDQEPJSy/AjTChMcY8dviW5KNxw=;
 b=RODprfOHx0yaieu1EOPKGnq9vCecoLKJ8XSBImAYqUmHPdas+VcUwEXW4oI9MoHd9z
 wIMJcCouALBrXdk22Wk3o6PqyT4Fu6mIqDhA5n18IgIkWxhbdY/yv9fOV9AqKJD/eyLr
 xbadITLGohMUESj248CCduhsFBGMu4SvN6uok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727285164; x=1727889964;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6fDHNqKXkYFiqQqwDQEPJSy/AjTChMcY8dviW5KNxw=;
 b=R3OmfppND8AXE2aWyPINyo5ROZI+h8/49E0nt19XvgPRLYefZpYklohwxDX25gP7/L
 jXVwUNTUvkDkXTtWfGXKsmjozJ6yQoqHVC8Nioph56MF9mmVE25XgwnDG+GR9jFVzlE1
 gdhbtS6XemtaSOEFjvrIw9K57BAGjF5gFSEBjrNqm/pRMBqiF/EXHrKksUdH5lrDeEY5
 lvtsEzaAcenaHpx9uxZmXBhdqNXpcC4JchnkeYEnsekLySecHFKR4zOi4lY57VDuFfDl
 vfAcn6pn4+fzFAlttMPP2ZX0VHqFL8ux8Q+XUYGtE/JeoYf1O49gUCd9uf3KwW/rgTD9
 zxvA==
X-Gm-Message-State: AOJu0Yx0wtSPJGjUWsTjfKNRi3O4j8Lnvff0mZYL+sexNvtZz14Eqob0
 fcB/0941DdlmCoh39U8YZeWRnd1J3ADijY7H1dGOaXO+fZYYVU40xopYrwD5Xyk=
X-Google-Smtp-Source: AGHT+IFzd1LrXi8II1tRHdsc4pT1dSjXVvjMRafvKIKye8L1KwzSf9VSW+Gk9pFCeD2k0nRDD1X0ZA==
X-Received: by 2002:a05:620a:450b:b0:7a9:bc1c:10b9 with SMTP id
 af79cd13be357-7ace7416c3amr522451885a.33.1727285164259; 
 Wed, 25 Sep 2024 10:26:04 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acde62b3a8sm189532085a.135.2024.09.25.10.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 10:26:03 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:26:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v6 01/19] test: Allow signaling that U-Boot is ready
Message-ID: <20240925172601.GA4252@bill-the-cat>
References: <20240920060158.106612-1-sjg@chromium.org>
 <20240920060158.106612-2-sjg@chromium.org>
 <20240923203512.GQ4252@bill-the-cat>
 <CAFLszTjT3RZYChMhBxUDsf6YC-7cZfh1_YhuQrin3sRanSO=Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+KE24SOC5FH8n2vJ"
Content-Disposition: inline
In-Reply-To: <CAFLszTjT3RZYChMhBxUDsf6YC-7cZfh1_YhuQrin3sRanSO=Xw@mail.gmail.com>
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


--+KE24SOC5FH8n2vJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 02:49:56PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 23 Sept 2024 at 22:35, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Sep 20, 2024 at 08:01:36AM +0200, Simon Glass wrote:
> >
> >
> > > When Labgrid is used, it can get U-Boot ready for running tests. It
> > > prints a message when it has done so.
> > >
> > > Add logic to detect this message and accept it.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  test/py/u_boot_console_base.py | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > What happens is that labgrid can also be told to look for and then
> > interrupt autoboot, just like our pytests can do, and the system is at
> > the prompt. But this is also what it's like for a system with autoboot
> > disabled. Do we actually need this patch to achieve the functionality
> > you want? Doesn't that already just happen?
>=20
> The point of this patch is actually to remove code in pytest, by
> allowing it to skip all the banner-detection stuff. It does not affect
> things in Labgrid, since it still needs to watch for banners, etc.

But you can't remove code from pytest, people can and will run the suite
outside of labgrid.

> Without this patch, we have to tell Labgrid's U-Boot driver to do
> nothing, so that pytest does it. But that is not a good idea, since
> Labgrid has a lot more info about the board than pytest has. For
> example, look at all the SPL-banner-count stuff.

Why do you have to tell it to do nothing? The pytest suite works fine,
today, if the board stops at the prompt automatically. To be clear, the
labgrid yaml file I'm using with my scripts has the information to stop
autoboot in it and it's not causing a problem.

> Basically, without this patch we cannot use '-s uboot' to tell the
> Labgrid strategy to take us to a U-Boot prompt. We must just use a raw
> console with no strategy, relying on pytest to do all the work.
>=20
> I hope that helps explain the problem?

I think I see what you're saying, and it's based on the assumption that
we'll make everyone either use labgrid?

--=20
Tom

--+KE24SOC5FH8n2vJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb0R6kACgkQFHw5/5Y0
tyy5VQv/Qgm0Ef7BcCAvwG+WwSHzJ8dtOxuoczI7qV2Ctk8b009cDgxYepn3SOPy
34KAvbz/o8dHXh0kImYuFXHSlbt3MU31cC4f8voYZ5mDH5mJ3C+sb+eROV5kZAFK
xTCTUD4mb1SrZMhaN95vlOIs8cbsPaGNUkG+GV4SIJH5WEtb/f0G5+iyR0M7/tHp
0vO0Fjo5O3w7EZyOCO8xFo3SYVdIGg7EplRu2ahTTEgkOt64UrimrIlTQOsKqse7
vHbDpRhGhD789x5puzn13nztwz+yHL68GWFH5K8IYB7VCpotbHdW0uU/qm8HgwC0
YV+B6OTUuXJELyDZrpGbzUjXKwihxlclWJc+IASlfOMpFsYrJEH+1Z09y6KAKDty
noIc1Wc/3TCAk4fHwlZPAshhyP2EAg8gHtYsQ+RnQpwzksYJT9TV1slPpl+RMiwD
gMAQNcbAOT4/1mkbl3P8AeQvCbs/nyoOGr4jbsA98HJh5XfGcoI6PcYZmTiIeuvC
N44LkpCF
=Y3h2
-----END PGP SIGNATURE-----

--+KE24SOC5FH8n2vJ--
