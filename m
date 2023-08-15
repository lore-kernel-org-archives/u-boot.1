Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A879BC001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 16:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0569A869AE;
	Tue, 15 Aug 2023 18:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZcSBRPU0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFFF5869B4; Tue, 15 Aug 2023 18:44:49 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C50B786940
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37FGihUW049232;
 Tue, 15 Aug 2023 11:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692117883;
 bh=pxCbL15lUWSkElXWvh6lwXTrqJqUlbiNOd6f0tMHeKs=;
 h=From:To:CC:Subject:Date;
 b=ZcSBRPU0fupAM2nhktFj9uKjIA0eOrtxtZx8JzFxLAG5MlgKmhM7zy9NmrQLdW8y5
 szlBZ0CkIw/bTqG4VL7FqpIelX/bSZsF4cbliS6rc/rKpS9dglosuFVP8pYRPlAWvj
 ABZI0mvrqgLgP5xDlVSzwKKcj5csQvCzyfRSYKUc=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37FGihgh113812
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Aug 2023 11:44:43 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Aug 2023 11:44:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Aug 2023 11:44:42 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37FGigqH100646;
 Tue, 15 Aug 2023 11:44:42 -0500
From: Nishanth Menon <nm@ti.com>
To: <n-francis@ti.com>, <trini@konsulko.com>
CC: <bb@ti.com>, <praneeth@ti.com>, <afd@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 0/4] board: ti: Add support for BeaglePlay
Date: Tue, 15 Aug 2023 11:44:36 -0500
Message-ID: <20230815164440.2713726-1-nm@ti.com>
X-Mailer: git-send-email 2.40.0
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


Add support for BeaglePlay - rev 3

Boot log: https://gist.github.com/nmenon/3e99b44380873263e39ba4d84788db89

Full series(including dependencies) can be found at:
https://github.com/nmenon/fix-k3-dt-u-boot/commits/beagleplay-v3

Caveats:
* I have kept networking out of picture for now as it is still in debug
 (See
  https://github.com/nmenon/fix-k3-dt-u-boot/commits/beagleplay-v3-enet-debug
  if anyone is interested)

Changes since V2:
* I have rebased to latest next branch
  bdc682437a67 (origin/next) Merge branch '2023-08-14-assorted-general-updates' into next
* Uses config fragments by default.
* Updated MAINTAINER file as well

V2: https://lore.kernel.org/u-boot/20230727234446.3651836-1-nm@ti.com/
V1: https://lore.kernel.org/all/20230725185253.2123433-1-nm@ti.com/

Nishanth Menon (3):
  arm: dts: k3-am625-sk-binman: Add labels for unsigned binary
  board: ti: am62x: Add am62x_beagleplay_* defconfigs
  doc: board: ti: Add BeaglePlay documentation

Robert Nelson (1):
  arm: dts: Add k3-am625-beagleplay

 arch/arm/dts/Makefile                         |    2 +
 .../dts/k3-am625-beagleplay-ddr4-1600MTs.dtsi | 2195 +++++++++++++++++
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  172 ++
 arch/arm/dts/k3-am625-beagleplay.dts          |  758 ++++++
 arch/arm/dts/k3-am625-r5-beagleplay.dts       |   87 +
 arch/arm/dts/k3-am625-sk-binman.dtsi          |    4 +-
 board/ti/am62x/MAINTAINERS                    |    7 +
 board/ti/am62x/beagleplay_a53.config          |   20 +
 board/ti/am62x/beagleplay_r5.config           |   11 +
 doc/board/ti/am62x_beagleplay.rst             |  121 +
 doc/board/ti/k3.rst                           |    1 +
 11 files changed, 3376 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/dts/k3-am625-beagleplay-ddr4-1600MTs.dtsi
 create mode 100644 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am625-beagleplay.dts
 create mode 100644 arch/arm/dts/k3-am625-r5-beagleplay.dts
 create mode 100644 board/ti/am62x/beagleplay_a53.config
 create mode 100644 board/ti/am62x/beagleplay_r5.config
 create mode 100644 doc/board/ti/am62x_beagleplay.rst

-- 
2.40.0

