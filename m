Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7874AC4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 00:17:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E57F386C83;
	Fri,  8 Dec 2023 01:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="DHPr8yLv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28055868AE; Fri,  8 Dec 2023 01:16:58 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47BC9868AE
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 01:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a1f653e3c3dso28066266b.2
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 16:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701994613; x=1702599413;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98brlmLd3TTZi5VOW2PWqdzA5a9nYBEFedKpJg5dHF0=;
 b=DHPr8yLvqvmQ1f1fH8+hhjvbWBpgzv8vQYUnOk58bSbVRcADqY2i1oQIpiUTpariOG
 C5cpmhVaYd6N9yw1a4Jakxa8bwDpXMQhGplSWXHd5lUfrAY+8lAaRHCJRgDJchfTAQU+
 5dxTz7NeEXgou6qsxEZ7b/M+h+B+EreiWI7/5fpLJU1vGMqCkV9N3mpvKvzrvtR/TA21
 CWM2D0i/bZ3JEcyi1bFmUWueX1VUnpY7txOW3UyV9C7bkRq8GZ+9Ol9ODbGl9/dr4oRC
 x9bKErRwjuUnrsopLTf7+O4AWmi09KzfvDLh1ho6bo5yQWXKqVd/1p+EUCkJURP/iDoS
 wEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701994613; x=1702599413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98brlmLd3TTZi5VOW2PWqdzA5a9nYBEFedKpJg5dHF0=;
 b=SU6zw+K4qJNliULhlFhmBM4ReuYDRQKSomP9qV6PXQfsHCj357PpJtWPPxPINLHJRB
 cbvMxJKywFQflFDpmkt6NUsI0f4Kt9v0K9bagombFyKNplFE8PNl2PGaRF7UfS9/W6mA
 P+s/EqMbqNg3FuL7x/XZ8wwQ0wuEGwoSqkO29JiYCgRHdhgla8Yk66OIA4/bJv/RyxJb
 MAbYTnSPtklg4RlcKUjmL3JfqhS1l4+flGjkqjrEOF/2zyKVZuZ3Qg5JMyxWGDkrYvUg
 +ApMyKn6a14rIKCF8BSw3ImnABxtlR7CfGV4dj6KaWuBoBONEb53td6NVRMyMRxhWNXF
 NEeQ==
X-Gm-Message-State: AOJu0YwHNlpnM8XaTZkI6VnGJJrnQix0T6xOgXkFHhmhGiH+07CdfRFQ
 ZvXYWKngijlKCcjn2ZlUjmDntEd0cvY361gYBlWRhg==
X-Google-Smtp-Source: AGHT+IGK8MNKhNe7MLSZWPHdlC2MJBdS8Y97GKLgF73AJUkYWGoOC+J6LfewhzLu2Z6T1xPME3G5IA==
X-Received: by 2002:a17:906:348a:b0:a1d:5d5b:be8f with SMTP id
 g10-20020a170906348a00b00a1d5d5bbe8fmr777562ejb.225.1701994612696; 
 Thu, 07 Dec 2023 16:16:52 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com.
 [209.85.208.50]) by smtp.gmail.com with ESMTPSA id
 vj12-20020a170907d48c00b00a1df19ca2a9sm330429ejc.131.2023.12.07.16.16.52
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 16:16:52 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-54c5d041c23so2094824a12.2
 for <u-boot@lists.denx.de>; Thu, 07 Dec 2023 16:16:52 -0800 (PST)
X-Received: by 2002:a50:9517:0:b0:54c:4fec:119 with SMTP id
 u23-20020a509517000000b0054c4fec0119mr1125439eda.168.1701994611762; Thu, 07
 Dec 2023 16:16:51 -0800 (PST)
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
 <CAHc5_t0Sdk3r5SGOVfQCttqBqv28Uy8x6gPqW7jJD+NGLRBt3A@mail.gmail.com>
 <0adba5d4-3fe9-4c35-b53d-f6370e79c3c7@denx.de>
In-Reply-To: <0adba5d4-3fe9-4c35-b53d-f6370e79c3c7@denx.de>
From: Shantur Rathore <i@shantur.com>
Date: Fri, 8 Dec 2023 00:16:40 +0000
X-Gmail-Original-Message-ID: <CAHc5_t2W7zmxGgvghS5Nxf2SZHufJ2goiTm9_caPdJYhhJJnFg@mail.gmail.com>
Message-ID: <CAHc5_t2W7zmxGgvghS5Nxf2SZHufJ2goiTm9_caPdJYhhJJnFg@mail.gmail.com>
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

