Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184EDE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 15:29:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45CEC8043F;
	Sat,  4 Jan 2025 16:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rdky/4Vh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A744B8043F; Sat,  4 Jan 2025 16:29:52 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1278E803DC
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 16:29:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d8fa32d3d6so66594156d6.2
 for <u-boot@lists.denx.de>; Sat, 04 Jan 2025 07:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736004589; x=1736609389; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WrZp/VP+bu4Oq+us4rn5pttwkX0nShCa2MpQO4qIYl0=;
 b=rdky/4Vhga9XlfmVZPo1zb2UJ0Wvw+5HuhxozUWYimk1npxq3BfYqLxVsiGMCVKwvg
 M44loQ0cXWY3vu4CC1DJqkNWLzYl7mhn3pcaHRhMAutz7K8FwIGO2SpnmMAkSveCTfFA
 3/Gw5cAZOe87RSkdmnb9h1RbX3UJMZBc5lME8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736004589; x=1736609389;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WrZp/VP+bu4Oq+us4rn5pttwkX0nShCa2MpQO4qIYl0=;
 b=cO7apbCwjsiaEZBgRVC1tDblompQtCZXwcq8dck9SIma9Oh3erT3gONwyaHtwLprMS
 hbM2KKZrk68oYyXf0huZ2cCBkFFEixO1ggkXFWVsdO3r9/tO61lZAaLOMDHNwBeBS32Y
 XH3W5wjeLcmpkqD7tEsntUwhPVvxEt/cm5Ar3As8NxZC5eLveK6If+QvJCuWM3a3nJw0
 JIXeExvfGWniD7xDGUeHN4WAvQVq9SNnxcCBNWKVLnFaMTvAiCZJy19nGJ/2PLjUtumI
 oc0RTT+Tgdz65ey9jDNQ6+c/7ZIE1QF02/Ml9VkD/a7m+FlbFcWpjwarXp1aawsJQ6ED
 X/vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn1yGpXixZGvINSmZRCffX/I9tCymFzUvlLPMOw0s4xBtDQ9P8ywvl/k2OCO/u4oqUFOHOU1Y=@lists.denx.de
X-Gm-Message-State: AOJu0Ywx0U3OQCi7eL+4xa0WW5pt5RXWqMX5VZLAX9+wZLHJ8SPnnDdr
 9Vbx+gHooGMQi7csQ1ZwdLmU+uuvZzVdOAig1XP+qYAE0rlXM+elgysk9EyxKko=
X-Gm-Gg: ASbGncvU96c+5H7osmbE+0P1lRlJ++s1Z1JFWdKD8tDPke0MuIaZzvFEAJQogfKEzW2
 +lcwwvUCnh2VA3EkrtLEX/3aHCVMVTk5I8Rboq31m8FEULSlLX6Zw1nX0tAcIP1ZM5sYF+ewvKd
 9wu6D+o6ZHTKa/6v6ferD1rzYNepNCUGQEIrQwNggOpRTZ11IYEgANUECyra6hIrsqPCHSgvR/n
 pvwxpiuLQPTbkKfN1sY9AkPLkcwWUDyKSxlXotc1mbuONDYv4SkqOxfTg==
X-Google-Smtp-Source: AGHT+IFv5bHpF7rMebMhFffF07hZkq0Wed6UHA9yIWvhJnOWfRNwr3AuRFyKpafnOuDnBC/UviAmNQ==
X-Received: by 2002:a05:6214:1c8d:b0:6d8:8f14:2f5d with SMTP id
 6a1803df08f44-6dd2335e685mr963977416d6.28.1736004588720; 
 Sat, 04 Jan 2025 07:29:48 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d52c2sm151241026d6.113.2025.01.04.07.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jan 2025 07:29:47 -0800 (PST)
Date: Sat, 4 Jan 2025 09:29:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lothar Rubusch <l.rubusch@gmail.com>,
 Olivier L'Heureux <olivier.lheureux@mind.be>,
 Yang Gang <yanggang@byosoft.com.cn>
Subject: Re: Pull request efi-next-20250104
Message-ID: <20250104152943.GX3476@bill-the-cat>
References: <5222dd9e-83f6-40ad-adc1-dc3fe1651991@gmx.de>
 <a84b7af4-0e78-4a07-ba5c-590891bc50ca@kwiboo.se>
 <947b4423-b1fb-4a65-ae5e-f71fb8a50255@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BYNWQa17PfeCqjEr"
Content-Disposition: inline
In-Reply-To: <947b4423-b1fb-4a65-ae5e-f71fb8a50255@gmx.de>
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


