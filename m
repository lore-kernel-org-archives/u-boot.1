Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62812CCFA1A
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 11:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE81183D0C;
	Fri,  7 Nov 2025 12:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="Pq2nW4yh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 136ED83D0C; Fri,  7 Nov 2025 12:17:44 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB0A983CB1
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 12:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5F2181485248; Fri,  7 Nov 2025 12:17:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1762514260; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=d0reGSBj6W9DErgA+Aso/nA85PmzaeWTy9apMhy9wxQ=;
 b=Pq2nW4yhy4xmzKFVQGxp8rPIHYNOIWgKKT9JBVxz3Gcj+hazt9+P/fv/6phd9xpQ96kdCC
 Ah/2Cc0qbf78FbgEA3mwxrEC5hvxi68rBUpWxEwb74+feJqz/2bG0was8jewtdzvRbfjHD
 Q0WKU1oLMK6xaPwD4Tmht45pgotwpO0CvXTC+AmurIlluoSiKWEu4j7cAVjgkGhojfCxN2
 vnxWmgKsX9VcrYW3y4shAbXGkH8esfE48K5j8fiskMVj04cqzlG3IBfgsoQuh5l/h91Bqx
 d/xA7FxseHmcWBXL6betXlcswyyJOFO7UBZpRYQFCcoiF9ndiB7DfnhHDTfnTQ==
Date: Fri, 7 Nov 2025 12:17:37 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Zixun LI <admin@hifiphile.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Alexander Dahl <ada@thorsis.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: atmel: Remove timing from atmel_pmecc
 struct
Message-ID: <20251107-sandpaper-blaming-e68f3c89ccc0@thorsis.com>
Mail-Followup-To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Eugen Hristev <eugen.hristev@linaro.org>,
 Zixun LI <admin@hifiphile.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>
References: <20251106-pmecc-v1-0-a1f3cf430be9@hifiphile.com>
 <20251106-pmecc-v1-2-a1f3cf430be9@hifiphile.com>
 <68d45e9e-8eed-439d-be9b-9d6f9e13fe89@linaro.org>
 <CAOf5uwkZUnUSjJ=CqtZhVf-rQ31eU4gC5o+XDXKJEAtRrY4NKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOf5uwkZUnUSjJ=CqtZhVf-rQ31eU4gC5o+XDXKJEAtRrY4NKQ@mail.gmail.com>
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

Hello Michael,

Am Fri, Nov 07, 2025 at 12:04:16PM +0100 schrieb Michael Nazzareno Trimarchi:
> Hi
> 
> On Fri, Nov 7, 2025 at 11:56 AM Eugen Hristev <eugen.hristev@linaro.org> wrote:
> >
> >
> >
> > On 11/6/25 13:12, Zixun LI wrote:
> > > "timing" is unused in atmel_pmecc struct, also it's not exist in Linux
> > > driver, let's remove it.
> > >
> > > Signed-off-by: Zixun LI <admin@hifiphile.com>
> > > ---
> > >  drivers/mtd/nand/raw/atmel/pmecc.c | 2 --
> > >  drivers/mtd/nand/raw/atmel/pmecc.h | 1 -
> > >  2 files changed, 3 deletions(-)
> > >
> > > diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
> > > index 7c4e9bd5f9967b119239adf2b39e683ea62b71fd..8fc5614cc0091d3e0f4b9280beee9e684fe2a57d 100644
> > > --- a/drivers/mtd/nand/raw/atmel/pmecc.c
> > > +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
> > > @@ -839,8 +839,6 @@ atmel_pmecc_create(struct udevice *dev,
> > >       ofnode_read_resource(dev->node_, 1, &res);
> > >       pmecc->regs.errloc = (void *)res.start;
> > >
> > > -     pmecc->regs.timing = 0;
> > > -
> >
> > I see there is also an unused parameter to atmel_pmecc_create() called
> > timing_res_idx .
> > Maybe this parameter was intended to be passed to the timing mapped memory ?
> >
> > If the timing_res_idx is related and unused as well, isn't it supposed
> > to be removed together ?
> >
> > I see it's being called with a hardcoded "2" , does this have any
> > significance that you know of ? Or it can be safely removed.
> >
> > Eugen
> >
> > >       /* pmecc data setup time */
> > >       if (caps->clk_ctrl)
> > >               writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_CLK);
> > > diff --git a/drivers/mtd/nand/raw/atmel/pmecc.h b/drivers/mtd/nand/raw/atmel/pmecc.h
> > > index 43f96b2f168c7b88e0c907996f2ae64f8554ed58..88b0d18040e7c48f226c74ce9b5caf93b5760360 100644
> > > --- a/drivers/mtd/nand/raw/atmel/pmecc.h
> > > +++ b/drivers/mtd/nand/raw/atmel/pmecc.h
> > > @@ -65,7 +65,6 @@ struct atmel_pmecc {
> > >       struct {
> > >               void __iomem *base;
> > >               void __iomem *errloc;
> > > -             void __iomem *timing;
> > >       } regs;
> > >
> > >       /* Mutex used for pmecc enable/disable */
> > >
> >
> I'm willing to help to clock part of nand, can someone point where I
> can buy the board?

I use the Microchip SAM9X60 Curiosity:

https://www.microchip.com/en-us/development-tool/ev40e67a

It's also available from Mouser, RS, Digikey, and probably more.

The NAND flash populated on that board is an MX30LF4G28AD-XKI [1].

Greets
Alex

[1] https://www.mxic.com.tw/en-us/products/NAND-Flash/SLC-NAND-Flash/Pages/spec.aspx?p=MX30LF4G28AD&m=SLC+NAND&n=PM2579
