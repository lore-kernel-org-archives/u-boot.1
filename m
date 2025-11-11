Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60634CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 12:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD28A83A91;
	Tue, 11 Nov 2025 13:15:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="lF9yV2vC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 218F983EC9; Tue, 11 Nov 2025 13:15:47 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9D1583A79
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 13:15:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C806D14800B1; Tue, 11 Nov 2025 13:15:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1762863343; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=I92feC3+4tic6LxCk/uzjivPPNc2rJ+bU0ZiL/Un9Ms=;
 b=lF9yV2vC3JeGfeAV41tfJAHnwMFcdpj4TTk0Gz7GpoQ6dGG8C/jXXDo45aH8WFfXpaBH/e
 bVwDscJXDpY62YflzA0aB/cvUKfkwCGvm8djr6P+ghhdDgDwQukFqLQfvnxkmmTDOkMgjS
 TF/Ds9jKBCpbs0DM0mCAZYfC7YnBY1MnGIaIUcsqlOHoQsZguKSb1+2VwjKSOI5hiYZ8Zh
 R2qwBUYnCYoQBtqB5EfQUt2n1iCvkkNtut/1k6NM0Fx/9dGTRlrmWDA8C4RcXAT6hYvucr
 qLbnAGvw4vUhiLi2OjzWMqp/dvsOMIM+Wed3XCD88OSEPZT9scVJMVW9I3865A==
Date: Tue, 11 Nov 2025 13:15:41 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Alexander Dahl <ada@thorsis.com>, Tom Rini <trini@konsulko.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Zixun LI <admin@hifiphile.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] ARM: dts: at91: sam9x60: Add spi0 node (flexcom 0)
Message-ID: <20251111-landfall-rockslide-407d7bf1a9c5@thorsis.com>
Mail-Followup-To: Eugen Hristev <eugen.hristev@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Zixun LI <admin@hifiphile.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
References: <20251111112637.919074-1-ada@thorsis.com>
 <20251111112637.919074-4-ada@thorsis.com>
 <dec7e0eb-5df4-4d3e-878a-13587291ade1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dec7e0eb-5df4-4d3e-878a-13587291ade1@linaro.org>
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

Am Tue, Nov 11, 2025 at 01:34:35PM +0200 schrieb Eugen Hristev:
> 
> 
> On 11/11/25 13:26, Alexander Dahl wrote:
> > Copied from linux kernel v6.18-rc4.  Stripped attributes not supported
> > by U-Boot drivers (dma, interrupt, fifo-size).
> 
> Hello Alexander,
> 
> Have you tried to configure the build to use upstream DTS ? this should
> be available in the U-boot dir. CONFIG_OF_UPSTREAM I believe.

Quick try with _just_ enabling CONFIG_OF_UPSTREAM and adding the
obligatory folder to CONFIG_DEFAULT_DEVICE_TREE leads to the expected
build errors:

  DTC     dts/upstream/src/arm/microchip/at91-sam9x60_curiosity.dtb
Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:43.1-7 Label or path clk32 not found
Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:51.1-9 Label or path main_rc not found
Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:67.1-16 Label or path pinctrl_sdhci0 not found
Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:79.1-9 Label or path pit64b0 not found
Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:87.1-8 Label or path sdhci0 not found
Error: …/u-boot/arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi:91.1-13 Label or path slow_rc_osc not found
FATAL ERROR: Syntax error parsing input tree

Not bad for the first shot, but I guess at least the clock related
issues might get challenging.  However I need to put this aside for later.

One question though, while we are at it:  Would it be possible to
define a custom dts in U-Boot and include an upstream .dtsi?

Greets
Alex

> 
> Also, if you really want to update this u-boot DT, you would have to
> copy it as-is, no stripping. Even if the props are unused. The only real
> issue would be if Uboot stops working or gets confused by these extra props
> 
> Eugen>
> > Signed-off-by: Alexander Dahl <ada@thorsis.com>
> > ---
> >  arch/arm/dts/sam9x60.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/arm/dts/sam9x60.dtsi b/arch/arm/dts/sam9x60.dtsi
> > index a33c0d57398..1ee30422518 100644
> > --- a/arch/arm/dts/sam9x60.dtsi
> > +++ b/arch/arm/dts/sam9x60.dtsi
> > @@ -182,6 +182,16 @@
> >  				ranges = <0x0 0xf801c000 0x800>;
> >  				status = "disabled";
> >  
> > +				spi0: spi@400 {
> > +					compatible = "microchip,sam9x60-spi", "atmel,at91rm9200-spi";
> > +					reg = <0x400 0x200>;
> > +					#address-cells = <1>;
> > +					#size-cells = <0>;
> > +					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
> > +					clock-names = "spi_clk";
> > +					status = "disabled";
> > +				};
> > +
> >  				i2c0: i2c@600 {
> >  					compatible = "microchip,sam9x60-i2c";
> >  					reg = <0x600 0x200>;
> 

-- 
Alexander Dahl           Thorsis Technologies GmbH   T +49 391 544 563 1000
Industrieautomation      Oststr. 18                  F +49 391 544 563 9099
T +49 391 544 563 3036   39114 Magdeburg             https://www.thorsis.com/

Sitz der Gesellschaft: Magdeburg
Amtsgericht Stendal HRB 30646
Geschäftsführer: Dipl.-Inf. Michael Huschke
