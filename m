Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6900EC4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 21:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA45F876E0;
	Sun,  3 Dec 2023 22:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="EF1rLRzQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C0EE87763; Sun,  3 Dec 2023 22:43:13 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D11387646
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 22:43:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a196f84d217so366433966b.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 13:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701639790; x=1702244590;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEk3ijy963YoMTdqF6zgEexfq8989oQN0ZbcMRYP3cc=;
 b=EF1rLRzQfhE7ckcXGbNw1mvit/jgl3ugqyBKoc/oE0F6eb3WgX/sdpaSjugP3kBCUJ
 PJizhOr6E26nljG2M5PyyOX/0q9IF6GitryCwOtnstoW+jV5MhxhQLMPw6DlJv6587qu
 wUnaF59L/Q11k+XRBs+E/ICoaeSAvQr+ATcAvqzow7IEVq6g5A5ke6n1a5sly3VPnn//
 QvEuc0eG26mdMwxWGks31tXaGR4WSxI5smXnFhekSY1jIgHaq7YFF3SNV2uJxpJy/ERC
 TRydsUVrgtCo2y60aWIbG9LhJKFVefgDpZ83JRQrWg+DwUYeTMPqZAf3uv5xpDKBASUh
 a4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701639790; x=1702244590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TEk3ijy963YoMTdqF6zgEexfq8989oQN0ZbcMRYP3cc=;
 b=PQ9KsC6E4Z2n9Md4AcKHWZW0pvql/pWta57eBCPJFZwAp0YLYCrdFvrT4KS4Lb1NTj
 41RHTYf1E+XNB7nFg02iZ5cc48TVCfDl3QQR53lIk5D6CuHHYIiP7Pjy2lr+Wppd8yRK
 kVxtPlMwAuyJyp6TMkSscjbKBpUd3Y42D4q21BsNvi1zOWRYs9Ax7GINscRFylGXOq3/
 yvekvXZZlSm+rG3jdQDrW7siYePYOBTMXJxsqecsXNBZyAH69C4xGX1PFKGKUcHUs8Yt
 dDAoyf4pBx4w4DGtL94cR6uMKZ76OULmkcPKNWzH0LO9iaANaxKbeGc6A4TmPav8ofTb
 upAA==
X-Gm-Message-State: AOJu0YxmzLoI1LSZUoUP0O5ME5PDsD9qxNVT2nZvpMDdyDWxk42AzU9t
 x/LU3th2/soRK55fLVaKVLj9LB5JMSIWSvIAD9NyxY6m
X-Google-Smtp-Source: AGHT+IHOnIjXRffZMQTpBe7NKuYfsqM5Vb89L6+cbREJWRxiIloDhtVYETm0hxOura+V9zLotZi51Q==
X-Received: by 2002:a17:906:3f01:b0:a19:7144:6bf4 with SMTP id
 c1-20020a1709063f0100b00a1971446bf4mr2619508ejj.59.1701639789660; 
 Sun, 03 Dec 2023 13:43:09 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com.
 [209.85.208.46]) by smtp.gmail.com with ESMTPSA id
 oz11-20020a170906cd0b00b009fc990d9edbsm4513614ejb.192.2023.12.03.13.43.09
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Dec 2023 13:43:09 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-54bfa9b3ffaso4946130a12.1
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 13:43:09 -0800 (PST)
X-Received: by 2002:a50:c08a:0:b0:54a:fb41:14c with SMTP id
 k10-20020a50c08a000000b0054afb41014cmr2469629edf.36.1701639788856; Sun, 03
 Dec 2023 13:43:08 -0800 (PST)
MIME-Version: 1.0
References: <20231110141311.512334-1-i@shantur.com>
 <a911092c-78e7-469b-abd8-2aeb9f7e28b7@denx.de>
 <CAHc5_t3ddCnKMBNbe8Cc=dZBXvxyke2p5ydU2dbt8Gt8RH43_w@mail.gmail.com>
 <14da0009-8819-4355-8a38-c9fe926ab3f7@denx.de>
 <CAHc5_t0-Mt+-9aBXnD0457YKRyJXHj3oYunq2c35ZaMbmQnqAw@mail.gmail.com>
 <3284f652-49dd-409f-9130-ad7cbce64b32@denx.de>
 <CAHc5_t3t7E+qZrv_KvNNwMDmD9+o+SX3jwv-wq-4gP3d17yBwg@mail.gmail.com>
 <2fe93269-7373-46cb-95e0-383270ea67ac@denx.de>
