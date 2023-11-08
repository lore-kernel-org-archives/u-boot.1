Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBA5C4167D
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:46:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62D68871DF;
	Wed,  8 Nov 2023 16:46:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AcAMbZNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94286871CC; Wed,  8 Nov 2023 16:46:39 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B29D86F93
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 16:46:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A8FkYrE100497;
 Wed, 8 Nov 2023 09:46:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699458394;
 bh=TIXCRei6JR9YA2JCsX5aErDn4ItBsyE+gxNkNXRbhAk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=AcAMbZNWDmYcNREGha12afSnr0xJ3fYdidcSykkA5IVZnWV7T0fC2cjWu10W1cfQk
 UvUHPZjaLrP/r4MYXVTBEIHvAw+6XBEbMl9duIuvvvhuShgcLqeT6+/LGChBbtvoVy
 T93oPrgOfbkIPC5Y3fPQcnTSN+QjyVEjyJ9H/X+8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A8FkYQO025471
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 8 Nov 2023 09:46:34 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 Nov 2023 09:46:34 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 Nov 2023 09:46:34 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A8FkYrQ038530;
 Wed, 8 Nov 2023 09:46:34 -0600
Date: Wed, 8 Nov 2023 09:46:34 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,
 Andrew Davis <afd@ti.com>, UBoot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] board: ti: common: add rtc setup to common folder
Message-ID: <20231108154634.jozi4cw5fm7v2lls@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231107232139.2839534-5-bb@ti.com>
 <20231107232139.2839534-6-bb@ti.com>
 <20231107233052.GX6601@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20231107233052.GX6601@bill-the-cat>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On November  7, 2023 thus sayeth Tom Rini:
> On Tue, Nov 07, 2023 at 05:21:41PM -0600, Bryan Brattlof wrote:
> 
> > All of the starter kit boards for the am62xxx extended family utilize
> > the same 32k crystal oscillator for a more accurate clock for the RTC
> > instance. Add the setup the clock mux and debounce configuration to the
> > common board directory so the entire am62xxx extended family can utilize
> > it.
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> [snip]
> > diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
> > index 49edd98014ab7..56a65c0a402bb 100644
> > --- a/board/ti/common/Kconfig
> > +++ b/board/ti/common/Kconfig
> > @@ -1,3 +1,11 @@
> > +config BOARD_HAS_32K_RTC_CRYSTAL
> > +	bool "Enable the 32k crystial for RTC"
> > +	help
> > +	   Some of Texas Instrument's Starter-Kit boards have
> > +	   an onboard 32k crystal. Select this option if you wish Uboot
> > +	   to enable this crystal for Linux
> > +	default n
> 
> No "default n" as that is the default. And we (a) need some depends on
> for what families this is found on and then (b) how, if at all, does
> this match up with the 32k crystal used on other TI reference platforms
> over the years? If this is specific to the K3 families of reference
> platforms, the help needs re-phrasing and the filename is too generic.
> It's also not a "RTC" in terms of something we can talk to via
> drivers/rtc/rtc-uclass.c and drivers/rtc/davinci.c, or in this case
> porting the kernel's drivers/rtc/rtc-ti-k3.c over, yes?
> 
> Oh, and "U-Boot" not "Uboot". Should see if the checkpatch typo list
> can be easily expanded by us, one of these days.

Yeah I'll work on the wording.

We just need to toggle a few bits for Linux to get the crystal muxed 
properly for the RTC driver in Linux.

We also toggle a few bits for the debouce settings that apparently I 
didn't separate out from this series.

Thanks for the quick review though.
~Bryan

