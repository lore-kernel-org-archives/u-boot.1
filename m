Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AA3C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 10:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CA1587D82;
	Mon, 18 Mar 2024 11:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="IQV2cQHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96A7087DFA; Mon, 18 Mar 2024 11:27:55 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6031C879F4
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 11:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Mon, 18 Mar 2024 11:27:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1710757671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b0zSLkKBG+QFzCPx+UsowajqaeanGRIzJ9bhfjVhSUI=;
 b=IQV2cQHq2jkYRbmodjPEArVsAbiTnagSbBidRNH1ba1nARm8Q3m6kCWlq5s8EYNf1MiAy8
 SisV5Jkmtg9FwPPpy+eAgxebkmvmOVehE4lEvE8D6zbx675ndmWG3PaKhHdcIz/NV8L0mn
 5ahHxtP0sZ2Cl9A4/kxYfk8+/0FayH4rWxIlJYA7oN2fNMeO0VODY69Y9eLWd0tEAvC6Xw
 O8Z0MRwEq/zKcmwdQYi8SS5rFBGXwvW8T+J5ZZjI/twHgh54MNGLggNVVBpu7zPk1m7gpz
 KuWJBFoz9XkfO4uWRTAFqxp4ADaVhF4Hi7gboL15/yi0n+3ZVhSsqzoT4Rfh9g==
From: Alexander Dahl <ada@thorsis.com>
To: Mihai.Sain@microchip.com
Cc: eugen.hristev@collabora.com, Balamanikandan.Gunasundar@microchip.com,
 ada@thorsis.com, michael@amarulasolutions.com, u-boot@lists.denx.de,
 dario.binacchi@amarulasolutions.com
Subject: Re: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Message-ID: <20240318-renewal-properly-6edd58ed9c79@thorsis.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH8PR11MB68048E53C58FAAE710FE51F3822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
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

Hello Mihai,

Am Mon, Mar 18, 2024 at 09:15:29AM +0000 schrieb Mihai.Sain@microchip.com:
> > Hi Alexander,
> >
> > I tested your work on sama7g54-curiosity board:
> >
> > U-Boot> nand info
> >
> > Device 0: nand0, sector size 256 KiB
> >   Manufacturer  MACRONIX
> >   Model         MX30LF4G28AD
> >   Device size        512 MiB
> >   Page size         4096 b
> >   OOB size           256 b
> >   Erase size      262144 b
> >   ecc strength         8 bits
> >   ecc step size      512 b
> >   subpagesize       4096 b
> >   options       0x00004200
> >   bbt options   0x00028000
> >
> > U-Boot> hsmc decode
> >
> > mck clock rate: 200000000
> >
> > HSMC_SETUP3:    0x00000001
> > HSMC_PULSE3:    0x07040804
> > HSMC_CYCLE3:    0x00070008
> > HSMC_TIMINGS3:  0x880402f2
> > HSMC_MODE3:     0x001f0003
> > NCS_RD: setup: 0 (0 ns), pulse: 7 (35 ns), hold: 0 (0 ns), cycle: 7 (35 ns)
> >    NRD: setup: 0 (0 ns), pulse: 4 (20 ns), hold: 3 (15 ns), cycle: 7 
> > (35 ns)
> > NCS_WR: setup: 0 (0 ns), pulse: 8 (40 ns), hold: 0 (0 ns), cycle: 8 (40 ns)
> >    NWE: setup: 1 (5 ns), pulse: 4 (20 ns), hold: 3 (15 ns), cycle: 8 
> > (40 ns) TDF optimization enabled TDF cycles: 15 (75 ns) Data Bus 
> > Width: 8-bit bus NWAIT Mode: 0 Write operation controlled by NWE 
> > signal Read operation controlled by NRD signal
> >
> > Best regards,
> > Mihai Sain
> 
> Hello Mihai,
> 
> If you have any suggestions for improvement, changes, or you are happy with this command, is it useful ?
> You can provide your Tested-by then if you consider this is useful
> 
> Eugen
> 
> ----------------------------------------------------------------------
> 
> Hello Eugen,
> 
> Yes.
> The command is very useful.
> I would like to have also the ONFI timing mode printed for nand-flash 😊

As far as I can see the actually set mode is not stored anywhere.  One
could print it after it was successfully set, but that would be in
nand base, not in the atmel driver.

> Also I recommend to print the master clock in MHz, and to print the master clock name/label from ccf driver:
> https://github.com/u-boot/u-boot/blob/master/drivers/clk/at91/sama7g5.c#L410

Should be possible.  I could do this and send a v2?

Greets
Alex

> 
> Tested-by: Mihai Sain <mihai.sain@microchip.com>
> 
> Best regards,
> Mihai Sain
