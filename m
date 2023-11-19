Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF2FC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 23:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1F2E869C4;
	Mon, 20 Nov 2023 00:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="N5B4OkTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B658A87527; Mon, 20 Nov 2023 00:35:15 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49241869C4
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 00:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-543923af573so5403394a12.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700436910; x=1701041710;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EgoaaPIi1r/r/TUs7UJrWECPGNWlKkDgvKg6aGxGstc=;
 b=N5B4OkTDLPlrn5PEOmKZzFTSjlT51PaSQt8X3azhN16E6TXnGH/ZL95WA6+Q66UZ/x
 YTjZ9/7cteYZ8g8sLp0bUIB1KND3rq+8wlwhiCYWmb1kR4jchknCEfvj36g9HJeM+qQc
 +LKOnyvieTq8BhIy8t2mVH9Fh/P1gMYQitQj0AZShd/cKcTt1p15nX+kPQiFmtB2zMdg
 yrobuIDxvttUnWNWvXHkyLrxya3PXLXizY2wdrsZUWg9WhqlhGeyD7j8nnYFEUaFlgik
 bhRd1z/e+2L07fshg1PiBjWHssf1D/+bTYs5qdbkNSYTisRGezsa1E4ns+SSDwwtIbd5
 zXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700436910; x=1701041710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EgoaaPIi1r/r/TUs7UJrWECPGNWlKkDgvKg6aGxGstc=;
 b=Vdu5CXZ7yjI7pXeLWZJY9/v9+QXvyv6dZcnGa7WWdB5Egrv9Sl8qH4QKymh93Q0lTH
 XiujAL8zdtDHHqycDcH11eQWzojVBEMipstqDvMBvncF4KKUmN6YYo2Sngse1MysyZA3
 l706ROlw6tUy5SRVKZx3pst2MIHVcSOEATHKQRT9ZFWNz0t54FK2K4eeIsO2MkXvDS1l
 pmiKJ9o9mu5DJMOwURyjgYot0Q4KMr9Jwj3nkiyLe0JGU8EBhCT4Ykxv2iYaMqRE2p9u
 A8fnP5gGqvM562smALn/oMYtWa7v9C/uu5r1UBTY4dJ544ziwMxLCO0k+C+lVKUZQmBu
 vfmQ==
X-Gm-Message-State: AOJu0Yx/KFsin/IuhtPSuxbZYN7MjNMd6fPCDO+3euW/NbtaBK9zMHwG
 qcBDzvIyfKiO+dL8A3LHi2fBDCvrlj1yN7S4Hf6mgRWS
X-Google-Smtp-Source: AGHT+IG1c9uWXPV6qACdZIcPm2p7iPwurmOeKPjyCAtSPx7elktBz9lGjN1wf/uK2YDjGhcAOkX7Vw==
X-Received: by 2002:aa7:d342:0:b0:547:9f26:e581 with SMTP id
 m2-20020aa7d342000000b005479f26e581mr4654298edr.37.1700436910422; 
 Sun, 19 Nov 2023 15:35:10 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com.
 [209.85.208.50]) by smtp.gmail.com with ESMTPSA id
 v9-20020aa7dbc9000000b005484ee5c856sm2616670edt.86.2023.11.19.15.35.09
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Nov 2023 15:35:10 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-53e08b60febso5393778a12.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:35:09 -0800 (PST)
X-Received: by 2002:a05:6402:2044:b0:548:4e53:99a7 with SMTP id
 bc4-20020a056402204400b005484e5399a7mr4951530edb.23.1700436909560; Sun, 19
 Nov 2023 15:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20231110141311.512334-1-i@shantur.com>
 <a911092c-78e7-469b-abd8-2aeb9f7e28b7@denx.de>
 <CAHc5_t3ddCnKMBNbe8Cc=dZBXvxyke2p5ydU2dbt8Gt8RH43_w@mail.gmail.com>
In-Reply-To: <CAHc5_t3ddCnKMBNbe8Cc=dZBXvxyke2p5ydU2dbt8Gt8RH43_w@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Sun, 19 Nov 2023 23:34:58 +0000
X-Gmail-Original-Message-ID: <CAHc5_t3H0bajJjB1ViEvWKvCsTvczN49bvnNBG=JZ9BOO53CoQ@mail.gmail.com>
Message-ID: <CAHc5_t3H0bajJjB1ViEvWKvCsTvczN49bvnNBG=JZ9BOO53CoQ@mail.gmail.com>
Subject: Re: [PATCH] common: usb-hub: Reset hub port before scanning
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
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

On Sun, Nov 19, 2023 at 11:03=E2=80=AFPM Shantur Rathore <i@shantur.com> wr=
ote:
>
> Hi Marek,
>
> On Sun, Nov 19, 2023 at 8:53=E2=80=AFPM Marek Vasut <marex@denx.de> wrote=
:
> >
> > On 11/10/23 15:13, Shantur Rathore wrote:
> > > Currently when a hub is turned on, all the ports are powered on.
> > > This works well for hubs which have individual power control.
> > >
> > > For the hubs without individual power control this has no effect.
> >
> > OK
> >
> > > Mostly in these scenarios the hub port is powered before the USB
> > > controller is enabled, this can lead to some devices in unexpected
> > > state.
> >
> > This ^ part needs clarification.
> >
> > Which devices are in incorrect state, the ones connected to the hub
> > downstream facing ports ?
> >
>
> In my case RockPro64, the power to usb ports onboard is controlled by
> a regulator.
> This regulator is enabled as part of init  as here
> https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/rk3399-rockpro6=
4.dtsi#L177
>
> On init, the usb devices connected to the port are powered up, in my
> case AM8180 (a RTL9210 based ) NVMe to USB enclosure with UAS.
> But the usb controller is only enabled at 'usb start' and by this time
> the device is in some state that it doesn't get detected.
>
> One way to make sure the devices connected to the ports are in an
> initialising state is by issuing a port reset before scanning the
> port.
>
> > > With this patch, we explicitly reset the port while powering up hub
> > > This resets the port for hubs without port power control and has
> > > no effect on hubs with port power control as the port is still off.
> >
> > Should common/usb_hub.c usb_hub_port_connect_change() trigger the reset=
?
> >
> > Could it be you do not get a connect change event ?
>
> Yes, that's correct there is no connect change event while scanning the p=
ort.
>
> >
> > > Before this patch AMicro AM8180 based NVME to USB adapter won't be
> > > detected as a USB3.0 Mass Storage device but with this it works as
> > > expected.
> >
> > Do you have HUB power control ?
> >
> > I recall there was some companion hub discussion recently.
>
> The onboard ports don't have separate power control, only the
> regulator as explained above.
>
> Kind regards,
> Shantur

PS:

If the usb device is kept disconnected on init but connected after 'usb sta=
rt'
while U-boot is scanning usb buses but hasn't scanned the bus the
device is connected to, the usb storage device is detected.

Also, I just tried -
https://patchwork.ozlabs.org/project/uboot/list/?series=3D379807
and it doesn't fix the issue.
