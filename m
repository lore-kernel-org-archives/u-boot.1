Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1FCD6ED09
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 11:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C164689715;
	Thu, 21 Nov 2024 12:14:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Hk8NEhks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AE4F89700; Thu, 21 Nov 2024 12:14:05 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E80589736
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 12:14:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so6211575e9.3
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 03:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732187640; x=1732792440;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2JNjblKrNmsrm2zEqsHMlRqR/9bLTQKJ2xafwoCudz0=;
 b=Hk8NEhksSlGZHfYhsanOhkb9VdFXJtV3FPJFqP/UGon+GoTL+CCYJcxrPe13dFJ7Mz
 xL/loV7fiXqONVmrXkmEcGP26shdCtFuXckrxyJwK6YilFrLnyyINXK4Y91iLPQ4sYuu
 7y1XZlWjIFUJSGkhBOyiQFiNZLvasSCAEISN608MeXl6Iw+VzCTRisPzM7dYDHnF/Ifb
 JB2HriiN9XYrzoLtrBYB8sIrkXcBGGHeabITpcVZngdDxnel47Yg0wYoKXRqgzJdwvuo
 KH9uzmqtR0Q/77dbUFf5Ln505IJtSo7Rw7gnVzul1B0lLsFrSV2cdgchGqOqv11zf302
 KO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732187640; x=1732792440;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2JNjblKrNmsrm2zEqsHMlRqR/9bLTQKJ2xafwoCudz0=;
 b=uv/d/gwuDbj5UytbHoWAiWrzNC5zmNjsYhbzvqgQvLuSuZZB31BXKByfm7MFRbpqTJ
 lwSK6vzeNXmfUscYLjFOkiFSSQ4sJJCC7M2gAGEw8N/q2d5vHxFn4CRTusrm8TBDPyA2
 +CURrkOjMnY42y9Pcq0MZjuHbVY7xNxFZ/y+y+GnmWRB4qq/UYRZ1mW43VDPVDd/LTyA
 9lLIw1nOzOAtemkvJlh1u8qe1Ry4a9HulDfYkM6yTtfaAfODL/EKhAURQ2rLK0vMbjp5
 d9h66i8S930TBUpjKJARS7vWfX2ag+kD5Ao86nVlelkDFseJvR4iT9qTS75w1FB+gUIx
 9/2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxQsMYZWIModDsdXCVuBMi9FuybBKTCusx4A3Bothbi4zaHm5oLl2zJ1Vh0Cuh5SQCzwpPuuc=@lists.denx.de
X-Gm-Message-State: AOJu0YxDjnVWIGizyt07I2W9rRAInopDu271TROewuCFW4bgCqa/uBAj
 QC5EgtOJNWQ9V4bXWOpq9B/5bmlcbChI2cRkmMSO/8ptnK9RqAsLhfW2/DjeGaU=
X-Google-Smtp-Source: AGHT+IHYgE1pqQeAFzjO06TG9fcQkynbAL/hUKfSKZ0jgrdUibafm7EotaXY2Nvc5FApEPA6xdtqbA==
X-Received: by 2002:a05:600c:a186:b0:432:c774:2e2b with SMTP id
 5b1f17b1804b1-4334f02191cmr49562665e9.32.1732187639766; 
 Thu, 21 Nov 2024 03:13:59 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38254905437sm4808466f8f.3.2024.11.21.03.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 03:13:58 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>, Tom Rini
 <trini@konsulko.com>, Simon Holesch <simon@holesch.de>, Ion Agorria
 <ion@agorria.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/1] usb: ci_udc: don't use "advance" feature when
 setting address
In-Reply-To: <CAPVz0n1F043u8HNvmm-cU=oUjk17tR17Em+g2o+Z8idqq5NM4Q@mail.gmail.com>
References: <20241013145820.85426-1-clamor95@gmail.com>
 <20241013145820.85426-2-clamor95@gmail.com>
 <6f3ce823-93e8-46b5-86f3-52038efc5271@denx.de>
 <CAPVz0n1dHC9VTgxgPmh=bUg1Ei1Wnamopbpjiyz81YxeFtfdWg@mail.gmail.com>
 <CAPVz0n1F043u8HNvmm-cU=oUjk17tR17Em+g2o+Z8idqq5NM4Q@mail.gmail.com>
Date: Thu, 21 Nov 2024 12:13:55 +0100
Message-ID: <87y11cltzg.fsf@baylibre.com>
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

Hello,

On mer., nov. 20, 2024 at 08:45, Svyatoslav Ryhel <clamor95@gmail.com> wrot=
e:

