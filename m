Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220D5C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 08:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 889B586FBB;
	Sat,  4 Nov 2023 09:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ORCyNCNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E79AB871E4; Sat,  4 Nov 2023 09:02:19 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE0FB87119
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 09:01:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A481gXo005996;
 Sat, 4 Nov 2023 03:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699084902;
 bh=AiLeVVlqZus1D/0WfDrhpuy3cQIBt1e+CxW8CC/Pvk4=;
 h=From:To:CC:Subject:Date;
 b=ORCyNCNy5KcxIoWZRW8AICY8SH8peXOjEuMy6RKfrJP7vw/y04ikcFzzsYRdmS783
 2aJynZ29QqhbRsLqNW6j+kb9m3qLQZXvT0hpy/Bp22iZAl4liYYOBUe93lc54mqTSK
 mTq0Yi23aX6vgxqtQFEkZJwQwMqoBZxbjStCMRDU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A481gEx051488
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 03:01:42 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 03:01:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 03:01:41 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A481fTM018695;
 Sat, 4 Nov 2023 03:01:41 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>, <bb@ti.com>, <praneeth@ti.com>
Subject: [PATCH 0/5] board: beagle: Move beagleplay and omap3beagle under
 beagle vendor folder
Date: Sat, 4 Nov 2023 03:01:32 -0500
Message-ID: <20231104080137.9628-1-nm@ti.com>
X-Mailer: git-send-email 2.37.2
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

Hi,

Subsequent to the discussion in [1] and a bit of offline discussions
with Jason and Robert, The series moves AM62x based BeaglePlay and OMAP3
based original BeagleBoard over to board/beagle/ folder and also creates
doc/board/beagle folder.

This series also is a "breaking" change for developers used to config
fragments of beagleplay as it introduces standalone config for
beagleplay and gets rid of the fragments as it no longer makes sense
to have fragments of one board vendor depend on another.

This is in preperation to introduce BeagleBone AI-64 in follow on
series.

BeaglePlay Boot log:

SD/MMC boot: https://gist.github.com/nmenon/921930ffd117dcff7d051dbee53f11ff
emmc boot with sdcard: https://gist.github.com/nmenon/ac70f5523118d44177103dbafd80a751
emmc boot without sdcard: https://gist.github.com/nmenon/a3135f9ff39e7d96186b2ebbac633090

Combined series can be found here:
https://github.com/nmenon/u-boot/commits/beagleboneai64-v2

Dependencies (in order):
(keys and yaml)
1. https://lore.kernel.org/all/20231101183329.65091-1-afd@ti.com/
2. https://lore.kernel.org/u-boot/20231104024511.3597476-1-nm@ti.com/
(docs prompt cleanup - gets in the way of moving things)
3. https://lore.kernel.org/u-boot/20231103000915.2413501-1-nm@ti.com/

CAVEAT:
* omap3beagle was only tested with buildman build. I dont have a board
  to verify.
* I dont plan to mess around with am335x/am57x beagle* products. That churn is
  a bit too much and impacts too many active users. if there are folks
  wanting to do that - patches to list are welcome.

Nishanth Menon (5):
  arm: dts: k3-am625-beagleplay-u-boot/r5: Just depend on k3-binman.dtsi
  configs: Add am62x_beagleplay_*_defconfig
  board: Move beagleplay under beagle vendor folder
  doc: board: Move am62x_beagleplay to it's own vendor
  board: Move omap3 beagle under beagle vendor folder

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi  |  160 ++-
 arch/arm/dts/k3-am625-r5-beagleplay.dts       |   39 +
 arch/arm/mach-k3/Kconfig                      |    1 +
 arch/arm/mach-omap2/omap3/Kconfig             |    2 +-
 board/{ti => beagle}/beagle/Kconfig           |    2 +-
 board/{ti => beagle}/beagle/MAINTAINERS       |    2 +-
 board/{ti => beagle}/beagle/Makefile          |    0
 board/{ti => beagle}/beagle/beagle.c          |    0
 board/{ti => beagle}/beagle/beagle.h          |    0
 board/{ti => beagle}/beagle/led.c             |    0
 board/beagle/beagleplay/Kconfig               |   60 +
 board/beagle/beagleplay/MAINTAINERS           |    6 +
 board/beagle/beagleplay/Makefile              |    9 +
 board/beagle/beagleplay/beagleplay.c          |   29 +
 .../beagleplay}/beagleplay.env                |    0
 board/beagle/beagleplay/board-cfg.yaml        |   36 +
 board/beagle/beagleplay/pm-cfg.yaml           |   12 +
 board/beagle/beagleplay/rm-cfg.yaml           | 1088 +++++++++++++++++
 board/beagle/beagleplay/sec-cfg.yaml          |  379 ++++++
 board/ti/am62x/MAINTAINERS                    |    7 -
 board/ti/am62x/beagleplay_a53.config          |   55 -
 board/ti/am62x/beagleplay_r5.config           |   15 -
 configs/am62x_beagleplay_a53_defconfig        |  118 ++
 configs/am62x_beagleplay_r5_defconfig         |  110 ++
 doc/board/{ti => beagle}/am62x_beagleplay.rst |   26 +-
 .../{ti => beagle}/img/beagleplay_emmc.svg    |    0
 doc/board/beagle/index.rst                    |   13 +
 doc/board/index.rst                           |    1 +
 doc/board/ti/k3.rst                           |    2 +-
 29 files changed, 2063 insertions(+), 109 deletions(-)
 rename board/{ti => beagle}/beagle/Kconfig (88%)
 rename board/{ti => beagle}/beagle/MAINTAINERS (84%)
 rename board/{ti => beagle}/beagle/Makefile (100%)
 rename board/{ti => beagle}/beagle/beagle.c (100%)
 rename board/{ti => beagle}/beagle/beagle.h (100%)
 rename board/{ti => beagle}/beagle/led.c (100%)
 create mode 100644 board/beagle/beagleplay/Kconfig
 create mode 100644 board/beagle/beagleplay/MAINTAINERS
 create mode 100644 board/beagle/beagleplay/Makefile
 create mode 100644 board/beagle/beagleplay/beagleplay.c
 rename board/{ti/am62x => beagle/beagleplay}/beagleplay.env (100%)
 create mode 100644 board/beagle/beagleplay/board-cfg.yaml
 create mode 100644 board/beagle/beagleplay/pm-cfg.yaml
 create mode 100644 board/beagle/beagleplay/rm-cfg.yaml
 create mode 100644 board/beagle/beagleplay/sec-cfg.yaml
 delete mode 100644 board/ti/am62x/beagleplay_a53.config
 delete mode 100644 board/ti/am62x/beagleplay_r5.config
 create mode 100644 configs/am62x_beagleplay_a53_defconfig
 create mode 100644 configs/am62x_beagleplay_r5_defconfig
 rename doc/board/{ti => beagle}/am62x_beagleplay.rst (95%)
 rename doc/board/{ti => beagle}/img/beagleplay_emmc.svg (100%)
 create mode 100644 doc/board/beagle/index.rst

[]1 https://lore.kernel.org/u-boot/20231103143925.GP496310@bill-the-cat/T/#mf63a1d50313999adef6b9348b77a57eed6e3cb9d

-- 
2.37.2

