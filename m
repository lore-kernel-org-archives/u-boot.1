Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE314C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26AF387197;
	Wed,  8 Nov 2023 16:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="V7XkyjPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E956087208; Wed,  8 Nov 2023 16:38:51 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B383D870F5
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 16:38:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A8Fck5J034787;
 Wed, 8 Nov 2023 09:38:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699457926;
 bh=lFnlinxOSNTPGDVGygVeTOzsd510lBXLzE/1BRs5ABk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=V7XkyjPme9YzTMHWpik1pT7aRxtg4D0gOmJWotgtIE0RbaOmsWsddJc2zYtcv5zf1
 +aqlFulG4TxNZYnGggE5762fd7KoF904a1Gp7jepDhO+47mOS67OWtmQ9MZZEI6F9+
 4a9gPX5xZu6qHrbDAtLYNVsQyzUpnTZ4OIcRJs4g=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A8Fckwa004506
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 8 Nov 2023 09:38:46 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 Nov 2023 09:38:45 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 Nov 2023 09:38:46 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A8Fcjo8006102;
 Wed, 8 Nov 2023 09:38:45 -0600
Date: Wed, 8 Nov 2023 09:38:45 -0600
From: Bryan Brattlof <bb@ti.com>
To: Vignesh Raghavendra <vigneshr@ti.com>
CC: Tom Rini <trini@konsulko.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,
 Andrew Davis <afd@ti.com>, UBoot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] board: ti: common: add rtc setup to common folder
Message-ID: <20231108153845.avd7c33635lnsi5x@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231107232139.2839534-5-bb@ti.com>
 <20231107232139.2839534-6-bb@ti.com>
 <b138a10f-03a5-4393-bcfd-5f0acebff1a9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <b138a10f-03a5-4393-bcfd-5f0acebff1a9@ti.com>
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

On November  8, 2023 thus sayeth Vignesh Raghavendra:
> On 08/11/23 04:51, Bryan Brattlof wrote:
> > All of the starter kit boards for the am62xxx extended family utilize
> > the same 32k crystal oscillator for a more accurate clock for the RTC
> > instance. Add the setup the clock mux and debounce configuration to the
> > common board directory so the entire am62xxx extended family can utilize
> > it.
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---

...

> > +	/* Setup debounce conf registers - arbitrary values.
> > +	 * Times are approx
> > +	 */
> > +	/* 1.9ms debounce @ 32k */
> > +	writel(WKUP_CTRLMMR_DBOUNCE_CFG1, 0x1);
> > +	/* 5ms debounce @ 32k */
> > +	writel(WKUP_CTRLMMR_DBOUNCE_CFG2, 0x5);
> > +	/* 20ms debounce @ 32k */
> > +	writel(WKUP_CTRLMMR_DBOUNCE_CFG3, 0x14);
> > +	/* 46ms debounce @ 32k */
> > +	writel(WKUP_CTRLMMR_DBOUNCE_CFG4, 0x18);
> > +	/* 100ms debounce @ 32k */
> > +	writel(WKUP_CTRLMMR_DBOUNCE_CFG5, 0x1c);
> > +	/* 156ms debounce @ 32k */
> > +	writel(WKUP_CTRLMMR_DBOUNCE_CFG6, 0x1f);
> > +}
> 
> 
> Pad Debounce settings has nothing to do with RTC. This doesn't belong to
> board_rtc_init()
> 

Oops.. I have no idea what I was thinking yesterday. This was a really 
half-baked plan all the way through :) 

I'll get this properly sorted out for v2

Thanks for reviewing though
~Bryan
