Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B94D6ED04
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 11:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4737B89715;
	Thu, 21 Nov 2024 12:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hJhn/MMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5099D89700; Thu, 21 Nov 2024 12:16:10 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A656889715
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 12:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-539eb97f26aso795359e87.2
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 03:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732187766; x=1732792566; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/cSg7vtOREmZkEXGp6OPNKKdqYYSA5YNYIxOPXB9IA=;
 b=hJhn/MMITqGqzWRssgg4yvbbepQyPgQbOYdrIY/PouFkPwGYpyy13yXxQTiFiNdFuf
 00hkCik8j1ubfn7KKggU7O7Fd7vlpo1rtOK1BPW24hgUU4mwYLvE6Mg5Iiecg9K4S26j
 BHfBFQirzcsAzFfBwMTRUJ9M4FaMrAvbuK6JZgBUxTmiODoZwKv6ySc0vhrZYMV4pi+w
 zsHHg8/spqx0cZL+nfI6OE7TPs00AUdJrQPgtseU7HUcOpjwbnpadxqGh6d+eOm7ck1U
 PqPFSTxxIWUgzYo7vkgMzCqg+TKJN0xJfbhWo7uaTZbZ37DbUzFGMjufYza0gNgaUWSP
 JIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732187766; x=1732792566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/cSg7vtOREmZkEXGp6OPNKKdqYYSA5YNYIxOPXB9IA=;
 b=NGUhGp65+I/n8VjCPLddjMrZu/Y7FeJgheD1GvrOaFo2S1isGFSSC7plfl/Hm+RsEK
 BJVCljASfqJpa+HuneROMsyfuFAqBbNeqAgw9jIW6Vo70g1cHzSWxj/F8VBGoB6dx8aw
 MdWn4RH1AeAkgQce6/cGeAXpxdLbVMUmv8Z4SyZMxV1WicDeqcPXCaW437NF1sz5Dg8N
 PV2UPoS8Zyua5eJkR8ZvQMpr4YptWKzQ7kLXNwdDJVyrcIGQqNmQrEPbiNgXPKRAVf+Y
 oSnN2wxhYtkuaKnhzsnJqePToMia5F2a3yS2lddeyXu85BmqN1pBT28pELZ+G72qVV64
 mIUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeoNg64NbD0xZ4u4XrqKcBceQQWwQxoKxjem/Vn+fGWbWbMTwNvAifFkZYmQg3DRQ9LPfpgA4=@lists.denx.de
X-Gm-Message-State: AOJu0Yxla/q1cs4GbDynMBrhbGBjbl823g6YgcWkv5DahRJz9WNd61Eq
 PDjoig7Aa/JY1Uy5YybJRCiFM0rreJijKpzt01RUdrfiN7c9muYshAOXoO1tLX3q7oJl5vjMqLC
 EtgZD6eCpILlQJH5H3V29bmOd192iQA==
X-Google-Smtp-Source: AGHT+IFwJFTm2/RGTAFEJpJqsidiuEFjd5OM60vqkBYiQhTtp0GSxD3/pQoL91fKTvfXHL1HzWqZfuxcNAZK+GesQlQ=
X-Received: by 2002:ac2:5f96:0:b0:53d:a9a6:1c16 with SMTP id
 2adb3069b0e04-53dc132c464mr2266989e87.10.1732187765528; Thu, 21 Nov 2024
 03:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20241013145820.85426-1-clamor95@gmail.com>
 <20241013145820.85426-2-clamor95@gmail.com>
 <6f3ce823-93e8-46b5-86f3-52038efc5271@denx.de>
 <CAPVz0n1dHC9VTgxgPmh=bUg1Ei1Wnamopbpjiyz81YxeFtfdWg@mail.gmail.com>
 <CAPVz0n1F043u8HNvmm-cU=oUjk17tR17Em+g2o+Z8idqq5NM4Q@mail.gmail.com>
 <87y11cltzg.fsf@baylibre.com>
In-Reply-To: <87y11cltzg.fsf@baylibre.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 21 Nov 2024 13:15:54 +0200
Message-ID: <CAPVz0n00AoaUV45kM__ADe=jA9XxqWzJiOP8UrOtaAG4TsCZtg@mail.gmail.com>
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

=D1=87=D1=82, 21 =D0=BB=D0=B8=D1=81=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 13:1=
4 Mattijs Korpershoek
<mkorpershoek@baylibre.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hello,
>
> On mer., nov. 20, 2024 at 08:45, Svyatoslav Ryhel <clamor95@gmail.com> wr=
ote:
>
> > =D0=BD=D0=B4, 27 =D0=B6=D0=BE=D0=B2=D1=82. 2024=E2=80=AF=D1=80. =D0=BE =
18:42 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> =D0=BD=D0=B4, 27 =D0=B6=D0=BE=D0=B2=D1=82. 2024=E2=80=AF=D1=80. =D0=BE=
 18:09 Marek Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
