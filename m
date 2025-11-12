Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98D4CCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 14:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10B1583CA4;
	Wed, 12 Nov 2025 15:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="FQcOwjVt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B7B83CAD; Wed, 12 Nov 2025 15:23:05 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD9983C54
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 15:23:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 263C0C0F561
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 14:22:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BE1026070B;
 Wed, 12 Nov 2025 14:23:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 627C5102F187D; Wed, 12 Nov 2025 15:22:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1762957380; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=G9k3Vmie5SsemGbCvluxSg7knpNvbFV0iXvsOGl4UOg=;
 b=FQcOwjVtR6PR7lpj4Ww75dytDM9NtwzX7KmGWNqFsBrDqAskKlY+vqINoHYtUo2DwtfOTE
 SPN7Rf6RDiAaHfSXP5ggSCYvnueBqhZNiuqS1C6x/Cm9YnSqGq55UmhcgdOjIzkrenWM5N
 h3+IXPuuAiqALwdH5aARqyULmZ0rgpGEtT5esvgzuFddyInAhWVTygD+C8h52iGoWvrXeO
 tg9Gw7V6OnhM4cK2v9W0YjlRmmGL1YSY1iJeCH+DMt1rzyb0HJ4zDrgen1a74lyQC6s50V
 QxkeIC6QPCJm2uzcdmbBVCi/V9AgtyWlzX2Y/rD7I6EMNNS91F+ufURGy6fSdA==
Date: Wed, 12 Nov 2025 15:22:55 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, Bajjuri Praneeth
 <praneeth@ti.com>, thomas.petazzoni@bootlin.com, Tom Rini
 <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH] boot: pxe_utils: Fix memory allocation issues in
 overlay_dir handling
Message-ID: <20251112152255.3a7b8ab3@kmaincent-XPS-13-7390>
In-Reply-To: <89c8a024-fdd6-40ac-8208-a97dba4f1016@cherry.de>
References: <20251112131719.98950-1-kory.maincent@bootlin.com>
 <89c8a024-fdd6-40ac-8208-a97dba4f1016@cherry.de>
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

On Wed, 12 Nov 2025 14:44:33 +0100
Quentin Schulz <quentin.schulz@cherry.de> wrote:

> Hi K=C3=B6ry,
>=20
> On 11/12/25 2:17 PM, Kory Maincent wrote:
> > From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
> >=20
> > Fix two memory allocation bugs in label_boot_extension():
> >=20
> > 1. When label->fdtdir is not set, overlay_dir was used without any
> >     memory allocation. Add the missing calloc() in the else branch.
> >=20
> > 2. When label->fdtdir is set, the allocation incorrectly used the
> >     'len' variable instead of 'dir_len'. The 'dir_len' variable is
> >     calculated to include the fdtdir length plus the trailing slash,
> >     while 'len' was only for the fdtdir length. This caused incorrect
> >     memory allocation size.
> >=20
> > These issues could lead to memory corruption or undefined behavior when
> > processing device tree overlays via PXE boot.
> >=20
> > Closes: https://lists.denx.de/pipermail/u-boot/2025-November/602892.html
> > Fixes: 935109cd9e97 ("boot: pxe_utils: Add extension board devicetree
> > overlay support") Signed-off-by: Kory Maincent (TI.com)
> > <kory.maincent@bootlin.com> ---
> >   boot/pxe_utils.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> > index 038416203fc..7a64b6b97d4 100644
> > --- a/boot/pxe_utils.c
> > +++ b/boot/pxe_utils.c
> > @@ -474,7 +474,7 @@ static void label_boot_extension(struct pxe_context
> > *ctx, slash =3D "";
> >  =20
> >   		dir_len =3D strlen(label->fdtdir) + strlen(slash) + 1;
> > -		overlay_dir =3D calloc(1, len);
> > +		overlay_dir =3D calloc(1, dir_len);
> >   		if (!overlay_dir)
> >   			return;
> >  =20
> > @@ -482,6 +482,10 @@ static void label_boot_extension(struct pxe_context
> > *ctx, slash);
> >   	} else {
> >   		dir_len =3D 2;
> > +		overlay_dir =3D calloc(1, dir_len);
> > +		if (!overlay_dir)
> > +			return;
> > +
> >   		snprintf(overlay_dir, dir_len, "/");
> >   	}
> >    =20
>=20
> I'm wondering if we couldn't make this easier to maintain by not having=20
> two calloc and snprintf calls?
>=20
> diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
> index 038416203fc..6c1bf05cf66 100644
> --- a/boot/pxe_utils.c
> +++ b/boot/pxe_utils.c
> @@ -474,17 +474,17 @@ static void label_boot_extension(struct=20
> pxe_context *ctx,
>   			slash =3D "";
>=20
>   		dir_len =3D strlen(label->fdtdir) + strlen(slash) + 1;
> -		overlay_dir =3D calloc(1, len);
> -		if (!overlay_dir)
> -			return;
> -
> -		snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir,
> -			 slash);
>   	} else {
>   		dir_len =3D 2;
> -		snprintf(overlay_dir, dir_len, "/");
> +		slash =3D "/";

In fact I think "./" should be the default one here.

>   	}
>=20
> +	overlay_dir =3D calloc(1, dir_len);
> +	if (!overlay_dir)
> +		return;
> +
> +	snprintf(overlay_dir, dir_len, "%s%s", label->fdtdir?: "", slash);

Yes, that's a good idea!

> Also, we probably want dir_len =3D len + strlen(slash) + 1 to avoid a=20
> second strlen on label->fdtdir (at the top of the git context here).

Indeed!

> Finally, I'm wondering if the snprintf should not be dir_len - 1=20
> considering we calloc with enough room for the trailing NUL character?=20

No, snprintf second argument is the max size written including the null
character.

> Or not have + 1 for dir_len and calloc with + 1.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
