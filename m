Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72829E9270D
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 15:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0EBB86B67;
	Thu,  5 Oct 2023 17:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="XWWjSUrb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3A7786B58; Thu,  5 Oct 2023 17:52:03 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E082886B55
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 17:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19210E0013;
 Thu,  5 Oct 2023 15:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1696521119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QrBEQ42FqeZUiJZ7t4J08w3rbwYJ8aVSvXQ1XX0hwI8=;
 b=XWWjSUrb5yd4ZlYB2oW8Zkws/pFxXS/GS9oKS+U/Z7BJSyHotGhkmBj34TKTANDcDSEXjK
 6P375i+w25M62Y96ni4H0pAQ4f3gID8d7OyNBJJKbY49sM62VkXS8pSjIvgdEg6Tw/B36f
 S69zhJ94wcqsI5wo/JM/mNSdCNta1tQZUhZOjLLnhoWwYz7ONQlofs+4HJpJFvpz1J/mkQ
 pFCa188uwv14YvUB1JYhR9dPp3vwfNbx/zGDT+p4waJy71jv/YQ79JanFtRkrcQTVGdRz/
 QgQ/MbE2eWPWiLCZtw6skzC27HOQTw25ZHs2AtZG49TpT+xGCtmmvln4Q571Yg==
Date: Thu, 5 Oct 2023 17:51:58 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH RESEND v2 2/2] usb: udc: Try to clarify an error message
Message-ID: <20231005175158.58374ff0@xps-13>
In-Reply-To: <7bdef74c-5756-45f2-80c5-63a9f5d68b03@denx.de>
References: <20231002134621.94786-1-miquel.raynal@bootlin.com>
 <20231002134621.94786-2-miquel.raynal@bootlin.com>
 <7bdef74c-5756-45f2-80c5-63a9f5d68b03@denx.de>
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

marex@denx.de wrote on Thu, 5 Oct 2023 15:04:25 +0200:

> On 10/2/23 15:46, Miquel Raynal wrote:
> > At some point when trying to use USB gadgets, two situations may arise
> > and lead to a failure. Either the UDC (USB Device Controller) is not
> > available at all (not described or not probed) or the UDC is already in
> > use. For instance, as the USB Ethernet gadget remains bound to the UDC,
> > the use of any other USB gadget (fastboot, dfu, etc) *after* will always
> > fail with the "couldn't find an available UDC" error.
> >=20
> > Let's give a more helpful message by making a difference between the two
> > cases. Let's also hint people who would get this error and grep it into
> > the sources a better explanation of what's wrong with their workflow.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> > While doing this I really wanted to add "much more" error comments but I
> > faced another reality: often the messages are there but use
> > pr_err/log_err which is actually silenced by default with LOGLEVEL=3D3,=
 so
> > I consider this unnecessary, as decreasing the loglevel will make these
> > messages appear. I would have expected errors to be displayed, but I
> > understand it makes the binaries even bigger.
> >=20
> > Resend: no change.
> >=20
> > Changes in v2:
> > * s/UDC/UDCs/. I kept the sentence as it was as the suggested form did
> >    not sound well at all when there is only one UDC.
> > ---
> >   drivers/usb/gadget/udc/udc-core.c | 13 ++++++++++++-
> >   1 file changed, 12 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc=
/udc-core.c
> > index 7f73926cb3e..8405b03462e 100644
> > --- a/drivers/usb/gadget/udc/udc-core.c
> > +++ b/drivers/usb/gadget/udc/udc-core.c
> > @@ -323,6 +323,7 @@ err1:
> >   int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
> >   {
> >   	struct usb_udc		*udc =3D NULL;
> > +	unsigned int		udc_count =3D 0;
> >   	int			ret; =20
> >   >   	if (!driver || !driver->bind || !driver->setup) =20
> > @@ -330,12 +331,22 @@ int usb_gadget_probe_driver(struct usb_gadget_dri=
ver *driver) =20
> >   >   	mutex_lock(&udc_lock); =20
> >   	list_for_each_entry(udc, &udc_list, list) {
> > +		udc_count++;
> > +
> >   		/* For now we take the first one */
> >   		if (!udc->driver)
> >   			goto found;
> >   	} =20
> >   > -	printf("couldn't find an available UDC\n"); =20
> > +	if (!udc_count)
> > +		printf("No UDC available in the system\n");
> > +	else
> > +		/* When this happens, users should 'unbind <class> <index>'
> > +		 * using the output of 'dm tree' and looking at the line right
> > +		 * after the USB peripheral/device controller.
> > +		 */
> > +		printf("All UDCs in use (%d available), use the unbind command\n",
> > +		       udc_count); =20
>=20
> Users should really use 'bind' command in the first place, to avoid this =
guesswork to which UDC (on systems with multiple UDCs) a gadget gets bound =
to, and instead bind the gadget to specific UDC they want to bind it to. Th=
is code should then be removed entirely.

There are two cases when this can happen:
* a single UDC (common) but a function already bound, there is no
  guessing here
* two (or more) UDC and there is some guessing

Before your cleanup, drivers would get automatically unbound from the
UDC to let the one being needed to bind. This is no longer the case,
so there is a change in the CLI and I want to help people facing
this new problem with a slightly more comprehensive message because
people don't fully understand what USB is all about. We cannot
ask all U-Boot USB users to be U-Boot experts and USB experts. This
is just a little help.

In an ideal world, we will have the possibility to create
composite gadgets and all this can go away once it is well
integrated, I guess?

Thanks,
Miqu=C3=A8l