> >> >
> >> > On 10/13/24 4:58 PM, Svyatoslav Ryhel wrote:
> >> >
> >> > Sorry for the late reply.
> >> >
> >> > > +++ b/drivers/usb/gadget/ci_udc.c
> >> > > @@ -649,12 +649,30 @@ static void flip_ep0_direction(void)
> >> > >       }
> >> > >   }
> >> > >
> >> > > +/*
> >> > > + * This function explicitly sets the address, without the "USBADR=
A" (advance)
> >> > > + * feature, which is not supported by older versions of the contr=
oller.
> >> > > + */
> >> > > +static void ci_set_address(struct ci_udc *udc, u8 address)
> >> > > +{
> >> > > +     DBG("%s %x\n", __func__, address);
> >> >
> >> > log_debug() or dev_dbg() please.
> >> >
> >>
> >> DBG macro is used across entire driver, if you wish to replace it,
> >> then pls, send a followup with patch for entire driver. This is out of
> >> scope of this patch.
> >>
> >> > > +     writel(address << 25, &udc->devaddr);
> >> > > +}
> >> > > +
> >> > >   static void handle_ep_complete(struct ci_ep *ci_ep)
> >> > >   {
> >> > >       struct ept_queue_item *item, *next_td;
> >> > >       int num, in, len, j;
> >> > >       struct ci_req *ci_req;
> >> > >
> >> > > +     /* Set the device address that was previously sent by SET_AD=
DRESS */
> >> > > +     if (controller.next_device_address !=3D 0) {
> >> > > +             struct ci_udc *udc =3D (struct ci_udc *)controller.c=
trl->hcor;
> >> > > +
> >> > > +             ci_set_address(udc, controller.next_device_address);
> >> > > +             controller.next_device_address =3D 0;
> >> > > +     }
> >> > > +
> >> > >       num =3D ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_=
MASK;
> >> > >       in =3D (ci_ep->desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
> >> > >       item =3D ci_get_qtd(num, in);
> >> > > @@ -783,7 +801,7 @@ static void handle_setup(void)
> >> > >                * write address delayed (will take effect
> >> > >                * after the next IN txn)
> >> > >                */
> >> > > -             writel((r.wValue << 25) | (1 << 24), &udc->devaddr);
> >> > > +             controller.next_device_address =3D r.wValue;
> >> >
> >> > wValue is word , u16 , but next_device_address is u8 below , why ?
> >> >
> >>
> >> wValue is u16 but only 8 bits are relevant since USB address is 8 bit,
> >> hence u8. Changing wValue to u8 is out of scope of this patch as well.
> >>
> >> > >               req->length =3D 0;
> >> > >               usb_ep_queue(controller.gadget.ep0, req, 0);
> >> > >               return;
> >> > > @@ -814,6 +832,9 @@ static void stop_activity(void)
> >> > >       int i, num, in;
> >> > >       struct ept_queue_head *head;
> >> > >       struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hco=
r;
> >> > > +
> >> > > +     ci_set_address(udc, 0);
> >> > > +
> >> > >       writel(readl(&udc->epcomp), &udc->epcomp);
> >> > >   #ifdef CONFIG_CI_UDC_HAS_HOSTPC
> >> > >       writel(readl(&udc->epsetupstat), &udc->epsetupstat);
> >> > > @@ -934,6 +955,7 @@ static int ci_pullup(struct usb_gadget *gadget=
, int is_on)
> >> > >       struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hco=
r;
> >> > >       if (is_on) {
> >> > >               /* RESET */
> >> > > +             controller.next_device_address =3D 0;
> >> > >               writel(USBCMD_ITC(MICRO_8FRAME) | USBCMD_RST, &udc->=
usbcmd);
> >> > >               udelay(200);
> >> > >
> >> > > diff --git a/drivers/usb/gadget/ci_udc.h b/drivers/usb/gadget/ci_u=
dc.h
> >> > > index bea2f9f3fe3..807f2084c1e 100644
> >> > > --- a/drivers/usb/gadget/ci_udc.h
> >> > > +++ b/drivers/usb/gadget/ci_udc.h
> >> > > @@ -105,6 +105,7 @@ struct ci_drv {
> >> > >       struct ept_queue_head           *epts;
> >> > >       uint8_t                         *items_mem;
> >> > >       struct ci_ep                    ep[NUM_ENDPOINTS];
> >> > > +     u8                              next_device_address;
> >> >
> >> > Should this be u16 ?
> >>
> >> No, USB address is only 8bits (u8)
> >
> > If no other comments were proposed, may this patch be applied?
>
> Ah, sorry, i've been waiting for a v2 patch that includes a link to the
> related kernel commit as asked in [1].
>
> Do you want me to fixup the commit message locally or will a v2 be send?
>
> Thanks!
> Mattijs
>
> [1] https://lore.kernel.org/all/87sesxzo2o.fsf@baylibre.com/

Both options are acceptable, it is up to you, what to choose.
