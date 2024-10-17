Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6192ED37482
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 12:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 962DB88FF1;
	Thu, 17 Oct 2024 14:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oC333WCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9053B88FE8; Thu, 17 Oct 2024 14:21:56 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 240DA88E5C
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 14:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37d47b38336so636174f8f.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 05:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729167711; x=1729772511;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iWODicsPgkG/1MzpX4O2YcAemu3JPenryhJCvsx6BTc=;
 b=oC333WCR5/OTkE9PI9kzL2G57GRwUW2yfz1OX5cLGr+PdeHYB6povtYRV1A0jaA+Tc
 m1KY/GyAUxHq7QkUHKmVPNmXLkSRhauLGlvICW47HymkqW4bBYF8Eh+/e5iwRPDxSqq3
 sXvkQnyWLgRG1X5QsVHsGw4f2JSDX0qCPXDOCLr/H0TANAZrjlAJzDyyNhWDrcXb4Y+q
 mmhh9RJfWHDmgk/8gTnLeRFRxaFzK7YcZQAY0QMjjnFx1ODx3Cdn3zVbsn5bTVqkOq4r
 3H4K8qbE5QlOXDkTOnEsWXSKkIi3lFM9W/phjBBBjmjl+JjC3alvkiXdxAsfNeuKXZ9f
 lDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729167711; x=1729772511;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iWODicsPgkG/1MzpX4O2YcAemu3JPenryhJCvsx6BTc=;
 b=NV4syioK0c+NGMqPDYnM1EsRQvuBExoo80c4hAwLFS63lJvpm2asyR8+808ZB4mzOK
 t8G8Y935NK1CJ3Py10a33+j2tRUi0Fi28+4PFgdkVdU9fLQPKfPEHvzG0W9hBRWMRz2L
 5s8QSBaPk7GM0pMuoR7LNzCyCaRig4y0FUmD+EhBOH09THmifzNsuTKarCHP60GH+Prv
 jNc01GWbtb7HetStYtYnJSS7e3P1AtT3At2EO4yHKDD4C51pmSrJVMadZCQI7AchDQyI
 XAbPKilSsrrEgVwZxWUXKKuLed7aDaUgnkM596Z6VxEhi/h5miv/dYcE+gqs3dSttEWs
 XbMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8QAvhj4ILC36fdfaDVk1QCHWSPGZU7Yjhkk95UBih+yfXYE5Bx2JWsrQByI2vTcjuKS9RXc8=@lists.denx.de
X-Gm-Message-State: AOJu0Yzis1L29zLGTuM+QFaRfPbx7w+RNBK/r5nY+9sTB/mJzhq+YEds
 noTPVApeAdIFj6TY43R9fMkhcO977yTTuZ5zgswfoMRilYW8yABc06SvIAbutPI=
X-Google-Smtp-Source: AGHT+IFGjQtAr9eXBXVIsA+vy4eigt46aW3tO9ZP4xnD0Xz7RCtDkCzZcwZae/gxIb6mtaNce/mhog==
X-Received: by 2002:adf:f0d1:0:b0:37d:50e1:b3e1 with SMTP id
 ffacd0b85a97d-37d86bba588mr4465057f8f.16.1729167711434; 
 Thu, 17 Oct 2024 05:21:51 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c39cafsm24552935e9.16.2024.10.17.05.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 05:21:51 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Ion Agorria <ionpl9@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, Simon Holesch
 <simon@holesch.de>, Ion Agorria <ion@agorria.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] usb: ci_udc: don't use "advance" feature when
 setting address
In-Reply-To: <CAACy2-ai7EhrG0iwqnoQbpyzokb=-aEDPtQuiSv6nmF35qUJ_Q@mail.gmail.com>
References: <20241013145820.85426-1-clamor95@gmail.com>
 <20241013145820.85426-2-clamor95@gmail.com> <87sesxzo2o.fsf@baylibre.com>
 <CAACy2-ai7EhrG0iwqnoQbpyzokb=-aEDPtQuiSv6nmF35qUJ_Q@mail.gmail.com>
Date: Thu, 17 Oct 2024 14:21:49 +0200
Message-ID: <87sesu2a3m.fsf@baylibre.com>
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

Hi,

On mer., oct. 16, 2024 at 21:57, Ion Agorria <ionpl9@gmail.com> wrote:

> Hello,
>
> Yes that's the correct commit I found when researching why the issue
> didn't happen in Linux, I already found that Tegra 2 reference docs
> had a different information about the register compared to Tegra 3.
>
> I consider that a single variable is enough since the value is only
> non-zero when we want to set a new address. But if is necessary i can
> copy like Linux does.

You are right, a single variable is enough. I'd still prefer to have
what Linux does because it will make it easier to compare with the Linux
driver in the future,

Thanks
Mattijs

