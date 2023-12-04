Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C734C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 11:00:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CB1587640;
	Mon,  4 Dec 2023 12:00:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="CL3A2mK+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FB6E870B7; Mon,  4 Dec 2023 12:00:00 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03E0C87617
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 11:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a18f732dc83so734128766b.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 02:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1701687596; x=1702292396;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7EAOCcRGWdCd+gH116tYHqaprJZlfl1W1m+D2ACeRk=;
 b=CL3A2mK+ylYCyynJd/lFac2Dhfz7ZAf7Ot3+vCNjvXMJ3xIdUVMIRvoHinAjEO3Myd
 clD9ajbZZ89JhLZ+ZEH+0PB7qdvIP9NRKpnDK7muwI12+n/XpExhBoBk1S1/eUWJxjRx
 A9xduYApHqhT28n5J2PoTLkkA/38/VrzRvReb8fsA63upj8vl+J4bkL4X4YyDFEJqMsY
 T+bp2lpW0iCfWOvb4i9URkidH6Bo8yxzjzQw+xKjEiUAsOKhyxO1ebvXz4ild1sHA4Uj
 Icq0CfRjVPvKfWag/7sWxONCZjfaB2IJ4eSvFFRMVKe0vh7C9dXXpy4IYroHWJ3InZ1o
 XS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701687596; x=1702292396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v7EAOCcRGWdCd+gH116tYHqaprJZlfl1W1m+D2ACeRk=;
 b=FR2X4TwHoKrBfTBzGcpKOdjEnyi6y87+XB0v4L4aIYMCyJ38T56MCZPA6l+zHIId7+
 e96UMVonknTAiWAYhs+b+ucax9biPOZifQ9GUN7runuNx7gWipdRX4WuYWQfEc2kZ/h2
 XyuEDF/8cmtIejARK0xZXYzIvULGaRE4Ifj21h06ZNaAucMjLNy7Atc+dXP/vjxWjuq0
 bAgGEG5ZfmZ8H9auyNFQYRSYSJdJPQZLQTWV6aUFLH4ulxitHU62qvP/FPs4ZZVyxlto
 yym6DITzerPBkr5Z6ZDTF4qa0qcu9hVdVr0LDEtoj4enQ7CrVRrPwvwuEeokwzwniPwq
 ykPA==
X-Gm-Message-State: AOJu0YymCYkFPmukAql+9zThDJw+VC5FPLdpugPmPD+t1r7x7i4WZnk/
 V+Tfs6DkmbHF5+0C2AIIrDIdoroHd/mSg2F8T2+GM5/K
X-Google-Smtp-Source: AGHT+IGIs1WFS7F5OAEdEdw7NRLX71o3ckKUpRjW6gtJAfNHq6YGTz3FCVkRP7xIpXCYW2VXHf5aZg==
X-Received: by 2002:a17:906:2202:b0:9ff:889c:c2ff with SMTP id
 s2-20020a170906220200b009ff889cc2ffmr5475948ejs.22.1701687595815; 
 Mon, 04 Dec 2023 02:59:55 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com.
 [209.85.218.42]) by smtp.gmail.com with ESMTPSA id
 gs20-20020a170906f19400b00a18374ade6bsm5154474ejb.67.2023.12.04.02.59.55
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 02:59:55 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-a18ebac19efso738096766b.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 02:59:55 -0800 (PST)
X-Received: by 2002:a17:906:eb4f:b0:a16:1b4a:a6fa with SMTP id
 mc15-20020a170906eb4f00b00a161b4aa6famr5233302ejb.8.1701687595003; Mon, 04
 Dec 2023 02:59:55 -0800 (PST)
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
In-Reply-To: <093a6f33-7ce3-4cbf-b1f5-9aba9f85c615@denx.de>
From: Shantur Rathore <i@shantur.com>
Date: Mon, 4 Dec 2023 10:59:43 +0000
X-Gmail-Original-Message-ID: <CAHc5_t1Nfrt9p-jiVDPsx1ro4tNjRmyXR48OZtSoggGudeLJJQ@mail.gmail.com>
Message-ID: <CAHc5_t1Nfrt9p-jiVDPsx1ro4tNjRmyXR48OZtSoggGudeLJJQ@mail.gmail.com>
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

On Sun, Dec 3, 2023 at 10:37=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 12/3/23 22:42, Shantur Rathore wrote:
> > Hi Marek,
> >
> > On Sun, Dec 3, 2023 at 8:42=E2=80=AFPM Marek Vasut <marex@denx.de> wrot=
e:
> >>
> >> On 11/24/23 01:37, Shantur Rathore wrote:
> >>> Hi Marek,
> >>
> >> Hi,
> >>
> >> sorry for the late reply.
> >>
> >>>>>>> In my case RockPro64, the power to usb ports onboard is controlle=
d by
> >>>>>>> a regulator.
> >>>>>>> This regulator is enabled as part of init  as here
> >>>>>>> https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/rk3399-=
rockpro64.dtsi#L177
> >>>>>>>
> >>>>>>> On init, the usb devices connected to the port are powered up, in=
 my
