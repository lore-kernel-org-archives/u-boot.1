Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56EAC3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A53086478;
	Wed, 23 Aug 2023 19:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lvFTu3q9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76A0F8647B; Wed, 23 Aug 2023 19:15:08 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0892D8645E
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-58e6c05f529so63621987b3.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692810905; x=1693415705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YOnAoiLu1TbTYUw8lkF4C820IDU6sXZtuJTaWSDJf8o=;
 b=lvFTu3q9oN9McdcIZ2ie/Sl+5kNqWc8noV5aZfNqScyFi2wv2iokh5Mu6IamlLxO4j
 nWRtZaFlARCRS14qK1SloGHIOvctn8yFbvq3XytYhaj00thNUEcjTMKTLvZ45piRLocj
 +bGN60BH0t9SJluOGyoofe+mw70qHjZqBpHz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692810905; x=1693415705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOnAoiLu1TbTYUw8lkF4C820IDU6sXZtuJTaWSDJf8o=;
 b=kBtFXbfVvJGPujXi6+SDeBpmLEzwFFmHYnSiRgVjNXFOOgp50mLvaXQQWPkQjadg0h
 PqPVlju7wfD/IaEDMRuvYFJ3zLrIHGMlqgMzkSEtEkShIygyhJvXcpqe2xu8Ar2LIr0n
 fCjT5s8mTFiejjPa+FmFxFNhg6Nlr0YLwr4lUsMRGO1dE59Kg+6XXqNCYMNEh1OyE6IZ
 FyF5eV6DUnO+BvJWj6+8JM9rEvT8Z/TClcL8aCjK/8txunqtWlmbNROfAjNsze7NaecN
 etX2LvFeilRU/AqPkvLU4jlMpntY+K+AcVB0hrD5cmAgpiCUXcer/uCAEpkxK+DXVyA6
 VUPw==
X-Gm-Message-State: AOJu0YyTOrxemLI6bDhFzvaafTU/a3Eqwq7lx+5yvwv0n+Aagw81ykLh
 VRweD3J/5fEqoro/lTYFyJeEXw==
X-Google-Smtp-Source: AGHT+IHmqDcKooveHvt6c92esWSqFTxf0Y0i3TYDQy3N1Kfs//G5ZrhbMrBP7oV5dEWsm3pre9bF5g==
X-Received: by 2002:a0d:c246:0:b0:561:d1b0:3f7e with SMTP id
 e67-20020a0dc246000000b00561d1b03f7emr14225753ywd.44.1692810904784; 
 Wed, 23 Aug 2023 10:15:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 d3-20020a81ab43000000b00573898fb12bsm3395471ywk.82.2023.08.23.10.15.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:15:04 -0700 (PDT)
Date: Wed, 23 Aug 2023 13:15:02 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@google.com>
Cc: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
Message-ID: <20230823171502.GQ3953269@bill-the-cat>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ1wGkq66ZEXHUVzLpc47fYgV0+Kk9WNwqDWcO0R7jEYVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UjI+4AjlPf9ws0j+"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1wGkq66ZEXHUVzLpc47fYgV0+Kk9WNwqDWcO0R7jEYVA@mail.gmail.com>
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


