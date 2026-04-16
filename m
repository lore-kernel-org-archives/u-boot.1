Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EC7F43841
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 07:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AD0483FC0;
	Thu, 16 Apr 2026 09:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="T+hwW5vg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34EF8840AB; Thu, 16 Apr 2026 09:53:49 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3B5B8352B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 09:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4887f49ec5aso92476845e9.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 00:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776326026; x=1776930826;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RGsGKpVtvhKPzDSmr/fxpHKP68S3fXLOp9eYzCqUOOE=;
 b=T+hwW5vgLg/EfT+ZgExRZHO2mYrGsSIrzmYKZhIA76V29T80Ibk9W88E39KIvVU9QV
 1lF4pQO4isXf4uzXVidmu8r7MPawhVjEFy87jyYJl6YDxqiom8b0ZvN0a4y4nW5pTMEC
 jPh3NsMUwQdFmAeG098n5BGYWVRbZX+m9F/Ga69lCX3ODGwiQYP8LBzJdrJwMsMeHtUJ
 0y9ZXBHoQ5UTVOrOeOeN54C18wUgLVn/quqmkP/ZwbS4AwzRav7V1+GtsNodfcBwtbGq
 8ZIgLqMO0ZZ4nzjAAe5e0ZFNE9llie1n6mzMBqPSQ62Xuk24QRzj+WwYBc6Q+Cg07wYa
 i3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776326026; x=1776930826;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RGsGKpVtvhKPzDSmr/fxpHKP68S3fXLOp9eYzCqUOOE=;
 b=dsq8UP7/Fp68OTYDmZf1KjiLiBcehFqqEhC3eP+1DMKpK9X8evjDJg34P5bEpkf7yW
 zkYxQy3X7fpGIvDP+OAkN55PYSTHMSf4FW5r0s6oPS8W5EPKFCr53dnf34FmYKHrR4ZD
 ZDjBn6p+le/KNdHg7AOOVE2kplDK1qYveMB4JYreJfHarna/+Ic9iZKGWKC21boaUPjq
 n8xHDyLE3adMOYMve45AA0qc1qgpJGhmcm3nm5VcQFDWFrhyL1rQkbb7in7qsfvcMn4Y
 0bw1pWjNP+ry6DoG/O18UqP/UDbHz+M+gobc4JplC+rc3SYq9mAj/ecQ6fhN5i6U1Tbd
 xkeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lEeJ7oGxuXWWxwdAgib4pirR8zgbLnUnPWku2ThaSMX/xlGTZ03+Q/8ND0EkwLB4w3Iysir0=@lists.denx.de
X-Gm-Message-State: AOJu0YycXA3uXUZ032pzhLAhxGrH5IzYQc+H0brwTyBKxJHJLXTg1LW6
 iRfPllTRR4LgNk3vrFpwfcOUScFdZZUndQ6LUYcFyU3jZ0ZZaKUUtvzAgvXJepuT4Fs=
X-Gm-Gg: AeBDiethG+WewESMGOzE7byO4dV6FnWzVn45d+bLkgjB74GdwZoWyMBvGJm9IbASCas
 QTnFR0PVdCj7V3brcWo9V3jL9pOluSydF7hd7/TMSKYL6OeWbAezyBfsGzts+TgW7/BdctQFmR9
 1LnJgL/fyeXPtGuH6ZGtqI/+U2Z3i1z1goRHxgaU/nQBPQE0Mf3uF4uBwufMjKqxHaI8kl3JI87
 MtZkFmRhtnDVDABAkDS6qX0HILKekxWPWSWFxQaJDFgcBN7l0ZmAznmx4154iDLfqH7GEDy/jFH
 oqSRq0KDKzwTxxefMNrzSDjwV7m6lD/sAdX5zIV3qtYIjctc3xJsrHxcGcsEbO6swxuf2aK2R6N
 m8da2JYjmCBOOmUUTNvzFWGUeA+X0dOappaWBEwtbjKg5VoOD2NGhjZRmEUVYMFYAW9X1p1JqGG
 jQJW34FuQXRf3plyokiy5GN3yPrw==
X-Received: by 2002:a05:600c:34cc:b0:488:869c:edaf with SMTP id
 5b1f17b1804b1-488d67d882cmr353689835e9.8.1776326026260; 
 Thu, 16 Apr 2026 00:53:46 -0700 (PDT)
