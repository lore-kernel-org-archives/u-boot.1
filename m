Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD401E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 07:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CA778021D;
	Thu, 19 Dec 2024 08:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="U/wwbfGU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9895E8022B; Thu, 19 Dec 2024 08:19:37 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 383128021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 08:19:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2736C148088A; Thu, 19 Dec 2024 08:19:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1734592774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eAydSBYxlab2jsAk9WzxEcPhRkT2dUAP8/+6vNevZM0=;
 b=U/wwbfGUjVpF6Hm7XmhCAvQyM9TA0JrKEDkSHfXsAUQABu5vKnq7r6fBSY6Rj173NLo7YU
 0ZvyXY2CT9XI/96rdcAKF/6AY0XjGYpHo0H4onu2xVmicPQDURfVCG15nstmaFva50TBen
 Uwrgkd9Wgu4pHmEMRKoBJVaHMUQqd8EBCk82eNYCN9HIqq01mhcOH5bUgv/wHe8oHw7rR/
 pcXTEZG6YdzsmvQhmaCut1MMxBk49RtubUFhm9buuZglt70uNhPlEH9G9oY9g9NX4VNBaZ
 XX3yhLFTPmC86ljCeTbawfeNi18ydYLK5zx2TJ0IzJEklBu7YLczPhEAABuauQ==
Date: Thu, 19 Dec 2024 08:19:31 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Mihai Sain <mihai.sain@microchip.com>,
 Li Bin <bin.li@microchip.com>, u-boot@lists.denx.de,
 Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH v3 3/3] mtd: nand: raw: atmel: Fix pulse read timing for
 certain NAND flashes
Message-ID: <20241219-grunge-prevalent-8b8a6e43f783@thorsis.com>
Mail-Followup-To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Mihai Sain <mihai.sain@microchip.com>,
 Li Bin <bin.li@microchip.com>, u-boot@lists.denx.de,
 Nicolas Ferre <nicolas.ferre@microchip.com>
References: <20240415074547.779264-1-ada@thorsis.com>
 <20240415075755.780653-1-ada@thorsis.com>
 <20240528-among-detective-e8ad4c9b5457@thorsis.com>
 <20240930-pamperer-prance-8b4566ba43a6@thorsis.com>
 <010201926bef0b2e-c1230e3e-a51a-4953-9c41-c2b116ac28ed-000000@eu-west-1.amazonses.com>
 <CAOf5uwnNSn-XGP9e54_Q4Kr1dpTkuYqFUyjgdgiPA57TOxjAvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOf5uwnNSn-XGP9e54_Q4Kr1dpTkuYqFUyjgdgiPA57TOxjAvQ@mail.gmail.com>
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

