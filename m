Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1DEC54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 12:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EE9B87E02;
	Mon, 18 Mar 2024 13:06:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="EqS4/Vad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D03DE87527; Mon, 18 Mar 2024 13:06:56 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D92C87527
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 13:06:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Date: Mon, 18 Mar 2024 13:06:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
 t=1710763613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=irKmTw6Haiz02XSjspb7bHIpWDQ9mf6qeOjHWCnmHs0=;
 b=EqS4/VadQJBSNdZkttBdSpL4rYHG+0WWrWzgdWD+AbAkG+sFJF/gTMAiHdJknIoxK1rKgP
 zjaNZOKGaJm7Diaerr5whyfEJTswXXIKpPzQV+4b4gsh+ZWC9MPlsZ4UkmM2FLop+NUFjG
 vLuRxSGtKMbFDBH19FVWkgv5MrIJGzxUeap1OCGgH1FLA1sUxaPN7D9p8znZ2Zns2rupaM
 LU0PubhNzdjNMNADp0scG7cV4TpizWbC6CJP/hBxlxjqVWBj54nqOUaDUIAvfPa5KBk1UF
 JQhygHgu7tO+JXFjt2xwK8fRqywFrmtDtYsrqOEmrRhsMiKCO1abwSmHr5DM4w==
From: Alexander Dahl <ada@thorsis.com>
To: Mihai.Sain@microchip.com
Cc: ada@thorsis.com, eugen.hristev@collabora.com,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 Balamanikandan.Gunasundar@microchip.com, u-boot@lists.denx.de,
 Li Bin <bin.li@microchip.com>
Subject: Re: [PATCH 4/4] mtd: nand: raw: atmel: Introduce optional debug
 commands
Message-ID: <20240318-rethink-krypton-c8479159e755@thorsis.com>
Mail-Followup-To: Mihai.Sain@microchip.com, eugen.hristev@collabora.com,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 Balamanikandan.Gunasundar@microchip.com, u-boot@lists.denx.de,
 Li Bin <bin.li@microchip.com>
References: <20240307091014.39796-1-ada@thorsis.com>
 <20240307091014.39796-5-ada@thorsis.com>
 <82a5ea3c-ab95-4460-9685-2676fe18d6b5@collabora.com>
 <PH8PR11MB6804301C3B361D21EADCEE71822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <20240318-tug-shrank-ae6315aaa6f4@thorsis.com>
 <PH8PR11MB68045C740982A66703188E70822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <20240318-crate-glisten-c4ee6f3469ea@thorsis.com>
 <PH8PR11MB68042D7DF9FDA068033F4CEB822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
Content-Type: multipart/mixed; boundary="4a04mp036Flhf1b6"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH8PR11MB68042D7DF9FDA068033F4CEB822D2@PH8PR11MB6804.namprd11.prod.outlook.com>
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


--4a04mp036Flhf1b6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Mihai,

