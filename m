Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE26C54E58
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 08:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2652187A80;
	Mon, 18 Mar 2024 09:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="Kkxr1cTX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D42D887CB1; Mon, 18 Mar 2024 09:46:43 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E2E879AF
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 09:46:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Mon, 18 Mar 2024 09:46:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1710751600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=QmdBRiRWiLWDLJmWNv/+Lkz34K32pLHKb8CXI6a9u6Y=;
 b=Kkxr1cTX+jX9whDfLUDOpZM/QPUmkqLUvy+Ua2PtpIYqG3fevZZp55mT1FEmzxW33VmNu5
 HWS/fIy7lAYM3GaOyyytoq3RKisVGYL9a6uIemwcjNNYqaaeVnN2vCgJMXcXTbuN81d0hP
 8Zz9eVcYODCfLuGz8KnpSfnqrcsOCr2BlRFVdonRnZYP0hoWvgEuW9FY/Rkx1vxglr8vdq
 Sxek627FtuXKfJ4H+MSXQQsFwvG7PU7VKbNwJ2uIkTzWkNlAi0cjPwdpCaxbCv+aB6zMgu
 EcRZLpaZ3ixTy+SibJ58c0GEkQcOBH7CLe1dy8ZM3jdgKSJOtA5cKc4XjpWG8w==
From: Alexander Dahl <ada@thorsis.com>
To: Mihai.Sain@microchip.com
Cc: eugen.hristev@collabora.com, ada@thorsis.com,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 Balamanikandan.Gunasundar@microchip.com, u-boot@lists.denx.de
Subject: Re: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Message-ID: <20240318-tug-shrank-ae6315aaa6f4@thorsis.com>
Mail-Followup-To: Mihai.Sain@microchip.com, eugen.hristev@collabora.com,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 Balamanikandan.Gunasundar@microchip.com, u-boot@lists.denx.de
References: <20240307091014.39796-1-ada@thorsis.com>
 <20240307091014.39796-5-ada@thorsis.com>
 <82a5ea3c-ab95-4460-9685-2676fe18d6b5@collabora.com>
 <PH8PR11MB6804301C3B361D21EADCEE71822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR11MB6804301C3B361D21EADCEE71822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
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

Am Mon, Mar 18, 2024 at 08:09:00AM +0000 schrieb Mihai.Sain@microchip.com:
> On 3/7/24 11:10, Alexander Dahl wrote:
> > For now adds one new command 'hsmc' with a single subcommand 'decode' 
> > to read and display the content of the registers of the Static Memory 
> > Controllers (SMC/HSMC) found in different at91 SoCs.  Needed to get a 
> > better picture on what raw nand core and atmel nand controller driver 
> > try to set as timings based on ONFI parameters of the connected NAND 
> > chip.
> >
> > Tested on SAMA5D2 and SAM9X60 based boards.  Example output:
> >
> >     U-Boot> hsmc decode
> >
> >     mck clock rate: 200000000
> >
> >     SMC_SETUP3:     0x00000002
> >     SMC_PULSE3:     0x07040703
> >     SMC_CYCLE3:     0x00070007
> >     SMC_MODE3:      0x001f0003
> >     NCS_RD: setup: 0 (0 ns), pulse: 7 (35 ns), hold: 0 (0 ns), cycle: 7 (35 ns)
> >        NRD: setup: 0 (0 ns), pulse: 4 (20 ns), hold: 3 (15 ns), cycle: 7 (35 ns)
> >     NCS_WR: setup: 0 (0 ns), pulse: 7 (35 ns), hold: 0 (0 ns), cycle: 7 (35 ns)
> >        NWE: setup: 2 (10 ns), pulse: 3 (15 ns), hold: 2 (10 ns), cycle: 7 (35 ns)
> >     Standard read is applied.
> >     TDF optimization enabled
> >     TDF cycles: 15 (75 ns)
> >     Data Bus Width: 8-bit bus
> >     NWAIT Mode: 0
> >     Write operation controlled by NWE signal
> >     Read operation controlled by NRD signal
> 
> Adding Mihai as he is usually very interested in such debug information and methods.
> 
> -------------------------------------------------------------------------------------
> 
> Hi Alexander,
> 
> I tested your work on sama7g54-curiosity board:

