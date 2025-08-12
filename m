Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0715FC87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 16:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4178E82E37;
	Tue, 12 Aug 2025 18:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=yngvason.is header.i=@yngvason.is header.b="iusLmd2Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1876833FC; Tue, 12 Aug 2025 18:10:51 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94EDA80107
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 18:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=yngvason.is
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andri@yngvason.is
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e91781e34dfso1243144276.3
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yngvason.is; s=google; t=1755015048; x=1755619848; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOlDVu20MipTXULAol44lTdbzJzci8onOGXQSQ1SF8k=;
 b=iusLmd2YJ7spP5HG4qDrZ3aDhv+XXzFi2wrqixDhjmDsZuPKIR1NJlrVduEpPo4C1E
 yHW121c4Co8H0dkDhaY64BQhzKjy6OD2bvA50NE0vpTFzDsaHI3V3TuIvznFvuXEDcRV
 5SiD5TFUnkhRfm/ewmCSfBO64lKkYMuLqwcQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755015048; x=1755619848;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UOlDVu20MipTXULAol44lTdbzJzci8onOGXQSQ1SF8k=;
 b=j50PphO3mbbh0XHgiHRg65ExhWdtca8FS33ac7dhS5x5n0kCcYhHZUgS6oFxF3wewZ
 f6HwrRvEd5/4rDx2YLEyQlYCpnZ/Wjph2OwQsdeor1ldxDVTAbxbPSIr3O2yopw/i9D7
 SaoSJzRJlbfHqo9VADd1pl+8ktF2MJv5/POhOqrhuQc+X/J2bxmk2M4Gallhpt2+Wb7A
 hHAxqjhtwZZ65NzvCnbYsFgDEfWmTYCvhBaajtjn+h22sfED9X/g7Tah2sbTcesPQvbl
 mPGmY+JQSE+quyujxsaa+Xywbjik/pBTIqTPtdAa9G8AZdGx1ms5sXNXFeeNQmZUqtMQ
 oA/A==
X-Gm-Message-State: AOJu0Ywi8/0p/IViIRGnNOgqhjlbVhPcqJyHSQUvIwH6idDYInxjtKRX
 p1itgGKhD7hTew5i/Z9EzBck4pmsZ0PfgZ4MZbfolT/NsmJE5eQtt1GxiMME1t8guwUPhoe7W/d
 7Me5X6z5jwhOwxVNRT5Su8ucTGItbP8GC/yOtgmxGTQ==
X-Gm-Gg: ASbGncs3H8NmUE7wo7oGstkNFfaUwEUzY/yuNKh+MszdioRS7wnwj6JsPglD8Ni8JzY
 AQ69sVRn4MYFHTLGK1lKgjnEHmk9oucZ0/t+M7Xa39gCri8aKDVFHB9TEGsm9pjVHwGuzooOrTW
 AUuXApXQo/+xdCk1T2df/yxv0XH2fxhVBoMRz9JkE/CghK/SljQDL6sFSusDLMDbWWE4yQ9W8iq
 JBPow+//Zu5sUvBQPu8MwO4zkYiLv8yFVeO4fE=
X-Google-Smtp-Source: AGHT+IEtUFFyNeuJqKRiQkL3KphUyKgWJga9toQQF8nl8wtv0hTAFl6x2TzlJEExjlgL4TLrI08jjdlZH7rfihVIk5U=
X-Received: by 2002:a05:690c:6d93:b0:71c:1a46:48d3 with SMTP id
 00721157ae682-71d4ce68c16mr1626157b3.31.1755015048139; Tue, 12 Aug 2025
 09:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250812153048.2775200-1-andri@yngvason.is>
 <20250812155951.GW124814@bill-the-cat>
In-Reply-To: <20250812155951.GW124814@bill-the-cat>
From: Andri Yngvason <andri@yngvason.is>
Date: Tue, 12 Aug 2025 16:10:12 +0000
X-Gm-Features: Ac12FXwrNECVZNFgC1BgSu_1fX5ZW1nSHXCDRjvznn958lDoCBkPfDrbNgaCosI
Message-ID: <CAFNQBQzpOej99AE3ZXdTdV7r0o7p6AE8cVeuADHWLkMeTvZRBg@mail.gmail.com>
Subject: Re: [PATCH] drivers: led: Add WS28XX compatible LED driver
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

=C3=BEri., 12. =C3=A1g=C3=BA. 2025 kl. 15:59 skrifa=C3=B0i Tom Rini <trini@=
konsulko.com>:
>
> On Tue, Aug 12, 2025 at 03:30:18PM +0000, Andri Yngvason wrote:
> > This is a new LED driver for the WS28XX family of LED controllers from
> > Worldsemi and compatible devices from other manufacturers.
> >
> > The LED chain must be connected to an SPI output. This driver uses SPI
> > to emulate the required digital signal.
> >
> > Each LED gets a fixed colour assigned to it in the device tree.
> >
> > Signed-off-by: Andri Yngvason <andri@yngvason.is>
> > ---
> >  doc/device-tree-bindings/leds/leds-ws28xx.txt |  48 ++++
>
> We have dts/upstream/Bindings/leds/ now, so this needs to be upstream
> and the driver compatible with that. If the driver is already
> compatible, we can just omit adding this file. Thanks.
>

There does not exist a compatible driver in the Linux kernel. Are you
saying that I also need to implement this for the Linux kernel for
this to be accepted into u-boot?

I have also written a driver for Linux, but I have no intention of
upstreaming it as it is much too complex to fit into the LED
subsystem.

Thanks,
Andri