Am Mon, Mar 18, 2024 at 11:28:39AM +0000 schrieb Mihai.Sain@microchip.com:
> Hi Alexander,
> 
> I'm sorry for quoting because the email is sent from Outlook ☹
> 
> > > U-Boot> nand info
> > >
> > > Device 0: nand0, sector size 256 KiB
> > >   Manufacturer  MACRONIX
> > >   Model         MX30LF4G28AD
> > >   Device size        512 MiB
> > >   Page size         4096 b
> > >   OOB size           256 b
> > >   Erase size      262144 b
> > >   ecc strength         8 bits
> > >   ecc step size      512 b
> > >   subpagesize       4096 b
> > >   options       0x00004200
> > >   bbt options   0x00028000
> >
> > This seems to be the same NAND chip as on the sam9x60 curiosity, but your output has three additional lines, see mine:
> > Do you have some additional patches printing manufacturer, model, and 
> > device size?  I can't see those lines printed in
> > nand_print_and_set_info() here.
> >
> > Yes. I have 😊
> > +     printf("  Manufacturer  %s \n", chip->onfi_params.manufacturer);
> > +     printf("  Model         %s \n", chip->onfi_params.model);
> > +     printf("  Device size   %8d MiB\n", (int)(chip->chipsize >> 20));
> 
> This is nice, and I think it would be valuable to have upstream.
> Maybe you could send a patch for that?
> 	Sure. I will send the patch !
> 
> > > U-Boot> hsmc decode
> > >
> > > mck clock rate: 200000000
> > >
> > > HSMC_SETUP3:    0x00000001
> > > HSMC_PULSE3:    0x07040804
> > > HSMC_CYCLE3:    0x00070008
> > > HSMC_TIMINGS3:  0x880402f2
> > > HSMC_MODE3:     0x001f0003
> > > NCS_RD: setup: 0 (0 ns), pulse: 7 (35 ns), hold: 0 (0 ns), cycle: 7 (35 ns)
> > >    NRD: setup: 0 (0 ns), pulse: 4 (20 ns), hold: 3 (15 ns), cycle: 7
> > > (35 ns)
> > > NCS_WR: setup: 0 (0 ns), pulse: 8 (40 ns), hold: 0 (0 ns), cycle: 8 (40 ns)
> > >    NWE: setup: 1 (5 ns), pulse: 4 (20 ns), hold: 3 (15 ns), cycle: 8
> > > (40 ns) TDF optimization enabled TDF cycles: 15 (75 ns) Data Bus
> > > Width: 8-bit bus NWAIT Mode: 0 Write operation controlled by NWE 
> > > signal Read operation controlled by NRD signal
> >
> > This is also interesting.  Given the mck clock rate is the same as on 
> > sam9x60, I would have guessed the timings set by
> > atmel_smc_nand_prepare_smcconf() should give the same results, both for ONFI timiming mode 3, which is the fastest mode the (H)SMC supports according to comments in the driver.  This is the output with the patch in question applied on next for sam9x60:
> >
> >     U-Boot> hsmc decode
> >
> >     mck clock rate: 200000000
> >
> >     SMC_SETUP3:     0x00000002
> >     SMC_PULSE3:     0x06030703
> >     SMC_CYCLE3:     0x00060007
> >     SMC_MODE3:      0x001f0003
> >     NCS_RD: setup: 0 (0 ns), pulse: 6 (30 ns), hold: 0 (0 ns), cycle: 6 (30 ns)
> >        NRD: setup: 0 (0 ns), pulse: 3 (15 ns), hold: 3 (15 ns), cycle: 6 (30 ns)
> >     NCS_WR: setup: 0 (0 ns), pulse: 7 (35 ns), hold: 0 (0 ns), cycle: 7 (35 ns)
> >        NWE: setup: 2 (10 ns), pulse: 3 (15 ns), hold: 2 (10 ns), cycle: 7 (35 ns)
> >     Standard read is applied.
> >     TDF optimization enabled
> >     TDF cycles: 15 (75 ns)
> >     Data Bus Width: 8-bit bus
> >     NWAIT Mode: 0
> >     Write operation controlled by NWE signal
> >     Read operation controlled by NRD signal
> >
> > Notice the pulse times for read are one clock cycle smaller than in your output, and the timings for write are also different.  Do you have changes for atmel_smc_nand_prepare_smcconf() applied which are not upstream yet?  Or is the HSMC on sama7g54 somehow different than on older SoCs?
> >
> > Yes. I force timing mode 2 in nand-controller.c:
> > +     if (conf->timings.sdr.tRC_min < 30001) // force timing mode 2, 
> > + 35ns for read/write cycle
> >
> > This will pass the nand torture test 😊
> >
> > U-Boot> nand torture 0x800000 0x1000000
> >
> > NAND torture: device 0 offset 0x800000 size 0x1000000 (block size 
> > 0x40000)
> >  Passed: 64, failed: 0
> 
> Ah okay.  I have another patch here for manually setting the ONFI timing mode from commandline.  This is probably too late for some scenarios, but it helped me when testing.  If you're interested I could send it to the public.
> 	Yes. I'm very interested !

