Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE150D37485
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 13:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 420CE88D5B;
	Thu, 17 Oct 2024 15:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WjpDPQPj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 996BE88FEC; Thu, 17 Oct 2024 15:13:51 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F4D388D61
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 15:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-431137d12a5so9893605e9.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 06:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729170826; x=1729775626;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vLACjzKGa1XF4zInhjnzt/qJivqif9NQt6KnG5yxb4M=;
 b=WjpDPQPj52VQjVtFzOW2P69H1wrZhWh/aOv2jPFN/hvk5SXbRjvhm/cjEf+V7DmDxg
 VdZ8577O7tfBzmf+iFWotzNA4wkvejNV6ngaoUDP1sqtcT5qXW8f2O3KCdbiPBt2JXVn
 t5tI0e7hy5y2A59hBHWD2y/glOzftI17lcDc+wHZkPd4QLgfGwCEdWdhi31GmiHnytR3
 xRh9WmI/VR0PYLqEGnKtsETM+VKwTAY582KcVyAU4XV0+hAVGe4pi8qMPuEui/RW2fFQ
 2U2G8JW74Y0xypo/HVOx2QF48hQCRpMHgftT7F0ibBLGUhrIAaJZBjsv1g94X8KLVHm0
 6n2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729170826; x=1729775626;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLACjzKGa1XF4zInhjnzt/qJivqif9NQt6KnG5yxb4M=;
 b=IohA2ZPWgzDCxrRgY+ScyOm8/P13L9AEPf/KNzeYBEjOG0ILmd4nOn3d4YXcFf758R
 xXKQlxAM2CWndsC1Lef3VU+RJarwOIT0izJZNaww/DpsvAD1JmC6sFO55cE/rzhU2Ow9
 4X8Qv09mf89/CuaGl36CQcSyYehiWYTYDTykH3Z++6g82j8vI5FwD6bd+UpuVyjzJ6kI
 qUhb0oAmSTkOK7oulFjIQu5zvyxISbeKUu0p49XIzc3DIzC61nqeN/Mgs4V2kN2o9ihD
 1Y1U/ejf4zsIL4l1PpnD8nIZFnswrS9QW92200SdD7mzaT4uN9a72SWfN9x9PXb9Xbm2
 u2PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpiX2+1I1tlid+1g6z4kbRvmOMr96IfuRlr/UyPo83gsAGpesalsvgTYLYBjHeAtTjTPTzmuU=@lists.denx.de
X-Gm-Message-State: AOJu0YwJIWp+FXKLnSbd0im+gP/9ZDFfTsI2tA7HMGdPhl4HLputq6ah
 c+Qmq+6EM8MWLoIoERUKjlZLwGrSBDof/6MvjPgsz/9hNvtucPhWgUe5bQBmLDo=
X-Google-Smtp-Source: AGHT+IFKTH7mCAjb5M0w6O5tArwyq5/mrkFVlRTNShuOfKLFVstKouTJzw6XvWm1GxrGQhBemvG5Kw==
X-Received: by 2002:a05:600c:4444:b0:426:66a2:b200 with SMTP id
 5b1f17b1804b1-4311ddfde29mr198414675e9.0.1729170826362; 
 Thu, 17 Oct 2024 06:13:46 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c617cesm25736365e9.41.2024.10.17.06.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 06:13:45 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Ion Agorria <ionpl9@gmail.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Simon Holesch
 <simon@holesch.de>, Ion Agorria <ion@agorria.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] usb: ci_udc: don't use "advance" feature when
 setting address
In-Reply-To: <CAPVz0n1-gWBsHWEkNfrynNrPXc84YrsksLj_KDJgJVcRQJnQEg@mail.gmail.com>
References: <20241013145820.85426-1-clamor95@gmail.com>
 <20241013145820.85426-2-clamor95@gmail.com> <87sesxzo2o.fsf@baylibre.com>
 <CAACy2-ai7EhrG0iwqnoQbpyzokb=-aEDPtQuiSv6nmF35qUJ_Q@mail.gmail.com>
 <87sesu2a3m.fsf@baylibre.com>
 <CAPVz0n1-gWBsHWEkNfrynNrPXc84YrsksLj_KDJgJVcRQJnQEg@mail.gmail.com>
