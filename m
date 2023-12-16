Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60565C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 19:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABC73876DE;
	Sat, 16 Dec 2023 20:56:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lkI1zbDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D376587B59; Sat, 16 Dec 2023 20:56:32 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A753F876B4
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 20:56:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-77f320ca2d5so137438985a.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 11:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702756589; x=1703361389; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dpvA90c1ifEBDdZ4Fp7AhkBRM798/pR2o02ueHgmo5s=;
 b=lkI1zbDkjiTGfF2A4KlJymHpjh3xCPqgWSXi0OiSu40svzSqEykZbbA5Xwts0u4viH
 mE/ywMKQXENql1yQ7bYzrnvMisvE4ZzNHB9OJa/Xl4dXHrRaKtx5NiHMLaDjpilI/lVg
 JDUj6fPkXGv6CpFzW6PUKwM9Knh5bksJAN5DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702756589; x=1703361389;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpvA90c1ifEBDdZ4Fp7AhkBRM798/pR2o02ueHgmo5s=;
 b=Z0WgvuJ2ao9pEkNByqZmlXv/oMitiQnc79NibHmdmMMjXUucn7ST5+idMNdRpdJasr
 sNmv6X6z7uJ2oyLtEtQFWbjZfmvjqyzeSQ5+rYPTMNGEZjZDP+N23xSKjZzkw/pqawnq
 Nc+V2L8SXzQiGVb/qpyNp/Zp0osu7qiEc2AdqgYX7pkOPJb5g4ybOvaVXlUiRKNKy4bV
 IPJnUZT8Q85n3US8SDuFVip53kR/B0+on5YS7Ac+BYkls7raoabp0F4NsxO+o+zQbn1D
 Wg2Zy9/V3Z6nYW5Gecnn2MdDvAPK+LSwAaHnAk+dnr6LPjt+diCjcOOfbjyj7X/ekMqe
 QwIA==
X-Gm-Message-State: AOJu0YyEiPLnkUW+rtCMOAGaY8b08DEgwGAOKHyesMMnB6CfPcQNx8ze
 LBJ20Vj/7Humr99uuPZCu+bWOw==
X-Google-Smtp-Source: AGHT+IEPSvhNoh2xdKtJGUk8D/HzzknsiGcGqJjdbBmmkEnXfrMOWZ8tfc/MnCtAbVdOeVchrTBNQw==
X-Received: by 2002:a05:620a:84c5:b0:76f:5b9:3f29 with SMTP id
 pq5-20020a05620a84c500b0076f05b93f29mr19683146qkn.2.1702756589357; 
 Sat, 16 Dec 2023 11:56:29 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 b23-20020a05620a119700b0077fb0e09815sm1319420qkk.17.2023.12.16.11.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 11:56:27 -0800 (PST)
Date: Sat, 16 Dec 2023 14:56:25 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v3 22/22] bootm: Create a new boot_run() function to
 handle booting
Message-ID: <20231216195625.GY2513409@bill-the-cat>
References: <20231216031446.2222362-1-sjg@chromium.org>
 <20231216031446.2222362-17-sjg@chromium.org>
 <20231216171227.GS2513409@bill-the-cat>
 <CAPnjgZ3Wnzn3TG-biOh0O=5kXV6qQZOgip5H+AC4nenBrgg-Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4LzQtJ4iEgNF7kVw"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3Wnzn3TG-biOh0O=5kXV6qQZOgip5H+AC4nenBrgg-Zg@mail.gmail.com>
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


