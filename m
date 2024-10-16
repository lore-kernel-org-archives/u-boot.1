Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D04D2F7C5
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 21:42:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D1FD88DB6;
	Wed, 16 Oct 2024 23:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mITimYSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EA9688DD1; Wed, 16 Oct 2024 21:57:17 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C796288DDC
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 21:57:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ionpl9@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c94861ee25so141019a12.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729108634; x=1729713434; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kxsw95VCNsyd/j34HZnYbwkH/frqsxDQzlTOjBTM4/c=;
 b=mITimYSsoQHyJWm4fJpuZ+HeKGVsTKY9nkyvnmQ6Oi/8z9U1st2+yeSCFdCaFCKxA8
 8njMuQf7/8YhrG4bo4F6TYDG80sFmLLuQb/NbzBfDkw0v/FAHX0HXYzy9AttAEznACLO
 Tp389WaH5z1klXv7oBz6/qNbaHhNOgYmiIAY2LsDRMANJ9XnFcSCd2AaZquzXhhziBn+
 UP8AY5ckbM2EhCKdoQvWZ0Foma5QLHYH5U8qpvcgUjFfRVZotXnb6H7lkAlyY5LOD7WM
 6zxj4MeX6gF5l/YV+o9/1Bn4hQdvLi4Wi00SSwbMg7vxnlEHdY5IohY+IRsPCobG4w9E
 MVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729108634; x=1729713434;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kxsw95VCNsyd/j34HZnYbwkH/frqsxDQzlTOjBTM4/c=;
 b=Ppn00mPXnAEi2T8OYlAo49e+XOdx3W+uNgVAuj0HKM1CUiWfBprmj6Bcxa4wHjntoU
 UtYk/kEy4YVKTXrguZWnOad50AzSNRDqtal8wbT2X3zuAsBLIzxxZctu4l4/wCtxN5p9
 GPxVde+J9/S7qDszTdmYYys+rCpV8qe4ZpfxMz89NUc5QAtVCiONYwuYmm+zB0/Gudez
 cywfDsGomBtL0FpclUUg2lvIullhQ+67X/01nBPFdqZ8cZcaLqiMENYRHhFOgPHk4/iD
 5ZJRv8RABvBAKzA+uuDb0Y3cAMiTsvfKxbs/YjV/lrUvE5Thpmypk0bdJy+a6xug8t/w
 W6ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx3Vy1ie4gxsrt0f3JXLYof9gKUM3Vmn2Hhg2qKlM/QyGWZE0476vvH57LlvdEqt1CvidEU5k=@lists.denx.de
X-Gm-Message-State: AOJu0YzZRbQn9vROMPtYFPz6MGLx3WzQozWgHMMheJSyKDMx9ymGVHxq
 r5nj3DaINUpsVXqlJEeUMxzzBEZno+O5Z10tCH5A7hHYAENzAwsbFhNHwFJSV7F3284M26Omi71
 geBhmC/0A5UPE2CmE5vRcdWbyGAo=
X-Google-Smtp-Source: AGHT+IF8KBFGflq+yGaCXDz3oaxJf/MSnrAvU5qhQsTckF8bizVMp662gk/hWuJqpPfq4otZaO8i5LqhIaUUOFlVW+o=
X-Received: by 2002:a05:6402:520f:b0:5c9:59e6:e929 with SMTP id
 4fb4d7f45d1cf-5c95aaf19c5mr25046678a12.0.1729108633878; Wed, 16 Oct 2024
 12:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241013145820.85426-1-clamor95@gmail.com>
 <20241013145820.85426-2-clamor95@gmail.com>
 <87sesxzo2o.fsf@baylibre.com>
In-Reply-To: <87sesxzo2o.fsf@baylibre.com>
From: Ion Agorria <ionpl9@gmail.com>
Date: Wed, 16 Oct 2024 21:57:02 +0200
Message-ID: <CAACy2-ai7EhrG0iwqnoQbpyzokb=-aEDPtQuiSv6nmF35qUJ_Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usb: ci_udc: don't use "advance" feature when
 setting address
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Simon Holesch <simon@holesch.de>,
 Ion Agorria <ion@agorria.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 16 Oct 2024 23:42:51 +0200
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

Hello,

Yes that's the correct commit I found when researching why the issue
didn't happen in Linux, I already found that Tegra 2 reference docs
had a different information about the register compared to Tegra 3.

I consider that a single variable is enough since the value is only
non-zero when we want to set a new address. But if is necessary i can
copy like Linux does.

Regards,
Ion Agorria

El mar, 15 oct 2024 a las 11:56, Mattijs Korpershoek
(<mkorpershoek@baylibre.com>) escribi=C3=B3:
>
> Hi Svyatoslav,
>
> Thank you for the patch.
>
> On dim., oct. 13, 2024 at 17:58, Svyatoslav Ryhel <clamor95@gmail.com> wr=
ote:
>
> > From: Ion Agorria <ion@agorria.com>
> >
> > In the older USB controllers like for example in ChipIdea controller
> > used by the Tegra 2 the "USBADRA: Device Address Advance" bitflag
> > does not exist, so the new device address set during SET_ADDRESS
> > can't be deferred by hardware, which causes the host to not recognize
> > the device and give an error.
> >
> > Instead store it until ep completes to apply the change into the hw
> > register as Linux kernel does. This should fix regression on old and
> > and be compatible with newer controllers.
>
> Since this is based on a linux commit, can we please mention the
> revision in the commit message?
>
> Per my understanding, this would be:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Def15e5490edc7edf808d3477ab32e0e320792f65
>
> >
> > Signed-off-by: Ion Agorria <ion@agorria.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/usb/gadget/ci_udc.c | 24 +++++++++++++++++++++++-
> >  drivers/usb/gadget/ci_udc.h |  1 +
> >  2 files changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
> > index bbe03cfff1f..4bff75da759 100644
> > --- a/drivers/usb/gadget/ci_udc.c
> > +++ b/drivers/usb/gadget/ci_udc.c
> > @@ -649,12 +649,30 @@ static void flip_ep0_direction(void)
> >       }
> >  }
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
> > +     writel(address << 25, &udc->devaddr);
> > +}
> > +
> >  static void handle_ep_complete(struct ci_ep *ci_ep)
> >  {
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
> >  #ifdef CONFIG_CI_UDC_HAS_HOSTPC
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
> Comparing to
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Def15e5490edc7edf808d3477ab32e0e320792f65,
>
> Can we please keep similar logic ?
> Having both:
> - bool setaddr
> - u8 address
>
> This way, we keep the diff with the linux driver a bit lower.
>
> >  };
> >
> >  struct ept_queue_head {
> > --
> > 2.43.0