Date: Thu, 17 Oct 2024 15:13:43 +0200
Message-ID: <87o73i27p4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On jeu., oct. 17, 2024 at 16:02, Svyatoslav Ryhel <clamor95@gmail.com> wrot=
e:

> =D1=87=D1=82, 17 =D0=B6=D0=BE=D0=B2=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 15=
:21 Mattijs Korpershoek
> <mkorpershoek@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>>
>> Hi,
>>
>> On mer., oct. 16, 2024 at 21:57, Ion Agorria <ionpl9@gmail.com> wrote:
>>
>> > Hello,
>> >
>> > Yes that's the correct commit I found when researching why the issue
>> > didn't happen in Linux, I already found that Tegra 2 reference docs
>> > had a different information about the register compared to Tegra 3.
>> >
>> > I consider that a single variable is enough since the value is only
>> > non-zero when we want to set a new address. But if is necessary i can
>> > copy like Linux does.
>>
>> You are right, a single variable is enough. I'd still prefer to have
>> what Linux does because it will make it easier to compare with the Linux
>> driver in the future,
>>
>
> Hello!
>
> Proposed patch already does what Linux changes do. Your request to
> make it "same" as Linux is impossible to achieve since the u-boot
> driver itself does not descend from Linux, nor it is similar to Linux
> one. There is nothing to compare with Linux in the future.

I'm not saying it should be a verbatim copy of the Linux driver.
I'm saying that keeping similar variable names can help
people comparing both.

Ion just send previously:

"""
Yes that's the correct commit I found when researching why the issue
didn't happen in Linux
"""

So clearly, comparison with the linux driver is valuable given that it
was done for **this very patch**.