>
> Regards,
> Ion Agorria
>
> El mar, 15 oct 2024 a las 11:56, Mattijs Korpershoek
> (<mkorpershoek@baylibre.com>) escribi=C3=B3:
>>
>> Hi Svyatoslav,
>>
>> Thank you for the patch.
>>
>> On dim., oct. 13, 2024 at 17:58, Svyatoslav Ryhel <clamor95@gmail.com> w=
rote:
>>
>> > From: Ion Agorria <ion@agorria.com>
>> >
>> > In the older USB controllers like for example in ChipIdea controller
>> > used by the Tegra 2 the "USBADRA: Device Address Advance" bitflag
>> > does not exist, so the new device address set during SET_ADDRESS
>> > can't be deferred by hardware, which causes the host to not recognize
>> > the device and give an error.
>> >
>> > Instead store it until ep completes to apply the change into the hw
>> > register as Linux kernel does. This should fix regression on old and
>> > and be compatible with newer controllers.
>>
>> Since this is based on a linux commit, can we please mention the
>> revision in the commit message?
>>
>> Per my understanding, this would be:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3Def15e5490edc7edf808d3477ab32e0e320792f65
>>
>> >
>> > Signed-off-by: Ion Agorria <ion@agorria.com>
>> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>> > ---
>> >  drivers/usb/gadget/ci_udc.c | 24 +++++++++++++++++++++++-
>> >  drivers/usb/gadget/ci_udc.h |  1 +
>> >  2 files changed, 24 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
>> > index bbe03cfff1f..4bff75da759 100644
>> > --- a/drivers/usb/gadget/ci_udc.c
>> > +++ b/drivers/usb/gadget/ci_udc.c
>> > @@ -649,12 +649,30 @@ static void flip_ep0_direction(void)
>> >       }
>> >  }
>> >
>> > +/*
>> > + * This function explicitly sets the address, without the "USBADRA" (=
advance)
>> > + * feature, which is not supported by older versions of the controlle=
r.
>> > + */
>> > +static void ci_set_address(struct ci_udc *udc, u8 address)
>> > +{
>> > +     DBG("%s %x\n", __func__, address);
>> > +     writel(address << 25, &udc->devaddr);
>> > +}
>> > +
>> >  static void handle_ep_complete(struct ci_ep *ci_ep)
>> >  {
>> >       struct ept_queue_item *item, *next_td;
>> >       int num, in, len, j;
>> >       struct ci_req *ci_req;
>> >
>> > +     /* Set the device address that was previously sent by SET_ADDRES=
S */
>> > +     if (controller.next_device_address !=3D 0) {
>> > +             struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl-=
>hcor;
>> > +
>> > +             ci_set_address(udc, controller.next_device_address);
>> > +             controller.next_device_address =3D 0;
>> > +     }
>> > +
>> >       num =3D ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
>> >       in =3D (ci_ep->desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
>> >       item =3D ci_get_qtd(num, in);
>> > @@ -783,7 +801,7 @@ static void handle_setup(void)
>> >                * write address delayed (will take effect
>> >                * after the next IN txn)
>> >                */
>> > -             writel((r.wValue << 25) | (1 << 24), &udc->devaddr);
>> > +             controller.next_device_address =3D r.wValue;
>> >               req->length =3D 0;
>> >               usb_ep_queue(controller.gadget.ep0, req, 0);
>> >               return;
>> > @@ -814,6 +832,9 @@ static void stop_activity(void)
>> >       int i, num, in;
>> >       struct ept_queue_head *head;
>> >       struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
>> > +
>> > +     ci_set_address(udc, 0);
>> > +
>> >       writel(readl(&udc->epcomp), &udc->epcomp);
>> >  #ifdef CONFIG_CI_UDC_HAS_HOSTPC
>> >       writel(readl(&udc->epsetupstat), &udc->epsetupstat);
>> > @@ -934,6 +955,7 @@ static int ci_pullup(struct usb_gadget *gadget, in=
t is_on)
>> >       struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
>> >       if (is_on) {
>> >               /* RESET */
>> > +             controller.next_device_address =3D 0;
>> >               writel(USBCMD_ITC(MICRO_8FRAME) | USBCMD_RST, &udc->usbc=
md);
>> >               udelay(200);
>> >
>> > diff --git a/drivers/usb/gadget/ci_udc.h b/drivers/usb/gadget/ci_udc.h
>> > index bea2f9f3fe3..807f2084c1e 100644
>> > --- a/drivers/usb/gadget/ci_udc.h
>> > +++ b/drivers/usb/gadget/ci_udc.h
>> > @@ -105,6 +105,7 @@ struct ci_drv {
>> >       struct ept_queue_head           *epts;
>> >       uint8_t                         *items_mem;
>> >       struct ci_ep                    ep[NUM_ENDPOINTS];
>> > +     u8                              next_device_address;
>>
>> Comparing to
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3Def15e5490edc7edf808d3477ab32e0e320792f65,
>>
>> Can we please keep similar logic ?
>> Having both:
>> - bool setaddr
>> - u8 address
>>
>> This way, we keep the diff with the linux driver a bit lower.
>>
>> >  };
>> >
>> >  struct ept_queue_head {
>> > --
>> > 2.43.0
