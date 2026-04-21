Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C67DF8FA73
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 13:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C48D83C51;
	Tue, 21 Apr 2026 15:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="yl5BBj/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2AC083E36; Tue, 21 Apr 2026 15:12:41 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7102B83A91
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:12:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso33255645e9.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 06:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776777159; x=1777381959;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IFm9sO/NFzfNysPF3K7l6pPZQEpdtvoEauJaOMo6jxw=;
 b=yl5BBj/DivAycWyMAj1PHUEZllsOiThj61CHzd3Mqb/zXd3QFzpYFsAsfm3wqFvlkk
 6wWoD+ILQgTL2k5s1mOk7XiVZWvxB2/wFutOxwWwgghhVEKl+mZw6hdXYx3Gc/0IsIU3
 WvmyJEOwn1IRNAPtjPZFEj8KJg0Vk7rnezVc+zBNxYs/j9smj8HYY0csnwEcAZtHeqls
 pcmF0gFA44ZVKSpp7vLZGNC/09UtglWD0Opqfyxc8Q0kChMg9ToTgRS+prBGKlehunaF
 i4rJN38UXNk0bw66VIPuyZJoBh/qD4QxEMtPMH5dEMFYMGLdFUULcrhjvvmuc/mIocFG
 E23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776777159; x=1777381959;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFm9sO/NFzfNysPF3K7l6pPZQEpdtvoEauJaOMo6jxw=;
 b=lXeXGARBTdO8M1tfL3Pc5yFWvmkxbN9PBCThqtyqEfbdUb1IXuFKQZNBr0KcOJxmPL
 3KZM9amFvsvcMyYMejNQ52933jAX0MM/D23BgQVHDDEXbqtROIF43cYOKxra//icbkVt
 BNiVxuZ0DAkPsckk0E4g0+zHgN7wLC0mu1iRDCVtd+eqoilP9MssK84aLUG2Ie07tYqg
 NFghy+xw/dAnBxIq9G1dAnyg4adZksKsYhtJqpnO+mSn+BBVMHAu+vU57ZnaL4IjhrFc
 8C1G26j/br68vQ7s/xa6MD1ZYiGjJ0BcyeJbOqkdjloqMq6w9c/ot+/i723qeP4J1oQ6
 YzwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+e07aOnG+h6lY1BVEfbHv8I0moGxSjqqS5kGfwCxzuQzzLLw6bm7CdBGZ9Hi9V7xjBygDRBBk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz3svs0Ootsz7zRbA7eNN5Xt/zWXU4Dflq4oa8sqrLBwnMaYr7i
 YkPytpz3JAERgyDN/2ZococU92sxeB6BRX8euh+Z3EsDxRKjedtQYBHyyH3nN4/a4lc=
X-Gm-Gg: AeBDievEDi+6JjmqT9FxFRERKpPNZJW4dWV+eHvfZh8TT8u8vC/nEq28Mg3/37JpzA3
 waSyGVWvRXoGa5VsmIIj8TFIXhiq3A/Mbpu3XdcH4AfDAVLEEb9J8Gxw/WWB5pMbB8YCadt7zKc
 51XmRRMoTAmTRKxekr/nDOmQqzvfT4Y2Q9j0Y2mlhX9nRBcJNZU98fbvn23pk0HTP2Lsp9kwPWs
 CC5tYbxhE5ntSZ+AAOnS3OAtWL2Si1qio0u2Gkf7PnSZih2qcq6266ZXVgkjtJIsqC05Uf1HiHt
 t649XgJ4KrzYR4m+Kv28t/inXiwu66OLGNhsrm0+8J1yTNkyoKB8zEs9aOlFCgI5XRu73gKBUW8
 lpuwx4IOUxNdJY72+mFzyG5V1NyfJ6iyoCDt6EbhV/1ET98EO7DCfM1UtL6AgpH9i2S+OvBvECq
 kn0OC0ftOlnuF8V576GUtodX55tg==
X-Received: by 2002:a05:600c:1da1:b0:488:f453:b976 with SMTP id
 5b1f17b1804b1-488fb7844c5mr287107005e9.27.1776777158809; 
 Tue, 21 Apr 2026 06:12:38 -0700 (PDT)
