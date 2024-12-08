Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E30E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 19:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0BA289370;
	Sun,  8 Dec 2024 20:12:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UCJpD0eR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E179894FF; Sun,  8 Dec 2024 19:50:38 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B465288E5C
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 19:50:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6d902aea641so5017646d6.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 10:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733683834; x=1734288634; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wOAM7XljA2UK4JJHbkIKxIox2j82EpnqBgHEHRZjudM=;
 b=UCJpD0eRccaT2ZUFQUeqHJYxY9e/Wlux39L+N172bL2uZK1nG3/3EsWussD05qXW2E
 HqZ+1RcjDIQLYtUQI1KkTjjj2IbAoCkbQKJFCqGLH6eFYgB84WAU94HMskZtST78IC3/
 EALXJFkem0EkfDLQCw6ZLGNtzIBYoNf1x2x3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733683834; x=1734288634;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wOAM7XljA2UK4JJHbkIKxIox2j82EpnqBgHEHRZjudM=;
 b=UYfrV/4T+lAHxSTOYVNJD5O2vqtn0NhWseFi/63DqjB1+v+9QoJNIPVTOAZIPGqJZ3
 /JbnQ/Zuo7HCN9gIpu30iWK997qJKzIUGHV+2641JivfCG+0FLkWx4ovC/q0WzALBIoz
 O3DnvoKRg0QzsDu14/dlFNOWkqi2gcYmP4hMYA1b49CbkFkNqqBklZIMFoBKXFFb0Bfo
 aoCwsilO2XaUqS4I8xamRMvl1MNhnZD4QzbwS8VmZjfIXse83q5dAh3Y8/W7aSMJ5DmX
 ohGXpt5Y/u72A/fnB2n64hxCL32cd90J5OBd9WZlFme4v3MVj7y6Qpk3vG/35pxWQxrq
 ZP5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYRNbFBdy91HqVDDLbY6nCtruaYcH/GBzwZhtKbufFYj8EOiYtTUpUNSv292txeai1usMjplI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7xJMIogcK+TpSpWjl/SIx00Ej0v10p3g+j/bt0EY3D7Lbh9GU
 qL5OX4Vxo73cljwE99XPz8DquM2y/e0FcWdzb1mHt0q5x7J3uR62Eo8RL40K178=
X-Gm-Gg: ASbGnctFINp89iVzrK3j7EEQBF7xXqYFBk9VqYZdUWZuRDQJ2RyjalWU/Ud40Tp3FPR
 fQn8fdWV3CAGKBUa7xBLwPNM4BQgl+Nj5dVTasj9oQW/qc/p2nPqFvN7vrpbMd5lQl3EaC24iXa
 KYQY3SBBYFon0+LqYmEcEjmWbKS5b3sfUHplKjZcDyERGjTV3vMVwzIe8dMI25DLzTGV637mo+E
 b9EW0FdGi3joplgVduNK6mRM7csaaJht9qz960BRC1WoKOG6XY=
X-Google-Smtp-Source: AGHT+IEcWQecpyu1r30DqZsEwc+4zRejTLjqRlRYc8xpJbrkr7arY0W1nmovX5Xy6sOy8MahzHGOIA==
X-Received: by 2002:ad4:5c66:0:b0:6d8:a1fe:729e with SMTP id
 6a1803df08f44-6d8e71eba80mr144889796d6.46.1733683834568; 
 Sun, 08 Dec 2024 10:50:34 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da6748b5sm40794226d6.4.2024.12.08.10.50.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 10:50:33 -0800 (PST)
Date: Sun, 8 Dec 2024 12:50:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, u-boot@lists.denx.de,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christophe ROULLIER <christophe.roullier@foss.st.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Gabor Juhos <j4g8y7@gmail.com>, Hanyuan Zhao <hanyuan-z@qq.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philip Oberfichtner <pro@denx.de>, Ramon Fried <rfried.dev@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Romain Naour <romain.naour@smile.fr>, Sam Edwards <CFSworks@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH 00/10] Improve UEFI app support
Message-ID: <20241208185027.GI2457179@bill-the-cat>
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <CAFLszThjGaKd3Z8fYaBqANDnyGOtGSF7t-o7B1B70R9q9jYfgA@mail.gmail.com>
 <CAFLszTitRwZbOMd-a0nQKzkBUg1OorNFrGzsdyZPtV9rdfEnyg@mail.gmail.com>
 <20241208155123.GG2457179@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="egESN7AjOl2HdEuS"
Content-Disposition: inline
In-Reply-To: <20241208155123.GG2457179@bill-the-cat>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sun, 08 Dec 2024 20:12:04 +0100
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


--egESN7AjOl2HdEuS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 08, 2024 at 09:51:23AM -0600, Tom Rini wrote:
> On Sun, Dec 08, 2024 at 08:28:42AM -0700, Simon Glass wrote:
> > Hi,
> >=20
> > On Sun, 1 Dec 2024 at 09:15, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Matthew,
> > >
> > > On Sat, 23 Nov 2024 at 12:56, Matthew Garrett <mjg59@srcf.ucam.org> w=
rote:
> > > >
> > > > We run a mixed environment including traditional embedded Linux and
> > > > UEFI. For consistency it's valuable to use U-Boot in both cases, bu=
t on
> > > > UEFI systems we want to run the full Linux kernel UEFI boot stub. T=
his
> > > > patchset adds support for that, along with various other quality-of=
-life
> > > > improvements such as automatically finding partitions based on their
> > > > GUID, automatic identification of load addresses where the firmware=
 has
