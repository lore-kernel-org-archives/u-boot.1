Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E44CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 16:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C33C88331F;
	Mon,  3 Nov 2025 17:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="X8s5iOhC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2263C838A5; Mon,  3 Nov 2025 17:16:38 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5192E80050
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 17:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id DBF0A1A1834;
 Mon,  3 Nov 2025 16:16:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9BE6660628;
 Mon,  3 Nov 2025 16:16:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C9B2F10B5009C; Mon,  3 Nov 2025 17:16:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1762186593; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=v2IxknaQvY0SXMpA2Rtpg6X3+IUZ9GM1xx514F903wY=;
 b=X8s5iOhCNcHRub1oMGIYd5UVbUIsegwooGVqVhfxS4HNoYbdCVmH0J1jbtUQZihhr6WyO6
 9gozb9kGDNBoZ9PdnuTu4UHTtPG7M3CTcaSKLoolxG26yiFPRPp1l2ABoTsykKZWDxbYB/
 MAByEkqnGBvjS546ikclcbhOCVxRPwqojbfeiPETahd9FWS82VyxBPBJQFx9GibxwRs1pa
 hJUNZznEeS3h6S4+9g/0Ws2GaSXXo5Me4UwKtkBy+HghHTfKqLYPAGOaIMCa/IUBVp/ueu
 2p+DJVDgpZoCU0kS5zkwU+KyJldaTtSkFfmCujMOS/B//Qrds4MeymuHcuL8FA==
Date: Mon, 3 Nov 2025 17:16:30 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, "Bajjuri, Praneeth" <praneeth@ti.com>, Tom
 Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/2] distro_bootcmd: Add support for customizable
 find_distro_rootpart
Message-ID: <20251103171630.4df1efdd@kmaincent-XPS-13-7390>
In-Reply-To: <20251103115225.381126f1@kmaincent-XPS-13-7390>
References: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
 <20251031-feature_distro_rootpart-v1-1-4e7c465708e8@bootlin.com>
 <CAFLszTicHdtY73+asYQ9NF_uEFg7BsSfN2cW+21FbQoxH9V_JA@mail.gmail.com>
 <20251103115225.381126f1@kmaincent-XPS-13-7390>
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

On Mon, 3 Nov 2025 11:52:25 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Sun, 2 Nov 2025 20:54:02 +0100
> Simon Glass <sjg@chromium.org> wrote:
>=20
> > Hi Kory,
> >=20
> > On Fri, 31 Oct 2025 at 17:36, Kory Maincent (TI.com) < =20
> > kory.maincent@bootlin.com> wrote:
> > >
> > > Commit d0ba0ca45a49 ("distro_bootcmd: Set distro_bootpart_uuid for bl=
ock
> > > devices") added support for the distro_boot_part_uuid environment var=
iable
> > > to allow using PARTUUID in the kernel command line.
> > >
> > > However, the way it was written only supports the case where the boot=
   =20
> > files =20
> > > and the rootfs are located in the same partition. There are many cases
> > > where the boot partition and rootfs partition are separate.
> > >
> > > Add a customizable find_distro_rootpart command to allow each board to
> > > define its own logic for locating the rootfs partition. This provides
> > > flexibility for boards with custom partition layouts while maintaining
> > > backward compatibility for the default case where boot and rootfs sha=
re
> > > the same partition.
> > >
> > > Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> > > ---
> > >  doc/develop/distro.rst          | 11 +++++++++++
> > >  include/config_distro_bootcmd.h | 10 +++++++---
> > >  2 files changed, 18 insertions(+), 3 deletions(-)
> > >   =20
> >=20
> > How about moving to standard boot and look at this there? =20
>=20
> Ok, I will take a look at it.

There is a custom nand boot target [1], and I have not any am335x board with
nand memory to test it. I am afraid to break it during the update to bootst=
d.
Not sure we can accept that. What do you think?

[1]https://elixir.bootlin.com/u-boot/v2025.10/source/include/configs/am335x=
_evm.h#L27

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
