Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E859D2CE0D
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 17:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 651C18904E;
	Tue, 22 Oct 2024 19:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kHMLZm9W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C804C88D91; Tue, 22 Oct 2024 19:56:52 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53797890CE
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 19:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b147a2ff04so506492385a.3
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 10:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729619809; x=1730224609; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SveEaCO98RX1IZgbTvmWFaGX3/8mk3zfMYVwVqJdqt0=;
 b=kHMLZm9Wu6Wi40h6BOcRbJmYcVXIntbpVmJ+uX+oJS58cUGb/5riKDJqIcLN+XiK73
 EB67I8Qm/XnbsQSoIUAl+/whjfEaCkq96cCHc4kpl25aeytTRC/mMFpWdGScW/cpdcbG
 m+yrj14QmLLBXnOjg6xqRSm1+0lolUOTkaqUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729619809; x=1730224609;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SveEaCO98RX1IZgbTvmWFaGX3/8mk3zfMYVwVqJdqt0=;
 b=gffK6u12xB496jlCchM6Pl7aGd5K3ba8MuAUvP6NXCS/qUV6yyv7UFDQeVDNwPBDey
 b7DNIGVDxFktqccyM+27rK12hIslAhErtOB2zoqXQgJEQ5x+8yzJvWpYDNmHLlmMDDOz
 1TZ4IbtcsmwS4XlaHI1r3ptrXtANo4opG6AqTd0wH8R8hFz/3X+lzWX2xyw/KAbTvTMa
 xzzSXTm0F3+SEMKmKYtvPeoOvM22VAZbZ8ZXQ2WG2Tqh00MT5XP65v9wcdtNA8FDhHhR
 2vlbEUfe+nNwGiTQfCyvUm+/EvJBOhPjr2L3qtr1uGp3yy2GXKpSVzTiZMazbU5mgsfW
 O8ww==
X-Gm-Message-State: AOJu0YzKWgrdjxq0m9YmqgwYPQLUu9pf8nhkvQviBf+L679OjRyTLy89
 carAfzw+C/zQ4ASEhEvwW9JcC/BJkhvPASP6H2ASGE/OentOM9CYdZjP+8T+Vik=
X-Google-Smtp-Source: AGHT+IF4pxiLXDX78eJnGagAm9T6MTRJBXOaxBOTI5xiiV0CxQDcy9YZTxPDKBp2dfIIv416NHbWUw==
X-Received: by 2002:a05:620a:172a:b0:7b1:5143:8da1 with SMTP id
 af79cd13be357-7b17dd484eamr34786285a.43.1729619809205; 
 Tue, 22 Oct 2024 10:56:49 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b165a071ddsm301696985a.71.2024.10.22.10.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 10:56:48 -0700 (PDT)
Date: Tue, 22 Oct 2024 11:56:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH] CI: Add a test for building without CMDLINE
Message-ID: <20241022175645.GI4959@bill-the-cat>
References: <20241021134450.22985-1-sjg@chromium.org>
 <20241021143336.GG4959@bill-the-cat>
 <CAFLszTjK=uw61U_WaqLjBX1JFCC15Ee2dRBm_qGUEsnjqiqpEw@mail.gmail.com>
 <20241021164958.GK4959@bill-the-cat>
 <CAFLszThz2DGSQ+gBiJi0jaSmsghVau0UTUyuZppjSyuy9pRkuA@mail.gmail.com>
 <20241022140223.GZ4959@bill-the-cat>
 <CAFLszTjn5jELfjZJ0+JNQ+Op8S++_t4V-9MLVxYNnf8kzv+xSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rn9BBebdamzLYM3P"
Content-Disposition: inline
In-Reply-To: <CAFLszTjn5jELfjZJ0+JNQ+Op8S++_t4V-9MLVxYNnf8kzv+xSQ@mail.gmail.com>
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


--rn9BBebdamzLYM3P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 07:00:39PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 22 Oct 2024 at 16:02, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 22, 2024 at 02:16:16PM +0200, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 21 Oct 2024 at 18:50, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Oct 21, 2024 at 06:32:18PM +0200, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, Oct 21, 2024, 16:33 Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Oct 21, 2024 at 03:44:49PM +0200, Simon Glass wrote:
> > > > > >
> > > > > > > Something this breaks, so add a test to keep it working. Sinc=
e sandbox
> > > > > > > enables a lot of options, it is a good board to use.
> > > > > > >
> > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > >  .azure-pipelines.yml |  8 ++++++++
> > > > > > >  .gitlab-ci.yml       | 11 +++++++++++
> > > > > > >  2 files changed, 19 insertions(+)
> > > > > >
> > > > > > I don't like this because "sandbox" is one of the longest run-t=
ime
> > > > > > build options due to all of the tests it runs. And given how we=
 break
