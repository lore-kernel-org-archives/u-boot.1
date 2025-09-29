Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D13CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 07:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA1768206E;
	Mon, 29 Sep 2025 09:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="iTsSngPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A1FF82A9E; Mon, 29 Sep 2025 09:23:44 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E6F8808AF
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 09:23:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7FC1F104026; Mon, 29 Sep 2025 09:23:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1759130621;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=TButxOMizUGYxT8sjCaL2l+2s5LaPBmwh0FiRR1XE2g=;
 b=iTsSngPo6tTisuo7MApPumrDjzqZUtjdu7JFIdcu9yf6Vq8JpKPzXysQwGkroWNDwT+GTS
 tMn302shbn0LaFnYzdnMxL9i9ItjZUZ2DCScWJpLlOjVwfXRt0ZbuNlNmIx2Volk95J1iK
 rddtlqirpg5H71Iv7fGmweM+i5dOh3k+A9QkYSxWHtzqim7/zFDmeGopWoAqDpRb1CT1gN
 rXd6ZELWmPrkN8lA66yusQNNcEnI1dU0qtieWvLwdVFSvAlS9SjYdf4r/7xPtGG8euIv5Q
 TVMQ9nM6LsrLZim8euPqJ3kl/iQloOCDtxFSy9LGmfNfoRZDJJuAoJWaol1jkg==
Date: Mon, 29 Sep 2025 09:23:38 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2] arm: gpio: Add set_flags callback to the Tegra gpio
 driver
Message-ID: <20250929092338.08d6b00a@wsk>
In-Reply-To: <CAPVz0n2iw7xZWFH46=fF3aPRjwx5QvQ0=yxY=v4tusNBj3qMvw@mail.gmail.com>
References: <20250922141617.225861-1-lukma@nabladev.com>
 <CAPVz0n2iw7xZWFH46=fF3aPRjwx5QvQ0=yxY=v4tusNBj3qMvw@mail.gmail.com>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Svyatoslav,

> =D0=BF=D0=BD, 22 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 17:16 Lu=
kasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > This patch adds support for the .set_flags callback.
> > For now following flags are supported:
> > - GPIOD_IS_AF (i.e. "alternate function").
> > - GPIOD_IS_IN
> > - GPIOD_IS_OUT
> >
> > Currently, the .set_flags in gpio-uclass.c (function
> > dm_gpio_set_value()) is used before .set_value callback, so
> > functionally replaces it. As a result the corresponding
> > tegra_gpio_set_value() can be removed.
> >
> > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > ---
> >
> > Changes for v2:
> > - Fix the format specifier for flags in debug() function
> > - Update commit message
> > - Remove tegra_gpio_set_value() method (as it is functionally
> > replaced by set_value()
> > - Prevent from returning errors when flags =3D 0 (problem with e.g.
> > I2C GPIO support)
> > ---
> >  drivers/gpio/tegra_gpio.c | 39
> > +++++++++++++++++++++++---------------- 1 file changed, 23
> > insertions(+), 16 deletions(-)=20
>=20
> Lukasz, thank you for this change I would really like to see it in
> mainline. ATM I have no capabilities to debug=20

You mean test if it works?

> this and I will return
> to it but that may not be soon unfortunately.

This is a bit problematic for me, as:

1. Some future work depends on it (more details below).
2. The "set_flags()" callback seems like being now the one to be
advised to being implemented and used.=20



Can you predict when you will be able to come back to this task? Is
this the matter of weeks or months?

> In case you really need
> switch GPIO back to SFIO and Linux cannot handle this, you an use
> dm_gpio_free to release gpios in board_preboot_os in the board as a
> temporary measure.

Yes, this is a temporary solution - i.e. dm_gpio_free() is supposed to
"free" the pin. IMHO, the set_flags() shall be used, as I in fact do
want to set the CFG_SFIO flag, not release the gpio.

>=20
> Overall issue you are describing is not u-boot's it is kernels, kernel
> must reconfigure gpios for proper work regardless of their previous
> state. If it is not the case, then kernel device configuration is
> incomplete or wrong.

This is how the pinmux in Linux for Tegra is written. You can setup the
PAD parameters, but you cannot set the pin's function.

In other words - you have to do it in bootloader (u-boot in this case).

In my case - customer uses the pin in u-boot as GPIO to check carrier
board version, then the same pin in Linux is going to be used as
special function one.

Unfortunately, above "reconfiguration" cannot be done in Linux.=20

As other "rework" of gpio code depends on it (use dm) - I would like to
postpone my work until this functionality is available in mainline (and
hence avoid "temporal solutions").

--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
