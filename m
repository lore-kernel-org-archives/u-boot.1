Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9312CD98CF
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 07:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD0B683FF5;
	Thu, 11 Jun 2026 09:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="cwSPsBDm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C29A83FF5; Thu, 11 Jun 2026 09:37:45 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0992680086
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 09:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 689713ae656811f1b1788b6acf885367-20260611
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=tBw1iAqT4zck8a49zhGOydw0KOatU5sJ/YxzYZKD1Hc=; 
 b=cwSPsBDmZlnjLuTPKxXJHEI0ZbNjOWjxro39xYOzKMEw4jt2fBi8nxbmlG1kbw45q9Vn/HvNLIQXiU64iUWQobwG6cyRJtVZ8725nY4/hNbNHMave7tjlN0SILG1ONkOj/1DJxiyArWR7g6dUX+n2+y3rSoc5PkU2InQHl7O1Fw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15, REQID:bf2903ba-ad67-4805-994d-8bcbfff675c2, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e276073, CLOUDID:b2b0a630-7784-4a77-a538-47ed6151d81b,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|136|836|865|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|80|1,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
 :0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 689713ae656811f1b1788b6acf885367-20260611
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1015575141; Thu, 11 Jun 2026 15:37:33 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Jun 2026 15:37:32 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 11 Jun 2026 15:37:30 +0800
Message-ID: <e9693e05a70e5a7814a788fe73b8a7dfb167e155.camel@mediatek.com>
Subject: Re: [PATCH v4 7/7] mtd: spi-nor-ids: Add support for Winbond
 W25Q256JV-M/W25Q512JV-M
From: Weijie Gao <weijie.gao@mediatek.com>
To: <Takahiro.Kuwano@infineon.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Date: Thu, 11 Jun 2026 15:37:30 +0800
In-Reply-To: <d65a58e9c28f421397933994341e52b8@infineon.com>
References: <cover.1779678003.git.weijie.gao@mediatek.com>
 <8d3e9a4b2106b82d9aa15c2abf8b93b3638c11b4.1779678003.git.weijie.gao@mediatek.com>
 <d65a58e9c28f421397933994341e52b8@infineon.com>
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

On Thu, 2026-06-11 at 03:01 +0000, Takahiro.Kuwano@infineon.com wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> Hi,
> 
> > 
> > W25Q256JV-M/W25Q512JV-M are 256Mb/512Mb flash devices with Quad
> > interface at
> > max 104MHz clock rate. DTR is not supported.
> > These flashes supports 2.7-3.6V voltage range.
> > 
> > Both tested on MediaTek's filogic platform.
> > 
> > Link: 
> > https://urldefense.com/v3/__https://www.winbond.com/resource-files/W25Q256JV*20DTR*20RevK*2010202025*20Plus.pdf__;JSUlJQ!!CTRNKA9wMg0ARbw!igFctdFJEjSnYCT52waw-qrNxt1fsqf-t3PAZM90vZDff7jGE2ulb3s6ORLw7r3l779LqaDgTJnj6zv73BVVRnwP4U6h3Bk$
> > Link: 
> > https://urldefense.com/v3/__https://www.winbond.com/resource-files/W25Q512JV*20DTR*20RevD*2006292020*20133.pdf__;JSUlJQ!!CTRNKA9wMg0ARbw!igFctdFJEjSnYCT52waw-qrNxt1fsqf-t3PAZM90vZDff7jGE2ulb3s6ORLw7r3l779LqaDgTJnj6zv73BVVRnwPZFlwJQ8$
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > ---
> > v3-v4: updated commit message
> > v2: refactored with previous patch. updated commit message
> > ---
> >  drivers/mtd/spi/spi-nor-ids.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-
> > nor-ids.c
> > index 3c183650229..dcb217f2401 100644
> > --- a/drivers/mtd/spi/spi-nor-ids.c
> > +++ b/drivers/mtd/spi/spi-nor-ids.c
> > @@ -585,6 +585,10 @@ const struct flash_info spi_nor_ids[] = {
> >                SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> > SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> >         { INFO("w25q128jv-m", 0xef7018, 0, 64 * 1024, 256,
> >                SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> > SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> > +       { INFO("w25q256jv-m", 0xef7019, 0, 64 * 1024, 512,
> > +              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> > SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> > +       { INFO("w25q512jv-m", 0xef7020, 0, 64 * 1024, 1024,
> > +              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> > SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> 
> Same as EON chip case in another patch.
> Looks like this issue existed in the first place. We need to rework
> lock
> feature to support other vendors' chips.

As the locking feature is not used by our platform, I think it's better
to remove these flags for now.

> 
> >         { INFO("w25q01jv-m", 0xef7021, 0, 64 * 1024, 2048,
> >                SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> > SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> >         { INFO("w25q02jv-m", 0xef7022, 0, 64 * 1024, 4096,
> > --
> > 2.45.2
> 
> Thanks,
> Takahiro
> 

