Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F0EC30653
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 20:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A30B88373;
	Mon, 24 Jun 2024 22:03:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="LGylufJH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B07882B8; Mon, 24 Jun 2024 22:03:35 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16D33883BA
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 22:03:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a7194ce90afso254226066b.2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1719259411; x=1719864211; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODPU2acPM12dhvqo3VdNYZmrI9VGoqP4JxaxbJe3sUY=;
 b=LGylufJH5r5SWhTxKyLBLJ6ROyFQDy13dRMqWjTvPiwhIeVH1VHOjTVr6scbBlaHzG
 TfrQJkFx2AUUDZaYS4LNuBK4PmCOB2HGMQPX1UwvuOHnBy5GqT/PeWYl4fmPxq7ZOk5H
 KzGR69z/FVcHX/+Snqw1J5wWPBDWUqiS9wW8KLe8IrruwgNvBgHH5z0YIJr2RT+p063t
 6BDYZH3scl25W4eLId6/6JHIjF7RnYwiW5EHo6y1kIhyaSt1Q19b0krL0e9sI8s11kn8
 7MYkmB0dmhTP4scWCT5vlg98BUUs9ezfNojZYgLsUzs4FBAa+ACiCJdbM5qO90HJw7zh
 0FqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719259411; x=1719864211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ODPU2acPM12dhvqo3VdNYZmrI9VGoqP4JxaxbJe3sUY=;
 b=nwUwBlaaVZAG6E87D8fvy4025gqhaSocaGkKo9g3HWz6P/qR2Mu2kHI9bpvUFvaLbo
 sEmcZ1FaSp8i8lO8LmstQ3xZnoJLg8gRTfzUkFyBVEDEjWp7uiYbEGOxOAd6l+LSwNN4
 1LhNg8bNTAY+uTDgPcS6ZlMxKiTzlDdsvJZFRVDF0Ubi0uJNPaxjMfe9pC086+70UReo
 JGCDRmifK+YCQVHurxh/w0Tr/rxtevyEYM5F3AfCti/+Xme90XF21Hoxx1/I4+UH1IUu
 iaLal8UhF4f1pxCF5O2pyeJVbOMBR1IbFB3rb50Ld27KCl/G7hRMgmsgbwzbrrdHb/N/
 29Qg==
X-Gm-Message-State: AOJu0Yw448RBZSdD43ne/AVshxtqp7hx03whThGUFI3jo1A4ah8OeMsI
 qCxnTh8aupYCjOPpwYuk+r+qsu5CdQ02Lcd+0O4fHPAyLRzFw2r6p+Vr/uhzzHlQh2P3iRkZKoN
 CjZY6Qu3N2y9Ujzdl16xmwZ1gEIwJszB/VCBgLg==
X-Google-Smtp-Source: AGHT+IFalFdIObWwYMIPag2xcuvbQFUKrGMRd9KQz0+DmhjdttsC+quyhwelWVdlzzYn5Nl7XYfNoccEVDuCvPm1CFM=
X-Received: by 2002:a17:906:ecf8:b0:a6f:b60c:2c08 with SMTP id
 a640c23a62f3a-a715f94a7famr386263666b.24.1719259411072; Mon, 24 Jun 2024
 13:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+vNU34T3gpSn0upzfK8ra5pUyVDE-CQZGaNo73btHA4pdE-A@mail.gmail.com>
 <CAHCN7xLoLecTjdThuxHH9K7KP6NVpaajyRov=TO8em2ADPmyyQ@mail.gmail.com>
In-Reply-To: <CAHCN7xLoLecTjdThuxHH9K7KP6NVpaajyRov=TO8em2ADPmyyQ@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 24 Jun 2024 13:03:18 -0700
Message-ID: <CAJ+vNU29qsdp2iwDmUjm93Rfyfr3dCA321_VO0HHkKkO9U40ng@mail.gmail.com>
Subject: Re: USB OTG mode for DWC3 (ie imx8mp) host controller with usb_ether
 USB Ethernet gadget?
To: Adam Ford <aford173@gmail.com>
Cc: u-boot <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>, 
 Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 dl-uboot-imx <uboot-imx@nxp.com>, Stefano Babic <sbabic@denx.de>,
 Teresa Remmet <t.remmet@phytec.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jun 24, 2024 at 12:54=E2=80=AFPM Adam Ford <aford173@gmail.com> wro=
te:
>
> On Mon, Jun 24, 2024 at 2:39=E2=80=AFPM Tim Harvey <tharvey@gateworks.com=
> wrote:
> >
> > Greetings,
> >
> > What is missing in U-Boot for the DWC3 host controller to support OTG
> > mode for usb_ether (USB Ethernet gadget)? I'm unable to get the usb
> > ethernet gadget to work for the imx8mp as it errors out with 'No UDC
> > available in the system'.
> >
> > The ums/acm/sdp gadget's all call udc_device_get_by_index to get the
> > UDC controller which for DWC3 is provided by
> > drivers/usb/dwc3/dwc3-generic.c and these gadgets work, however
> > usb_ether is different in that it calls usb_gadget_register_driver to
> > bind the gadget driver to the UDC and for DWC3 this calls
> > usb_gadget_probe_driver which iterates over udc_list which does not
> > contain DWC3 hosts that are in peripheral/otg mode.
> >
> > Before I spend a lot more time on this I wanted to see if anyone else
> > understands why boards with DWC3 host controllers like imx8mp don't
> > seem to register controllers in udc_list that are not in host mode.
> >
> > I'm also unclear how to get a DWC3 controller to switch roles
> > dynamically at runtime based on a gpio state for example. That support
> > appears to be missing and I'm not sure what the right way would be to
> > go about adding it. I notice that some imx8mp boards like the
> > imx8mp-evk have a u-boot.dtsi that just forces its OTG controller to
> > peripheral mode and I force the imx8mp-venice OTG controllers into
> > host mode.
>
> I think there is some interaction between the DWC controller and a
> type-c controller, but I think the mainline code lacks a proper type-c
> controller and/or framework.  Not everyone might use a USB Type-C
> chip, but it seems like if the USB is set to dual-role, it could
> default to peripheral mode until someone starts the USB host stuff
> with 'usb start'

Agreed... if I override the controller to peripheral mode as is done
by Fabio for imx8mp-evk in commit b0eef7326920f ("imx8mp-evk: Add USB0
OTG support") I would expect peripheral mode to work and for imx8mp it
does indeed work for sdp/acm/ums just not for usb_ether.

I'm not clear if usb_ether is doing things the 'right way' or if the
others are doing it the right way and maybe they are both doing things
the right way and the issue I'm facing is that for whatever reason the
dwc3_generic_peripheral driver just doesn't get added to the udc_list.

>
> I am just not sure how to handle situations where a USB cable may be
> connected to a host computer and someone issues a start command and
> brings up VBUS which may cause a voltage contention.

If a USB start command is done the controller should check to make
sure it's in host mode before bringing up VBUS. This is done for the
ci_udc controller used in imx8mm for example. That controller uses the
USB_ID pin routed to the CI block when determining the role. There
does not currently appear to be any support for making role detection
generic such that an extcon driver or something like that could
provide the role functionality.

> I think some people tried to push a Type-C driver if memory serves,
> but I think it was rejected.  I don't recall the details and my memory
> is terrible.  :-)

you're not alone there! I rely heavily on notes but often forget where
my notes are :)

Tim