--4LzQtJ4iEgNF7kVw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 11:45:36AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sat, 16 Dec 2023 at 10:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Dec 15, 2023 at 08:14:26PM -0700, Simon Glass wrote:
> > > Create a common function used by the three existing bootz/i/m_run()
> > > functions, to reduce duplicated code.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > ---
> > >
> > > Changes in v3:
> > > - Add new boot_run() function
> > >
> > >  boot/bootm.c    | 40 ++++++++++++++--------------------------
> > >  include/bootm.h | 18 ++++++++++++++++++
> > >  2 files changed, 32 insertions(+), 26 deletions(-)
> > >
> > > diff --git a/boot/bootm.c b/boot/bootm.c
> > > index 53236136f489..6a4cebcf7a08 100644
> > > --- a/boot/bootm.c
> > > +++ b/boot/bootm.c
> > > @@ -1123,47 +1123,35 @@ err:
> > >       return ret;
> > >  }
> > >
> > > -int bootm_run(struct bootm_info *bmi)
> > > +int boot_run(struct bootm_info *bmi, const char *cmd, int extra_stat=
es)
> > >  {
> > >       int states;
> > >
> > > -     bmi->cmd_name =3D "bootm";
> > > -     states =3D BOOTM_STATE_START | BOOTM_STATE_FINDOS | BOOTM_STATE=
_PRE_LOAD |
> > > -             BOOTM_STATE_FINDOTHER | BOOTM_STATE_LOADOS |
> > > -             BOOTM_STATE_OS_PREP | BOOTM_STATE_OS_FAKE_GO |
> > > -             BOOTM_STATE_OS_GO | BOOTM_STATE_MEASURE;
> > > +     bmi->cmd_name =3D cmd;
> > > +     states =3D BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
> > > +             BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
> > >       if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
> > >               states |=3D BOOTM_STATE_RAMDISK;
> > > -     if (IS_ENABLED(CONFIG_PPC) || IS_ENABLED(CONFIG_MIPS))
> > > -             states |=3D BOOTM_STATE_OS_CMDLINE;
> > > +     states |=3D extra_states;
> > >
> > >       return bootm_run_states(bmi, states);
> > >  }
> > >
> > > -int bootz_run(struct bootm_info *bmi)
> > > +int bootm_run(struct bootm_info *bmi)
> > >  {
> > > -     int states;
> > > -
> > > -     bmi->cmd_name =3D "bootz";
> > > -     states =3D BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
> > > -             BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
> > > -     if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
> > > -             states |=3D BOOTM_STATE_RAMDISK;
> > > +     return boot_run(bmi, "bootm", BOOTM_STATE_START | BOOTM_STATE_F=
INDOS |
> > > +                     BOOTM_STATE_PRE_LOAD | BOOTM_STATE_FINDOTHER |
> > > +                     BOOTM_STATE_LOADOS);
> > > +}
> > >
> > > -     return bootm_run_states(bmi, states);
> > > +int bootz_run(struct bootm_info *bmi)
> > > +{
> > > +     return boot_run(bmi, "bootz", 0);
> > >  }
> > >
> > >  int booti_run(struct bootm_info *bmi)
> > >  {
> > > -     int states;
> > > -
> > > -     bmi->cmd_name =3D "booti";
> > > -     states =3D BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
> > > -             BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
> > > -     if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
> > > -             states |=3D BOOTM_STATE_RAMDISK;
> > > -
> > > -     return bootm_run_states(bmi, states);
> > > +     return boot_run(bmi, "booti", 0);
> > >  }
> > >
> > >  int bootm_boot_start(ulong addr, const char *cmdline)
> > > diff --git a/include/bootm.h b/include/bootm.h
> > > index eba35b33b4e5..9e0f8d60de0a 100644
> > > --- a/include/bootm.h
> > > +++ b/include/bootm.h
> > > @@ -150,6 +150,24 @@ int bootm_measure(struct bootm_headers *images);
> > >   */
> > >  int bootm_run_states(struct bootm_info *bmi, int states);
> > >
> > > +/**
> > > + * boot_run() - Run the entire bootm/booti/bootz process
> > > + *
> > > + * This runs through the boot process from start to finish, with a b=
ase set of
> > > + * states, along with the extra ones supplied.
> > > + *
> > > + * This uses bootm_run_states().
> > > + *
> > > + * Note that it is normally easier to use bootm_run(), etc. since th=
ey handle
> > > + * the extra states correctly.
> > > + *
> > > + * @bmi: bootm information
> > > + * @cmd: command being run, NULL if none
> > > + * @extra_states: Mask of extra states to use for the boot
> > > + * Return: 0 if ok, something else on error
> > > + */
> > > +int boot_run(struct bootm_info *bmi, const char *cmd, int extra_stat=
es);
> > > +
> > >  /**
> > >   * bootm_run() - Run the entire bootm process
> > >   *
> >
> > Overall good, thanks. My question is, should we mark the others as
> > static, or is this new helper static and not to be called externally?
>=20
> The others are used externally.
>=20
> For bootm_run() I toyed with the idea of it being static, but then
> wondered if we might use that programmatically instead of the
> bootz/i/m(_run) versions. It is quite nice that the differences are
> now pretty minor between them.
>=20
> I don't mind either way, though.

OK, lets put it on the TODO list for once the CMDLINE=3Dn case is fully
flushed out and code otherwise cleaned up and organized, it'll perhaps
be clearer then if the answer is old functions, new function or neither
function.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--4LzQtJ4iEgNF7kVw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV+AOYACgkQFHw5/5Y0
tyzxvgv/TCikbkbZGanyGj6xAK+5/cwI9NHK4m0LUrVSlcWJpIs7sc3CIzUnIzxV
Tv5pwlD+Wm34PMVLwk2qkGURoi1Wz7M3SsYIvMD8vTXslfvHlwTbYTSTFU93oRy5
iPd8WLNTLRBg8TzdogPQQo7gGikEgva/mKtx4MURMaDRuYjMM6X6seTmf4EPgUcs
iioKfji/pvVubNaKRqn9K0qqoH6257642KJU7XKUNuU53UPPb7cpjSJyH8iozy75
fzOoTo2T2S0NOHB8wSfNn1+xV2/dxiKk/HNEpw4K9n93AOBbatdHC+gM6hSyNc64
CIZlzTVCFC+5ixJo8+gVBpTnZtcHWj+3Fn6FOqVzefMCXVlKzyLRvN54vV+9i7oL
mO7PDnuPjNGD+yKRlc1Ztcv6wnTX2njbS7Bps/02MqfLeABHYJnGpGHLSyM1Zhpa
aTLA+pWLG3eqWg+kQ5kHH0Ha9TrcdogeKz6tqu3jafbX1vlsjEj08pd6gaBOhg5m
A77vUwzn
=OtuE
-----END PGP SIGNATURE-----

--4LzQtJ4iEgNF7kVw--
