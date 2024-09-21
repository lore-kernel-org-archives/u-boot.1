Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39E2CF9C64
	for <u-boot@archiver.kernel.org>; Sat, 21 Sep 2024 10:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 366EF88953;
	Sat, 21 Sep 2024 12:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ngN4nDZf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EBBD887FA; Sat, 21 Sep 2024 12:13:54 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32D468878A
 for <u-boot@lists.denx.de>; Sat, 21 Sep 2024 12:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0458C1BF203;
 Sat, 21 Sep 2024 10:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1726913630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zol/KF2OuCW4i6Rq7r+vtUbf4g1GGleYjBthIc84/Nw=;
 b=ngN4nDZfAztYNhT5QfeLuEr3XnH6xH74rVTdmyoc7nWwz6yrScQIPBkXwZlP9nL5dJpRCx
 oVzODOHZdor8SY2kvMJEgVLOQUHjcvbxv7qR/pDSxXlZZoKYO+xE2sh0Q023/ZTbwbqME0
 L1KPo4b2luNHz8CSqewImppRx6bMCKWAHyCZYGKsSfc4jM5jxaSrfp+FDcqX2Rbtfj6Vm0
 uJ70xc4Yeh7cVgf6K7wiZFWh45idoQdyKDOb+8AWCjFe5RHxdCMtcnXEAQGxxWAUklhfb8
 OyPUEsZfT/gHiLCfzOGz7zQM37VYaqtUE4MCLupFrCjkCzFJ3DmK7kilVw1o1Q==
Date: Sat, 21 Sep 2024 12:13:34 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Eddie James <eajames@linux.ibm.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Yang Xiwen
 <forbidden405@outlook.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko
 Schocher <hs@denx.de>, Alexey Romanov <avromanov@salutedevices.com>, Martin
 Kurbanov <mmkurbanov@salutedevices.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Artur Rojek <artur@conclusive.pl>, Leo Yu-Chi
 Liang <ycliang@andestech.com>, Vasileios Amoiridis
 <vassilisamir@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Michael Polyntsov
 <michael.polyntsov@iopsys.eu>, Doug Zobel <douglas.zobel@climate.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, John Crispin
 <john@phrozen.org>
Subject: Re: [PATCH v4 07/11] mtd: implement support for LED activity
Message-ID: <20240921121334.530610b6@xps-13>
In-Reply-To: <20240920225101.2008-8-ansuelsmth@gmail.com>
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
 <20240920225101.2008-8-ansuelsmth@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Christian,

ansuelsmth@gmail.com wrote on Sat, 21 Sep 2024 00:50:00 +0200:

> Implement support for LED activity. If the feature is enabled,
> make the defined ACTIVITY LED to signal mtd write or erase operations.

I'm curious, why did you not consider reads in your proposal? I think
in general as long as you use a device the LED should blink. While
you're performing a read you cannot do anything else with the chip so I
would definitely consider the read path as well.

Also, I would expect the blinking to continue when the device is
accessed, no matter who is asking for it. So for instance when I load
my kernel into RAM, I believe it should blink. Hence, why not
considering the mtd layer rather than the command .c file?

>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  cmd/mtd.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/cmd/mtd.c b/cmd/mtd.c
> index 795aaa2b37d..dae90b0e6e4 100644
> --- a/cmd/mtd.c
> +++ b/cmd/mtd.c

Thanks,
Miqu=C3=A8l
