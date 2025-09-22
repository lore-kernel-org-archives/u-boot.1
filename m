Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60703CAC5A7
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 01:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FEFC8317B;
	Mon, 22 Sep 2025 03:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="eACAO3DV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EE0883211; Mon, 22 Sep 2025 03:25:33 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 094DA82B07
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 03:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 03896a68975311f08d9e1119e76e3a28-20250922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID;
 bh=kMbxTsj85UeZwa0C6XSRoH+vl6saY4Tj5c2j/7IzSTc=; 
 b=eACAO3DVazRy56Zhl5h0jMXYdtXcZaXhaVl7U9tKiMywuz9Ra/heihY2SCSA/KVBQfV5No04GyXI4EYEvUpPtC2Pdk3Em8hNXJtycdDYLYX+FsAXLgQFoCUgw2eSvCdWYN8/+ZscYD194qX17Grr89oFj1Mbtb194cyEcjp44ZM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4, REQID:20c24fae-4347-4f39-8256-be38783a17d5, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:1ca6b93, CLOUDID:700c0785-5317-4626-9d82-238d715c253f,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|888|898,TC:-5,Co
 ntent:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
 COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 03896a68975311f08d9e1119e76e3a28-20250922
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1893753989; Mon, 22 Sep 2025 09:25:24 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 22 Sep 2025 09:25:23 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Mon, 22 Sep 2025 09:25:22 +0800
Message-ID: <721b0ad8a171f224108db11767f92f862ccf9fe9.camel@mediatek.com>
Subject: Re: Aw: [PATCH] MT7988 add LED Blue/Green + WPS/Reset Button
From: Weijie Gao <weijie.gao@mediatek.com>
To: Frank Wunderlich <frank-w@public-files.de>, <devel@easynet.dev>,
 <u-boot@lists.denx.de>
Date: Mon, 22 Sep 2025 09:25:22 +0800
In-Reply-To: <trinity-9c95f31d-257e-4486-b833-df15865a5e55-1758445394693@trinity-msg-rest-gmx-gmx-live-646f7b8dfd-24vr4>
References: <20250920163536.1096800-1-devel@easynet.dev>
 <trinity-9c95f31d-257e-4486-b833-df15865a5e55-1758445394693@trinity-msg-rest-gmx-gmx-live-646f7b8dfd-24vr4>
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

On Sun, 2025-09-21 at 09:03 +0000, Frank Wunderlich wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> Hi
> 
> > Gesendet: Samstag, 20. September 2025 um 18:35
> > Von: EasyNetDev <devel@easynet.dev>
> > An: u-boot@lists.denx.de
> > CC: EasyNetDev <devel@easynet.dev>
> > Betreff: [PATCH] MT7988 add LED Blue/Green + WPS/Reset Button
> > 
> > MT7988 is missing LED Blue and Green from DTS.
> > EEPROM is hard wired to LED Green and you can't use it without
> > LED support.
> > WPS/Reset button is just for future customization of the U-Boot
> > booting.
> > 
> > Signed-off-by: EasyNetDev <devel@easynet.dev>
> 
> please use real name here :)
> 
> > ---
> >  arch/arm/dts/mt7988-rfb.dts    | 23 +++++++++++++++++++++++
> >  arch/arm/dts/mt7988-sd-rfb.dts | 23 +++++++++++++++++++++++
> >  2 files changed, 46 insertions(+)
> 
> i'm not sure if RFB (which dts you are patching) has also green/blue
> led and the buttons.

All MediaTek's RFBs have no LEDs. We discourage defining LEDs/buttons
in the RFB dts files.

> 
> If you really need this, you have to create an own devicetree for
> BPI-R4 (i guess you are
> using this board).
> 
> btw. in uboot eeprom can be written without setting the green
> led...somehow pinctrl driver
> behaves differently (or pin is already initialized to work).
> 
> regards Frank
> 

