Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B59C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 15:44:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49EB086F67;
	Mon, 15 Jan 2024 16:44:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="kDof2Hxt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C0086EF1; Mon, 15 Jan 2024 16:44:48 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C9DF86F67
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 16:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 4E24628682;
 Mon, 15 Jan 2024 16:44:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1705333484;
 bh=FVZ01lgRqiNKYFMLi7htcpOkC1kNUHq+18V2KYD4PHg=; h=From:To:Subject;
 b=kDof2Hxt49IzxRohWHxdDWb5e0CRBPldloDtQPfcKm1dAvB+9EJVGrcwxg4key+P3
 xkq0nbLOj4ilYLpIf4xVyVVzwWtnoYriP+fZ91cCkcbiCo+7/CTadDwki8/xjDIbet
 HacnduJXFW2MHXMD/5pIr5VKAbYvKGka4ou600AVarbgWttWC67ci1xsn2oozfCKDx
 2DLm58eHFAo+zBDr1rj2QbM5HOOosPn/VwYgc8U+CVn/Kh045QsyextXqFRb07xsmj
 UwLEUVh6MMn9FnqoLIpK6nlEcGgZaN9D7t1Ufe/y2Zbi2iaD3e5k6uUWaiNfHnAmH7
 laCEKN/55DUJA==
Date: Mon, 15 Jan 2024 16:44:20 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Stefano Babic <sbabic@denx.de>
Subject: Re: [RFC][PATCH] ARM: imx: verdin-imx8mm: Set CAN oscillator
 frequency based on model
Message-ID: <20240115154420.GA31739@francesco-nb>
References: <20240113183350.176131-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240113183350.176131-1-marex@denx.de>
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

On Sat, Jan 13, 2024 at 07:33:17PM +0100, Marek Vasut wrote:
> The older i.MX8M Mini Verdin SoMs before rev. 1.1C came with 20 MHz SPI CAN
> controller oscillator, the newer SoMs use 40 MHz oscillator. Handle both by
> overriding the oscillator frequency just before booting the kernel.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Cc: Philippe Schenker <philippe.schenker@toradex.com>

Philippe is no longer in toradex, removed from cc list.

> Cc: Stefano Babic <sbabic@denx.de>
> ---
>  board/toradex/verdin-imx8mm/verdin-imx8mm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
> index b2781b51d6a..8bc1a51eeb1 100644
> --- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
> +++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
> @@ -142,6 +142,25 @@ int board_phys_sdram_size(phys_size_t *size)
>  #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
>  int ft_board_setup(void *blob, struct bd_info *bd)
>  {
> +	const char *canoscpath = "/oscillator";
> +	int canoscoff, freq, ret;
> +
> +	canoscoff = fdt_path_offset(blob, canoscpath);
> +	if (canoscoff < 0)	/* No CAN oscillator found. */
> +		goto exit;
> +
> +	if (tdx_hw_tag.ver_assembly < 2)        /* rev. A or B */
> +		freq = 20000000;
> +	else					/* rev. C or newer */
> +		freq = 40000000;

So, the situation is more complex than what I thought initially.

The actual frequency of the oscillator depends on the whole
`struct toradex_hw`, you would need to check prodid, ver_major,
ver_minor and ver_assembly.
	
In addition to that code should not expect `ver_assembly` to be an
increasing number, this is just a number that is matching the BOM.

The actual `prodid` (PID4 in Toradex naming) that have the CAN
functionality are 0055 and 0059.

0059, V1.1A and V1.1B, use a 20MHz oscillator
0055, V1.1A, V1.1B, V1.1C and V1.1D, use a 20Mhz oscillator

Verdin iMX8MM V1.0* is something I would not consider, from what I know
they were all scrapped (not even myself has any of those anymore).

With that said what I would do is something like

if ((tdx_hw_tag.ver_major == 1 && tdx_hw_tag.ver_minor == 1) &&
    ((tdx_hw_tag.prodid == VERDIN_IMX8MMQ_IT && ver_assembly <= 1) ||
    (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WIFI_BT_IT &&. ....))

    ft_fixup_can_oscillator_freq();

or any other more readable variant of your choice ;-)

And I would not have the code guess anything apart this, just setting
20MHz for the well known configuration.

If you are interested the details on the versions they are public, see
https://www.toradex.com/computer-on-modules/verdin-arm-family/nxp-imx-8m-mini-nano
and
https://developer.toradex.com/hardware/verdin-som-family/modules/verdin-imx8m-mini/#revision-history

Francesco

