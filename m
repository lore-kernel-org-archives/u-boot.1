Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57E9CAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 13:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 079B783211;
	Mon, 22 Sep 2025 15:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XrLKLWxb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EE7C832F9; Mon, 22 Sep 2025 15:59:10 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9AF482CF4
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 15:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-889b846c314so101581939f.2
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 06:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758549544; x=1759154344; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EVEfieoaQUXBMmtdfcqK1UydKSuz2Ky9Ycm8IZoXV2o=;
 b=XrLKLWxbtPvn5XpwO6LckI6YO/8o/3NOIB5HdTIOC0fkksNgW7irIpSUt+Y9zLdBz7
 rXBIYOpuJ62vIJHLQNf4DkD8TRoHvNdWBSQmhDceipwZnz0p8w5soCzvbKLA1enk8CMN
 TbTfDSQkPrtZ94YPj/jINOFu7tIIiyO1Bc8JA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758549544; x=1759154344;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVEfieoaQUXBMmtdfcqK1UydKSuz2Ky9Ycm8IZoXV2o=;
 b=PHlC9e2q7kGVYwOpHPcmRgaGI0/XVHd5j57h963ihTXo+IKh/YMgw4W6cl+wYhPdqQ
 Z5yY3sKWkeSz54NVup9Le/UweqEoXjwKmqGtrHYofzEcuJvjfixSOS4Lj10uYWiv6JF4
 bc3MgBaBjpEDkMNMfWRut/SXuqvUeTAq97iBwDQqDLVWsa9FSUd/oQBQvNuOBEPbKKd1
 xRovh+Lw7tu60bQxXG/qycFI8tp9+LRjs81vtYTvpPEiwYnD3AnXga74XQhri/oxK9yz
 Cq6jKF2zLHkeCbczN/xJ+IpN7oeEEEWcSPPYOmq2V92R3pRPwPAB+kW9YtR+Tw4jtVbl
 +LMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW+u0S6AmcoS2MrUJwWRPwPyDtT/tIL/ljGIvThcM+PXDhD5Z+po6ydivofRjHIpSqM1kJZ38=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8vxe1En1Zk08bVavfV3pKWlWxxaP3J8HeXM0h9qy+GwLfje3y
 13XpTnUKp4WUF00nMg+WrOJ5GTBLoL7mHGIz1BfS9UsSEwxJPNCHqSVmV+3+FIrjI8I=
X-Gm-Gg: ASbGnctE84Or/C/U/cGYtqzC+PomqFllCx+DGalRBDxFUtiHCx7VqUwtLl0nPRUZT2G
 3NpkwGq9zDRMC38GG8UXhTtSkI6kf9j3XOpQIqw2vsMJ7rJbV4G7PW7Eh0owNbrR3bOxIW9/hht
 D7KNqBHmEoqcUi11SLx0xVIHItxyTTZFr3vw2fgUfc5Oi7yfAZtpG62XRtZe63JJqjPtJvAAGve
 IpPbnbNnyaFpMBpPaIbWHRclT25RZlNEhgfay4MiCUjOCnYVyHD3Xj3jpdsXQ2ASELJ3gESlieH
 jKkQT4OjL1gbcpXkx7R+CiivfC/PwPVHIwwEIuUFPy/iDOpKKPpT5nNEutoBP/ztnpBRoZndjlU
 Dj/0JzypKvQlxpnf0y8/BgWciMU4eKoqVO9/do8p0cEspvEIxPdDPUrlV
X-Google-Smtp-Source: AGHT+IEPUVycMEbBgpVMQM8Xo0RQY4QeCiJATVKAcT7KrA50IaB5fHg61i3S3jxtwM7KALim3EnwnQ==
X-Received: by 2002:a05:6e02:12e4:b0:425:6edd:f004 with SMTP id
 e9e14a558f8ab-4256eddf1f0mr97004465ab.20.1758549544226; 
 Mon, 22 Sep 2025 06:59:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-557e9e4252csm2221966173.81.2025.09.22.06.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 06:59:03 -0700 (PDT)
Date: Mon, 22 Sep 2025 07:59:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH 2/5] ci: add post-buildman script to build TF-A
Message-ID: <20250922135901.GB124814@bill-the-cat>
References: <20250916161426.32259-1-raymond.mao@linaro.org>
 <20250916161426.32259-3-raymond.mao@linaro.org>
 <20250916182742.GZ124814@bill-the-cat>
 <CAEfUkUL2t64-hz-_acWHf01WgLeddYu7S8dRudmNT3re0_hfnQ@mail.gmail.com>
 <20250917154926.GM124814@bill-the-cat>
 <CAFLszTjBPpgPcqTuAdzhV=HAR01mvzFKBTcNOrxxz4djZ-8h0A@mail.gmail.com>
 <20250919152638.GW124814@bill-the-cat>
 <CAFLszTgvGT56_r6R8QGpu1kV8PcNUk3diVAguadZeBfKfh6vjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UEbsHv9QCI9lhgYF"
