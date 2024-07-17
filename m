Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0280C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 08:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A377886E5;
	Wed, 17 Jul 2024 10:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QzfKGL6m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E2B088A1B; Wed, 17 Jul 2024 10:26:33 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07B85885E7
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 10:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 478BF20008;
 Wed, 17 Jul 2024 08:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1721204790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EYahKxTKimkj9qfGJB3+5Lza25FoEMRD/xh5TelLvV4=;
 b=QzfKGL6mC/fd0xGhTj5ZR14kVsYO5cHRmTvSt75VRyZqcxqkXITMd4k9RdPhjmuHIV5ji5
 QGDnOKMRept/qxuDqqAtwIaRhLFUfaJFiDsdCoha7CeH+aIrpfkNOf3h1bIdT4Z3/RG8VJ
 QFzWZqZEaSWHskEGKyQneGy+KvUEwrp5nRzyf2+lbboZroesCGthcYowTqcawZquNbqwsw
 5OsVuBLYDv9t3sSlZkNB21h+gq82sFp06YN0sBYtGCowUQe73givIX/TgafNvwqc3UHHIO
 tva5BjOyKatjP1WbCYAG7PalrlUU9+b79xh0Us4BAm5hthElXhFodY0lX1RT4g==
Date: Wed, 17 Jul 2024 10:26:29 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@sigma-star.at>
Cc: Richard Weinberger <richard@nod.at>, upstream@sigma-star.at,
 u-boot@lists.denx.de, jmcosta944@gmail.com, thomas.petazzoni@bootlin.com,
 trini@konsulko.com, upstream+uboot@sigma-star.at
Subject: Re: [PATCH 4/4] squashfs: Fix stack overflow while symlink resolving
Message-ID: <20240717102629.5a1a863c@xps-13>
In-Reply-To: <3173526.TQGk6oTFT5@somecomputer>
References: <20240712082344.8655-1-richard@nod.at>
 <20240712082344.8655-4-richard@nod.at>
 <20240717100635.19491668@xps-13> <3173526.TQGk6oTFT5@somecomputer>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

Hi Richard,

richard@sigma-star.at wrote on Wed, 17 Jul 2024 10:16:06 +0200:

> Hi Miquel,
>=20
> Am Mittwoch, 17. Juli 2024, 10:06:35 CEST schrieb 'Miquel Raynal' via ups=
tream:
> > Hi Richard,
> >=20
> > richard@nod.at wrote on Fri, 12 Jul 2024 10:23:44 +0200:
> >  =20
> > > The squashfs driver blindly follows symlinks, and calls sqfs_size()
> > > recursively. So an attacker can create a crafted filesystem and with
> > > a deep enough nesting level a stack overflow can be achieved.
> > >=20
> > > Fix by limiting the nesting level to 8. =20
> >=20
> > As this is I believe an arbitrary value, could we define this value
> > somewhere and flag it with a comment as "arbitrary" with some details
> > from the commit log? Right now the value '8' is hardcoded at least in 3
> > different places. =20
>=20
> I stole the value from the ext4 code.

Ah ok, interesting. So I guess it is "enough" and was probably not so
random.

> Since U-Boot lacks a common filesystem code, there will be always
> duplication. I can happily add a common define for the value.

Oh yeah, I meant a define in squashfs' code. I was not hinting to
declare a global number (even though in practice it would be nice).

> > Also, 8 seems rather small, any reason for choosing
> > that? I believe this is easy to cross even in non-evil filesystems and
> > could perhaps be (again, arbitrarily) increased a bit? =20
>=20
> For ext4 the value seems okay.
> So dunno. :-)

Yeah, fine I guess.

Thanks,
Miqu=C3=A8l
