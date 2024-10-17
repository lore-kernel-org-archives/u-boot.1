Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018C2D37487
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 13:02:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6401688E32;
	Thu, 17 Oct 2024 15:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KTPpZkaM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC0188ECE; Thu, 17 Oct 2024 15:02:44 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 564D588E32
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 15:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4315c1c7392so5219555e9.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 06:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729170160; x=1729774960; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqb3KNoYqC0xMYZc4SYoxWs4YvpfQzDLu7tT+zO/3q8=;
 b=KTPpZkaM2oVj1/TPKFN8UyE+Y2RsLi74/Kdxz3kJVlsOV5YEEjZYt1LdX0a4YvEkyH
 Z763chJPg5e0TeNi/6QO6wZSdmUxKfrOD8Xj+DIkq4EepD5by2f0D3s8yOjWOUX/ql8f
 vsRFhNwWpd3CVHVNUy0oibXG7P6yDVG4E2TnGxKASdAcNOsIPvkj1eAztT4RY3eu0ICm
 S/Xio7Awmd28gzXnoBsHu1ccIHHBed7SpYSyWY5pRmzTwssP80e6DG+cQajdVP8wQtqi
 o15xoFPfmSmy1bAskuD0pffosf/XlXfi5tTsSiBR24+0RBu4ifDYgYx8jk2A8y7M2dUM
 Jubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729170160; x=1729774960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aqb3KNoYqC0xMYZc4SYoxWs4YvpfQzDLu7tT+zO/3q8=;
 b=O2VmQq5KUfXzxVt5kgZ0dpcIqF04dsxVQSj711t54/2Vku1NFfYGAb/Oa2to8O0l2U
 Zb002AI+7YbHCmIOpcHjOF9N5a/OyTAlhJNFB8d3L3yewEgsOdLuv+TBub/bMYfUrjmD
 jDk2gly9cx7z2YObiY0d57ZhrxroWvgMyG+x2UyZ8l5iAHw6Qicd5F3/lozqHMOdrI8A
 YyKDhzuaNKXxUKiijyAHgT1djR4QBNn5xOB1z8yPqBsZgKq43uyxkl6PeagNVVzlblhX
 HdS8pPDsF7oIb7n7kEf/dqSkTMOF001SXB85oYH49x7Hlff4jQdoQbqoEc/03/8T2GR/
 eQYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdMIheYkOOwYN/xkUtQtRlgn+vcUXlhtIrwkOT0MS689azZ7/k6/HUA9dzgMQLc4pWU2a9GOI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw78pLX6IkN+2FcSVPvL/R9ebrPDoR+hR9OZwPgInXnTEiWCmTH
 escSEkp0TIC4oXc9iFhRBWzacZlUCs9zkgQMUxwfQ/HdKBoX+De+OKi0XbpLU7GyO5sr28cD89s
 nfuS9XYz0zOsK0XacoTc7gf4EIB8=
X-Google-Smtp-Source: AGHT+IEDcdTlhCrh8QgvlriCJHilDhndGggkT9b7TTUP/rztEU8j5WkHbLMy9Ce4TNWpJ0y9d1rdmpV8gKF1CvrYsTU=
X-Received: by 2002:a05:600c:4f07:b0:426:6308:e2f0 with SMTP id
 5b1f17b1804b1-4312560975amr153955725e9.26.1729170158746; Thu, 17 Oct 2024
 06:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241013145820.85426-1-clamor95@gmail.com>
 <20241013145820.85426-2-clamor95@gmail.com>
 <87sesxzo2o.fsf@baylibre.com>
 <CAACy2-ai7EhrG0iwqnoQbpyzokb=-aEDPtQuiSv6nmF35qUJ_Q@mail.gmail.com>
 <87sesu2a3m.fsf@baylibre.com>
In-Reply-To: <87sesu2a3m.fsf@baylibre.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 17 Oct 2024 16:02:27 +0300
Message-ID: <CAPVz0n1-gWBsHWEkNfrynNrPXc84YrsksLj_KDJgJVcRQJnQEg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usb: ci_udc: don't use "advance" feature when
 setting address
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Ion Agorria <ionpl9@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, 
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

=D1=87=D1=82, 17 =D0=B6=D0=BE=D0=B2=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 15:2=
1 Mattijs Korpershoek
<mkorpershoek@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi,
>
> On mer., oct. 16, 2024 at 21:57, Ion Agorria <ionpl9@gmail.com> wrote:
>
> > Hello,
> >
> > Yes that's the correct commit I found when researching why the issue
> > didn't happen in Linux, I already found that Tegra 2 reference docs
> > had a different information about the register compared to Tegra 3.
> >
> > I consider that a single variable is enough since the value is only
> > non-zero when we want to set a new address. But if is necessary i can
> > copy like Linux does.
>
> You are right, a single variable is enough. I'd still prefer to have
> what Linux does because it will make it easier to compare with the Linux
> driver in the future,
>

Hello!

Proposed patch already does what Linux changes do. Your request to
make it "same" as Linux is impossible to achieve since the u-boot
driver itself does not descend from Linux, nor it is similar to Linux
one. There is nothing to compare with Linux in the future.

Best regards,
Svyatoslav R.

