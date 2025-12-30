Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320ABEE0214
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 15:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CACE83DE4;
	Tue, 30 Dec 2025 16:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QVls3AQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6175E83F53; Tue, 30 Dec 2025 16:31:21 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1377583DA9
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 16:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4510974a6bbso3024450b6e.3
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 07:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767108677; x=1767713477; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0Qvw7cUpbJ/OLc71itHiugQizfujVbE8jXb65OSYFp4=;
 b=QVls3AQ+Eb82ohD54Lnui6IJSeGWWH0aDN8NIm/ubfPylPk2IVJcoYUlMwMNgv4Uwy
 TomgtfidFW5DZA0PD5ccKOZlhYcZ49ZIVN3ZwoMdB5f6HBEOJs6cHz3zQa2isYt2/VQc
 BkvcBMruwCmIb/Ysb9fPNO5seLezItzOJIB+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767108677; x=1767713477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Qvw7cUpbJ/OLc71itHiugQizfujVbE8jXb65OSYFp4=;
 b=EBTcGwKZuvE/t0i2kT6n1C5s+E8iDaaL6ZIFCMiFSjchYHCRPWes7wU/mK2THcOUHH
 UfXd6Qo6y22IqlV271H3G/adZvOUl4Ts+Ujd/nVgT7ZB+2/ft7nWCZgrKK5/boEMNKEH
 U9FDGvssu3VkZ2dmzPVMtdWl6jCufawOhZ1Ys3ny8FKBOBeWvAdPYUHVB4QErPI4VkKZ
 /dffNzl1h7mUehdMfnEj8DrEaxMAWzk9Y2skF5cUuwyZ4TPAYE/xmW1wFsYQt3PO8Z01
 gvD1P1XSqts3ZWV5zdcxxQK3wuOsVbC3NXeSNJsHaN9BgNzrTWJEigqx6qW2gTHX/DcF
 ySRg==
X-Gm-Message-State: AOJu0YxmWY78YjUFBH1/yKLf3NOQhvEePyANN/mvbk6Ri8EiNYLqwbJd
 NZU5DszFjHtb4NuCN5SepJPlfxcqFnQxX1Udt16Id/DFWqkeZmqTtOiT+fjk9E1j57uopaii9bg
 LLAqcL5s=
X-Gm-Gg: AY/fxX6+krZ554pbth1VwlERafOFbSHVixnzLNp+cluuSWx4OwjB6nRvUClC0OWsGtH
 9rBHrXUv3wnF291pYXGwafsUsaacgp6/so/2RizpbNyDLWkvccBP1ic/426TFv/E0FV8RWUtdxi
 DD+6bnhtXoym+QpNxMkPxS+OpGQdkK1YwUtGHHEvLfK0nvNrfIXj1+GZqrPmhDB4g74etlyAFrI
 oyvk/zTch1wKf6+ujRAqJEGpQkO0wUhPoqiIdJeeV/BMMf26h+Dnx5WaCpXa9z0/qsIOuiqHb3U
 gHJ5M9db6CsQV0hmJtw60j4rMrsJzYvzZAxqUMKg+j/mXVDgwMwLOM4mhDRWKVTZjqzQc4OfhOP
 BteePuKo2I2DuFD4deTS5UADkb2Qm7u8aKhjgLQTJbm5GqBQt8+lDK10hWV6z4mMIIs1CW3fx39
 i8s4Ao0jKlt6mhH6EGy1pOHitFsm3UgBlxX6l0yAsPCXBWTioIUYhgo7yxLn4CxsR6AcLllvI4p
 zB6MCKzxi2TV61/sRlx+Tr5K39lV6S48DQRdH0=
X-Google-Smtp-Source: AGHT+IEqh156ycDa577D3aTXH/ao11geP43zUSRUJSvsAOmPuy92MaR17gKhkju1ndQ2bf6OPmmH4g==
X-Received: by 2002:a05:6808:4fd1:b0:450:f3e4:eb0f with SMTP id
 5614622812f47-457b20ad5b6mr17152427b6e.20.1767108677630; 
 Tue, 30 Dec 2025 07:31:17 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaac0273bsm20501162fac.20.2025.12.30.07.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Dec 2025 07:31:17 -0800 (PST)
