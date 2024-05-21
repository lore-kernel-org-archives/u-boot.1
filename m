Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F418C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 11:29:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F79A87F7D;
	Tue, 21 May 2024 13:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="pRyPP+sc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA9488080; Tue, 21 May 2024 13:29:13 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA026880AE
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 13:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id D8C2E206C9;
 Tue, 21 May 2024 13:29:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1716290951;
 bh=EA/+lucwWGM8N4vMl4Dhm7Xzx1fL51iuHUs85dgJMgI=; h=From:To:Subject;
 b=pRyPP+scBQA62CF8v0EKmiOrYJuDIHuznpp7C3wqQHWsIQ+0AcJPBv9kAadBPDz4u
 7H7aaCMauLx65JDecJDCkfCLfZj32wWAEJayufus961ASdoA8a2L53P2dxK8wcNOH3
 p9yEKDCvb8kUdT3kw69DcjDiVdFzwRtRIrGkwnhnMtV5pK1GRDYqsJtn57vHutN9ZO
 jIKX6n9MtW4Hu81Ma7PazJ7dGXSPvMtp0Nf46jDZoRNPzKxoFRkIpkynJ7leE6VZm2
 vl1mmUKUEzBvoVXwcO3wDJAQywSHSffvgg7OuDSEH5xwGa8eV2z9eV1DIpr2in+ToC
 DystGkMqDQPBg==
Date: Tue, 21 May 2024 13:29:07 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@denx.de>, Francesco Dolcini <francesco@dolcini.it>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH] ARM: imx: verdin-imx8mm: Set CAN oscillator frequency
 based on model
Message-ID: <20240521112907.GA16302@francesco-nb>
References: <20240521093923.8771-1-marex@denx.de>
 <20240521111916.GA14658@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521111916.GA14658@francesco-nb>
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

On Tue, May 21, 2024 at 01:19:24PM +0200, Francesco Dolcini wrote:
> On Tue, May 21, 2024 at 11:39:05AM +0200, Marek Vasut wrote:
> > The older i.MX8M Mini Verdin SoMs may came with 20 MHz SPI CAN controller
> > oscillator, the newer SoMs always use 40 MHz oscillator. Handle both by
> > overriding the oscillator frequency just before booting the kernel.
> > 
> > These are the known variants with 20 MHz oscillator:
> > - 0055, V1.1A, V1.1B, V1.1C and V1.1D, use a 20MHz oscillator
> > - 0059, V1.1A and V1.1B, use a 20MHz oscillator
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > ---
> > Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> > Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > Cc: Philippe Schenker <philippe.schenker@toradex.com>
> > Cc: Martyn Welch <martyn.welch@collabora.com>
> > Cc: Stefano Babic <sbabic@denx.de>
> > Cc: u-boot@lists.denx.de
> > ---
> >  board/toradex/verdin-imx8mm/verdin-imx8mm.c | 30 +++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
> > index 55c02653da6..b4a443ebfb0 100644
> > --- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
> > +++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
> > @@ -125,6 +125,36 @@ int board_phys_sdram_size(phys_size_t *size)
> >  #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
> >  int ft_board_setup(void *blob, struct bd_info *bd)
> >  {
> > +	const char *canoscpath = "/oscillator";
> > +	int freq = 40000000;	/* 40 MHz is used on most variants */
> > +	int canoscoff, ret;
> > +
> > +	canoscoff = fdt_path_offset(blob, canoscpath);
> > +	if (canoscoff < 0)	/* No CAN oscillator found. */
> > +		goto exit;
> > +
> > +	/*
> > +	 * The actual "prodid" (PID4 in Toradex naming) that have the CAN
> > +	 * functionality are 0055 and 0059.
> This is nor correct, we have more, they just always use 40MHz.
> 
> I would rephrase this:
> 
> /*
>  * 20MHz CAN oscillator product variants:
>  * - 0055, V1.1A, V1.1B, V1.1C and V1.1D
>  * - 0059, V1.1A and V1.1B
>  */
> 
> or in a different way, if you prefer, but you got the point.
> 
> > +	if ((tdx_hw_tag.ver_major == 1 && tdx_hw_tag.ver_minor == 1) &&
> > +	    ((tdx_hw_tag.prodid == VERDIN_IMX8MMQ_IT &&
> > +	      tdx_hw_tag.ver_assembly <= 1) ||	/* 0055 rev. A or B */
> > +	     (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WIFI_BT_IT &&
> > +	      tdx_hw_tag.ver_assembly <= 4))) {	/* 0059 rev. A/B/C/D */
> 
> ver_assembly is the hardware revision - 'A', e.g. 'A' is 0, 'D' is 3.
> 
> VERDIN_IMX8MMQ_IT is 0059
> VERDIN_IMX8MMQ_WIFI_BT_IT is 0055
> 
> with that said, it should be
> 
> 	if ((tdx_hw_tag.ver_major == 1 && tdx_hw_tag.ver_minor == 1) &&
> 	    ((tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WIFI_BT_IT &&
> 	      tdx_hw_tag.ver_assembly <= 1) ||	/* 0055 rev. A or B */
> 	     (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_IT &&
> 	      tdx_hw_tag.ver_assembly <= 3))) {	/* 0059 rev. A/B/C/D */

whoops. I confused myself.
What is correct is the table you have in the comment and the commit
message.

What is wrong is the comment in this if branch, and this confused me
(and probably also you, sorry).

	if ((tdx_hw_tag.ver_major == 1 && tdx_hw_tag.ver_minor == 1) &&
	    ((tdx_hw_tag.prodid == VERDIN_IMX8MMQ_IT &&
	      tdx_hw_tag.ver_assembly <= 1) ||	/* 0059 rev. A or B */
	     (tdx_hw_tag.prodid == VERDIN_IMX8MMQ_WIFI_BT_IT &&
	      tdx_hw_tag.ver_assembly <= 3))) {	/* 0055 rev. A/B/C/D */

Francesco

