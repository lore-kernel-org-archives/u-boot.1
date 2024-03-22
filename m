Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDAAC47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8542E87FA3;
	Fri, 22 Mar 2024 12:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="BZVBbMFK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D4BD881A0; Fri, 22 Mar 2024 12:46:58 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FD6287B77
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 12:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Fri, 22 Mar 2024 12:46:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1711108015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=WyfJYCitbm2c1X9RHaQJ9bor4/lI9EfGc00eQlapK7U=;
 b=BZVBbMFKNrL9OQxGOQ9lDdaaxEr/hk4+Q1Bd7mxW7IW23hBOyCsTjLmd7jW8GYMlG7g5WW
 iYVsEho7FS+DnEqHJKN/+67pwByWCDRDkfbqMi+ZwRK+eJiB5tT0jDpRuPpVBN69FbViPk
 g4tvo93cmD12hq+N+kLasb8xe5+8i6gYFGHBmJCjWdgldGJ0A3sZ81Ua8yNrNpWYF07tC2
 tb8TBwcxC9Lmchj3zgKY0m08jwqh0wCVsfssVx/WbB0zSNs9JSZGojuNr4MSjrC7KrXNQ3
 hv1+vgySYUCpnuNLzRv3g9uTeGS3B6BM95Zn0kMc63gvy4/uL8ccEFPCX6GF1A==
From: Alexander Dahl <ada@thorsis.com>
To: Mihai.Sain@microchip.com
Cc: michael@amarulasolutions.com, ada@thorsis.com,
 dario.binacchi@amarulasolutions.com,
 Balamanikandan.Gunasundar@microchip.com,
 eugen.hristev@collabora.com, Bin.Li@microchip.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 6/6] cmd: nand: Add new optional sub-command 'onfi'
Message-ID: <20240322-cupbearer-tray-de2157fd9c07@thorsis.com>
Mail-Followup-To: Mihai.Sain@microchip.com, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com,
 Balamanikandan.Gunasundar@microchip.com,
 eugen.hristev@collabora.com, Bin.Li@microchip.com,
 u-boot@lists.denx.de
References: <20240320090214.40465-1-ada@thorsis.com>
 <20240320090214.40465-7-ada@thorsis.com>
 <PH8PR11MB680479987099973E85D6CC6C82332@PH8PR11MB6804.namprd11.prod.outlook.com>
 <CAOf5uwmeW0_0rjXgoPBHK2XPYJk=D9Cdw4Qc7rQ_TPuOanCHwQ@mail.gmail.com>
 <PH8PR11MB680480DD4A44E187DFC4A9B782312@PH8PR11MB6804.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH8PR11MB680480DD4A44E187DFC4A9B782312@PH8PR11MB6804.namprd11.prod.outlook.com>
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

Am Fri, Mar 22, 2024 at 10:02:29AM +0000 schrieb Mihai.Sain@microchip.com:
> Hi Michael,
> 
> -------------------------------------------------------
> 
> I think this command can be really useful.
> Let try to have more testing on more boards
> 
> ---------------------------------------------------------
> 
> I managed to test the command on sama7g54-curiosity board.

Thanks for that.  Nice to see it works on other variants of the SoC
family.

> I also forced timing mode 5 from controller driver (conf->timings.sdr.tRC_min < 20000).

You did a similar thing for the sam9x75.  These boards/socs seem to
have a newer SMC / HSMC controller than sama5d2 or sam9x60?  The
driver claims all the (H)SMC incarnations do _not_ support these EDO
modes 4 and 5.  Maybe someone could have a deeper look at the
datasheets of the newer SoCs and propose a patch to support those
newer controllers in the atmel nand-controller driver?  I guess the
problem is the same in Linux, right?

Greets
Alex

> 
> => nand onfi 0
> => hsmc decode
> 
> MCK rate: 200 MHz
> 
> HSMC_SETUP3:    0x00000004
> HSMC_PULSE3:    0x140a140a
> HSMC_CYCLE3:    0x00140014
> HSMC_TIMINGS3:  0x880805f4
> HSMC_MODE3:     0x001f0003
> NCS_RD: setup: 0 (0 ns), pulse: 20 (100 ns), hold: 0 (0 ns), cycle: 20 (100 ns)
>    NRD: setup: 0 (0 ns), pulse: 10 (50 ns), hold: 10 (50 ns), cycle: 20 (100 ns)
> NCS_WR: setup: 0 (0 ns), pulse: 20 (100 ns), hold: 0 (0 ns), cycle: 20 (100 ns)
>    NWE: setup: 4 (20 ns), pulse: 10 (50 ns), hold: 6 (30 ns), cycle: 20 (100 ns)
> TDF optimization enabled
> TDF cycles: 15 (75 ns)
> Data Bus Width: 8-bit bus
> NWAIT Mode: 0
> Write operation controlled by NWE signal
> Read operation controlled by NRD signal
> NFSEL (NAND Flash Selection) is set
> OCMS (Off Chip Memory Scrambling) is disabled
> TWB (WEN High to REN to Busy): 64 (320 ns)
> TRR (Ready to REN Low Delay):  64 (320 ns)
> TAR (ALE to REN Low Delay):    5 (25 ns)
> TADL (ALE to Data Start):      71 (355 ns)
> TCLR (CLE to REN Low Delay):   4 (20 ns)
> 
> => time nand torture 0x1000000 0x1000000
> 
> NAND torture: device 0 offset 0x1000000 size 0x1000000 (block size 0x40000)
>  Passed: 64, failed: 0
> 
> time: 22.638 seconds
> 
> => nand onfi 5
> => hsmc decode
> 
> MCK rate: 200 MHz
> 
> HSMC_SETUP3:    0x00000001
> HSMC_PULSE3:    0x07040502
> HSMC_CYCLE3:    0x00070005
> HSMC_TIMINGS3:  0x880402f2
> HSMC_MODE3:     0x001f0003
> NCS_RD: setup: 0 (0 ns), pulse: 7 (35 ns), hold: 0 (0 ns), cycle: 7 (35 ns)
>    NRD: setup: 0 (0 ns), pulse: 4 (20 ns), hold: 3 (15 ns), cycle: 7 (35 ns)
> NCS_WR: setup: 0 (0 ns), pulse: 5 (25 ns), hold: 0 (0 ns), cycle: 5 (25 ns)
>    NWE: setup: 1 (5 ns), pulse: 2 (10 ns), hold: 2 (10 ns), cycle: 5 (25 ns)
> TDF optimization enabled
> TDF cycles: 15 (75 ns)
> Data Bus Width: 8-bit bus
> NWAIT Mode: 0
> Write operation controlled by NWE signal
> Read operation controlled by NRD signal
> NFSEL (NAND Flash Selection) is set
> OCMS (Off Chip Memory Scrambling) is disabled
> TWB (WEN High to REN to Busy): 64 (320 ns)
> TRR (Ready to REN Low Delay):  4 (20 ns)
> TAR (ALE to REN Low Delay):    2 (10 ns)
> TADL (ALE to Data Start):      71 (355 ns)
> TCLR (CLE to REN Low Delay):   2 (10 ns)
> 
> => time nand torture 0x1000000 0x1000000
> 
> NAND torture: device 0 offset 0x1000000 size 0x1000000 (block size 0x40000)
>  Passed: 64, failed: 0
> 
> time: 11.661 seconds
> 
> => nand info
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
>   options       0x40004200
>   bbt options   0x00028000
> 
> Best regards,
> Mihai Sain
