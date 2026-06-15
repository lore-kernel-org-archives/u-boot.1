Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F00CD98DE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 23:14:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE40684869;
	Tue, 16 Jun 2026 01:14:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A7ucdtbS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFAD1846B0; Mon, 15 Jun 2026 18:30:13 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD17184105
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 18:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-440ebc72386so1830757fac.3
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 09:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781541010; x=1782145810; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HlHp5UQTxskIUmXtguXFGXXBsJsDBHJcC1fRwWZt/6Y=;
 b=A7ucdtbSNqvMpYJSC5avhR6xBuN2HcYdcl7SuF4GtLdK5ON2UXwHN/BXB/tQmZZLa6
 MNaRuXdQfab9mmhEUm5wWCUSzO6/Pv5uKTZPHVZ2Q5bPVRpgVFaB78mZ4higWqB0C6dl
 us1xs9BWV16v8oTv5dLN7v0RHPRaK8cEo/Qa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781541010; x=1782145810;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HlHp5UQTxskIUmXtguXFGXXBsJsDBHJcC1fRwWZt/6Y=;
 b=qQVyO/mXEIZOnP1QLabgIQ0uzG90K0KCAs+MYd5rQtv8gJ8w0LqYX2F7lOJL/c/aJ/
 20M0O7Fprk+IQieIlTCdFvLrfGTzLjirbqA61tFZIG+dd2oMDwwl0gTpv1SVm6zpzGvZ
 l7Er/6n9vbW3tuKenpVeMJSxqeNy0kbl7PWNGiyagR7+gOr9GuagdQqQqfxEMNQYpRPe
 RLURpGuZ8+QD7L6skmiQt0BQT4vSJs9sVBGhBbXcYVNInJ1iWnzuBkvV/KA6qNiyQOT/
 +PsyFA/mnNe9LxsCAAjQMld50iK9IbwwpTFt5Tbmy0e+TaeoJ7mwE19g+ayldUHIiYsC
 tz2Q==
X-Gm-Message-State: AOJu0YzcNVnJSrm56YgM18lsQOvMZLi5ab6rKBVP8wHeYo0jv/3dzSpg
 UtsaG6glSvI4X2NZ/SUDggoqDNLR9ury1zHrtqHG8xPgGMX6AdczJ3BVTBOkWNlLg4E=
X-Gm-Gg: Acq92OG99+L6QXiXYjfJJ9OpO02CoU5nhyWRJvuIq+xkbxd9fZLr0mdoCnWGHEUT+H/
 1KzNEuaEp5kIbARp1Omj6jfSKmtg4qVrfMJJEV/IOd64sIOK/rot4AGhMjTXese6A2UTRvTif/O
 f2aQqA4wRyI8CSmPQfvDTZFgC+/FNU2T994ipb7FoazfF0/kaXzAO3rMwly1Xb/HkAZj7MtAgrA
 L4+gFu3PoeIKvHbHoo0HwpP4OXpHIRxYnK+Oqhlzp59N5M9wBkCw76OVGbAaWTcznGLZfufYs2u
 yfynzFH2h9RqCqCr1ddJKXfSkx0bQlM0pZIi1Mkb7yNehhYCu6WW0OUS/eCallQ7+GnRcJm1GLV
 BPISufHbFvfX7vMT5egpc/TNydgAw5GzIico0o4qJMh3UChEC7lTU68Zb7Kh+ryuLVN+QNLnJs5
 HCYNSccn+f6z5afAo0R3AYsXlePtu7pYhesYoq4Fd1RP3HqoSbAnnrpjafKij3BKnaS/yLJn6W5
 xHhhesx0WZ0hL72DkRWiXGx/g/TTHwZRLVloXWmNLtm1Utvy10=
X-Received: by 2002:a05:6871:c706:b0:442:175:cea9 with SMTP id
 586e51a60fabf-4430b2d14bdmr56859fac.7.1781541010353; 
 Mon, 15 Jun 2026 09:30:10 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44308f190c9sm198092fac.11.2026.06.15.09.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 09:30:09 -0700 (PDT)
