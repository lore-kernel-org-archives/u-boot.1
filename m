Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAC2D767F4
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:28:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C5E388E0F;
	Thu, 31 Oct 2024 19:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NGp2CSyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F23FA88E67; Thu, 31 Oct 2024 19:28:29 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5B8B88B9F
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:28:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b14554468fso80929785a.1
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730399306; x=1731004106; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nKVXWS82uuvgYTw/5QcCkjAqSAPTA0QjN9AuKz+R9Fc=;
 b=NGp2CSyNNCIOzCrxF7NbFjIo85eYf2ZzGhDReRscqUL/QzVkRAnubQu+eTmGl6R8c8
 H/oh7BBqjZfLYSITIplOdoGYa98IDqncf1sqvnxHoq1n9Hje4qXyrlT8T7+1nsiS9K1y
 ipwni6aWTJeI6o382o393XIIXsgAkuMLM1618=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730399306; x=1731004106;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKVXWS82uuvgYTw/5QcCkjAqSAPTA0QjN9AuKz+R9Fc=;
 b=gS8RvOj2StVai1Xe6YC/Fpv+1xsgy64TPA3QFo4De9VvN/L0c97dHFKiJ95aebkE/E
 A62BZ9pGy3s0qOxAgAotEWjKha2c+far8Pi+jeMwU5Ft+4XLXj3+Sml8TQoj0T/Eh6+h
 SE7RVUa5THHmQXQftVTyqa9xq5RL8UKiiIvZfi1wIrJLlXzMmq6uFnirU4suqmf9BxDJ
 A478GMtnQSvGXeTw0Y2xDbG2I0F76DoMkgoNVvqQC9gG8b5xxcGI4InDF5RreJMl65Z3
 vyPFwpWrRMt5ijpkAUilwFRbx5BKXIpmEA6NbzypjzNhNBJkd+sSL72sZAR1G4z+OdGQ
 dz3Q==
X-Gm-Message-State: AOJu0YxDSY8m/4QP/mGh0AR3/ZGB9PVt9yvAHdylNcDXIXJzyzWl1w2E
 ul+uCn6Vdb4GdAt7zBJZHvgU4RBd9Z4nZyt4kAaYjEOOpCYD2weyBa9ikTZ8FZc=
X-Google-Smtp-Source: AGHT+IEuyBbosm6w52DFb55zmPyWfZyJYKi4oZR3mjrl0kQoeLKSKCPHWCbdux0LjBJaMam2hYFzcA==
X-Received: by 2002:a05:620a:46aa:b0:7ac:a842:87c5 with SMTP id
 af79cd13be357-7b193f7534bmr2823557485a.66.1730399306385; 
 Thu, 31 Oct 2024 11:28:26 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f3a709fbsm93316385a.75.2024.10.31.11.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 11:28:24 -0700 (PDT)
Date: Thu, 31 Oct 2024 12:28:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v6 01/19] test: Allow signaling that U-Boot is ready
Message-ID: <20241031182822.GA3600562@bill-the-cat>
References: <20240920060158.106612-1-sjg@chromium.org>
 <20240920060158.106612-2-sjg@chromium.org>
 <20240923203512.GQ4252@bill-the-cat>
 <CAFLszTjT3RZYChMhBxUDsf6YC-7cZfh1_YhuQrin3sRanSO=Xw@mail.gmail.com>
 <20240925172601.GA4252@bill-the-cat>
 <CAFLszTjFMRpfwFVPJ=-xqKUu=XbH=hq+yP+N17TuFd2b8+rt4g@mail.gmail.com>
 <20240927025159.GR4252@bill-the-cat>
 <CAFLszThvvU8uEYSBh_F6NQViNJ+bFr6mMYzd8yrTAwOp9dhLLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FkvC1d5Iqk3+K1Dw"
Content-Disposition: inline
In-Reply-To: <CAFLszThvvU8uEYSBh_F6NQViNJ+bFr6mMYzd8yrTAwOp9dhLLw@mail.gmail.com>
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


--FkvC1d5Iqk3+K1Dw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 07:03:19PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 27 Sept 2024 at 04:52, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Sep 26, 2024 at 11:36:00PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 25 Sept 2024 at 19:26, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Sep 25, 2024 at 02:49:56PM +0200, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 23 Sept 2024 at 22:35, Tom Rini <trini@konsulko.com> wrot=
e:
> > > > > >
> > > > > > On Fri, Sep 20, 2024 at 08:01:36AM +0200, Simon Glass wrote:
> > > > > >
> > > > > >
> > > > > > > When Labgrid is used, it can get U-Boot ready for running tes=
ts. It
> > > > > > > prints a message when it has done so.
> > > > > > >
> > > > > > > Add logic to detect this message and accept it.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > (no changes since v1)
> > > > > > >
> > > > > > >  test/py/u_boot_console_base.py | 9 +++++----
> > > > > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > What happens is that labgrid can also be told to look for and t=
hen
> > > > > > interrupt autoboot, just like our pytests can do, and the syste=
m is at
> > > > > > the prompt. But this is also what it's like for a system with a=
utoboot
> > > > > > disabled. Do we actually need this patch to achieve the functio=
nality
> > > > > > you want? Doesn't that already just happen?
> > > > >
> > > > > The point of this patch is actually to remove code in pytest, by
> > > > > allowing it to skip all the banner-detection stuff. It does not a=
ffect
> > > > > things in Labgrid, since it still needs to watch for banners, etc.
> > > >
> > > > But you can't remove code from pytest, people can and will run the =
suite
> > > > outside of labgrid.
> > >
> > > Yes, that's right. I meant that with Labgrid the code is not used.
> >
> > OK. I still think this (and I assume the related flag to tell whichever
> > helper that was that the platform is ready to go) are too implementation
> > specific.
>=20
> OK, but it does have the virtue of working properly on all the boards
> I have, rather than just a subset, without this patch.
>=20
> >
> > > > > Without this patch, we have to tell Labgrid's U-Boot driver to do
> > > > > nothing, so that pytest does it. But that is not a good idea, sin=
ce
> > > > > Labgrid has a lot more info about the board than pytest has. For
> > > > > example, look at all the SPL-banner-count stuff.
> > > >
> > > > Why do you have to tell it to do nothing? The pytest suite works fi=
ne,
> > > > today, if the board stops at the prompt automatically. To be clear,=
 the