Date: Tue, 30 Dec 2025 09:31:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Jun Chang <jun.chang@metanoia-comm.com>
Cc: u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Subject: Re: [PATCH 1/1] board: mt5824: Add initial support for Metanoia
 MT5824 EVB
Message-ID: <20251230153115.GR710860@bill-the-cat>
References: <20251230030328.215240-1-jun.chang@metanoia-comm.com>
 <20251230030328.215240-2-jun.chang@metanoia-comm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MfqV83wNq6c6a2pg"
Content-Disposition: inline
In-Reply-To: <20251230030328.215240-2-jun.chang@metanoia-comm.com>
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


--MfqV83wNq6c6a2pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 11:03:28AM +0800, Jun Chang wrote:

> - Add RISC-V target for MT5824
> - Add board defconfig and DTS for MT5824 EVB
> - Add SPL and U-Boot board support for MT5824 EVB
> - Add DDR init for MT5824 EVB
>=20
> Signed-off-by: Jun Chang <jun.chang@metanoia-comm.com>
> ---
>  arch/riscv/Kconfig                    |   4 +
>  arch/riscv/dts/mt5824-evb.dts         | 232 +++++++++++++++++

What is the status on upstreaming this device tree?

[snip]
> diff --git a/board/metanoia/mt5824/lpddr4.h b/board/metanoia/mt5824/lpddr=
4.h
> new file mode 100644
> index 00000000000..5de70c536ca
> --- /dev/null
> +++ b/board/metanoia/mt5824/lpddr4.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2025 Metanoia Communications Inc.,
> + * Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
> + */
> +
> +#ifndef __COBRA_DDR_H
> +#define __COBRA_DDR_H
> +
> +#include <asm/io.h>
> +
> +#define UMCTL2_REGS_BASE_ADDR 0x10060000
> +
> +#define reg8_write(addr, data) \
> +	writeb((uint8_t)(data), (volatile void __iomem *)(addr))
> +#define reg16_write(addr, data) \
> +	writew((uint16_t)(data), (volatile void __iomem *)(addr))
> +#define reg32_write(addr, data) \
> +	writel((uint32_t)(data), (volatile void __iomem *)(addr))

We really don't already have an appropriate macro here to use?

[snip]
> +#endif /* __COBRA_DDR_H */
> \ No newline at end of file

Please fix that globally.

> diff --git a/board/metanoia/mt5824/lpddr4_helper.c b/board/metanoia/mt582=
4/lpddr4_helper.c
> new file mode 100644
> index 00000000000..3bc447038dc
> --- /dev/null
> +++ b/board/metanoia/mt5824/lpddr4_helper.c
[snip]
> +#if 0 /* Enable for debugging */
> +		if (i < 10) {
> +			printf("  [%02d] 0x%08x =3D 0x%08x\n", i, reg_addr, reg_value);
> +		}
> +#endif

Just use debug() here? And remove other "if 0" or commented out code
globally.

[snip]
> diff --git a/board/metanoia/mt5824/mt5824.c b/board/metanoia/mt5824/mt582=
4.c
> new file mode 100644
> index 00000000000..f385de1d897
> --- /dev/null
> +++ b/board/metanoia/mt5824/mt5824.c
> @@ -0,0 +1,188 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2025 Metanoia Communications Inc.,
> + * Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
> + */
> +
> +#include <log.h>
> +#include <asm/csr.h>
> +#include <asm/sbi.h>
> +#include <config.h>
> +#include <cpu_func.h>
> +#include <image.h>
> +#include <init.h>
> +#include <net.h>
> +#include <asm/global_data.h>
> +#include <linux/io.h>
> +#include <fdtdec.h>
> +#include <dm.h>
> +#include <hang.h>
> +#include <misc.h>
> +#include <hexdump.h>
> +#include <env_internal.h>
> +#include <linux/delay.h>
> +#include <asm/io.h>

