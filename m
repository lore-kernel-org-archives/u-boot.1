Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EF3E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 07:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0B0E8021D;
	Thu, 19 Dec 2024 08:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="i/Iu0TcV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F3B48022B; Thu, 19 Dec 2024 08:17:29 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7DF88021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 08:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 32A6F148088C; Thu, 19 Dec 2024 08:17:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1734592645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mthSaLontGMRLtRI2K3QB+e+aNBroW5ARHCF1oP/yrA=;
 b=i/Iu0TcV97oG7+MD4CICrHK1NFcCU7ZqTtdyQ5Qqi45jfI+8fgAa90FJfEGFvqrwh0mtt/
 HQBN5ofVv9Ajbvl7k08/AMPk5QRMBNpNLbn8RrNELe9AyqJvxzwn+Z1xazsaAX4Jc8rF/a
 6K6MkWEq31dyu1n47Ur/kSEF2MvAdC2KuiqDN+e0RXpqmY2r2d3KGfCHSm88hBnMi3MAyV
 Mwhps8Lr606ig4tS+giLUFm4spu+o/MugjnUttDF6ATajglDm1veRo/zY4gzcYEuxdYzVK
 fEAfHI8YbDc/bOfuCT0/vr/wnq3jKhUWXdpz4DN2r3bdNcwrNVRjQy4YLl7/FQ==
Date: Thu, 19 Dec 2024 08:17:17 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Balamanikandan.Gunasundar@microchip.com
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 eugen.hristev@collabora.com, Mihai.Sain@microchip.com,
 Bin.Li@microchip.com, u-boot@lists.denx.de, Nicolas.Ferre@microchip.com
Subject: Re: [PATCH v3 3/3] mtd: nand: raw: atmel: Fix pulse read timing for
 certain NAND flashes
Message-ID: <20241219-failing-crazily-dc8dbc2c3635@thorsis.com>
Mail-Followup-To: Balamanikandan.Gunasundar@microchip.com,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 eugen.hristev@collabora.com, Mihai.Sain@microchip.com,
 Bin.Li@microchip.com, u-boot@lists.denx.de,
 Nicolas.Ferre@microchip.com
References: <20240415074547.779264-1-ada@thorsis.com>
 <20240415075755.780653-1-ada@thorsis.com>
 <20240528-among-detective-e8ad4c9b5457@thorsis.com>
 <20240930-pamperer-prance-8b4566ba43a6@thorsis.com>
 <3a3cc57c-e696-408f-a050-39502081b6f3@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a3cc57c-e696-408f-a050-39502081b6f3@microchip.com>
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

Hello Bala,

Am Wed, Oct 09, 2024 at 04:45:02AM +0000 schrieb Balamanikandan.Gunasundar@microchip.com:
> On 30/09/24 1:37 pm, Alexander Dahl wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Hello,
> > 
> > Am Tue, May 28, 2024 at 12:32:44PM +0200 schrieb Alexander Dahl:
> >> Hei hei,
> >>
> >> Am Mon, Apr 15, 2024 at 09:57:55AM +0200 schrieb Alexander Dahl:
> >>>  From reading the S34ML02G1 and the SAM9X60 datasheets again, it seems
> >>> like we have to wait tREA after rising RE# before sampling the data.
> >>> Thus pulse time must be at least tREA.
> >>>
> >>> Without this fix we got PMECC errors when reading, after switching to
> >>> ONFI timing mode 3 on SAM9X60 SoC with S34ML02G1 raw NAND flash chip.
> >>>
> >>> The approach to set timings used before worked on sam9g20 and sama5d2
> >>> with the same flash (S34ML02G1), probably because those have a slower
> >>> mck clock rate and thus the resolution of the timings setup is not as
> >>> tight as with sam9x60.
> >>>
> >>> The approach to fix the issue was carried over from at91bootstrap, and
> >>> has been successfully tested in at91bootstrap, U-Boot and Linux.
> >>>
> >>> Link: https://github.com/linux4sam/at91bootstrap/issues/174
> >>> Cc: Li Bin <bin.li@microchip.com>
> >>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> >>> ---
> >>>
> >>> Notes:
> >>>      v3:
> >>>      - initial patch version (not present in v1 and v2)
> >>
> >> This patch was send as part of a series, which you wanted to have some
> >> more time to test.  Besides that, has anyone looked into this
> >> particular fix?  Maybe it can be applied separately?
> > 
> > I'd kindly ask what the status of this patch series is from U-Boot
> > NAND subsystem maintainers POV?  Could you test it?  Should I rebase
> > and resend?
> > 
> > Two of these three patches are specific to at91 family, what's the
> > opinion of at91 maintainers on this?
> > 
> > Link to the series discussion for reference:
> > 
> > https://lore.kernel.org/u-boot/20240415074547.779264-1-ada@thorsis.com/T/#u
> > 
> > Greets
> > Alex
> > 
> 
> Hi Alex,
> 
> Apologies for the delay in response. I also faced the same kind of 
> problem while testing our new sam7d65 board with MX30LF4G28AD nand 
> flash. I just had a workaround to increase the pulse time by 5 nsecs 
> just for testing. The issue has been reported to the validation team and 
> an investigation is under progress.
> 
> I would request a few more days for this patch alone.

Did the validation team come to any conclusion on this?

Greets
Alex

> 
> Thanks,
> Bala.
> 
> >>
> >> Greets
> >> Alex
> >>
> >>>
> >>>   drivers/mtd/nand/raw/atmel/nand-controller.c | 13 +++++++++----
> >>>   1 file changed, 9 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> >>> index bbafc88e44c..00ffeadd113 100644
> >>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> >>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> >>> @@ -1133,7 +1133,7 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
> >>>                                        const struct nand_data_interface *conf,
> >>>                                        struct atmel_smc_cs_conf *smcconf)
> >>>   {
> >>> -   u32 ncycles, totalcycles, timeps, mckperiodps;
> >>> +   u32 ncycles, totalcycles, timeps, mckperiodps, pulse;
> >>>      struct atmel_nand_controller *nc;
> >>>      int ret;
> >>>
> >>> @@ -1259,11 +1259,16 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
> >>>                       ATMEL_SMC_MODE_TDFMODE_OPTIMIZED;
> >>>
> >>>      /*
> >>> -    * Read pulse timing directly matches tRP:
> >>> +    * Read pulse timing would directly match tRP,
> >>> +    * but some NAND flash chips (S34ML01G2 and W29N02KVxxAF)
> >>> +    * do not work properly in timing mode 3.
> >>> +    * The workaround is to extend the SMC NRD pulse to meet tREA
> >>> +    * timing.
> >>>       *
> >>> -    * NRD_PULSE = tRP
> >>> +    * NRD_PULSE = max(tRP, tREA)
> >>>       */
> >>> -   ncycles = DIV_ROUND_UP(conf->timings.sdr.tRP_min, mckperiodps);
> >>> +   pulse = max(conf->timings.sdr.tRP_min, conf->timings.sdr.tREA_max);
> >>> +   ncycles = DIV_ROUND_UP(pulse, mckperiodps);
> >>>      totalcycles += ncycles;
> >>>      ret = atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NRD_SHIFT,
> >>>                                        ncycles);
> >>> --
> >>> 2.39.2
> >>>
> >>
> 
