Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41103D30000
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 12:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C85FD89110;
	Fri, 18 Oct 2024 14:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mf7N3aDp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5702A891E3; Fri, 18 Oct 2024 08:52:33 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 390C689254
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 08:52:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ionpl9@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c96b2a10e1so2074243a12.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 23:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729234349; x=1729839149; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SeYqujjQKwL7b8z/v/+RJbqRtLpejZGGhOkpVO5UvlI=;
 b=mf7N3aDp6YR6u6d31cop2Hiun/+WfRphMxu6rpT8yq/1bu7B21vJOv2wytgKi2CQ8Y
 ewX8pvq1NFmOZghR+clOlOfU93nb57UFlqCwpfr+F3U8Qp+zX/inSmls+xO5z+VjEP0H
 gJP+r3ef9i4vcU7vwHSbQQPiUe4P5PvNPwCNAxR6R1+BFxfGa0LjqKvLpQlsRwhD3kd9
 onfEybdWlQ3zN6bEujwH0ry+BITRp/sKli7q5gm006eTX4MH4wyzvGN7Rp1Qc9rz3RdN
 qGYH8UGMctf1gmapowAt0UCY2/t7J+IpH60Fk5DRA9rI1P9o30bXIXdKebYTb/mV0zjv
 hh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729234349; x=1729839149;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SeYqujjQKwL7b8z/v/+RJbqRtLpejZGGhOkpVO5UvlI=;
 b=FVmTbGomA3Y6ceGlHTLOvZTxpI/IkR/QqepJ2SFMxNre8s8DlsuIhxUckZjfsJH7ST
 j3lQGPugVjoKn8ESYJV5lc3veKhwKUE5x44DCTaLz5KzqBCrfdsQou/4QyMq2qZZbdYF
 n+LolSo01orFSkhTjEIo+rPzlCwVqbUYRSsbkXOn22Z0SMzt/I5so4BFas9399PNoq7g
 HbnwXvSxpeOJguHJWaFmaN+VfEGLGHfyz51LyMFyU5ejg95vI8S8cPSQ2d+eyI/JJKDt
 2iiJfEY5QyupCF3URkYKMFXFpRaaLGh0P5CxQOdA9c1n3z+ITQkwYr7kCTaGIAxMiQv8
 VZLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnRXfVXn1tiHz9+kkF6KV7wt7UbUJKolgUAUjw5NIB4t+C67SzG8yQdCTs+gRAu4ITeGfSKIc=@lists.denx.de
X-Gm-Message-State: AOJu0YzS9ZYYP4BbZqIpPgMvogPUv9UPEHKPOtPaI8GzW9D56zQPxOyu
 TH1rS7AEHSWvZ6Ld+EPYU7JXcsAPQ8+Rq5zpOtt8xbA0AJw0bGHIb14iP/PMoORGe3foZuFtv0i
 +A87GQIqjng6jaPuAftXbO7G8bRg=
X-Google-Smtp-Source: AGHT+IG+sikS264LSxwnwrZxe+MhE/tn0D0dfm1t0TvQHgjSrkr6xRrxaTkZOcgGsVZvB+SOA2HRUGTx7Rn+h1fb3jI=
X-Received: by 2002:a05:6402:26cc:b0:5c9:893e:30d2 with SMTP id
 4fb4d7f45d1cf-5ca0ac50df1mr1326587a12.8.1729234348263; Thu, 17 Oct 2024
 23:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241013145820.85426-1-clamor95@gmail.com>
 <20241013145820.85426-2-clamor95@gmail.com>
 <87sesxzo2o.fsf@baylibre.com>
 <CAACy2-ai7EhrG0iwqnoQbpyzokb=-aEDPtQuiSv6nmF35qUJ_Q@mail.gmail.com>
 <87sesu2a3m.fsf@baylibre.com>
 <CAPVz0n1-gWBsHWEkNfrynNrPXc84YrsksLj_KDJgJVcRQJnQEg@mail.gmail.com>
 <87o73i27p4.fsf@baylibre.com>
In-Reply-To: <87o73i27p4.fsf@baylibre.com>
From: Ion Agorria <ionpl9@gmail.com>
Date: Fri, 18 Oct 2024 08:52:15 +0200
Message-ID: <CAACy2-YLnkyJWO_L6yhyW1KUNVpkKzpbq2xOqUtfJF8AkxBRNQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usb: ci_udc: don't use "advance" feature when
 setting address
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Simon Holesch <simon@holesch.de>,
 Ion Agorria <ion@agorria.com>, u-boot@lists.denx.de
