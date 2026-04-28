Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B60FFF886F
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC02A83FB5;
	Tue, 28 Apr 2026 09:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="pqS8wpHO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4472584255; Tue, 28 Apr 2026 09:26:45 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BD5983A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 962c730c42d311f19781c1a04af40193-20260428
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=AZ018JQxaxphSuz2r+kgN3ZVXalzPSdMexFIIzSwW/Q=; 
 b=pqS8wpHO0zpqTynemG4j6rZB/tyRSe/0xN8/bc9IIUciP7BAivuIgNSrZ4XBFpubwt2egHipOb3v/5PMU2+2zvf0ugBTV8ySeUUfEIjcEDiXqZ43VYbNDTSMf2In8An5wEmmvI88RmALdGancquGoxwPbZAQHB/bjW/R2wYGFYA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:d11a1450-6ade-46cc-975d-1d900d833291, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:be69ca44-8360-4d24-8500-9b9380fa4b0d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:99|80|1,File:130,RT:0,Bulk:nil,QS:nil,
 BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 962c730c42d311f19781c1a04af40193-20260428
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1730139994; Tue, 28 Apr 2026 15:26:35 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 28 Apr 2026 15:26:33 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 28 Apr 2026 15:26:32 +0800
Message-ID: <eff9b72a02eb3ae4e5953cf80f76c238027ce336.camel@mediatek.com>
Subject: Re: [PATCH 4/6] mtd: spi-nor-ids: Add 4K page support for Macronix
 MX25L25635E
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
Date: Tue, 28 Apr 2026 15:26:32 +0800
In-Reply-To: <87cxzjft1x.fsf@bootlin.com>
References: <cover.1777345877.git.weijie.gao@mediatek.com>
 <5fd1dfc2637fdc2f33b8ba68b46a35f8f320a6d1.1777345877.git.weijie.gao@mediatek.com>
 <87cxzjft1x.fsf@bootlin.com>
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

On Tue, 2026-04-28 at 09:22 +0200, Miquel Raynal wrote:
> Hi,
> 
> On 28/04/2026 at 11:32:03 +08, Weijie Gao <weijie.gao@mediatek.com>
> wrote:
> 
> > The datasheet can be found here:
> > 
https://urldefense.com/v3/__https://www.mxic.com.tw/Lists/Datasheet/Attachments/8592/MX25L25635E,*203V,*20256Mb,*20v1.3.pdf__;JSUl!!CTRNKA9wMg0ARbw!lYeaxwC-knJH61lKpIB1VNkNkvLBAAyzS5JwtDo-x9YDy7jngWucI28Yjx2wnzvEsuVLYPR4LkWiSKXNWrnIq93KhJw$
> >  
> 
> You can be a little more verbose here, about the why we need this?
> 
> > @@ -330,7 +330,7 @@ const struct flash_info spi_nor_ids[] = {
> >  	{ INFO("mx25u51245g", 0xc2253a, 0, 64 * 1024, 1024, SECT_4K |
> >  	       SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> > SPI_NOR_4B_OPCODES) },
> >  	{ INFO("mx25l12855e", 0xc22618, 0, 64 * 1024, 256, 0) },
> > -	{ INFO("mx25l25635e", 0xc22019, 0, 64 * 1024, 512,
> > SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +	{ INFO("mx25l25635e", 0xc22019, 0, 64 * 1024, 512, SECT_4K |
> > SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> 
> Is this something you really need to flag? Isn't it already provided
> by
> the SFDP tables?

I need to use this without enabling SFDP to save some space. So it's
still necessary to add this flag. I can add this description to the
commit message.

> 
> >  	{ INFO("mx25u25635f", 0xc22539, 0, 64 * 1024, 512, SECT_4K |
> > SPI_NOR_4B_OPCODES) },
> >  	{ INFO("mx25v8035f",  0xc22314, 0, 64 * 1024,  16, SECT_4K |
> > SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >  	{ INFO("mx25r1635f",  0xc22815, 0, 64 * 1024,  32, SECT_4K |
> > SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> 
> Thanks,
> Miquèl

