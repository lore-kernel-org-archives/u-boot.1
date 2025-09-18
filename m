Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143E1CAC597
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 20:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35E598206E;
	Thu, 18 Sep 2025 22:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QD8rtfMH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C2F82C84; Thu, 18 Sep 2025 22:09:26 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFE6180B9B
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 22:09:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-3326d9ee5edso1003562fac.3
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 13:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758226162; x=1758830962; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qZeRdK9P7Ko2pSW7ayVEDMB9lRl5jO8M+vKJCps1ZC0=;
 b=QD8rtfMHB2AkKFBsWfCP6UnYkodifd9J7w9t7SDyuQVXMNwN7eVjQqfqiOTn5le6ry
 lra/wTgeesV+AkpjLjr8kE4Mef/g+k70dDBVicC+sHtDDXSG8DaQ49Kk/eDvOMLfGNTN
 E/5S2wHKy2UZeSczSK1U6GQEEF8K2exir6gp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758226162; x=1758830962;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZeRdK9P7Ko2pSW7ayVEDMB9lRl5jO8M+vKJCps1ZC0=;
 b=jfdZrLzf3hdfzSLpmqHlRnxUwRIYQSETDEyPm8T79xBOcrzHcULh0nOqc56PGz1F/c
 /kc8rH3NnttQzSD8PWEdYD7RQdy4B/yRMJzUnPt0fmoDi8uAqX7gXUUv5NmEHwFBSJiK
 +oJBJW6R99C/jclOxB6ba9Yjkl0oOgfX/9lD7InSEm+n2PCxisvRKLpgNC+ETaUOIO/I
 6e1hbu1uO064B2BvWvbN4A8z9Hv88yuf4JDBM2ih3F/zzn0M4OwjZTheqr4x3W7QASoS
 dCPp0a2vzLhy/lHgF3EO1P1lOaR6WkTWh1HRW44Sz0WLyTskn2+YauKs2AJVfFDdwfiw
 QWyg==
X-Gm-Message-State: AOJu0YyKMwLiqi1CSZlxGahYaLZB1Zgx4q2gZvA7TCyYy4Hk3fOvXZLm
 NsKP3qXu3wIJwsff/YlelOSAsacCbCTehO6VMvpP6dQo8LoeHboZkx4Jy08Mwbbf28o=
X-Gm-Gg: ASbGncvesMUle5O5S2YRqqjqBvBPB5Wa/S7z4HSTXS2W6VUg7fFUPZncH1OXuJ0TxBa
 4cSRDznctdhCblacliWUwahRBXian+FXVsYxV9da70PxlucR91CC68ZdLVabOQIONztHqDe7pHI
 H3aZpoLC5TQVAwHtZz/R7o1jWmBbym0tDwUEKWbHpVT9rwhkkwjLWpN57bCCvayM0VvF/wQwVbq
 HeIoNUltnP7bCv8oBO0DfmgkSD8S5f5jql3LJ3Mf0xMoHGE+Fqelleg/+Zrz8sPGicoyfqhBwJK
 GUT5qPChpjboAk/klhjGBFW06MAraHXOgbelJ72gza2vlyxjjInpCLZeMGjIAFLQjAav5clL6lF
 oJPQMDEj7aNKgtbNbcjBEm49xWq4frO+iSy00dRB3gwXi3nCxlDNpoGizHHfWkGMPsy6m/Nj04O
 o=
X-Google-Smtp-Source: AGHT+IFXFir1pAvl4HtmdUWaes7Uq58Kt4fNzaaFML/AkgIAQp1CX+s8JJyvFZlXJ+n7W9rtZ/5ixg==
X-Received: by 2002:a05:6870:bb0c:b0:321:4dd9:b850 with SMTP id
 586e51a60fabf-33bb4412e73mr610152fac.34.1758226162430; 
 Thu, 18 Sep 2025 13:09:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-336e3af71d4sm1884974fac.1.2025.09.18.13.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 13:09:21 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:09:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 3/5] pytest: add test script to validate Firmware Handoff
Message-ID: <20250918200919.GO124814@bill-the-cat>
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-4-raymond.mao@linaro.org>
 <20250916182747.GA124814@bill-the-cat>
 <CAEfUkUKX6zM+=R4s9UOQAmDho-V9UULvky0rG7H1CVj6uJCy9g@mail.gmail.com>
 <20250917174612.GN124814@bill-the-cat>
 <CAEfUkUL_YzG41ta=2XRv_XWY8A43ZZ9aX3Fci6f9D0zjoDjwzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6BdUorYLGIAsI7uS"
Content-Disposition: inline
In-Reply-To: <CAEfUkUL_YzG41ta=2XRv_XWY8A43ZZ9aX3Fci6f9D0zjoDjwzw@mail.gmail.com>
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


