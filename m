Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECEDD6D226
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 13:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EB3283D07;
	Thu, 18 Dec 2025 14:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="EKcv1F+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBAB583D8A; Thu, 18 Dec 2025 14:49:17 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 049C080325
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 14:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id CE176C1A5AF;
 Thu, 18 Dec 2025 13:48:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5A78F606B6;
 Thu, 18 Dec 2025 13:49:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 04EA7102F0B3B; Thu, 18 Dec 2025 14:49:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1766065752; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=WEYZIim9YL7BsiecXoVULNdpZLl+lTZNE/xWFd5wI20=;
 b=EKcv1F+zxWZq83LIKtC9j0DkoGHnU2GWvOjnuQmot5xnUzhFqXCAK3pIjj2IDDT4GlRX4s
 Ol2CTc5M/Ly9NdauFpCntNQ6AOuWafE7wTa1Xon/LDNDW2jKd0B0CqmJb4VSKpX00IXt5L
 ezXfHu8hYyBSqsGucdZH751KHusR2HRgM2MF2OS1e7GnKP3a3JGjZ6n6GKUzVE68l97/S9
 PVulP/4fEKeRmy+4fT4eLOz9ZfVnQhTnLkBJjjnLQoNWTQR1mcf+nIxR6dH3arD36DhyK+
 a8dXIQTyFODIXDd9aLgqemjt0d4h+mmrjugCHA4Q93mLBCvgtoS/j/+Lt0wplA==
Date: Thu, 18 Dec 2025 14:49:02 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Paul HENRYS
 <paul.henrys_ext@softathome.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Greg Malysa <malysagreg@gmail.com>, Arturs Artamonovs
 <arturs.artamonovs@analog.com>, Vasileios Bimpikas
 <vasileios.bimpikas@analog.com>, Utsav Agarwal <utsav.agarwal@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Peng Fan
 <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Duje =?UTF-8?B?TWloYW5vdmnEhw==?=
 <duje@dujemihanovic.xyz>, Stefan Roese <stefan.roese@mailbox.org>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Sumit Garg <sumit.garg@kernel.org>,
 Heiko Schocher <hs@nabladev.com>, Alif Zakuan Yuslaimi
 <alif.zakuan.yuslaimi@altera.com>, E Shattow <e@freeshell.de>, Raymond Mao
 <raymondmaoca@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang
 <yangshiji66@outlook.com>, Daniel Golle <daniel@makrotopia.org>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>, Yao Zi <ziyao@disroot.org>, Leonard
 Anderweit <l.anderweit@phytec.de>
Subject: Re: [PATCH v2 0/6] Add support for fwumdata
Message-ID: <20251218144902.62ca232b@kmaincent-XPS-13-7390>
In-Reply-To: <CAC_iWjLT1OJxADQ5bZaz_E7shWbGUJSnDQK7_dQM7agOKEvK0A@mail.gmail.com>
References: <20251212-feature_fwumdata-v2-0-ad51572fbe79@bootlin.com>
 <CAC_iWjLT1OJxADQ5bZaz_E7shWbGUJSnDQK7_dQM7agOKEvK0A@mail.gmail.com>
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

Hello Ilias,

On Thu, 18 Dec 2025 14:04:12 +0200
Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:

> Hi Kory,
>=20
> I haven't lost track of this, I'll try to have a look as soon as I can.
> For the record, I still don't think this is a great idea. I'd rather
> have people follow the design docs.

I don't get it. What are your arguments against this tool? It is a simple w=
ay
to change the content of the FWU metadata from Linux.

