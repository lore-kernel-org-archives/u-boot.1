Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B24DC54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 11:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D57D87E74;
	Tue, 19 Mar 2024 12:43:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="VSmPsvNs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E59B287E96; Tue, 19 Mar 2024 12:43:10 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4D2D87DEA
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 12:43:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Tue, 19 Mar 2024 12:43:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1710848587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CXrpbH+CO9+HsVmk19fG6t1hi7upkgfOUHZIBSb5So8=;
 b=VSmPsvNsks0YnzXYJYGg0uxCgTbjF5f/WX65QdTE6+rhKMrK9pNp9xKaeEweCi2/MTBBMY
 VrhptxvTLBHg9fvYHTChsIPA8jjKTwSyraLOUVNO+Jo32R2XK87IsddH68YT+s98aQbe5Q
 JGsB6RE8dLRCW/uvwENqoPIj16Iw2Dmy/9QndJu/MRFE/Sid3F5eh6wzq4M8KQXXaEFCT3
 b8NaT+Z/9p4pvMEvxf/zby79JpFT4YD0sFp3Y8beVvAg+VTrw5kpd0TzeDTqhbcIR4Hdbb
 wGHgl2lMx6ZOWH3Dp83/IO2JUIC61T2bP0/O+IOZdTfxkAzgxj+pa43YIuDTPg==
From: Alexander Dahl <ada@thorsis.com>
To: Mihai.Sain@microchip.com
Cc: ada@thorsis.com, eugen.hristev@collabora.com,
 Balamanikandan.Gunasundar@microchip.com,
 michael@amarulasolutions.com, u-boot@lists.denx.de,
 dario.binacchi@amarulasolutions.com
Subject: Re: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Message-ID: <20240319-transpose-enjoyably-6f0a11f36382@thorsis.com>
Mail-Followup-To: Mihai.Sain@microchip.com, eugen.hristev@collabora.com,
 Balamanikandan.Gunasundar@microchip.com,
 michael@amarulasolutions.com, u-boot@lists.denx.de,
 dario.binacchi@amarulasolutions.com
References: <20240307091014.39796-1-ada@thorsis.com>
 <20240307091014.39796-5-ada@thorsis.com>
 <82a5ea3c-ab95-4460-9685-2676fe18d6b5@collabora.com>
 <PH8PR11MB6804301C3B361D21EADCEE71822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <00241bf0-2543-4836-b43f-1b6452caf2e6@collabora.com>
 <PH8PR11MB68048E53C58FAAE710FE51F3822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <20240318-renewal-properly-6edd58ed9c79@thorsis.com>
 <PH8PR11MB68040409774B3441A8657DA1822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH8PR11MB68040409774B3441A8657DA1822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
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

Hello everyone,

Am Mon, Mar 18, 2024 at 11:15:18AM +0000 schrieb Mihai.Sain@microchip.com:
> ------------------------------------------------------------
> > The command is very useful.
> > I would like to have also the ONFI timing mode printed for nand-flash 
> > 😊
> 
> As far as I can see the actually set mode is not stored anywhere.  One could print it after it was successfully set, but that would be in nand base, not in the atmel driver.
> 
> 	OK. Understood.
> 	Thanks.
> 
> > Also I recommend to print the master clock in MHz, and to print the master clock name/label from ccf driver:
> > https://github.com/u-boot/u-boot/blob/master/drivers/clk/at91/sama7g5.
> > c#L410
> 
> Should be possible.  I could do this and send a v2?
> 
> 	Yes Please 😊
> 	Also please note that older SAM9/SAMA5 series have no ccf drivers ☹
> 	Only SAM9X6+ and SAMA7 series have ccf 😊

Okay I thought this would be easy, but it seems not.  This is what I
came up with:

-                printf("mck clock rate: %lu\n", clk_get_rate(nc->mck));
+                printf("%s rate: %lu MHz\n",
+                       nc->mck->dev->name ? nc->mck->dev->name : "mck clock",
+                       clk_get_rate(nc->mck) / 1000000);

And this is the output on sam9x60 with CONFIG_CLK_CCF enabled:

    pmc@fffffc00 rate: 200 MHz

The corresponding line from `clk dump` is:

     200000000            5        |       |           |   `-- mck_div

That name, I don't get it where to get that one.

Greets
Alex

> 	Thanks.
> 
> 
> Greets
> Alex
> 
> >
> > Tested-by: Mihai Sain <mihai.sain@microchip.com>
> >
> > Best regards,
> > Mihai Sain