Hi Marek,

On Tue, Dec 5, 2023 at 5:40=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
>
> On 12/4/23 13:10, Shantur Rathore wrote:
> > On Mon, Dec 4, 2023 at 11:05=E2=80=AFAM Marek Vasut <marex@denx.de> wro=
te:
> >>
> >> On 12/4/23 11:59, Shantur Rathore wrote:
> >>> Hi Marek,
> >>>
> >>> On Sun, Dec 3, 2023 at 10:37=E2=80=AFPM Marek Vasut <marex@denx.de> w=
rote:
> >>>>
> >>>> On 12/3/23 22:42, Shantur Rathore wrote:
> >>>>> Hi Marek,
> >>>>>
> >>>>> On Sun, Dec 3, 2023 at 8:42=E2=80=AFPM Marek Vasut <marex@denx.de> =
wrote:
> >>>>>>
> >>>>>> On 11/24/23 01:37, Shantur Rathore wrote:
> >>>>>>> Hi Marek,
> >>>>>>
> >>>>>> Hi,
> >>>>>>
> >>>>>> sorry for the late reply.
> >>>>>>
> >>>>>>>>>>> In my case RockPro64, the power to usb ports onboard is contr=
olled by
> >>>>>>>>>>> a regulator.
> >>>>>>>>>>> This regulator is enabled as part of init  as here
> >>>>>>>>>>> https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/rk3=
399-rockpro64.dtsi#L177
> >>>>>>>>>>>
> >>>>>>>>>>> On init, the usb devices connected to the port are powered up=
, in my
> >>>>>>>>>>> case AM8180 (a RTL9210 based ) NVMe to USB enclosure with UAS=
.
> >>>>>>>>>>> But the usb controller is only enabled at 'usb start' and by =
this time
> >>>>>>>>>>> the device is in some state that it doesn't get detected.
> >>>>>>>>>>>
> >>>>>>>>>>> One way to make sure the devices connected to the ports are i=
n an
> >>>>>>>>>>> initialising state is by issuing a port reset before scanning=
 the
> >>>>>>>>>>> port.
> >>>>>>>>>>
> >>>>>>>>>> Why not remove this regulator-always-on and let the PHY driver=
 turn the
> >>>>>>>>>> VBUS ON only when it is needed ?
> >>>>>>>>>>
> >>>>>>>>>> Wouldn't that solve the problem too AND remove unnecessarily e=
nabled
> >>>>>>>>>> regulator ?
> >>>>>>>>>>
> >>>>>>>>>> [...]
> >>>>>>>>>
> >>>>>>>>> Removing the regulator-always-on does make it work but there ar=
e few issues
> >>>>>>>>>
> >>>>>>>>> 1. regulator is used to control power to multiple ports ( USB3.=
0 and
> >>>>>>>>> USB2.0 in RockPro64 ),
> >>>>>>>>> so this could lead to all ports turning off if a phy resets / t=
urns off power
> >>>>>>>>
> >>>>>>>> I vaguely recall seeing some refcounting patch for regulator sub=
system,
> >>>>>>>> would that help ?
> >>>>>>>
> >>>>>>> I don't think this would be a problem for u-boot, but linux maybe=
.
> >>>>>>
> >>>>>> How so ?
> >>>>>
> >>>>> Actually, I am wrong. I wasn't sure if there is refcounting for the
> >>>>> regulator subsystem
> >>>>> in linux. just found it has so this is null and void.
> >>>>>
> >>>>>>
> >>>>>>>>> 2. Even with regulator-always-on and without this reset port pa=
tch,
> >>>>>>>>> linux was always
> >>>>>>>>> able to detect the drive on the port, so there is something mis=
sing in u-boot.
> >>>>>>>>> 3. Looking at usb hub code in Linux, I found that for USB3.0 it=
 tries
