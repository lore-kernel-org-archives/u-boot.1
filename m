Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 124B1C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 15:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F103F87555;
	Mon, 27 Nov 2023 16:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="soHno37M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 432768753F; Mon, 27 Nov 2023 16:48:02 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E801875AB
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 16:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ARFlu3i101849;
 Mon, 27 Nov 2023 09:47:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701100076;
 bh=3MUkli9m6S1qWzbKrqL99EJ4PKxc+cBEqlhF+130kJw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=soHno37M7lCaObH1h5KjL4JSzuP0vy1H+5CtgUM2LSJ0ISdCk2MAR34m0fwOeFpa+
 37nuy5k6ipreG9JPgy2BVoYfl7auKpktKVKXnsoSVZsGapjcfLP18XPsnewPbCWYFx
 582bvM5oZZ7plA+HnAUD/Pw4p9A78Q4w1L8Ua7Tc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ARFluR7037406
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Nov 2023 09:47:56 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 09:47:56 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 09:47:55 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ARFltHq128835;
 Mon, 27 Nov 2023 09:47:55 -0600
Date: Mon, 27 Nov 2023 09:47:55 -0600
From: Nishanth Menon <nm@ti.com>
To: "Raghavendra, Vignesh" <vigneshr@ti.com>
CC: Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Apurva Nandan
 <a-nandan@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/3] arm: mach-k3: Remove non-cached memory map areas
Message-ID: <20231127154755.duf5xciqrp5mg23j@reopen>
References: <20231123172214.653268-1-afd@ti.com>
 <20231123172214.653268-3-afd@ti.com>
 <fdce61c7-6517-4965-94ba-90fc8dbd2bdd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fdce61c7-6517-4965-94ba-90fc8dbd2bdd@ti.com>
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

On 23:04-20231123, Vignesh Raghavendra wrote:
> 
> 
> On 11/23/2023 10:52 PM, Andrew Davis wrote:
> > @@ -219,16 +177,9 @@ struct mm_region am62_mem_map[] = {
> >  	}, {
> >  		.virt = 0x80000000UL,
> >  		.phys = 0x80000000UL,
> > -		.size = 0x1E780000UL,
> > -		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> > -			PTE_BLOCK_INNER_SHARE
> > -	}, {
> > -		.virt = 0xA0000000UL,
> > -		.phys = 0xA0000000UL,
> > -		.size = 0x60000000UL,
> > +		.size = 0x80000000UL,
> >  		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> >  			 PTE_BLOCK_INNER_SHARE
> > -
> >  	}, {
> >  		.virt = 0x880000000UL,
> >  		.phys = 0x880000000UL,
> 
> 
> This causes issues when TF-A region @0x9e780000 is firewalled off from
> non-secure world. A53 does speculative accesses to this region from EL1
> leading to FW exceptions being reported on TIFS log (although A53 itself
> doesn't seem to abort)

Hmm... Why not just manage the ones that use TFA in DDR seperately? I
suppose OPTEE will come in the way?

Looks like the no-map is not honored well.. as you were mentioning, a
zephyr style generating the map from dts might be much better, but then
we do support multiple dtbs as well..

OK - I guess we need to leave this cleanup for now.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