X-Mailman-Approved-At: Fri, 18 Oct 2024 14:32:49 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

I already finished the fix before looking up and only moved the set address
function outside as a func after seeing the linux version.

I think drivers are different enough so there isnt much to compare.

Regards,
Ion

On Thu, 17 Oct 2024, 15:13 Mattijs Korpershoek, <mkorpershoek@baylibre.com>
wrote:

> On jeu., oct. 17, 2024 at 16:02, Svyatoslav Ryhel <clamor95@gmail.com>
> wrote:
>
> > =D1=87=D1=82, 17 =D0=B6=D0=BE=D0=B2=D1=82. 2024=E2=80=AF=D1=80. =D0=BE =
15:21 Mattijs Korpershoek
> > <mkorpershoek@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> Hi,
> >>
> >> On mer., oct. 16, 2024 at 21:57, Ion Agorria <ionpl9@gmail.com> wrote:
> >>
> >> > Hello,
> >> >
> >> > Yes that's the correct commit I found when researching why the issue
> >> > didn't happen in Linux, I already found that Tegra 2 reference docs
> >> > had a different information about the register compared to Tegra 3.
> >> >
> >> > I consider that a single variable is enough since the value is only
> >> > non-zero when we want to set a new address. But if is necessary i ca=
n
> >> > copy like Linux does.
> >>
> >> You are right, a single variable is enough. I'd still prefer to have
> >> what Linux does because it will make it easier to compare with the Lin=
ux
> >> driver in the future,
> >>
> >
> > Hello!
> >
> > Proposed patch already does what Linux changes do. Your request to
> > make it "same" as Linux is impossible to achieve since the u-boot
> > driver itself does not descend from Linux, nor it is similar to Linux
> > one. There is nothing to compare with Linux in the future.
>
> I'm not saying it should be a verbatim copy of the Linux driver.
> I'm saying that keeping similar variable names can help
> people comparing both.
>
> Ion just send previously:
>
> """
> Yes that's the correct commit I found when researching why the issue
> didn't happen in Linux
> """
>
> So clearly, comparison with the linux driver is valuable given that it
> was done for **this very patch**.
>
> >
> > Best regards,
> > Svyatoslav R.
> >
> >> Thanks
> >> Mattijs
> >>
> >> >
> >> > Regards,
> >> > Ion Agorria
> >> >
> >> > El mar, 15 oct 2024 a las 11:56, Mattijs Korpershoek
> >> > (<mkorpershoek@baylibre.com>) escribi=C3=B3:
> >> >>
> >> >> Hi Svyatoslav,
> >> >>
> >> >> Thank you for the patch.
> >> >>
> >> >> On dim., oct. 13, 2024 at 17:58, Svyatoslav Ryhel <
> clamor95@gmail.com> wrote:
> >> >>
> >> >> > From: Ion Agorria <ion@agorria.com>
> >> >> >
> >> >> > In the older USB controllers like for example in ChipIdea
> controller
> >> >> > used by the Tegra 2 the "USBADRA: Device Address Advance" bitflag
> >> >> > does not exist, so the new device address set during SET_ADDRESS
> >> >> > can't be deferred by hardware, which causes the host to not
> recognize
> >> >> > the device and give an error.
> >> >> >
> >> >> > Instead store it until ep completes to apply the change into the =
hw
> >> >> > register as Linux kernel does. This should fix regression on old
> and
> >> >> > and be compatible with newer controllers.
> >> >>
> >> >> Since this is based on a linux commit, can we please mention the
> >> >> revision in the commit message?
> >> >>
> >> >> Per my understanding, this would be:
> >> >>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Def15e5490edc7edf808d3477ab32e0e320792f65
> >> >>
> >> >> >
> >> >> > Signed-off-by: Ion Agorria <ion@agorria.com>
> >> >> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> >> > ---
> >> >> >  drivers/usb/gadget/ci_udc.c | 24 +++++++++++++++++++++++-
> >> >> >  drivers/usb/gadget/ci_udc.h |  1 +
> >> >> >  2 files changed, 24 insertions(+), 1 deletion(-)
> >> >> >
> >> >> > diff --git a/drivers/usb/gadget/ci_udc.c
> b/drivers/usb/gadget/ci_udc.c
> >> >> > index bbe03cfff1f..4bff75da759 100644
> >> >> > --- a/drivers/usb/gadget/ci_udc.c
> >> >> > +++ b/drivers/usb/gadget/ci_udc.c
> >> >> > @@ -649,12 +649,30 @@ static void flip_ep0_direction(void)
> >> >> >       }
> >> >> >  }
> >> >> >
> >> >> > +/*
> >> >> > + * This function explicitly sets the address, without the
> "USBADRA" (advance)
> >> >> > + * feature, which is not supported by older versions of the
> controller.
> >> >> > + */
> >> >> > +static void ci_set_address(struct ci_udc *udc, u8 address)
> >> >> > +{
> >> >> > +     DBG("%s %x\n", __func__, address);
> >> >> > +     writel(address << 25, &udc->devaddr);
> >> >> > +}
> >> >> > +
> >> >> >  static void handle_ep_complete(struct ci_ep *ci_ep)
> >> >> >  {
> >> >> >       struct ept_queue_item *item, *next_td;
> >> >> >       int num, in, len, j;
> >> >> >       struct ci_req *ci_req;
> >> >> >
> >> >> > +     /* Set the device address that was previously sent by
> SET_ADDRESS */
> >> >> > +     if (controller.next_device_address !=3D 0) {
> >> >> > +             struct ci_udc *udc =3D (struct ci_udc
> *)controller.ctrl->hcor;
> >> >> > +
> >> >> > +             ci_set_address(udc, controller.next_device_address)=
;
> >> >> > +             controller.next_device_address =3D 0;
> >> >> > +     }
> >> >> > +
> >> >> >       num =3D ci_ep->desc->bEndpointAddress &
> USB_ENDPOINT_NUMBER_MASK;
> >> >> >       in =3D (ci_ep->desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
> >> >> >       item =3D ci_get_qtd(num, in);
> >> >> > @@ -783,7 +801,7 @@ static void handle_setup(void)
> >> >> >                * write address delayed (will take effect
> >> >> >                * after the next IN txn)
> >> >> >                */
> >> >> > -             writel((r.wValue << 25) | (1 << 24), &udc->devaddr)=
;
> >> >> > +             controller.next_device_address =3D r.wValue;
> >> >> >               req->length =3D 0;
> >> >> >               usb_ep_queue(controller.gadget.ep0, req, 0);
> >> >> >               return;
> >> >> > @@ -814,6 +832,9 @@ static void stop_activity(void)
> >> >> >       int i, num, in;
> >> >> >       struct ept_queue_head *head;
> >> >> >       struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hc=
or;
> >> >> > +
> >> >> > +     ci_set_address(udc, 0);
> >> >> > +
> >> >> >       writel(readl(&udc->epcomp), &udc->epcomp);
> >> >> >  #ifdef CONFIG_CI_UDC_HAS_HOSTPC
> >> >> >       writel(readl(&udc->epsetupstat), &udc->epsetupstat);
> >> >> > @@ -934,6 +955,7 @@ static int ci_pullup(struct usb_gadget
> *gadget, int is_on)
> >> >> >       struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hc=
or;
> >> >> >       if (is_on) {
> >> >> >               /* RESET */
> >> >> > +             controller.next_device_address =3D 0;
> >> >> >               writel(USBCMD_ITC(MICRO_8FRAME) | USBCMD_RST,
> &udc->usbcmd);
> >> >> >               udelay(200);
> >> >> >
> >> >> > diff --git a/drivers/usb/gadget/ci_udc.h
> b/drivers/usb/gadget/ci_udc.h
> >> >> > index bea2f9f3fe3..807f2084c1e 100644
> >> >> > --- a/drivers/usb/gadget/ci_udc.h
> >> >> > +++ b/drivers/usb/gadget/ci_udc.h
> >> >> > @@ -105,6 +105,7 @@ struct ci_drv {
> >> >> >       struct ept_queue_head           *epts;
> >> >> >       uint8_t                         *items_mem;
> >> >> >       struct ci_ep                    ep[NUM_ENDPOINTS];
> >> >> > +     u8                              next_device_address;
> >> >>
> >> >> Comparing to
> >> >>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Def15e5490edc7edf808d3477ab32e0e320792f65
> ,
> >> >>
> >> >> Can we please keep similar logic ?
> >> >> Having both:
> >> >> - bool setaddr
> >> >> - u8 address
> >> >>
> >> >> This way, we keep the diff with the linux driver a bit lower.
> >> >>
> >> >> >  };
> >> >> >
> >> >> >  struct ept_queue_head {
> >> >> > --
> >> >> > 2.43.0
>
