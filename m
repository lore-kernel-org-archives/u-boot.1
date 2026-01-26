Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DA8D19513
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 19:28:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C4A83BFE;
	Mon, 26 Jan 2026 20:28:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="L0XiS74O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52BDA83D71; Mon, 26 Jan 2026 20:28:22 +0100 (CET)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 651D183BD2
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 20:28:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j.ne@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 1EC94240028
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 20:28:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1769455700; bh=WlGDauoFT5kX83fUAT0j5pVLMyOd4RSU7CyPDgGcgXI=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:From;
 b=L0XiS74OkKZmi3IwNgMmhLir35j0t/9m1xYjljAQy+hVyV8cqEdTgg2uhj1uGXgSQ
 C6RGTZbB7UfmIE2ChSCkFlp+rgkF7aLH+A01Y+XgYBBNCD8FuCxDp0Oau0xB5GswA6
 obCqxBUmns6Gmea6xWb/CzxwL3eCQaiLHhYTNJVqHT3TDoMuwtd6t159nScBlGxSkb
 6MHZCdJCDrwaMaCSrskNq/0T5N3WWWk4GpjIgOYJUBGrqszlzHc8I+t04C4oDq/fWK
 wdUbDEiLrZW4IVTGAIDNntVAbm026rmuKBjg8kHqA+/+PpYXbBmZ8yA0sQpk+Kx3x9
 B0OnK6/Vd1+YA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4f0JV73jFcz6twv;
 Mon, 26 Jan 2026 20:28:15 +0100 (CET)
Date: Mon, 26 Jan 2026 19:28:19 +0000
From: =?utf-8?Q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
To: Andre Przywara <andre.przywara@arm.com>
Cc: j.ne@posteo.net, u-boot@lists.denx.de,
 linux-sunxi <linux-sunxi@lists.linux.dev>, Tom Rini <trini@konsulko.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Peter Geis <pgwipeout@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Chen-Yu Tsai <wens@kernel.org>,
 Lukas Schmid <lukas.schmid@netcube.li>
Subject: Re: [PATCH next v3] board: sunxi: Add X96Q support
Message-ID: <aXfATwq781U4ehTn@probook>
References: <20260120-x96q-v3-1-1419ee399fa1@posteo.net>
 <03086904-df06-488c-9e8d-5ad5dab9255a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03086904-df06-488c-9e8d-5ad5dab9255a@arm.com>
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

On Thu, Jan 22, 2026 at 11:53:04PM +0000, Andre Przywara wrote:
> Hi,
> 
> thanks, that looks very good now. Just one tiny thing:
> 
> On 20/01/2026 15:20, J. Neuschäfer via B4 Relay wrote:
> > From: "J. Neuschäfer" <j.ne@posteo.net>
> > 
> > The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
> > 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> > output, and infrared input.
[...]
> > +++ b/configs/x96q_defconfig
> > @@ -0,0 +1,26 @@
> > +CONFIG_ARM=y
> > +CONFIG_ARCH_SUNXI=y
> > +CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-h313-x96q"
> > +CONFIG_DRAM_CLK=600
> > +CONFIG_SPL=y
> > +CONFIG_DRAM_SUNXI_DX_ODT=0x03030303
> > +CONFIG_DRAM_SUNXI_DX_DRI=0x0e0e0e0e
> > +CONFIG_DRAM_SUNXI_CA_DRI=0x1f12
> > +CONFIG_DRAM_SUNXI_TPR0=0xc0001002
> > +CONFIG_DRAM_SUNXI_TPR2=0x00000100
> > +CONFIG_DRAM_SUNXI_TPR10=0x002f0107
> > +CONFIG_DRAM_SUNXI_TPR11=0xddddcccc
> > +CONFIG_DRAM_SUNXI_TPR12=0xeddc7665
> > +CONFIG_MACH_SUN50I_H616=y
> > +CONFIG_SUNXI_DRAM_H616_DDR3_1333=y
> 
> This misses -CONFIG_MMC_SUNXI_SLOT_EXTRA=2 here, was this deliberate? The DT
> mentions the eMMC, and you have CONFIG_SUPPORT_EMMC_BOOT below, so is this
> just on omission? Or did the eMMC not work?
> 
> If you can confirm, I can just add this while committing.

I forgot to test booting from eMMC. Indeed it doesn't work as is.
With CONFIG_MMC_SUNXI_SLOT_EXTRA=2 added, booting from eMMC works.


Thanks again!
J. Neuschäfer
