Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33BBC25B7C
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 15:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F93788253;
	Thu, 23 May 2024 17:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="uEhOKYxP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E3DD87E9B; Thu, 23 May 2024 17:04:06 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 485CF88253
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 17:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 591EB20684;
 Thu, 23 May 2024 17:04:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1716476643;
 bh=dEeO2JNAWc3WiYOKex+20MjOalJeOZGe0q+7UP5TzNc=; h=From:To:Subject;
 b=uEhOKYxPLYNnqT1B7ZSuNi6rT8UL77QYyUgDPYFpV2ZzA6F+c/IAVavcPj8nFf8Yq
 SfGj5pNvJfiKw56JduXifjf3t3I53/z5zdnNYXZpMjjFw3XTjmX/tB0H9YsJ6RL+vH
 djvlGywN6TDRSWSxJFYk3zRXn/mUSK3ZzC0bmV0ax71gKI8+Nfqh6zdJ5qgYK5OjNk
 khRa7k0seldXOAAQ4aeYqhzJg8EULgP06nN7G/0f3srAuj50v/L8h5luwyWiJhL7rh
 bunU1r4UXfPfYWOV7bO4YxJyg0Gh5giWdq6qaU3zX5S73oTz8DGH9B6PcCh5/cJVRS
 YqMVLzEfKFyaw==
Date: Thu, 23 May 2024 17:03:59 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@denx.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH v2] ARM: imx: verdin-imx8mm: Set CAN oscillator frequency
 based on model
Message-ID: <20240523150359.GA18323@francesco-nb>
References: <20240522002122.50796-1-marex@denx.de>
 <20240522063948.GA5278@francesco-nb>
 <e9a57cfc-637a-4c26-84ac-6f6530ca62ce@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9a57cfc-637a-4c26-84ac-6f6530ca62ce@denx.de>
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

On Wed, May 22, 2024 at 03:23:51PM +0200, Marek Vasut wrote:
> On 5/22/24 8:39 AM, Francesco Dolcini wrote:
> > > diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
> > > index 55c02653da6..ef632d95f0a 100644
> > > --- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
> > > +++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
> > > @@ -125,6 +125,36 @@ int board_phys_sdram_size(phys_size_t *size)
> > >   #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
> > >   int ft_board_setup(void *blob, struct bd_info *bd)
> > >   {
> > > +	const char *canoscpath = "/oscillator";
> > > +	int freq = 40000000;	/* 40 MHz is used on most variants */
> > > +	int canoscoff, ret;
> > > +
> > > +	canoscoff = fdt_path_offset(blob, canoscpath);
> > > +	if (canoscoff < 0)	/* No CAN oscillator found. */
> > > +		goto exit;
> > > +
> > > +	/*
> > > +	 * The actual "prodid" (PID4 in Toradex naming) that have the CAN
> > > +	 * functionality are 0055 and 0059. Special case 20 MHz variant
> > > +	 * here:
> > > +	 * - 0055, V1.1A, V1.1B, V1.1C and V1.1D, use a 20MHz oscillator
> > > +	 * - 0059, V1.1A and V1.1B, use a 20MHz oscillator
> > > +	 */
> > 
> > Any reason why you ignored my suggestion here? The variants you list
> > here are the only one with a 20MHz oscillator, and this is correct.
> > 
> > What is not correct is that 0055/0059 are the only variant with CAN
> > functionality. We have other "prodid" with CAN functionality.
> > 
> > With that said, the code is correct, thanks. I appreciate you taking care
> > of this.
> 
> So ... what should I change for V3 ?
> 
> Maybe just create me a diff I can squash into the patch before resend ? (I
> think I am a bit confused, I thought I addressed all the V1 feedback)

Sorry for the confusion, here the diff.
With that please add

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
index ef632d95f0a5..59cc28f652f1 100644
--- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
+++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
@@ -134,11 +134,10 @@ int ft_board_setup(void *blob, struct bd_info *bd)
                goto exit;

        /*
-        * The actual "prodid" (PID4 in Toradex naming) that have the CAN
-        * functionality are 0055 and 0059. Special case 20 MHz variant
-        * here:
-        * - 0055, V1.1A, V1.1B, V1.1C and V1.1D, use a 20MHz oscillator
-        * - 0059, V1.1A and V1.1B, use a 20MHz oscillator
+        * The followings "prodid" (PID4 in Toradex naming) use
+        * a 20MHz CAN oscillator:
+        * - 0055, V1.1A, V1.1B, V1.1C and V1.1D
+        * - 0059, V1.1A and V1.1B
         */
        if ((tdx_hw_tag.ver_major == 1 && tdx_hw_tag.ver_minor == 1) &&
            ((tdx_hw_tag.prodid == VERDIN_IMX8MMQ_IT &&


