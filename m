Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8761ECA0FF2
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 07:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFBEC8320C;
	Thu, 28 Aug 2025 09:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="PBvN0Em7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 173BC83252; Thu, 28 Aug 2025 09:22:26 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56AB2831D5
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 09:22:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: b9f14f4683df11f0bd5779446731db89-20250828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=c1reNj0ZJvFDwYDZy2yNMFN0EjgsVHrttGml5xyRevQ=; 
 b=PBvN0Em76djHqP5HnHx7EPno7jMfJ+l6KA1IEg9L7tUMMr7Bb/2SQw150ZmLqUHGnwRptjqQNNElgJTHrrtrPIpFaUKhZ6iAG6iHuQ7dAc0gXfodLKZFRZvkcSUwB/i+sismQ5ny83bP/tJpGe/3QvyPRwVkbfkdcSFh/kLXkmY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:6c8ecfe3-d61c-42a9-9ccb-c7d2c7bb4c2e, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:f1326cf, CLOUDID:c70cb36d-c2f4-47a6-876f-59a53e9ecc6e,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:-5,Content:0|15|5
 0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
 OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b9f14f4683df11f0bd5779446731db89-20250828
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1104563866; Thu, 28 Aug 2025 15:22:16 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 28 Aug 2025 15:22:15 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 28 Aug 2025 15:22:14 +0800
Message-ID: <e13e0dabf7b4adee9b987557c2c54803dcc6075e.camel@mediatek.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mediatek: add doc for MediaTek
 MT7987/MT7988 2.5Gb ethernrt PHY
From: Weijie Gao <weijie.gao@mediatek.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Sky Huang
 <SkyLake.Huang@mediatek.com>
Date: Thu, 28 Aug 2025 15:22:14 +0800
In-Reply-To: <20250827182822.GJ124814@bill-the-cat>
References: <cover.1756283872.git.weijie.gao@mediatek.com>
 <8c0d6997255a2bbc2e761ed457c51de653cc96c5.1756283872.git.weijie.gao@mediatek.com>
 <20250827182822.GJ124814@bill-the-cat>
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

On Wed, 2025-08-27 at 12:28 -0600, Tom Rini wrote:
> On Wed, Aug 27, 2025 at 04:55:54PM +0800, Weijie Gao wrote:
> > The MediaTek MT7987 and MT7988 platforms supports one built-in
> > 2.5Gb
> > ethernet PHY through eth1 interface.
> > 
> > This patch add documentation for configuring these PHYs.
> > 
> > Signed-off-by: Sky Huang <SkyLake.Huang@mediatek.com>
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > ---
> > Changes in v2:
> > 1. rename "pd-disable" property to "half-en"
> > 2. rename "gbe-min-ipg-11-bytes" property to "gbe-min-ipg-11-bytes-
> > en"
> > 3. rename "auto-downshift-disable" property to "auto-downshift-dis"
> > 4. add note for "retrain-dis" property
> > ---
> >  .../net/phy/mediatek,mt798x-i2p5ge-phy.txt    | 68
> > +++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >  create mode 100644 doc/device-tree-
> > bindings/net/phy/mediatek,mt798x-i2p5ge-phy.txt
> 
> What is the status of this binding in Linux? Thanks.
> 

The driver in linux kernel is just a basic version supporting only
mt7988, and of course none of these bindings are supported. The u-boot
driver is actually the complete version. We also plan to update the
linux driver later.