--BYNWQa17PfeCqjEr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 04, 2025 at 01:08:00PM +0100, Heinrich Schuchardt wrote:
> On 1/4/25 12:49, Jonas Karlman wrote:
> > Hi Heinrich,
> >=20
> > On 2025-01-04 04:19, Heinrich Schuchardt wrote:
> > > Dear Tom,
> > >=20
> > > The following changes since commit ec9263b4f15c4cf82eb6a211c67baa6385=
065b8e:
> > >=20
> > >     Fix neighbor discovery ethernet address saving (2025-01-01 14:40:=
04
> > > -0600)
> > >=20
> > > are available in the Git repository at:
> > >=20
> > >     https://source.denx.de/u-boot/custodians/u-boot-efi.git
> > > tags/efi-next-20250104
> > >=20
> > > for you to fetch changes up to ce190e1b33b8c0e1228f4123759dfa1981c202=
de:
> > >=20
> > >     efi: Correct ECPT table GUID (2025-01-04 02:17:06 +0100)
> > >=20
> > > Gitlab CI reported no issues:
> > > https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/24075
> > >=20
> > > ----------------------------------------------------------------
> > > Pull request efi-next-20250104
> > >=20
> > > Documentation:
> > >=20
> > > * doc: develop: Fix typos and wording in binman/binman.rst
> > > * doc: develop: Fix typos and wording in gdb.rst
> > > * doc: sandbox: Fix the "sb" command name
> > > * doc/develop/distro.rst: Better document upstream definition of
> > > extlinux.conf
> > >=20
> > > UEFI:
> > >=20
> > > With this pull request the UEFI sub-system detects all boot devices e=
ven
> > > if they have not been probed before. If this adds to much boot delay
> > > individual bootmeths and bootdevs can be disabled via the customizing.
> > >=20
> > > * efi_loader: avoid writing message in Exit() boot service
> > > * efi_loader: run bootdev_hunt() to find ESP
> >=20
> > This patch still completely changes how standard boot operates, from
> > lazy probing boot devices from fastest to slowest (probe time) as
> > described in the standard boot documentation [1], to probing all boot
> > devices all at once before checking for a bootmeth/bootflow.
> >=20
> > This slows down script and extlinux booing on my Rockchip board by
> > several seconds because now pcie and usb is probed before current fast
> > bootflow from mmc devices is tested.

I think there was some further discussion on IRC after these emails.

>=20
> We need to scan all block devices to be EFI compliant.

In "efi bootmanager" mode, yes?

> As described in the pull request message, if you don't want to boot from
> PCIe or USB, you can disable these bootdevs.

But that will still cause them to be probed in the efi boot manager
instance yes?

> If you don't want to boot via EFI set CONFIG_EFI_LOADER=3Dn.

But that's precisely what we're trying to avoid in the general case. We
want EFI_LOADER=3Dy so that all the assorted modern SoCs can Just Work
with all of the assorted off the shelf FOSS OS images.

> > Will you work on a fix for this or do you recommend disabling the
> > efi_mgr bootmeth or similar? E.g. something like the diff below.
> >=20
> > Similarly if I understand correctly the priority of efi_mgr bootmeth,
> > first regardless of configured bootmeth order, is the main blocker for
> > sunxi to fully move to standard boot.
>=20
> Allowing to run global boot methods after non-global ones still has to
> be worked on.

Yes, this needs to be done first, then we can do things which will slow
down the boot process in the case of an un-optimized configuration.

> Please, elaborate why Sunxi cannot be migrated like other boards. If
> some embedded board needs to be trimmed to maximize boot speed you will
> anyway adjust the configuration to eliminate all unnecessary scanning of
> devices.

The problem with SUNXI was described well enough in the thread about
migration and I believe re-summarized in the past few weeks. But no one
wants their device to boot any slower than required. Which in turn means
getting things setup such that we can boot the specific case before the
global case.

--=20
Tom

--BYNWQa17PfeCqjEr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd5U9wACgkQFHw5/5Y0
tyybgwv/RzbsuSPKTX0DgUoiXZ/lPe8OLGFtudZUcD/mSBiLPmDXqFYuWxWTsRES
zrOKdC17z6UTAELqV4g1Pc8BuEXCVJkSbGyEhFBrqfZ3aV0pWJ6nfGIgP6zf1rMS
1Wy+hpc1r8iMtHPNRU8do8HW3IuGIaedSVMJe2fPjld8ENH/wgrQuVxqFt3GP4XC
iaR9jj4gDlMi8qOJN8/NY5wyN65PaAk3ShexaxeFhZgrSXevA73icTqpZ7Re0dg0
AOBIa+ygTqCoPiPJfYddd4z7NPH+E6/j80QYYb0gJTSFluy1EpzA4IzOmVyw9Ee4
K/xRA4lkpTOPTazE/cZ8hQAzdE9xoFfzY6LhXqGl29lUJgPan9AQXSXslE0Uuds5
joYuL9VwEDXZbU4GH++AaH3apwI2DjkXaFHOkgYFgnKUOLuMy12OP4y3SQF0YjZn
mvi/EAxvDuITnr7T78TbNAOsu9+gqY0Ux0TYtt2+iI4LdvCnDzW20ArSYzQgnuZg
4HtdeJjm
=O+F2
-----END PGP SIGNATURE-----

--BYNWQa17PfeCqjEr--