> > > > > > down the jobs this will make a further bottleneck. Can we just =
disable
> > > > > > CMDLINE in one of the existing sandbox defconfigs instead pleas=
e?
> > > > > > Perhaps sandbox_spl since that only does SPL related pytests?
> > > > >
> > > > > Actually we do boot into U-Boot proper as some tests need to check
> > > > > that SPL did the right thing.
> > > > >
> > > > > Note that this patch doesn't run any tests at all. It just tries =
to
> > > > > build sandbox without CMDLINE
> > > >
> > > > Is there no existing thing we can put this in? And have we had anot=
her
> > > > problem with CMDLINE=3Dn ? It's not cheap (wall clock) to add anoth=
er
> > > > stage, especially in Azure, I'd really rather figure some way to bu=
ndle
> > > > this in with what we already do. Heck, following on with
> > > > qemu_arm64_lwip_defconfig I'd rather just add
> > > > sandbox_no_cmdline_defconfig and use #include so that it's just a f=
ew
> > > > lines of defconfig anyhow, but merged in with existing builds.
> > >
> > > No, I have not seen any problems with CMDLINE as it is, but there are
> > > some BOOTSTD cases which I would like to check, since disabling the
> > > command-line and using programmatic boot is something I'd like to
> > > eventually test. So this is just a starting point. In the end perhaps
> > > we have a new sandbox variant, or can take over the SPL one...but I'm
> > > not sure yet.
> > >
> > > If Azure is a problem, we could perhaps just do it in gitlab, where we
> > > have more runners. A build variant isn't the sort of problem that
> > > would be different between gitlab and Azure.
> > >
> > > The run is at [1] and it only took 1m19s - I suppose you saw that it
> > > is in the 'world build' section and no tests are run.
> > >
> > > Regards,
> > > Simon
> > >
> > > [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/jobs/924269
> >
> > No, I don't want Azure and GitLab to diverge since Azure is where
> > everywhere who isn't a custodian with git access can run CI and I keep
> > encouraging more people to use it. And also note that the actual build
> > took 8 seconds which is another reason it would be good to just drop it
> > in to an existing job.
>=20
> Oh I didn't know that about Azure. Could/should we have a public
> gitlab pusher also? Or is that not possible?

I'd really rather not overwhelm our few build servers (of which you're
providing most of).

> Anyway, I cannot put it into a job which runs tests, since it doesn't
> ever produce a command prompt. So that rules out the test.py stage,
> since even if I use '-k nothing' it will still fail to see the prompt,
> so the build will fail. I don't see any option but to put the build in
> a separate piece?

Yes, we could just do something like configs/qemu_arm64_lwip_defconfig
but be sandbox_nocmdline_defconfig and it'll just be part of the normal
world stage that already builds all of the sandbox targets.

--=20
Tom

--rn9BBebdamzLYM3P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcX510ACgkQFHw5/5Y0
tyxrZwwAoTgxdtcV0OogDX2sMagfZdChmOzDqZuZXpRtN55eSVTHUWLSmCa+K/I1
wYOK+dixsmlY/gD5IVy5yG4550Ab+0HHRZDgmmLCqImmzf0lLWtkAW1Me6NP//0a
5M7ozLECPxtXDIxErvHIENKx4wkPPUniKBZIZ9a1Kq4cdby7qvpTsSV/vPANE3VQ
0FSFCzvyhNHqc7B9B97f9MWfUwic+TyfsJOuUSo3JQOBAbKxtpvbt4/VU+6yRDco
Rx9bcDQDQ2713NrIC9OiscFAqf8SoQY37ogY4bdQ303l902HD+AF8i7z/+tklYU4
78ST3oC2uS+Ax1VhH0+pFdzj6iXKTKSc0GUMHFgKygM4gcqfkZg3X13o36KXXfka
xEYlXDRbaqfKvag4I3aLK1i9nOExUAjiX6OfOfPZpEUj4VrS1J7TMkltQGytfNYg
L++3qYTaCtq5hT4SdTSBAAOg7ROSLHXKtgizJrdjn9ofDQocI65plbwcIaaMukU7
TG1TW8i9
=1P8G
-----END PGP SIGNATURE-----

--rn9BBebdamzLYM3P--
