Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DA3C25B7C
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 15:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 888D38850A;
	Tue, 28 May 2024 17:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="CKWszQgc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7B1A884E9; Tue, 28 May 2024 17:11:21 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF14884B5
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 17:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A5E9320003;
 Tue, 28 May 2024 15:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1716909079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8QykgrGJq4Ijz2tAendYYMoCII3ASrhJQlY2wiotH8=;
 b=CKWszQgczcJu2NO4+12mhOeNUvR4kFuYcvhMAiGox9ZEk5q+3qCBGGNgFXrLEbhqAUGSXZ
 atfykCTkNhqxftElRjdyxGlmPXKTznrBDYhM5NPUWVuMZYmWuYexLfKKrZrj6pM+pfAiqV
 3+pu1r0KVDDGR6Get2Zi0mJPg5XFYANYg8QnczUkiJCDsveGCYmPeUdsyD3ETkqQHjAHmq
 2MZV9S6xCjeRxQ+cIOMn3qVNg7U5W7QT7OqM4tfKZrVrnSXQoZpeyI7NbZKiObWvEaopkA
 jktYjkS5GpveC6H+f+6u9tuaa6qOGjPRWFQRJRCU8di551hDFVP6JAZudvNwjA==
Date: Tue, 28 May 2024 17:11:17 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, thomas.petazzoni@bootlin.com, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] xilinx: zynqmp: Allow multiboot environment write even
 in saved environment
Message-ID: <20240528171117.2986dacb@kmaincent-XPS-13-7390>
In-Reply-To: <a7b20716-669f-4e52-88e6-426f5304c5bb@amd.com>
References: <20240528143652.64489-1-kory.maincent@bootlin.com>
 <a7b20716-669f-4e52-88e6-426f5304c5bb@amd.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
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

On Tue, 28 May 2024 16:53:42 +0200
Michal Simek <michal.simek@amd.com> wrote:

> On 5/28/24 16:36, Kory Maincent wrote:
> > Once the environment was saved, we could not retrieve information about=
 =20
>=20
> nit: use imperative mood.

Ah indeed.

>=20
> > the multiboot image used. When dealing with firmware updates, this
> > information is necessary alongside the saved environment. =20
>=20
> what exactly are you trying to do?

Retrieving the multiboot information to know which boot000x.bin image we ha=
ve
booted. This would allow to check the boot status of a firmware update.

> > Move the multiboot environment set operation before the saved environme=
nt
> > check to ensure this information is always available. =20
>=20
> that make sense.
>=20
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >   board/xilinx/zynqmp/zynqmp.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> > index f370fb7347a..16292ed1c7e 100644
> > --- a/board/xilinx/zynqmp/zynqmp.c
> > +++ b/board/xilinx/zynqmp/zynqmp.c
> > @@ -519,6 +519,10 @@ int board_late_init(void)
> >   	usb_ether_init();
> >   #endif
> >  =20
> > +	multiboot =3D multi_boot();
> > +	if (multiboot >=3D 0) =20
>=20
> likely make sense to remove this check to because you want to have even=20
> multiboot=3D0 too.

I don't understand, this check is >=3D so it supports multiboot=3D0.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