> >>>>>>> case AM8180 (a RTL9210 based ) NVMe to USB enclosure with UAS.
> >>>>>>> But the usb controller is only enabled at 'usb start' and by this=
 time
> >>>>>>> the device is in some state that it doesn't get detected.
> >>>>>>>
> >>>>>>> One way to make sure the devices connected to the ports are in an
> >>>>>>> initialising state is by issuing a port reset before scanning the
> >>>>>>> port.
> >>>>>>
> >>>>>> Why not remove this regulator-always-on and let the PHY driver tur=
n the
> >>>>>> VBUS ON only when it is needed ?
> >>>>>>
> >>>>>> Wouldn't that solve the problem too AND remove unnecessarily enabl=
ed
> >>>>>> regulator ?
> >>>>>>
> >>>>>> [...]
> >>>>>
> >>>>> Removing the regulator-always-on does make it work but there are fe=
w issues
> >>>>>
> >>>>> 1. regulator is used to control power to multiple ports ( USB3.0 an=
d
> >>>>> USB2.0 in RockPro64 ),
> >>>>> so this could lead to all ports turning off if a phy resets / turns=
 off power
> >>>>
> >>>> I vaguely recall seeing some refcounting patch for regulator subsyst=
em,
> >>>> would that help ?
> >>>
> >>> I don't think this would be a problem for u-boot, but linux maybe.
> >>
> >> How so ?
> >
> > Actually, I am wrong. I wasn't sure if there is refcounting for the
> > regulator subsystem
> > in linux. just found it has so this is null and void.
> >
> >>
> >>>>> 2. Even with regulator-always-on and without this reset port patch,
> >>>>> linux was always
> >>>>> able to detect the drive on the port, so there is something missing=
 in u-boot.
> >>>>> 3. Looking at usb hub code in Linux, I found that for USB3.0 it tri=
es
> >>>>> to reset the port before
> >>>>> scanning. The comment says
> >>>>>
> >>>>> /* Is a USB 3.0 port in the Inactive or Compliance Mode state?
> >>>>>     * Port warm reset is required to recover
> >>>>>     */
> >>>>>
> >>>>> i. https://github.com/torvalds/linux/blob/master/drivers/usb/core/h=
ub.c#L5736
> >>>>> ii. https://github.com/torvalds/linux/blob/master/drivers/usb/core/=
hub.c#L2836
> >>>>>
> >>>>> I believe this isn't implemented in u-boot and hence explicit reset=
 of
> >>>>> a port fixes the issue.
> >>>>
> >>>> I feel this is separate issue and what needs to be fixed first is th=
e
> >>>> hard-wired VBus control.
> >>>
> >>> I beg to differ on this, couple of reasons for this
> >>>
> >>> 1. The same drive works fine without being reset on the USB2.0 ports =
- this
> >>> confirms that the issue is related to USB3.0 only.
> >>
> >> This is a separate issue from the hard-wired VBus control. I agree the
> >> issue does exist, I would simply like to avoid conflating the hard-wir=
ed
> >> VBus control with device reset.
> >>
> >>> 2. Linux is able to detect the same drive on USB3.0 when u-boot fails=
 - this
> >>> confirms issue doesn't lie with regulator-always-on
> >>
> >> See above
> >>
> >>> 3. The links I pasted earlier mentions that in USB3.0 the ports need =
reset
> >>> and this is done before the port is scanned. Adding the similar reset=
 in u-boot
> >>> fixes all with the same regulator-always-on. AFAIK u-boot doesn't han=
dle
> >>> this special USB3.0 case and maybe this is why I was finding a few po=
sts
> >>> around the drive not being detected in the USB3.0 port in u-boot but =
works in
> >>> a USB2.0 port.
> >>
> >> I am not disputing the need for USB 3.0 device reset, I believe there
> >> are two issues here -- one is the hard-wired VBus regulator -- the oth=
er
> >> is this USB 3.0 reset. They should both be fixed.
> >
> > Sure, agreed 100%.
> > Do we need to fix both at the same time?
> > Both patches seem to be independent.
>
> Separate patch for the regulator please .

Thanks, I am working on the regulator patch for rk3399-rockpro64-u-boot but
there seems to be a bug in the rk3399-rockpro64.dtsi from linux where
the typec phy
is configure with wrong regulator and if I do the patch as below

--- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
@@ -22,6 +22,23 @@
        };
 };

+&vcc5v0_host {
+       /delete-property/ regulator-always-on;
+};
+
+&vcc5v0_typec {
+       /delete-property/ regulator-always-on;
+};
+
+&vcc5v0_usb {
+       /delete-property/ regulator-always-on;
+       /delete-property/ regulator-boot-on;
+};

The typec port won't work until I correct the issue with

+&u2phy1_host {
+       phy-supply =3D <&vcc5v0_typec>;
+};
+

What would be acceptable here?
1. Leave regulator for typec as it was
2. disable regulator-always-on and fix phy here.

Kind regards,
Shantur
