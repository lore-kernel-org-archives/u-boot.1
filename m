Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74CDC44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 03:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1970384AB8;
	Wed, 15 Jul 2026 05:11:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="AAWY+PuQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F79184ABB; Wed, 15 Jul 2026 05:11:44 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FF8484AA4
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 05:11:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: e398a70a7ffa11f1b1788b6acf885367-20260715
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=6QZvStQN7G2rk9jzerxRk5HfQ9Z1xVR5vYiVdwzFeDU=; 
 b=AAWY+PuQXpLP5pMiS9Wn99DOKt/1mWRtvLG8LQBWczOrOlzWXkycnzF95rXkY9XwvdD7tfCcJkZMbi9LkQgd3abEnjNKebF3SaZHis0PlMfh9TKdgJNm/EhvnYjFXqGX6qLGNMqX5ZDcTcCif4WyJm0wIPeH3Ex4CYqcJGXWJJ8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17, REQID:c877c562-37ac-4d28-8a71-412df552adeb, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:d497b38, CLOUDID:6173c2eb-3490-40c8-8a6a-6678a1dd151a,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|136|836|865|888|898,TC:-5,Cont
 ent:0|15|50|99,EDM:-3|-100,IP:nil,URL:99|80|1,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e398a70a7ffa11f1b1788b6acf885367-20260715
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 521799959; Wed, 15 Jul 2026 11:11:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 15 Jul 2026 11:11:34 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 15 Jul 2026 11:11:33 +0800
Message-ID: <55d9b1b63eb2418d4140b04b4bdb3dc3d4b7cabd.camel@mediatek.com>
Subject: Re: [PATCH v6 4/7] mtd: spi-nor-ids: Add 4K page support for
 Macronix MX25L25635E
From: Weijie Gao <weijie.gao@mediatek.com>
To: <Takahiro.Kuwano@infineon.com>, <u-boot@lists.denx.de>
CC: <GSS_MTK_Uboot_upstream@mediatek.com>, <trini@konsulko.com>,
 <vigneshr@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>, <jeyu@issi.com>, <christoph.reiter@evk.biz>,
 <miquel.raynal@bootlin.com>, <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>, <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Date: Wed, 15 Jul 2026 11:11:33 +0800
In-Reply-To: <d29fbb24a43b4593b7916bc50037d306@infineon.com>
References: <cover.1781508530.git.weijie.gao@mediatek.com>
 <ab4739209544e1f55f623d17db1183547adce79b.1781508530.git.weijie.gao@mediatek.com>
 <d29fbb24a43b4593b7916bc50037d306@infineon.com>
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

On Fri, 2026-07-03 at 08:51 +0000, Takahiro.Kuwano@infineon.com wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> Hi,
> 
> In Subject,
> s/4K page/4K sector/
> 
> > MX25L25635E supports 4KB/32KB/64KB uniform erase sector/blocks.
> > 
> > Link: 
> > https://urldefense.com/v3/__https://www.mxic.com.tw/Lists/Datasheet/Attachments/8592/MX25L25635E,*203V,*20256Mb,*20v1.3.pdf__;JSUl!!CTRNKA9wMg0ARbw!kHm23EUX4Wa5BvxT5qIdEZbaVKzcKHdyZz5oaiqiHGnOx_YmCyyAihdv5ilWogF6nMCWOCQ_VvleRcqT6q17vwZaO_hRSb4$
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > ---
> > v5-v6: not changed
> > v3-v4: updated commit message
> > v2: not changed
> > ---
> >  drivers/mtd/spi/spi-nor-ids.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-
> > nor-ids.c
> > index 4d07221ae65..018a8341553 100644
> > --- a/drivers/mtd/spi/spi-nor-ids.c
> > +++ b/drivers/mtd/spi/spi-nor-ids.c
> > @@ -323,7 +323,7 @@ const struct flash_info spi_nor_ids[] = {
> >         { INFO("mx25u51245g", 0xc2253a, 0, 64 * 1024, 1024, SECT_4K
> > |
> >                SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> > SPI_NOR_4B_OPCODES) },
> >         { INFO("mx25l12855e", 0xc22618, 0, 64 * 1024, 256, 0) },
> > -       { INFO("mx25l25635e", 0xc22019, 0, 64 * 1024, 512,
> > SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > +       { INFO("mx25l25635e", 0xc22019, 0, 64 * 1024, 512, SECT_4K
> > | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> 
> Like as some chips in this series, this chip doesn't support PP_1_1_4
> (32h).
> Maybe using SFDP can correct the chip capability.
> If you tested this chip, it would be good to describe test
> conditions, such
> as SFDP used (or not), read/program protocols, and so forth.
> 
> This is a pre-existing issue in core that adds PP_1_1_4 capability
> along with
> READ_1_1_4.

My test platform supports only 1-1-1 page program. So I can't and
didn't test the 1-1-4/1-4-4 page program.

I can remove the SPI_NOR_QUAD_READ flag if necessary.

> 
> >         { INFO("mx25u25635f", 0xc22539, 0, 64 * 1024, 512, SECT_4K
> > | SPI_NOR_4B_OPCODES) },
> >         { INFO("mx25v8035f",  0xc22314, 0, 64 * 1024,  16, SECT_4K
> > | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> >         { INFO("mx25r1635f",  0xc22815, 0, 64 * 1024,  32, SECT_4K
> > | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > --
> > 2.45.2
> 
> Thanks,
> Takahiro
> 

