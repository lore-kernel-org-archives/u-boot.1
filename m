Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97290E9A03B
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 10:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEA0983B99;
	Wed, 18 Feb 2026 11:37:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pVy0yS/U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BB3F83CE3; Wed, 18 Feb 2026 11:37:09 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F197B83C67
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 11:37:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 2E8794E40F58;
 Wed, 18 Feb 2026 10:37:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0423F60738;
 Wed, 18 Feb 2026 10:37:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 83D1410368B5B; Wed, 18 Feb 2026 11:36:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1771411024; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=zlMCgf4VSnPszNCnaBXebC7ywETYq4MURzK9512M96A=;
 b=pVy0yS/U7NEjAykatW1+0NtDq04a1mmvxXUgds2c55dZqEE684XVDqOsvG62oZvVlwEyQN
 K45G1y2QL+x/N7sjDrQ6XWuFC1oqAYIcWJwTmNJhie9tsEhDbni73FkBjS9lnnRHGiqv50
 Hs/wY73eKyrPc7bjUVhrUxA7RHt3LI2psZdNRYlA00LxnJ5RKNi8REOqIKwyJUsCkW84xh
 FTm2shrQiBOqBDsFWhjj53eKuC+85fG079YIMK29zcz7vWysTyZ4wQR9aQlbCiKHLC5GFU
 i9s2zybFTLDPhfmToPNWbalDW03r2L+m6OfX75+HqWBD7h4Hyt/ljsKrS7AwNQ==
Date: Wed, 18 Feb 2026 11:36:57 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Sughosh Ganu <sughosh.ganu@arm.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Paul HENRYS
 <paul.henrys_ext@softathome.com>, Greg Malysa <malysagreg@gmail.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>, Vasileios Bimpikas
 <vasileios.bimpikas@analog.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Peng Fan
 <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, Duje =?UTF-8?B?TWlo?=
 =?UTF-8?B?YW5vdmnEhw==?= <duje@dujemihanovic.xyz>, Stefan Roese
 <stefan.roese@mailbox.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, Alif
 Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, E Shattow
 <e@freeshell.de>, Raymond Mao <raymondmaoca@gmail.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>, Daniel
 Golle <daniel@makrotopia.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Leonard Anderweit
 <l.anderweit@phytec.de>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v3 5/6] tools: Add support for fwumdata tool
Message-ID: <20260218113657.38d374c6@kmaincent-XPS-13-7390>
In-Reply-To: <aZWMA6Oh0dPtQmUP@a079122.arm.com>
References: <20260216-feature_fwumdata-v3-0-9ecc5b10456d@bootlin.com>
 <20260216-feature_fwumdata-v3-5-9ecc5b10456d@bootlin.com>
 <aZWMA6Oh0dPtQmUP@a079122.arm.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

On Wed, 18 Feb 2026 15:23:07 +0530
Sughosh Ganu <sughosh.ganu@arm.com> wrote:

> On Mon, Feb 16, 2026 at 02:35:35PM +0100, Kory Maincent wrote:
> > Add a new fwumdata tool to allows users to read, display, and modify FWU
> > (Firmware Update) metadata from Linux userspace. It provides functional=
ity
> > similar to fw_printenv/fw_setenv but for FWU metadata. Users can view
> > metadata, change active/previous bank indices, modify bank states, and =
set
> > image acceptance flags. Configuration is done via fwumdata.config file.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >  MAINTAINERS                        |   4 +
> >  doc/develop/uefi/fwu_updates.rst   |   4 +-
> >  doc/fwumdata.1                     | 222 ++++++++++
> >  tools/.gitignore                   |   1 +
> >  tools/fwumdata_src/Kconfig         |  11 +
> >  tools/fwumdata_src/fwumdata.c      | 854
> > +++++++++++++++++++++++++++++++++++++ tools/fwumdata_src/fwumdata.confi=
g |
> > 33 ++ tools/fwumdata_src/fwumdata.h      | 138 ++++++
> >  tools/fwumdata_src/fwumdata.mk     |   5 +-
> >  9 files changed, 1270 insertions(+), 2 deletions(-)
> >  =20
>=20
> <snip>
>=20
> > diff --git a/tools/fwumdata_src/fwumdata.mk b/tools/fwumdata_src/fwumda=
ta.mk
> > index 00f4ae50dbb..2199e43b372 100644
> > --- a/tools/fwumdata_src/fwumdata.mk
> > +++ b/tools/fwumdata_src/fwumdata.mk
> > @@ -4,4 +4,7 @@
> > =20
> >  mkfwumdata-objs :=3D fwumdata_src/mkfwumdata.o generated/lib/crc32.o
> >  HOSTLDLIBS_mkfwumdata +=3D -luuid
> > -hostprogs-always-$(CONFIG_TOOLS_MKFWUMDATA) +=3D mkfwumdata
> > +hostprogs-$(CONFIG_TOOLS_MKFWUMDATA) +=3D mkfwumdata =20
>=20
> This is correct the first way around.
>=20
> > +
> > +fwumdata-objs :=3D fwumdata_src/fwumdata.o generated/lib/crc32.o
> > +hostprogs-$(CONFIG_TOOLS_FWUMDATA) +=3D fwumdata =20
>=20
> This needs to be hostprogs-always-$(...)

Oh thanks spotting this, I don't know how I lost the always suffix.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
