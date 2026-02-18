Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1F0E9A03B
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 11:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12DFA83AA9;
	Wed, 18 Feb 2026 12:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="VDscERmp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66C4583B99; Wed, 18 Feb 2026 12:08:32 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16F7F83936
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 12:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 9B08C4E40F5F;
 Wed, 18 Feb 2026 11:08:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6AD9960738;
 Wed, 18 Feb 2026 11:08:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AB8BF10368B61; Wed, 18 Feb 2026 12:08:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1771412908; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=eVVaD0k/ezUb0avN6LIBUIRvE7L4bkCRii3QBre91c0=;
 b=VDscERmp+PO8TlqlvEzYQ5WsK2/N1e/qqBWn7i/vExzNXPITw47aiJaPEWRwuUG/eikkGc
 CSgIUZqML/3CpCvGg+lyS2owMzbF5Pejp+K4xxDdzSqbbwa+zQwlMmgHlhXFqIPESwZYa3
 bl6DIgY7VjMF83k5PEVyetPhOr6c6H2IMz153sY6az73mhP1AzoMNaNrZ/HRIkckQ3answ
 yUcJp2m7Ku6lRjjRGSFIVlcLHHvsninbqjpmx/6YrNnmOXHr9c10lZh6yciQtW9aweE/t1
 rY6HB8ZAkZFsz12dT7/GhW90QQPRSgI2vTbdIsHP66jZD3CQBNqk69hpV4LsMQ==
Date: Wed, 18 Feb 2026 12:08:16 +0100
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
Message-ID: <20260218120816.760df1ff@kmaincent-XPS-13-7390>
In-Reply-To: <aZWYOv6nAASD_dQk@a079122.arm.com>
References: <20260216-feature_fwumdata-v3-0-9ecc5b10456d@bootlin.com>
 <20260216-feature_fwumdata-v3-5-9ecc5b10456d@bootlin.com>
 <aZWKyl6r8BphaePp@a079122.arm.com>
 <aZWM0_v4eUgKLTSz@a079122.arm.com>
 <20260218113116.3c447668@kmaincent-XPS-13-7390>
 <aZWYOv6nAASD_dQk@a079122.arm.com>
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

On Wed, 18 Feb 2026 16:15:14 +0530
Sughosh Ganu <sughosh.ganu@arm.com> wrote:

> On Wed, Feb 18, 2026 at 11:31:16AM +0100, Kory Maincent wrote:
> > Hello Sughosh,
> >=20
> > On Wed, 18 Feb 2026 15:26:35 +0530
> > Sughosh Ganu <sughosh.ganu@arm.com> wrote:
> >  =20
> > > On Wed, Feb 18, 2026 at 03:17:58PM +0530, Sughosh Ganu wrote: =20
> > > > On Mon, Feb 16, 2026 at 02:35:35PM +0100, Kory Maincent wrote:   =20
> > > > > Add a new fwumdata tool to allows users to read, display, and mod=
ify
> > > > > FWU (Firmware Update) metadata from Linux userspace. It provides
> > > > > functionality similar to fw_printenv/fw_setenv but for FWU metada=
ta.
> > > > > Users can view metadata, change active/previous bank indices, mod=
ify
> > > > > bank states, and set image acceptance flags. Configuration is done
> > > > > via fwumdata.config file.
> > > > >=20
> > > > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > > > ---   =20
> > > >=20
> > > > I am not sure if this has been discussed with Ilias earlier, and
> > > > apologies if it has been, but I do think that this patch is not
> > > > adhering to the DEN0118 specification, specifically the part mentio=
ned
> > > > in section A3.2.1, which says that the metadata is to be maintained=
 by
> > > > the Update Agent. I would like to hear from Jose Marinho, who is the
> > > > author of the spec, on what he thinks about this approach.
> > > >=20
> > > > I do think that the other patches in series look fine, and can be
> > > > applied. There is just an issue of inclusion of the tool for
> > > > building. I will comment on that patch separately.   =20
> > >=20
> > >=20
> > > Adding Jose to the discussion. =20
> >=20
> > We indeed already had some discussion about it with Ilias.=20
> > https://lists.denx.de/pipermail/u-boot/2025-December/605924.html
> >=20
> > It seems ST deviate from the original idea behind the standard. It does=
 not
> > use EFI neither update capsule.
> > TF-A is managing the selection of the boot partition (FIP image: OPTEE +
> > bootloader) according to the FWU metadata content and is dealingwith the
> > rollback mechanism. Linux through this tools is the update agent to sel=
ect
> > the boot image. =20
>=20
> Okay. I guess that is fine then -- with the Update Agent residing in
> Linux, this is not an issue. My next question then would be, why are
> you adding this to U-Boot then :). Can this not be bundled with a
> related package of RAUC maybe(if one such exists)?

There was also a discussion about this topic:
https://lists.denx.de/pipermail/u-boot/2025-December/604901.html

The final conclusion is:
- for the short/medium term we add it alongside the mkfwumdata tool.=20
- for the long term it would be nice to extract all generic tools to a diff=
erent repo
  than U-boot to make life easier for other projects.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
