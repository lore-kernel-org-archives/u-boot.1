Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C116CE7A89
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 07:21:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D1586B82;
	Mon, 25 Sep 2023 09:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ZlnkQHc6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34D6C86B8B; Mon, 25 Sep 2023 09:21:30 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0FBD86B3A
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 09:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B888FF812;
 Mon, 25 Sep 2023 07:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1695626487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mW/LhaMZ6C8T9Ul4CHk8qHTKhJA/foMq45GY45NOR0=;
 b=ZlnkQHc60r6J3wd2dZP/cYKxILn0bxKYukv/OkkSmvgkE18IIjcfgpNU26e1xi/o4Nch67
 oD6+c1pJkQkZ3sYg+Bht63SC/7Ncy7MmxImhrKsHPzByzIqWnONyDShI4i2RuC1LDB1SWb
 /HaNVl60+WIY4MHmTJMm9MlJ53jPhbxlWA06cJT1xK0Y86w6FCyVbg3/I7BEihXLdBcwD8
 lVhi+YO+I6wn61/EeCAdf/tQDGvBu/nqYUT+5cLPpmnbwQbe1MiDBfpAlgZRx2wua4A+JX
 MY4f9+FEh5Q0hUyrUVnWceGbmiCKgpneO87BI53cvcJ4BCfOZByWUnmlMaR2Cw==
Date: Mon, 25 Sep 2023 09:21:22 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, U-Boot
 Mailing List <u-boot@lists.denx.de>, linux-mtd@lists.infradead.org, Tom
 Rini <trini@konsulko.com>, Conor Dooley <conor+dt@kernel.org>, Dhruva Gole
 <d-gole@ti.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
Message-ID: <20230925092122.0b615f25@xps-13>
In-Reply-To: <CAPnjgZ3BnD9aX3cNNPiGRKTOj+YeurHCLv6K0TRFhAtY21Qufw@mail.gmail.com>
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
 <CAPnjgZ1pfxaMG1n5yOBhiOhsNrRjck1K92U7Ga=+VTY_jjjrVg@mail.gmail.com>
 <20230922174649.GA3320366-robh@kernel.org>
 <CAPnjgZ3ojfAv=BHqOhM=-NnYqCm81Ny=PsGKiNphKTmw++fk9w@mail.gmail.com>
 <CAL_JsqJqvyP=c93DHDO8A5RXv7Lz_Z7eEHSbJQ=JCo+qPVhSfg@mail.gmail.com>
 <CAPnjgZ3BnD9aX3cNNPiGRKTOj+YeurHCLv6K0TRFhAtY21Qufw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Simon,

sjg@chromium.org wrote on Fri, 22 Sep 2023 13:51:14 -0600:

> Hi Rob,
>=20
> On Fri, 22 Sept 2023 at 13:43, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Sep 22, 2023 at 1:12=E2=80=AFPM Simon Glass <sjg@chromium.org> =
wrote: =20
> > >
> > > Hi Rob,
> > >
> > > On Fri, 22 Sept 2023 at 11:46, Rob Herring <robh@kernel.org> wrote: =
=20
> > > >
> > > > On Fri, Sep 22, 2023 at 11:01:18AM -0600, Simon Glass wrote: =20
> > > > > Hi Rob,
> > > > >
> > > > > On Fri, 22 Sept 2023 at 10:00, Rob Herring <robh@kernel.org> wrot=
e: =20
> > > > > >
> > > > > > On Thu, Sep 21, 2023 at 1:45=E2=80=AFPM Simon Glass <sjg@chromi=
um.org> wrote: =20
> > > > > > >
> > > > > > > Binman[1] is a tool for creating firmware images. It allows y=
ou to
> > > > > > > combine various binaries and place them in an output file.
> > > > > > >
> > > > > > > Binman uses a DT schema to describe an image, in enough detai=
l that
> > > > > > > it can be automatically built from component parts, disassemb=
led,
> > > > > > > replaced, listed, etc.
> > > > > > >
> > > > > > > Images are typically stored in flash, which is why this bindi=
ng is
> > > > > > > targeted at mtd. Previous discussion is at [2] [3].
> > > > > > >
> > > > > > > [1] https://u-boot.readthedocs.io/en/stable/develop/package/b=
inman.html
> > > > > > > [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-s=
jg@chromium.org/
> > > > > > > [3] https://www.spinics.net/lists/devicetree/msg626149.html =
=20
> > > > > >
> > > > > > You missed:
> > > > > >
> > > > > > https://github.com/devicetree-org/dt-schema/pull/110
> > > > > >
> > > > > > where I said: We certainly shouldn't duplicate the existing par=
titions
> > > > > > bindings. What's missing from them (I assume we're mostly talki=
ng
> > > > > > about "fixed-partitions" which has been around forever I think =
(before
> > > > > > me))?
> > > > > >
> > > > > > To repeat, unless there is some reason binman partitions confli=
ct with
> > > > > > fixed-partitions, you need to start there and extend it. From w=
hat's
> > > > > > posted here, it neither conflicts nor needs extending. =20
> > > > >
> > > > > I think at this point I am just hopelessly confused. Have you tak=
en a
> > > > > look at the binman schema? [1] =20
> > > >
> > > > Why do I need to? That's used for some tool and has nothing to do w=
ith a
> > > > device's DTB. However, I thought somewhere in this discussion you s=
howed
> > > > it under a flash device node. =20
> > >
> > > Yes, that is the intent (under a flash node).
> > > =20
> > > > Then I care because then it overlaps with
> > > > what we already have for partitions. If I misunderstood that, then =
just
> > > > put your schema with your tool. Only users of the tool should care =
about
> > > > the tool's schema. =20
> > >
> > > OK. I believe that binman will fit into both camps, since its input is
> > > not necessarily fully formed. E.g. if you don't specify the offset of
> > > an entry, then it will be packed automatically. But the output is
> > > fully formed, in that Binman now knows the offset so can write it to
> > > the DT. =20
> >
> > I suppose it could take its own format as input and then write out
> > something different for the "on the device" format (i.e.
> > fixed-partitions). At least for the dynamic offsets, we may need
> > something allowed for binman input, but not allowed on device. In
> > general, there is support for partitions without addresses/offsets,
> > but only for partitions that have some other way to figure that out
> > (on disk partition info).
> >
> > There's also the image filename which doesn't really belong in the on
> > device partitions. So maybe the input and output schemas should be
> > separate. =20
>=20
> OK, I'll focus on the output schema for now. I suspect this will be a
> grey area though.
>=20
> As an example, if you replace a binary in the firmware, Binman can
> repack the firmware to make room, respecting the alignment and size
> constraints. So these need to be in the output schema somehow.
>=20
> > =20
> > > > > I saw this file, which seems to extend a partition.
> > > > >
> > > > > Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-par=
titions.yaml =20
> > > >
> > > > IIRC, that's a different type where partition locations are stored =
in
> > > > the flash, so we don't need location and size in DT. =20
> > >
> > > OK.
> > > =20
> > > > =20
> > > > >
> > > > > I was assuming that I should create a top-level compatible =3D "b=
inman"
> > > > > node, with subnodes like compatible =3D "binman,bl31-atf", for ex=
ample.
> > > > > I should use the compatible string to indicate the contents, righ=
t? =20
> > > >
> > > > Yes for subnodes, and we already have some somewhat standard ones f=
or
> > > > "u-boot" and "u-boot-env". Though historically, "label" was used. =
=20
> > >
> > > Binman has common properties for all entries, including "compress"
> > > which sets the compression algorithm. =20
> >
> > I see no issue with adding that. It seems useful and something missing
> > in the existing partition schemas. =20
>=20
> OK I sent a patch with that.
>=20
> > =20
> > > So perhaps I should start by defining a new binman,bl31-atf which has
> > > common properties from an "binman,entry" definition? =20
> >
> > I don't understand the binman prefix. The contents are ATF (or TF-A
> > now). Who wrote it to the flash image is not relevant. =20
>=20
> Are you suggesting just "atf-bl31", or "arm,atf-bl31" ? Or should we
> change it to "tfa-bl31"?

I don't really understand the relationship with TF-A here. Can't we
just have a kind of fixed-partitions with additional properties like
the compression?

> > We already have some compatibles in use. We should reuse them if
> > possible. Not sure about TF-A though. =20
>=20
> OK.
>=20

Also, I still don't understand the purpose of this schema. So binman
generates an image, you want to flash this image and you would like the
tool to generate the corresponding (partition) DT snippet automatically.
Do I get this right? I don't get why you would need new compatibles for
that.

Thanks, Miqu=C3=A8l