>
> Best regards,
> Svyatoslav R.
>
>> Thanks
>> Mattijs
>>
>> >
>> > Regards,
>> > Ion Agorria
>> >
>> > El mar, 15 oct 2024 a las 11:56, Mattijs Korpershoek
>> > (<mkorpershoek@baylibre.com>) escribi=C3=B3:
>> >>
>> >> Hi Svyatoslav,
>> >>
>> >> Thank you for the patch.
>> >>
>> >> On dim., oct. 13, 2024 at 17:58, Svyatoslav Ryhel <clamor95@gmail.com=
> wrote:
>> >>
>> >> > From: Ion Agorria <ion@agorria.com>
>> >> >
>> >> > In the older USB controllers like for example in ChipIdea controller
>> >> > used by the Tegra 2 the "USBADRA: Device Address Advance" bitflag
>> >> > does not exist, so the new device address set during SET_ADDRESS
>> >> > can't be deferred by hardware, which causes the host to not recogni=
ze
>> >> > the device and give an error.
>> >> >
>> >> > Instead store it until ep completes to apply the change into the hw
>> >> > register as Linux kernel does. This should fix regression on old and
>> >> > and be compatible with newer controllers.
>> >>
>> >> Since this is based on a linux commit, can we please mention the
>> >> revision in the commit message?
>> >>
>> >> Per my understanding, this would be:
>> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Def15e5490edc7edf808d3477ab32e0e320792f65
>> >>
>> >> >
>> >> > Signed-off-by: Ion Agorria <ion@agorria.com>
>> >> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>> >> > ---
>> >> >  drivers/usb/gadget/ci_udc.c | 24 +++++++++++++++++++++++-
>> >> >  drivers/usb/gadget/ci_udc.h |  1 +
>> >> >  2 files changed, 24 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_ud=
c.c
>> >> > index bbe03cfff1f..4bff75da759 100644
>> >> > --- a/drivers/usb/gadget/ci_udc.c
>> >> > +++ b/drivers/usb/gadget/ci_udc.c
>> >> > @@ -649,12 +649,30 @@ static void flip_ep0_direction(void)
>> >> >       }
>> >> >  }
>> >> >
>> >> > +/*
>> >> > + * This function explicitly sets the address, without the "USBADRA=
" (advance)
>> >> > + * feature, which is not supported by older versions of the contro=
ller.
>> >> > + */
>> >> > +static void ci_set_address(struct ci_udc *udc, u8 address)
>> >> > +{
>> >> > +     DBG("%s %x\n", __func__, address);
>> >> > +     writel(address << 25, &udc->devaddr);
>> >> > +}
>> >> > +
>> >> >  static void handle_ep_complete(struct ci_ep *ci_ep)
>> >> >  {
>> >> >       struct ept_queue_item *item, *next_td;
>> >> >       int num, in, len, j;
>> >> >       struct ci_req *ci_req;
>> >> >
>> >> > +     /* Set the device address that was previously sent by SET_ADD=
RESS */
>> >> > +     if (controller.next_device_address !=3D 0) {
>> >> > +             struct ci_udc *udc =3D (struct ci_udc *)controller.ct=
rl->hcor;
>> >> > +
>> >> > +             ci_set_address(udc, controller.next_device_address);
>> >> > +             controller.next_device_address =3D 0;
>> >> > +     }
>> >> > +
>> >> >       num =3D ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_M=
ASK;
>> >> >       in =3D (ci_ep->desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
>> >> >       item =3D ci_get_qtd(num, in);
>> >> > @@ -783,7 +801,7 @@ static void handle_setup(void)
>> >> >                * write address delayed (will take effect
>> >> >                * after the next IN txn)
>> >> >                */
>> >> > -             writel((r.wValue << 25) | (1 << 24), &udc->devaddr);
>> >> > +             controller.next_device_address =3D r.wValue;
>> >> >               req->length =3D 0;
>> >> >               usb_ep_queue(controller.gadget.ep0, req, 0);
>> >> >               return;
>> >> > @@ -814,6 +832,9 @@ static void stop_activity(void)
>> >> >       int i, num, in;
>> >> >       struct ept_queue_head *head;
>> >> >       struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
>> >> > +
>> >> > +     ci_set_address(udc, 0);
>> >> > +
>> >> >       writel(readl(&udc->epcomp), &udc->epcomp);
>> >> >  #ifdef CONFIG_CI_UDC_HAS_HOSTPC
>> >> >       writel(readl(&udc->epsetupstat), &udc->epsetupstat);
>> >> > @@ -934,6 +955,7 @@ static int ci_pullup(struct usb_gadget *gadget,=
 int is_on)
>> >> >       struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
>> >> >       if (is_on) {
>> >> >               /* RESET */
>> >> > +             controller.next_device_address =3D 0;
>> >> >               writel(USBCMD_ITC(MICRO_8FRAME) | USBCMD_RST, &udc->u=
sbcmd);
>> >> >               udelay(200);
>> >> >
>> >> > diff --git a/drivers/usb/gadget/ci_udc.h b/drivers/usb/gadget/ci_ud=
c.h
>> >> > index bea2f9f3fe3..807f2084c1e 100644
>> >> > --- a/drivers/usb/gadget/ci_udc.h
>> >> > +++ b/drivers/usb/gadget/ci_udc.h
>> >> > @@ -105,6 +105,7 @@ struct ci_drv {
>> >> >       struct ept_queue_head           *epts;
>> >> >       uint8_t                         *items_mem;
>> >> >       struct ci_ep                    ep[NUM_ENDPOINTS];
>> >> > +     u8                              next_device_address;
>> >>
>> >> Comparing to
>> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Def15e5490edc7edf808d3477ab32e0e320792f65,
>> >>
>> >> Can we please keep similar logic ?
>> >> Having both:
>> >> - bool setaddr
>> >> - u8 address
>> >>
>> >> This way, we keep the diff with the linux driver a bit lower.
>> >>
>> >> >  };
>> >> >
>> >> >  struct ept_queue_head {
>> >> > --
>> >> > 2.43.0
