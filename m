Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFE2D1356F
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F383588360;
	Sun, 27 Oct 2024 17:43:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hZeahA0k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E428388E00; Sun, 27 Oct 2024 17:43:01 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03E4188113
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 17:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4314c452180so31242805e9.0
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 09:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730047374; x=1730652174; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJrEhSMMv8/jbKoY/z4IANoRel6+xHlDOOBDztCfWVc=;
 b=hZeahA0kj9yba7o2oth8nkRmqn4/OcPmohjxUvyc+QO74eNeAx2dZIErL8TN7sV3So
 PO2nlXoaplzS/ZEPFSvKZdOYG443N+xm7MYdFnjgVA764xP9DYl/c04BAQFEUuMnhM0R
 +kqKqYdmP5sZrYzhMs2vsk+sNpkbJZgwvPzNUvrtl52Ih+eT3Muf+rrX6hNm7SPzgrM+
 6Qr8Et/lbmDra6R7ATekxpeN6RaKb5fr0Q+s+6qKL+HSRDtNwY1SPg95861iPyHefpee
 rOd5WaYUEdh5bet9HKvUDkqz3btLJp8Lq2LY8SfHoaU1O0Fq8v53nf1MdvqULgo4Ug9W
 dpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730047374; x=1730652174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJrEhSMMv8/jbKoY/z4IANoRel6+xHlDOOBDztCfWVc=;
 b=owSMIbo8CDtTBLWvmMCpHerfvtQPQ+yWcJj9nS/uwhBwTegZ7gheViKPzx39Hq0ffI
 k19O4YAmAUoTmxqgtmQ7s9tw+UjFpX3zoTCljIFHD8/4OSZvKS4gH5Enttdgn/WDrApa
 25Rcy3kAxVpkAOPvQU3N4cvmHbDzSHwltEmbt4a+jt/pwi35c17RuldAYr3GFJ5saG06
 uvBQWTRFp+urkdDq9xjlks1ebh7QKjK79wERRLIuOwL/JbqjvXUpocFoI5soQXvmD+Gi
 7uQ9KCwrWvF31j4u7R/Ir+ACOWYFV4o4bVi5N0mJ3qKbc6bTwshRaJlPeiNwEWvuct5K
 Efxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzIKEPj+EOT9EBakaCe+6Id2QRN5umjqp/MnnUp2JoYjMCm4ZzIsWtlveMn0WFPX0M4uQvx/E=@lists.denx.de
X-Gm-Message-State: AOJu0YwQvFUgxQ8vzhJbsTqw+W0pcI900RUV8enL1S+20+ltCNvqABB5
 SC44FhuI/3sMiQpDnv9HDxU7PZIvDzAL1QnpSOSgKIIXAd2Zf3fRMNi+84UzHpFWKXZTCVJhePL
 JjmqOZZWLwrNw1DyRKD31pLWhBrY=
X-Google-Smtp-Source: AGHT+IFv20gS+ElaRiE+Cc1OaFjgt9aSlX8T3gSX8PoywYdWo22hzocdBYTB5pktuugEL+j6xpUUlTz7WXXV9Kuf7Rw=
X-Received: by 2002:a05:6000:e04:b0:37d:46ad:127f with SMTP id
 ffacd0b85a97d-38045883804mr9189858f8f.26.1730047374123; Sun, 27 Oct 2024
 09:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20241013145820.85426-1-clamor95@gmail.com>
 <20241013145820.85426-2-clamor95@gmail.com>
 <6f3ce823-93e8-46b5-86f3-52038efc5271@denx.de>
In-Reply-To: <6f3ce823-93e8-46b5-86f3-52038efc5271@denx.de>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 27 Oct 2024 18:42:42 +0200
Message-ID: <CAPVz0n1dHC9VTgxgPmh=bUg1Ei1Wnamopbpjiyz81YxeFtfdWg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usb: ci_udc: don't use "advance" feature when
 setting address