> I understand the acceptance capsule feels 'weird', but there was a
> good reason for it. There's a PR with an update to the spec, which
> makes the acceptance substantially easier now that all the ecosystem
> parts are in place [0[
>=20
> [0] https://github.com/ARM-software/edge-iot-arch-guide/pull/21

This design guideline is for one use case of FWU Metadata. It needs UEFI and
capsule update.

FWU Metadata is an update standard for ARM architecture, it is not dependen=
t on
the implementation. UEFI with capsule update is one implementation, but we =
could
have others.
https://documentation-service.arm.com/static/660be6391bc22b03bca92702

On my case (ST board) there is no UEFI, I have TF-A (FSBL) that reads the F=
WU
metadata to know the location of the FIP Image (SSBL which contain U-boot a=
nd
OPTEE).
During the OTA process, Linux is updating the FWU metadata to change the ac=
tive
bank and the bank state with this new fwumdata tool.

Note that the previous development of FWU support in U-boot as not been
developed in a generic way but bound to the UEFI capsule framework which is=
 not
ideal. On my case if I want to read FWU metadata in U-boot I have to enable=
 the
UEFI capsule config for nothing.

Regards,

>=20
> Cheers
> /Ilias
>=20
> On Fri, 12 Dec 2025 at 18:23, Kory Maincent <kory.maincent@bootlin.com> w=
rote:
> >
> > Add a new fwumdata tool to allows users to read, display, and modify FWU
> > (Firmware Update) metadata from Linux userspace. It provides functional=
ity
> > similar to fw_printenv/fw_setenv but for FWU metadata. Users can view
> > metadata, change active/previous bank indices, modify bank states, and =
set
> > image acceptance flags. Configuration is done via fwumdata.config file.
> >
> > Made a few change to mkfwumdata tool along the way.
> >
> > Here is an output example
> >
> > $ ./fwumdata -l
> > FWU Metadata:
> >         Version:            2
> >         Active Index:       0
> >         Previous Index:     1
> >         CRC32:              0x1f21ff7b
> >         Metadata Size:      120 bytes
> >         Descriptor Offset:  32
> >         Bank States:
> >                 Bank 0: accepted (0xfc)
> >                 Bank 1: accepted (0xfc)
> >
> >         Firmware Store Descriptor:
> >                 Number of Banks:       2
> >                 Number of Images:      1
> >                 Image Entry Size:      80
> >                 Bank Info Entry Size:  24
> >
> >         Images:
> >                 Image 0:
> >                         Image Type GUID:
> > 65ae85ad-1fb3-0b46-8c5d-285543aa6eab Location GUID:
> > 51513491-da07-2a4f-9bea-375ea53b1b5c Banks:
> >                                 Bank 0:
> >                                         Image GUID:
> > cb2df442-f929-6a44-a374-672d92eb2aa7 Accepted:    yes (1)
> >                                 Bank 1:
> >                                         Image GUID:
> > a839a18f-395c-484f-83b8-0354077c8f9f Accepted:    yes (1)
> >
> > Changes in v2:
> > - Fix a small offset mistake in last patch
> >
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> > Kory Maincent (6):
> >       tools: gitignore: Add mkfwumdata to the git ignore file
> >       tools: Reorganize mkfwumdata tool into fwumdata_src directory
> >       tools: mkfwumdata: Improve error message specificity
> >       tools: mkfwumdata: Add bank count validation for FWU metadata v2
> >       tools: Add support for fwumdata tool
> >       tools: mkfwumdata: Remove dependency on fwu_mdata.h header
> >
> >  MAINTAINERS                           |   7 +-
> >  doc/develop/uefi/fwu_updates.rst      |   4 +-
> >  doc/fwumdata.1                        | 222 +++++++++
> >  tools/.gitignore                      |   2 +
> >  tools/Kconfig                         |   9 +-
> >  tools/Makefile                        |   4 +-
> >  tools/fwumdata_src/Kconfig            |  19 +
> >  tools/fwumdata_src/fwumdata.c         | 854
> > ++++++++++++++++++++++++++++++++++ tools/fwumdata_src/fwumdata.config  =
  |
> > 33 ++ tools/fwumdata_src/fwumdata.h         | 138 ++++++
> >  tools/fwumdata_src/fwumdata.mk        |  10 +
> >  tools/{ =3D> fwumdata_src}/mkfwumdata.c | 106 ++---
> >  12 files changed, 1315 insertions(+), 93 deletions(-)
> > ---
> > base-commit: 31bf4a1c308773895a8e7ea047b3cea037e4c922
> > change-id: 20251107-feature_fwumdata-58508d61e1d3
> >
> > Best regards,
> > --
> > K=C3=B6ry Maincent, Bootlin
> > Embedded Linux and kernel engineering
> > https://bootlin.com
> > =20



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