Globally, please audit your include list.

[snip]
> diff --git a/configs/mt5824_evb_defconfig b/configs/mt5824_evb_defconfig
> new file mode 100644
> index 00000000000..74f6ceb2284
> --- /dev/null
> +++ b/configs/mt5824_evb_defconfig
> @@ -0,0 +1,61 @@
> +CONFIG_RISCV=3Dy
> +CONFIG_RISCV_ANDES=3Dy
> +CONFIG_ARCH_RV64I=3Dy
> +CONFIG_RISCV_SMODE=3Dy
> +

Please re-generate this with "make savedefconfig".

[snip]
> diff --git a/include/configs/mt5824.h b/include/configs/mt5824.h
> new file mode 100644
> index 00000000000..9809080b805
> --- /dev/null
> +++ b/include/configs/mt5824.h
[snip]
> +/* environments */
> +
> +/* SPI FLASH */
> +
> +/*
> + * For booting Linux, the board info and command line data
> + * have to be in the first 16 MB of memory, since this is
> + * the maximum mapped by the Linux kernel during initialization.
> + */
> +
> +/* Initial Memory map for Linux*/
> +#define CFG_SYS_BOOTMAPSZ	(64 << 20)
> +/* Increase max gunzip size */
> +
> +/* Support autoboot from RAM (kernel image is loaded via debug port) */
> +#define BOOTENV_DEV_NAME_RAM(devtypeu, devtypel, instance) \
> +	"ram "
> +
> +#define BOOTENV_DEV_RAM(devtypeu, devtypel, instance) \
> +	"bootcmd_ram=3D" \
> +	"bootm ${fit_addr}\0"
> +
> +#define BOOTENV_DEV_LEGACY_MMC(devtypeu, devtypel, instance) \
> +	"bootcmd_" #devtypel #instance "=3D" \
> +	"setenv mmcdev " #instance"; "\
> +	"setenv bootpart " #instance":2 ; "\
> +	"run mmcboot\0"
> +
> +#define BOOTENV_DEV_NAME_LEGACY_MMC(devtypeu, devtypel, instance) \
> +	#devtypel #instance " "
> +
> +#define BOOTENV_DEV_NAME_TFTP(devtypeu, devtypel, instance) \
> +	#devtypel " "
> +
> +#define BOOTENV_DEV_TFTP(devtypeu, devtypel, instance) \
> +	"bootcmd_" #devtypel "=3D" \
> +	"tftpboot ${fit_addr} $serverip:fitImage-dev-image-initramfs; " \
> +	"bootm ${fit_addr}\0"
> +
> +/* Enable distro boot */
> +#define BOOT_TARGET_DEVICES(func) \
> +	func(TFTP, tftp, na) \
> +	func(RAM, ram, na)
> +
> +#include <config_distro_bootcmd.h>
> +
> +#define CFG_EXTRA_ENV_SETTINGS	\
> +	"bootcmd=3Dbootm 90000000\0" \
> +	"kernel_addr_r=3D82000000\0" \
> +	"pxefile_addr_r=3D0x83f00000\0" \
> +	"scriptaddr=3D0x83f00000\0" \
> +	"fdt_addr_r=3D0x68010000\0" \
> +	"ramdisk_addr_r=3D0x83000000\0" \
> +	"fit_addr=3D0x83000000\0" \
> +	"initrd_high=3D0x100000000\0" \
> +	BOOTENV

Please switch to plain text environment and consider standard boot,
thanks.

--=20
Tom

--MfqV83wNq6c6a2pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVPwPwAKCRAr4qD1Cr/k
CiMWAQCa8apJzLAEVF1stiize66hypwEhzNeBUYPBR5PYk4H4AEAsSnpnBngPBP9
JHGh0DuCRmAirKFU/rAFEOpX7TN5Pgk=
=kQlk
-----END PGP SIGNATURE-----

--MfqV83wNq6c6a2pg--
