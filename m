Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF04CAC598
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 17:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2344380050;
	Wed, 17 Sep 2025 19:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bLG/AWSe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F03A5800B6; Wed, 17 Sep 2025 19:46:19 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC7B08003E
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 19:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-891292b8495so7557539f.3
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 10:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758131176; x=1758735976; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AQIo/WGHWv/qq0piRX5rzD7XW6HfDKrUcsduEQEBS0E=;
 b=bLG/AWSegl/I1JQDD9lgdFIeEvEZDQb5smKZocxv5a8uPCk/inn/dQa1KdLcw2QE+9
 JOXFnDCHq1NGN3V1LSZYCAsUwm4jJPINWCw0bBbvGZSOurV5zNjZm30b6EoUWlmnL8Py
 +LaOxoYMkEN0wYnSuNn7KTkzT8XTnKJL/GrJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758131176; x=1758735976;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AQIo/WGHWv/qq0piRX5rzD7XW6HfDKrUcsduEQEBS0E=;
 b=e4bxmKgAvO5orczxADpykCOKy0vcKQYulHnbhkk7ZIrbCf2QfWlsBItD6inCoc9yaT
 cXzBcuQC8amu13flO7lSNCYp5RSWw5ptAE2gOxtVeakZDkTv5dmPm4qGcBc9S1Cdw4LQ
 ZYz40ScI9iwi6GiCad5bvmfIvL+QKMbKEnic/64F/CzWJKJ19a19zJNycdDgQi89lbww
 l0DXKMuzu9KaJk8AbCQBYdYtk0QVuspBlkv8pQLr+z3Y8aI0D6bWsCcTYSmdKm17ogKF
 CdupT3656ASllVctK5YbEJUIK30u5vexaKhvRdHoJC+p/zYmjAHpNxVft4IPyz13lDTE
 KGvQ==
X-Gm-Message-State: AOJu0YxOHrHwjY1tWYEdfVQWBxZ6lLbmWBZK+ccWOfmzqE2Ia8HKQu9E
 m69v4zQhQ/aiuODsYI5QDw/E6ayO9CzVa0k3+Ip/CHDAYIxhhHrxcZxxRJrk2l9ZOQk=
X-Gm-Gg: ASbGncsHt/SXG1wL00qARSSnXX/qEGhbN2aKUgDB1ahMZ0bWUOKbq+RXg2S36W8KlHi
 uyGBOV9xDoYNeFanMN5pR4GLSdKygRlWUjwfva3zb2R/HhU02UPW7d3KqUs2ztsv7kI2pZ6pBQU
 NTBTe/h3u0rlkihIcOi1ilhC7/Vutlr3kvMQnzbcifcYcvSCKwvK505mgJRA5ioFiQWLApCa0U8
 VesDvlI+SietQeGkvPEk7LHlFdOAL0hLY68dxVKSdlad4RWN/HohlhChWB8aST46xCXkQH7Q8AD
 F0IZ/rmoeJajfcaG4Vgtys7i8vWerzLjxHEPDq1WHXWUbXIFUgsKW9g2MgkzT2NC4Ha1265LrP1
 ZJVhJMlpI35m7v1Uk6mIToB6pBYOBQTYhczBmBIRhY1HjcqSnJu3A9ozu
X-Google-Smtp-Source: AGHT+IFohhQnzXJhSPVmsx4D1GGGRMLtWsyzcuA0msS6QLmZbkkbX839EOawVBHKLlBNBxAnuKU6ow==
X-Received: by 2002:a05:6e02:1522:b0:404:fda5:fa2d with SMTP id
 e9e14a558f8ab-4241a4ce355mr40166155ab.6.1758131176361; 
 Wed, 17 Sep 2025 10:46:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-4244a67d298sm252775ab.14.2025.09.17.10.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 10:46:15 -0700 (PDT)
Date: Wed, 17 Sep 2025 11:46:12 -0600
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
Message-ID: <20250917174612.GN124814@bill-the-cat>
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-4-raymond.mao@linaro.org>
 <20250916182747.GA124814@bill-the-cat>
 <CAEfUkUKX6zM+=R4s9UOQAmDho-V9UULvky0rG7H1CVj6uJCy9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9s27q1HWa2kN02Qc"