Received: from localhost ([62.246.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891978ef6bsm81082155e9.4.2026.04.21.06.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 06:12:37 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=87877e700a9a669c98cdb06f2bbfcc947d973bf787dc51a12144d055e49d;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 21 Apr 2026 15:12:27 +0200
Message-Id: <DHYUXLAXK8WY.1MYVPQJ729WGO@baylibre.com>
Cc: <pratheesh@ti.com>, <j-rameshbabu@ti.com>, <praneeth@ti.com>,
 <vigneshr@ti.com>, <srk@ti.com>, <rogerq@ti.com>, <danishanwar@ti.com>,
 <m-malladi@ti.com>, <krishna@couthit.com>, <mohan@couthit.com>,
 <pmohan@couthit.com>, <basharath@couthit.com>
Subject: Re: [PATCH v2] board: ti: am335x: Conditional MDIO PAD
 configuration instead of static for AM335_ICE
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Parvathi Pudi" <parvathi@couthit.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <Maarten.Brock@sttls.nl>,
 <kory.maincent@bootlin.com>, <msp@baylibre.com>, <sbellary@baylibre.com>,
 <romain.gantois@bootlin.com>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260421123106.2885994-1-parvathi@couthit.com>
In-Reply-To: <20260421123106.2885994-1-parvathi@couthit.com>
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

--87877e700a9a669c98cdb06f2bbfcc947d973bf787dc51a12144d055e49d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Apr 21, 2026 at 2:30 PM CEST, Parvathi Pudi wrote:
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
>
> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Looks good to me, one nitpick inline:

> ---
> Changes from v1 to v2 :
> *) Adressed Markus Schneider-Pargmann's comments on this patch.
>
>  board/ti/am335x/board.c | 11 +++++++++++
>  board/ti/am335x/mux.c   |  2 --
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
> index 90e37a8d913..f0a40cb82af 100644
> --- a/board/ti/am335x/board.c
> +++ b/board/ti/am335x/board.c
> @@ -28,6 +28,7 @@
>  #include <asm/arch/mmc_host_def.h>
>  #include <asm/arch/sys_proto.h>
>  #include <asm/arch/mem.h>
> +#include <asm/arch/mux.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
>  #include <asm/emif.h>
> @@ -72,6 +73,12 @@ static struct ctrl_dev *cdev =3D (struct ctrl_dev *)CT=
RL_DEVICE_BASE;
>  #define GPIO0_IRQSTATUSRAW	(AM33XX_GPIO0_BASE + 0x024)
>  #define GPIO1_IRQSTATUSRAW	(AM33XX_GPIO1_BASE + 0x024)
> =20
> +static struct module_pin_mux rmii1_mdio_pin_mux[] =3D {
> +	{OFFSET(mdio_clk), MODE(0) | PULLUP_EN},	/* MDIO_CLK */
> +	{OFFSET(mdio_data), MODE(0) | RXACTIVE | PULLUP_EN}, /* MDIO_DATA */
> +	{-1},
> +};
> +
>  /*
>   * Read header information from EEPROM into global structure.
>   */
> @@ -779,6 +786,10 @@ int board_init(void)
>  			hang();
>  		}
> =20
> +		/* Set the Mux Mode to MDIO_DATA, MDIO_CLK */

I think it is ovious by the names. Can you please remove the comment?

Best
Markus

> +		if (!eth0_is_mii)
> +			configure_module_pin_mux(rmii1_mdio_pin_mux);
> +
>  		prueth_is_mii =3D eth0_is_mii;
> =20
>  		/* disable rising edge IRQs */
> diff --git a/board/ti/am335x/mux.c b/board/ti/am335x/mux.c
> index d2d87c304f6..36d849d2119 100644
> --- a/board/ti/am335x/mux.c
> +++ b/board/ti/am335x/mux.c
> @@ -190,8 +190,6 @@ static struct module_pin_mux mii1_pin_mux[] =3D {
>  };
> =20
>  static struct module_pin_mux rmii1_pin_mux[] =3D {
> -	{OFFSET(mdio_clk), MODE(0) | PULLUP_EN},	/* MDIO_CLK */
> -	{OFFSET(mdio_data), MODE(0) | RXACTIVE | PULLUP_EN}, /* MDIO_DATA */
>  	{OFFSET(mii1_crs), MODE(1) | RXACTIVE},		/* MII1_CRS */
>  	{OFFSET(mii1_rxerr), MODE(1) | RXACTIVE},	/* MII1_RXERR */
>  	{OFFSET(mii1_txen), MODE(1)},			/* MII1_TXEN */


--87877e700a9a669c98cdb06f2bbfcc947d973bf787dc51a12144d055e49d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaed3vRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOd
pwD/U+JtRLMM/jFf3swcf0e9wDh6qu5tL/Np7Kv+1G+/5EsBAKTiLuO0h7tMmN9S
pIQbinTcUPfroFVPdAi9qLv+p5YH
=6z9q
-----END PGP SIGNATURE-----

--87877e700a9a669c98cdb06f2bbfcc947d973bf787dc51a12144d055e49d--
