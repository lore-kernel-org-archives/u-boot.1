Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758E7C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 12:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06E438758F;
	Mon,  4 Dec 2023 13:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="xt09qjhW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF0F086BA4; Mon,  4 Dec 2023 13:10:49 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB7F8758F
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 13:10:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50be10acaf9so2314798e87.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 04:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701691846; x=1702296646;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OErQ/ZJTeiS/eRVfLgZcxRJZb7WY7AjXjiSmHRzEVcM=;
 b=xt09qjhWSZSyEgvQtCtXU43PMTELtN56t5VylfeKrQPtYNTdMtmaNbMdetgBSw5Dka
 PBnf7WEKrt0A+s7mtkW8/0fpHcKIBY2BvwW1cvzqPw5lTpo7ab1wclxO7GvGrboSaOlo
 lcKXtsgKVYrnJzRPkk2fVhDR9OmwY+khfFf3S04aDdzTHIxwTzpJwYwrh20jZH9JXlBF
 t3I7nIS/IYu6gkDM+YYFq+ECKtbAIpJ4HXAnimFXgnV/PqfT/jWZTH384JyHIKf+ugCB
 m/EN2nKehiDdTZoAFWDrgyJxEaoilyX8PufKmUUF/DwgGn9H/QGfR+XxFRRZAq/JeOzl
 bBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701691846; x=1702296646;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OErQ/ZJTeiS/eRVfLgZcxRJZb7WY7AjXjiSmHRzEVcM=;
 b=src3rRR6O0fo9pDOb0h+88Wd6h6thUlYA0iQo1WfuNIGSy/OX3LNxDYWwoBie6b5X7
 3yFW82DtEhGbsSV9KdwGARlr58C4Mb1rtOtLut9LkI2G3CQEXYlN7tPhia7N+qWmbJgh
 wgzkbhBMuYUzrKlcNlAll4VMcvdLazZCM8pHwDDZlC2cx+Oj7iFYpcvBVY6fykY5NfSh
 QvRYb9fFQof2VPLsSmIIdgbWNKRXYWNPgSaWTNMOXYCkludETyTuTnOB2NXbWY5P/Hl5
 wD6vxZAKjn7/PGQVUZATphlCHdSbksiqBQGBrH+2kZvRNMdH0croSiaOXf8oevI+niva
 rUIg==
X-Gm-Message-State: AOJu0YwoAXgWA3inT5/brL5i61Y0iJo8PXi2ujEzfvhe7o2T3D3TXyCM
 lYTVzuiJqHjUZxsnd7W1Zs+ChJ/t3J2bF/l3crbvEq/1
X-Google-Smtp-Source: AGHT+IEU0k4erIo8nwPpFc8GzYkFj4dhmld4A3Jy16focnFJUPhHuFCi1YSyx+iKkH+vRmjGfC8jIw==
X-Received: by 2002:ac2:5dc3:0:b0:50b:f3fc:125a with SMTP id
 x3-20020ac25dc3000000b0050bf3fc125amr866899lfq.10.1701691845880; 
 Mon, 04 Dec 2023 04:10:45 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com.
 [209.85.218.45]) by smtp.gmail.com with ESMTPSA id
 bi38-20020a0565120ea600b0050bfd88075asm113663lfb.287.2023.12.04.04.10.45
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 04:10:45 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-a18f732dc83so747338566b.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 04:10:45 -0800 (PST)
X-Received: by 2002:a17:906:19ca:b0:9fa:d1df:c2c4 with SMTP id
 h10-20020a17090619ca00b009fad1dfc2c4mr5467838ejd.36.1701691844692; Mon, 04
 Dec 2023 04:10:44 -0800 (PST)
MIME-Version: 1.0
References: <20231110141311.512334-1-i@shantur.com>
 <a911092c-78e7-469b-abd8-2aeb9f7e28b7@denx.de>
 <CAHc5_t3ddCnKMBNbe8Cc=dZBXvxyke2p5ydU2dbt8Gt8RH43_w@mail.gmail.com>
 <14da0009-8819-4355-8a38-c9fe926ab3f7@denx.de>
 <CAHc5_t0-Mt+-9aBXnD0457YKRyJXHj3oYunq2c35ZaMbmQnqAw@mail.gmail.com>
 <3284f652-49dd-409f-9130-ad7cbce64b32@denx.de>
 <CAHc5_t3t7E+qZrv_KvNNwMDmD9+o+SX3jwv-wq-4gP3d17yBwg@mail.gmail.com>
 <2fe93269-7373-46cb-95e0-383270ea67ac@denx.de>
 <CAHc5_t1Gw7TyxaoEdCcZ1Avh+hjMx+po=2Bh86V=ykt65qPqKg@mail.gmail.com>
 <093a6f33-7ce3-4cbf-b1f5-9aba9f85c615@denx.de>
 <CAHc5_t1Nfrt9p-jiVDPsx1ro4tNjRmyXR48OZtSoggGudeLJJQ@mail.gmail.com>
 <d065661e-23d5-45d5-86e7-1e381ccc657a@denx.de>
