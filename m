Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52801D6E2C9
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 06:46:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77BDD8962D;
	Wed, 20 Nov 2024 07:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RfbdBfT6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A44B89634; Wed, 20 Nov 2024 07:46:00 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76EA18962D
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 07:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-382411ea5eeso306303f8f.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 22:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732085158; x=1732689958; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTQV64BYMR8D8EWpBQRd/aD2J2LubMIUvyWvzoG5dvU=;
 b=RfbdBfT6tw+o1OcQHX8e9kpeQ8qI8SfcEAsIS2OqfQGiTSl1rIxIt/b4u/GqDsRl83
 UcbCtuiWdxg8VsQCI++0GMarXbAmmplMmoJ1nXk/xBZveahvOtFanh8w7U1yDtyPzfoy
 icIMnw0LJ6UNkLojdjev/oQQl6OLHVWfWuwNOJLULj84cOfm8L8uv/TKmgZdA6/arhjR
 m4GonuYOqU+q9WVUkDpg/wzFHKXwIdJOHRCfOo3K2xMG5KMRhJ4csV1kD0mfcaMtwbR0
 COJjYhJ7oJUQYqtlm/T1L3v3iro1qkJCpIkngSMW41eC70vLPJpiZPSqRXh23ghJ/wV1
 Y/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732085158; x=1732689958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vTQV64BYMR8D8EWpBQRd/aD2J2LubMIUvyWvzoG5dvU=;
 b=eV6DhUFul6j3CCfUT7A2k0IDhtWuU0QOKBDAGxfiPwXP9MqU667H9g9tMB/jxMq9aD
 tBhHu++GcmgPLZoMoSmCSBFtKMgc1F0TxJddkgyzqE29rAsjiY2vZ6KII3ehlk9izLQy
 ISmIgcqEhkOrcoQv+Ay0TqJg18UBGJJLgkg0HVCC6OqSf4vORuYFzVgI2hidO55hBb7T
 tIfvQM+qFEqj5mPmmj2Ei7nK27nuvUUWhAS9JpXiXKBPdnPCRFNUhyXR8XP/KXh8E1mf
 VbNw3DFnR9/zq6lPOxTdIl3cXVJjF7zpu3+NLzkarg+GPAvn8zBxpyuWOEl4nAxErcnr
 +zZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEu2BsfG4BXEFTcOUjFMDubZ6Sb8HDvL2EYAOxZYqAzHwosMcsPXauhGJKnUZJzI+gf49HGqY=@lists.denx.de
X-Gm-Message-State: AOJu0YwGkLCHyRkFjDS4p1q1ptgnsgk+7ebURxzK6f640zfwGhWYX/Pt
 EtiyatPIfbzsQC63idwhOwczEZLBSLiD0209Mg7vyMv01N3KJk8RgrvTJ0L1Y2v0XO0hdVzlrYu
 8sYFOkeR/9oMatnuMuA7b3AmkQiw=
X-Google-Smtp-Source: AGHT+IH/EsAjACtEnNGDQSxDOcRsfLv+AKV85IaLF77oZUrwzzpalIS4yhpUqBWuwkSKqh4meH9NMCDb3b3+MunIbZg=
X-Received: by 2002:a05:6000:1847:b0:382:4995:7a3e with SMTP id
 ffacd0b85a97d-382544ce4c4mr1285898f8f.16.1732085157705; Tue, 19 Nov 2024
 22:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20241013145820.85426-1-clamor95@gmail.com>
 <20241013145820.85426-2-clamor95@gmail.com>
 <6f3ce823-93e8-46b5-86f3-52038efc5271@denx.de>
 <CAPVz0n1dHC9VTgxgPmh=bUg1Ei1Wnamopbpjiyz81YxeFtfdWg@mail.gmail.com>
In-Reply-To: <CAPVz0n1dHC9VTgxgPmh=bUg1Ei1Wnamopbpjiyz81YxeFtfdWg@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 20 Nov 2024 08:45:46 +0200
Message-ID: <CAPVz0n1F043u8HNvmm-cU=oUjk17tR17Em+g2o+Z8idqq5NM4Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] usb: ci_udc: don't use "advance" feature when
 setting address
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Simon Holesch <simon@holesch.de>, Ion Agorria <ion@agorria.com>,
 u-boot@lists.denx.de
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

