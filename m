Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A25C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 08:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA835801B0;
	Thu, 23 Jan 2025 09:54:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Mo3V1RI2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5E6880214; Thu, 23 Jan 2025 09:54:57 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 182C080137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 09:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: b28db2eed96711efbd192953cf12861f-20250123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=DzUS3aZHr7e/B3vJP55xyJ1mW4wI14EOW1cMj89Fp5g=; 
 b=Mo3V1RI2fWymzbP3dDsT0f/luqdKlYpjfigT8wBqf6i+ITzCoIn3U2jTtf+iPT/kO8PdMnDAL+e+jFe+lRmboI849p+9L/n7h7ZqIs27xqykpgJQn8NzCYsODUmxmhk0XJo6b+BSOP/V7YJupercVHYngrJ/OUSQe3R4qVa/D+k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:5971e128-98fb-406a-977a-56500d18d1e7, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:60aa074, CLOUDID:b360943d-da39-4471-8a46-23da908abe46,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b28db2eed96711efbd192953cf12861f-20250123
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1326927512; Thu, 23 Jan 2025 16:54:47 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 23 Jan 2025 16:54:45 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Thu, 23 Jan 2025 16:54:45 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 0/5] Add support for MediaTek MT7987 SoC
Date: Thu, 23 Jan 2025 16:54:42 +0800
Message-ID: <cover.1737621362.git.weijie.gao@mediatek.com>
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

This patch series add support for MediaTek MT7987 SoC with its reference
boards and related drivers.

This patch series add basic boot support on eMMC/SD/SPI-NOR/SPI-NAND for these
boards. The clock, pinctrl drivers and the SoC initializaton code are also
included.

Weijie Gao (5):
  clk: mediatek: add clock driver support for MediaTek MT7987 SoC
  pinctrl: mediatek: add pinctrl driver for MT7987 SoC
  mmc: mediatek: add support for MediaTek MT7987 SoCs
  arm: mediatek: add support for MediaTek MT7987 SoC
  board: mediatek: add MT7987 reference boards

 arch/arm/dts/mt7987-emmc.dtsi                 |  50 ++
 arch/arm/dts/mt7987-netsys-u-boot.dtsi        |  51 ++
 arch/arm/dts/mt7987-pinctrl-u-boot.dtsi       | 146 +++
 arch/arm/dts/mt7987-pinctrl.dtsi              | 200 +++++
 arch/arm/dts/mt7987-sd.dtsi                   |  37 +
 arch/arm/dts/mt7987.dtsi                      | 808 +++++++++++++++++
 arch/arm/dts/mt7987a-emmc-rfb-u-boot.dtsi     |  61 ++
 arch/arm/dts/mt7987a-emmc-rfb.dts             |  37 +
 arch/arm/dts/mt7987a-rfb-u-boot.dtsi          |  71 ++
 arch/arm/dts/mt7987a-rfb.dts                  |  34 +
 arch/arm/dts/mt7987a-sd-rfb-u-boot.dtsi       |  59 ++
 arch/arm/dts/mt7987a-sd-rfb.dts               |  37 +
 arch/arm/dts/mt7987a-u-boot.dtsi              |  66 ++
 arch/arm/dts/mt7987a.dtsi                     |  96 ++
 arch/arm/mach-mediatek/Kconfig                |  19 +-
 arch/arm/mach-mediatek/Makefile               |   2 +
 arch/arm/mach-mediatek/mt7987/Makefile        |   4 +
 arch/arm/mach-mediatek/mt7987/init.c          |  62 ++
 arch/arm/mach-mediatek/mt7987/lowlevel_init.S |  30 +
 arch/arm/mach-mediatek/tzcfg.c                | 242 +++++
 board/mediatek/mt7987/MAINTAINERS             |   8 +
 board/mediatek/mt7987/Makefile                |   3 +
 board/mediatek/mt7987/mt7987_rfb.c            |  10 +
 configs/mt7987_emmc_rfb_defconfig             |  91 ++
 configs/mt7987_rfb_defconfig                  |  87 ++
 configs/mt7987_sd_rfb_defconfig               |  91 ++
 drivers/clk/mediatek/Makefile                 |   1 +
 drivers/clk/mediatek/clk-mt7987.c             | 848 ++++++++++++++++++
 drivers/mmc/mtk-sd.c                          |  21 +-
 drivers/pinctrl/mediatek/Kconfig              |   4 +
 drivers/pinctrl/mediatek/Makefile             |   1 +
 drivers/pinctrl/mediatek/pinctrl-mt7987.c     | 736 +++++++++++++++
 include/configs/mt7987.h                      |  14 +
 .../dt-bindings/clock/mediatek,mt7987-clk.h   | 206 +++++
 34 files changed, 4230 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/dts/mt7987-emmc.dtsi
 create mode 100644 arch/arm/dts/mt7987-netsys-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt7987-pinctrl-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt7987-pinctrl.dtsi
 create mode 100644 arch/arm/dts/mt7987-sd.dtsi
 create mode 100644 arch/arm/dts/mt7987.dtsi
 create mode 100644 arch/arm/dts/mt7987a-emmc-rfb-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt7987a-emmc-rfb.dts
 create mode 100644 arch/arm/dts/mt7987a-rfb-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt7987a-rfb.dts
 create mode 100644 arch/arm/dts/mt7987a-sd-rfb-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt7987a-sd-rfb.dts
 create mode 100644 arch/arm/dts/mt7987a-u-boot.dtsi
 create mode 100644 arch/arm/dts/mt7987a.dtsi
 create mode 100644 arch/arm/mach-mediatek/mt7987/Makefile
 create mode 100644 arch/arm/mach-mediatek/mt7987/init.c
 create mode 100644 arch/arm/mach-mediatek/mt7987/lowlevel_init.S
 create mode 100644 arch/arm/mach-mediatek/tzcfg.c
 create mode 100644 board/mediatek/mt7987/MAINTAINERS
 create mode 100644 board/mediatek/mt7987/Makefile
 create mode 100644 board/mediatek/mt7987/mt7987_rfb.c
 create mode 100644 configs/mt7987_emmc_rfb_defconfig
 create mode 100644 configs/mt7987_rfb_defconfig
 create mode 100644 configs/mt7987_sd_rfb_defconfig
 create mode 100644 drivers/clk/mediatek/clk-mt7987.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt7987.c
 create mode 100644 include/configs/mt7987.h
 create mode 100644 include/dt-bindings/clock/mediatek,mt7987-clk.h

-- 
2.34.1

