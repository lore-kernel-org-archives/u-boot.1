Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA15E7716C
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 14:15:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A681A894F6;
	Thu,  5 Dec 2024 15:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pZp5xRLg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87E3E88E99; Thu,  5 Dec 2024 15:15:53 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9CB5894E7
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 15:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d8a13444fcso8419786d6.3
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 06:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733408149; x=1734012949; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mIwqrjtw0qQgX9wYY0Sb3sXvElCAnGdL2IzyXn8KqKM=;
 b=pZp5xRLgwK7rd/e1IEWRMblLunXeApLJBPMUnENZPMbLzvGZbdK+wO9YfWzbkZK9bB
 Em4NPwjsrFDYDh9gSvWELW24UTgSfBdiD498H1tc6wBQ9foWAR+WFmkawZWSNHQ3P6cL
 4/nwQmK7d3CNyHXIQclvjG1uSSUS1uVfEMOaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733408149; x=1734012949;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mIwqrjtw0qQgX9wYY0Sb3sXvElCAnGdL2IzyXn8KqKM=;
 b=BEDKOuU6Aqv2b1gGBbSArIY5p0aMhaDbUqisDnXmv0iPPW8V82AvcrlYMfWBvDvZYb
 u67Rk9ekFxM0UOyYZEGSWJX/xFeD1bSO6ysiQtEoFU/cYv8JEKZYdmPE6ff3oq942Iic
 qP9a9xVj8CvCRdXMMXB0beWzpcbi1S/81cqBUjKx/g4rPht6nRtUIeCdNfauQj8+ImuN
 HGx12ZX7rAMxmB1vhvJ/cB0YxItjBTaY+QSRe9eUXVX5OvvoBdK7dskr1bCkW3EpCAN2
 0Aw9yYC5iB2MPPbAFHrBIeY0cV1WWYU35otA+QjrkM5BiGAPyAdqcPOMMsPU2/8NOG/b
 KjtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXudnHPnHra1yw7SgdUTu40FhfyHUU2igT8Eels4gq4NHOin/ROI/Lr3+FLVFaGz+PFCNqYO6A=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+srYuK6ukDlICe3i57bR0tBz323tcD0NQ/RuMku9V1ZfJSgYT
 2uzRVriHfdYnyvc28Vd3GY2EpdbLoAj0bpNWQSJ+HwdIrwW7xqkYnXxgYepHul4=
X-Gm-Gg: ASbGncuyVl0FZ/8+5PdeC7G8kqQnGk5vRb5jJqV1cWrW2v4Xi/T+Xa6EFksIF45p2rW
 6svFK1hPEq6SVWlEM60HIyemgVZbPHFIscTSTrHcBcJ8DMKWE1/MInyZ9OuByC+f3fiusioWOzm
 VjzRTIJTlzmvtzq/aIut5dlTPF+Z5wNpQLoP8R0YDijWsutdTGVnyb9x8H9BR158061NjHt3vrP
 EcrktC6oGyRGYUyuZ0CWFWxzSW0T83AGCBlfMnxT6KDmpJswg==
X-Google-Smtp-Source: AGHT+IEmBxvYvJLwm69MZYlJ+dInsIdtt8ECX/+H+A254HtsK9tBvIwHcJhjzUbQvZEaMuVorg61HA==
X-Received: by 2002:a05:6214:ccb:b0:6d4:22e9:b8b5 with SMTP id
 6a1803df08f44-6d8b747b678mr164196576d6.46.1733408149655; 
 Thu, 05 Dec 2024 06:15:49 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dabfb6f1sm6787666d6.114.2024.12.05.06.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 06:15:49 -0800 (PST)
Date: Thu, 5 Dec 2024 08:15:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: "Maniyam, Dinesh" <dinesh.maniyam@intel.com>,
 U-Boot-Denx <u-boot@lists.denx.de>, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Johan Jonker <jbx6244@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Alexander Dahl <ada@thorsis.com>,
 William Zhang <william.zhang@broadcom.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 "Meng, Tingting" <tingting.meng@intel.com>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@intel.com>,
 "Ng, Boon Khai" <boon.khai.ng@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "Zamri, Muhammad Hazim Izzat" <muhammad.hazim.izzat.zamri@intel.com>,
 "Lim, Jit Loon" <jit.loon.lim@intel.com>,
 "Tang, Sieu Mun" <sieu.mun.tang@intel.com>
Subject: Re: [resend v2 14/19] configs: nand2_defconfig: Enable configs for
 nand boot
