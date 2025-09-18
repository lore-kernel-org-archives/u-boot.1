Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1511CCAC597
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 23:19:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51CA981E13;
	Fri, 19 Sep 2025 01:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j9T8Gf77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E72FD829E7; Fri, 19 Sep 2025 01:19:54 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 948D480B9B
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 01:19:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-745a415bf72so659404a34.2
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 16:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758237591; x=1758842391; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vq4gM2mWF25PyOZTpwNdHx1FiUzRV7QElsAwzCLp0yY=;
 b=j9T8Gf77fukEDSA+phzFOUDy1QDcBI40bxpwJTkHeT57Rk5oN5rQrTJ1cKH2B/iTrb
 QA/ViH75cOLiMu2u9y2ApGcBH0AMKaW3j1tebOJ8FROpQ0AO6xouOEhikDE1WKcYfJub
 luL/JfrPUuY4q12e3ZlkZ+rmsNbEc+phSQ7U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758237591; x=1758842391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vq4gM2mWF25PyOZTpwNdHx1FiUzRV7QElsAwzCLp0yY=;
 b=a5nIdA/dY7cJBl7+k7dFGRO7dCncQHqSWJmBngv+1BpuHPIySpr/fmNeHdM/pgyWLn
 o2fUEl6hMD1EGMlKPNBSHVUO9/zYib2ctXyI2ukgcAbAgZmG1R3LMdfHlRKje1mob8sk
 /6z9shEXsYEwSg3J8mqF2KX+PvP2NWZEwcj0DHDJXyBqDivra9FhT8Vrq+b12bGwumpy
 +r2OkaVohPowO5lpnZ9A1uacF7eNXNltCuihG5n1Y5wu8iBummGFVSjvDIIHuovylHbT
 wf/NgrOnJIviXVx9qoZ3xfaURjwMDPOAzIlPDt55VLYQ0igULxAnLq/p3fwoZgdWvq4i
 rqow==
X-Gm-Message-State: AOJu0YyKtBjW/29sNwyhreQpW8VWUmpbFbjkGOB0F0JzxaWt5RxnY+W6
 HOkEmdXQReKrgE1B0htWY9YxkaDcywoe4qwm/wH1k0aPzBCqaBYtAinmI2io8DLj2OE=
X-Gm-Gg: ASbGnctH2uFXhWbFfan6Y4QjxvaQADz76ZseQjGUnqevYWMRmaue7I0lfi05zM1b5QX
 ru9qF0oI9kvYAzum/x06AvNVZLaGiTXVu0tCGyWLa0nVbSTMia3psLA/oH92JCdTJ9UadOseooA
 DTXKqCwG4rDtPvpEe5CrBpAf9eJaUZj5SFnSK2rzAmHOvOKxNiy3LoFXCQ0I39KnAEbwrfoyL8Y
 Y5Dmms59XhnuKCVz0vYC4/41R4eoCjTBhJGrCgUfOAxg4b4OaD/PZTM8VPZO6cB+pfmYEiFbvvb
 fERzOuBGFKy6WpVv+74oudPLQGWjTEPoO7HU+tzn/QAVhhxpw6BXRJClMUyqt4sSgJbPd0Vll2X
 pbi/naHcbqw5CQ8XZPisjs5xTuXvuixD/jvuUKxrDyMAaYUlR+GGI4zIs
X-Google-Smtp-Source: AGHT+IFcD3Z95fne77LKV7BnFHj6v82vO3CX1NABkdg4LxNIxe9iBr+B56rU3PLMLKOEnurdHtydWw==
X-Received: by 2002:a05:6808:19a3:b0:439:b491:401b with SMTP id
 5614622812f47-43d6c111b57mr519106b6e.10.1758237591160; 
 Thu, 18 Sep 2025 16:19:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-43d5c85d269sm1306911b6e.23.2025.09.18.16.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 16:19:50 -0700 (PDT)
Date: Thu, 18 Sep 2025 17:19:47 -0600
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
Message-ID: <20250918231947.GR124814@bill-the-cat>
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-4-raymond.mao@linaro.org>
 <20250916182747.GA124814@bill-the-cat>
 <CAEfUkUKX6zM+=R4s9UOQAmDho-V9UULvky0rG7H1CVj6uJCy9g@mail.gmail.com>
 <20250917174612.GN124814@bill-the-cat>
 <CAEfUkUL_YzG41ta=2XRv_XWY8A43ZZ9aX3Fci6f9D0zjoDjwzw@mail.gmail.com>
 <20250918200919.GO124814@bill-the-cat>
 <CAEfUkULbRavxp+xd8TDwihRk6tVGxicgd0oeDxs9wZSdudBzNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bnDyRDk6AvRWW41k"
Content-Disposition: inline
In-Reply-To: <CAEfUkULbRavxp+xd8TDwihRk6tVGxicgd0oeDxs9wZSdudBzNA@mail.gmail.com>
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


