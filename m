Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A22AC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 18:16:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EC0E87660;
	Sat,  9 Dec 2023 19:16:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="XMjh1+Vm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 470208765B; Sat,  9 Dec 2023 19:16:02 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D25088764C
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 19:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b8903f7192so2188837b6e.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 10:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1702145758; x=1702750558;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HlPWZ9fle7qROzBdzXkZdFXHPnzJiq1KzB2ShOf83Q=;
 b=XMjh1+VmUKjX5e9UkFpr/Vawni7OAKGv0kHHVD2yxpFiXNt3+vQjicUM67aZDUwQ2P
 PzvVJ9DlVt42wOegIIcL3qUoS74Ng2sNnBFaFVCyaqi6auzQtz8j4g0AXxkMqKseM4JC
 xht3ghzAgJD2LT7/GnvCKml69kxq49cDnnXJM9dZKq7tqQQZPBSusb9sdZsbq2QVhNWV
 clujR17mBowIVhnooDA5fsq9A2jOsHrXG5U3/uxpvg2HvmnWwMrrXS4myumWxuy/z5yz
 U54tkgzMzDI0rRu4ui9iAU7eqPFBkEaB6HffHd9p+cJiI9O1UVs+l5gz/FerxIIVhETL
 v7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702145758; x=1702750558;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2HlPWZ9fle7qROzBdzXkZdFXHPnzJiq1KzB2ShOf83Q=;
 b=Z9nLQ0pVFCUbu1VbM+jnAO55aYdRDpJCqJQteFhYNNXi80rTAgwdsC4h/57RfgGJLZ
 mbLEzvAip5DY2Ezsv/das5IG6QDjgHNLFRZVrVvmKfckB14Yu3tvwFPJQZYnxIPphzeX
 ahfpzLDoktmb+CIt0BhwuJydrgDyae6wFXJk2/LjGVORNXZzJ+DjaXZz9+TMFxagL39u
 GYX/8Fn+BpI+RsG4HLCJld8wnjUVdDXF8GjfKlAPwMcR4o2axJCnQ44sErHJ8Ugk5NLz
 47hrgcpW05rwrrxiojCR2YyFa7zBt3JDfk/iRG71VZvKfq9w0TcPPnexUmJVeDO0bw9b
 +NzA==
X-Gm-Message-State: AOJu0YznH7ANYSUrcoRyWLavn5h/UwBCxA1WwRkXWRJklu1hxzbNEgbu
 Bo1FyLRZSnWLlyDYb6K8mMkrlLPzysLSigPQFTcRGw==
X-Google-Smtp-Source: AGHT+IGZR7woH7WpFk4GUXfd3SSzOb6a6ur/c9oXB7Bzs/Rj8A02HuRHGVJs2HHq5xDpbFlFmFNfRZvLIIQaL/fOZQY=
X-Received: by 2002:a05:6808:1598:b0:3b6:b071:3079 with SMTP id
 t24-20020a056808159800b003b6b0713079mr2098672oiw.27.1702145758475; Sat, 09
 Dec 2023 10:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20231208000947.248849-1-i@shantur.com>
 <20231208000947.248849-3-i@shantur.com>
 <edd57912-f38f-4589-bb21-c638db8535e1@denx.de>
 <CABEcMwWA1FzdPtvRBwk_9KaXC12R1OCDMoOtuFSvuG8XhphQdQ@mail.gmail.com>
In-Reply-To: <CABEcMwWA1FzdPtvRBwk_9KaXC12R1OCDMoOtuFSvuG8XhphQdQ@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Sat, 9 Dec 2023 18:15:47 +0000
Message-ID: <CABEcMwVu=qTFgbg0D9MteUVE55Sq_s=sSHn1fPNfHK2_voMpBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dts: rockpro64: Disable usb regulators-always-on
To: Marek Vasut <marex@denx.de>
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, 
 Jagan Teki <jagan@amarulasolutions.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
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

Hi Marek,

On Sat, Dec 9, 2023 at 5:57=E2=80=AFPM Shantur Rathore <i@shantur.com> wrot=
e:
>
> Hi Marek,
>
> On Sat, Dec 9, 2023 at 5:31=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
> >
> > On 12/8/23 01:09, Shantur Rathore wrote:
> > > USB port regulators should be controlled by phys
> >
> > PHYs
> >
> > > so we remove always-on property and let phy manage the
> > > regulator.
> > >
> > > Typec port has misconfugred
> >
> > misconfigured (typo)
>
> Thanks will fix both typos in v3
>
> >
> > > phy-supply in upstream and
> > > now that we are removing always-on, we need to fix the
> > > phy-supply until its fixed upstream.
> >
> > Where is the upstream Linux kernel patch ?
> > Was it submitted already ?
> >
>
> No, there is no patch yet for this in Linux upstream.
>
> > You should send this patch separately, it doesn't depend on the USB Hub
> > 1/2 patch and will go in through different (rockchip) tree.
>
> Sure, I will split and send v3 for these now.

These have been split to

[0] - https://patchwork.ozlabs.org/project/uboot/patch/20231209181057.33181=
5-1-i@shantur.com/
[1] - https://patchwork.ozlabs.org/project/uboot/patch/20231209180437.33096=
9-1-i@shantur.com/

Thanks,
Shantur
