Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C05C4707C
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 20:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B06787842;
	Sat, 13 Jan 2024 21:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="aweVEGtd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFE1B87960; Sat, 13 Jan 2024 21:45:49 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A79287842
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 21:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 85790206F2;
 Sat, 13 Jan 2024 21:45:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1705178746;
 bh=4r1ywiX4N9z+UDHxBnMqMteYJfb+sXbkJe700Nr2aGc=; h=From:To:Subject;
 b=aweVEGtdKQrpgSBj9wowFIYZN7OWj6BqkKrpXrIg89JEdnAk7VCZHyl3NoxbW0SuI
 gKdYMcGZdzQIagj5NNp9Hzgz7bOlw31C3WZE1D8Ac5GAWjzqbe3NeEeN45GuxQK64y
 lZG0tvJ4jeZVn/TPflJkZW0yqCC58wRMvdHex1sK6Tr+8s6ymQYC4rO68A01b8KaXj
 OpB5gLwotNu0GVTY8CQ51tHPk2tNMbzwhN1s349ADWn50dLE7pf4d3tDD8fzwPGPNL
 QnhNtgwLSBVFAH+aaQCjvf6xDwLoBSfl4sC+6wZGMLRpDi54lm8bL1G/YNjGD4LjyQ
 8nz0cixBA35sA==
Date: Sat, 13 Jan 2024 21:45:42 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, "marex@denx.de" <marex@denx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [RFC][PATCH] ARM: imx: verdin-imx8mm: Set CAN oscillator
 frequency based on model
Message-ID: <20240113204542.GA3000@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5APcHhdkvd40Pm+WzSAoxtHS0kcdVpkRTs8yqwXdUSaRQ@mail.gmail.com>
 <e07c0ace3d9db05e80795a949a449506d7a3247e.camel@toradex.com>
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

On Sat, Jan 13, 2024 at 06:40:19PM +0000, Marcel Ziswiler wrote:
> Hi Marek
> 
> Thanks, seems like a decent idea. I guess we just did not do it as those previous revisions were just samples
> but with this change can still be used much easier (e.g. without requiring manual intervention).
> 
> On Sat, 2024-01-13 at 19:33 +0100, Marek Vasut wrote:
> > The older i.MX8M Mini Verdin SoMs before rev. 1.1C came with 20 MHz SPI CAN
> > controller oscillator, the newer SoMs use 40 MHz oscillator. Handle both by
> > overriding the oscillator frequency just before booting the kernel.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > ---
> > Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> > Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > Cc: Philippe Schenker <philippe.schenker@toradex.com>
> > Cc: Stefano Babic <sbabic@denx.de>
> 
> Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Marcel, that patch is buggy.

The assembly version makes sense only for a specific major/minor
hardware version.

So what you need to check if revision < 1.1C, while the code from Marek
check just for the assembly version C.

> 
> > ---
> >  board/toradex/verdin-imx8mm/verdin-imx8mm.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
> > index b2781b51d6a..8bc1a51eeb1 100644
> > --- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
> > +++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
> > @@ -142,6 +142,25 @@ int board_phys_sdram_size(phys_size_t *size)
> >  #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
> >  int ft_board_setup(void *blob, struct bd_info *bd)
> >  {
> > +	const char *canoscpath = "/oscillator";
> > +	int canoscoff, freq, ret;
> > +
> > +	canoscoff = fdt_path_offset(blob, canoscpath);
> > +	if (canoscoff < 0)	/* No CAN oscillator found. */
> > +		goto exit;
> > +
> > +	if (tdx_hw_tag.ver_assembly < 2)        /* rev. A or B */
I would suggest a slightly different approach.

First you need to check also for major/minor version. The revision
restart from A every time there is a change in a version.

Second I would set the 20MHz oscillator only for older version and do
nothing, not set anything, for the newer one.

On Sat, Jan 13, 2024 at 04:52:57PM -0300, Fabio Estevam wrote:
> On Sat, Jan 13, 2024 at 3:34 PM Marek Vasut <marex@denx.de> wrote:
> >
> > The older i.MX8M Mini Verdin SoMs before rev. 1.1C came with 20 MHz SPI CAN
> > controller oscillator, the newer SoMs use 40 MHz oscillator. Handle both by
> > overriding the oscillator frequency just before booting the kernel.
> >
> > Signed-off-by: Marek Vasut <marex@denx.de>
> 
> Applied, thanks.

Fabio, you were too fast ... please revert it.

Francesco


