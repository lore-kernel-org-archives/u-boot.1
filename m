Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5C1C61DF7
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 00:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 079498760A;
	Fri, 24 Nov 2023 01:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="zKKC8gTl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E816E8760C; Fri, 24 Nov 2023 01:37:53 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 250E287613
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 01:37:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507a55302e0so1838512e87.0
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 16:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700786269; x=1701391069;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GzCMeurq1JCH3V9ppOkGE6t3IK16k/YjQO4suqrzlno=;
 b=zKKC8gTlHlBLaCmb8gI2Sn+DLU7i1Xno+xYzVgWm5hg7IKObtBzy1Wqt7M3IZMZj06
 lMjadEpjKfOGqITiNJz12StR02jmyZpLoYDqKODMPwT0naCJkvsUXjDjsQ0gIWh5w4Dr
 ny/A1qL8IQTVNTlJnNeYApif91MU7Tko91BpnTXDXEevdH+/v+d2eRbR+kv9Yu7baenU
 K8U5lbqeoCHdWmU0yDpQ+Qow88FihkLAnacVmYbxcQJ5riXTKxkOKoYtN1Nok7h9hyWk
 0FmZo8zcFXdmFVf8X9dwZiForWXrW6u9ScVjKMwsbIf1iUBspWSVWcfkSpZ34BzSKVvh
 w/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700786269; x=1701391069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GzCMeurq1JCH3V9ppOkGE6t3IK16k/YjQO4suqrzlno=;
 b=luYgut7CPiIx5u3xYbW6B54UCCVk2d6DU8S0y2Y9n8bEiBNzEbs1NtcssZ+XwC3BzV
 FD/0zBdW0gcgbDaBgFO7qUYx70ECBs3aPZrhxyfQlQXv5EyL65keM6cXyinS4zuSV2RX
 r/dQw2D2jBOUCnUA3ydxVunw8TUqMf4mw0Fn+tjLY5Ko8dsFmMjMQKAuhGTs+qQhyw+B
 mmpuz6PqQMMFEpTv9+SZIoMKXqzx6tWzBEqJO7CIRwBkXykEw/6l2a8bibNMwteTlKQ8
 sRh99eUMYWb7BcOEmEMYlSRNb0nMikA/g4CC/B4RGqInYKEOvSH7APS8R1E3A5vyDhTP
 rF+Q==
X-Gm-Message-State: AOJu0Ywgs3EhvkSgdfYBLqpVdZlgF9mWHKq5luaZ8gzzHkp3cgwobmL3
 GrOTXSP4bZwkGaSDlj4ayPZem9mKIFb2ybDg0Um8ew==
X-Google-Smtp-Source: AGHT+IEzUJDBeeqv7rRILpqC5JkS9jlDdrPduTeFvroDRd50xDNu5t3pHLlZpmmQCYW+Fkq980L+kA==
X-Received: by 2002:a05:6512:400d:b0:503:38fe:4590 with SMTP id
 br13-20020a056512400d00b0050338fe4590mr548422lfb.60.1700786269255; 
 Thu, 23 Nov 2023 16:37:49 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com.
 [209.85.218.48]) by smtp.gmail.com with ESMTPSA id
 kg16-20020a17090776f000b00a0371c6cc23sm1369606ejc.95.2023.11.23.16.37.35
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 16:37:39 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-a02c48a0420so187866666b.2
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 16:37:35 -0800 (PST)
X-Received: by 2002:a17:906:693:b0:9fc:9b28:7ff7 with SMTP id
 u19-20020a170906069300b009fc9b287ff7mr708224ejb.60.1700786254272; Thu, 23 Nov
 2023 16:37:34 -0800 (PST)
MIME-Version: 1.0
References: <20231110141311.512334-1-i@shantur.com>
 <a911092c-78e7-469b-abd8-2aeb9f7e28b7@denx.de>
 <CAHc5_t3ddCnKMBNbe8Cc=dZBXvxyke2p5ydU2dbt8Gt8RH43_w@mail.gmail.com>
 <14da0009-8819-4355-8a38-c9fe926ab3f7@denx.de>
 <CAHc5_t0-Mt+-9aBXnD0457YKRyJXHj3oYunq2c35ZaMbmQnqAw@mail.gmail.com>
 <3284f652-49dd-409f-9130-ad7cbce64b32@denx.de>
