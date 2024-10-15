Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06813D1F9C2
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 19:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2587488770;
	Tue, 15 Oct 2024 21:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j+MD9sk4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 265D4883D4; Tue, 15 Oct 2024 21:05:21 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B348899C
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 21:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b13bf566c0so48366185a.3
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729019118; x=1729623918; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CEnK64WsUOerdmav+xkjmPk5cf87g/udNyvugzvnS0Q=;
 b=j+MD9sk4S0NPYgRf4kJJIM+E6Tng8vr7+XnC7hjAzYK/jVfaF5AvK4RKmaBPnxT3JF
 FybdYQ3BDUF6WfbiCF8EYPilNd4Yy08PgJJD8LaiULh7rNn6nkKdve/svH9gXFrZLy86
 aXF9wjjSg75vgnDJRyosW/5iQ6F0mQkL8bEcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729019118; x=1729623918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEnK64WsUOerdmav+xkjmPk5cf87g/udNyvugzvnS0Q=;
 b=o24Ev+gNt1wX/syLb6JIvzmaKa+PVbcZjF6tUbijWjqia223A1Bodl3Fmmx3alPlHd
 j5x4vCAjRbeoWXSC+s6hXr8yEtVDBUrWfH7xF73wKO+8szYDiEbv2FAZbKYDAaJUnTV+
 I3sVoHzIMJdpRPUEiY/DS+ljdz6BRPYzwENDhbKY5NCqhtoRKhnj7ct43Jf1fgeLwIeJ
 xvLMOsFr9QkW72Sk9F1yMSncmBshk5VCRUDECNLWegC4mSpyRrdT/j85R+TAdewK4vTC
 Jb8jrlraDuG0Nkik/MoM/wkYaeSjkTHAAkPTLRHaRPGg166LZcC/qMoru89YH6Esef/X
 mc6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn4j2OYP2cK+V/rZRDxq2hC3wAhE7C3BJNjic5bGL4j1Q2PEmKoro0tuaj+iFbUFH/fR3bUyI=@lists.denx.de
X-Gm-Message-State: AOJu0YzIfffDCr3Cze9t9C9TctAYA6AuVUpP1Qyf+n20IDnNw0Wwnnnx
 Uzkr18ShZ19VpfWJIXFIC05iFJoBELg1Ji6aKB/MQ7qKOlHoAqDviDLxXSXjvPY=
X-Google-Smtp-Source: AGHT+IFX1jvs+6uEtCOaxmAHP8IGn6BxhKDP4KeD7GzLoYLUbuxLXGIqqUIuyK1/CzzNa4aHoVBrxQ==
X-Received: by 2002:a05:6214:5905:b0:6cb:be91:6ab5 with SMTP id
 6a1803df08f44-6cbf0044c7fmr271927016d6.17.1729019117459; 
 Tue, 15 Oct 2024 12:05:17 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc229245fcsm9914486d6.58.2024.10.15.12.05.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 12:05:16 -0700 (PDT)
Date: Tue, 15 Oct 2024 13:05:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 03/15] efi: memory: use the lmb API's for allocating
 and freeing memory
Message-ID: <20241015190513.GR53053@bill-the-cat>
References: <20241014155642.GO53053@bill-the-cat>
 <CAFLszThVP_OgyTt_ksJ1_7HAHT+K-wcixWB+k+fmzAjh6+5Bmg@mail.gmail.com>
 <20241014210453.GU53053@bill-the-cat>
 <CAFLszTgm=t=y1kj7Ju5Ls7nf0ghLCqRppVnY7yorD6v1hoeN1g@mail.gmail.com>
 <20241014212718.GZ53053@bill-the-cat>
 <CAFLszTiW_N-DvivnC_Fq4LWv+H+S2h8A-8o5dXPtGMsii1ToxQ@mail.gmail.com>
 <20241014214841.GD53053@bill-the-cat>
 <CAFLszThxdPd7ty2=X66ZRWopzE0R1ChhdRZzah5tYLS+FvZ-Jg@mail.gmail.com>
 <20241014230725.GH53053@bill-the-cat>
 <CAFLszTj6y-aC=bJ+9c8un+=zG=yGb7bs60wPzDOeMVAKMgVchQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S5mAnEtUaaErLW/3"
Content-Disposition: inline
In-Reply-To: <CAFLszTj6y-aC=bJ+9c8un+=zG=yGb7bs60wPzDOeMVAKMgVchQ@mail.gmail.com>
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