--6BdUorYLGIAsI7uS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 11:05:25AM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Wed, 17 Sept 2025 at 13:46, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Sep 17, 2025 at 11:54:08AM -0400, Raymond Mao wrote:
> > > Hi Tom,
> > >
> > > On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Sep 16, 2025 at 09:14:19AM -0700, Raymond Mao wrote:
> > > > > Add test cases to validate FDT and TPM eventlog handoff from TF-A
> > > > > and OP-TEE via bloblist.
> > > > >
> > > > > For FDT, the nodes 'reserved-memory' and 'firmware' appended by
> > > > > OP-TEE indicates a successful handoff.
> > > > >
> > > > > For TPM eventlog, the events 'SECURE_RT_EL3', 'SECURE_RT_EL1_OPTE=
E'
> > > > > and 'SECURE_RT_EL1_OPTEE_EXTRA1' created by TF-A indicates a
> > > > > successful handoff.
> > > > >
> > > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > > ---
> > > > >  test/py/tests/test_fw_handoff.py | 94 ++++++++++++++++++++++++++=
++++++
> > > > >  1 file changed, 94 insertions(+)
> > > > >  create mode 100644 test/py/tests/test_fw_handoff.py
> > > > >
> > > > > diff --git a/test/py/tests/test_fw_handoff.py b/test/py/tests/tes=
t_fw_handoff.py
> > > > > new file mode 100644
> > > > > index 00000000000..4cdf51a4375
> > > > > --- /dev/null
> > > > > +++ b/test/py/tests/test_fw_handoff.py
> > > > > @@ -0,0 +1,94 @@
> > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > +#
> > > > > +# Copyright (c) 2025 Linaro Limited
> > > > > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > > > > +#
> > > > > +# Validate Firmware Handoff from TF-A and OP-TEE
> > > > > +
> > > > > +import pytest
> > > > > +import re
> > > > > +
> > > > > +def _norm_ws(s: str) -> str:
> > > > > +    """Normalize whitespace for robust comparisons."""
> > > > > +    return re.sub(r"\s+", " ", s).strip()
> > > > > +
> > > > > +@pytest.mark.buildconfigspec("bloblist")
> > > > > +@pytest.mark.buildconfigspec("cmd_bloblist")
> > > > > +@pytest.mark.buildconfigspec("of_control")
> > > > > +@pytest.mark.buildconfigspec("cmd_fdt")
> > > > > +def test_fw_handoff_dt(ubman):
> > > > > +    """Validate FDT handoff via bloblist."""
> > > > > +
> > > > > +    if (ubman.config.board_type !=3D 'qemu_arm64' or
> > > > > +        ubman.config.board_identity !=3D 'fw_handoff_tfa_optee'):
> > > > > +        pytest.skip("Test only for qemu_arm64 with ID fw_handoff=
_tfa_optee")
> > > >
> > > > This (and the other tests) should be more pytest.mark.buildconfigsp=
ec
> > > > but for TARGET_QEMU_ARM_64BIT and then relevant TF-A/OP-TEE options=
=2E And
> > > > even then, possibly just the relevant TF-A/OP-TEE options as it sho=
uld
> > > > work on other platforms too, yes? Thanks.
> > > >
> > > Just like what you commented to my test-hooks patches, if we can merge
> > > and use a general conf qemu_arm64_na, the check for the board ID is no
> > > longer needed.
> > > But still this is for qemu_arm64 only, since the TF-A driver is
> > > platform-dependent, thus the feature currently only works on a few
> > > platforms.
> >
> > My point is that if a platform enables the correct U-Boot options (and
> > only would if the rest of the firmware stack supported it, yes?) then
> > this test should also run correctly. Right?
> >
> In U-Boot, Firmware Handoff is sharing the BLOBLIST kconfig, and with
> two prerequisites for a "handoff via bloblist" happen:
> 1. BLOBLIST is selected.
> 2. Registers are carrying a bloblist compliant to Firmware Handoff
> plus expected conventions.
>=20
> But a platform selecting BLOBLIST does not necessarily enable Firmware
> Handoff - Simon designed the bloblist with other purposes other than
> handoff.

Ah, right, OK. So we need to make the test opt-in (via the board env
u_boot_boardenv_...) instead then. We can't hard-code a board ID in to
the tests, that's not portable.

--=20
Tom

--6BdUorYLGIAsI7uS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMxm6wAKCRAr4qD1Cr/k
CsYUAQDxOm6hXefuhzDZsrivdvckOjStK67M6o23BnKX4Rx3LQEArUWnuOz4l07N
JoqXj3bC3j1Kwk/6qNllXuPaA8mo+go=
=OvZo
-----END PGP SIGNATURE-----

--6BdUorYLGIAsI7uS--
