Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A1DCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 09:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA9A82A9E;
	Tue,  4 Nov 2025 10:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="bXYIuT3w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71DB2836D1; Tue,  4 Nov 2025 10:29:26 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7DA68144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 10:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 227A14E414F1;
 Tue,  4 Nov 2025 09:29:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EDCCE606EF;
 Tue,  4 Nov 2025 09:29:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7ADB110B50125; Tue,  4 Nov 2025 10:29:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1762248562; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=p8N+wwer53jgbOo4augqZHeh4SLYNJfFxtv5TzOIXKs=;
 b=bXYIuT3wABufE7h1yzFRQ8c915j+OAxN3Dj8o8Yen5jCDl39oAfH3+W9wDa/MhESPm9J2v
 d2ymIsRY7gmo42dD/eT2m7oKPKlktyMSRfhw0zp5jRWoarScBSL5onLWY2eyuzfcq1Aay/
 z0Z1P4936iUCYwrNl7susD8s/J/JQ9CK0XTRS6C62DNaIs67gVafys7rBMzKplW8RPu+p8
 XB6iJM48EkKNKWv5/Ev9FxidgX2VGQUuV8ztkfz/ReOsJqrwH58sgcWrZlTG0t63rrC4dc
 3ZiGrNAHl/cn99e80MdHLEL1xaIhU4U5nDFDednBXRdXqZUApj7mmIt/hBW0Fg==
Date: Tue, 4 Nov 2025 10:29:16 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/2] distro_bootcmd: Add support for customizable
 find_distro_rootpart
Message-ID: <20251104102916.3df33d55@kmaincent-XPS-13-7390>
In-Reply-To: <20251103161905.GP6688@bill-the-cat>
References: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
 <20251031-feature_distro_rootpart-v1-1-4e7c465708e8@bootlin.com>
 <CAFLszTicHdtY73+asYQ9NF_uEFg7BsSfN2cW+21FbQoxH9V_JA@mail.gmail.com>
 <20251103115225.381126f1@kmaincent-XPS-13-7390>
 <20251103171630.4df1efdd@kmaincent-XPS-13-7390>
 <20251103161905.GP6688@bill-the-cat>
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

On Mon, 3 Nov 2025 10:19:05 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Mon, Nov 03, 2025 at 05:16:30PM +0100, Kory Maincent wrote:
> > On Mon, 3 Nov 2025 11:52:25 +0100
> > Kory Maincent <kory.maincent@bootlin.com> wrote:
> >  =20
> > > On Sun, 2 Nov 2025 20:54:02 +0100
> > > Simon Glass <sjg@chromium.org> wrote:
> > >  =20
> > > > Hi Kory,
> > > >=20
> > > > On Fri, 31 Oct 2025 at 17:36, Kory Maincent (TI.com) <   =20
> > > > kory.maincent@bootlin.com> wrote:
> > > > >
> > > > > Commit d0ba0ca45a49 ("distro_bootcmd: Set distro_bootpart_uuid for
> > > > > block devices") added support for the distro_boot_part_uuid
> > > > > environment variable to allow using PARTUUID in the kernel command
> > > > > line.
> > > > >
> > > > > However, the way it was written only supports the case where the =
boot
> > > > >     =20
> > > > files   =20
> > > > > and the rootfs are located in the same partition. There are many =
cases
> > > > > where the boot partition and rootfs partition are separate.
> > > > >
> > > > > Add a customizable find_distro_rootpart command to allow each boa=
rd to
> > > > > define its own logic for locating the rootfs partition. This prov=
ides
> > > > > flexibility for boards with custom partition layouts while mainta=
ining
> > > > > backward compatibility for the default case where boot and rootfs
> > > > > share the same partition.
> > > > >
> > > > > Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> > > > > ---
> > > > >  doc/develop/distro.rst          | 11 +++++++++++
> > > > >  include/config_distro_bootcmd.h | 10 +++++++---
> > > > >  2 files changed, 18 insertions(+), 3 deletions(-)
> > > > >     =20
> > > >=20
> > > > How about moving to standard boot and look at this there?   =20
> > >=20
> > > Ok, I will take a look at it. =20
> >=20
> > There is a custom nand boot target [1], and I have not any am335x board=
 with
> > nand memory to test it. I am afraid to break it during the update to
> > bootstd. Not sure we can accept that. What do you think?
> >=20
> > [1]https://elixir.bootlin.com/u-boot/v2025.10/source/include/configs/am=
335x_evm.h#L27
> > =20
>=20
> I think we can risk it. I'd even be OK with not migrating that portion
> and letting anyone still using those platforms, with NAND only, to just
> use a custom boot command instead as I have strong doubts there's anyone
> doing anything other than that currently.

Ok.

Small questions related to standard boot:
Why do we have a lot of bootmeth selected by default like BOOTMETH_EFILOADE=
R,
BOOTMETH_EFI_BOOTMGR, BOOTMETH_VBE ..., but BOOTSTD_DEFAULTS not selected by
default? Shouldn't it be the contrary?
Moreover it is explicitly described that global bootmeth can be slow:
https://elixir.bootlin.com/u-boot/v2025.10/source/doc/develop/bootstd/overv=
iew.rst#L103

The bootmeths environment variable is never read.
Changing this environment in the prompt allows to change the bootmeth order
thanks to this callback:
https://elixir.bootlin.com/u-boot/v2025.10/source/boot/bootmeth-uclass.c#L4=
59
But if we set bootmeths in the board environment it doesn't work at all.
Is it intended?

Regards
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
