Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E627BF8FA74
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 13:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7726A83BC8;
	Tue, 21 Apr 2026 15:18:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="JG/Xb7nG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8129983C51; Tue, 21 Apr 2026 15:18:21 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8054383BC4
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso57093155e9.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 06:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776777499; x=1777382299;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NwFrs7Sm4coBbV5Ej1N+P+msjENIUmHKxzvVx0QUMqc=;
 b=JG/Xb7nGiE4d/2I0GAwqh3ulQwdvO1PUzsTxryVdxMmDW7KpFt0XqPl6qUS0xxvylV
 7adzZizSE5SnXV4MF9gkD4hHlnixnWsBaju7LMWDeGPjvgE6mLCEQuub7lbklO7UVsZZ
 uZsCf/ukECvoDugclyA/dsMmpjIronlw6gtpt24NzcoxpUjikuoBPrxiNZ1C4eCke0J8
 rvqfomEaE5KfeGYL3/TXr7Z3tSx6OobFq9vnDFfnoLlXge2F8bOGrko2eHWQ7eTGQnEv
 WiNq6b8UJpSHHnkUCpBQ56264bzjxMik//5Vm/PVK4qer/C/rnYJpu+6mIiOwHvxcJRm
 coIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776777499; x=1777382299;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwFrs7Sm4coBbV5Ej1N+P+msjENIUmHKxzvVx0QUMqc=;
 b=F79qKZra/RhKkmgsJhWsoZn4uZcKNGaBGmgHZ46meVNvpXcYgcKl1YFa9d7y/Xc8PG
 fHYh+1zLGWyyRrnBcX0ZSDAmoXh0UXaL0rO+z/5SMq+lde6uqzCG5BlD6krCmHoFy1mZ
 357ciSRuYeZigB7ZsbsSNW+AIX67O9e0NLr4sUf8NgtJGAeHZptAiPRbHb1tL60o9u5/
 85cbxJcL+xwHJac/YHM5CwOLL/E3G3S6Kuy/+C+txVL9lyJtu0Fv1JY9ORqyprIU8mEN
 HQfK3SyJlZFqMnmN02FbpdFbvawqYhOKpmH67HLXr5ldbZKbZyKRpF6nBgf518n3r6Uq
 NhGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/M35Z+B+vaUAC3jHL9ff24VPKF7qU2rLhCTTvSonlntF4j5C3p4O5+Risy8rczDUXRlEQX1Fk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9OKBeVn9ndLmtYKJQwPGg405lpPBG7EDQfVibvMkN3IdGaSz4
 fao0du/m2kEg8graSW5B79Ez2njRCqAJuQMwxyTeerTGFDpBdF4kPOCDAKq4XEcE62A=
X-Gm-Gg: AeBDieu6N4QjS8Kw2+eVGz3wn4HMyP4CPTOq5iBAoG4zG6zZEiuir/4XEpKiW9uvSc/
 ngJ0hpxtzuxQP6PeTs9qegMGoTLB+PyK94Q3gGygQ67x2Q62DgJRoSdyYd6zq2XhiS903BfYWaD
 ZhHCV5tRYO6KCzd8o63YNiC+BKz4k2g9liA/cFgZrYxCkjb8JLA7S2MSP2DT0BVWY+LwjhaOTX9
 Wlo/cZ7BsWjx2DY+Vu4hZjFh1Mkhh8z8v/Lpy5I4uBOmRt+6ZENTQMgrT4iaWOUl3EztpO0wdzo
 ghtZ+cGrCghmUTY6ZT2buhjbw6RAqC3+Q9oPM8mhI+HSqxtSBSdewe9CXVBnDnKcmKD7e7JhSZO
 3EZHFpjDkh2uFHju/y/TUjgEcaUV3yxN9brR7vfMvoH7UZ3Pq7UiP3KxdXloDiEA3VK5Z/2iI57
 fTT+Hl3BYtMWhgaXT5LEjB7x9MGg==
X-Received: by 2002:a05:600c:4e8f:b0:48a:56cd:5266 with SMTP id
 5b1f17b1804b1-48a56cd549bmr29267135e9.4.1776777498704; 
 Tue, 21 Apr 2026 06:18:18 -0700 (PDT)
