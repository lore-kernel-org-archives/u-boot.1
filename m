Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7880C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 09:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0EED878EE;
	Wed,  7 Feb 2024 10:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="RklON1mE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 174D6807AE; Wed,  7 Feb 2024 10:22:30 +0100 (CET)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com
 [IPv6:2607:f8b0:4864:20::a31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D936878EE
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 10:22:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4c033928deaso1000677e0c.0
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 01:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1707297746; x=1707902546;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UrWFANOsllv16hvbnHSIcU8pHqBzgjDlZSrxreZCoqw=;
 b=RklON1mE5yix4sEx5A3+pTnhTgV53Qg80u/pHy+6H5BnrQVCLMWYfMPkBn/FYdALQk
 wne3MY2ty3Yt4veCBDITPEbqU2E7lG0HvvF6bfiALUjZoan5cayPklZ2L0xuQL7c4DVn
 N6Zw88cy8OM8VhIUZAGPNJzCqziCfUKAYNQqwk7hoFWjJcVYbA1Fl88lNReY28ktLWcd
 ZONjID0ION1mLMahVIOZaxuGPFUdU2MBr7LX46E29ftcnSY/ePjJCWT6JiBi3E/cY1vh
 myktLHz3oTwTUIRSlYPVc19dhRQIjTRkTUaRdBm4iL7Nb47aITQqqaXrl2uLlOZuEd92
 jmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707297746; x=1707902546;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UrWFANOsllv16hvbnHSIcU8pHqBzgjDlZSrxreZCoqw=;
 b=cbU03A17A53jc988GYELWUgMOXFpvF+N1CF1g7ztrYp4FQQ56w4/uowswnFWHJFVof
 w+msiQeP66nqwTtDgRy7lk3rT6ZgJJIvVZunkPThvlUz+aNVxDV/yIGANCNmAWnpRPbM
 W9UNRRf0H0ub4nV3/alqwatSRIgbgpXwiDBE12H5zSKO7cJgSuw5o8u/yh7vdv/aKQC+
 wxk+e/1SrmLNHOLi9xBVp1WjNJmc5JTv81rkf7zJUIAqeCPqRHh0kZR3wXTWOErBI0xZ
 xFAphu1U1DvtzF9vfbAFYRSGAnAqj4HRZYaYbknYR5nQAaBbfnuiftVPrS7/y9n+mdqE
 B/fw==
X-Gm-Message-State: AOJu0Yxf2vGaymWexBLxBr8iA4NX/AB7ezRlIYjJj6FbxME+arMEdqgd
 lCUkyhTPcLgUBXNUqrqQ64GZUn1sHjeXopawG82m8Q8PI1zShpDRwVX8waOXpYlZLjhmWjv3pRA
 6ZTpcTs/xoYtVycqnMyUqEvRkpiZ0/yRkE+5ZzA==
X-Google-Smtp-Source: AGHT+IElD4Gq7UZhzAAFjH1DIVpswcUps+DHQ9Z5Ppa4sfgUAAelBasy+0yGgflH8+50XCEJjNpxWM5jVH80KIJIZ5M=
X-Received: by 2002:a05:6122:218f:b0:4b9:103a:9a64 with SMTP id
 j15-20020a056122218f00b004b9103a9a64mr1386176vkd.8.1707297745752; Wed, 07 Feb
 2024 01:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20231209181057.331815-1-i@shantur.com>
 <20240130140123.445f368a@donnerap.manchester.arm.com>
 <CABEcMwWs-_ZzTdt=kRc05JwC=okA9FyvrAVK1rTLa=erTu9N3g@mail.gmail.com>
 <20240201164604.13315fa6@donnerap.manchester.arm.com>
 <CABEcMwXYw9L957wykfZ5HcC5V88hbgEDZ-E_fYL9LhG_hyxb=g@mail.gmail.com>
 <20240202001218.63b4e9c3@minigeek.lan>
 <0f15ffcce8c15b86e5a44a3255ef265c@manjaro.org>
 <20240202112841.268fb764@donnerap.manchester.arm.com>
 <7e81f6a49eb1b824b0ee3568892ba4d6@manjaro.org>
In-Reply-To: <7e81f6a49eb1b824b0ee3568892ba4d6@manjaro.org>
From: Shantur Rathore <i@shantur.com>
Date: Wed, 7 Feb 2024 09:22:14 +0000
Message-ID: <CABEcMwU56tfRbRtd+MYbzSuOYQzCZm6KuCwomNFihyQKQqe7MA@mail.gmail.com>
Subject: Re: [PATCH v3] common: usb-hub: Reset hub port before scanning
To: Dragan Simic <dsimic@manjaro.org>
Cc: Andre Przywara <andre.przywara@arm.com>, marex@denx.de, bmeng.cn@gmail.com,
 clamor95@gmail.com, Hector Martin <marcan@marcan.st>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Dragan and Andre,

On Sat, Feb 3, 2024 at 10:39=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Andre and Shantur,
>
> On 2024-02-02 12:28, Andre Przywara wrote:
> > On Fri, 02 Feb 2024 03:35:24 +0100 Dragan Simic <dsimic@manjaro.org>
> > wrote:
> >> On 2024-02-02 01:12, Andre Przywara wrote:
> >> > On Thu, 1 Feb 2024 18:35:28 +0000 Shantur Rathore <i@shantur.com>
> >> > wrote:
> >> >> On Thu, Feb 1, 2024 at 4:46=E2=80=AFPM Andre Przywara <andre.przywa=
ra@arm.com>
> >> >> wrote:
> >> >> > On Thu, 1 Feb 2024 09:39:54 +0000 Shantur Rathore <i@shantur.com>=
 wrote:
> >> >> > > Which USB disk are you using? Is it a USB 2.0 disk ?
> >> >> > > Can you try with any other USB disk to confirm?
> >> >> >
> >> >> > Yes, this was some USB 2.0 memory stick, on an USB 2.0 port.
> >> >> > Most sunxi boards only have USB 2.0, but there is one SoC with US=
B 3.0, I
> >> >> > will try some combinations later tonight.
> >> >>
> >> >> That would be awesome.
> >> >> We need to test
> >> >>
> >> >> USB 3.0 and 2.0 ports with USB 3.0 and 2.0 drives.
> >> >
> >> > So I had some mixed and apparently inconsistent results:
> >> > - On the Pine-H64 (H6 SoC with USB 3.0 + USB 2.0) it worked with
> >> >   mainline, but only after I applied some pending sunxi USB PHY
> >> >   regulator patches. This is an unrelated issue, those patches
> >> >   are needed to enable USB 3.0 support on that board (shared regulat=
or
> >> >   conflict).
> >> >   I tested a USB 2.0 and a USB 3.0 drive in both kind of slots, with
> >> >   and without the patch.
> >> > - On the OrangePi Zero 3 (H616 SoC with USB 2.0 only), the USB 3.0
> >> >   drive would not work with mainline. A USB 2.0 drive was fine.
> >> >   Applying your patch below fixed that problem, now both drives work=
ed.
> >>
> >> Let me interject, please...
> >>
> >> Huh, this (mih)behavior with the tested OrangePi Zero 3 is really
> >> strange.  As we know, a USB 3.0 drive plugged into a USB 2.0 port
> >> should behave just like a USB 2.0 drive, using the separate set
> >> of pins inside the connector.
> >
> > Yes, I found this odd as well, hence saying inconsistent above.
> >
> >> If possible, performing some additional testing with another USB
> >> 3.0 drive would be quite interesting.  Could it be that something
> >> is wrong with the USB 2.0 receptacle on your OrangePi Zero 3,
> >> mechanically or electrically?
> >
> > The receptacle on the OPi Zero3 is a standard USB 2.0 Type-A socket,
> > with clearly only 4 pins. The USB 3.0 stick in question has all 9 pins.
> > So indeed there should be little difference to a USB 2.0 stick.
>
> Ah, sorry, I wasn't clear enough...  I actually had some possible
> damage to the Zero 3's USB 2.0 receptacle in mind, or some results
> of the regular wear and tear, which could've possibly caused some
> intermittent issues.
>
> > And I just tested the same board with some other (cheap) USB 2.0 stick:
> > it's the same situation as with the USB 3.0 drive: it does not work
> > with
> > mainline, but works with the patch below. So the USB 3.0 device here
> > might
> > be a red herring, and it's actually more up to an individual device?
> > Or maybe it's like: *Some* USB devices (in Hi-Speed mode?) do not like
> > it
> > when their port is reset before it's powered on? And the root hub
> > implementation also plays a role, which is why we only got reports
> > about
> > Allwinner boards?
>
> Hmm, we've got quite a few unknowns there.  Thank you for
> performing the additional testing!
>
> > Also I think Marek said that Linux does the reset only when using
> > SuperSpeed (hence the patch below), so maybe it's something in the USB
> > 3.0
> > spec that changed the requirements?
>
> I just spent about an hour and a half going through the USB 2.0
> and USB 3.0 specifications.  From what I understood, resetting
> a USB 3.0 port should be required when a USB device transitions
> between different states, such as when it resumes from suspend,
> but maybe not necessarily upon the initial device attachment.
>
> Though, the Linux kernel USB driver seems to be doing additional
> USB 3.0 port resets upon the initial USB device attachment,
> presumably to ensure proper state of the USB 3.0 hub port and
> proper USB mode negotiation.
>
> Here are the links to a couple of screenshots from the USB 3.0
> specification, for future reference: https://i.imgur.com/cMaBdq2.png
> and https://i.imgur.com/PDciRjP.png .
>
> Moreover, such USB port resets don't seem to exist for USB 2.0
> hubs, or at least I didn't see them in the USB 2.0 specification.
> The resets seem to be added to the USB 3.0 specification as part
> of the port and device mode negotiation.
>
> Thus, the additional fix that Shantur sent, available below, looks
> to be the right way to handle it.  Thus, Shantur, AFAICT it's fine
> to submit this fix as a separate "Fixes" patch.
>

Thanks for confirmation.
I will submit a patch soon.

> >> > - On the OrangePi Zero (H3 with USB 2.0 only), it worked with and
> >> >   without the patch below, with both the USB 2.0 and USB 3.0 drive.
> >> > - On the BananaPi M64 (A64 with USB 2.0 only and an onboard USB 2.0
> >> >   hub) it also worked in all cases: with and without the patch, USB =
2.0
> >> >   and USB 3.0 drive.
> >> >
> >> > So the good news is: with the patch below it worked in all cases, wi=
th
> >> > all drives in all slots, on all boards. With current mainline some
> >> > drives don't work at least on the board with the H616 SoC.
> >> >
> >> > I cannot really say if that makes sense, and the results above maybe
> >> > more per board than per SoC (different VBUS supply), but would
> >> > pragmatically tend to use the patch, feel free to add my Tested-by:
> >> > when sending:
> >> >
> >> > Tested-by: Andre Przywara <andre.przywara@arm.com>
> >> >
> >> > Just one tiny thing:
> >> >
> >> >> Once you have tested it, can you please try the patch below
> >> >>
> >> >>         debug("enabling power on all ports\n");
> >> >>         for (i =3D 0; i < dev->maxchild; i++) {
> >> >> -               usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_RESE=
T);
> >> >> -               debug("Reset : port %d returns %lX\n", i + 1,
> >> >> dev->status);
> >> >> +               if (usb_hub_is_superspeed(hub)) {
> >> >
> >> > this must be: usb_hub_is_superspeed(dev)

No, this is to check the hub. If the hub is USB 3.0 then we can try reset.
The device isn't identified yet.

> >> >
> >> > So many thanks for that patch, that seem to have fixed it for me - e=
ven
> >> > though I don't understand why. But then again I only have superficia=
l
> >> > USB knowledge.
> >> >
> >> >> +                       usb_set_port_feature(dev, i + 1,
> >> >> USB_PORT_FEAT_RESET);
> >> >> +                       debug("Reset : port %d returns %lX\n", i + =
1,
> >> >> dev->status);
> >> >> +               }
> >> >>                 usb_set_port_feature(dev, i + 1, USB_PORT_FEAT_POWE=
R);
> >> >>                 debug("PowerOn : port %d returns %lX\n", i + 1,
> >> >> dev->status);
> >> >>         }