> =D0=BD=D0=B4, 27 =D0=B6=D0=BE=D0=B2=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 18=
:42 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>>
>> =D0=BD=D0=B4, 27 =D0=B6=D0=BE=D0=B2=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 1=
8:09 Marek Vasut <marex@denx.de> =D0=BF=D0=B8=D1=88=D0=B5:
>> >
>> > On 10/13/24 4:58 PM, Svyatoslav Ryhel wrote:
>> >
>> > Sorry for the late reply.
>> >
>> > > +++ b/drivers/usb/gadget/ci_udc.c
>> > > @@ -649,12 +649,30 @@ static void flip_ep0_direction(void)
>> > >       }
>> > >   }
>> > >
>> > > +/*
>> > > + * This function explicitly sets the address, without the "USBADRA"=
 (advance)
>> > > + * feature, which is not supported by older versions of the control=
ler.
>> > > + */
>> > > +static void ci_set_address(struct ci_udc *udc, u8 address)
>> > > +{
>> > > +     DBG("%s %x\n", __func__, address);
>> >
>> > log_debug() or dev_dbg() please.
>> >
>>
>> DBG macro is used across entire driver, if you wish to replace it,
>> then pls, send a followup with patch for entire driver. This is out of
>> scope of this patch.
>>
>> > > +     writel(address << 25, &udc->devaddr);
>> > > +}
>> > > +
>> > >   static void handle_ep_complete(struct ci_ep *ci_ep)
>> > >   {
>> > >       struct ept_queue_item *item, *next_td;
>> > >       int num, in, len, j;
>> > >       struct ci_req *ci_req;
>> > >
>> > > +     /* Set the device address that was previously sent by SET_ADDR=
ESS */
>> > > +     if (controller.next_device_address !=3D 0) {
>> > > +             struct ci_udc *udc =3D (struct ci_udc *)controller.ctr=
l->hcor;
>> > > +
>> > > +             ci_set_address(udc, controller.next_device_address);
>> > > +             controller.next_device_address =3D 0;
>> > > +     }
>> > > +
>> > >       num =3D ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MA=
SK;
>> > >       in =3D (ci_ep->desc->bEndpointAddress & USB_DIR_IN) !=3D 0;
>> > >       item =3D ci_get_qtd(num, in);
>> > > @@ -783,7 +801,7 @@ static void handle_setup(void)
>> > >                * write address delayed (will take effect
>> > >                * after the next IN txn)
>> > >                */
>> > > -             writel((r.wValue << 25) | (1 << 24), &udc->devaddr);
>> > > +             controller.next_device_address =3D r.wValue;
>> >
>> > wValue is word , u16 , but next_device_address is u8 below , why ?
>> >
>>
>> wValue is u16 but only 8 bits are relevant since USB address is 8 bit,
>> hence u8. Changing wValue to u8 is out of scope of this patch as well.
>>
>> > >               req->length =3D 0;
>> > >               usb_ep_queue(controller.gadget.ep0, req, 0);
>> > >               return;
>> > > @@ -814,6 +832,9 @@ static void stop_activity(void)
>> > >       int i, num, in;
>> > >       struct ept_queue_head *head;
>> > >       struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
>> > > +
>> > > +     ci_set_address(udc, 0);
>> > > +
>> > >       writel(readl(&udc->epcomp), &udc->epcomp);
>> > >   #ifdef CONFIG_CI_UDC_HAS_HOSTPC
>> > >       writel(readl(&udc->epsetupstat), &udc->epsetupstat);
>> > > @@ -934,6 +955,7 @@ static int ci_pullup(struct usb_gadget *gadget, =
int is_on)
>> > >       struct ci_udc *udc =3D (struct ci_udc *)controller.ctrl->hcor;
>> > >       if (is_on) {
>> > >               /* RESET */
>> > > +             controller.next_device_address =3D 0;
>> > >               writel(USBCMD_ITC(MICRO_8FRAME) | USBCMD_RST, &udc->us=
bcmd);
>> > >               udelay(200);
>> > >
>> > > diff --git a/drivers/usb/gadget/ci_udc.h b/drivers/usb/gadget/ci_udc=
.h
>> > > index bea2f9f3fe3..807f2084c1e 100644
>> > > --- a/drivers/usb/gadget/ci_udc.h
>> > > +++ b/drivers/usb/gadget/ci_udc.h
>> > > @@ -105,6 +105,7 @@ struct ci_drv {
>> > >       struct ept_queue_head           *epts;
>> > >       uint8_t                         *items_mem;
>> > >       struct ci_ep                    ep[NUM_ENDPOINTS];
>> > > +     u8                              next_device_address;
>> >
>> > Should this be u16 ?
>>
>> No, USB address is only 8bits (u8)
>
> If no other comments were proposed, may this patch be applied?

Ah, sorry, i've been waiting for a v2 patch that includes a link to the
related kernel commit as asked in [1].

Do you want me to fixup the commit message locally or will a v2 be send?

Thanks!
Mattijs

[1] https://lore.kernel.org/all/87sesxzo2o.fsf@baylibre.com/
