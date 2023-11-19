Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23949C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 23:04:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4977F87527;
	Mon, 20 Nov 2023 00:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="vw573gMx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526A98752B; Mon, 20 Nov 2023 00:04:15 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D9D83CF3
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 00:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9e1021dbd28so518794566b.3
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700435039; x=1701039839;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UHIBfgv5jRxA1yLnxnyMh2HM5qeuT5f62bJRLDRXHbQ=;
 b=vw573gMxobrnALHEMfoJqUx5h0F5sX0CWl0PKXBhbM85EEGPZzjYz3fHwlSBHH4ZAK
 iTDoDb5vSg3kk0tvM+h5mFPlAUzrhMUv8sUMeP5pBk2tHdncpveakHIZjPWDRJRQ6EOG
 pd7gUz4PiP9O2/0CgUjCaChy6OrkMHjI0x+vuNxAKe28hNctS/M8h6upB8v/JFSlEEiN
 q9oxArpq4SAXAKBfvAsEusXpiLJuplHwtC06EbYwKewTvhGXJ3N4mMJBUtkOYENf6kaa
 QZNsii346Day5/A1hyG9vqI0rHe2s9qtfeYjq9OJrd6WrLLP24/4Fx9DQ6ds8DsyMZGF
 x5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700435039; x=1701039839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UHIBfgv5jRxA1yLnxnyMh2HM5qeuT5f62bJRLDRXHbQ=;
 b=qYap6G7/X2fj38nZzd/LB+7G/eYGIEMJztpAa5op5UdaNWKJ1oB9OaRBdxfnqhE3/0
 HUAFU7sDI5hKXxAYh13VUSa8EEPcWgQXmkps8PazByzl47Kb307wg9EuGtbheAyItf0x
 YtcmLLmwHxBZ0jnQAKwCA4Nv+SNf5r5CUhQsCRXbJMx2lArR7e8v81h1HkYH52Ywo2Aq
 t+zRMXoFlgs6x78HlJYIa1ZM+2gUl67pFTvHNJCEm2HRe7ihyU77Yg5d0HvkGcOJzCM3
 MzJLvWs7+yFOBBkKqWoQdOW29P3EguBVL4u+uwNiiHbmivtfSbjnhk8QmT5LFNz0PnL7
 4S8g==
X-Gm-Message-State: AOJu0YxDblg3OfIF362dtDWgoNY7wjgPzCoeI6OLrvBc4YXWdf3Ohg2h
 cmiqYKbsaTJHuSuS0C59uPWv/AHaCdiq2Zlknv+vdJvU
X-Google-Smtp-Source: AGHT+IGhuPz+Mnqc+OaDfCMQWJb6MyVCUHGbgIJmb/BIZdZ1mAN5/XUjJNWq6Rqzzpwku+ySUy3f6g==
X-Received: by 2002:a17:906:2acf:b0:9dd:7b77:a37c with SMTP id
 m15-20020a1709062acf00b009dd7b77a37cmr4077852eje.57.1700435038633; 
 Sun, 19 Nov 2023 15:03:58 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com.
 [209.85.208.41]) by smtp.gmail.com with ESMTPSA id
 r7-20020a170906280700b009cc1e8ed7c5sm3271637ejc.133.2023.11.19.15.03.58
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Nov 2023 15:03:58 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-548d1f8b388so14467a12.0
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:03:58 -0800 (PST)
X-Received: by 2002:aa7:c511:0:b0:53d:d879:34f3 with SMTP id
 o17-20020aa7c511000000b0053dd87934f3mr4762069edq.1.1700435037924; Sun, 19 Nov
 2023 15:03:57 -0800 (PST)
MIME-Version: 1.0
References: <20231110141311.512334-1-i@shantur.com>
 <a911092c-78e7-469b-abd8-2aeb9f7e28b7@denx.de>
In-Reply-To: <a911092c-78e7-469b-abd8-2aeb9f7e28b7@denx.de>
From: Shantur Rathore <i@shantur.com>
Date: Sun, 19 Nov 2023 23:03:46 +0000
X-Gmail-Original-Message-ID: <CAHc5_t3ddCnKMBNbe8Cc=dZBXvxyke2p5ydU2dbt8Gt8RH43_w@mail.gmail.com>
Message-ID: <CAHc5_t3ddCnKMBNbe8Cc=dZBXvxyke2p5ydU2dbt8Gt8RH43_w@mail.gmail.com>
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

Hi Marek,

On Sun, Nov 19, 2023 at 8:53=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 11/10/23 15:13, Shantur Rathore wrote:
> > Currently when a hub is turned on, all the ports are powered on.
> > This works well for hubs which have individual power control.
> >
> > For the hubs without individual power control this has no effect.
>
> OK
>
> > Mostly in these scenarios the hub port is powered before the USB
> > controller is enabled, this can lead to some devices in unexpected
> > state.
>
> This ^ part needs clarification.
>
> Which devices are in incorrect state, the ones connected to the hub
> downstream facing ports ?
>

In my case RockPro64, the power to usb ports onboard is controlled by
a regulator.
This regulator is enabled as part of init  as here
https://github.com/u-boot/u-boot/blob/master/arch/arm/dts/rk3399-rockpro64.=
dtsi#L177

On init, the usb devices connected to the port are powered up, in my
case AM8180 (a RTL9210 based ) NVMe to USB enclosure with UAS.
But the usb controller is only enabled at 'usb start' and by this time
the device is in some state that it doesn't get detected.

One way to make sure the devices connected to the ports are in an
initialising state is by issuing a port reset before scanning the
port.

> > With this patch, we explicitly reset the port while powering up hub
> > This resets the port for hubs without port power control and has
> > no effect on hubs with port power control as the port is still off.
>
> Should common/usb_hub.c usb_hub_port_connect_change() trigger the reset?
>
> Could it be you do not get a connect change event ?

Yes, that's correct there is no connect change event while scanning the por=
t.

>
> > Before this patch AMicro AM8180 based NVME to USB adapter won't be
> > detected as a USB3.0 Mass Storage device but with this it works as
> > expected.
>
> Do you have HUB power control ?
>
> I recall there was some companion hub discussion recently.

The onboard ports don't have separate power control, only the
regulator as explained above.

Kind regards,
Shantur
