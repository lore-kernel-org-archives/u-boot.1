Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B668C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 20:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E210888D5;
	Mon, 15 Jul 2024 22:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="kBFOT8rg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33D7E888D4; Mon, 15 Jul 2024 22:50:15 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF172887E6
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 22:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1721076610; x=1721681410; i=frank-w@public-files.de;
 bh=Lo0s3qNp2TZLgBBIfpPkLjrFZbjhyvy4tid1MAEnZ/4=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
 Content-Type:Date:In-Reply-To:References:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=kBFOT8rgWIJ+ZFD/dqhtwXb1nNjWfk0QWVcVNU5P70XzqAuXXWHUMsNWsJbsDdmL
 x+4J85v2Q9dcFHQkXG5d2NhZh59JoWUxiJwocQUviYBXn1yr2yviUSCi+OjFv11py
 a0bM4ExP/fU19Gw/q3HZXWQl+vQUwcgEhG6f9geu6MtAdmr9tY51KMD+3Rm8g+5DM
 wO+ciCOt833dT8n5Ahdu4kK/pCPjTEmRba36F2EFmrxUTZILZ5XArw6TXFD8bxvPb
 Khbtx7fR6RFCQFXjo3meMPSqkU+PnxQyg52dAQMzcKB8BI7auvPYOQeTPjcEmo5Jl
 jZkx3Msohfz17hy/Rg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.157.130] ([217.61.157.130]) by web-mail.gmx.net
 (3c-app-gmx-bs14.server.lan [172.19.170.66]) (via HTTP); Mon, 15 Jul 2024
 22:50:10 +0200
MIME-Version: 1.0
Message-ID: <trinity-eed391ff-b254-4e52-a79e-febc2d406618-1721076610706@3c-app-gmx-bs14>
From: Frank Wunderlich <frank-w@public-files.de>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Daniel Golle <daniel@makrotopia.org>, "Christian
 Marangi (Ansuel)" <ansuelsmth@gmail.com>, John Crispin <john@phrozen.org>
Subject: Aw: Re: avoid syscon fallback class for getting regmap
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jul 2024 22:50:10 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAFLszTiBhrQPMJNS8sjY-jnq8TFnqdWxutyU2NXPit2RZJczhA@mail.gmail.com>
References: <trinity-c68bf542-baa7-4122-858b-c6d5ef8bf843-1720619007870@3c-app-gmx-bs04>
 <CAFLszTiBhrQPMJNS8sjY-jnq8TFnqdWxutyU2NXPit2RZJczhA@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:pDjC1C1XzUL3vfHTti6oso4rCdqVOY0tDaZj7KDvs1mt0Ls7BOGNwae7F61cEJt6lWScc
 fEvnRIPG4C0+MYI8LXZy4YmxfAIfY0mddHQnoTreUS25aMZC/d0okcXLog+v+l5JsvtGKxVPsz8j
 mNIpUBBqS8nlGFzn0ddYPZAXeVDtY2/bg0B+sqTB2r3lBzcNpGU2iuHR//5Kbu97JltKDK/zCM4x
 U5Qhc8XpY3Au4Vb6rmZwI2ny8x+1SQEP1noDyfI65TX80atCV7uWdaelL3F3PXq+hOmF82fLFQBh
 OY=
UI-OutboundReport: notjunk:1;M01:P0:nNE4ybMiKjE=;msL2jHFLvauLr6p/HpB8VjwqfXd
 7tsk/D07JFdMvWYnqmA9Cs/IcG29n6HrKc/MsCY81mT2V689nZxpA1/MgTeW6R+9xohtF9fSD
 qPBgM4Mk+XrHqAqw9A37YFH+6R7t6I7WZP95bgMHOXEhBmvwecjwZKjQ9seNQDFk606icfQ3H
 wU/UHSRG8lNjF7W693Wao1hzhIhfs60AOrxlghple7EM17Y/oOMgmb78wE+2pvTIWTjRbArjl
 5ltCkPeCO6RNqkFxhMWpthP6IApX5nF4dUWMMTHsRd9CZ7UsOsq0k0Mp6E78qeIhzGt/xsmU6
 A750w+GV8klJGBjYbixzeGkKPK4teJd3sldh54iivXrzoMD8VcKg1C1pBcASjdKvD78W8YGuV
 e7b3//o18JvYR25sY/OSikJQNLJ3AZ6MP9/4mfuaElwECmSTQNDD+749R3/OeeDdxBuO2moxF
 14DRfjnQH0a+MJcqXX99JzgGhXxMB9uCypdy5BQxeAhZ47iZm33gIRfbNt8gfIsJbBcT5K4ID
 FlYBpBPIqr4EdLyNsVQAtynzptfgKTWlVVEuvMAfrQV7HSd5t+4ChUx2P/tQFgR8U/nqXA997
 FEYSoPrxM0xZGgH1HIo/oV6w5OOtQonreSKFyS4sQ9Cjgn7GI9730zI5AZA2NThVQsdnXOsNl
 qr7E1pgJuyUoXX6XqgnXGXB7hYBVU8PG2clkisVyLw==
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

> Gesendet: Samstag, 13. Juli 2024 um 17:13 Uhr
> Von: "Simon Glass" <sjg@chromium.org>
> Betreff: Re: avoid syscon fallback class for getting regmap
>
> Hi Frank,
>
> On Wed, 10 Jul 2024 at 14:43, Frank Wunderlich <frank-w@public-files.de>=
 wrote:
> >
> > Hi,
> >
> > i'm working on OF_UPSTREAM for mediatek boards and noticed missing sys=
con-fallback on some (mt7988) devicetree nodes.
> >
> > i know that u-boot uses this fallback to get the regmap shared across =
drivers, but only initializing once with the syscon_uclass.
> >
> > i tried adding the syscon-fallback to linux device tree and got pointe=
d [1] back to uboot to solve the issue there...
> >
> > are there any ways to avoid syscon in device tree and get the regmap o=
f different node?
> >
> > i guess i could use [2], but then it is possible to aquire same regmap=
 multiple times which may result in issues (e.g. race-conditions).
> > I also want to avoid creating multiple drivers doing the exactily same=
 thing like syscon.
> >
> > one easy (but maybe unwanted way) is to add all compatibles for affect=
ed syscons to the syscon driver...but then it is no more generic (baed on =
compatibles then vendor-specific).
>
> One option is to create a new driver in a new file and have its ops
> use the syscon ops. See for example
> arch/arm/mach-rockchip/rk3399/syscon_rk3399.c

Hi Simon,

thanks for the suggestion, but i have not got it working yet


still fails here (drivers/net/mtk_eth.c):

		priv->xfi_pll_regmap =3D syscon_node_to_regmap(args.node);

this is how i tried:
https://github.com/frank-w/u-boot/commit/a1060c88152fe8aa8a092f087591240f9=
30146b3

do i miss something (i guess i do not need the data-field as i only need t=
he regmap)?

regards Frank