Message-ID: <20241205141544.GK2457179@bill-the-cat>
References: <20241205092315.25060-1-dinesh.maniyam@intel.com>
 <20241205092315.25060-15-dinesh.maniyam@intel.com>
 <BL1PR11MB53660F0C5BE89BE5CEE5FBA982302@BL1PR11MB5366.namprd11.prod.outlook.com>
 <CAOf5uwk102CGq243krXHOjLkSFwPq7RPH8wdWk5Arg5SEaGFtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EdhEym7QZ0RuKqYc"
Content-Disposition: inline
In-Reply-To: <CAOf5uwk102CGq243krXHOjLkSFwPq7RPH8wdWk5Arg5SEaGFtg@mail.gmail.com>
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


--EdhEym7QZ0RuKqYc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 10:41:17AM +0100, Michael Nazzareno Trimarchi wrote:
> Hi
>=20
> Il gio 5 dic 2024, 10:36 Maniyam, Dinesh <dinesh.maniyam@intel.com> ha
> scritto:
>=20
> >
> >
> > > -----Original Message-----
> > > From: Maniyam, Dinesh <dinesh.maniyam@intel.com>
> > > Sent: Thursday, 5 December 2024 5:23 pm
> > > To: u-boot@lists.denx.de
> > > Cc: Marek <marex@denx.de>; Simon <simon.k.r.goldschmidt@gmail.com>; T=
om
> > > Rini <trini@konsulko.com>; Dario Binacchi
> > > <dario.binacchi@amarulasolutions.com>; Michael Trimarchi
> > > <michael@amarulasolutions.com>; Johan Jonker <jbx6244@gmail.com>; Mic=
hal
> > > Simek <michal.simek@amd.com>; Arseniy Krasnov
> > > <avkrasnov@salutedevices.com>; Alexander Dahl <ada@thorsis.com>; Will=
iam
> > > Zhang <william.zhang@broadcom.com>; Igor Prusov
> > > <ivprusov@salutedevices.com>; Meng, Tingting <tingting.meng@intel.com=
>;
> > > Chee, Tien Fong <tien.fong.chee@intel.com>; Hea, Kok Kiang
> > > <kok.kiang.hea@intel.com>; Maniyam, Dinesh <dinesh.maniyam@intel.com>;
> > > Ng, Boon Khai <boon.khai.ng@intel.com>; Yuslaimi, Alif Zakuan
> > > <alif.zakuan.yuslaimi@intel.com>; Zamri, Muhammad Hazim Izzat
> > > <muhammad.hazim.izzat.zamri@intel.com>; Lim, Jit Loon
> > > <jit.loon.lim@intel.com>; Tang, Sieu Mun <sieu.mun.tang@intel.com>
> > > Subject: [resend v2 14/19] configs: nand2_defconfig: Enable configs f=
or
> > nand boot
> > >
> > > From: Dinesh Maniyam <dinesh.maniyam@intel.com>
> > >
> > > Enable configs for nand boot.
> > >
> > > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> > >
> > > ---
> > > v2:
> > > - remove the "this patch is to" commit phrases
> > > - using #include mechanism to keep track of the variant
> > > - add maintainer
> > > ---
> > > ---
> > >  board/intel/agilex5-socdk/MAINTAINERS   |  2 ++
> > >  configs/socfpga_agilex5_nand2_defconfig | 33 +++++++++++++++++++++++=
++
> > >  2 files changed, 35 insertions(+)
> > >  create mode 100644 configs/socfpga_agilex5_nand2_defconfig
> > >
> > > diff --git a/board/intel/agilex5-socdk/MAINTAINERS b/board/intel/agil=
ex5-
> > > socdk/MAINTAINERS
> > > index b696f788c8..30d8815d20 100644
> > > --- a/board/intel/agilex5-socdk/MAINTAINERS
> > > +++ b/board/intel/agilex5-socdk/MAINTAINERS
> > > @@ -2,7 +2,9 @@ SOCFPGA BOARD
> > >  M:   Tien Fong Chee <tien.fong.chee@intel.com>
> > >  M:   Teik Heng Chong <teik.heng.chong@intel.com>
> > >  M:   Jit Loon Lim <jit.loon.lim@intel.com>
> > > +M:   Dinesh Maniyam <dinesh.maniyam@intel.com>
> > >  S:   Maintained
> > >  F:   board/intel/agilex5-socdk/
> > >  F:   include/configs/socfpga_agilex5_socdk.h
> > >  F:   configs/socfpga_agilex5_defconfig
> > > +F:   configs/socfpga_agilex5_nand2_defconfig
> > > diff --git a/configs/socfpga_agilex5_nand2_defconfig
> > > b/configs/socfpga_agilex5_nand2_defconfig
> > > new file mode 100644
> > > index 0000000000..3bfe6270fd
> > > --- /dev/null
> > > +++ b/configs/socfpga_agilex5_nand2_defconfig
> > > @@ -0,0 +1,33 @@
> > > +#include <configs/socfpga_agilex5_defconfig>
> > > +
> > > +CONFIG_ARM=3Dy
> > > +CONFIG_ARCH_SOCFPGA=3Dy
> > > +CONFIG_DEFAULT_DEVICE_TREE=3D"socfpga_agilex5_socdk"
> > > +CONFIG_OF_UPSTREAM=3Dy
> > > +CONFIG_BOOTARGS=3D"earlycon panic=3D-1 root=3D${nandroot} rw rootwait
> > > rootfstype=3Dubifs ubi.mtd=3D1"
> > > +CONFIG_TARGET_SOCFPGA_AGILEX5_NAND2=3Dy
> > > +CONFIG_PHY_CADENCE_COMBOPHY=3Dn
> > > +CONFIG_SPL_PHY_CADENCE_COMBOPHY=3Dn
> > > +# CONFIG_MMC_DW is not set
> > > +CONFIG_SPL_MTD=3Dy
> > > +CONFIG_CMD_NAND_TRIMFFS=3Dy
> > > +CONFIG_CMD_NAND_LOCK_UNLOCK=3Dy
> > > +CONFIG_SPL_MTD_SUPPORT=3Dy
> > > +CONFIG_MTDIDS_DEFAULT=3D"nand0=3D10b80000.nand.0"
> > > +CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3D10b80000.nand.0:2m(u-boot),-
> > > (root)"
> > > +CONFIG_CMD_UBIFS=3Dy
> > > +CONFIG_MTD_UBI=3Dy
> > > +CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
> > > +CONFIG_MTD_UBI_BEB_LIMIT=3D20
> > > +CONFIG_SYS_NAND_U_BOOT_LOCATIONS=3Dy
> > > +CONFIG_SYS_NAND_U_BOOT_OFFS=3D0x0
> > > +CONFIG_SYS_NAND_U_BOOT_OFFS_REDUND=3D0x100000
> > > +CONFIG_UBI_SILENCE_MSG=3Dy
> > > +CONFIG_MTD_RAW_NAND=3Dy
> > > +CONFIG_NAND_CADENCE=3Dy
> > > +CONFIG_SPL_NAND_SUPPORT=3Dy
> > > +CONFIG_SPL_NAND_FRAMEWORK=3Dy
> > > +CONFIG_SPL_NAND_CADENCE=3Dy
> > > +CONFIG_SYS_NAND_ONFI_DETECTION=3Dy
> > > +CONFIG_SYS_NAND_BLOCK_SIZE=3D0x20000
> > > +CONFIG_SYS_NAND_PAGE_SIZE=3D0x800
> > > --
> > > 2.19.0
> >
> > Hi Michael,
> >
> > Please guide me through the process to run the CI in github.
> >
>=20
> I will do it for you and send some instructions today.
>=20
> Sorry for delay. I was busy ;)