In-Reply-To: <3284f652-49dd-409f-9130-ad7cbce64b32@denx.de>
From: Shantur Rathore <i@shantur.com>
Date: Fri, 24 Nov 2023 00:37:23 +0000
X-Gmail-Original-Message-ID: <CAHc5_t3t7E+qZrv_KvNNwMDmD9+o+SX3jwv-wq-4gP3d17yBwg@mail.gmail.com>
Message-ID: <CAHc5_t3t7E+qZrv_KvNNwMDmD9+o+SX3jwv-wq-4gP3d17yBwg@mail.gmail.com>
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

On Thu, Nov 23, 2023 at 9:07=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 11/23/23 12:24, Shantur Rathore wrote:
> > Hi Marek,
> >
> > On Thu, Nov 23, 2023 at 12:06=E2=80=AFAM Marek Vasut <marex@denx.de> wr=
ote:
> >>
> >> On 11/20/23 00:03, Shantur Rathore wrote:
> >>> Hi Marek,
> >>
> >> Hi,
> >>
> >>> On Sun, Nov 19, 2023 at 8:53=E2=80=AFPM Marek Vasut <marex@denx.de> w=
rote:
> >>>>
> >>>> On 11/10/23 15:13, Shantur Rathore wrote:
> >>>>> Currently when a hub is turned on, all the ports are powered on.
> >>>>> This works well for hubs which have individual power control.
> >>>>>
> >>>>> For the hubs without individual power control this has no effect.
> >>>>
> >>>> OK
> >>>>
> >>>>> Mostly in these scenarios the hub port is powered before the USB
> >>>>> controller is enabled, this can lead to some devices in unexpected
> >>>>> state.
> >>>>
> >>>> This ^ part needs clarification.
> >>>>
> >>>> Which devices are in incorrect state, the ones connected to the hub
> >>>> downstream facing ports ?
> >>>>
> >>>
> >>> In my case RockPro64, the power to usb ports onboard is controlled by
> >>> a regulator.
> >>> This regulator is enabled as part of init  as here
> >>> https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/rk3399-rock=
pro64.dtsi#L177
> >>>
> >>> On init, the usb devices connected to the port are powered up, in my
> >>> case AM8180 (a RTL9210 based ) NVMe to USB enclosure with UAS.
> >>> But the usb controller is only enabled at 'usb start' and by this tim=
e
> >>> the device is in some state that it doesn't get detected.
> >>>
> >>> One way to make sure the devices connected to the ports are in an
> >>> initialising state is by issuing a port reset before scanning the
> >>> port.
> >>
> >> Why not remove this regulator-always-on and let the PHY driver turn th=
e
> >> VBUS ON only when it is needed ?
> >>
> >> Wouldn't that solve the problem too AND remove unnecessarily enabled
> >> regulator ?
> >>
> >> [...]
> >
> > Removing the regulator-always-on does make it work but there are few is=
sues
> >
> > 1. regulator is used to control power to multiple ports ( USB3.0 and
> > USB2.0 in RockPro64 ),
> > so this could lead to all ports turning off if a phy resets / turns off=
 power
>
> I vaguely recall seeing some refcounting patch for regulator subsystem,
> would that help ?

I don't think this would be a problem for u-boot, but linux maybe.

>
> > 2. Even with regulator-always-on and without this reset port patch,
> > linux was always
> > able to detect the drive on the port, so there is something missing in =
u-boot.
> > 3. Looking at usb hub code in Linux, I found that for USB3.0 it tries
> > to reset the port before
> > scanning. The comment says
> >
> > /* Is a USB 3.0 port in the Inactive or Compliance Mode state?
> >   * Port warm reset is required to recover
> >   */
> >
> > i. https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.c=
#L5736
> > ii. https://github.com/torvalds/linux/blob/master/drivers/usb/core/hub.=
c#L2836
> >
> > I believe this isn't implemented in u-boot and hence explicit reset of
> > a port fixes the issue.
>
> I feel this is separate issue and what needs to be fixed first is the
> hard-wired VBus control.

I beg to differ on this, couple of reasons for this

1. The same drive works fine without being reset on the USB2.0 ports - this
confirms that the issue is related to USB3.0 only.
2. Linux is able to detect the same drive on USB3.0 when u-boot fails - thi=
s
confirms issue doesn't lie with regulator-always-on
3. The links I pasted earlier mentions that in USB3.0 the ports need reset
and this is done before the port is scanned. Adding the similar reset in u-=
boot
fixes all with the same regulator-always-on. AFAIK u-boot doesn't handle
this special USB3.0 case and maybe this is why I was finding a few posts
around the drive not being detected in the USB3.0 port in u-boot but works =
in
a USB2.0 port.

Kind regards,
Shantur
