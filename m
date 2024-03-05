Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0084DC54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 08:55:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CE1F87FF4;
	Tue,  5 Mar 2024 09:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=walle.cc header.i=@walle.cc header.b="n7xadHeW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8B9087FEE; Tue,  5 Mar 2024 09:55:44 +0100 (CET)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1F6487FF4
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 09:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=walle.cc
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=michael@walle.cc
Received: from localhost (unknown [213.135.10.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by mail.3ffe.de (Postfix) with ESMTPSA id 530C32AA;
 Tue,  5 Mar 2024 09:55:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2022082101; t=1709628941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=TKkoBP6KmAMr92k4UibA7aIX8tov/9pikXnbx8Gy0V0=;
 b=n7xadHeWVHQy/gZD0L0W5ThRprS/xfpEWo85qmk2fixJ9UsqqxWCbwCDIv0Mllu2SOgobd
 8X6n7Vwio4Ts5p5isALOJRSWaxp+0SR1BXkr6fCRpcL77qE8CrZHM4JXA9KFkginj4vaBC
 euzoJ77hxPq49WhzpTo066jEwdC4rQoRAemNPw6KCIbUusCGhYLf7dAl7F1NXNfn6W6o5X
 ZmPi6OEnB1lI/a3fWQqoj2RKeU1Xa4k3F7Uj1jxkWKscmi+LrcgBxq9dlD1veiKbm2UOur
 pTpfvVASeWG9QtImgjUCU2q2U8e7Pc51TdgES9KrFLTTz0+dt0cQVZZc1NW3xQ==
Content-Type: multipart/signed;
 boundary=acf4be2f55090aa1dcc23d2f9a6b39a9e383484571a9d1d3dff03dfb8e4c;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Tue, 05 Mar 2024 09:55:30 +0100
Message-Id: <CZLOVK212G8L.2ISEL1IIWU1YE@walle.cc>
Subject: Re: [PATCH] mtd: spi-nor: Clear Winbond SR3 WPS bit on boot
Cc: "Hai Pham" <hai.pham.ud@renesas.com>, "Heinrich Schuchardt"
 <xypron.glpk@gmx.de>, "Jagan Teki" <jagan@amarulasolutions.com>, "Johann
 Neuhauser" <jneuhauser@dh-electronics.com>, "Simon Glass"
 <sjg@chromium.org>, "Takahiro Kuwano" <Takahiro.Kuwano@infineon.com>,
 "Venkatesh Yadav Abbarapu" <venkatesh.abbarapu@amd.com>, "Vignesh R"
 <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>
From: "Michael Walle" <michael@walle.cc>
To: "Marek Vasut" <marex@denx.de>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.16.0
References: <20240304161607.82759-1-marex@denx.de>
In-Reply-To: <20240304161607.82759-1-marex@denx.de>
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

--acf4be2f55090aa1dcc23d2f9a6b39a9e383484571a9d1d3dff03dfb8e4c
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

[+ linux-mtd ]

Hi Marek,

On Mon Mar 4, 2024 at 5:16 PM CET, Marek Vasut wrote:
> Some Winbond SPI NORs have special SR3 register which is
> used among other things to control whether non-standard
> "Individual Block/Sector Write Protection" (WPS bit)
> locking scheme is activated. This non-standard locking
> scheme is not supported by either U-Boot or Linux SPI
> NOR stack so make sure it is disabled, otherwise the
> SPI NOR may appear locked for no obvious reason.

I don't think it is a good idea to just disable the WPS bit.
Usually, that bit is non-volatile and the default is not set. Thus,
there is likely someone, probably the manufacturer of the board,
who intentionally set this bit. Now, with this patch it will get
disabled *unconditionally*, forever.

-michael

> W25Q16DW, but the W25Q16DW does not implement the SR3 WPS bit.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Hai Pham <hai.pham.ud@renesas.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Johann Neuhauser <jneuhauser@dh-electronics.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> Cc: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mtd/spi/spi-nor-core.c | 47 ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spi-nor.h    |  5 ++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-cor=
e.c
> index 9a1801ba93d..68dee57258d 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -544,6 +544,24 @@ static int read_cr(struct spi_nor *nor)
>  }
>  #endif
> =20
> +/**
> + * read_sr3() - Read status register 3 unique to newer Winbond flashes
> + * @nor:	pointer to a 'struct spi_nor'
> + */
> +static int read_sr3(struct spi_nor *nor)
> +{
> +	int ret;
> +	u8 val;
> +
> +	ret =3D nor->read_reg(nor, SPINOR_OP_RDSR3, &val, 1);
> +	if (ret < 0) {
> +		dev_dbg(nor->dev, "error %d reading SR3\n", ret);
> +		return ret;
> +	}
> +
> +	return val;
> +}
> +
>  /*
>   * Write status register 1 byte
>   * Returns negative if error occurred.
> @@ -554,6 +572,17 @@ static int write_sr(struct spi_nor *nor, u8 val)
>  	return nor->write_reg(nor, SPINOR_OP_WRSR, nor->cmd_buf, 1);
>  }
> =20
> +/**
> + * write_sr3() - Write status register 3 unique to newer Winbond flashes
> + * @nor:	pointer to a 'struct spi_nor'
> + * @val:	value to be written into SR3
> + */
> +static int write_sr3(struct spi_nor *nor, u8 val)
> +{
> +	nor->cmd_buf[0] =3D val;
> +	return nor->write_reg(nor, SPINOR_OP_WRSR3, nor->cmd_buf, 1);
> +}
> +
>  /*
>   * Set write enable latch with Write Enable command.
>   * Returns negative if error occurred.
> @@ -3890,6 +3919,24 @@ static int spi_nor_init(struct spi_nor *nor)
>  		write_enable(nor);
>  		write_sr(nor, 0);
>  		spi_nor_wait_till_ready(nor);
> +
> +		/*
> +		 * Some Winbond SPI NORs have special SR3 register which is
> +		 * used among other things to control whether non-standard
> +		 * "Individual Block/Sector Write Protection" (WPS bit)
> +		 * locking scheme is activated. This non-standard locking
> +		 * scheme is not supported by either U-Boot or Linux SPI
> +		 * NOR stack so make sure it is disabled, otherwise the
> +		 * SPI NOR may appear locked for no obvious reason.
> +		 */
> +		if (JEDEC_MFR(nor->info) =3D=3D SNOR_MFR_WINBOND) {
> +			err =3D read_sr3(nor);
> +			if (err > 0 && err & SR3_WPS) {
> +				write_enable(nor);
> +				write_sr3(nor, err & ~SR3_WPS);
> +				write_disable(nor);
> +			}
> +		}
>  	}
> =20
>  	if (nor->quad_enable) {
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 2861b73edbc..ceb32e3906f 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -45,6 +45,8 @@
>  #define SPINOR_OP_WRSR		0x01	/* Write status register 1 byte */
>  #define SPINOR_OP_RDSR2		0x3f	/* Read status register 2 */
>  #define SPINOR_OP_WRSR2		0x3e	/* Write status register 2 */
> +#define SPINOR_OP_RDSR3		0x15	/* Read status register 3 */
> +#define SPINOR_OP_WRSR3		0x11	/* Write status register 3 */
>  #define SPINOR_OP_READ		0x03	/* Read data bytes (low frequency) */
>  #define SPINOR_OP_READ_FAST	0x0b	/* Read data bytes (high frequency) */
>  #define SPINOR_OP_READ_1_1_2	0x3b	/* Read data bytes (Dual Output SPI) *=
/
> @@ -185,6 +187,9 @@
>  /* Status Register 2 bits. */
>  #define SR2_QUAD_EN_BIT7	BIT(7)
> =20
> +/* Status Register 3 bits. */
> +#define SR3_WPS			BIT(2)
> +
>  /* For Cypress flash. */
>  #define SPINOR_OP_RD_ANY_REG			0x65	/* Read any register */
>  #define SPINOR_OP_WR_ANY_REG			0x71	/* Write any register */


--acf4be2f55090aa1dcc23d2f9a6b39a9e383484571a9d1d3dff03dfb8e4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIcEABYIAC8WIQQCnWSOYTtih6UXaxvNyh2jtWxG+wUCZebeAhEcbWljaGFlbEB3
YWxsZS5jYwAKCRDNyh2jtWxG+xbvAQCJSk2p6f3PiYYB+yWtQyJVe6NuSsk9kCJI
pzr0lonvHgD+J5A7y4ZHHpj8vxWPUrPf5WE+//8jMzOZbmMMc8964gc=
=5Q61
-----END PGP SIGNATURE-----

--acf4be2f55090aa1dcc23d2f9a6b39a9e383484571a9d1d3dff03dfb8e4c--
