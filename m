Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183CFCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 13:35:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9983383A48;
	Fri, 10 Oct 2025 15:35:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WUX43D9+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B6C383A3B; Fri, 10 Oct 2025 15:35:18 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C892583FCE
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 15:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 467FC1A128C;
 Fri, 10 Oct 2025 13:35:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1ACD960667;
 Fri, 10 Oct 2025 13:35:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 14D25102F216D; 
 Fri, 10 Oct 2025 15:35:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1760103314; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=L8Y4TBeCLIdGiIzv3+RZExNeux65YAj7UETyHGpTNvU=;
 b=WUX43D9+mcT+IuDOhKHQpQ108cPHauXySUiyLTLyW0zl68IteFkDTM+7yj0BZHCJ4BCv0t
 MAEjXJ2Y+dwa5ovh1/FYQBuqkO6nxu7oArAMTBWdZc8kaGIojeBvsPWJu5QFtOclF5bxaY
 w/WjzRIpxvIPzPttTWTifv1G+0N2TwDteLRG8t0sjjXEunrKqGqMCS6LiT+f31UXxPKoRy
 Kgv8OjYfWvmOQHduAmFkHkwaLdEv7iJ1//8Fcs5msEusSmMS2TH6TGX0gH10BB6pecjAYz
 ExEMeYBo3o8tLdWs5eC8cizSLQD/InxBigIuQQz3nIo4R/oe45JsuTyeQVO90g==
Date: Fri, 10 Oct 2025 15:35:00 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Hans de Goede
 <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot
 Team" <uboot-imx@nxp.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 03/18] boot: Add UCLASS support for extension boards
Message-ID: <20251010153500.5bec4e20@kmaincent-XPS-13-7390>
In-Reply-To: <CAFLszTg-i7cDiN57pqat=bYwqucCOGqW6oh1CvnJz7-UhKaCwA@mail.gmail.com>
References: <20251009-feature_sysboot_extension_board-v2-0-e09b39e54de5@bootlin.com>
 <20251009-feature_sysboot_extension_board-v2-3-e09b39e54de5@bootlin.com>
 <CAFLszTg-i7cDiN57pqat=bYwqucCOGqW6oh1CvnJz7-UhKaCwA@mail.gmail.com>
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

On Fri, 10 Oct 2025 12:13:11 +0100
Simon Glass <sjg@chromium.org> wrote:

> Hi Kory,
>=20
> On Thu, 9 Oct 2025 at 15:51, Kory Maincent (TI.com)
> <kory.maincent@bootlin.com> wrote:
> >
> > Introduce UCLASS-based extension board support to enable more
> > standardized and automatic loading of extension board device tree
> > overlays in preparation for integration with bootstd and pxe_utils.
> >
> > Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>

...

> > +
> > +#include <alist.h>
> > +#include <command.h>
> > +#include <dm/device-internal.h>
> > +#include <dm/lists.h>
> > +#include <dm/uclass.h>
> > +#include <env.h>
> > +#include <extension_board.h>
> > +#include <fdt_support.h>
> > +#include <malloc.h>
> > +#include <mapmem.h> =20
>=20
> nit: Please correct the ordering
>=20
> https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files

Oh didn't know this rule.

> > +
> > +DECLARE_GLOBAL_DATA_PTR;
> > +
> > +/* For now, bind the extension device manually if none are found */
> > +static struct udevice *extension_get_dev(void) =20
>=20
> This should really return the error rather than gobbling it. Normally
> we use 'int' as the return value, so:
>=20
> static int extension_get_dev(struct udevice *devp)

You mean rather this then:
static int extension_get_dev(struct udevice **devp)