> >>>>>>>>> to reset the port before
> >>>>>>>>> scanning. The comment says
> >>>>>>>>>
> >>>>>>>>> /* Is a USB 3.0 port in the Inactive or Compliance Mode state?
> >>>>>>>>>       * Port warm reset is required to recover
> >>>>>>>>>       */
> >>>>>>>>>
> >>>>>>>>> i. https://github.com/torvalds/linux/blob/master/drivers/usb/co=
re/hub.c#L5736
> >>>>>>>>> ii. https://github.com/torvalds/linux/blob/master/drivers/usb/c=
ore/hub.c#L2836
> >>>>>>>>>
> >>>>>>>>> I believe this isn't implemented in u-boot and hence explicit r=
eset of
> >>>>>>>>> a port fixes the issue.
> >>>>>>>>
> >>>>>>>> I feel this is separate issue and what needs to be fixed first i=
s the
> >>>>>>>> hard-wired VBus control.
> >>>>>>>
> >>>>>>> I beg to differ on this, couple of reasons for this
> >>>>>>>
> >>>>>>> 1. The same drive works fine without being reset on the USB2.0 po=
rts - this
> >>>>>>> confirms that the issue is related to USB3.0 only.
> >>>>>>
> >>>>>> This is a separate issue from the hard-wired VBus control. I agree=
 the
> >>>>>> issue does exist, I would simply like to avoid conflating the hard=
-wired
> >>>>>> VBus control with device reset.
> >>>>>>
> >>>>>>> 2. Linux is able to detect the same drive on USB3.0 when u-boot f=
ails - this
> >>>>>>> confirms issue doesn't lie with regulator-always-on
> >>>>>>
> >>>>>> See above
> >>>>>>
> >>>>>>> 3. The links I pasted earlier mentions that in USB3.0 the ports n=
eed reset
> >>>>>>> and this is done before the port is scanned. Adding the similar r=
eset in u-boot
> >>>>>>> fixes all with the same regulator-always-on. AFAIK u-boot doesn't=
 handle
> >>>>>>> this special USB3.0 case and maybe this is why I was finding a fe=
w posts
> >>>>>>> around the drive not being detected in the USB3.0 port in u-boot =
but works in
> >>>>>>> a USB2.0 port.
> >>>>>>
> >>>>>> I am not disputing the need for USB 3.0 device reset, I believe th=
ere
> >>>>>> are two issues here -- one is the hard-wired VBus regulator -- the=
 other
> >>>>>> is this USB 3.0 reset. They should both be fixed.
> >>>>>
> >>>>> Sure, agreed 100%.
> >>>>> Do we need to fix both at the same time?
> >>>>> Both patches seem to be independent.
> >>>>
> >>>> Separate patch for the regulator please .
> >>>
> >>> Thanks, I am working on the regulator patch for rk3399-rockpro64-u-bo=
ot but
> >>> there seems to be a bug in the rk3399-rockpro64.dtsi from linux where
> >>> the typec phy
> >>> is configure with wrong regulator and if I do the patch as below
> >>>
> >>> --- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> >>> +++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> >>> @@ -22,6 +22,23 @@
> >>>           };
> >>>    };
> >>>
> >>> +&vcc5v0_host {
> >>> +       /delete-property/ regulator-always-on;
> >>> +};
> >>> +
> >>> +&vcc5v0_typec {
> >>> +       /delete-property/ regulator-always-on;
> >>> +};
> >>> +
> >>> +&vcc5v0_usb {
> >>> +       /delete-property/ regulator-always-on;
> >>> +       /delete-property/ regulator-boot-on;
> >>> +};
> >>>
> >>> The typec port won't work until I correct the issue with
> >>>
> >>> +&u2phy1_host {
> >>> +       phy-supply =3D <&vcc5v0_typec>;
> >>> +};
> >>> +
> >>>
> >>> What would be acceptable here?
> >>> 1. Leave regulator for typec as it was
> >>> 2. disable regulator-always-on and fix phy here.
> >>
> >> Is there going to be a matching Linux kernel patch with a Linux side f=
ix ?
> >>
> >> If so, include a link to that patch in lore.k.o in the commit message,
> >> and either temporarily fix it up in u-boot.dtsi or backport that patch
> >> to U-Boot DT, either works.
> >
> > So there is no patch in lore.k.o for this and the more I looked the mor=
e
> > dts needed fixing related  usb. I would rather do it in one go and subm=
it
> > proper patches to lore.k.o and u-boot.
> >
> > For now, as usb reset is independent of the rockpro64 regulator issue, =
can
> > you please merge this and I will work on dts fixes separately.
>
> I'll wait for the regulator fix and them merge them both.
>
> This affects too many systems and I'm reluctant to put this into current
> release at rc4, so there should be plenty of time until the next release.

Apologies for the late reply.

I have sent both the patches here
https://patchwork.ozlabs.org/project/uboot/list/?series=3D385763

Thanks,
Shantur
