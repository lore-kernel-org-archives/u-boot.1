Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DB2CA0FFA
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 18:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3EFA8698E;
	Tue,  5 Sep 2023 20:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nlSXBrPd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D33D86989; Tue,  5 Sep 2023 20:13:34 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5093686667
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 20:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 385IDSvx062832;
 Tue, 5 Sep 2023 13:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693937608;
 bh=bLrnjYIWHRphRML1m9KZQEfpuNf/4UmcCRTMeCqrPus=;
 h=From:To:CC:Subject:Date;
 b=nlSXBrPdcdOHo4pMu2ATSRuTihhemjSX7Sz17UIlPoziV3skjvW+KSQkUxo5VQF9w
 mbpleJxBDmIxVFrerggZtyfcVf13S58Gae9qgsU+j7v0lruLOlx1kOIyTGElKg9vYc
 BYKUa2Q22TREWAXOZ40aZTTbuZpU1ZAWFYtGi9RI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 385IDS5p010497
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Sep 2023 13:13:28 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 13:13:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 13:13:28 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 385IDS7W029122;
 Tue, 5 Sep 2023 13:13:28 -0500
From: Reid Tonking <reidt@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>, Reid
 Tonking <reidt@ti.com>
Subject: [PATCH 0/3] J7200 device tree sync from v6.5-rc1 to u-boot
Date: Tue, 5 Sep 2023 13:13:06 -0500
Message-ID: <20230905181309.61666-1-reidt@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

This series tries to sync device tree files from Linux v6.5-rc1 while 
making changes to the u-boot.dtsi and r5-common-proc-board.dts files in 
order to remove duplicate nodes and achieve successful boot.

MCU Ringacc [0] and DMA fixes [1] are currently being upstreamed to Linux. 
They'll be fixed in U-boot post their merge in Linux, hopefully during
v6.6-rc1 timeframe.

Test Logs are included in [2]

[0]: https://lore.kernel.org/all/20230809175932.2553156-1-vigneshr@ti.com/
[1]: https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/
[2]: https://gist.github.com/Glockn/73c30d9a189919169e38c2c2566b5fc6

Signed-off-by: Reid Tonking <reidt@ti.com>
---
Changes in v2:
- Separated mcu_timer0 fix into separate patch
- Added j7200-vtm compatible to k3_avs driver instead of using j721e 
  compatible
- &lp876441 node no longer needed for buck1_reg to enable avs
- dropped uneeded chosen/alias property/node from u-boot.dtsi file
- fixed spacing/typo issues
- removed most nesting of nodes and using mostly labels only now
- removed &main_r5fss0
- &mcu_timer0 now correctly implemented
- &dm_tifs moved to r5 root node
- Link to v1: https://lore.kernel.org/u-boot/20230822185725.6718-1-reidt@ti.com/

---
Reid Tonking (3):
  drivers: misc: k3_avs: Add Linux compatible to enable avs in u-boot
  arm: mach-k3: j7200: Add mcu_timer0 id to the dev list
  arm: dts: j7200: dtb sync with Linux 6.5-rc1

 .../k3-j7200-common-proc-board-u-boot.dtsi    | 160 +++---
 arch/arm/dts/k3-j7200-common-proc-board.dts   | 170 ++++--
 arch/arm/dts/k3-j7200-main.dtsi               | 512 +++++++++++++++++-
 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi         | 265 ++++++++-
 .../arm/dts/k3-j7200-r5-common-proc-board.dts | 301 +---------
 arch/arm/dts/k3-j7200-som-p0.dtsi             | 153 ++++--
 arch/arm/dts/k3-j7200-thermal.dtsi            |  47 ++
 arch/arm/dts/k3-j7200.dtsi                    |  30 +-
 arch/arm/mach-k3/j7200/dev-data.c             |   1 +
 drivers/misc/k3_avs.c                         |   2 +-
 10 files changed, 1152 insertions(+), 489 deletions(-)
 create mode 100644 arch/arm/dts/k3-j7200-thermal.dtsi

-- 
2.34.1

