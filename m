Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A216CD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 03:00:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53CB6846B0;
	Mon, 15 Jun 2026 05:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="f9Crw7EM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D6F84704; Mon, 15 Jun 2026 05:00:39 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F3B1846A4
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 05:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 5931cb74686611f1b1788b6acf885367-20260615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=Nj2VNlV9I+w0gcKbtBGAiu1Misf9wCURXENYm7vpf90=; 
 b=f9Crw7EM6Bc/XObg0PHoEwI7it4a1PvsZOiK76IrMQ01DW+5hvuLN3F0H+S6C2O2/9gcJP7lrKPK4rtv8LnMfb92HuuQ8LWx+7eA9p1D6SW6+p/6Qk/OPS+LQcVsxfbwtc4qgh6lCMbaYXqqHLaX42p7f9Ai4OzXvv78m1qfQZU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15, REQID:19dd32e3-c515-466f-97a7-51b631e23b12, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e276073, CLOUDID:7465201f-0e0a-4900-8de9-9762fc206090,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:99|80|1,File:130,RT:0,Bulk:nil,QS:nil,
 BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5931cb74686611f1b1788b6acf885367-20260615
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2102608442; Mon, 15 Jun 2026 11:00:21 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 15 Jun 2026 11:00:20 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 15 Jun 2026 11:00:19 +0800
Message-ID: <78cb06cf5c3e7c8442548bde350fd1b84503e249.camel@mediatek.com>
Subject: Re: [PATCH v5 1/7] mtd: spi-nor-ids: Correct flash flags for
 ESMT/EON flashes
From: Weijie Gao <weijie.gao@mediatek.com>
To: <Takahiro.Kuwano@infineon.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Date: Mon, 15 Jun 2026 11:00:19 +0800
In-Reply-To: <c2c8f27ffce4428cb3637eeaec973785@infineon.com>
References: <cover.1781164951.git.weijie.gao@mediatek.com>
 <64ce1a920dc067717de2b39d2e7a5098e6853aab.1781164951.git.weijie.gao@mediatek.com>
 <c2c8f27ffce4428cb3637eeaec973785@infineon.com>
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

On Fri, 2026-06-12 at 07:57 +0000, Takahiro.Kuwano@infineon.com wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> Hi,
> 
> > 
> > All currently supported ESMT/EON flashes supports 4KB sector and
> > dual/quad
> > read.
> > 
> > Link: 
> > https://urldefense.com/v3/__https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25Q80B.pdf__;!!CTRNKA9wMg0ARbw!loGGxfD6Cz6vPt1rShQD1VK39EnUqHA4wA-sj11XPNLZYHslG0iY9ti_X1WIobvc_XTx610jrDxeE7ApjOUpZuZlSKdjMqk$
> > Link: 
> > https://urldefense.com/v3/__https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25QH128A*20(2TC).pdf__;JQ!!CTRNKA9wMg0ARbw!loGGxfD6Cz6vPt1rShQD1VK39EnUqHA4wA-sj11XPNLZYHslG0iY9ti_X1WIobvc_XTx610jrDxeE7ApjOUpZuZlftRl0h8$
> > Link: 
> > https://urldefense.com/v3/__https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25S64A(2SC).pdf__;!!CTRNKA9wMg0ARbw!loGGxfD6Cz6vPt1rShQD1VK39EnUqHA4wA-sj11XPNLZYHslG0iY9ti_X1WIobvc_XTx610jrDxeE7ApjOUpZuZl8G8RB38$
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > ---
> > v5: not changed
> > v3-v4: updated commit message
> > v2: not changed
> > ---
> >  drivers/mtd/spi/spi-nor-ids.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-
> > nor-ids.c
> > index c0fa98424aa..7d96adab4fd 100644
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
> > | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +       { INFO("en25q64",    0x1c3017, 0, 64 * 1024,  128, SECT_4K
> > | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +       { INFO("en25q128b",  0x1c3018, 0, 64 * 1024,  256, SECT_4K
> > | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +       { INFO("en25qh128",  0x1c7018, 0, 64 * 1024,  256, SECT_4K
> > | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +       { INFO("en25s64",    0x1c3817, 0, 64 * 1024,  128, SECT_4K
> > | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> 
> If SPI_NOR_QUAD_READ is given, the driver assumes the chip supports
> Quad Output Read (1-1-4, 6Bh) and Quad Page Program (1-1-4, 32h).
> Except en25qh128, those chips don't support 1-1-4 read/program per
> datasheets.
> They do support Quad I/O Read (1-4-4, EBh). If you want to enable it,
> write fixup otherwise just drop the SPI_NOR_QUAD_READ flag, please.
> 

This is my mistake. I bought one en25qh128 to test and confirmed that.
I'll drop all incompatible quad read flags.

> Thanks,
> Takahiro
> 