Received: from localhost ([62.246.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a52583fe7sm93121845e9.13.2026.04.21.06.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 06:18:18 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=3418c0162d01e621aa9cc83e409070b0230fb3ab63e7546cb2239f3554fc;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 21 Apr 2026 15:18:10 +0200
Message-Id: <DHYV1YMP40HL.1TW21CRX00Q3N@baylibre.com>
Cc: <pratheesh@ti.com>, <j-rameshbabu@ti.com>, <praneeth@ti.com>,
 <vigneshr@ti.com>, <srk@ti.com>, <rogerq@ti.com>, <danishanwar@ti.com>,
 <m-malladi@ti.com>, <krishna@couthit.com>, <mohan@couthit.com>,
 <pmohan@couthit.com>, <basharath@couthit.com>
Subject: Re: [PATCH v2] board: ti: am335x: Conditional MDIO PAD
 configuration instead of static for AM335_ICE
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Markus Schneider-Pargmann" <msp@baylibre.com>, "Parvathi Pudi"
 <parvathi@couthit.com>, <u-boot@lists.denx.de>, <trini@konsulko.com>,
 <Maarten.Brock@sttls.nl>, <kory.maincent@bootlin.com>,
 <sbellary@baylibre.com>, <romain.gantois@bootlin.com>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260421123106.2885994-1-parvathi@couthit.com>
 <DHYUXLAXK8WY.1MYVPQJ729WGO@baylibre.com>
In-Reply-To: <DHYUXLAXK8WY.1MYVPQJ729WGO@baylibre.com>
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

--3418c0162d01e621aa9cc83e409070b0230fb3ab63e7546cb2239f3554fc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Tue Apr 21, 2026 at 3:12 PM CEST, Markus Schneider-Pargmann wrote:
> On Tue Apr 21, 2026 at 2:30 PM CEST, Parvathi Pudi wrote:
>> This patch removes the static MDIO pinmux configuration from
>> rmii1_pin_mux[] and instead configures the MDIO pins conditionally
>> during board_init(). Previously, the MDIO_CLK and MDIO_DATA pins
>> were always configured for CPSW in mux.c, which could lead to
>> unnecessary pin ownership and conflicts in scenarios where CPSW
>> is not used.
>>
>> With this change, the MDIO pins are configured only when required,
>> ensuring that CPSW Ethernet functionality in U-Boot remains unaffected.
>> This approach keeps Ethernet boot behavior intact and provides cleaner
>> separation between CPSW and other Ethernet use cases.
>>
>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
>
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Oops, that was supposed to be

Reviewed-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>

>
> Looks good to me, one nitpick inline:
>
>> ---
>> Changes from v1 to v2 :
>> *) Adressed Markus Schneider-Pargmann's comments on this patch.
>>
>>  board/ti/am335x/board.c | 11 +++++++++++
>>  board/ti/am335x/mux.c   |  2 --
>>  2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
>> index 90e37a8d913..f0a40cb82af 100644
>> --- a/board/ti/am335x/board.c
>> +++ b/board/ti/am335x/board.c
>> @@ -28,6 +28,7 @@
>>  #include <asm/arch/mmc_host_def.h>
>>  #include <asm/arch/sys_proto.h>
>>  #include <asm/arch/mem.h>
>> +#include <asm/arch/mux.h>
>>  #include <asm/global_data.h>
>>  #include <asm/io.h>
>>  #include <asm/emif.h>
>> @@ -72,6 +73,12 @@ static struct ctrl_dev *cdev =3D (struct ctrl_dev *)C=
TRL_DEVICE_BASE;
>>  #define GPIO0_IRQSTATUSRAW	(AM33XX_GPIO0_BASE + 0x024)
>>  #define GPIO1_IRQSTATUSRAW	(AM33XX_GPIO1_BASE + 0x024)
>> =20
>> +static struct module_pin_mux rmii1_mdio_pin_mux[] =3D {
>> +	{OFFSET(mdio_clk), MODE(0) | PULLUP_EN},	/* MDIO_CLK */
>> +	{OFFSET(mdio_data), MODE(0) | RXACTIVE | PULLUP_EN}, /* MDIO_DATA */
>> +	{-1},
>> +};
>> +
>>  /*
>>   * Read header information from EEPROM into global structure.
>>   */
>> @@ -779,6 +786,10 @@ int board_init(void)
>>  			hang();
>>  		}
>> =20
>> +		/* Set the Mux Mode to MDIO_DATA, MDIO_CLK */
>
> I think it is ovious by the names. Can you please remove the comment?
>
> Best
> Markus
>
>> +		if (!eth0_is_mii)
>> +			configure_module_pin_mux(rmii1_mdio_pin_mux);
>> +
>>  		prueth_is_mii =3D eth0_is_mii;
>> =20
>>  		/* disable rising edge IRQs */
>> diff --git a/board/ti/am335x/mux.c b/board/ti/am335x/mux.c
>> index d2d87c304f6..36d849d2119 100644
>> --- a/board/ti/am335x/mux.c
>> +++ b/board/ti/am335x/mux.c
>> @@ -190,8 +190,6 @@ static struct module_pin_mux mii1_pin_mux[] =3D {
>>  };
>> =20
>>  static struct module_pin_mux rmii1_pin_mux[] =3D {
>> -	{OFFSET(mdio_clk), MODE(0) | PULLUP_EN},	/* MDIO_CLK */
>> -	{OFFSET(mdio_data), MODE(0) | RXACTIVE | PULLUP_EN}, /* MDIO_DATA */
>>  	{OFFSET(mii1_crs), MODE(1) | RXACTIVE},		/* MII1_CRS */
>>  	{OFFSET(mii1_rxerr), MODE(1) | RXACTIVE},	/* MII1_RXERR */
>>  	{OFFSET(mii1_txen), MODE(1)},			/* MII1_TXEN */


--3418c0162d01e621aa9cc83e409070b0230fb3ab63e7546cb2239f3554fc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaed5EhsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNz
EQEA7PI3nl8LTPjKjVBr1y5P2wBNymoMRsMXIXTBpUsDwBEBAPuXxMD4uAb3x10n
zzIWQ69jsPCFPvtv91JN8fn7iNgH
=TEK3
-----END PGP SIGNATURE-----

--3418c0162d01e621aa9cc83e409070b0230fb3ab63e7546cb2239f3554fc--
