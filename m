Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C32C25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 06:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1057088460;
	Wed, 22 May 2024 08:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="SfVO7bZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78EFC88822; Wed, 22 May 2024 08:39:55 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CECD88460
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 08:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 679671FE3C;
 Wed, 22 May 2024 08:39:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1716359992;
 bh=C717S4cnMnl0N7ZDz3oNno/ndqJnu+yRNum6n0ZPg1g=; h=From:To:Subject;
 b=SfVO7bZ4MwJjt4rDEa00cox2hpZ+XpzQD10cyhPIBU5SErz8xhn/p0p6+m/od7Seh
 cCyRRHlyXwbBtASQEw4vivSELWWP8GfYMEYIblPELj9pdU5UVPSxm7tQTChJesfQoF
 UU2F7G3IUQlZudDqYAH4TWJhKnREe0LUhZfepi4R9K7df2r+pMu6Wteso5YRmFU3eJ
 9kbGHe+uOKgnAJRZrgVHOiJaQXtc9QUNsD3DJT79Jg0xHfo4ZttNBk0V3XsrfDQEMT
 lXZherutU0Y7z57JK/BnRDP3Pl2B/mdWiXesEecTcv0RYrwLoHh1arkN4KCyABnRJ8
 FEPEnEGi3JeKA==
Date: Wed, 22 May 2024 08:39:48 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH v2] ARM: imx: verdin-imx8mm: Set CAN oscillator frequency
 based on model
Message-ID: <20240522063948.GA5278@francesco-nb>
References: <20240522002122.50796-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522002122.50796-1-marex@denx.de>
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

On Wed, May 22, 2024 at 02:21:14AM +0200, Marek Vasut wrote:
> The older i.MX8M Mini Verdin SoMs may came with 20 MHz SPI CAN controller
> oscillator, the newer SoMs always use 40 MHz oscillator. Handle both by
> overriding the oscillator frequency just before booting the kernel.
> 
> These are the known variants with 20 MHz oscillator:
> - 0055, V1.1A, V1.1B, V1.1C and V1.1D, use a 20MHz oscillator
> - 0059, V1.1A and V1.1B, use a 20MHz oscillator
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Cc: Martyn Welch <martyn.welch@collabora.com>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: u-boot@lists.denx.de
> ---
> V2: - Update the comment in conditional statement
>     - Update ver_assembly check for 0055 rev.A/B/C/D
> ---
>  board/toradex/verdin-imx8mm/verdin-imx8mm.c | 30 +++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
> index 55c02653da6..ef632d95f0a 100644
> --- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
> +++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
> @@ -125,6 +125,36 @@ int board_phys_sdram_size(phys_size_t *size)
>  #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
>  int ft_board_setup(void *blob, struct bd_info *bd)
>  {
> +	const char *canoscpath = "/oscillator";
> +	int freq = 40000000;	/* 40 MHz is used on most variants */
> +	int canoscoff, ret;
> +
> +	canoscoff = fdt_path_offset(blob, canoscpath);
> +	if (canoscoff < 0)	/* No CAN oscillator found. */
> +		goto exit;
> +
> +	/*
> +	 * The actual "prodid" (PID4 in Toradex naming) that have the CAN
> +	 * functionality are 0055 and 0059. Special case 20 MHz variant
> +	 * here:
> +	 * - 0055, V1.1A, V1.1B, V1.1C and V1.1D, use a 20MHz oscillator
> +	 * - 0059, V1.1A and V1.1B, use a 20MHz oscillator
> +	 */

Any reason why you ignored my suggestion here? The variants you list
here are the only one with a 20MHz oscillator, and this is correct.

What is not correct is that 0055/0059 are the only variant with CAN
functionality. We have other "prodid" with CAN functionality.

With that said, the code is correct, thanks. I appreciate you taking care
of this.

Francesco