Am Tue, Oct 08, 2024 at 02:12:38PM +0200 schrieb Michael Nazzareno Trimarchi:
> Hi
> 
> On Tue, Oct 8, 2024 at 1:41 PM Eugen Hristev
> <eugen.hristev@collabora.com> wrote:
> >
> > On 9/30/24 11:07, Alexander Dahl wrote:
> > > Hello,
> > >
> > > Am Tue, May 28, 2024 at 12:32:44PM +0200 schrieb Alexander Dahl:
> > >> Hei hei,
> > >>
> > >> Am Mon, Apr 15, 2024 at 09:57:55AM +0200 schrieb Alexander Dahl:
> > >>> From reading the S34ML02G1 and the SAM9X60 datasheets again, it seems
> > >>> like we have to wait tREA after rising RE# before sampling the data.
> > >>> Thus pulse time must be at least tREA.
> > >>>
> > >>> Without this fix we got PMECC errors when reading, after switching to
> > >>> ONFI timing mode 3 on SAM9X60 SoC with S34ML02G1 raw NAND flash chip.
> > >>>
> > >>> The approach to set timings used before worked on sam9g20 and sama5d2
> > >>> with the same flash (S34ML02G1), probably because those have a slower
> > >>> mck clock rate and thus the resolution of the timings setup is not as
> > >>> tight as with sam9x60.
> > >>>
> > >>> The approach to fix the issue was carried over from at91bootstrap, and
> > >>> has been successfully tested in at91bootstrap, U-Boot and Linux.
> > >>>
> > >>> Link: https://github.com/linux4sam/at91bootstrap/issues/174
> > >>> Cc: Li Bin <bin.li@microchip.com>
> > >>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> > >>> ---
> > >>>
> > >>> Notes:
> > >>>     v3:
> > >>>     - initial patch version (not present in v1 and v2)
> > >>
> > >> This patch was send as part of a series, which you wanted to have some
> > >> more time to test.  Besides that, has anyone looked into this
> > >> particular fix?  Maybe it can be applied separately?
> > >
> > > I'd kindly ask what the status of this patch series is from U-Boot
> > > NAND subsystem maintainers POV?  Could you test it?  Should I rebase
> > > and resend?
> > >
> > > Two of these three patches are specific to at91 family, what's the
> > > opinion of at91 maintainers on this?
> >
> > Hello Alexander,
> >
> > From at91 perspective I have no objections.
> > As these are very NAND specific, I defer the patches to the NAND maintainers.
> >
> > Eugen
> >
> > >
> > > Link to the series discussion for reference:
> > >
> > > https://lore.kernel.org/u-boot/20240415074547.779264-1-ada@thorsis.com/T/#u
> > >
> > > Greets
> > > Alex
> > >
> 
> I will review this series

This might have fallen through the cracks?  The series was initially
based on v2024.04, now we are on v2025.01-rc4 already.  Still applies
cleanly to master, though.  I'm especially interested in the timing
fix of patch 3.  Could you please have a look?

Greets
Alex

> 
> Michael
> 
> > >>
> > >> Greets
> > >> Alex
> > >>
> > >>>
> > >>>  drivers/mtd/nand/raw/atmel/nand-controller.c | 13 +++++++++----
> > >>>  1 file changed, 9 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > >>> index bbafc88e44c..00ffeadd113 100644
> > >>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> > >>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > >>> @@ -1133,7 +1133,7 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
> > >>>                                       const struct nand_data_interface *conf,
> > >>>                                       struct atmel_smc_cs_conf *smcconf)
> > >>>  {
> > >>> -   u32 ncycles, totalcycles, timeps, mckperiodps;
> > >>> +   u32 ncycles, totalcycles, timeps, mckperiodps, pulse;
> > >>>     struct atmel_nand_controller *nc;
> > >>>     int ret;
> > >>>
> > >>> @@ -1259,11 +1259,16 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
> > >>>                      ATMEL_SMC_MODE_TDFMODE_OPTIMIZED;
> > >>>
> > >>>     /*
> > >>> -    * Read pulse timing directly matches tRP:
> > >>> +    * Read pulse timing would directly match tRP,
> > >>> +    * but some NAND flash chips (S34ML01G2 and W29N02KVxxAF)
> > >>> +    * do not work properly in timing mode 3.
> > >>> +    * The workaround is to extend the SMC NRD pulse to meet tREA
> > >>> +    * timing.
> > >>>      *
> > >>> -    * NRD_PULSE = tRP
> > >>> +    * NRD_PULSE = max(tRP, tREA)
> > >>>      */
> > >>> -   ncycles = DIV_ROUND_UP(conf->timings.sdr.tRP_min, mckperiodps);
> > >>> +   pulse = max(conf->timings.sdr.tRP_min, conf->timings.sdr.tREA_max);
> > >>> +   ncycles = DIV_ROUND_UP(pulse, mckperiodps);
> > >>>     totalcycles += ncycles;
> > >>>     ret = atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NRD_SHIFT,
> > >>>                                       ncycles);
> > >>> --
> > >>> 2.39.2
> > >>>
> > >>
> >
> 
> 
> -- 
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
> 
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com
