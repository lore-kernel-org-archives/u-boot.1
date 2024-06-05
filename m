Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA03FC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 15:28:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F7F882E2;
	Wed,  5 Jun 2024 17:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Buo/4hKG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D40088370; Wed,  5 Jun 2024 17:28:00 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 742AD86FB2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 17:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 455FRtA0057456;
 Wed, 5 Jun 2024 10:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717601275;
 bh=ZCl3zSvi9+3uGnIYkiq/98D6Wf02yMmsFss1HsZGvtk=;
 h=From:To:CC:Subject:Date;
 b=Buo/4hKG0rzi0Rhud7T74JLO09NsT0DenJ+32OT6qF7FIGn+5d0tY0Ik35ZeH/eRj
 8y43C9lcF3ACOdPV4D5JmBnf8kNGrokNRte1EIxJ7ZgvjUJkQecxNfJiu04ScvyESH
 hWBjW7DmBb2cBMTzy/gM2dkldlkeIjmbzk3vrXg4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 455FRsfT091027
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Jun 2024 10:27:55 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jun 2024 10:27:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jun 2024 10:27:54 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 455FRspA111358;
 Wed, 5 Jun 2024 10:27:54 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Dhruva Gole <d-gole@ti.com>, Bryan Brattlof <bb@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, <u-boot@lists.denx.de>,
 Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/3] arm: dts: am625/am62a7: Switch over to OF_UPSTREAM
Date: Wed, 5 Jun 2024 10:27:49 -0500
Message-ID: <20240605152752.1711835-1-nm@ti.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Organization: Texas Instruments, Inc.
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Cleanup am625 on by switching over the last two platforms (SK and
beagleplay) over to OF_UPSTREAM, and while at it, switch over am62a7
(last of the am62* family) over as well.

This superscedes the previous version of beagleplay only patch[1]

Test logs: https://gist.github.com/nmenon/ba310d3750a80789aca6a4fd90190135

Nishanth Menon (3):
  arm: dts: am625_beagleplay: Switch to OF_UPSTREAM
  arm: dts: am625_sk: Switch to OF_UPSTREAM
  arm: dts: am62a7_sk: Switch to OF_UPSTREAM

 arch/arm/dts/Makefile                        |    7 +-
 arch/arm/dts/k3-am62-main.dtsi               | 1058 ------------------
 arch/arm/dts/k3-am62-mcu.dtsi                |  176 ---
 arch/arm/dts/k3-am62-thermal.dtsi            |   36 -
 arch/arm/dts/k3-am62-wakeup.dtsi             |   96 --
 arch/arm/dts/k3-am62.dtsi                    |  122 --
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi |    4 +-
 arch/arm/dts/k3-am625-beagleplay.dts         |  932 ---------------
 arch/arm/dts/k3-am625-sk-binman.dtsi         |    2 +-
 arch/arm/dts/k3-am625-sk.dts                 |  299 -----
 arch/arm/dts/k3-am625.dtsi                   |  155 ---
 arch/arm/dts/k3-am62a-main.dtsi              | 1054 -----------------
 arch/arm/dts/k3-am62a-mcu.dtsi               |  170 ---
 arch/arm/dts/k3-am62a-sk-binman.dtsi         |    2 +-
 arch/arm/dts/k3-am62a-thermal.dtsi           |   50 -
 arch/arm/dts/k3-am62a-wakeup.dtsi            |   73 --
 arch/arm/dts/k3-am62a.dtsi                   |  125 ---
 arch/arm/dts/k3-am62a7-sk.dts                |  702 ------------
 arch/arm/dts/k3-am62x-sk-common.dtsi         |  535 ---------
 configs/am62ax_evm_a53_defconfig             |    3 +-
 configs/am62x_beagleplay_a53_defconfig       |    3 +-
 configs/am62x_evm_a53_defconfig              |    3 +-
 22 files changed, 12 insertions(+), 5595 deletions(-)
 delete mode 100644 arch/arm/dts/k3-am62-main.dtsi
 delete mode 100644 arch/arm/dts/k3-am62-mcu.dtsi
 delete mode 100644 arch/arm/dts/k3-am62-thermal.dtsi
 delete mode 100644 arch/arm/dts/k3-am62-wakeup.dtsi
 delete mode 100644 arch/arm/dts/k3-am62.dtsi
 delete mode 100644 arch/arm/dts/k3-am625-beagleplay.dts
 delete mode 100644 arch/arm/dts/k3-am625-sk.dts
 delete mode 100644 arch/arm/dts/k3-am625.dtsi
 delete mode 100644 arch/arm/dts/k3-am62a-main.dtsi
 delete mode 100644 arch/arm/dts/k3-am62a-mcu.dtsi
 delete mode 100644 arch/arm/dts/k3-am62a-thermal.dtsi
 delete mode 100644 arch/arm/dts/k3-am62a-wakeup.dtsi
 delete mode 100644 arch/arm/dts/k3-am62a.dtsi
 delete mode 100644 arch/arm/dts/k3-am62a7-sk.dts
 delete mode 100644 arch/arm/dts/k3-am62x-sk-common.dtsi

 [1] https://lore.kernel.org/u-boot/20240604134751.249048-1-nm@ti.com/

base-commit: 227be29df37545f74243a98c12a4a33c4160e3cd
-- 
2.43.0

