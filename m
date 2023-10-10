Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3D1CD68FE
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 08:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A29E686C9B;
	Tue, 10 Oct 2023 10:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jOCLmLtq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 711E386C9B; Tue, 10 Oct 2023 10:34:12 +0200 (CEST)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03BD986C67
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 10:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 078CB1C000A;
 Tue, 10 Oct 2023 08:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1696926844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNJmAKULUFP9jTeGCn/u9aAVDP9Nl3Q4ByePJtpldxI=;
 b=jOCLmLtqtPya8nakR4ehBMfDa44wVI36v+ooaF4lIA5w3nAtDGw74yOaf2LyzVqShO5TVw
 xm20OlyRL96fL9JdbIGUpIuo7IwRJLtZvK7rNwJF6ADa29bNXIiV2mpgmleysl/77hJU8S
 JpkKDMq7UKutigo9LXrUF+OviG5yOQTyS5DhzMRQdA6NoeHONKm3rMI6p+9IhEXVEhyqxM
 qMq2rFj6H8yKIY5XVSlaztsuEwqdFibOL+IMSLMUQSKq1vKHwl5BwC6vvZsawzvknS4IRs
 kjUdLGhYKlwfmSoRm9UQ9m5KlIG28zuJIFZgTGYYtKGUeH6bnsB2poyJJq/Zkw==
Date: Tue, 10 Oct 2023 10:34:02 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH RESEND v2 2/2] usb: udc: Try to clarify an error message
Message-ID: <20231010103402.48e0d72e@xps-13>
In-Reply-To: <d8e97696-38fb-4e4f-9473-9a9b820af3ee@denx.de>
References: <20231002134621.94786-1-miquel.raynal@bootlin.com>
 <20231002134621.94786-2-miquel.raynal@bootlin.com>
 <7bdef74c-5756-45f2-80c5-63a9f5d68b03@denx.de>
 <20231005175158.58374ff0@xps-13>
 <d8e97696-38fb-4e4f-9473-9a9b820af3ee@denx.de>
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

> >>> --- a/drivers/usb/gadget/udc/udc-core.c
> >>> +++ b/drivers/usb/gadget/udc/udc-core.c
> >>> @@ -323,6 +323,7 @@ err1:
> >>>    int usb_gadget_probe_driver(struct usb_gadget_driver *driver)
> >>>    {
> >>>    	struct usb_udc		*udc =3D NULL;
> >>> +	unsigned int		udc_count =3D 0;
> >>>    	int			ret; =20
> >>>    >   	if (!driver || !driver->bind || !driver->setup) =20
> >>> @@ -330,12 +331,22 @@ int usb_gadget_probe_driver(struct usb_gadget_d=
river *driver) =20
> >>>    >   	mutex_lock(&udc_lock); =20
> >>>    	list_for_each_entry(udc, &udc_list, list) {
> >>> +		udc_count++;
> >>> +
> >>>    		/* For now we take the first one */
> >>>    		if (!udc->driver)
> >>>    			goto found;
> >>>    	} =20
> >>>    > -	printf("couldn't find an available UDC\n"); =20
> >>> +	if (!udc_count)
> >>> +		printf("No UDC available in the system\n");
> >>> +	else
> >>> +		/* When this happens, users should 'unbind <class> <index>'
> >>> +		 * using the output of 'dm tree' and looking at the line right
> >>> +		 * after the USB peripheral/device controller.
> >>> +		 */
> >>> +		printf("All UDCs in use (%d available), use the unbind command\n",
> >>> +		       udc_count); =20
> >>
> >> Users should really use 'bind' command in the first place, to avoid th=
is guesswork to which UDC (on systems with multiple UDCs) a gadget gets bou=
nd to, and instead bind the gadget to specific UDC they want to bind it to.=
 This code should then be removed entirely. =20
> >=20
> > There are two cases when this can happen:
> > * a single UDC (common) but a function already bound, there is no
> >    guessing here
> > * two (or more) UDC and there is some guessing
> >=20
> > Before your cleanup, drivers would get automatically unbound from the
> > UDC to let the one being needed to bind. =20
>=20
> How did that ever work ?

I believe both commands (fastboot vs. network commands like dhcp, tftp,
etc) would automatically bind to the first UDC and unbind once the
command done. But you recently changed that.

> > This is no longer the case,
> > so there is a change in the CLI and I want to help people facing
> > this new problem with a slightly more comprehensive message because
> > people don't fully understand what USB is all about. We cannot
> > ask all U-Boot USB users to be U-Boot experts and USB experts. This
> > is just a little help. =20
>=20
> In that case, you have to handle the details like CMD_BIND may not be ena=
bled, and CMD_DM may not be enabled.

If I understand correctly you would like this to be described:

CMD_BIND imply CMD_DM
USB_GADGET imply CMD_BIND

Currently there is:

CMD_BIND default y if USB_ETHER

Maybe we should instead have:

CMD_BIND default y if USB_GADGET

And perhaps I would even go further and change the dependency
direction, so:

USB_GADGET imply CMD_BIND
CMD_BIND imply CMD_DM

Would this work for you?

> But then, maybe what we want to do is fix the automatic switching of
> gadgets to make it work again ?

This is a longer term goal I guess.

> > In an ideal world, we will have the possibility to create
> > composite gadgets and all this can go away once it is well
> > integrated, I guess? =20
>=20
> I believe you would still have to do a disconnect/connect cycle even with=
 a composite driver, you cannot just add functions to existing composite at=
 runtime.

I have in mind an environment variable which could define the "default"
composite gadget that we want at boot time, but then if people want to
change the gadgets exposed they would indeed need some kind of
disconnect/connect machinery, agreed.

Thanks, Miqu=C3=A8l
