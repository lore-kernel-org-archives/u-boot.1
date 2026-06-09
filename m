Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5F8CD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 08:38:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EC618405A;
	Tue,  9 Jun 2026 10:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="QL/+fPvM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58CB68405A; Tue,  9 Jun 2026 10:38:16 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9227C8485F
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 10:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 8558801263de11f18dc8c9802ae25ab1-20260609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=WOan7ziZY1m69fInKfmrqK+wOe/RIPfNBNFFf3ndmlY=; 
 b=QL/+fPvMIIip4Fpqp+ZAmuggy/Da3qPDZi7nGwMX2AZApFY9Hwi76u0v8enXmlCtln8ed2uavUTAvuNqcsSTt+RZDnpbJmsxN0MwmlFP97+dZ185MHaN3NO/3BgWj2gOg9n52R9ElNZq+Mr7q54qZOPr3OKgSuNOtvpcASbNenI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15, REQID:0df80f8d-a49d-4ec8-8bb6-672a27287af4, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e276073, CLOUDID:41947b2a-13d2-4d29-83ea-b8014339a000,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|136|836|865|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|80|1,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC
 :0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8558801263de11f18dc8c9802ae25ab1-20260609
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1746728925; Tue, 09 Jun 2026 16:37:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 9 Jun 2026 16:37:58 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 9 Jun 2026 16:37:57 +0800
Message-ID: <bb057c88fa81f9bdcc151070c163eb43eb672e6d.camel@mediatek.com>
Subject: Re: [PATCH] mtd: spinand: add support for Etron SPI-NAND flashes
From: Weijie Gao <weijie.gao@mediatek.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: <u-boot@lists.denx.de>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini <trini@konsulko.com>, "Dario
 Binacchi" <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Tianling Shen <cnsztl@gmail.com>, "Cheng
 Ming Lin" <chengminglin@mxic.com.tw>, Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>
Date: Tue, 9 Jun 2026 16:37:57 +0800
In-Reply-To: <875x49l0lf.fsf@bootlin.com>
References: <20260429081313.151656-1-weijie.gao@mediatek.com>
 <875x49l0lf.fsf@bootlin.com>
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

On Wed, 2026-05-27 at 10:26 +0200, Miquel Raynal wrote:
> Hello Weijie,
> 
> Sorry for the delay, I have a couple of comments, see below.
> 
> On 29/04/2026 at 16:13:13 +08, Weijie Gao <weijie.gao@mediatek.com>
> wrote:
> 
> > This patch adds some Etron SPI-NAND flashes from 1Gb to 8Gb with
> > 4-bits/8-bits On-die ECC support.
> > 
> > EM73C044VCF/EM73D044VCO/EM73E044VCE/EM73F044VCA are tested on
> > MediaTek
> > filogic MT7988 reference board.
> > 
> > Datasheets:
> > 
https://urldefense.com/v3/__https://etron.com/wp-content/uploads/2024/08/EM73C044VCF-SPI-NAND-Flash_Rev-1.03.pdf__;!!CTRNKA9wMg0ARbw!gspAb_ATP-dOd61dvrUFgW4djua1MqYvOWrCMpr08fy1cd0aXgBHc0DpLK1QjsvUpnqO8M17049YgIPRAD7TX0rDOTY$
> >  
> > 
https://urldefense.com/v3/__https://etron.com/wp-content/uploads/2022/04/EM73D044VCOR-SPI-NAND-Flash_Rev-1.00.pdf__;!!CTRNKA9wMg0ARbw!gspAb_ATP-dOd61dvrUFgW4djua1MqYvOWrCMpr08fy1cd0aXgBHc0DpLK1QjsvUpnqO8M17049YgIPRAD7TDU5Zmz4$
> >  
> > 
https://urldefense.com/v3/__https://etron.com/wp-content/uploads/2022/04/EM78DE044VC-SPI-NAND-Flash_Rev-1.01.pdf__;!!CTRNKA9wMg0ARbw!gspAb_ATP-dOd61dvrUFgW4djua1MqYvOWrCMpr08fy1cd0aXgBHc0DpLK1QjsvUpnqO8M17049YgIPRAD7TC0zknDQ$
> >  
> > 
https://urldefense.com/v3/__https://etron.com/wp-content/uploads/2024/08/EM73E044VCEG-SPI-NAND-Flash_Rev-1.00.pdf__;!!CTRNKA9wMg0ARbw!gspAb_ATP-dOd61dvrUFgW4djua1MqYvOWrCMpr08fy1cd0aXgBHc0DpLK1QjsvUpnqO8M17049YgIPRAD7TN5lTwzg$
> >  
> > 
https://urldefense.com/v3/__https://etron.com/wp-content/uploads/2022/04/EM738F044VCA-SPI-NAND-Flash_Rev-1.02.pdf__;!!CTRNKA9wMg0ARbw!gspAb_ATP-dOd61dvrUFgW4djua1MqYvOWrCMpr08fy1cd0aXgBHc0DpLK1QjsvUpnqO8M17049YgIPRAD7T0csUZhs$
> >  
> 
> I haven't checked all the chips in detail, I checked just a couple of
> them.
> 
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > ---
> 
> [...]
> 
> > +#ifndef __UBOOT__
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#endif
> 
> Please drop this #if block
> 
> > +#include <linux/mtd/spinand.h>
> > +
> > +#define SPINAND_MFR_ETRON		0xD5
> > +
> > +#define STATUS_ECC_LIMIT_BITFLIPS	(3 << 4)
> 
> Please add a prefix aligned with Etron's namespace.

