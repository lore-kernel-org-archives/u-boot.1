Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AB8EED631
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 17:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27D2B89104;
	Thu, 12 Sep 2024 19:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZiZMcxRB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14BF4890D6; Thu, 12 Sep 2024 19:45:15 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D030C88D7B
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 19:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6c355155f8eso723126d6.0
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 10:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726163112; x=1726767912; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dCM8VNI8DipaxsOzPhCDFa8nRIsUpew+CUamkLgHU9M=;
 b=ZiZMcxRBlXucbwf79gAZAWpsPFiwuZZzLeitqP2FgSZj87M+Z6KTUVOyr06N1dgKp0
 biERKgqOzdEyqssALz+K6fZUikOCORkCxFlPUJtwDTwvVM7qFgYeGN3mxOCgz131kYN9
 HVgKG3YrO+gH9r3aMGNdvr9Zo7t7ObzGzqS6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726163112; x=1726767912;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dCM8VNI8DipaxsOzPhCDFa8nRIsUpew+CUamkLgHU9M=;
 b=cfPGMphuETwtmyIp7wgB9Qrcy8r7Gs30cmLYyZKjKXgtCzUEF074ikQsuMV7uHkUmO
 c8WxgXstGpoWwYPv305etDCjNolC4uWhHSZoICUVwbhxDR2q9h0CzLb6APtsgGj7VPkM
 41/yPwTRT8+tl7mSHvKP7IINk+EllCVSPECT9QJSoUVXN/Or86FEcHO11u86Bprh/MzC
 OUacS8UzYcEA/wBeTrg6jCAI8CqXhff0bMzjfRZG8BM+EuVgmwJUHzVcmxTqsLeK5LQI
 vjUnbluPmDwcvt9wu41GG3N5Yqfe5be11ZU33yQrPzBQdC3s2Qj8m1GERytktjFF3kQx
 74Rw==
X-Gm-Message-State: AOJu0YwWuSCEeZmCPg6rDY9bilAqCmZIQMnROwizvKhXY0MI4eFVb/Nc
 hFmkknQXzt0vkab1011gVODaPsF8++4tci9x952p9yCAdzFXY7uZLKBt4+indO0=
X-Google-Smtp-Source: AGHT+IHfqNdO4rt0WqU+rTBy0AgLnLdc2LGAwlmtkEEenqV9Vjk6DunmptXj6XocoIzEeJLPwMWpbg==
X-Received: by 2002:ac8:5dce:0:b0:456:81d1:dfe5 with SMTP id
 d75a77b69052e-4586041ad0dmr54970311cf.40.1726163111481; 
 Thu, 12 Sep 2024 10:45:11 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822f60a81sm55272821cf.67.2024.09.12.10.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 10:45:10 -0700 (PDT)
Date: Thu, 12 Sep 2024 11:45:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, simon.k.r.goldschmidt@gmail.com,
 tien.fong.chee@intel.com
Subject: Re: [PATCH 3/9] ARM: socfpga: add Enclustra AA1 SoM support
Message-ID: <20240912174507.GV4252@bill-the-cat>
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-4-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7mZP2K70EiFYBPkQ"
Content-Disposition: inline
In-Reply-To: <20240912060649.190-4-l.rubusch@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--7mZP2K70EiFYBPkQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 06:06:43AM +0000, Lothar Rubusch wrote:

