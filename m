Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB32E784AC
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 13:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C56FB870AD;
	Mon,  2 Oct 2023 15:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="gKlYyK1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7585786DE8; Mon,  2 Oct 2023 15:42:54 +0200 (CEST)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C28E86DF6
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 15:42:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D199260002;
 Mon,  2 Oct 2023 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1696254170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Pw9oVYxWmLCzRyqRsy37YM09Y7zNtfIMFj/v8KgtJw=;
 b=gKlYyK1qKp4l4s3F1qgN24akzjKe16fA0HuBzJw+v3nnCbo4E9MZ/Ag3qZJbFSbXuMbvJ5
 Uc0DpTR1ASiflV64tM4L72DmACSfVXhjDsKhCyDQlezy7fU8lnh0o9Q9B/VM/u3GiNk4Kw
 MorsaGzKoP9ZFwIT+DnKltQtk7NcNjMfdz6/pB8af8D7nma16pU1IDINKf/6jUShW8hqs1
 Um5Jf8zRNwfRk8ijT+KDe7TSWwx6N9WkTaEZVyBvU0EG+7nFVIZn4PLh+XozLsOtZSXtua
 3UXfnVzcCab6Wxz4H/liCWo9Id0V0KFSntTYvQIqlWtrq1R/oR+DoYPel0/SMw==
Date: Mon, 2 Oct 2023 15:42:46 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Angus Ainslie <angus@akkea.ca>, Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>, Kever Yang
 <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, Nishanth
 Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, Stefan Roese
 <sr@denx.de>, kernel@puri.sm
Subject: Re: [PATCH v2 01/17] dm: usb: udc: Factor out plain udevice handler
 functions
Message-ID: <20231002154246.38d43236@xps-13>
In-Reply-To: <7abc460b-54c2-67b0-2f1e-e67a6878666e@denx.de>
References: <20230901095003.352930-1-marex@denx.de>
 <20230922120012.6e24645f@xps-13> <20230927155901.10c5d520@xps-13>
 <7abc460b-54c2-67b0-2f1e-e67a6878666e@denx.de>
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

Hi Marek,

marex@denx.de wrote on Sat, 30 Sep 2023 23:11:17 +0200:

> On 9/27/23 15:59, Miquel Raynal wrote:
> > Hi Marek, =20
>=20
> Hi,
>=20
> > miquel.raynal@bootlin.com wrote on Fri, 22 Sep 2023 12:00:12 +0200:
> >  =20
> >> Hi Marek,
> >>
> >> I'm answering here as there is no cover letter. Just to let you know
> >> I'm still concerned by the series and want to test it but did not had
> >> the time to do so recently. Hopefully next week. =20
> >=20
> > The series looks good to me and works as well on a Beagle Bone Black
> > with no visible functional changes regarding the use of the UDC. The
> > whole series is:
> >=20
> > Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >=20
> > By the way, following your initial series there have been three
> > followup patches trying to improve a little bit the doc, one got merged
> > and two others were delegated to you:
> > https://patchwork.ozlabs.org/project/uboot/list/?series=3D367635
> >=20
> > They are almost 2 months old now, would you mind acking or merging
> > them so both your initial USB gadget rework and the additional
> > (related) doc can be in the same release please? =20
>=20
> Can you resend those and CC this mail address ?

Of course!

> That said, 1/2 should be in some sort of README instead, and the 'dm tree=
' command depends on CMD_DM=3Dy .

Well, the README is more something which targets the developer IMO,
whereas here I want to target the users. Many people only see U-Boot
through Yocto now (that's a different topic) and the purpose of this
additional text is to help them in finding their way into U-Boot device
model *alone*. It's really short, but I bet it can really help, given
how I felt when I actually understood why you advised to type a couple
of semi-random bind/unbind commands which eventually worked. Anybody not
involved in any DM conversion is likely just not aware of all of that.
Having people finding their own way through the DM means less
complaints/needs for help on the mailing list.

> The usb_gadget_probe_driver() is code synchronized from kernel, you likel=
y want to add any such clarification to usb_gadget_register_driver() .

Actually the kernel functions do have some kind of alternate error
message as well now :-) Clearly different given that this code has been
adapted to U-Boot's DM, but the idea is close. However
usb_gadget_register_driver() is kind of blind regarding the number of
UDCs in the system and if they are already bound or not, so I don't
really see the point in moving the error message there along with all
the logic duplication involved.

> That said, the usb_gadget_register_driver() should be reworked into
> some new functions, which takes UDC controller *udevice pointer to
> avoid this binding heuristics.

Yes, I don't know many boards with two UDCs but it's a clear limitation.

Thanks,
Miqu=C3=A8l