Content-Disposition: inline
In-Reply-To: <CAEfUkUKX6zM+=R4s9UOQAmDho-V9UULvky0rG7H1CVj6uJCy9g@mail.gmail.com>
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


--9s27q1HWa2kN02Qc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:54:08AM -0400, Raymond Mao wrote:
> Hi Tom,
>=20
> On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Sep 16, 2025 at 09:14:19AM -0700, Raymond Mao wrote:
> > > Add test cases to validate FDT and TPM eventlog handoff from TF-A
> > > and OP-TEE via bloblist.
> > >
> > > For FDT, the nodes 'reserved-memory' and 'firmware' appended by
> > > OP-TEE indicates a successful handoff.
> > >
> > > For TPM eventlog, the events 'SECURE_RT_EL3', 'SECURE_RT_EL1_OPTEE'
> > > and 'SECURE_RT_EL1_OPTEE_EXTRA1' created by TF-A indicates a
> > > successful handoff.
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > ---
> > >  test/py/tests/test_fw_handoff.py | 94 ++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 94 insertions(+)
> > >  create mode 100644 test/py/tests/test_fw_handoff.py
> > >
> > > diff --git a/test/py/tests/test_fw_handoff.py b/test/py/tests/test_fw=
_handoff.py
> > > new file mode 100644
> > > index 00000000000..4cdf51a4375
> > > --- /dev/null
> > > +++ b/test/py/tests/test_fw_handoff.py
> > > @@ -0,0 +1,94 @@
> > > +# SPDX-License-Identifier: GPL-2.0+
> > > +#
> > > +# Copyright (c) 2025 Linaro Limited
> > > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > > +#
> > > +# Validate Firmware Handoff from TF-A and OP-TEE
> > > +
> > > +import pytest
> > > +import re
> > > +
> > > +def _norm_ws(s: str) -> str:
> > > +    """Normalize whitespace for robust comparisons."""
> > > +    return re.sub(r"\s+", " ", s).strip()
> > > +
> > > +@pytest.mark.buildconfigspec("bloblist")
> > > +@pytest.mark.buildconfigspec("cmd_bloblist")
> > > +@pytest.mark.buildconfigspec("of_control")
> > > +@pytest.mark.buildconfigspec("cmd_fdt")
> > > +def test_fw_handoff_dt(ubman):
> > > +    """Validate FDT handoff via bloblist."""
> > > +
> > > +    if (ubman.config.board_type !=3D 'qemu_arm64' or
> > > +        ubman.config.board_identity !=3D 'fw_handoff_tfa_optee'):
> > > +        pytest.skip("Test only for qemu_arm64 with ID fw_handoff_tfa=
_optee")
> >
> > This (and the other tests) should be more pytest.mark.buildconfigspec
> > but for TARGET_QEMU_ARM_64BIT and then relevant TF-A/OP-TEE options. And
> > even then, possibly just the relevant TF-A/OP-TEE options as it should
> > work on other platforms too, yes? Thanks.
> >
> Just like what you commented to my test-hooks patches, if we can merge
> and use a general conf qemu_arm64_na, the check for the board ID is no
> longer needed.
> But still this is for qemu_arm64 only, since the TF-A driver is
> platform-dependent, thus the feature currently only works on a few
> platforms.

My point is that if a platform enables the correct U-Boot options (and
only would if the rest of the firmware stack supported it, yes?) then
this test should also run correctly. Right?

--=20
Tom

--9s27q1HWa2kN02Qc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMrz4QAKCRAr4qD1Cr/k
CnX/AP9MANR709Pr9UREUrrmpAo9SvmK4sATOpLQTe1+ua0tAwEA1770X5aq3nrt
6PPhAve64a4OAA8mS0jsWQ/IdEPtbAI=
=pRYV
-----END PGP SIGNATURE-----

--9s27q1HWa2kN02Qc--
