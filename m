Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCEBCD4F54
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:33:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26BFA847EF;
	Mon, 25 May 2026 04:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="MJK4uRfo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 349C0847EF; Mon, 25 May 2026 04:33:32 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 762C6846D3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:33:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 17fd8cb857e211f18dc8c9802ae25ab1-20260525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=Utiv8QNTIuI43aEHcHOis/1f7X4EYvbbYKwA6CUNmGo=; 
 b=MJK4uRfoq4P2tc1Lc7f23mydc9CgPOc3bLFRpNa4MHJoUa68ZxhGhHTy5IRG1T+hLkUXiKOmeg8RiYleOKPh3ZRmw8ITBXc1x23yAFbCHNIXocpEppn4YKUV4x4ob3+BEQOp+vN/w/R0Ls4e0kbMQ3oYbDD8iHEYnZi3IZ9EiYA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15, REQID:71b3bbba-d5cd-439d-aa67-ad1e8fc8e785, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e276073, CLOUDID:80f66146-e650-4d81-a877-d298d8f44b5d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:99|80|1,File:130,RT:0,Bulk:nil,QS:nil,
 BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 17fd8cb857e211f18dc8c9802ae25ab1-20260525
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 641241333; Mon, 25 May 2026 10:33:20 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 25 May 2026 10:33:18 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 25 May 2026 10:33:18 +0800
Message-ID: <125fe28e5b21bfc041ad2e3b5f3f7057dcc81401.camel@mediatek.com>
Subject: Re: [PATCH v3 3/7] mtd: spi-nor-ids: Add support for GigaDevice
 GD25Q256
From: Weijie Gao <weijie.gao@mediatek.com>
To: <Takahiro.Kuwano@infineon.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Date: Mon, 25 May 2026 10:33:17 +0800
In-Reply-To: <db34ba7dcb6b442fbcc137b6d790964f@infineon.com>
References: <cover.1778655692.git.weijie.gao@mediatek.com>
 <906583fc7f1055d6c86c85802d04c2c92f3183b0.1778655692.git.weijie.gao@mediatek.com>
 <db34ba7dcb6b442fbcc137b6d790964f@infineon.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Fri, 2026-05-22 at 07:55 +0000, Takahiro.Kuwano@infineon.com wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> > GD25Q256 ia 256Mb flash device with Quad interface at max 80MHz
> > clock rate.
> 
> ia -> is
> 
> The datasheet says it's up-to 133MHz. If you tested at 80MHz, please
> mention
> that.
> 
> > This flash supports 2.7-3.6V voltage range.
> > 
> > Tested on MediaTek's filogic platform.
> > 
> > Link: 
> > https://urldefense.com/v3/__https://download.gigadevice.com/Datasheet/DS-00526-GD25Q256E-Rev1.3.pdf__;!!CTRNKA9wMg0ARbw!hEUSDGPOIwhKz5co5q62J5najY5WWOrcek_xV9OeEXby2PPbtBBWk4AwK4bms9x6tUKZNkKDkhOyzYQ6PfsifsLfjfXnqCQ$
> > 
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> 
> Please remove blank line between the tags.
> 
> > ---
> > v3: removed locking flags. updated commit message
> > v2: updated commit message
> > ---
> >  drivers/mtd/spi/spi-nor-ids.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-
> > nor-ids.c
> > index fcc546fb5ae..9271cefc759 100644
> > --- a/drivers/mtd/spi/spi-nor-ids.c
> > +++ b/drivers/mtd/spi/spi-nor-ids.c
> > @@ -147,6 +147,10 @@ const struct flash_info spi_nor_ids[] = {
> >                         SECT_4K | SPI_NOR_DUAL_READ |
> > SPI_NOR_QUAD_READ |
> >                         SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> >         },
> > +       {
> > +               INFO("gd25q256", 0xc84019, 0, 64 * 1024, 512,
> > +                       SECT_4K | SPI_NOR_DUAL_READ |
> > SPI_NOR_QUAD_READ)
> > +       },
> 
> Same ID but different name entry below (I overlooked this in previous
> review).
> Both 'Q' and 'B' are available in GigaDevice website. What's the
> difference?

Hmm. I found that a bunch of chips share the same ID:
GD25Q256C/GD25Q256D/GD25Q256E/GD25Q257D
GD25B256D/GD25B256E/GD25B257D/GD25R256D

They both supports 4K sector and dual/quad read.
Differences I found are max speed, RPMC and DTR.

I'll remove this patch.

> 
> >         /* adding these 3V QSPI flash parts */
> >         {INFO("gd25b256", 0xc84019, 0, 64 * 1024, 512,  SECT_4K |
> >         SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK |
> > SPI_NOR_4B_OPCODES)  },
> 
> Thanks,
> Takahiro
> 