Content-Disposition: inline
In-Reply-To: <CAFLszTgvGT56_r6R8QGpu1kV8PcNUk3diVAguadZeBfKfh6vjw@mail.gmail.com>
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


--UEbsHv9QCI9lhgYF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 10:13:34AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 19 Sept 2025 at 09:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Sep 19, 2025 at 09:09:26AM -0600, Simon Glass wrote:
> > > Hi Raymond,
> > >
> > > On Wed, 17 Sept 2025 at 09:49, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Sep 17, 2025 at 11:44:07AM -0400, Raymond Mao wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 16 Sept 2025 at 14:27, Tom Rini <trini@konsulko.com> wrot=
e:
> > > > > >
> > > > > > On Tue, Sep 16, 2025 at 09:14:18AM -0700, Raymond Mao wrote:
> > > > > > > Add a script which is running after buildman to fetch TF-A (v=
2.13.0)
> > > > > > > with MbedTLS (v3.6) and build 'flash.bin', linking built U-Bo=
ot as
> > > > > > > BL33 and OP-TEE as BL32, with both Firmware Handoff and Measu=
red Boot
> > > > > > > enabled.
> > > > > > >
> > > > > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > > > > ---
> > > > > > >  .azure-pipelines.yml               |  1 +
> > > > > > >  .gitlab-ci.yml                     |  1 +
> > > > > > >  tools/post_build_tfa_fw_handoff.sh | 87 ++++++++++++++++++++=
++++++++++
> > > > > > >  3 files changed, 89 insertions(+)
> > > > > > >  create mode 100755 tools/post_build_tfa_fw_handoff.sh
> > > > > > >
> > > > > > > diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> > > > > > > index 8209d2b329c..eb547606ddd 100644
> > > > > > > --- a/.azure-pipelines.yml
> > > > > > > +++ b/.azure-pipelines.yml
> > > > > > > @@ -290,6 +290,7 @@ stages:
> > > > > > >            cp /opt/grub/grubriscv64.efi \${UBOOT_TRAVIS_BUILD=
_DIR}/grub_riscv64.efi
> > > > > > >            cp /opt/grub/grubaa64.efi \${UBOOT_TRAVIS_BUILD_DI=
R}/grub_arm64.efi
> > > > > > >            cp /opt/grub/grubarm.efi \${UBOOT_TRAVIS_BUILD_DIR=
}/grub_arm.efi
> > > > > > > +          ./tools/post_build_tfa_fw_handoff.sh \${UBOOT_TRAV=
IS_BUILD_DIR} \${TEST_PY_BD} \${TEST_PY_ID}
> > > > > > >            # create sdcard / spi-nor images for sifive unleas=
hed using genimage
> > > > > > >            if [[ "\${TEST_PY_BD}" =3D=3D "sifive_unleashed" ]=
]; then
> > > > > > >                mkdir -p root;
> > > > > > > diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> > > > > > > index 85401d3e09b..61e4af96c9a 100644
> > > > > > > --- a/.gitlab-ci.yml
> > > > > > > +++ b/.gitlab-ci.yml
> > > > > > > @@ -79,6 +79,7 @@ stages:
> > > > > > >      - cp /opt/grub/grubriscv64.efi $UBOOT_TRAVIS_BUILD_DIR/g=
rub_riscv64.efi
> > > > > > >      - cp /opt/grub/grubaa64.efi $UBOOT_TRAVIS_BUILD_DIR/grub=
_arm64.efi
> > > > > > >      - cp /opt/grub/grubarm.efi $UBOOT_TRAVIS_BUILD_DIR/grub_=
arm.efi
> > > > > > > +    - ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BU=
ILD_DIR} ${TEST_PY_BD} ${TEST_PY_ID}
> > > > > > >      # create sdcard / spi-nor images for sifive unleashed us=
ing genimage
> > > > > > >      - if [[ "${TEST_PY_BD}" =3D=3D "sifive_unleashed" ]]; th=
en
> > > > > > >          mkdir -p root;
> > > > > > > diff --git a/tools/post_build_tfa_fw_handoff.sh b/tools/post_=
build_tfa_fw_handoff.sh
> > > > > > > new file mode 100755
> > > > > > > index 00000000000..f876db593ba
> > > > > > > --- /dev/null
> > > > > > > +++ b/tools/post_build_tfa_fw_handoff.sh
> > > > > >
> > > > > > The "is this a valid board" check should be in the pipeline fil=
e (like
> > > > > > where we do all the other board-specific things) instead of the=
 helper
