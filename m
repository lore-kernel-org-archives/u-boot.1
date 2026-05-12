Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31EFCD4F26
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 08:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FA9380398;
	Tue, 12 May 2026 10:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="abUysLkH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DDF980F0E; Tue, 12 May 2026 10:42:19 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4D8F801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 10:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 760928164dde11f1b96f91537e34a508-20260512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=6jIptE1u1FCp4/twwY34MhySBzEHdGkYXYtdyKCdGRk=; 
 b=abUysLkHB8iyQBhW5Imy/7AunITBKgTuGn4c2J+xhYZFlFEi6sg9b5qL0yVlZZLxlEMemNoBoF9Q0hs0Zbtn9UPQ0k52nQjWX8f+uACUe0YTXPRtWdurufckx4+GHkumRc4yfXiKbRJYKwCu6Abqjv+Tih/ssjmVT9hTGi0ZMrg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.13, REQID:1516e0c6-bae0-4a37-8931-ea6f1475d79f, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b1afecd, CLOUDID:d1d37a45-8360-4d24-8500-9b9380fa4b0d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:99|80|1,File:130,RT:0,Bulk:nil,QS:nil,
 BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 760928164dde11f1b96f91537e34a508-20260512
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 782084437; Tue, 12 May 2026 16:42:08 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 12 May 2026 16:42:07 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 12 May 2026 16:42:06 +0800
Message-ID: <8a6b7ad4d3ede9c6b27e8aba57ee7c8ca06f6947.camel@mediatek.com>
Subject: Re: [PATCH v2 3/7] mtd: spi-nor-ids: Add support for GigaDevice
 GD25Q256
From: Weijie Gao <weijie.gao@mediatek.com>
To: <Takahiro.Kuwano@infineon.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Date: Tue, 12 May 2026 16:42:05 +0800
In-Reply-To: <cc029112ea4a4e829ec628022b632221@infineon.com>
References: <cover.1777368885.git.weijie.gao@mediatek.com>
 <6558b4e914d6de3353af2728016b17e3736d4a6d.1777368885.git.weijie.gao@mediatek.com>
 <cc029112ea4a4e829ec628022b632221@infineon.com>
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

On Tue, 2026-05-12 at 06:16 +0000, Takahiro.Kuwano@infineon.com wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> Hi,
> 
> > This flash is tested on MediaTek's filogic platform.
> > 
> > The datasheet can be found here:
> > 
https://urldefense.com/v3/__https://download.gigadevice.com/Datasheet/DS-00526-GD25Q256E-Rev1.3.pdf__;!!CTRNKA9wMg0ARbw!ndOq50YXbkGmB3qYwwC_omlvMBrrpmnEYWM7HgPAAAr8lFPMtkm7ZnS3buDbxXZZ_N35sCX5t3lWH9rSvvUY69OHWTYcwkw$
> 
> Please add a quick introduction/description about the device in
> commit
> message and use Link: tag for datasheet reference.
> 
> > 
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > ---
> > v2: updated commit message
> > ---
> >  drivers/mtd/spi/spi-nor-ids.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-
> > nor-ids.c
> > index fcc546fb5ae..8b74fbd4946 100644
> > --- a/drivers/mtd/spi/spi-nor-ids.c
> > +++ b/drivers/mtd/spi/spi-nor-ids.c
> > @@ -147,6 +147,11 @@ const struct flash_info spi_nor_ids[] = {
> >                         SECT_4K | SPI_NOR_DUAL_READ |
> > SPI_NOR_QUAD_READ |
> >                         SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> >         },
> > +       {
> > +               INFO("gd25q256", 0xc84019, 0, 64 * 1024, 512,
> > +                       SECT_4K | SPI_NOR_DUAL_READ |
> > SPI_NOR_QUAD_READ |
> > +                       SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
> 
> Did you test locking feature?
> Per datasheet, this device has 4-bit BPs and TB at SR BIT(6), while
> current
> u-boot supports 3-bit BPs and TB at SR BIT(5) only.

This is a copy-paste mistake. I'll remove these two flags.

> 
> > +       },
> >         /* adding these 3V QSPI flash parts */
> >         {INFO("gd25b256", 0xc84019, 0, 64 * 1024, 512,  SECT_4K |
> >         SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK |
> > SPI_NOR_4B_OPCODES)  },
> > --
> > 2.45.2
> 
> Thanks,
> Takahiro
> 

