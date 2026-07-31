Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A572C55162
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 03:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE24A40EBB;
	Fri, 31 Jul 2026 03:16:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3UDArRNSUOrW; Fri, 31 Jul 2026 03:16:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D807E40CB2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785467785;
	bh=Gb4jNeBnR7j2HyTCuSxDP4ZMjbY5AFpXhSYAEJ6NujY=;
	h=Subject:From:To:CC:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=096/SAzSfAMWM9uwCDYaYZKcXKh5qO/cHP/WBvQ4UsmaE9u7czDoYe4rG3jFpbWqk
	 iswScIWwkzFL5opBd6SluFuPJnABxkjM+Akb3/J7zOvY3Qo9kNecsYziKU0L8Fz+OK
	 sIe/vLFfeeC+tTEMWiUQDHKea08jBNr9yEu9S4Avll1AxmTB15npZKzy7+0T6G0tR9
	 aDhMmPYVaSMjUK9hoZfHSjRBMrOn4RUpwd1xRzeih2bHbQHCbiJ4eyZKT9snUCugfE
	 1AOo7bqRV9bZv5GtwwfResNDy72+S/TiyKLjQM/CcX6rGqdM78RnRWKI5J+Iyj3luT
	 EJ2Bqu52h3E+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D807E40CB2;
	Fri, 31 Jul 2026 03:16:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7242769
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:16:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 63DF180EB0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:16:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qcCE4IOk56Ap for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 03:16:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=weijie.gao@mediatek.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 576D480E70
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 576D480E70
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 576D480E70
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 03:16:22 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82C5784A0B; Fri, 31 Jul 2026 05:16:19 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5A78849BC
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 05:16:15 +0200 (CEST)
X-UUID: 2d4d06bc8c8e11f1b1788b6acf885367-20260731
X-CID-CACHE: Type:Local,Time:202607311116+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18, REQID:f8eb0cd6-4972-43a2-8623-340d2edd3741, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:8a735a6, CLOUDID:04fdf8e1-71f1-405e-92eb-6802d6af74fd,
 B
 ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|136|836|865|888|898,TC:-5,Cont
 ent:0|15|50|99,EDM:-3|-100,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,B
 EC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2d4d06bc8c8e11f1b1788b6acf885367-20260731
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 911013960; Fri, 31 Jul 2026 11:16:09 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 31 Jul 2026 11:16:08 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 31 Jul 2026 11:16:07 +0800
Message-ID: <cade4374b7eba539dfc6c4b94b9c94560ded655d.camel@mediatek.com>
Subject: Re: [PATCH v2] mtd: spinand: add support for Etron SPI-NAND flashes
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Tianling Shen <cnsztl@gmail.com>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, Cheng Ming Lin
 <chengminglin@mxic.com.tw>, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Date: Fri, 31 Jul 2026 11:16:07 +0800
In-Reply-To: <20260609084435.56297-1-weijie.gao@mediatek.com>
References: <20260609084435.56297-1-weijie.gao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; d=mediatek.com; s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=Gb4jNeBnR7j2HyTCuSxDP4ZMjbY5AFpXhSYAEJ6NujY=; 
 b=J1ymYWy4bnwqrBRWBnJ/rL9zPoreT6tf7w5RrglnYJzg1Wm+Lsb59ORy86NPw5nc9STXE3cokI/oK8Q8QhRV22i5+c6ko7k1g++l+oKuc+AuSei8bQU44oP2L+cFBOeKMemcY8A5Ysg5acYKb23T7YsfuU+Gg5x/a/h9qcVztEg=;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=mediatek.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com
 header.a=rsa-sha256 header.s=dk header.b=J1ymYWy4
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=weijie.gao@mediatek.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="J1ymYWy4";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi All,

This is just a gentle ping.
Any comments/review are appreciated.
Is this patch able to be merged?

On Tue, 2026-06-09 at 16:44 +0800, Weijie Gao wrote:
> This patch adds some Etron SPI-NAND flashes from 1Gb to 8Gb with
> 4-bits/8-bits On-die ECC support.
> 
> EM73C044VCF/EM73D044VCO/EM73E044VCE/EM73F044VCA are tested on
> MediaTek
> filogic MT7988 reference board.
> 
> Link: 
> https://etron.com/wp-content/uploads/2024/08/EM73C044VCF-SPI-NAND-Flash_Rev-1.03.pdf
> Link: 
> https://etron.com/wp-content/uploads/2022/04/EM73D044VCOR-SPI-NAND-Flash_Rev-1.00.pdf
> Link: 
> https://etron.com/wp-content/uploads/2022/04/EM78DE044VC-SPI-NAND-Flash_Rev-1.01.pdf
> Link: 
> https://etron.com/wp-content/uploads/2024/08/EM73E044VCEG-SPI-NAND-Flash_Rev-1.00.pdf
> Link: 
> https://etron.com/wp-content/uploads/2022/04/EM738F044VCA-SPI-NAND-Flash_Rev-1.02.pdf
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> ---
> Changes in v2:
> Group oob/ecc layouts
> Follow ecc handling from linux kernel
> ---
>  drivers/mtd/nand/spi/Makefile |   5 +-
>  drivers/mtd/nand/spi/core.c   |   1 +
>  drivers/mtd/nand/spi/etron.c  | 226
> ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h   |   1 +
>  4 files changed, 231 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/mtd/nand/spi/etron.c
> 

Best Regards,
Weijie

