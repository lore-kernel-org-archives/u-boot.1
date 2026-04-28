Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E1EFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 08:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F7F184150;
	Tue, 28 Apr 2026 10:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="HNm+0tng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD062845CE; Tue, 28 Apr 2026 10:37:18 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FC8084119
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 6f3fdce842dd11f19a16598d5ca7f8ec-20260428
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=PI3KPTVhaa5o4Z9XrclLRGNfaxNo5ZO0RmE3KBnI/2c=; 
 b=HNm+0tnghgUCWJD6b3zuLi2F65ZJKpmXY3+49SV6SeIoe27NJzV6actBgn93ItLLCIN+XDnx7VXHTPkJyaZhV+Vhf8xxMjHQ9sUY8iORw4dtetEORRamsiUm6UxdyIqTj72IEtYu6cx301+h21sAcWrcJNR8Ds27vkDcbkezF18=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:5945e7d4-a54b-4c2e-bcdf-9e9b8a8733be, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:2647a270-3b7f-4b26-b2f9-40f0deecb36d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:99|80|1,File:130,RT:0,Bulk:nil,QS:nil,
 BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6f3fdce842dd11f19a16598d5ca7f8ec-20260428
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 761948465; Tue, 28 Apr 2026 16:37:04 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 28 Apr 2026 16:37:03 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 28 Apr 2026 16:37:02 +0800
Message-ID: <5be181eabf090169f9df89d86d34347a8b4bd276.camel@mediatek.com>
Subject: Re: [PATCH 6/6] mtd: spi-nor-ids: Add support for Winbond
 W25Q256JV/W25Q512JV
From: Weijie Gao <weijie.gao@mediatek.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <u-boot@lists.denx.de>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini <trini@konsulko.com>, Vignesh
 R <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>, Marek
 Vasut <marek.vasut+renesas@mailbox.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Jeffrey Yu <jeyu@issi.com>, Christoph Reiter
 <christoph.reiter@evk.biz>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Shiji Yang <yangshiji66@outlook.com>, Bernhard
 Messerklinger <bernhard.messerklinger@at.abb.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Date: Tue, 28 Apr 2026 16:37:02 +0800
In-Reply-To: <871pfzfs03.fsf@bootlin.com>
References: <cover.1777345877.git.weijie.gao@mediatek.com>
 <a953087c1d0ff8429d64aa014ddb5612d2799b50.1777345877.git.weijie.gao@mediatek.com>
 <871pfzfs03.fsf@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK: N
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

On Tue, 2026-04-28 at 09:45 +0200, Miquel Raynal wrote:
> On 28/04/2026 at 11:32:13 +08, Weijie Gao <weijie.gao@mediatek.com>
> wrote:
> 
> > Datasheets can be found here:
> > 
https://urldefense.com/v3/__https://www.winbond.com/resource-files/W25Q256JV*20DTR*20RevK*2010202025*20Plus.pdf__;JSUlJQ!!CTRNKA9wMg0ARbw!hPu0SggaVM2sVfZIIpmauqFfldb_a2CUsdY8EXtlYmCrlPsgfbAHiUVQjb7RsCxDyHKNzQ_IeQino7kbe_I8YtAtzN5pOGJalR6BUZ0$
> >  
> > 
https://urldefense.com/v3/__https://www.winbond.com/resource-files/W25Q512JV*20DTR*20RevD*2006292020*20133.pdf__;JSUlJQ!!CTRNKA9wMg0ARbw!hPu0SggaVM2sVfZIIpmauqFfldb_a2CUsdY8EXtlYmCrlPsgfbAHiUVQjb7RsCxDyHKNzQ_IeQino7kbe_I8YtAtzN5pOGJaaukqJvM$
> >  
> > 
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > ---
> >  drivers/mtd/spi/spi-nor-ids.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-
> > nor-ids.c
> > index 492411a90f5..dc62a0e034a 100644
> > --- a/drivers/mtd/spi/spi-nor-ids.c
> > +++ b/drivers/mtd/spi/spi-nor-ids.c
> > @@ -609,11 +609,21 @@ const struct flash_info spi_nor_ids[] = {
> >  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ
> > |
> >  			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> >  	},
> > +	{
> > +		INFO("w25q256jv", 0xef7019, 0, 64 * 1024, 512,
> > +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ
> > |
> > +			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> > +	},
> >  	{
> >  		INFO("w25q256jw", 0xef6019, 0, 64 * 1024, 512,
> >  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ
> > |
> >  			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> >  	},
> > +	{
> > +		INFO("w25q512jv", 0xef7020, 0, 64 * 1024, 1024,
> 
> This is JV-M (here and above).

Of course. I didn't test the -Q version but I already saw related parts
like w25q512jvq existed.

Perhaps naming these -M series with 'm' suffix is better.

> 
> These chips also happen to conflict with W25QxxRV-M chips. Is this
> support for these new chips that you are targeting?

I didn't use RV series now. w25q256jv/w25q512jv are tested on
MediaTek's filogic platform.

As winbond doesn't provide the actual contents of the SFDP table, I'm
not sure if there's a way to distinguish between these two families.

> 
> > +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ
> > |
> > +			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> > +	},
> >  	{
> >  		INFO("w25q512nwq", 0xef6020, 0, 64 * 1024, 1024,
> >  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ
> > |
> 
> I would rather group them by family (ef60xx then ef70xx).

It's OK.

> 
> Thanks,
> Miquèl