Okay, I'll add it to v2 of the series then.

> 	Maybe we should add an automatic fallback for timing mode in nand-controller.c 😊
> 	As of now the driver is forcing tRC_min to 30ns (mode 3), which is not reliable for sama7 nfc controller ☹
> 	https://github.com/u-boot/u-boot/blob/master/drivers/mtd/nand/raw/nand_timings.c#L167
> 	The nand torture command helped me to manually force tRC_min to 35ns (mode 2).

This sounds like the same problem encountered in
https://github.com/linux4sam/at91bootstrap/issues/174 and the fix
proposed there works in Linux and U-Boot as well.  I consider the
original commit message of the patch attached to that ticket not easy
to understand however, so I wrote what I think is the problem.  Could
you please test the patch attached to this mail which does the same
thing and should apply to U-Boot cleanly?  I tested that on sam9x60
and sama5, but have no other boards/socs to test with.  If that works
on sama7, I will propose it on U-Boot, too.

(I hope it is okay to attach it as an attachment for now, it's not
ready for submission anyways.)

Greets
Alex

> 	Thanks.
> 
> Greets
> Alex
> 
> >
> > Note: I'm currently testing a patch changing the computation of the read pulse cycles based on a patch for at91bootstrap [1], but that is not applied here for the output quoted above.
> >
> > Greets
> > Alex
> >
> > [1] 
> > https://github.com/linux4sam/at91bootstrap/issues/174#issuecomment-197
> > 0698527
> >
> > >
> > > Best regards,
> > > Mihai Sain

--4a04mp036Flhf1b6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-mtd-nand-raw-atmel-Port-timing-fix-from-at91bootstra.patch"

From 3ab90ab8a817c79013c6d57d5ac4e52d5242295e Mon Sep 17 00:00:00 2001
From: Alexander Dahl <ada@thorsis.com>
Date: Tue, 12 Mar 2024 13:41:04 +0100
Subject: [PATCH] mtd: nand: raw: atmel: Port timing fix from at91bootstrap

From reading the S34ML02G1 and the SAM9X60 datasheets again, it seems
like we have to wait tREA after rising RE# before sampling the data.
Thus pulse must be at least tREA.  The fix works in bootstrap, u-boot,
and Linux, but the explanation might be improved.  It probably worked on
sam9g20 and sama5d2 before, because those have a slower mck clock rate
and thus the resolution of the timings setup is not as tight as with
sam9x60.

Without the fix we got PMECC errors when reading after switching to ONFI
timing mode 3.

Link: https://github.com/linux4sam/at91bootstrap/issues/174
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 4b6c9a79306..405987acd51 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1168,7 +1168,7 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
 					  const struct nand_data_interface *conf,
 					  struct atmel_smc_cs_conf *smcconf)
 {
-	u32 ncycles, totalcycles, timeps, mckperiodps;
+	u32 ncycles, totalcycles, timeps, mckperiodps, pulse;
 	struct atmel_nand_controller *nc;
 	int ret;
 
@@ -1294,11 +1294,16 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
 			 ATMEL_SMC_MODE_TDFMODE_OPTIMIZED;
 
 	/*
-	 * Read pulse timing directly matches tRP:
+	 * Read pulse timing would directly match tRP,
+	 * but some NAND flash chips (S34ML01G2 and W29N02KVxxAF)
+	 * do not work properly in timing mode 3.
+	 * The workaround is to extend the SMC NRD pulse to meet tREA
+	 * timing.
 	 *
-	 * NRD_PULSE = tRP
+	 * NRD_PULSE = max(tRP, tREA)
 	 */
-	ncycles = DIV_ROUND_UP(conf->timings.sdr.tRP_min, mckperiodps);
+	pulse = max(conf->timings.sdr.tRP_min, conf->timings.sdr.tREA_max);
+	ncycles = DIV_ROUND_UP(pulse, mckperiodps);
 	totalcycles += ncycles;
 	ret = atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NRD_SHIFT,
 					  ncycles);
-- 
2.39.2


--4a04mp036Flhf1b6--