In-Reply-To: <d065661e-23d5-45d5-86e7-1e381ccc657a@denx.de>
From: Shantur Rathore <i@shantur.com>
Date: Mon, 4 Dec 2023 12:10:33 +0000
X-Gmail-Original-Message-ID: <CAHc5_t0Sdk3r5SGOVfQCttqBqv28Uy8x6gPqW7jJD+NGLRBt3A@mail.gmail.com>
Message-ID: <CAHc5_t0Sdk3r5SGOVfQCttqBqv28Uy8x6gPqW7jJD+NGLRBt3A@mail.gmail.com>
Subject: Re: [PATCH] common: usb-hub: Reset hub port before scanning
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Bin Meng <bmeng.cn@gmail.com>
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

On Mon, Dec 4, 2023 at 11:05=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 12/4/23 11:59, Shantur Rathore wrote:
> > Hi Marek,
> >
> > On Sun, Dec 3, 2023 at 10:37=E2=80=AFPM Marek Vasut <marex@denx.de> wro=
te:
> >>
> >> On 12/3/23 22:42, Shantur Rathore wrote:
> >>> Hi Marek,
> >>>
> >>> On Sun, Dec 3, 2023 at 8:42=E2=80=AFPM Marek Vasut <marex@denx.de> wr=
ote:
> >>>>
> >>>> On 11/24/23 01:37, Shantur Rathore wrote:
> >>>>> Hi Marek,
> >>>>
> >>>> Hi,
> >>>>
> >>>> sorry for the late reply.
> >>>>
> >>>>>>>>> In my case RockPro64, the power to usb ports onboard is control=
led by
> >>>>>>>>> a regulator.
> >>>>>>>>> This regulator is enabled as part of init  as here
> >>>>>>>>> https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/rk339=
9-rockpro64.dtsi#L177
> >>>>>>>>>
> >>>>>>>>> On init, the usb devices connected to the port are powered up, =
in my
> >>>>>>>>> case AM8180 (a RTL9210 based ) NVMe to USB enclosure with UAS.
> >>>>>>>>> But the usb controller is only enabled at 'usb start' and by th=
is time
> >>>>>>>>> the device is in some state that it doesn't get detected.
> >>>>>>>>>
> >>>>>>>>> One way to make sure the devices connected to the ports are in =
an
> >>>>>>>>> initialising state is by issuing a port reset before scanning t=
he
> >>>>>>>>> port.
> >>>>>>>>
> >>>>>>>> Why not remove this regulator-always-on and let the PHY driver t=
urn the
> >>>>>>>> VBUS ON only when it is needed ?
> >>>>>>>>
> >>>>>>>> Wouldn't that solve the problem too AND remove unnecessarily ena=
bled
> >>>>>>>> regulator ?
> >>>>>>>>
> >>>>>>>> [...]
> >>>>>>>
> >>>>>>> Removing the regulator-always-on does make it work but there are =
few issues
> >>>>>>>
> >>>>>>> 1. regulator is used to control power to multiple ports ( USB3.0 =
and
> >>>>>>> USB2.0 in RockPro64 ),
> >>>>>>> so this could lead to all ports turning off if a phy resets / tur=
ns off power
> >>>>>>
> >>>>>> I vaguely recall seeing some refcounting patch for regulator subsy=
stem,
> >>>>>> would that help ?
> >>>>>
> >>>>> I don't think this would be a problem for u-boot, but linux maybe.
> >>>>
> >>>> How so ?
> >>>
> >>> Actually, I am wrong. I wasn't sure if there is refcounting for the
> >>> regulator subsystem
> >>> in linux. just found it has so this is null and void.
> >>>
> >>>>
> >>>>>>> 2. Even with regulator-always-on and without this reset port patc=
h,
> >>>>>>> linux was always
> >>>>>>> able to detect the drive on the port, so there is something missi=
ng in u-boot.
> >>>>>>> 3. Looking at usb hub code in Linux, I found that for USB3.0 it t=
ries
> >>>>>>> to reset the port before
> >>>>>>> scanning. The comment says
> >>>>>>>
> >>>>>>> /* Is a USB 3.0 port in the Inactive or Compliance Mode state?
> >>>>>>>      * Port warm reset is required to recover
> >>>>>>>      */
> >>>>>>>
> >>>>>>> i. https://github.com/torvalds/linux/blob/master/drivers/usb/core=
/hub.c#L5736
> >>>>>>> ii. https://github.com/torvalds/linux/blob/master/drivers/usb/cor=
e/hub.c#L2836
> >>>>>>>
> >>>>>>> I believe this isn't implemented in u-boot and hence explicit res=
et of
> >>>>>>> a port fixes the issue.
> >>>>>>
> >>>>>> I feel this is separate issue and what needs to be fixed first is =
the
> >>>>>> hard-wired VBus control.
> >>>>>
> >>>>> I beg to differ on this, couple of reasons for this
> >>>>>
> >>>>> 1. The same drive works fine without being reset on the USB2.0 port=
s - this
> >>>>> confirms that the issue is related to USB3.0 only.
> >>>>
> >>>> This is a separate issue from the hard-wired VBus control. I agree t=
he
> >>>> issue does exist, I would simply like to avoid conflating the hard-w=
ired
> >>>> VBus control with device reset.
> >>>>
> >>>>> 2. Linux is able to detect the same drive on USB3.0 when u-boot fai=
ls - this
> >>>>> confirms issue doesn't lie with regulator-always-on
> >>>>
> >>>> See above
> >>>>
> >>>>> 3. The links I pasted earlier mentions that in USB3.0 the ports nee=
d reset
> >>>>> and this is done before the port is scanned. Adding the similar res=
et in u-boot
> >>>>> fixes all with the same regulator-always-on. AFAIK u-boot doesn't h=
andle
> >>>>> this special USB3.0 case and maybe this is why I was finding a few =
posts
> >>>>> around the drive not being detected in the USB3.0 port in u-boot bu=
t works in
> >>>>> a USB2.0 port.
> >>>>
> >>>> I am not disputing the need for USB 3.0 device reset, I believe ther=
e
> >>>> are two issues here -- one is the hard-wired VBus regulator -- the o=
ther
> >>>> is this USB 3.0 reset. They should both be fixed.
> >>>
> >>> Sure, agreed 100%.
> >>> Do we need to fix both at the same time?
> >>> Both patches seem to be independent.
> >>
> >> Separate patch for the regulator please .
> >
> > Thanks, I am working on the regulator patch for rk3399-rockpro64-u-boot=
 but