> > > > given us constraints, support for EFI variable access in the EFI ap=
p,
> > > > drivers for EFI network adapters and TPMs, support for embedding DT=
Bs in
> > > > the EFI app, and a couple of bug fixes.
> > > >
> > > >
> > > > Janis Danisevskis (1):
> > > >   Fix efi_bind_block.
> > > >
> > > > Matthew Garrett (9):
> > > >   Add EFI handover support to bootm
> > > >   Add part_find command
> > > >   Add a command to find a load address
> > > >   Hook up EFI env variable support in the EFI app
> > > >   Add EFI network driver
> > > >   Add UEFI TPM2 driver
> > > >   Support separate DTB files with the UEFI app
> > > >   Use the correct ramdisk address
> > > >   Add command to set an environment variable to an EFI variable
> > > >
> > > >  Makefile                        |   7 +-
> > > >  arch/x86/config.mk              |   2 +-
> > > >  arch/x86/lib/bootm.c            |  60 ++++++++----
> > > >  arch/x86/lib/elf_x86_64_efi.lds |   4 +
> > > >  boot/bootm.c                    |   5 +
> > > >  cmd/Kconfig                     |  23 ++++-
> > > >  cmd/Makefile                    |   3 +
> > > >  cmd/addr_find.c                 |  87 +++++++++++++++++
> > > >  cmd/efigetenv.c                 | 133 ++++++++++++++++++++++++++
> > > >  cmd/part_find.c                 | 156 ++++++++++++++++++++++++++++=
++
> > > >  drivers/net/Kconfig             |   7 ++
> > > >  drivers/net/Makefile            |   1 +
> > > >  drivers/net/efi_net.c           | 110 +++++++++++++++++++++
> > > >  drivers/tpm/Kconfig             |   7 ++
> > > >  drivers/tpm/Makefile            |   1 +
> > > >  drivers/tpm/tpm2_efi.c          |  97 +++++++++++++++++++
> > > >  include/asm-generic/sections.h  |   1 +
> > > >  include/bootm.h                 |   6 ++
> > > >  include/efi.h                   |  24 +++++
> > > >  include/efi_tcg2.h              |   1 +
> > > >  lib/efi/Makefile                |   2 +-
> > > >  lib/efi/efi.c                   |   1 +
> > > >  lib/efi/efi_app.c               |  41 ++++++++
> > > >  lib/efi/efi_app_init.c          | 163 ++++++++++++++++++++++++++++=
++--
> > > >  lib/efi/efi_dtb.S               |   6 ++
> > > >  lib/efi/efi_vars.c              |  44 +++++++++
> > > >  lib/fdtdec.c                    |   3 +
> > > >  27 files changed, 967 insertions(+), 28 deletions(-)
> > > >  create mode 100644 cmd/addr_find.c
> > > >  create mode 100644 cmd/efigetenv.c
> > > >  create mode 100644 cmd/part_find.c
> > > >  create mode 100644 drivers/net/efi_net.c
> > > >  create mode 100644 drivers/tpm/tpm2_efi.c
> > > >  create mode 100644 lib/efi/efi_dtb.S
> > > >  create mode 100644 lib/efi/efi_vars.c
> > > >
> > > > --
> > > > 2.47.0
> > > >
> > >
> > > Thank you for sending this and for your interesting talk at plumbers.
> > > It is a novel approach and potentially provides an alternative to grub
> > > and EFI_LOADER, etc.
> > >
> > > I'd like to try getting this running in CI as we don't have any such
> > > tests for the app or payload at present.
> >=20
> > I'm planning to pull this in as this seems like an important use case.
> > I'm not sure how much time Matthew will have for this, and I want to
> > avoid this series going stale.
> >=20
> > The comments which are not 'why do you want to do this?' are fairly
> > minor, so I'll send a follow-up to resolve them next week. We should
> > also think about what code we could move from lib/efi_loader to
> > lib/efi so we can share it with the app.
> >=20
> > Matthew, thanks again for sending this. if you are planning to do more
> > here in the short term, please let me know.
>=20
> Please don't grab other peoples patch series and pick them up for your,
> well, whatever you want to call "ci/master". You can do what you like
> with patches you wrote but taking submissions from others is just going
> to confuse the situation as to if you are, or are not, forking the
> project at this point.

And really, do not change patchwork state. That reflects the project
itself.

--=20
Tom

--egESN7AjOl2HdEuS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdV6mwACgkQFHw5/5Y0
tyxD6wv/R8cAxTggMUDy4k30JAoNAmk2GNe29vVYszSD0nohAwPNKOuTM4j3sdBi
u2N2XE06zoTs5vvDbWwa0kWfUaU8IHKf33WKleRtK2ea4K8Foz5TKslcCImwRsQJ
wciPsk0agIOe47CrBNogYap4flfb9WI7JmketLYtHaUGJgao+NE/YR//F4i2VwQL
f+t0Bltu/ahJ+B/BYDzi0S5FFL9JBTGLKKTay2uU+K3dxI8lHm59jUnMrmeZwLvX
wjoiJaqtoi4urFS/Or/9c51IAZLjs+HIwTc51Ant2l++K0vn2GDBWyQ2jOkn/dHe
j5nCe2rK0yboFyJo9LWVK5UKRNon1T/eTLl1Tf5jdiqXXQ+9wwjOwBApP4tQp2YP
Hg4W5NAazm8SDivwKaUA+D9pXMp9UeyrR8l9FTJR6DuKm0iTFiKYmCkp5wrxEAo9
v6+OYsAYay9eSEGh8Dtq1aO878oXxiZxYcg6EXxPJKKQmekny4V9I21LnYKcw7XQ
Ylvh3TXL
=l8U1
-----END PGP SIGNATURE-----

--egESN7AjOl2HdEuS--