To run CI in github we have
https://docs.u-boot.org/en/latest/develop/ci_testing.html and where
it's not clear enough please send patches to update
doc/develop/ci_testing.rst thanks!

--=20
Tom

--EdhEym7QZ0RuKqYc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdRtYkACgkQFHw5/5Y0
tyy68QwAlEouYEFIU/Mom9pzbtmAHgq0OxlybeB3KsINd1S/QLoDM4WRcsGFm4IP
T23c5TYIxARhZ7+AKJo6jduwYV/wfhgMp7DrKc632UJU0Rnvcrn5vPG1g74oAFkK
5mPBcL+SuxSO7NrACocbFTcbeq60v040Ykjy/+0pggDYi36Yr9YtTwSK7CJGeMW4
prthA10fNS+/20u2aTM+V1gDGMx/UlhfcsOvNR/fWK3oKwR6T7yGb12HWAWUmTG7
8DaRXh++/oTrpacPpy5UEO9xHSc8eANfUcdpGfIY+GXMFcf7OULuz0Wxb2E7P/xV
lxcR6Dymn8zrNTbFtPztFr/psjawmdsv9jI5XTvJhA/5VcXqQysAP5GsyU4OeH4S
2GJhY5m1T2de+hC4zzObleSQUiuCky8S8cgP+HTNIciD8yH2hYrWrFMzzcN3Xfxi
MPi8dB/UgnAbxWWfpljMLeo9Rq+NDQ+qUlEFavVBTazEfc0fmm+qqAdFEuj4It+n
8U1dQPey
=vtEb
-----END PGP SIGNATURE-----

--EdhEym7QZ0RuKqYc--
