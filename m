Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEA7FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B34F68453A;
	Sat, 25 Apr 2026 20:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OmmhN9xv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59D07843D1; Sat, 25 Apr 2026 19:37:55 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA4B84399
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-8acb3daf2aaso140412196d6.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777138671; x=1777743471; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P9CHYLfQyMa7nodfgNj6jna+L4NAbT2JE5+9O8UhF9o=;
 b=OmmhN9xvxBq65r3C3c552gj2pRC86jGG91seb1mraEN2ujL6uWcoPFUyHnVLVv1K+9
 hkWeeUjOh5Y8x/Ty61WJ9DfRtRB1vzoVolp1TAQ2xYJ/Q2lplD7i5MD6D5kQxBOp6Xb9
 072B1l29dfnQvPWlRidtqTdmytyGVktZqvpj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777138671; x=1777743471;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P9CHYLfQyMa7nodfgNj6jna+L4NAbT2JE5+9O8UhF9o=;
 b=UwLKW3DdywbCYKujH3adxrsrFaePwy4waBIjSfMjBKMWOz7ceQ3AgBhIrHB0+wpviY
 bJxXajuVBXAIjG8EmJ51KXqDdEfyEXyQ/xfc5QYqTsjnJSWRyxrmQABeJ4zRjVy1U3Qo
 HldITJbo5vQ8xrNqOUl/Ffiy7J4unA5FsIFBeEmlq5MmfU+Yt6CQ+USTfIQlEw2vz714
 Y2XgxWO9dACGtbyZbdXz1ZYaM5mHNfxVAVBIra+R4TPbXquozzf9QGCBFKw2sKprHKlP
 aqJ0bJ2oq3pqvjmRF9zDJBjqukNTEadLtBhCCUPJe1OJygCw0lQ57K3+YQ5qgFKQ+L9t
 umkw==
X-Gm-Message-State: AOJu0Yx06pTlrcqYfAxzZJe0F5+gH3IhG58MvNWSGsL9KvcSSHQi3phC
 a+ZV2zl59MV1hYquxvqr1ap7lfcojIAQP7BgEuXpL0XSlfdUPT/3AOM/FGScJ4toRFNCNY2XGgt
 NcY6F
X-Gm-Gg: AeBDieuC0DSxOVPzYqwX93j6WhNj+BPVyskC+Se9jNOpJ5oGGsaHaxvRzMj/l6WWpuk
 wrpaRNsUSROt8CBlMwY86tRuV0j37+kCxNU0B38TNApBIEBPAhELFS8CQ6CbbCHe0PH9+aOSlET
 9rv1bm9CIgY7Gd99NegswCPDij7sr6XEYxh4GmU+1WWU9Gl0tYhWC/2RcHsEEFrXSFbK3lRSkoS
 t4PRvdIH78AwLhpXCNseRPaUv5G86wOi07uZ0F92HRjkHK1vF0GBIcBZ/yAhdKsNHLS0yupRdYk
 DNnOgHvPbgFSkXFbTUMhKW+64nrDzLPoIn5vA8FQW1+qsaruvlr/H+jY17rTtmJC2kcktvA5qZz
 2ObyFe3SW3AtlECo+hb6P2I1PXVnVOzcW2giq7kb0SdrWGHz60CJpMOqcGKk4FiNIjUBD5p7Hgr
 Nnkf6UT8gYoUdNPaFYGL2BjPdhQp5t09neTKk8N+qJKAGeZrpfIE//5sKxKyibZmLg1G8juuoti
 w3j2qII6kOIQrc05ClqTC7IpTRhpgQED9av9HMIWYYnxDb1qT4nCWsZoKaJYQ==
X-Received: by 2002:a05:6870:e091:b0:41c:880:f9b7 with SMTP id
 586e51a60fabf-42abf2238b1mr21003070fac.7.1777072513860; 
 Fri, 24 Apr 2026 16:15:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42fae7ee3a5sm11782846fac.7.2026.04.24.16.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 16:15:12 -0700 (PDT)
Date: Fri, 24 Apr 2026 17:15:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Srba <Michael.Srba@seznam.cz>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alice Guo <alice.guo@nxp.com>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v3 03/11] drivers: allow clk_stub and spmi in SPL
Message-ID: <20260424231508.GL41863@bill-the-cat>
References: <20260421-qcom_spl-v3-0-efee3f76754d@seznam.cz>
 <20260421-qcom_spl-v3-3-efee3f76754d@seznam.cz>
 <20260421204651.GB41863@bill-the-cat>
 <5958da60-b8b1-40bb-bc66-5589a3d5ba7f@seznam.cz>
 <20260421211041.GC41863@bill-the-cat>
 <74bdca54-0780-4715-8c31-33019f2fe262@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3k0Eq+LeUI16yQTa"