nice, thanks for that.

> U-Boot> nand info
> 
> Device 0: nand0, sector size 256 KiB
>   Manufacturer  MACRONIX
>   Model         MX30LF4G28AD
>   Device size        512 MiB
>   Page size         4096 b
>   OOB size           256 b
>   Erase size      262144 b
>   ecc strength         8 bits
>   ecc step size      512 b
>   subpagesize       4096 b
>   options       0x00004200
>   bbt options   0x00028000

This seems to be the same NAND chip as on the sam9x60 curiosity, but
your output has three additional lines, see mine:

    U-Boot> nand info
    
    Device 0: nand0, sector size 256 KiB
      Page size         4096 b
      OOB size           256 b
      Erase size      262144 b
      ecc strength         8 bits
      ecc step size      512 b
      subpagesize       4096 b
      options       0x40004200
      bbt options   0x00028000

Do you have some additional patches printing manufacturer, model, and
device size?  I can't see those lines printed in
nand_print_and_set_info() here.

> U-Boot> hsmc decode
> 
> mck clock rate: 200000000
> 
> HSMC_SETUP3:    0x00000001
> HSMC_PULSE3:    0x07040804
> HSMC_CYCLE3:    0x00070008
> HSMC_TIMINGS3:  0x880402f2
> HSMC_MODE3:     0x001f0003
> NCS_RD: setup: 0 (0 ns), pulse: 7 (35 ns), hold: 0 (0 ns), cycle: 7 (35 ns)
>    NRD: setup: 0 (0 ns), pulse: 4 (20 ns), hold: 3 (15 ns), cycle: 7 (35 ns)
> NCS_WR: setup: 0 (0 ns), pulse: 8 (40 ns), hold: 0 (0 ns), cycle: 8 (40 ns)
>    NWE: setup: 1 (5 ns), pulse: 4 (20 ns), hold: 3 (15 ns), cycle: 8 (40 ns)
> TDF optimization enabled
> TDF cycles: 15 (75 ns)
> Data Bus Width: 8-bit bus
> NWAIT Mode: 0
> Write operation controlled by NWE signal
> Read operation controlled by NRD signal

This is also interesting.  Given the mck clock rate is the same as on
sam9x60, I would have guessed the timings set by
atmel_smc_nand_prepare_smcconf() should give the same results, both
for ONFI timiming mode 3, which is the fastest mode the (H)SMC
supports according to comments in the driver.  This is the output with
the patch in question applied on next for sam9x60:

    U-Boot> hsmc decode 
    
    mck clock rate: 200000000
    
    SMC_SETUP3:     0x00000002
    SMC_PULSE3:     0x06030703
    SMC_CYCLE3:     0x00060007
    SMC_MODE3:      0x001f0003
    NCS_RD: setup: 0 (0 ns), pulse: 6 (30 ns), hold: 0 (0 ns), cycle: 6 (30 ns)
       NRD: setup: 0 (0 ns), pulse: 3 (15 ns), hold: 3 (15 ns), cycle: 6 (30 ns)
    NCS_WR: setup: 0 (0 ns), pulse: 7 (35 ns), hold: 0 (0 ns), cycle: 7 (35 ns)
       NWE: setup: 2 (10 ns), pulse: 3 (15 ns), hold: 2 (10 ns), cycle: 7 (35 ns)
    Standard read is applied.
    TDF optimization enabled
    TDF cycles: 15 (75 ns)
    Data Bus Width: 8-bit bus
    NWAIT Mode: 0
    Write operation controlled by NWE signal
    Read operation controlled by NRD signal

Notice the pulse times for read are one clock cycle smaller than in
your output, and the timings for write are also different.  Do you
have changes for atmel_smc_nand_prepare_smcconf() applied which are
not upstream yet?  Or is the HSMC on sama7g54 somehow different than
on older SoCs?

Note: I'm currently testing a patch changing the computation of the
read pulse cycles based on a patch for at91bootstrap [1], but that is
not applied here for the output quoted above.

Greets
Alex

[1] https://github.com/linux4sam/at91bootstrap/issues/174#issuecomment-1970698527

> 
> Best regards,
> Mihai Sain