> > > > labgrid yaml file I'm using with my scripts has the information to =
stop
> > > > autoboot in it and it's not causing a problem.
> > >
> > > But if it wasn't causing a problem I would not have invented this
> > > annoying scheme.
> >
> > Well, I honestly thought it might be a remnant from development that
> > wasn't needed once everything else was done. I do that from time to time
> > myself.
>=20
> OK.
>=20
> >
> > > For several boards, by the time pytest gets to see
> > > the output it is too late to press a key and stop.
> >
> > Why / how? Do we perhaps need to adjust the timeout upwards, slightly?
> > Especially in light of the changes you also did to detect a "dead" board
> > and so we don't wait 30 minutes for a test run to fail.
>=20
> Why / how - because the board prints its SPL banner as soon as reset
> is released, then waits for U-Boot proper to be sent, at which case
> the U-Boot banner is sent .Then labgrid disconnects from the console
> and runs microcom, which connects to the console over ser2net and
> misses some of what has already been sent.
>=20
> This is actually a fundamental problem, not something we can adjust
> with timeouts.

Wait, what? *Labgrid* is the thing that's the problem here with dropping
the connection to the board and re-establishing it at some point?

That is the kind of detail which (a) needs to be in the commit message
(b) perhaps an issue filed (or if already exists Link:'d in the commit
message) and (c) would have made it clear why we need this work-around
and then I'd have been a lot happier to accept it as a work-around back
on v1 or so.

> > > Also, some boards
> > > have a different prompt which is not detected by pytest.
> > >
> > > For example:
> > > configs/am62x_beagleplay_a53_defconfig:CONFIG_AUTOBOOT_PROMPT=3D"Press
> > > SPACE to abort autoboot in %d seconds\n"
> >
> > Yeah, I had forgotten that as I turn that off along with turning on
> > other tests via config fragment, on that platform. That really is a
> > deficiency in our pytest version of this.
>=20
> OK
>=20
> >
> > > > > Basically, without this patch we cannot use '-s uboot' to tell the
> > > > > Labgrid strategy to take us to a U-Boot prompt. We must just use =
a raw
> > > > > console with no strategy, relying on pytest to do all the work.
> > > > >
> > > > > I hope that helps explain the problem?
> > > >
> > > > I think I see what you're saying, and it's based on the assumption =
that
> > > > we'll make everyone either use labgrid?
> > >
> > > Not at all. I tested this version of the series again with my
> > > pre-Labgrid lab and it works fine. But I do believe that the hooks
> > > that pytest has are not ideal for use with Labgrid.
> >
> > OK. But, why can't you make use of the labgrid functionality to pause
> > the board? It's the state flag for labgrid-client yes? Dropping that in
> > with my labgrid support would be just a tweak to the console script to
> > check if the board set labgrid_strategy or something, and I think you
> > could adapt yours to that too?
>=20
> I am really not sure what to say here. I have explained the reality of
> the situation. I have spent hours debugging it and figuring out the
> root cause. There is no other tweak I can think of that will solve
> this problem.

Well, I hate to get on a tangent here, but I think a common thread is
that after you've spent hours debugging a problem and working out a
solution you then omit much of the details. I'd much rather see a much
longer commit message here describing the problem, or a longer
description under the "---" where you explain that labgrid uses minicom,
gets things up, drops the connection and uses ser2net and so there's a
chance we miss messages and so need something like this. Or, that you've
been debugging on *x86_64* a bunch of EFI_LOADER things and off the
shelf distributions aren't working (and ExitBootServices() is where you
had a problem with Ubuntu I gather still on x86_64).

>=20
> Regards,
> Simon

--=20
Tom

--FkvC1d5Iqk3+K1Dw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcjzEIACgkQFHw5/5Y0
tywMfgv/UbznmDI57z/GfmmH/ILW1MIU6o/pi8DJL7WIVaOeNYoK9MdUYEUKcUtP
d0ko9KUWgsiPMiRPIXHO5POHy5c8uy7D9/Z5H7kuRBnLXQvO2CKGqkzSjoc5TuZs
szR6PV3td3HzmPWMBRjoVAihh2n6SWn0pAWc2lUTI+D+xoMG4g064W3z6vN1razP
ldTcR7ww9kehwG1MN8GqRxcz1aBgXsFqHqghpeqae80IUk93sHr0w1uKMYZ9vdVH
rkidUsvQ+8otpy3J3o1Mv5d4SZ8EN8yP87+/uQCaHnJjM+LD2EmT5bh+ryImul5Z
u2SxFMLiASv3UlgcUFPjhvKsiMzSBjAc89qder/Wt/IvAOheg1PDpzpTyZT3utCy
twiO9nFgTku8OjWDrtp70TSHBQdo9qPZv2VuNR3n2JmhknLBV3+bgI2h0aTWU5au
UqGlIu3SMHLnAIdIqhae8zu3x5I0zQzqlR+ymuXGPA4AQklafClT3KC4MQA5uMMa
0/9sH00I
=n/Qc
-----END PGP SIGNATURE-----

--FkvC1d5Iqk3+K1Dw--