In-Reply-To: <2fe93269-7373-46cb-95e0-383270ea67ac@denx.de>
From: Shantur Rathore <i@shantur.com>
Date: Sun, 3 Dec 2023 21:42:57 +0000
X-Gmail-Original-Message-ID: <CAHc5_t1Gw7TyxaoEdCcZ1Avh+hjMx+po=2Bh86V=ykt65qPqKg@mail.gmail.com>
Message-ID: <CAHc5_t1Gw7TyxaoEdCcZ1Avh+hjMx+po=2Bh86V=ykt65qPqKg@mail.gmail.com>
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

On Sun, Dec 3, 2023 at 8:42=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 11/24/23 01:37, Shantur Rathore wrote:
> > Hi Marek,
>
> Hi,
>
> sorry for the late reply.
>
> >>>>> In my case RockPro64, the power to usb ports onboard is controlled =
by
> >>>>> a regulator.
> >>>>> This regulator is enabled as part of init  as here
> >>>>> https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/rk3399-ro=
ckpro64.dtsi#L177
> >>>>>
> >>>>> On init, the usb devices connected to the port are powered up, in m=
y
> >>>>> case AM8180 (a RTL9210 based ) NVMe to USB enclosure with UAS.
> >>>>> But the usb controller is only enabled at 'usb start' and by this t=
ime
> >>>>> the device is in some state that it doesn't get detected.
> >>>>>
> >>>>> One way to make sure the devices connected to the ports are in an
> >>>>> initialising state is by issuing a port reset before scanning the
> >>>>> port.
> >>>>
> >>>> Why not remove this regulator-always-on and let the PHY driver turn =
the
> >>>> VBUS ON only when it is needed ?
> >>>>
> >>>> Wouldn't that solve the problem too AND remove unnecessarily enabled
> >>>> regulator ?
> >>>>
> >>>> [...]
> >>>
> >>> Removing the regulator-always-on does make it work but there are few =
issues
> >>>
> >>> 1. regulator is used to control power to multiple ports ( USB3.0 and
> >>> USB2.0 in RockPro64 ),
> >>> so this could lead to all ports turning off if a phy resets / turns o=
ff power
> >>
> >> I vaguely recall seeing some refcounting patch for regulator subsystem=
,
> >> would that help ?
> >
> > I don't think this would be a problem for u-boot, but linux maybe.
>
> How so ?

Actually, I am wrong. I wasn't sure if there is refcounting for the
regulator subsystem
in linux. just found it has so this is null and void.

>
> >>> 2. Even with regulator-always-on and without this reset port patch,
> >>> linux was always
> >>> able to detect the drive on the port, so there is something missing i=
n u-boot.
> >>> 3. Looking at usb hub code in Linux, I found that for USB3.0 it tries
> >>> to reset the port before
> >>> scanning. The comment says
> >>>
> >>> /* Is a USB 3.0 port in the Inactive or Compliance Mode state?
> >>>    * Port warm reset is required to recover
> >>>    */
> >>>
> >>> i. https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub=
.c#L5736
> >>> ii. https://github.com/torvalds/linux/blob/master/drivers/usb/core/hu=
b.c#L2836
> >>>
> >>> I believe this isn't implemented in u-boot and hence explicit reset o=
f
> >>> a port fixes the issue.
> >>
> >> I feel this is separate issue and what needs to be fixed first is the
> >> hard-wired VBus control.
> >
> > I beg to differ on this, couple of reasons for this
> >
> > 1. The same drive works fine without being reset on the USB2.0 ports - =
this
> > confirms that the issue is related to USB3.0 only.
>
> This is a separate issue from the hard-wired VBus control. I agree the
> issue does exist, I would simply like to avoid conflating the hard-wired
> VBus control with device reset.
>
> > 2. Linux is able to detect the same drive on USB3.0 when u-boot fails -=
 this
> > confirms issue doesn't lie with regulator-always-on
>
> See above
>
> > 3. The links I pasted earlier mentions that in USB3.0 the ports need re=
set
> > and this is done before the port is scanned. Adding the similar reset i=
n u-boot
> > fixes all with the same regulator-always-on. AFAIK u-boot doesn't handl=
e
> > this special USB3.0 case and maybe this is why I was finding a few post=
s
> > around the drive not being detected in the USB3.0 port in u-boot but wo=
rks in
> > a USB2.0 port.
>
> I am not disputing the need for USB 3.0 device reset, I believe there
> are two issues here -- one is the hard-wired VBus regulator -- the other
> is this USB 3.0 reset. They should both be fixed.

Sure, agreed 100%.
Do we need to fix both at the same time?
Both patches seem to be independent.

Kind regards,
Shantur