--bnDyRDk6AvRWW41k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 06:44:14PM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Thu, 18 Sept 2025 at 16:09, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Sep 18, 2025 at 11:05:25AM -0400, Raymond Mao wrote:
> > > Hi Tom,
> > >
> > > On Wed, 17 Sept 2025 at 13:46, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Sep 17, 2025 at 11:54:08AM -0400, Raymond Mao wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrot=
e:
> > > > > >
> > > > > > On Tue, Sep 16, 2025 at 09:14:19AM -0700, Raymond Mao wrote:
> > > > > > > Add test cases to validate FDT and TPM eventlog handoff from =
TF-A
> > > > > > > and OP-TEE via bloblist.
> > > > > > >
> > > > > > > For FDT, the nodes 'reserved-memory' and 'firmware' appended =
by
> > > > > > > OP-TEE indicates a successful handoff.
> > > > > > >
> > > > > > > For TPM eventlog, the events 'SECURE_RT_EL3', 'SECURE_RT_EL1_=
OPTEE'
> > > > > > > and 'SECURE_RT_EL1_OPTEE_EXTRA1' created by TF-A indicates a
> > > > > > > successful handoff.
> > > > > > >
> > > > > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > > > > ---
> > > > > > >  test/py/tests/test_fw_handoff.py | 94 ++++++++++++++++++++++=
++++++++++
> > > > > > >  1 file changed, 94 insertions(+)
> > > > > > >  create mode 100644 test/py/tests/test_fw_handoff.py
> > > > > > >
> > > > > > > diff --git a/test/py/tests/test_fw_handoff.py b/test/py/tests=
/test_fw_handoff.py
> > > > > > > new file mode 100644
> > > > > > > index 00000000000..4cdf51a4375
> > > > > > > --- /dev/null
> > > > > > > +++ b/test/py/tests/test_fw_handoff.py
> > > > > > > @@ -0,0 +1,94 @@
> > > > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > > > +#
> > > > > > > +# Copyright (c) 2025 Linaro Limited
> > > > > > > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > > > > > > +#
> > > > > > > +# Validate Firmware Handoff from TF-A and OP-TEE
> > > > > > > +
> > > > > > > +import pytest
> > > > > > > +import re
> > > > > > > +
> > > > > > > +def _norm_ws(s: str) -> str:
> > > > > > > +    """Normalize whitespace for robust comparisons."""
> > > > > > > +    return re.sub(r"\s+", " ", s).strip()
> > > > > > > +
> > > > > > > +@pytest.mark.buildconfigspec("bloblist")
> > > > > > > +@pytest.mark.buildconfigspec("cmd_bloblist")
> > > > > > > +@pytest.mark.buildconfigspec("of_control")
> > > > > > > +@pytest.mark.buildconfigspec("cmd_fdt")
> > > > > > > +def test_fw_handoff_dt(ubman):
> > > > > > > +    """Validate FDT handoff via bloblist."""
> > > > > > > +
> > > > > > > +    if (ubman.config.board_type !=3D 'qemu_arm64' or
> > > > > > > +        ubman.config.board_identity !=3D 'fw_handoff_tfa_opt=
ee'):
> > > > > > > +        pytest.skip("Test only for qemu_arm64 with ID fw_han=
doff_tfa_optee")
> > > > > >
> > > > > > This (and the other tests) should be more pytest.mark.buildconf=
igspec
> > > > > > but for TARGET_QEMU_ARM_64BIT and then relevant TF-A/OP-TEE opt=
ions. And
> > > > > > even then, possibly just the relevant TF-A/OP-TEE options as it=
 should
> > > > > > work on other platforms too, yes? Thanks.
> > > > > >
> > > > > Just like what you commented to my test-hooks patches, if we can =
merge
> > > > > and use a general conf qemu_arm64_na, the check for the board ID =
is no
> > > > > longer needed.
> > > > > But still this is for qemu_arm64 only, since the TF-A driver is
> > > > > platform-dependent, thus the feature currently only works on a few
> > > > > platforms.
> > > >
> > > > My point is that if a platform enables the correct U-Boot options (=
and
> > > > only would if the rest of the firmware stack supported it, yes?) th=
en
> > > > this test should also run correctly. Right?
> > > >
> > > In U-Boot, Firmware Handoff is sharing the BLOBLIST kconfig, and with
> > > two prerequisites for a "handoff via bloblist" happen:
> > > 1. BLOBLIST is selected.
> > > 2. Registers are carrying a bloblist compliant to Firmware Handoff
> > > plus expected conventions.
> > >
> > > But a platform selecting BLOBLIST does not necessarily enable Firmware
> > > Handoff - Simon designed the bloblist with other purposes other than
> > > handoff.
> >
> > Ah, right, OK. So we need to make the test opt-in (via the board env
> > u_boot_boardenv_...) instead then. We can't hard-code a board ID in to
> > the tests, that's not portable.
> >
> Well, I can create a 'u_boot_boardenv_qemu_arm64_fw_handoff_tfa_optee.py'=
 with:
> 'env__firmware_handoff_enabled =3D True'.
> Then in the pytest get it via 'ubman.config.env.get()'.

Yes, and other platforms can also opt-in too. In theory, we could enable
this on vexpress_vfp_bloblist too (I want to take that out of regular
CI due to how often the race for console fails).

--=20
Tom

--bnDyRDk6AvRWW41k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMyTkAAKCRAr4qD1Cr/k
CrKwAQCdqFfiT/qX2V0L4yVdyHpd0pDrTqRzTdT1rSSYJY9SEwEAikKA6aKn/zTV
R8oIUv5bwtg/AyBO7W34Yh0FMSm4/gE=
=ZCWL
-----END PGP SIGNATURE-----

--bnDyRDk6AvRWW41k--
