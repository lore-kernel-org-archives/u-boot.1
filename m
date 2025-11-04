Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BDDCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 15:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A4E3808AF;
	Tue,  4 Nov 2025 16:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="a2+wu1UJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4C298144A; Tue,  4 Nov 2025 16:51:55 +0100 (CET)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10A368003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 16:51:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 7B1F51A1833;
 Tue,  4 Nov 2025 15:51:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 35D58606EF;
 Tue,  4 Nov 2025 15:51:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 567D010B510DF; Tue,  4 Nov 2025 16:51:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1762271511; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=1TqXRv9CJV9sR2OPmEIbHKeYXVAn4vxO0Q+u401whEw=;
 b=a2+wu1UJAKDZBSethhuyA4GgZTYMh+pFKzp4Adu2AIzKx2z8Hfq1O9a7f+XbRvrTixpVTF
 MChBdwqpS3DkYLBI5oSpRazD3LLU20bk85jN4ONvu3Xf5Cmz4w96/dGJH4dYAQtmNju6pi
 U8GZAppDUiihErIbabmaZyOLRn6P7r90NcUuTfzKytJ85rPm0Sz8e7+HlgK1hdEpL/oA3/
 aOSul+U0SreXRbjwrnS2xd39qaJkVRM7lo93DT+ye1AYTa/YT5vNG7ty/48I7YID41vKU0
 1maOkJImBG7jci12Sh6tHVf0RhDrI0pnGuY3/8TZnjDDg/YuguyKNt1LJaQm4A==
Date: Tue, 4 Nov 2025 16:51:47 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Bajjuri Praneeth <praneeth@ti.com>, thomas.petazzoni@bootlin.com, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Martin Schwan
 <m.schwan@phytec.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] doc: bootstd: Describe the optional
 extension_overlay_addr environment
Message-ID: <20251104165147.2e5bf7cc@kmaincent-XPS-13-7390>
In-Reply-To: <3e2517cc-1bdd-4e52-b35d-2463111e1ca7@gmx.de>
References: <20251104104530.1064647-1-kory.maincent@bootlin.com>
 <3e2517cc-1bdd-4e52-b35d-2463111e1ca7@gmx.de>
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

On Tue, 4 Nov 2025 16:15:32 +0100
Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> On 11/4/25 11:45, Kory Maincent wrote:
> > From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> >=20
> > Add extension_overlay_addr description to the list of environment
> > variables that can be useful during the standard boot.
> >=20
> > Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> > ---
> >   doc/develop/bootstd/overview.rst | 3 +++
> >   1 file changed, 3 insertions(+)
> >=20
> > diff --git a/doc/develop/bootstd/overview.rst
> > b/doc/develop/bootstd/overview.rst index 6cf3b48efca..d3dba2a3405 100644
> > --- a/doc/develop/bootstd/overview.rst
> > +++ b/doc/develop/bootstd/overview.rst
> > @@ -261,6 +261,9 @@ fdt_addr_r
> >   fdtoverlay_addr_r (needed if overlays are used)
> >       Address at which to load the overlay for the FDT, e.g. 0x02000000
> >  =20
> > +extension_overlay_addr (needed if extension is used)
> > +    Address at which to load the extension FDT overlays, e.g. 0x020000=
00 =20
>=20
> Requiring a predefined address instead of allocating memory via LMB is=20
> not a good design.

Didn't know this U-boot framework and there is no such uses in standard boot
code. It would have been nice to review the series before it got merged I
would have been glad to move it to a better design.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
