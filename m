Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7382ECCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 11:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB0FF83CB9;
	Fri,  7 Nov 2025 12:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="i/odf047";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C89DD83D07; Fri,  7 Nov 2025 12:01:38 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 768D483CB8
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 12:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D19EA1485122; Fri,  7 Nov 2025 12:01:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1762513292; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=5x8XBHI1QsTVYRtWcLEhgjurcQpjsJptI5XkNxtflkY=;
 b=i/odf047kYauKNw5rOqMgCBBi4g11vh/xwWJ+yQ5WMCC/owSPS7IW3o7x8p8HLxRlPQJR4
 ku3sLKjVd9XiYtG2OXVIa/UF7PcSWXsaAv7LEKx1+7mjTZZ8FLSS7CJo4dOrbGETtQ7PRq
 17YpVEGju1PjL+CIJ/QE1gOL1wdNcVP9tNqg8OKZ9QUMaUQ9OZWYUmjgjDIGcxAhhr/aXO
 2vKXUnfv/zsiIGiSlbaZyAargl33i4dRt+3Y3fVLb/IV2ZGMiRM/ZioTyZ+vlTezDw2qFL
 VjLF3/pOdxSala4DAyJAn7lErxnY7Ts1+Qy07MGyYqIeOnfR9BB8M5fVWubXqQ==
Date: Fri, 7 Nov 2025 12:01:23 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Zixun LI <admin@hifiphile.com>, Alexander Dahl <ada@thorsis.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Subject: Re: [PATCH 1/2] mtd: rawnand: atmel: set pmecc data setup time
Message-ID: <20251107-condone-percolate-51ec103f3ef4@thorsis.com>
Mail-Followup-To: Eugen Hristev <eugen.hristev@linaro.org>,
 Zixun LI <admin@hifiphile.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
References: <20251106-pmecc-v1-0-a1f3cf430be9@hifiphile.com>
 <20251106-pmecc-v1-1-a1f3cf430be9@hifiphile.com>
 <e0a9b9af-330c-4504-8ef3-ba4c3433ce4f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0a9b9af-330c-4504-8ef3-ba4c3433ce4f@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Eugen,

Am Fri, Nov 07, 2025 at 12:52:05PM +0200 schrieb Eugen Hristev:
> Hello Zixun, Alexander,
> 
> On 11/6/25 13:12, Zixun LI wrote:
> > Setup the pmecc data setup time as 3 clock cycles for 133MHz as
> > recommended by the datasheet.
> > 
> > Backported from Linux: f552a7c7 ("mtd: rawnand: atmel: set pmecc data
> > setup time")
> 
> Maybe use 12 digits commit hash ? I cannot find this commit in Linux

v6.16-rc4-10-gf552a7c7e0a14 aka
f552a7c7e0a14215cb8a6fd89e60fa3932a74786 from July 2025.

> 
> > 
> > Fixes: a490e1b7c017c ("nand: atmel: Add pmecc driver")
> > 
> > Signed-off-by: Zixun LI <admin@hifiphile.com>
> > ---
> >  drivers/mtd/nand/raw/atmel/pmecc.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
> > index e500a0fe3f8671ff08195c94c3383696a7731eb3..7c4e9bd5f9967b119239adf2b39e683ea62b71fd 100644
> > --- a/drivers/mtd/nand/raw/atmel/pmecc.c
> > +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
> > @@ -142,6 +142,7 @@ struct atmel_pmecc_caps {
> >  	int nstrengths;
> >  	int el_offset;
> >  	bool correct_erased_chunks;
> > +	bool clk_ctrl;
> >  };
> >  
> >  struct atmel_pmecc_user_conf_cache {
> > @@ -840,6 +841,10 @@ atmel_pmecc_create(struct udevice *dev,
> >  
> >  	pmecc->regs.timing = 0;
> >  
> > +	/* pmecc data setup time */
> > +	if (caps->clk_ctrl)
> > +		writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_CLK);
> > +
> >  	/* Disable all interrupts before registering the PMECC handler. */
> >  	writel(0xffffffff, pmecc->regs.base + ATMEL_PMECC_IDR);
> >  	atmel_pmecc_reset(pmecc);
> > @@ -884,6 +889,7 @@ static struct atmel_pmecc_caps at91sam9g45_caps = {
> >  	.strengths = atmel_pmecc_strengths,
> >  	.nstrengths = 5,
> >  	.el_offset = 0x8c,
> > +	.clk_ctrl = true,
> 
> This appears to be done only for sam9g45.
> 
> So, Alexander, this should not impact sam9x60 .

Yes it should.  According to arch/arm/boot/dts/microchip/sam9x60.dtsi
the compatible used on sam9x60 is "atmel,at91sam9g45-pmecc", see:

	pmecc: ecc-engine@ffffe000 {
			compatible = "microchip,sam9x60-pmecc", "atmel,at91sam9g45-pmecc";
			reg = <0xffffe000 0x300>,
					<0xffffe600 0x100>;
	};

> I looked a bit in the Linux driver and this appears to be just as bad:
> 133 Mhz clock config hardcoded. I would expect this clock to be taken
> from a clock input and not hardcoded. But oh well, if this clock is to
> be changed in another device, it would be exposed somewhere...

I did not look into that deeply, but if it is like you said, someone
should.  This sounds bad.

Greets
Alex

> 
> Eugen
> 
> >  };
> >  
> >  static struct atmel_pmecc_caps sama5d4_caps = {
> > 
> 
