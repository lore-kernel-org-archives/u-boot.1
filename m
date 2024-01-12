Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB21C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 12:40:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 085A2878B1;
	Fri, 12 Jan 2024 13:40:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tGsAIvov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E66098797B; Fri, 12 Jan 2024 13:40:07 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83F998785F
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CCe3vc049511;
 Fri, 12 Jan 2024 06:40:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705063203;
 bh=fUmYGQDLsUFQAS4X/7zmuEU76nTOwk9q0lwqGLJCvTc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=tGsAIvovV5rY9pGGXqLbqZwE9nN9EqqxZeG1CjG0gJhD/Ki4IleL6hIsusWk5i2sw
 VQOHTu8IGm04tWiuH7vs6oSouvKHNGR52L6Smo/l/LEaQNQT/vhZ05LWGC9Lh4/+In
 6dj0V0y6fdQlWICEQ5g9Wphf++QerQ9HSglC0p/U=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CCe2ds006263
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 06:40:03 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 06:40:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 06:40:01 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CCe1Up038115;
 Fri, 12 Jan 2024 06:40:01 -0600
Date: Fri, 12 Jan 2024 06:40:01 -0600
From: Nishanth Menon <nm@ti.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <afd@ti.com>, <vigneshr@ti.com>, 
 <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>
Subject: Re: [PATCH 01/10] board: ti: am62x: Init DRAM size in R5/A53 SPL
Message-ID: <20240112124001.axyvj2ixyufh5e5v@excavator>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112064759.1801600-2-s-vadapalli@ti.com>
 <20240112122623.gkrpcvcqbmrmwkho@margin>
 <4fdc86fb-69e6-4b79-acd8-e1b0bd8c9f4b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4fdc86fb-69e6-4b79-acd8-e1b0bd8c9f4b@ti.com>
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

On 18:01-20240112, Siddharth Vadapalli wrote:
> Hello Nishanth,
> 
> On 12/01/24 17:56, Nishanth Menon wrote:
> > On 12:17-20240112, Siddharth Vadapalli wrote:
> >> From: Kishon Vijay Abraham I <kishon@ti.com>
> >>
> >> Call dram_init_banksize() from spl_board_init() otherwise TFTP download
> >> fails with error "TFTP error: trying to overwrite reserved memory..."
> >> due to lmb_get_free_size() not able to find unreserved region due
> >> to lack of DRAM size info. Required to support Ethernet boot on AM62x.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> >> ---
> >>  board/ti/am62x/evm.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
> >> index ad93908840..35f291d83a 100644
> >> --- a/board/ti/am62x/evm.c
> >> +++ b/board/ti/am62x/evm.c
> >> @@ -85,6 +85,9 @@ void spl_board_init(void)
> >>  	if (IS_ENABLED(CONFIG_SPL_SPLASH_SCREEN) && IS_ENABLED(CONFIG_SPL_BMP))
> >>  		splash_display();
> >>  
> >> +	if (IS_ENABLED(CONFIG_SPL_ETH))
> >> +		/* Init DRAM size for R5/A53 SPL */
> >> +		dram_init_banksize();
> >>  }
> >>  
> >>  #if defined(CONFIG_K3_AM64_DDRSS)
> >> -- 
> >> 2.34.1
> >>
> > 
> > Are you sure? tftp seems to work without this patch.
> > 
> > https://gist.github.com/nmenon/91e3282e00e38ae42e8cf640be2ab888
> 
> I noticed the error pointed out in the commit message at the A53 SPL stage when
> the U-Boot Image is being fetched over TFTP without this patch, so I have
> verified that this patch is necessary. The logs you have shared verify TFTP at
> U-Boot, but this patch is for enabling TFTP at A53 SPL for fetching U-Boot image
> via TFTP.

Please fix the commit message.

I still dont get why we have to explicitly  have to call
dram_init_banksize is that because some sort of configuration option was
missed?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