> Introduce initial support for the Enclustra SoMs:
>=20
> - Mercury AA1
>=20
> Cover general board files for SD/MMC and QSPI boot modes. Integrate the
> boards to kconfig. All build variants will depend on Quartus handoff
> files, thus they depend on the particular Quartus design. The approach is
> covered in the according documentation part.
>=20
> Additionally add configuration for SD/MMC boot and QSPI bootmodes. Regist=
er
> additional targets in kconfig.
>=20
> Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
[snip]
> diff --git a/board/enclustra/mercury_aa1/mercury_aa1.c b/board/enclustra/=
mercury_aa1/mercury_aa1.c
> new file mode 100644
> index 0000000000..7de9b287d9
> --- /dev/null
> +++ b/board/enclustra/mercury_aa1/mercury_aa1.c
> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Enclustra GmbH
> + * <info@enclustra.com>
> + */
> +
> +#include <command.h>
> +#include <env.h>
> +#include <init.h>
> +#include <dm/uclass.h>
> +#include <asm-generic/gpio.h>
> +#include <asm/io.h>
> +
> +/* Pin muxing */
> +#if !defined(CONFIG_SPL_BUILD)
> +
> +#define ALTERA_NONE 0
> +#define ALTERA_MMC 1
> +#define ALTERA_QSPI 2
> +#define ALTERA_EMMC 3
> +#define MMC_CLK_DIV 0x9
> +#define QSPI_CLK_DIV 0x384
> +#define ALTERA_PINMUX_OFFS 0xffd07200
> +#define ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE 0xFFD04078
> +
> +static int altera_current_storage =3D ALTERA_NONE;
> +
> +#endif
> +
> +#if !defined(CONFIG_SPL_BUILD)
> +
> +static void set_mux_mmc(void)
> +{
> +	u32 pinmux_arr[] =3D {0x0c, 0x8,  // IO4 connected to SDMMC
> +			0x10, 0x8,	// IO5
> +			0x14, 0x8,	// IO6
> +			0x18, 0x8,	// IO7
> +			0x1c, 0x8,	// IO8
> +			0x20, 0x8,	// IO9
> +			0x24, 0xf,	// IO10 connected to GPIO
> +			0x28, 0xf,	// IO11
> +			0x2c, 0xf,	// IO12
> +			0x30, 0xf,	// IO13
> +			0x34, 0xf,	// IO14
> +			0x38, 0xf};	// IO15
> +	u32 len, i, offset, value;
> +
> +	len =3D sizeof(pinmux_arr) / sizeof(u32);
> +	for (i =3D 0; i < len; i +=3D 2) {
> +		offset =3D pinmux_arr[i];
> +		value =3D pinmux_arr[i + 1];
> +		writel(value, ALTERA_PINMUX_OFFS + offset);
> +	}
> +}
> +
> +static void set_mux_emmc(void)
> +{
> +	u32 pinmux_arr[] =3D {0x0c, 0x8,  // IO4
> +		0x10, 0x8,	// IO5
> +		0x14, 0x8,	// IO6
> +		0x18, 0x8,	// IO7
> +		0x1c, 0x8,	// IO8
> +		0x20, 0x8,	// IO9
> +		0x24, 0xf,	// IO10
> +		0x28, 0xf,	// IO11
> +		0x2c, 0x8,	// IO12
> +		0x30, 0x8,	// IO13
> +		0x34, 0x8,	// IO14
> +		0x38, 0x8};	// IO15
> +	u32 len, i, offset, value;
> +
> +	len =3D sizeof(pinmux_arr) / sizeof(u32);
> +	for (i =3D 0; i < len; i +=3D 2) {
> +		offset =3D pinmux_arr[i];
> +		value =3D pinmux_arr[i + 1];
> +		writel(value, ALTERA_PINMUX_OFFS + offset);
> +	}
> +}
> +
> +static void set_mux_qspi(void)
> +{
> +	u32 pinmux_arr[] =3D {0x0c, 0x4,  // IO4 connected to QSPI
> +		0x10, 0x4,	// IO5
> +		0x14, 0x4,	// IO6
> +		0x18, 0x4,	// IO7
> +		0x1c, 0x4,	// IO8
> +		0x20, 0x4,	// IO9
> +		0x24, 0xf,	// IO10
> +		0x28, 0xf,	// IO11
> +		0x2c, 0xf,	// IO12
> +		0x30, 0xf,	// IO13
> +		0x34, 0xf,	// IO14
> +		0x38, 0xf};	// IO15
> +	u32 len, i, offset, value;
> +
> +	len =3D sizeof(pinmux_arr) / sizeof(u32);
> +	for (i =3D 0; i < len; i +=3D 2) {
> +		offset =3D pinmux_arr[i];
> +		value =3D pinmux_arr[i + 1];
> +		writel(value, ALTERA_PINMUX_OFFS + offset);
> +	}
> +}
> +
> +void altera_set_storage(int store)

Should be static?

