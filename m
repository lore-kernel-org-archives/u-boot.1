Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B3FE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 09:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFF698036B;
	Fri, 10 Jan 2025 10:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="eMVduHq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C733805EA; Fri, 10 Jan 2025 10:13:13 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A128800C2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 10:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 154ce6b4cf3311ef99858b75a2457dd9-20250110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=uye4bnwRXMHD0SLpBRoh5HSVyxXrF7QyY4C6mjRuHV8=; 
 b=eMVduHq/cx9WthMqwjwIGQJejZ5NDsDWEoHz9Qi6fuKNzeE3GG9iy4drTNbScCilY8y/M4eZjl940T96OoZWqsz4LXoD7j2pn/c+q9uqLTaDWvMYGzHhUAbtVyYhs8RbxAlBjXIW/tDJz56nyd30mwOTWT6jDlKDyx8gR8HMKWY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:7e05c8e7-a842-49e3-9163-8eca699d1132, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-5
X-CID-META: VersionHash:60aa074, CLOUDID:dd13ae37-e11c-4c1a-89f7-e7a032832c40,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 154ce6b4cf3311ef99858b75a2457dd9-20250110
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1784338890; Fri, 10 Jan 2025 17:12:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 10 Jan 2025 17:12:56 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 10 Jan 2025 17:12:56 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 0/2] MediaTek MT7629 OF_UPSTREAM migration
Date: Fri, 10 Jan 2025 17:12:55 +0800
Message-ID: <cover.1736500023.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
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

This patch series migrates MediaTek MT7629 to OF_UPSTREAM

Sam Shih (2):
  clk: mediatek: mt7629: fix gate offset of peri clock tree
  board: mediatek: mt7629: Migrate to OF_UPSTREAM

 arch/arm/dts/mt7629-rfb-u-boot.dtsi    | 113 +++++++-
 arch/arm/dts/mt7629-rfb.dts            | 123 ---------
 arch/arm/dts/mt7629.dtsi               | 360 -------------------------
 configs/mt7629_rfb_defconfig           |   3 +-
 drivers/clk/mediatek/clk-mt7629.c      |  14 +-
 include/dt-bindings/clock/mt7629-clk.h | 206 --------------
 6 files changed, 127 insertions(+), 692 deletions(-)
 delete mode 100644 arch/arm/dts/mt7629-rfb.dts
 delete mode 100644 arch/arm/dts/mt7629.dtsi
 delete mode 100644 include/dt-bindings/clock/mt7629-clk.h

-- 
2.34.1

