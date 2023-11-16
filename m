Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7252EC54FB9
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 15:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3528B87465;
	Thu, 16 Nov 2023 16:43:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tBf79zCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FE7587465; Thu, 16 Nov 2023 16:43:38 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C4978744B
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 16:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1ef36a04931so459983fac.2
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 07:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700149413; x=1700754213; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TArAeu+BV0n9Z9VsOMHAohdAkGIn3HcyPINBuVDNhlU=;
 b=tBf79zCGUrW6Vi3aKKOxbdF3BHp1rMipAS0eaHCuz8L1yW8v4qdSg/+sR/A3YEAjYB
 CbW7HpyX/IBdGARNMNgcYRP17z9MUwWUC7WLwfauzSGBrsPo2OfyxTgMT2KL8JyJ346t
 h3pDYDOp4AAKx5H0IwwksMTUNUXoWwGaq28yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700149413; x=1700754213;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TArAeu+BV0n9Z9VsOMHAohdAkGIn3HcyPINBuVDNhlU=;
 b=GF6XefkmgIlEEle3cr9ZceQBKsAMWfkTkZfu17B/VPFrUxM/XkKGkEmE4zz/E/yDvx
 LyvRnXgLmg3k97U6j6JVr9oohHfA6AAfwjJxCsZhaobJE0tkSMapHxbBC1wi2TcNrXMa
 m2vEYvY5+G0iMoNu5rJqTAVRDJ40Wrs5rikHNVM9QGFFSZfUwcH6+cXaBJObrYlkJPnj
 NYNUbI0AUthTHUoEMCQbeU56yLTC1lmt+mxxoBiGa1p/dRnxq/ePwQbsbRCSCPb/7UMx
 8ktj41peprE2Ht25l9uPu23sVdpyZp+KzZDuw+p69PbNKxX+rrFwyDQZDuGjAJdqsxl/
 Y7yA==
X-Gm-Message-State: AOJu0Yyi3w4ZeHRiMlEJ6UZAS+Y9+H8Y6WEVR4ec39/KXonBpGqN1IsO
 93jOLQRFRyscKUGU82NFbzr1ug==
X-Google-Smtp-Source: AGHT+IECFnefImFGvQMGmMAfLaDRf4lie1Bh8Ypcq4eZHlrG0m8zrv6gFEoghWyohADhzs07scmsFQ==
X-Received: by 2002:a05:6871:a302:b0:1f4:a122:6b02 with SMTP id
 vx2-20020a056871a30200b001f4a1226b02mr17587742oab.45.1700149412687; 
 Thu, 16 Nov 2023 07:43:32 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 f19-20020ac840d3000000b0041cb8732d57sm4420780qtm.38.2023.11.16.07.43.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 07:43:32 -0800 (PST)
Date: Thu, 16 Nov 2023 10:43:28 -0500
From: Tom Rini <trini@konsulko.com>
To: Artur Rojek <artur@conclusive.pl>
Cc: Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Wojciech Kloska <wojciech@conclusive.pl>,
 =?utf-8?B?UmFkb3PFgmF3?= Adamczyk <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] board: Add support for Conclusive WHLE-LS1046A
Message-ID: <20231116154328.GK6601@bill-the-cat>
References: <20231116131630.407502-1-artur@conclusive.pl>
 <20231116131630.407502-3-artur@conclusive.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="w3Gc4rWX4n2RFqOA"
Content-Disposition: inline
In-Reply-To: <20231116131630.407502-3-artur@conclusive.pl>
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


--w3Gc4rWX4n2RFqOA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 02:16:30PM +0100, Artur Rojek wrote:

> Introduce support for Conclusive WHLE-LS1046A Single Board Computer.
>=20
> Co-developed-by: Jakub Klama <jakub@conclusive.pl>
> Signed-off-by: Jakub Klama <jakub@conclusive.pl>
> Signed-off-by: Artur Rojek <artur@conclusive.pl>
[snip]
> +	fdt_fixup_memory_banks(blob, base, size, 2);
> +	ft_cpu_setup(blob, bd);
> +
> +#ifdef CONFIG_SYS_DPAA_FMAN
> +#ifndef CONFIG_DM_ETH
> +	fdt_fixup_fman_ethernet(blob);
> +#endif
> +#endif

DM_ETH is a must-have at this point so you can just drop the non-DM_ETH
case.

[snip]
> diff --git a/include/configs/whle_ls1046a.h b/include/configs/whle_ls1046=
a.h
> new file mode 100644
> index 000000000000..982bf71be515
> --- /dev/null
> +++ b/include/configs/whle_ls1046a.h

In here, please see if there's any defines that are either not required,
or could be in another header (for example only needed in your board
code, so a header in the board directory).

> +#define QSPI_NOR_BOOTCOMMAND	CONFIG_BOOTCOMMAND
> +#define QSPI_NAND_BOOTCOMMAND	CONFIG_BOOTCOMMAND
> +#define SD_BOOTCOMMAND		CONFIG_BOOTCOMMAND
> +
> +#undef CFG_EXTRA_ENV_SETTINGS
> +#define CFG_EXTRA_ENV_SETTINGS		\
> +	"hwconfig=3Dfsl_ddr:bank_intlv=3Dauto\0"	\
> +	"kernel_addr_r=3D0x81000000\0"		\
> +	"kernel_size=3D0x07000000\0"		\
> +	"kernel_comp_addr_r=3D0x88000000\0"	\
> +	"kernel_comp_size=3D0x04000000\0"		\
> +	"ramdisk_addr_r=3D0x90000000\0"		\
> +	"ramdisk_size=3D0x08000000\0"		\
> +	"fdt_addr_r=3D0x98000000\0"		\
> +	"pxefile_addr_r=3D0x99000000\0"		\
> +	"scriptaddr=3D0x9a000000\0"		\
> +	"fdtfile=3Dfsl-ls1046a-whle.dtb\0"	\
> +	"console=3DttyS0,115200\0"                \
> +	CONFIG_MTDPARTS_DEFAULT "\0"		\
> +	BOOTENV

Please move this to a plain text environment (see board/*/*/*.env) and
move from the distro_bootcmd macros to BOOTSTD. Thanks.

--=20
Tom

--w3Gc4rWX4n2RFqOA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWOJoACgkQFHw5/5Y0
tyw3Sgv/dHb6dxntLOUrNj6Rf/XjRZ13fOGyhea/L8POLdrMLHTpFw55kvUXnEv2
L+MYABI7CVbgxRjT8K8PqfsFGc1oIMPZeAUHPhayWg73UBjvngYNTFIDywXFGsZP
KcJUX/Ux9BYu8sjaGvsopc410oKJx/vGgGVHVV3vDM8araw6mPKhRhjggPv4ZeOR
mY7B1fftEjp75h14jqNMq8hZgwaQyWCu4KhGh8/YcHqq2RyJ6ef5P9azgeG9AGXo
wlTyhkCUoq1j+6uXnctYrhFyR5Cvy22ARWGcM8wqnb6ykdaK3b10K26mDbeCFUqJ
aZ+a89eX8j0z9TeERuO3cx5b331vP2suxPUvUkybPhwFhRfReXYTIf8KX5rj2Oh4
Ke4LnAu4oLDpvkaHz/IuQHEVaPgJWXzYaMVBgcAEpAgp8vsiBLDq0h0NEPX8H5SW
KBkBFp4IRJYQC39lxlgwe3OGNErr+y5Jn+d2SWVh9GCmCo6jZ/sbvTgg1NWcdbJ3
JInUt0R/
=XD8U
-----END PGP SIGNATURE-----

--w3Gc4rWX4n2RFqOA--
