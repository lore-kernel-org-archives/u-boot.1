Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C157EC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 09:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E7C8070C;
	Fri, 17 Jan 2025 10:16:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="mM6z9M5g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A196C806FB; Fri, 17 Jan 2025 10:16:44 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 291CC8069D
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 10:16:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: beaacd86d4b311ef99858b75a2457dd9-20250117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=jwGs5spJ6W5n55/ISm0iliGNwDW3c/fBECantDJiYLQ=; 
 b=mM6z9M5gcEYjq8Mra01xMK8zPBCWmH4tuX7YARTNr80aIfzZrqRUCbSy/3ABh6ZpvC8Tomt085dUWvdS4y/XxBRT5KNpzfHgfX/p8znsLYEACKzALdfvg5RSOD+fmh69Q0P5N+aqc7l35dubwj5t5eQsAVBd2V24Lao5g92DGAQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:1659bc01-c17a-490f-9ffd-a3c01d2ed123, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:60aa074, CLOUDID:d7420b38-e11c-4c1a-89f7-e7a032832c40,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: beaacd86d4b311ef99858b75a2457dd9-20250117
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2104990283; Fri, 17 Jan 2025 17:16:33 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 Jan 2025 17:16:32 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 17 Jan 2025 17:16:31 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 00/15] Cumulative fixes and updates for MediaTek platform
Date: Fri, 17 Jan 2025 17:16:27 +0800
Message-ID: <cover.1737104723.git.weijie.gao@mediatek.com>
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

This patch series contains fixes and updates for MediaTek platform,
including drivers, board and arch files.

Weijie Gao (15):
  board: mediatek: mt7622: remove board_late_init
  clk: mediatek: fix uninitialized fields issue in INFRA_MUX struct
  configs: mt7629: move image load address to 0x42000000
  configs: mt7988: move image load address to 0x44000000
  spi: mtk_spim: add support to use DT live tree
  spi: mtk_spim: check slave device mode in spi-mem's supports_op
  arm: dts: mediatek: add quad mode capabilities for SPI flashes
  pwm: mediatek: add pwm3 support for mt7981
  pci: mediatek: add support for multiple ports in mediatek pcie gen3
    driver
  arm: dts: mediatek: add pcie support for mt7988
  arm: dts: medaitek: fix internal switch link speed of mt7988
  arm: dts: mediatek: add support for all three GMACs for mt7988
  arm: dts: medaitek: add flash interface driving settings for mt7988
  arm: dts: mediatek: update mt7981 mmc node
  MAINTAINERS: update file list for MediaTek ARM platform

 MAINTAINERS                        |   5 +
 arch/arm/dts/mt7981-emmc-rfb.dts   |   8 ++
 arch/arm/dts/mt7981-rfb.dts        |  12 ++
 arch/arm/dts/mt7981-sd-rfb.dts     |  14 +-
 arch/arm/dts/mt7981.dtsi           |  22 ++--
 arch/arm/dts/mt7986a-rfb.dts       |   4 +
 arch/arm/dts/mt7986b-rfb.dts       |   4 +
 arch/arm/dts/mt7988-rfb.dts        |  59 ++++++++-
 arch/arm/dts/mt7988-sd-rfb.dts     |   5 +-
 arch/arm/dts/mt7988.dtsi           | 204 ++++++++++++++++++++++++++++-
 board/mediatek/mt7622/mt7622_rfb.c |   7 -
 configs/mt7629_rfb_defconfig       |   2 +-
 configs/mt7988_rfb_defconfig       |   2 +-
 drivers/clk/mediatek/clk-mt7981.c  |   1 +
 drivers/clk/mediatek/clk-mt7986.c  |   1 +
 drivers/clk/mediatek/clk-mt7988.c  |   1 +
 drivers/pci/pcie_mediatek_gen3.c   |  24 ++++
 drivers/pwm/pwm-mtk.c              |   2 +-
 drivers/spi/mtk_spim.c             |   5 +-
 19 files changed, 353 insertions(+), 29 deletions(-)

-- 
2.34.1