> +{
> +	unsigned int gpio_flash_sel;
> +	unsigned int gpio_flash_oe;
> +
> +	if (store =3D=3D altera_current_storage)
> +		return;
> +
> +	if (gpio_lookup_name("portb5", NULL, NULL, &gpio_flash_oe)) {
> +		printf("ERROR: GPIO not found\n");
> +		return;
> +	}
> +
> +	if (gpio_request(gpio_flash_oe, "flash_oe")) {
> +		printf("ERROR: GPIO request failed\n");
> +		return;
> +	}
> +
> +	if (gpio_lookup_name("portc6", NULL, NULL, &gpio_flash_sel)) {
> +		printf("ERROR: GPIO not found\n");
> +		return;
> +	}
> +
> +	if (gpio_request(gpio_flash_sel, "flash_sel")) {
> +		printf("ERROR: GPIO request failed\n");
> +		return;
> +	}
> +
> +	switch (store) {
> +	case ALTERA_MMC:
> +		set_mux_mmc();
> +		gpio_direction_output(gpio_flash_sel, 0);
> +		gpio_direction_output(gpio_flash_oe, 0);
> +		altera_current_storage =3D ALTERA_MMC;
> +		writel(MMC_CLK_DIV, ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE);
> +		break;
> +	case ALTERA_EMMC:
> +		set_mux_emmc();
> +		gpio_direction_output(gpio_flash_sel, 1);
> +		gpio_direction_output(gpio_flash_oe, 1);
> +		altera_current_storage =3D ALTERA_EMMC;
> +		writel(MMC_CLK_DIV, ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE);
> +		break;
> +	case ALTERA_QSPI:
> +		set_mux_qspi();
> +		gpio_direction_output(gpio_flash_sel, 1);
> +		gpio_direction_output(gpio_flash_oe, 0);
> +		altera_current_storage =3D ALTERA_QSPI;
> +		writel(QSPI_CLK_DIV, ALTERA_CLKMGR_MAINPLL_CNTR6CLK_BASE);
> +		break;
> +	default:
> +		altera_current_storage =3D ALTERA_NONE;
> +		break;
> +	}
> +
> +	gpio_free(gpio_flash_sel);
> +	gpio_free(gpio_flash_oe);
> +}
> +
> +int altera_set_storage_cmd(struct cmd_tbl *cmdtp, int flag,
> +			   int argc, char * const argv[])

Same?

> +{
> +	if (argc !=3D 2)
> +		return CMD_RET_USAGE;
> +
> +	if (!strcmp(argv[1], "MMC"))
> +		altera_set_storage(ALTERA_MMC);
> +	else if (!strcmp(argv[1], "QSPI"))
> +		altera_set_storage(ALTERA_QSPI);
> +	else if (!strcmp(argv[1], "EMMC"))
> +		altera_set_storage(ALTERA_EMMC);
> +	else
> +		return CMD_RET_USAGE;
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +U_BOOT_CMD(altera_set_storage, 2, 0, altera_set_storage_cmd,
> +	   "Set non volatile memory access",
> +	   "<MMC|QSPI|EMMC> - Set access for the selected memory device");
> +
> +#endif

The entire file seems to be for just adding the cmd. Perhaps rename this
file to reflect that and have the Makefile only even build this when
CONFIG_SPL_BUILD is not set. And then yes, the later patch will need to
be refactored slightly.

Also, the MAINTAINERS entry doesn't cover the documentation (which I'm
glad to see being added at the start!) nor the clock driver.

--=20
Tom

--7mZP2K70EiFYBPkQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbjKKMACgkQFHw5/5Y0
tyxcTgwArkRrO5dLCg6pFww4MXfiF+06Vg1Zlvxtm/WGwjkqFgKoPh3x5BEHyOV/
NRHw61CYe0N5hs/eoG8y5tBFgqXNCgzm9Z7wGxwtcRE0zKi3b82eQ1XtxOP5PfzE
THat/yxR4RDUY74iE1f8stKtodd4QnmTbb8+mzlKr+yrSLNuDnugCzVFJrtb2fJH
++QAaQhev3BBI/lkhXFB9sPQPBJ6QDFtpRxXgCEUVLNC1SqdYG8HhYjesLemZhf5
tDxnFqfRWjfpTXIZAIbWMTCPcMfitF8TuOMGD/af8MxnF6ceEVVd73owWXZ0HLmT
s3OvHopfsxnvGDATCN5EDxtHM28j76K1gvg4/dOb37jCjOY6/+RtfsDOEXNX/sSW
V6MnjNR8dHcx6Uv1XQyd5aEW1Dp0klIA6Er7rERInHb8sdz7PQW4xfFhnXSR16gF
+fGymbIZukCLhZEJ/PAhkyoyPIor/IncCg7nPt/UnHOkQoPNBQzpesX/IK21jUFe
FWJvjxZz
=0hOL
-----END PGP SIGNATURE-----

--7mZP2K70EiFYBPkQ--