I'll use STATUS_ECC_MASK instead, as what the linux kernel does.

> 
> > +static SPINAND_OP_VARIANTS(read_cache_variants,
> > +		SPINAND_PAGE_READ_FROM_CACHE_1S_4S_4S_OP(0, 1, NULL, 0,
> > 0),
> > +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_4S_OP(0, 1, NULL, 0,
> > 0),
> > +		SPINAND_PAGE_READ_FROM_CACHE_1S_2S_2S_OP(0, 1, NULL, 0,
> > 0),
> > +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_2S_OP(0, 1, NULL, 0,
> > 0),
> > +		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1,
> > NULL, 0, 0),
> > +		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0,
> > 0));
> > +
> > +static SPINAND_OP_VARIANTS(write_cache_variants,
> > +		SPINAND_PROG_LOAD_1S_1S_4S_OP(true, 0, NULL, 0),
> > +		SPINAND_PROG_LOAD_1S_1S_1S_OP(true, 0, NULL, 0));
> > +
> > +static SPINAND_OP_VARIANTS(update_cache_variants,
> > +		SPINAND_PROG_LOAD_1S_1S_4S_OP(false, 0, NULL, 0),
> > +		SPINAND_PROG_LOAD_1S_1S_1S_OP(false, 0, NULL, 0));
> > +
> > +static int etron_ecc4_ooblayout_ecc(struct mtd_info *mtd, int
> > section,
> > +				    struct mtd_oob_region *region)
> > +{
> > +	struct spinand_device *spinand = mtd_to_spinand(mtd);
> > +
> > +	if (section >= spinand->base.memorg.pagesize / mtd-
> > >ecc_step_size)
> > +		return -ERANGE;
> > +
> > +	region->offset = (8 * section) + 32;
> > +	region->length = 8;
> 
> This should be grouped into one big continuous area.

OK.

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static int etron_ecc4_ooblayout_free(struct mtd_info *mtd, int
> > section,
> > +				     struct mtd_oob_region *region)
> > +{
> > +	struct spinand_device *spinand = mtd_to_spinand(mtd);
> > +
> > +	if (section >= spinand->base.memorg.pagesize / mtd-
> > >ecc_step_size)
> > +		return -ERANGE;
> > +
> > +	if (section) {
> > +		region->offset = 8 * section;
> > +		region->length = 8;
> 
> Ditto.
> 
> And same below, in the other OOB layouts.
> 
> > +	} else {
> > +		/* section 0 has two bytes reserved for bad block mark
> > */
> > +		region->offset = 2;
> > +		region->length = 6;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct mtd_ooblayout_ops etron_ecc4_ooblayout = {
> > +	.ecc = etron_ecc4_ooblayout_ecc,
> > +	.rfree = etron_ecc4_ooblayout_free,
> > +};
> > +
> > +static int etron_ecc8_ooblayout_ecc(struct mtd_info *mtd, int
> > section,
> > +				    struct mtd_oob_region *region)
> > +{
> > +	struct spinand_device *spinand = mtd_to_spinand(mtd);
> > +
> > +	if (section >= spinand->base.memorg.pagesize / mtd-
> > >ecc_step_size)
> > +		return -ERANGE;
> > +
> > +	region->offset = (14 * section) + 72;
> > +	region->length = 14;
> > +
> > +	return 0;
> > +}
> > +
> > +static int etron_ecc8_ooblayout_free(struct mtd_info *mtd, int
> > section,
> > +				     struct mtd_oob_region *region)
> > +{
> > +	struct spinand_device *spinand = mtd_to_spinand(mtd);
> > +
> > +	if (section >= spinand->base.memorg.pagesize / mtd-
> > >ecc_step_size)
> > +		return -ERANGE;
> > +
> > +	if (section) {
> > +		region->offset = 18 * section;
> > +		region->length = 18;
> > +	} else {
> > +		/* section 0 has two bytes reserved for bad block mark
> > */
> > +		region->offset = 2;
> > +		region->length = 16;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct mtd_ooblayout_ops etron_ecc8_ooblayout = {
> > +	.ecc = etron_ecc8_ooblayout_ecc,
> > +	.rfree = etron_ecc8_ooblayout_free,
> 
>          ^
> 
> Should not even compile?

I didn't see and mistake here.
This file can be compiled without error.

> 
> > +};
> > +
> > +static int etron_ecc_get_status(struct spinand_device *spinand, u8
> > status)
> > +{
> > +	struct nand_device *nand = spinand_to_nand(spinand);
> > +
> > +	switch (status & STATUS_ECC_MASK) {
> > +	case STATUS_ECC_NO_BITFLIPS:
> > +		return 0;
> > +
> > +	case STATUS_ECC_UNCOR_ERROR:
> > +		return -EBADMSG;
> > +
> > +	case STATUS_ECC_HAS_BITFLIPS:
> > +		return nand->eccreq.strength >> 1;
> 
> This is incorrect, you should probably return strength - 1 if that is
> what the bit means. We already had a discussion about this in the
> past:
> 
https://lore.kernel.org/linux-mtd/20210908201624.237634-1-bert@biot.com/
>  
> 

OK. I'll follow the linux kernel.

> > +
> > +	case STATUS_ECC_LIMIT_BITFLIPS:
> > +		return nand->eccreq.strength;
> > +
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> 
> Thanks,
> Miquèl