> Thanks
> Mattijs
>
> >
> > Regards,
> > Ion Agorria
> >
> > El mar, 15 oct 2024 a las 11:56, Mattijs Korpershoek
> > (<mkorpershoek@baylibre.com>) escribi=C3=B3:
> >>
> >> Hi Svyatoslav,
> >>
> >> Thank you for the patch.
> >>
> >> On dim., oct. 13, 2024 at 17:58, Svyatoslav Ryhel <clamor95@gmail.com>=
 wrote:
> >>
> >> > From: Ion Agorria <ion@agorria.com>
> >> >
> >> > In the older USB controllers like for example in ChipIdea controller
> >> > used by the Tegra 2 the "USBADRA: Device Address Advance" bitflag
> >> > does not exist, so the new device address set during SET_ADDRESS
> >> > can't be deferred by hardware, which causes the host to not recogniz=
e
> >> > the device and give an error.
> >> >
> >> > Instead store it until ep completes to apply the change into the hw
> >> > register as Linux kernel does. This should fix regression on old and
> >> > and be compatible with newer controllers.
> >>
> >> Since this is based on a linux commit, can we please mention the
> >> revision in the commit message?
> >>
> >> Per my understanding, this would be:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Def15e5490edc7edf808d3477ab32e0e320792f65
> >>
> >> >
> >> > Signed-off-by: Ion Agorria <ion@agorria.com>
> >> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >> > ---
> >> >  drivers/usb/gadget/ci_udc.c | 24 +++++++++++++++++++++++-
> >> >  drivers/usb/gadget/ci_udc.h |  1 +
> >> >  2 files changed, 24 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc=
.c
> >> > index bbe03cfff1f..4bff75da759 100644
> >> > --- a/drivers/usb/gadget/ci_udc.c
> >> > +++ b/drivers/usb/gadget/ci_udc.c
> >> > @@ -649,12 +649,30 @@ static void flip_ep0_direction(void)
> >> >       }
> >> >  }
> >> >
> >> > +/*
> >> > + * This function explicitly sets the address, without the "USBADRA"=
 (advance)
> >> > + * feature, which is not supported by older versions of the control=
ler.
> >> > + */
> >> > +static void ci_set_address(struct ci_udc *udc, u8 address)
> >> > +{
> >> > +     DBG("%s %x\n", __func__, address);
> >> > +     writel(address << 25, &udc->devaddr);
> >> > +}
> >> > +
> >> >  static void handle_ep_complete(struct ci_ep *ci_ep)
> >> >  {
> >> >       struct ept_queue_item *item, *next_td;
> >> >       int num, in, len, j;
> >> >       struct ci_req *ci_req;
> >> >
> >> > +     /* Set the device address that was previously sent by SET_ADDR=
ESS */
> >> > +     if (controller.next_device_address !=3D 0) {
> >> > +             struct ci_udc *udc =3D (struct ci_udc *)controller.ctr=
l->hcor;
> >> > +
> >> > +             ci_set_address(udc, controller.next_device_address);
> >> > +             controller.next_device_address =3D 0;
> >> > +     }
> >> > +
> >> >       num =3D ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MA=
SK;
> >> >       in =3D (ci_ep->desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
> >> >       item =3D ci_get_qtd(num, in);
> >> > @@ -783,7 +801,7 @@ static void handle_setup(void)
> >> >                * write address delayed (will take effect
> >> >                * after the next IN txn)
> >> >                */
> >> > -             writel((r.wValue << 25) | (1 << 24), &udc->devaddr);
> >> > +             controller.next_device_address =3D r.wValue;
> >> >               req->length =3D 0;
> >> >               usb_ep_queue(controller.gadget.ep0, req, 0);
> >> >               return;
> >> > @@ -814,6 +832,9 @@ static void stop_activity(void)
> >> >       int i, num, in;
> >> >       struct ept_queue_head *head;
> >> >       struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
> >> > +
> >> > +     ci_set_address(udc, 0);
> >> > +
> >> >       writel(readl(&udc->epcomp), &udc->epcomp);
> >> >  #ifdef CONFIG_CI_UDC_HAS_HOSTPC
> >> >       writel(readl(&udc->epsetupstat), &udc->epsetupstat);
> >> > @@ -934,6 +955,7 @@ static int ci_pullup(struct usb_gadget *gadget, =
int is_on)
> >> >       struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
> >> >       if (is_on) {
> >> >               /* RESET */
> >> > +             controller.next_device_address =3D 0;
> >> >               writel(USBCMD_ITC(MICRO_8FRAME) | USBCMD_RST, &udc->us=
bcmd);
> >> >               udelay(200);
> >> >
> >> > diff --git a/drivers/usb/gadget/ci_udc.h b/drivers/usb/gadget/ci_udc=
.h
> >> > index bea2f9f3fe3..807f2084c1e 100644
> >> > --- a/drivers/usb/gadget/ci_udc.h
> >> > +++ b/drivers/usb/gadget/ci_udc.h
> >> > @@ -105,6 +105,7 @@ struct ci_drv {
> >> >       struct ept_queue_head           *epts;
> >> >       uint8_t                         *items_mem;
> >> >       struct ci_ep                    ep[NUM_ENDPOINTS];
> >> > +     u8                              next_device_address;
> >>
> >> Comparing to
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3Def15e5490edc7edf808d3477ab32e0e320792f65,
> >>
> >> Can we please keep similar logic ?
> >> Having both:
> >> - bool setaddr
> >> - u8 address
> >>
> >> This way, we keep the diff with the linux driver a bit lower.
> >>
> >> >  };
> >> >
> >> >  struct ept_queue_head {
> >> > --
> >> > 2.43.0
