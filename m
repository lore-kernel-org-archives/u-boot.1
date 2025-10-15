Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10979CCD18E
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 13:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 317558313B;
	Wed, 15 Oct 2025 15:25:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="R/m1ggy+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D6E28323A; Wed, 15 Oct 2025 15:25:52 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1721980107
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 15:25:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 69B3E4E410D8;
 Wed, 15 Oct 2025 13:25:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 40CD2606F9;
 Wed, 15 Oct 2025 13:25:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 30136102F22CE; 
 Wed, 15 Oct 2025 15:25:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760534747; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=GoKqP40OU9zJj4Sci3IJAdVIkMoeM4Y4KhsloBGXlNo=;
 b=R/m1ggy+J0NnRERtAl3KoGGflK4ae/nwVSze2w7QGKK4i3W6/H2z1QDy9ordUEbFUfwsol
 V7TXXRI0cwm8YI9SrrMz7wzwM4jQ1ujJGXI91tYmR6Som7mhrUe8cm8dPAaocWaLN9mxSM
 Gqow/fOoaHhaBVdFmuCa7HIaGbCRM81l/rxrjNO3vJSIrWzkiBdDQEMDUCDnvrHMMfb2rC
 /Gd76Ca+hQITVDjAMMOarPad5gLpsO3b2l2XExlukVkfdVB30vYSWrKLBkK3cDn8jNmDZy
 xneRq7o6hdzKS81SR8OBo1KER1qniU8WSLwMckyJdiEO0uGVkmoKIepyksFWfw==
Date: Wed, 15 Oct 2025 15:25:38 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] test: Do not build expo and cedit test if no SDL
Message-ID: <20251015152538.7fccb0f6@kmaincent-XPS-13-7390>
In-Reply-To: <20251006214436.GE298503@bill-the-cat>
References: <20251006164506.380308-1-kory.maincent@bootlin.com>
 <CAFLszTg+2-xRo1N3zzqY3BEUUqM989xifttbar_+mOE_X12PYg@mail.gmail.com>
 <20251006214436.GE298503@bill-the-cat>
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

Hello Tom,

On Mon, 6 Oct 2025 15:44:36 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Mon, Oct 06, 2025 at 02:38:10PM -0600, Simon Glass wrote:
> > Hi Kory,
> >=20
> > On Mon, 6 Oct 2025 at 10:45, Kory Maincent <kory.maincent@bootlin.com>
> > wrote: =20
> > >
> > > expo and cedit tests depend on the host having the SDL library.
> > > Build these tests only if VIDEO_SANDBOX_SDL config is enabled.
> > >
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > ---
> > >  test/boot/Makefile | 2 ++
> > >  1 file changed, 2 insertions(+) =20
> >=20
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >=20
> > We should be careful that a future CI change doesn't cause these tests
> > to stop running. =20
>=20
> Given how HOST_HAS_SDL is defined, CI will be fine.

What is the status on this fix? I see that it is still not merged. Is there=
 a
reason for this?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
