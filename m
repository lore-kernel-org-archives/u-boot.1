Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9344CCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 16:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09C6E80422;
	Wed, 22 Oct 2025 18:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="FCVeHw/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E1881E13; Wed, 22 Oct 2025 18:48:22 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366018004F
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 18:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 113D6C09FA8;
 Wed, 22 Oct 2025 16:47:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AD55E606DC;
 Wed, 22 Oct 2025 16:48:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ACE4D102F243D; 
 Wed, 22 Oct 2025 18:48:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1761151698; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=/upqz1hPWSfn8Ib0BTRe05nC38vKVutwdpJEoAyTFE0=;
 b=FCVeHw/DArcof5svrcfOW/y+udZZsl1covQmQ/QerD5Iy/5kvXeVgBRMLCL1dhlIrO5Rud
 iD39tc5vOQt90eDgA7UgpnmhMprWnqn8SauVvEVfJENQ7dt6/A4E+27f4dMj+J9+Co2ysF
 Ip0wqMYYQxoYUHWZICoJZjPyoDE6Ps97REq4vn2Kew/gSsXBvQApPGtdbvc36F4L4BkYgr
 vibuFbxCq0R7r3XfcEQ9USs/Sk0tyuZDEFv8vcNTjj68cWKJjuRaClb3IY8mGsum+jqKjn
 HTHQxBC6ZwKsIwzt3m42MZL0kqTcKJfSt87krzgOg/tkc3ium8g3z0SC2IGNog==
Date: Wed, 22 Oct 2025 18:48:10 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Bajjuri Praneeth <praneeth@ti.com>,
 thomas.petazzoni@bootlin.com, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] test: py: Add pyelftools dependency for test_event_dump
Message-ID: <20251022184810.2b30ba57@kmaincent-XPS-13-7390>
In-Reply-To: <20251022161958.GL6688@bill-the-cat>
References: <20251022161301.893395-1-kory.maincent@bootlin.com>
 <20251022161958.GL6688@bill-the-cat>
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

On Wed, 22 Oct 2025 10:19:58 -0600
Tom Rini <trini@konsulko.com> wrote:

> On Wed, Oct 22, 2025 at 06:13:00PM +0200, Kory Maincent wrote:
>=20
> > From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> >=20
> > The test_event_dump test requires pyelftools to run.
> > Add this missing dependency to requirements.txt to ensure the test can =
run
> > successfully.
> >=20
> > Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> > ---
> >  test/py/requirements.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/test/py/requirements.txt b/test/py/requirements.txt
> > index 804a427b351..6d7909cb919 100644
> > --- a/test/py/requirements.txt
> > +++ b/test/py/requirements.txt
> > @@ -3,3 +3,4 @@ pycryptodomex=3D=3D3.21.0
> >  pytest=3D=3D6.2.5
> >  pytest-xdist=3D=3D2.5.0
> >  FATtools=3D=3D1.0.42
> > +pyelftools=3D=3D0.32 =20
>=20
> So with commit 859621b47f9e ("python: Recreate test/py and
> tools/buildman requirements.txt files") I re-created this
> file and pyelftools was removed. I think what's wrong is that it's not
> documented that you need tools/binman/requirements.txt installed because
> test_event_dump uses scripts/event_dump.py and that imports elf from
> binman and that in turn needs pyelftools.
=20
Ok, so it is rather a documentation change needed here.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
