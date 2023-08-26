Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C46C83F11
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 18:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E650C805C3;
	Sat, 26 Aug 2023 20:42:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F370E8074B; Sat, 26 Aug 2023 20:42:30 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E3E298056B
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 20:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2297B1FB;
 Sat, 26 Aug 2023 11:43:06 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 687223F740;
 Sat, 26 Aug 2023 11:42:24 -0700 (PDT)
Date: Sat, 26 Aug 2023 19:41:27 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Jarrah
 Gosbell <kernel@undef.tools>, Arnaud Ferraris
 <arnaud.ferraris@collabora.com>, Pavel Machek <pavel@ucw.cz>,
 u-boot@lists.denx.de, Detlev Casanova <detlev.casanova@collabora.com>,
 =?UTF-8?B?RnLDqWTDqXJpYw==?= Danis <frederic.danis@collabora.com>
Subject: Re: [PATCH] pstore: Use root address-cells/size-cells as defaults
 for reserved-memory
Message-ID: <20230826194127.30117656@slackpad.lan>
In-Reply-To: <f9fc81a5-1505-4cb3-8b65-798ddf16e1aa@gmx.de>
References: <20230826121652.2487643-1-andrej.skvortzov@gmail.com>
 <f9fc81a5-1505-4cb3-8b65-798ddf16e1aa@gmx.de>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sat, 26 Aug 2023 15:10:10 +0200
Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

Hi,

> On 8/26/23 14:16, Andrey Skvortsov wrote:
> > u-boot adds reserve-memory node, if it's missing, with following
> > properties:
> >
> > ```
> >      reserved-memory {
> >           #address-cells =3D <2>;
> >           #size-cells =3D <2>; =20
>=20
> This defines the size of cells for the children of reserved-memory and
> and for the ranges property. If you set the cell sizes to 1 you can no
> longer encode 64 bit addresses.

Yes, this is expected in this case, the Allwinner A64 SoC has its memory
map (including DRAM) completely below 4GB, hence the root node can go
with 1/1.

>=20
> >           ranges;
> >      }
> > ```
> >
> > But with these default address-cells and size-cells values, pstore
> > isn't working on A64. Root node for A64 defines 'address-cells' and
> > 'size-cells' as 1.
> >
> > dtc complains if reserved-memory has different address-cells and
> > size-cells.
> >
> > ```
> >       Warning (ranges_format): /reserved-memory:ranges: empty "ranges"
> >       property but its #address-cells (2) differs from / (1) =20
>=20
> I cannot find any such requirement in the Devicetree Specification 1.4.
> Is this a dtc bug?

I think the culprit here is the *empty* ranges property:
"If the property is de=EF=AC=81ned with an <empty> value, it speci=EF=AC=81=
es that the
parent and child address space is identical, and no address translation
is required."
As this is contradicted by the differing #a-c/#s-z properties, it looks
like dtc has good reasons to warn.

>=20
> > ```
> >
> > This patch takes into account address-cells and size-cells of the root
> > node and uses them as values for new reserved-memory node. =20
>=20
> Reservations may be above 4 GiB. How does your patch consider this?

If the root #a-c/#s-c don't allow for more than 4GB, then it's for a
reason (in this case, the A64 being 32-bit only, even with AArch64
capable cores), and keeping it isn't restricting it further. So I think
copying the root properties is the right thing to do. I think almost
every other 64-bit core uses 2/2 anyway, so it's just the odd outlier
here.

Cheers,
Andre

> Best regards
>=20
> Heinrich
>=20
> >
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > ---
> >   cmd/pstore.c | 10 ++++++++--
> >   1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/cmd/pstore.c b/cmd/pstore.c
> > index cd6f6feb2f..9795eea2db 100644
> > --- a/cmd/pstore.c
> > +++ b/cmd/pstore.c
> > @@ -486,6 +486,8 @@ void fdt_fixup_pstore(void *blob)
> >   {
> >   	char node[32];
> >   	int  nodeoffset;	/* node offset from libfdt */
> > +	u32 addr_cells_root;
> > +	u32 size_cells_root;
> >   	u32 addr_cells;
> >   	u32 size_cells;
> >
> > @@ -495,6 +497,8 @@ void fdt_fixup_pstore(void *blob)
> >   		log_err("fdt_path_offset() returned %s\n", fdt_strerror(nodeoffset)=
);
> >   		return;
> >   	}
> > +	addr_cells_root =3D fdt_getprop_u32_default_node(blob, nodeoffset, 0,=
 "#address-cells", 2);
> > +	size_cells_root =3D fdt_getprop_u32_default_node(blob, nodeoffset, 0,=
 "#size-cells", 2);
> >
> >   	nodeoffset =3D fdt_find_or_add_subnode(blob, nodeoffset, "reserved-m=
emory");
> >   	if (nodeoffset < 0) {
> > @@ -503,8 +507,10 @@ void fdt_fixup_pstore(void *blob)
> >   		return;
> >   	}
> >
> > -	addr_cells =3D fdt_getprop_u32_default_node(blob, nodeoffset, 0, "#ad=
dress-cells", 2);
> > -	size_cells =3D fdt_getprop_u32_default_node(blob, nodeoffset, 0, "#si=
ze-cells", 2);
> > +	addr_cells =3D fdt_getprop_u32_default_node(blob, nodeoffset, 0,
> > +						  "#address-cells", addr_cells_root);
> > +	size_cells =3D fdt_getprop_u32_default_node(blob, nodeoffset, 0,
> > +						  "#size-cells", size_cells_root);
> >   	fdt_setprop_u32(blob, nodeoffset, "#address-cells", addr_cells);
> >   	fdt_setprop_u32(blob, nodeoffset, "#size-cells", size_cells);
> > =20
>=20

