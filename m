Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D4AF9D0CA
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 13:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B86084206;
	Tue, 14 Apr 2026 15:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="kM/NKQKV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E64A84214; Tue, 14 Apr 2026 15:36:07 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 367C9841F2
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 15:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id B84831A32A8;
 Tue, 14 Apr 2026 13:36:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8D64C60410;
 Tue, 14 Apr 2026 13:36:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8BCB8104510D5; 
 Tue, 14 Apr 2026 15:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776173763; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=HMxEp9ZVar77dhQKjnpB6Pw7nzNY6Xz1rTaS0Tj0vGo=;
 b=kM/NKQKVzs1FEELXTz8sTkPCNLK5tgkAvx+TETyHJNZz3QJClGmeBmfvKnmJ18CuVLPXJc
 xNmmwK31JJ5poenvhC+P86EdP3miX/xueIVVZp6C5uIjoWZxFvuGGAijYxyapWHdFmfynn
 JouYBLxDme3s5qgpKkDnqX0jgcHYq8Um6cTbm5UfOl/6KN8UymF6yZDM6wCN3L1dgQf9ok
 9phx/5EqOi1cu5WBNwDvr+iwcJm7aqVYVwFoBgAYjO1OJ3IjvxdB2930YUtnHenBMdZD58
 VmQJI8sfTB4tyo3iGuGb4WLm84nLKBr6WGS7kCZELushhbZ/p6MNEF8DO8/0IA==
Date: Tue, 14 Apr 2026 15:36:00 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Davis <afd@ti.com>
Cc: <u-boot@lists.denx.de>, Bajjuri Praneeth <praneeth@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Jason Kridner <jkridner@beagleboard.org>,
 <thomas.petazzoni@bootlin.com>, Tom Rini <trini@konsulko.com>, Marian
 Cingel <cingel.marian@gmail.com>
Subject: Re: [PATCH] board: ti: cape_detect: Add overlay name lookup table
 for extension boards
Message-ID: <20260414153600.45f651be@kmaincent-XPS-13-7390>
In-Reply-To: <86387a11-6f9b-4535-962c-150b004f4d20@ti.com>
References: <20260414082007.662549-1-kory.maincent@bootlin.com>
 <86387a11-6f9b-4535-962c-150b004f4d20@ti.com>
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

On Tue, 14 Apr 2026 07:25:34 -0500
Andrew Davis <afd@ti.com> wrote:

> On 4/14/26 3:20 AM, Kory Maincent wrote:
> > From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
> >=20
> > Some extension boards have EEPROM part numbers that do not directly mat=
ch
> > their devicetree overlay filenames. Introduce a static name_mapping tab=
le
> > and a set_cape_overlay() helper that translates the part number and ver=
sion
> > strings read from the EEPROM into the correct overlay filename.
> >=20
> > When no entry matches, fall back to the existing behavior of constructi=
ng
> > the overlay name as "<part_number>-<version>.dtbo" directly from the
> > EEPROM content.
> >=20
> > Add an initial entry mapping BB-GREEN-HDMI revision 00A0 to
> > am335x-bone-hdmi-00a0.dtbo.
> >=20
> > Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>
> > ---
> >   board/ti/common/cape_detect.c | 42 +++++++++++++++++++++++++++++++++--
> >   1 file changed, 40 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/board/ti/common/cape_detect.c b/board/ti/common/cape_detec=
t.c
> > index 88fa6ae81f0..c9555779c0c 100644
> > --- a/board/ti/common/cape_detect.c
> > +++ b/board/ti/common/cape_detect.c
> > @@ -13,6 +13,44 @@
> >  =20
> >   #include "cape_detect.h"
> >  =20
> > +struct name_mapping {
> > +	char part_number[17];
> > +	char version[5];
> > +	char overlay[64];
> > +};
> > +
> > +static struct name_mapping extension_mapping[] =3D {
> > +	{
> > +		"BB-GREEN-HDMI",
> > +		"00A0",
> > +		"am335x-bone-hdmi-00a0.dtbo",
> > +	},
> > +	{ /* sentinel */ }
> > +};
> > +
> > +void set_cape_overlay(char *overlay, char *part_number, char *version)
> > +{
> > +	struct name_mapping *mapping;
> > +
> > +	for (mapping =3D extension_mapping; mapping->part_number[0] !=3D 0;
> > +	     mapping++) { =20
>=20
> Does ARRAY_SIZE() make this any cleaner than a null-terminated array? Or
> do you plan to generalize this in some way more?
>=20
> Either way, the concept looks good to me.

We could indeed use ARRAY_SIZE. I have no preference.
Maybe its indeed better in terms of footprint size. I will send a v2 with i=
t.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