--S5mAnEtUaaErLW/3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 07:10:27AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 14 Oct 2024 at 17:07, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 14, 2024 at 03:55:05PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 14 Oct 2024 at 15:48, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Oct 14, 2024 at 03:35:12PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 14 Oct 2024 at 15:27, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Oct 14, 2024 at 03:13:01PM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 14 Oct 2024 at 15:04, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Mon, Oct 14, 2024 at 01:13:17PM -0600, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Mon, 14 Oct 2024 at 09:56, Tom Rini <trini@konsulko.co=
m> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Oct 14, 2024 at 09:50:37AM -0600, Simon Glass w=
rote:
> > > > > > > > > > > Hi Sughosh,
> > > > > > > > > > >
> > > > > > > > > > > On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.g=
anu@linaro.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > Use the LMB API's for allocating and freeing up mem=
ory. With this, the
> > > > > > > > > > > > LMB module becomes the common backend for managing =
non U-Boot image
> > > > > > > > > > > > memory that might be requested by other modules.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.or=
g>
> > > > > > > > > > > > ---
> > > > > > > > > > > > Changes since V2:
> > > > > > > > > > > > * Use map_to_sysmem() to get the user-visible addre=
ss to be shared
> > > > > > > > > > > >   with the lmb API's for sandbox.
> > > > > > > > > > > >
> > > > > > > > > > > >  lib/efi_loader/Kconfig      |  1 +
> > > > > > > > > > > >  lib/efi_loader/efi_memory.c | 77 +++++++++++------=
--------------------
> > > > > > > > > > > >  2 files changed, 24 insertions(+), 54 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > When efi_init_obj() is called, it should be able to a=
dd the lmb memory
> > > > > > > > > > > to its own tables. There is no need to worry about lm=
b after that,
> > > > > >
> > > > > > Saying "There is no need to worry about lmb after that" is not =
true.
> > > > > > Invoking the "env" command for example will have efi_init_obj()=
 be
> > > > > > called, among the others that Heinrich listed. And to possibly =
refute
> > > > > > a next issue, that is intentional so that efivars, the standard
> > > > > > mechanism used by an OS to talk with the firmware can be availa=
ble to
> > > > > > U-Boot, if I recall things correctly.
> > > > > >
> > > > > > My understanding of your assumption is that you believe that on=
ce the
> > > > > > EFI_LOADER subsystem has started work on a payload we're just a=
 few call
> > > > > > chains away from the OS being started and runtime services asid=
e U-Boot
> > > > > > being done.
> > > > > >
> > > > > > My understanding of how things are used today is that this is i=
ncorrect.
> > > > >
> > > > > What I am getting at is that once we have called that function we=
 know
> > > > > we are booting an EFI app or using an EFI feature in preparation =
for
> > > > > doing so. Let's start there. Is that correct?
> > > >
> > > > No, it is not correct.
> > >
> > > Can you give me a code link?
> >
> > env_set() -> env_do_env_set() -> do_env_set_efi() -> efi_init_obj_list()
>=20
> That's with the '-e' option, though, so people doing that are
> specifically choosing EFI.

They're choosing a feature, yes and from there may not use any more, and
can / will be using "load" to put things in to memory.

> What I am saying is that, if we are not booting an EFI app or using an
> EFI feature. Since 'env set -e' is an EFI feature, efi_init_obj_list()
> is called, and EFI is in the picture.
>=20
> Even if efi_init_obj_list(), I don't like treating U-Boot's memory as
> a stack to just grow into. But as a first step, I do want to ensure
> that non-EFI boot can be more like U-Boot.

I think you intended a negation somewhere in that last sentence.

But among the points trying to be made here are that no, we didn't start
an EFI app (a previous point of contention you had), even if we used an
EFI feature. We may or may not use more. But saying "I guess now we can
live with the EFI pool doing what it needs" is quite silly since we've
potentially done almost nothing else. And so why did we make this
special case anyways? This is why I keep saying various versions of, you
need to re-think what you consider "U-Boot memory". If you have concerns
about our stack smashing in to things, that's the problem to address (it
could just as easily smash an initrd placed high in memory by a non-EFI
bootmeth).

--=20
Tom

--S5mAnEtUaaErLW/3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcOvOIACgkQFHw5/5Y0
tyyzQAwAmazLqKVx5hhuQ+4Ae/+VBWwuUeq9IqsfgL4s6mJ2F1ptAfuktok/rxJl
XKN6F2kHKO5U8jzME58svAEQo6sJnytVO3LckESeihhJUiQHVXx+ReXpWP4ZJ9Qu
bD1jsa0OVoFqlmNdaw2AuVao/eld+uadni/fjId+KlFZmCIii/Fqp39OB433oieT
hkLvf3uJlXjMYBQXwDTfck7LcH8WNWzyXWnwO/tiAvZJ8r/Op86FAWaIg3ufa+HF
Aimbbx8kqPDhnTFTuHix1Qf3mcv/uqbJsnD1Wx8rC0qJoA+IMRpiG8fx0f9zGdWU
TIfAxkJ0acxeKd957AYc3tYr/aIXg17jPbARKO/IJYGkstXXeBpqhLKvsGRHdXFI
8BQ/58g5DSxYPxpSNE7DkGXi+NZRB6Kwf+3nESscHfIGHQu2mmkl8J4DkYvBI+HI
rKfBxvqBaLWDBDIK+cGwdDiSXhDWf5L/XD+I3A7NBEgb0FAjplxDxzUWos8AFqcd
HQ14RG6D
=at1h
-----END PGP SIGNATURE-----

--S5mAnEtUaaErLW/3--