Date: Mon, 15 Jun 2026 10:30:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alexey Charkov <alchark@flipper.net>, Andrew Davis <afd@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Dhruva Gole <d-gole@ti.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Michal Simek <michal.simek@amd.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 David Wronek <david.wronek@mainlining.org>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Yao Zi <me@ziyao.cc>,
 Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v3 01/14] spl: ufs: rename SPL_UFS_SUPPORT config to
 SPL_UFS
Message-ID: <20260615163005.GZ382693@bill-the-cat>
References: <20260615-spl_ufs-v3-0-360bceb29596@oss.qualcomm.com>
 <20260615-spl_ufs-v3-1-360bceb29596@oss.qualcomm.com>
 <20260615162247.GY382693@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HADHBNMOo6fuCeTx"
Content-Disposition: inline
In-Reply-To: <20260615162247.GY382693@bill-the-cat>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Tue, 16 Jun 2026 01:14:20 +0200
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


--HADHBNMOo6fuCeTx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 10:22:47AM -0600, Tom Rini wrote:
> On Mon, Jun 15, 2026 at 12:29:57PM +0530, Balaji Selvanathan wrote:
>=20
> > Rename the Kconfig symbol SPL_UFS_SUPPORT to SPL_UFS to align with
> > the naming convention used by other SPL storage drivers (e.g.,
> > SPL_SATA, SPL_MMC). This shorter name also works cleanly with the
> > $(PHASE_) prefix macro in Makefiles, allowing uniform use of
> > CONFIG_$(PHASE_)UFS across SPL and TPL build rules.
> >=20
> > Remove the unnecessary `depends on UFS` from SPL_UFS. This dependency
> > is not needed because SPL_UFS is a build-time option that can be
> > independently controlled.
>=20
> The problem is that in drivers/ufs/Makefile we have:
> obj-$(CONFIG_UFS) +=3D ufs-uclass.o
>=20
> So we only get the uclass with CONFIG_UFS=3Dy. Can you build a boot a
> CONFIG_UFS=3Dy CONFIG_SPL_UFS=3Dy target with your series? I expect there=
's
> problems.
>=20
> [snip]
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 43d0ba33281..86a54b5f332 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -73,7 +73,7 @@ obj-$(CONFIG_SPL_USB_HOST) +=3D usb/host/
> >  obj-$(CONFIG_SPL_SATA) +=3D ata/ scsi/
> >  obj-$(CONFIG_SPL_LEGACY_BLOCK) +=3D block/
> >  obj-$(CONFIG_SPL_THERMAL) +=3D thermal/
> > -obj-$(CONFIG_SPL_UFS_SUPPORT) +=3D scsi/ ufs/
> > +obj-$(CONFIG_SPL_UFS) +=3D scsi/ ufs/
> > =20
> >  endif
> >  endif
>=20
> This isn't great, and I'd like to see the relevant part of the Makefile
> itself cleaned up to be:
> obj-$(CONFIG_$(PHASE_)UFS)) +=3D scsi/ ufs/
> (and so drop the unconditional obj-y +=3D ufs).
>=20
> I don't see anyone upstream yet enabling SPL_UFS_SUPPORT so there's
> likely some more general Kconfig updates / additions needed here.

=2E.. and here's me being a tiny bit unhappy about new platforms ending up
in the master branch, post the next branch branch-point. That said, they
of course both set CONFIG_UFS and CONFIG_SPL_UFS_SUPPORT today, so my
general comments still apply.

--=20
Tom

--HADHBNMOo6fuCeTx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajAojAAKCRAr4qD1Cr/k
CljvAP9n5wr89kqeJ+Il7ykLhinYaNw5qv+fBSoDxKt5K+6NrwD+KjamnGHVjqEG
b/3itgSR3upvvSNFBKG772AeGabb8Qk=
=irY4
-----END PGP SIGNATURE-----

--HADHBNMOo6fuCeTx--