To: Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>, Simon Holesch <simon@holesch.de>,
 Ion Agorria <ion@agorria.com>, u-boot@lists.denx.de
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

=D0=BD=D0=B4, 27 =D0=B6=D0=BE=D0=B2=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 18:0=
9 Marek Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 10/13/24 4:58 PM, Svyatoslav Ryhel wrote:
>
> Sorry for the late reply.
>
> > +++ b/drivers/usb/gadget/ci_udc.c
> > @@ -649,12 +649,30 @@ static void flip_ep0_direction(void)
> >       }
> >   }
> >
> > +/*
> > + * This function explicitly sets the address, without the "USBADRA" (a=
dvance)
> > + * feature, which is not supported by older versions of the controller=
.
> > + */
> > +static void ci_set_address(struct ci_udc *udc, u8 address)
> > +{
> > +     DBG("%s %x\n", __func__, address);
>
> log_debug() or dev_dbg() please.
>

DBG macro is used across entire driver, if you wish to replace it,
then pls, send a followup with patch for entire driver. This is out of
scope of this patch.

> > +     writel(address << 25, &udc->devaddr);
> > +}
> > +
> >   static void handle_ep_complete(struct ci_ep *ci_ep)
> >   {
> >       struct ept_queue_item *item, *next_td;
> >       int num, in, len, j;
> >       struct ci_req *ci_req;
> >
> > +     /* Set the device address that was previously sent by SET_ADDRESS=
 */
> > +     if (controller.next_device_address !=3D 0) {
> > +             struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->=
hcor;
> > +
> > +             ci_set_address(udc, controller.next_device_address);
> > +             controller.next_device_address =3D 0;
> > +     }
> > +
> >       num =3D ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
> >       in =3D (ci_ep->desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
> >       item =3D ci_get_qtd(num, in);
> > @@ -783,7 +801,7 @@ static void handle_setup(void)
> >                * write address delayed (will take effect
> >                * after the next IN txn)
> >                */
> > -             writel((r.wValue << 25) | (1 << 24), &udc->devaddr);
> > +             controller.next_device_address =3D r.wValue;
>
> wValue is word , u16 , but next_device_address is u8 below , why ?
>

wValue is u16 but only 8 bits are relevant since USB address is 8 bit,
hence u8. Changing wValue to u8 is out of scope of this patch as well.

> >               req->length =3D 0;
> >               usb_ep_queue(controller.gadget.ep0, req, 0);
> >               return;
> > @@ -814,6 +832,9 @@ static void stop_activity(void)
> >       int i, num, in;
> >       struct ept_queue_head *head;
> >       struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
> > +
> > +     ci_set_address(udc, 0);
> > +
> >       writel(readl(&udc->epcomp), &udc->epcomp);
> >   #ifdef CONFIG_CI_UDC_HAS_HOSTPC
> >       writel(readl(&udc->epsetupstat), &udc->epsetupstat);
> > @@ -934,6 +955,7 @@ static int ci_pullup(struct usb_gadget *gadget, int=
 is_on)
> >       struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
> >       if (is_on) {
> >               /* RESET */
> > +             controller.next_device_address =3D 0;
> >               writel(USBCMD_ITC(MICRO_8FRAME) | USBCMD_RST, &udc->usbcm=
d);
> >               udelay(200);
> >
> > diff --git a/drivers/usb/gadget/ci_udc.h b/drivers/usb/gadget/ci_udc.h
> > index bea2f9f3fe3..807f2084c1e 100644
> > --- a/drivers/usb/gadget/ci_udc.h
> > +++ b/drivers/usb/gadget/ci_udc.h
> > @@ -105,6 +105,7 @@ struct ci_drv {
> >       struct ept_queue_head           *epts;
> >       uint8_t                         *items_mem;
> >       struct ci_ep                    ep[NUM_ENDPOINTS];
> > +     u8                              next_device_address;
>
> Should this be u16 ?

No, USB address is only 8bits (u8)