>=20
> > +{
> > +       struct driver *drv =3D ll_entry_start(struct driver, driver);
> > +       const int n_ents =3D ll_entry_count(struct driver, driver);
> > +       struct udevice *dev;
> > +       int i, ret;
> > +
> > +       /* These are not needed before relocation */
> > +       if (!(gd->flags & GD_FLG_RELOC))
> > +               return NULL;
> > +
> > +       uclass_first_device(UCLASS_EXTENSION, &dev);
> > +       if (dev)
> > +               return dev;
> > +
> > +       /* Create the extension device if not already bound */
> > +       for (i =3D 0; i < n_ents; i++, drv++) {
> > +               if (drv->id =3D=3D UCLASS_EXTENSION) { =20
>=20
> If this is really what you want, you might as well just put a
> U_BOOT_DRVINFO() declaration in the source. Then driver model does it
> for you. We are supposed to use the devicetree, but it seems that that
> idea is WIP at best.

Oh I will use this MACRO instead.
=20
> > +int dm_extension_scan(void)
> > +{
> > +       struct alist *extension_list =3D dm_extension_get_list();
> > +       struct udevice *dev =3D extension_get_dev();
> > +       const struct extension_ops *ops;
> > +
> > +       if (!dev || !extension_list)
> > +               return -ENODEV;
> > +
> > +       ops =3D device_get_ops(dev); =20
>=20
> extension_get_ops()

Is it really needed as it is used only once.

>=20
> > +       if (!ops->scan)
> > +               return -ENODEV; =20
>=20
> That is normally -ENOSYS - at this point we have a device, it's just
> that it doesn't have the require method.
>=20
> But it seem strange to me to allow a device that has no means to scan.

Yes, maybe this check is useless indeed, as it is the only action done by t=
he
board code.

...

> > @@ -13,9 +14,28 @@ LIST_HEAD(extension_list);
> >  static int do_extension_list(struct cmd_tbl *cmdtp, int flag,
> >                              int argc, char *const argv[])
> >  {
> > +#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN)
> > +       struct alist *dm_extension_list;
> > +#endif
> >         struct extension *extension;
> >         int i =3D 0;
> >
> > +#if CONFIG_IS_ENABLED(SUPPORT_DM_EXTENSION_SCAN) =20
>=20
> Is it possible to use if() ? Perhaps at the end of your series, when
> all the conversions are done and you can delete the old code?

As all these macro check are removed when the conversion is done I didn't
bother to use if() because I would have to take care of define but not used
warnings.

...

> > +/**
> > + * dm_extension_get_list - Get the extension list
> > + * Return: The extension alist pointer, or NULL if no such list exists=
. =20
>=20
> caller must free the list?

No.
=20
> > + */
> > +struct alist *dm_extension_get_list(void); =20
>=20
> Is this the list of all extensions from all extension devices?

yes.

> > +/**
> > + * dm_extension_apply - Apply extension board overlay to the devicetree
> > + * @extension_num: Extension number to be applied
> > + * Return: Zero on success, negative on failure.
> > + */
> > +int dm_extension_apply(int extension_num); =20
>=20
> The uclass should have a method like apply(struct uclass *dev, int
> extension_num). Is the numbering global across all devices?

We currently support only one extension driver loaded at a time, therefore =
we
don't currently need this uclass parameter.
We will change the API when we will have several scan method possible at the
same time but I can't test it for now. I don't think we will have such cases
soon and maybe the devicetree WIP support will be ok at that time.

> > +
> > +/**
> > + * dm_extension_apply_all - Apply all extension board overlays to the
> > + *                         devicetree
> > + * Return: Zero on success, negative on failure.
> > + */
> > +int dm_extension_apply_all(void);
> > +
> >  struct extension {
> >         struct list_head list;
> >         char name[32];
> > @@ -20,6 +62,28 @@ struct extension {
> >         char other[32];
> >  }; =20
>=20
> At some point in this series, please comment this struct

Ok I will add a patch to add comment on this.

>=20
> >
> > +struct extension_ops {
> > +       /**
> > +        * scan - Add system-specific function to scan extension boards.
> > +        * @dev: extension device to use =20
>=20
> need to document extension_list here - I believe it is a list of
> struct extension? Or is it struct extension * ?

Oop some code leftover here.

>=20
> > +        * Return: The number of extension or a negative value in case =
of
> > +        *         error.
> > +        */
> > +       int (*scan)(struct alist *extension_list); =20
>=20
> This is a bit of a strange uclass function! Since you are probing
> drivers in this uclass, you can iterate through them using
> uclass_foreach...() etc.
>=20
> I am guessing that you just need to add a struct udevice * as the first a=
rg.

As I said there is only one drivers loaded at a time supported for now. =20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