Content-Disposition: inline
In-Reply-To: <74bdca54-0780-4715-8c31-33019f2fe262@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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


--3k0Eq+LeUI16yQTa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 12:46:03AM +0200, Michael Srba wrote:
> Hi,
>=20
> On 4/21/26 23:10, Tom Rini wrote:
> > On Tue, Apr 21, 2026 at 11:05:58PM +0200, Michael Srba wrote:
> > > Hi,
> > >=20
> > > On 4/21/26 22:46, Tom Rini wrote:
> > > > On Tue, Apr 21, 2026 at 09:43:46PM +0200, michael.srba@seznam.cz wr=
ote:
> > > >=20
> > > > > From: Michael Srba <Michael.Srba@seznam.cz>
> > > > >=20
> > > > > Only Makefile and Kconfig changes necessary.
> > > > >=20
> > > > > Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> > > > > ---
> > > > >    drivers/Makefile      |  2 +-
> > > > >    drivers/clk/Kconfig   |  7 +++++++
> > > > >    drivers/spmi/Kconfig  | 13 +++++++++++++
> > > > >    drivers/spmi/Makefile |  4 ++--
> > > > >    4 files changed, 23 insertions(+), 3 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/Makefile b/drivers/Makefile
> > > > > index 43d0ba33281..477718ce89a 100644
> > > > > --- a/drivers/Makefile
> > > > > +++ b/drivers/Makefile
> > > > > @@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)RAM) +=3D ram/
> > > > >    obj-$(CONFIG_$(PHASE_)RTC) +=3D rtc/
> > > > >    obj-$(CONFIG_$(PHASE_)SERIAL) +=3D serial/
> > > > >    obj-$(CONFIG_$(PHASE_)SPI) +=3D spi/
> > > > > +obj-$(CONFIG_$(PHASE_)SPMI) +=3D spmi/
> > > > >    obj-$(CONFIG_$(PHASE_)TIMER) +=3D timer/
> > > > >    obj-$(CONFIG_$(PHASE_)VIRTIO) +=3D virtio/
> > > > >    obj-$(CONFIG_$(PHASE_)DM_MAILBOX) +=3D mailbox/
> > > > > @@ -106,7 +107,6 @@ obj-$(CONFIG_DM_REBOOT_MODE) +=3D reboot-mode/
> > > > >    obj-y +=3D rtc/
> > > > >    obj-y +=3D scsi/
> > > > >    obj-y +=3D sound/
> > > > > -obj-y +=3D spmi/
> > > > >    obj-y +=3D watchdog/
> > > > >    obj-$(CONFIG_QE) +=3D qe/
> > > > >    obj-$(CONFIG_U_QE) +=3D qe/
> > > > Code-wise this is fine. But this reminds me, did you run this whole
> > > > series through CI? Thanks.
> > > I tried, but on gitlab.org it just didn't work at all, and locally it=
 only ran partially
> > > before running out of disk space. I tried making an account
> > > on https://source.denx.de but the anti-spam measure is blocking me
> > > and I'm waiting to see if that gets resolved (since it's not clear to=
 me if
> > > the unblocking is supposed to be automatic or not, and if it's manual
> > > then just waiting is probably all I need to do) (fwiw not sure if that
> > > instance allows random users to run the CI, the docs don't really
> > > say *where* I'm supposed to run it, but I figured it was worth a try)
> > The thing with source.denx.de is that then you also need (manually) a
> > contributor tree, for CI (and user accounts are more for bug filing). We
> > have how to run CI via Azure documented here:
> > https://docs.u-boot.org/en/latest/develop/ci_testing.html
> >=20
> > And my concern is changing "always traverse this directory" to "traverse
> > once CONFIG_SPMI is set" shouldn't cause a problem. But sometimes
> > there's platforms with unexpected (and invalid needing to be fixed)
> > configurations out there.
> >=20
> I figured out the github workflow, quite straightforward in the end. Ther=
e is only
> one failing check, missing MAINTAINERS entry for the defconfig. Should I =
add
> an entry in the same commit and put it under `u-boot-qcom@groups.io`?

If that's who is going to maintain it, yes, thanks :)

--=20
Tom

--3k0Eq+LeUI16yQTa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaev5eAAKCRAr4qD1Cr/k
CslEAQDaPMpFVLOr+obPRPVRiuymdbN0zDHE8ojjhuGSA+Nn7QD/Qlt1/toU8nzT
F9FlcjcJ9iNehN1z5esBBKGGZEtqWgU=
=+YDS
-----END PGP SIGNATURE-----

--3k0Eq+LeUI16yQTa--
