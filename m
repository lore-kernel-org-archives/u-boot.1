Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE179E9A03B
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 10:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2106683B99;
	Wed, 18 Feb 2026 11:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="D9x44BfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E134983C19; Wed, 18 Feb 2026 11:31:35 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18D5083AA9
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 11:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 9466C4E40F59;
 Wed, 18 Feb 2026 10:31:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5B4FF60738;
 Wed, 18 Feb 2026 10:31:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0F74010368B52; Wed, 18 Feb 2026 11:31:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1771410691; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=f+/SAUBeJcDce6yjMyi/fsYXAU4IYwXidgfvc+5Demw=;
 b=D9x44BfNYEQOZWa2zXybA6bKqaj00+FvF4/Tht17rmDAJOmNYegOFU+yOWFAX+hS+xlYUM
 a12VgEvE8suMXJHUriEn9msnrwVugL8oET8PDcBvx3W2fUV4cbKcqirDblLsE82N9SRgIY
 /4s3whaxXno2rX2sPGSeqtVY9W3u3x6jrgTn0XPM/NeHsX+tf9PEaAQhnO7XC4YI2lnER0
 4i7fKnuenRfhARGfsE8PT5QWp0Z36nzRG5O6Uzw+xUXjfhrT5qDTZU3i31fTqu2bDFV4Mh
 ZhjQmvtEQSc0Ilehwi6CRlSA/ZtrzJnOCOXgK9VFxXForQKjfIHE0fT9LFxhjA==
Date: Wed, 18 Feb 2026 11:31:16 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Sughosh Ganu <sughosh.ganu@arm.com>
Cc: u-boot@lists.denx.de, jose.marinho@arm.com, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Paul HENRYS
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
Message-ID: <20260218113116.3c447668@kmaincent-XPS-13-7390>
In-Reply-To: <aZWM0_v4eUgKLTSz@a079122.arm.com>
References: <20260216-feature_fwumdata-v3-0-9ecc5b10456d@bootlin.com>
 <20260216-feature_fwumdata-v3-5-9ecc5b10456d@bootlin.com>
 <aZWKyl6r8BphaePp@a079122.arm.com>
 <aZWM0_v4eUgKLTSz@a079122.arm.com>
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

Hello Sughosh,

On Wed, 18 Feb 2026 15:26:35 +0530
Sughosh Ganu <sughosh.ganu@arm.com> wrote:

> On Wed, Feb 18, 2026 at 03:17:58PM +0530, Sughosh Ganu wrote:
> > On Mon, Feb 16, 2026 at 02:35:35PM +0100, Kory Maincent wrote: =20
> > > Add a new fwumdata tool to allows users to read, display, and modify =
FWU
> > > (Firmware Update) metadata from Linux userspace. It provides function=
ality
> > > similar to fw_printenv/fw_setenv but for FWU metadata. Users can view
> > > metadata, change active/previous bank indices, modify bank states, an=
d set
> > > image acceptance flags. Configuration is done via fwumdata.config fil=
e.
> > >=20
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > --- =20
> >=20
> > I am not sure if this has been discussed with Ilias earlier, and
> > apologies if it has been, but I do think that this patch is not
> > adhering to the DEN0118 specification, specifically the part mentioned
> > in section A3.2.1, which says that the metadata is to be maintained by
> > the Update Agent. I would like to hear from Jose Marinho, who is the
> > author of the spec, on what he thinks about this approach.
> >=20
> > I do think that the other patches in series look fine, and can be
> > applied. There is just an issue of inclusion of the tool for
> > building. I will comment on that patch separately. =20
>=20
>=20
> Adding Jose to the discussion.

We indeed already had some discussion about it with Ilias.=20
https://lists.denx.de/pipermail/u-boot/2025-December/605924.html

It seems ST deviate from the original idea behind the standard. It does not=
 use
EFI neither update capsule.
TF-A is managing the selection of the boot partition (FIP image: OPTEE +
bootloader) according to the FWU metadata content and is dealingwith the
rollback mechanism. Linux through this tools is the update agent to select =
the
boot image.
The final goal is to have RAUC updating the boot A/B partition and switchin=
g to
it calling this new tool.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