--UjI+4AjlPf9ws0j+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 09:30:31AM -0600, Simon Glass wrote:
> Hi Nishanth,
>=20
> On Tue, 22 Aug 2023 at 12:43, Nishanth Menon <nm@ti.com> wrote:
> >
> > Add base documentation for BeaglePlay
> >
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >
> > Changes Since V3:
> > * Updated documentation to give a more clear overview of MMC partitions
> >   and flashing information.
> > * Added OpenOCD debug documentation
> > * Added LED status information and indication of various boot stages
> >
> > V3: https://lore.kernel.org/all/20230815164440.2713726-5-nm@ti.com/
> > V2: https://lore.kernel.org/u-boot/20230727234446.3651836-5-nm@ti.com/
> > V1: https://lore.kernel.org/all/20230725185253.2123433-7-nm@ti.com/
> >
> >  doc/board/ti/am62x_beagleplay.rst    | 256 ++++++++++
> >  doc/board/ti/img/beagleplay_emmc.svg | 697 +++++++++++++++++++++++++++
> >  doc/board/ti/k3.rst                  |   1 +
> >  3 files changed, 954 insertions(+)
> >  create mode 100644 doc/board/ti/am62x_beagleplay.rst
> >  create mode 100644 doc/board/ti/img/beagleplay_emmc.svg
> >
>=20
> Great docs, an example to others.
>=20
> Some nits below.
>=20
> The bigger problem is that we cannot build this with buildman since it
> needs config fragments and we don't have a way to describe them. In
> fact none of my existing flows can build this board and it breaks all
> my scripts, etc.
>=20
> I don't think anyone else sees this as a problem?
>=20
> Anyway, I'll send a separate email on the topic.
>=20
> > diff --git a/doc/board/ti/am62x_beagleplay.rst b/doc/board/ti/am62x_bea=
gleplay.rst
> > new file mode 100644
> > index 000000000000..5adb7b4c9ace
> > --- /dev/null
> > +++ b/doc/board/ti/am62x_beagleplay.rst
> > @@ -0,0 +1,256 @@
> > +.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> > +.. sectionauthor:: Nishanth Menon <nm@ti.com>
> > +
> > +AM62x Beagleboard.org Beagleplay
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Introduction:
> > +-------------
> > +
> > +BeagleBoard.org BeaglePlay is an easy to use, affordable open source
> > +hardware single board computer based on the Texas Instruments AM625
> > +SoC that allows you to create connected devices that work even at long
> > +distances using IEEE 802.15.4g LR-WPAN and IEEE 802.3cg 10Base-T1L.
> > +Expansion is provided over open standards based mikroBUS, Grove and
> > +QWIIC headers among other interfaces.
> > +
> > +Further information can be found at:
> > +
> > +* Product Page: https://beagleplay.org/
> > +* Hardware documentation: https://git.beagleboard.org/beagleplay/beagl=
eplay
> > +
> > +Boot Flow:
> > +----------
> > +Below is the pictorial representation of boot flow:
> > +
> > +.. image:: img/boot_diagram_k3_current.svg
> > +  :alt: Boot flow diagram
> > +
> > +- On this platform, 'TI Foundational Security' (TIFS) functions as the
> > +  security enclave master while 'Device Manager' (DM), also known as t=
he
> > +  'TISCI server' in "TI terminology", offers all the essential service=
s.
> > +  The A53/M4F (Aux core) sends requests to TIFS/DM to accomplish these
> > +  services, as illustrated in the diagram above.
> > +
> > +Sources:
> > +--------
> > +.. include::  k3.rst
> > +    :start-after: .. k3_rst_include_start_boot_sources
> > +    :end-before: .. k3_rst_include_end_boot_sources
> > +
> > +Build procedure:
> > +----------------
> > +0. Setup the environment variables:
> > +
> > +.. include::  k3.rst
> > +    :start-after: .. k3_rst_include_start_common_env_vars_desc
> > +    :end-before: .. k3_rst_include_end_common_env_vars_desc
> > +
> > +.. include::  k3.rst
> > +    :start-after: .. k3_rst_include_start_board_env_vars_desc
> > +    :end-before: .. k3_rst_include_end_board_env_vars_desc
> > +
> > +Set the variables corresponding to this platform:
> > +
> > +.. include::  k3.rst
> > +    :start-after: .. k3_rst_include_start_common_env_vars_defn
> > +    :end-before: .. k3_rst_include_end_common_env_vars_defn
> > +.. code-block:: bash
> > +
> > + $ export UBOOT_CFG_CORTEXR=3D"am62x_evm_r5_defconfig beagleplay_r5.co=
nfig"
> > + $ export UBOOT_CFG_CORTEXA=3D"am62x_evm_a53_defconfig beagleplay_a53.=
config"
>=20
> Can you drop those two variables? It seems to just confuse the matter.
> They are only used once. We are used to seeing a 'defconfig' target
> when configuring, and this just obfuscates things.

This is how we have a common bit of rST for how to build N boards,
without having to do a literal copy and paste N times.

--=20
Tom

--UjI+4AjlPf9ws0j+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmPpYACgkQFHw5/5Y0
tyw0Ewv+KXKX5aFM9ilcFZeTqYMrqAQIY22rmngNKTnEGDICMKcgLnAGDcMWaPYf
XtmUdRHkmiDW34G14sY3DuVtXQPCxcOA5y2avzXxqQfSHzJItW1ya5b9JGgLhTlL
ICKj/SOp4zXaoOMgZdjXgj6aC+O5ZP5fN8EP70P6eqFoZ0OT3UPphkh9ChB+vxN/
d57ohKF6Ge1R15y38D4zi65nV91X8Z2WKfub3C06tbYYm6MXUQEB59Q/O46v9mFe
6WUEjm2VF1hEsqnvQKtW2HFwRPeNRiVD4VAXHiOXiPK0NdC6GLIQ3UUR8iCC9Au2
tl6XqmVgwQQL9f4BT2EevoWLF1CCJoen7kDe1IrLv21RcL1XWWvPNL6SOY9gmIL0
vMytZWHOebXiIqYAQ8enXwaxMfbfkeeFZp5K3Q+uKVRoAG/8AOQhpv/7WIBK54VA
0FN4w/98EVXQnhSPk6gbBszV3ttT1eoJOHVwemSObgE46UTdqERyKZBdPiQuTJIA
PJaCmqWv
=kjyj
-----END PGP SIGNATURE-----

--UjI+4AjlPf9ws0j+--
