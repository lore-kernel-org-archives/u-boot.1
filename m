Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD66D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 13:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A283483A6A;
	Mon,  1 Dec 2025 14:14:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="sVNvuzJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D600B83B0B; Mon,  1 Dec 2025 14:14:23 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A71683966
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 14:14:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 87B57C17B4B;
 Mon,  1 Dec 2025 13:13:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AB85E606BB;
 Mon,  1 Dec 2025 13:14:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6C5AB1191817C; Mon,  1 Dec 2025 14:14:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764594859; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=qQzbfbeidRE7ol09U3gV1nsyRa87fr3Cl+bdfGEF5XA=;
 b=sVNvuzJdBqCU1U8GjoaoGpdmOEZd0Kp2s5o+VNLJD8W2lF5VdbN1EKD0Dt8kI3vvrrTUA/
 JqhkNgr0hQc7uhLL4R7rXGX1EQxdy/ui9Q/QGPXqMk8QvXJVTq4RSe+8ro//DoQIRE+RXG
 RY3+wOB3sC/s+ChluWL7vogFYsZZxHXuipsDGFjenwj4+8uMnu1P0FbFBCbhXu/Az0rvrv
 pbOh65GniY7PKsqOs6rehFWGUbdrl8EWMcGdOCxLLCD0ExK3kc9XCqeLspkk9nP/Yj3MGO
 fxq4tDu0K/hkg9Pj+kJz52qc7ex5QvDerYbixqdhMvarDt9zFR8dV6NhoAaD4g==
Date: Mon, 1 Dec 2025 14:14:16 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>, Tom Rini
 <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Parvathi Pudi <parvathi@couthit.com>,
 Basharath Hussain Khaja <basharath@couthit.com>, Paul Barker
 <paul.barker@sancloud.com>
Subject: Re: [PATCH v2 6/7] am33xx: Support upstream devicetree binding
Message-ID: <20251201141416.03333902@kmaincent-XPS-13-7390>
In-Reply-To: <20251128-topic-am33-evm-oftree-v2026-01-v2-6-42a863304498@baylibre.com>
References: <20251128-topic-am33-evm-oftree-v2026-01-v2-0-42a863304498@baylibre.com>
 <20251128-topic-am33-evm-oftree-v2026-01-v2-6-42a863304498@baylibre.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
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

On Fri, 28 Nov 2025 21:46:36 +0100
"Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com> wrote:

> Support musb being probed by ti,musb-am33xx. The non-upstream DT probing
> used a wrapper driver that probed ti-musb-peripheral and ti-musb-host.
> This wrapper registered as UCLASS_MISC, which is why it is requested in
> this board.c file.
>=20
> With the new devicetree the wrapper that registers as UCLASS_MISC is
> gone, instead the UCLASS_USB and UCLASS_USB_GADGET_GENERIC have to be
> requested.
>=20
> Also don't fail if the USB devices are not available.
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  arch/arm/mach-omap2/am33xx/board.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/am33xx/board.c
> b/arch/arm/mach-omap2/am33xx/board.c index
> d7db260513308257f142ea70d5d5c643afc920c9..4bfdb55b2dd5c66cd58bce360cf1c69=
fb7a00cd6
> 100644 --- a/arch/arm/mach-omap2/am33xx/board.c +++
> b/arch/arm/mach-omap2/am33xx/board.c @@ -266,12 +266,16 @@ int
> arch_misc_init(void) struct udevice *dev;
>  	int ret;
> =20
> -	ret =3D uclass_first_device_err(UCLASS_MISC, &dev);
> -	if (ret)
> -		return ret;
> +	if (IS_ENABLED(CONFIG_OF_UPSTREAM)) {
> +		uclass_first_device_err(UCLASS_USB, &dev);
> +		ret =3D uclass_first_device_err(UCLASS_USB_GADGET_GENERIC,
> &dev);
> +	} else {
> +		ret =3D uclass_first_device_err(UCLASS_MISC, &dev);
> +	}
> =20
>  #if defined(CONFIG_DM_ETH) && defined(CONFIG_USB_ETHER)
> -	usb_ether_init();
> +	if (!ret)
> +		usb_ether_init();
>  #endif
> =20
>  	return 0;

You are losing the error return value here.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