> > there seems to be a bug in the rk3399-rockpro64.dtsi from linux where
> > the typec phy
> > is configure with wrong regulator and if I do the patch as below
> >
> > --- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> > +++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> > @@ -22,6 +22,23 @@
> >          };
> >   };
> >
> > +&vcc5v0_host {
> > +       /delete-property/ regulator-always-on;
> > +};
> > +
> > +&vcc5v0_typec {
> > +       /delete-property/ regulator-always-on;
> > +};
> > +
> > +&vcc5v0_usb {
> > +       /delete-property/ regulator-always-on;
> > +       /delete-property/ regulator-boot-on;
> > +};
> >
> > The typec port won't work until I correct the issue with
> >
> > +&u2phy1_host {
> > +       phy-supply =3D <&vcc5v0_typec>;
> > +};
> > +
> >
> > What would be acceptable here?
> > 1. Leave regulator for typec as it was
> > 2. disable regulator-always-on and fix phy here.
>
> Is there going to be a matching Linux kernel patch with a Linux side fix =
?
>
> If so, include a link to that patch in lore.k.o in the commit message,
> and either temporarily fix it up in u-boot.dtsi or backport that patch
> to U-Boot DT, either works.

So there is no patch in lore.k.o for this and the more I looked the more
dts needed fixing related  usb. I would rather do it in one go and submit
proper patches to lore.k.o and u-boot.

For now, as usb reset is independent of the rockpro64 regulator issue, can
you please merge this and I will work on dts fixes separately.

Regards,
Shantur