> > > > > > script.
> > > > > >
> > > > > > > @@ -0,0 +1,87 @@
> > > > > > > +#!/bin/bash
> > > > > > > +# SPDX-License-Identifier: GPL-2.0+
> > > > > > > +#
> > > > > > > +# Copyright (c) 2025 Linaro Limited
> > > > > > > +# Author: Raymond Mao <raymond.mao@linaro.org>
> > > > > > > +#
> > > > > > > +# CI Post-buildman script for building TF-A 'flash.bin' with=
 Measured
> > > > > > > +# Boot and Firmware Handoff enabled.
> > > > > > > +#
> > > > > > > +# Usage: from the top level U-Boot source tree, run:
> > > > > > > +# $ ./tools/post_build_tfa_fw_handoff.sh ${UBOOT_TRAVIS_BUIL=
D_DIR} \
> > > > > > > +#     ${TEST_PY_BD} ${TEST_PY_ID}
> > > > > > > +#
> > > > > > > +# 'bl1.bin', 'fip.bin' and 'flash.bin' will be generated and=
 copied
> > > > > > > +# to /tmp.
> > > > > > > +
> > > > > > > +set -e
> > > > > > > +
> > > > > > > +BUILDMAN_OUT_DIR=3D$(realpath "$1")
> > > > > > > +BOARD=3D$2
> > > > > > > +ID=3D$4
> > > > > > > +echo "Buildman Outdir: $BUILDMAN_OUT_DIR, Board: $BOARD, ID:=
 $ID"
> > > > > >
> > > > > > Can we not use fiptool to update the contents of a file here? A=
nd build
> > > > > > as much as possible in the Dockerfile, like we do for vexpress?
> > > > > >
> > > > > Sorry I am not quite clear about how it was done for fvp, maybe I
> > > > > missed some context, do you mean to build TF-A with OP-TEE at
> > > > > Dokerfile and generate a fip.bin without BL33? But then who will
> > > > > assemble BL1+fip+u-boot? by test hooks?
> > > >
> > > > So for FVP, in the Dockerfile we say BL33=3D/dev/null and this gets
> > > > packaged correctly. Then in u-boot-test-hooks we have bin/flash.fip=
tool
> > > > which will update "fip" with the just-built u-boot.bin. The logic:
> > > >     # If we have TF-A binaries, we need to use them.
> > > >     - if [[ -d /opt/tf-a/"${TEST_PY_BD}" ]]; then
> > > >         cp /opt/tf-a/"${TEST_PY_BD}"/fip.bin /opt/tf-a/"${TEST_PY_B=
D}"/bl1.bin /tmp/;
> > > >         export fip=3D/tmp/fip.bin;
> > > >         export bl1=3D/tmp/bl1.bin;
> > > >         export PATH=3D/opt/Base_RevC_AEMvA_pkg/models/Linux64_GCC-9=
=2E3:${PATH};
> > > >       fi
> > > >
> > > > Is how we know what bl1.bin and fip.bin to use as the base.
> > > >
> > > > --
> > > > Tom
> > >
> > > This should actually use binman.  We don't want any shell scripts for
> > > building :-) We finally got rid of the FIT generator script after some
> > > years.
> > >
> > > Build mbedtls and TFA should be in dockerfile, like we have for
> > > coreboot, for example. I suspect they will be useful in other tests
> > > too.
> >
> > There's nothing to do here for binman, it already supports fiptool. It
> > just doesn't make much sense to add the complexity in this case however.
>=20
> Write a binman description so it creates an image as part of the build
> for this board.
>=20
> It could be a good example if other people want to use TF-A, etc. with U-=
Boot.

No, I don't think that makes sense in this case, you're missing
sufficient context.

--=20
Tom

--UEbsHv9QCI9lhgYF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNFWJAAKCRAr4qD1Cr/k
CmB3AQCh57ceTj9/0pMWAE3ej/Uy9RcKXPyP3ZFJKkbC8FJZJQEAqmikER5J7Eq/
AhES3lgprZgEwg9iE7r0UgXo+Z0Vtgo=
=a46l
-----END PGP SIGNATURE-----

--UEbsHv9QCI9lhgYF--
