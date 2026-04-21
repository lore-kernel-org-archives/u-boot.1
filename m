Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A55F94CA7
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 21:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6635F84348;
	Tue, 21 Apr 2026 23:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uTQfWssW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED35384348; Tue, 21 Apr 2026 23:10:49 +0200 (CEST)
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com
 [IPv6:2001:4860:4864:20::42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4965A842FC
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 23:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x42.google.com with SMTP id
 586e51a60fabf-40423dbe98bso1966431fac.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 14:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776805846; x=1777410646; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eUvw+zfPazrtwfR5e2f6A6yFJoZi1W0sLAi88OMtND4=;
 b=uTQfWssWJ3LCqcCt1JFGUMZw7/z92jHbxJXiMc4+eASDpg8toG+98BNOPbEo7Da+Ns
 bLl6RUtZU1gxByjYDic1y0+fD6CdSlJT7DIa5KhSRM4eqrk+chr79b1EGt7Hhz/Iq6gx
 /j8NL81KjEeGmO/tsm6t1s8xIwwqMzILM3VWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776805846; x=1777410646;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUvw+zfPazrtwfR5e2f6A6yFJoZi1W0sLAi88OMtND4=;
 b=OE7MLqGFcPiz7ZSv9SzOEUaKaQlhH8G0IvPfm+CQ4WEaVRnrGd8u0INZi3mKJ96MmT
 fimfhSL+f3k/TRpSAnRPjYCWU6NdO9C5uc+sFaBz9Lt0XjMQfCwcReiMLfGO1rTETNB4
 iLQGi7YgRs6jb0HbqgxkbH2MwVV2L4PIIYFzZk2CTu7J5PhswmgsrNfE3HYt4ZplTdJK
 k9V3mrjK12+MUr0Z2Q/RiPJZQLDg8MTOpjhIgieiuFI1VdWW9z/ZK/c0KQSgryB3p4dR
 Q1zWdm7rRo2wb6LNErZDp7sM3YvMUXoMMkwxuHi1qqX7nnyEYlQHe6HtlfKGQh115hyk
 8UZQ==
X-Gm-Message-State: AOJu0Yy4gFh1hlR94CMCKH/HmiwoSas0BNVhn1jiDcC3ztjBXSm5j20p
 78/kelN4Kte5Um8vfjg95fyf0yPK+Xs8npDazpSGl8BeWhZr0UeQ60Hb/XEC0gjv7FMmiwQayBR
 CMFC59ZLUc6lxMHY=
X-Gm-Gg: AeBDieseaAFHm60dbkqVvKG+OYPn54qAWS6npYyPyN21hJLwG+xtvUBi3LU1jrgkwIC
 OTYDrHlL4ebUme7qYs4GPplltWO7DkmKj4zJyEn809KDxHoSkQXGM6vdabjvkGmaH47BaghlQAu
 0fvoBoWf1+Q9mqYFAKepBKe32s86QivzT7/5LSaQybW63p0dxA2AcCiXLlKtuPnazwyKepHj1Uy
 6WxiTcI65jRpXbHDC34j2s4h9/gEM8EBOidC+Pk25/2ulVg4Ycn+nIAqZZS30pCtC01qUjDq07l
 K5lly+2HOvWxI3UYoe8ToWKNcbv+vtZxI7xu38KP6XwV7lHU1ezH2zyt/mgsRDV3gVL1uWkLJZO
 TrSGskZTjUoFX/dF/KDAJ/0ogxd1Ac2BWlMnR1ARn1/RBJV+W6rBBIjFFkng7JEBEM8nTDOmlgB
 PIZ+YV3RUHhduOt4XPr4ruDB8m0qn7rylDphs7mkT+w880e1hScwsexBSwTL/MOrRCgx99Ggbqr
 O84MtIZAv6XDYJ+OFvMnJ7dZjzUD/QF0cU7bUauhF8SFDKdyUhaPWDFAyLM90Uw1KooVPw9
X-Received: by 2002:a05:6870:8896:b0:42f:ba47:36f5 with SMTP id
 586e51a60fabf-42fba47ba89mr1147587fac.17.1776805845895; 
 Tue, 21 Apr 2026 14:10:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42bebc9cb33sm8519485fac.11.2026.04.21.14.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 14:10:45 -0700 (PDT)
Date: Tue, 21 Apr 2026 15:10:41 -0600
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
Message-ID: <20260421211041.GC41863@bill-the-cat>
References: <20260421-qcom_spl-v3-0-efee3f76754d@seznam.cz>
 <20260421-qcom_spl-v3-3-efee3f76754d@seznam.cz>
 <20260421204651.GB41863@bill-the-cat>
 <5958da60-b8b1-40bb-bc66-5589a3d5ba7f@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nt4vpleO8zan6CxY"
Content-Disposition: inline
In-Reply-To: <5958da60-b8b1-40bb-bc66-5589a3d5ba7f@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 21 Apr 2026 23:12:41 +0200
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


--nt4vpleO8zan6CxY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 11:05:58PM +0200, Michael Srba wrote:
> Hi,
>=20
> On 4/21/26 22:46, Tom Rini wrote:
> > On Tue, Apr 21, 2026 at 09:43:46PM +0200, michael.srba@seznam.cz wrote:
> >=20
> > > From: Michael Srba <Michael.Srba@seznam.cz>
> > >=20
> > > Only Makefile and Kconfig changes necessary.
> > >=20
> > > Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> > > ---
> > >   drivers/Makefile      |  2 +-
> > >   drivers/clk/Kconfig   |  7 +++++++
> > >   drivers/spmi/Kconfig  | 13 +++++++++++++
> > >   drivers/spmi/Makefile |  4 ++--
> > >   4 files changed, 23 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/drivers/Makefile b/drivers/Makefile
> > > index 43d0ba33281..477718ce89a 100644
> > > --- a/drivers/Makefile
> > > +++ b/drivers/Makefile
> > > @@ -35,6 +35,7 @@ obj-$(CONFIG_$(PHASE_)RAM) +=3D ram/
> > >   obj-$(CONFIG_$(PHASE_)RTC) +=3D rtc/
> > >   obj-$(CONFIG_$(PHASE_)SERIAL) +=3D serial/
> > >   obj-$(CONFIG_$(PHASE_)SPI) +=3D spi/
> > > +obj-$(CONFIG_$(PHASE_)SPMI) +=3D spmi/
> > >   obj-$(CONFIG_$(PHASE_)TIMER) +=3D timer/
> > >   obj-$(CONFIG_$(PHASE_)VIRTIO) +=3D virtio/
> > >   obj-$(CONFIG_$(PHASE_)DM_MAILBOX) +=3D mailbox/
> > > @@ -106,7 +107,6 @@ obj-$(CONFIG_DM_REBOOT_MODE) +=3D reboot-mode/
> > >   obj-y +=3D rtc/
> > >   obj-y +=3D scsi/
> > >   obj-y +=3D sound/
> > > -obj-y +=3D spmi/
> > >   obj-y +=3D watchdog/
> > >   obj-$(CONFIG_QE) +=3D qe/
> > >   obj-$(CONFIG_U_QE) +=3D qe/
> > Code-wise this is fine. But this reminds me, did you run this whole
> > series through CI? Thanks.
> I tried, but on gitlab.org it just didn't work at all, and locally it onl=
y ran partially
> before running out of disk space. I tried making an account
> on https://source.denx.de but the anti-spam measure is blocking me
> and I'm waiting to see if that gets resolved (since it's not clear to me =
if
> the unblocking is supposed to be automatic or not, and if it's manual
> then just waiting is probably all I need to do) (fwiw not sure if that
> instance allows random users to run the CI, the docs don't really
> say *where* I'm supposed to run it, but I figured it was worth a try)

The thing with source.denx.de is that then you also need (manually) a
contributor tree, for CI (and user accounts are more for bug filing). We
have how to run CI via Azure documented here:
https://docs.u-boot.org/en/latest/develop/ci_testing.html

And my concern is changing "always traverse this directory" to "traverse
once CONFIG_SPMI is set" shouldn't cause a problem. But sometimes
there's platforms with unexpected (and invalid needing to be fixed)
configurations out there.

--=20
Tom

--nt4vpleO8zan6CxY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaefn0AAKCRAr4qD1Cr/k
ClImAQCWBtHM8XcHUvZywKb1AcKMVRMOJJqB1bGSgmD9wpMWQwD9FR4nwL4DZX+u
GpiwKDh3pvH8roRlqfg95B8Vdca6ggU=
=yAw0
-----END PGP SIGNATURE-----

--nt4vpleO8zan6CxY--
