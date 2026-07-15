Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69057C4450A
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 03:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CDD384AAC;
	Wed, 15 Jul 2026 05:00:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="TO9yDK8W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00EFB84AAE; Wed, 15 Jul 2026 05:00:45 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EE6084AA4
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 05:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 5740dd5a7ff911f18dc8c9802ae25ab1-20260715
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=W+uYCj9LfKK94eIpILCOk/p0Lmy4ipUFLqgJFkzi18s=; 
 b=TO9yDK8WfdfDRUWp/EamK3FxJ+DuGcMP1IJwF/p4cXhdUC5qTix0AOS2haCH74TRS0Dsic/d3GVcEkb87+5V3g8J5WY9aCSmlrGuwaEaDTmsHfGDZHT+PhrxmVjCUU1YkdI2aZiTINCT+js7YOQXTdJzb204cnHO/MPPcMdTd6M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17, REQID:b89117e8-8750-41da-a6fd-c7313786f4d4, IP:0,
 U
 RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:25
X-CID-META: VersionHash:d497b38, CLOUDID:2255b537-7759-43a9-ae06-f4df9d53bea1,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|836|865|888|898,TC:-5,Content:
 0|15|50|99,EDM:-3,IP:nil,URL:99|11|83|106|80|1,File:130,RT:0,Bulk:nil,QS:n
 il,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:
 0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5740dd5a7ff911f18dc8c9802ae25ab1-20260715
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1290126932; Wed, 15 Jul 2026 11:00:31 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 15 Jul 2026 11:00:30 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 15 Jul 2026 11:00:29 +0800
Message-ID: <7be0c4e8dc3fe32bef1452de434a9812719d5dd3.camel@mediatek.com>
Subject: Re: [PATCH v6 1/7] mtd: spi-nor-ids: Correct flash flags for
 ESMT/EON flashes
From: Weijie Gao <weijie.gao@mediatek.com>
To: <Takahiro.Kuwano@infineon.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Date: Wed, 15 Jul 2026 11:00:28 +0800
In-Reply-To: <d8dfad96296b4654b206e08dc2156600@infineon.com>
References: <cover.1781508530.git.weijie.gao@mediatek.com>
 <3facbb0d047ffeab20aacee385ce137bb8894716.1781508530.git.weijie.gao@mediatek.com>
 <d8dfad96296b4654b206e08dc2156600@infineon.com>
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

On Fri, 2026-07-03 at 09:03 +0000, Takahiro.Kuwano@infineon.com wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> Hi,
> 
> > All currently supported ESMT/EON flashes supports 4KB sector and
> > dual read.
> > EN25Q80B also supports 1-1-4 quad read.
> > 
> > Link: 
> > https://urldefense.com/v3/__https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25Q80B.pdf__;!!CTRNKA9wMg0ARbw!j7E681Y4Vzt6S4aIsheiVdVOq9m8dv0YTHDU9h9Bd3fu83ASyITxt4cxou55heRBOS52p8pOfsmu5cjY5uK7MdQnA5YmOgE$
> > Link: 
> > https://urldefense.com/v3/__https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25QH128A*20(2TC).pdf__;JQ!!CTRNKA9wMg0ARbw!j7E681Y4Vzt6S4aIsheiVdVOq9m8dv0YTHDU9h9Bd3fu83ASyITxt4cxou55heRBOS52p8pOfsmu5cjY5uK7MdQn6Cw3FY0$
> > Link: 
> > https://urldefense.com/v3/__https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25S64A(2SC).pdf__;!!CTRNKA9wMg0ARbw!j7E681Y4Vzt6S4aIsheiVdVOq9m8dv0YTHDU9h9Bd3fu83ASyITxt4cxou55heRBOS52p8pOfsmu5cjY5uK7MdQnfRLy1jE$
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > ---
> > v6: removed SPI_NOR_QUAD_READ from incompatible flashes
> > v5: not changed
> > v3-v4: updated commit message
> > v2: not changed
> > ---
> >  drivers/mtd/spi/spi-nor-ids.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-
> > nor-ids.c
> > index c0fa98424aa..0dacb4abdbc 100644
> > --- a/drivers/mtd/spi/spi-nor-ids.c
> > +++ b/drivers/mtd/spi/spi-nor-ids.c
> > @@ -90,12 +90,12 @@ const struct flash_info spi_nor_ids[] = {
> >  #endif
> >  #ifdef CONFIG_SPI_FLASH_EON            /* EON */
> >         /* EON -- en25xxx */
> > -       { INFO("en25q80b",   0x1c3014, 0, 64 * 1024,   16, SECT_4K)
> > },
> > -       { INFO("en25q32b",   0x1c3016, 0, 64 * 1024,   64, 0) },
> > -       { INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K)
> > },
> > -       { INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, 0) },
> > -       { INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, 0) },
> > -       { INFO("en25s64",    0x1c3817, 0, 64 * 1024,  128, SECT_4K)
> > },
> > +       { INFO("en25q80b",   0x1c3014, 0, 64 * 1024,   16, SECT_4K
> > | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +       { INFO("en25q32b",   0x1c3016, 0, 64 * 1024,   64, SECT_4K
> > | SPI_NOR_DUAL_READ) },
> > +       { INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K
> > | SPI_NOR_DUAL_READ) },
> > +       { INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, SECT_4K
> > | SPI_NOR_DUAL_READ) },
> > +       { INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, SECT_4K
> > | SPI_NOR_DUAL_READ) },
> > +       { INFO("en25s64",    0x1c3817, 0, 64 * 1024,  128, SECT_4K
> > | SPI_NOR_DUAL_READ) },
> 
> In our discussion in previous revision [1], only en25qh128 supports
> 1-1-4
> read and program, but you set QUAD_READ flag in en25q80b instead.
> Please fix.

I reserved this flag because I found a newer datasheet that claims it
supports the 6B opcode for 1-1-4 read:

https://www.novitronic.com/Datenbl%C3%A4tter/Aktive%20Komponenten/EN25Q80B%282C%29.pdf

As the EN25Q80B is EOL, I can't buy one for testing. I'll remove this
flag in next patch series.

> 
> Thanks,
> Takahiro
> 
> [1]
> 
https://patchwork.ozlabs.org/project/uboot/patch/64ce1a920dc067717de2b39d2e7a5098e6853aab.1781164951.git.weijie.gao@mediatek.com/
> 