=D0=BD=D0=B4, 27 =D0=B6=D0=BE=D0=B2=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 18:4=
2 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> =D0=BD=D0=B4, 27 =D0=B6=D0=BE=D0=B2=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 18=
:09 Marek Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On 10/13/24 4:58 PM, Svyatoslav Ryhel wrote:
> >
> > Sorry for the late reply.
> >
> > > +++ b/drivers/usb/gadget/ci_udc.c
> > > @@ -649,12 +649,30 @@ static void flip_ep0_direction(void)
> > >       }
> > >   }
> > >
> > > +/*
> > > + * This function explicitly sets the address, without the "USBADRA" =
(advance)
> > > + * feature, which is not supported by older versions of the controll=
er.
> > > + */
> > > +static void ci_set_address(struct ci_udc *udc, u8 address)
> > > +{
> > > +     DBG("%s %x\n", __func__, address);
> >
> > log_debug() or dev_dbg() please.
> >
>
> DBG macro is used across entire driver, if you wish to replace it,
> then pls, send a followup with patch for entire driver. This is out of
> scope of this patch.
>
> > > +     writel(address << 25, &udc->devaddr);
> > > +}
> > > +
> > >   static void handle_ep_complete(struct ci_ep *ci_ep)
> > >   {
> > >       struct ept_queue_item *item, *next_td;
> > >       int num, in, len, j;
> > >       struct ci_req *ci_req;
> > >
> > > +     /* Set the device address that was previously sent by SET_ADDRE=
SS */
> > > +     if (controller.next_device_address !=3D 0) {
> > > +             struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl=
->hcor;
> > > +
> > > +             ci_set_address(udc, controller.next_device_address);
> > > +             controller.next_device_address =3D 0;
> > > +     }
> > > +
> > >       num =3D ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MAS=
K;
> > >       in =3D (ci_ep->desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
> > >       item =3D ci_get_qtd(num, in);
> > > @@ -783,7 +801,7 @@ static void handle_setup(void)
> > >                * write address delayed (will take effect
> > >                * after the next IN txn)
> > >                */
> > > -             writel((r.wValue << 25) | (1 << 24), &udc->devaddr);
> > > +             controller.next_device_address =3D r.wValue;
> >
> > wValue is word , u16 , but next_device_address is u8 below , why ?
> >
>
> wValue is u16 but only 8 bits are relevant since USB address is 8 bit,
> hence u8. Changing wValue to u8 is out of scope of this patch as well.
>
> > >               req->length =3D 0;
> > >               usb_ep_queue(controller.gadget.ep0, req, 0);
> > >               return;
> > > @@ -814,6 +832,9 @@ static void stop_activity(void)
> > >       int i, num, in;
> > >       struct ept_queue_head *head;
> > >       struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
> > > +
> > > +     ci_set_address(udc, 0);
> > > +
> > >       writel(readl(&udc->epcomp), &udc->epcomp);
> > >   #ifdef CONFIG_CI_UDC_HAS_HOSTPC
> > >       writel(readl(&udc->epsetupstat), &udc->epsetupstat);
> > > @@ -934,6 +955,7 @@ static int ci_pullup(struct usb_gadget *gadget, i=
nt is_on)
> > >       struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
> > >       if (is_on) {
> > >               /* RESET */
> > > +             controller.next_device_address =3D 0;
> > >               writel(USBCMD_ITC(MICRO_8FRAME) | USBCMD_RST, &udc->usb=
cmd);
> > >               udelay(200);
> > >
> > > diff --git a/drivers/usb/gadget/ci_udc.h b/drivers/usb/gadget/ci_udc.=
h
> > > index bea2f9f3fe3..807f2084c1e 100644
> > > --- a/drivers/usb/gadget/ci_udc.h
> > > +++ b/drivers/usb/gadget/ci_udc.h
> > > @@ -105,6 +105,7 @@ struct ci_drv {
> > >       struct ept_queue_head           *epts;
> > >       uint8_t                         *items_mem;
> > >       struct ci_ep                    ep[NUM_ENDPOINTS];
> > > +     u8                              next_device_address;
> >
> > Should this be u16 ?
>
> No, USB address is only 8bits (u8)

If no other comments were proposed, may this patch be applied?