Received: from localhost ([62.246.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f581d836sm30627395e9.7.2026.04.16.00.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 00:53:45 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=f2f73e8c14f9c9a9f483b4b7f8fb60b9d6367944501bc3effe2f022f9e68;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 16 Apr 2026 09:53:37 +0200
Message-Id: <DHUF0R06L66I.OSJLU3XXXRAJ@baylibre.com>
Cc: <pratheesh@ti.com>, <j-rameshbabu@ti.com>, <praneeth@ti.com>,
 <vigneshr@ti.com>, <srk@ti.com>, <rogerq@ti.com>, <danishanwar@ti.com>,
 <m-malladi@ti.com>, <krishna@couthit.com>, <mohan@couthit.com>,
 <pmohan@couthit.com>, <basharath@couthit.com>
Subject: Re: [PATCH] board: ti: am335x: Conditional MDIO PAD configuration
 instead of static for AM335_ICE
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Parvathi Pudi" <parvathi@couthit.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <Maarten.Brock@sttls.nl>,
 <kory.maincent@bootlin.com>, <msp@baylibre.com>, <sbellary@baylibre.com>,
 <romain.gantois@bootlin.com>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260407082402.2311644-1-parvathi@couthit.com>
In-Reply-To: <20260407082402.2311644-1-parvathi@couthit.com>
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

--f2f73e8c14f9c9a9f483b4b7f8fb60b9d6367944501bc3effe2f022f9e68
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Parvathi,

On Tue Apr 7, 2026 at 10:22 AM CEST, Parvathi Pudi wrote:
> This patch removes the static MDIO pinmux configuration from
> rmii1_pin_mux[] and instead configures the MDIO pins conditionally
> during board_init(). Previously, the MDIO_CLK and MDIO_DATA pins
> were always configured for CPSW in mux.c, which could lead to
> unnecessary pin ownership and conflicts in scenarios where CPSW
> is not used.
>
> With this change, the MDIO pins are configured only when required,
> ensuring that CPSW Ethernet functionality in U-Boot remains unaffected.
> This approach keeps Ethernet boot behavior intact and provides cleaner
> separation between CPSW and other Ethernet use cases.

Do you have a specific use case here?

>
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> ---
>  board/ti/am335x/board.c | 22 ++++++++++++++++++++++
>  board/ti/am335x/mux.c   |  2 --
>  2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
> index 90e37a8d913..abeab809387 100644
> --- a/board/ti/am335x/board.c
> +++ b/board/ti/am335x/board.c
> @@ -61,6 +61,18 @@ DECLARE_GLOBAL_DATA_PTR;
>  #define GPIO_ETH0_MODE		GPIO_TO_PIN(0, 11)
>  #define GPIO_ETH1_MODE		GPIO_TO_PIN(1, 26)
> =20
> +#define AM335X_PIN_MDIO	0x948
> +#define AM335X_PIN_MDC		0x94c

These two are not aligned when applied.

> +
> +#define GPIO_MDIO_DATA		CTRL_BASE + AM335X_PIN_MDIO
> +#define GPIO_MDIO_CLK		CTRL_BASE + AM335X_PIN_MDC
> +
> +/* Enabling MDIO_DATA by setting MUX_MODE to 0, RXACTIVE, PULLUP_EN bits=
 */
> +#define PAD_CONFIG_MDIO_DATA	0x30
> +
> +/* Enabling MDIO_CLK by setting MUX_MODE to 0, PULLUP_EN bit */
> +#define PAD_CONFIG_MDIO_CLK	0x10
> +
>  static struct ctrl_dev *cdev =3D (struct ctrl_dev *)CTRL_DEVICE_BASE;
> =20
>  #define GPIO0_RISINGDETECT	(AM33XX_GPIO0_BASE + OMAP_GPIO_RISINGDETECT)
> @@ -779,6 +791,16 @@ int board_init(void)
>  			hang();
>  		}
> =20
> +		if (!eth0_is_mii || !eth1_is_mii) {

eth0_is_mii and eth1_is_mii is the same, as it was checked in the
if condition above this one. You could make this an else if as well if
you like.

> +			/* Set the Mux Mode to MDIO_DATA */
> +			reg =3D readl(GPIO_MDIO_DATA);
> +			writel(reg & PAD_CONFIG_MDIO_DATA, GPIO_MDIO_DATA);
> +
> +			/* Set the Mux Mode to MDIO_CLK */

Please remove comments for code that shows the same thing.

> +			reg =3D readl(GPIO_MDIO_CLK);
> +			writel(reg & PAD_CONFIG_MDIO_CLK, GPIO_MDIO_CLK);

Could you do the same thing in enable_board_pin_mux()? Or would it be
possible to reuse mux.h here to avoid redefining values etc.?

Why do you use reg & PAD_CONFIG_MDIO_CLK instead of writing
PAD_CONFIG_MDIO_CLK directly and skip the read?

> +		}
> +

This snippet is in the section guarded by these:

  #if defined(CONFIG_CLOCK_SYNTHESIZER) && (!defined(CONFIG_XPL_BUILD) || \
    (defined(CONFIG_SPL_ETH) && defined(CONFIG_XPL_BUILD)))
    if (board_is_icev2()) {

Is this the same as for the original pinmux setup?

Best
Markus

--f2f73e8c14f9c9a9f483b4b7f8fb60b9d6367944501bc3effe2f022f9e68
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaeCVgRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPi
dwEAjYQPztUdrntNrxlRfBpziPfI8mUoHTdcFXrUbjrMe90BAMVRj60F+FBh7ApO
LhA6Tg9cdCwpmlh/zdCXDpzPu/8F
=SrMA
-----END PGP SIGNATURE-----

--f2f73e8c14f9c9a9f483b4b7f8fb60b9d6367944501bc3effe2f022f9e68--
