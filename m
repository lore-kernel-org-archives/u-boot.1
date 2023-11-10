Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230FCC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 15:30:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD318782D;
	Fri, 10 Nov 2023 16:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HCavk/fc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EE3C8780B; Fri, 10 Nov 2023 16:29:55 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4648B87805
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 16:29:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AAFTks8105964;
 Fri, 10 Nov 2023 09:29:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699630186;
 bh=W2Du6IDYgQJQN+fdYbsGqHfNWlT07vQKF0eCfVCkCb8=;
 h=From:To:CC:Subject:Date;
 b=HCavk/fc+j8T+GiUUrC2Hepu2xEOrRpExgEsDQPJ4HGap3rdVFaKdCem2XRoG8wZ7
 bdUjDh6YeRnGbAKUsCyY85j77XyfULibY703SJ90+HHc0C2bcmrympffKJVSnFBonW
 DpHhUD+ZLNY5cbNMdfz5n0WwhZp2XGQIB49r+bFI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AAFTkZb055013
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 Nov 2023 09:29:46 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Nov 2023 09:29:46 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Nov 2023 09:29:46 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AAFTjRG011601;
 Fri, 10 Nov 2023 09:29:45 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v2 0/6] Move framebuffer reservation for SPL to RAM end
Date: Fri, 10 Nov 2023 20:59:38 +0530
Message-ID: <20231110152944.647535-1-devarsht@ti.com>
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

Move video memory reservation for SPL at end of RAM so that it does
not interefere with reservations for next stage so that the next stage
need not have holes in between for passed regions and instead it can
maintain continuity in reservations.

Also catch the bloblist before starting reservations to avoid the same
problem.

While at it, also fill missing fields in video handoff struct before
passing it to next stage.

This is as per discussions at :
For moving SPL framebuffer reservation at end of RAM:

https://lore.kernel.org/all/CAPnjgZ3xSoe_G3yrqwuAvoiVjUfZ+YQgkOR0ZTVXGT9VK8TwJg@mail.gmail.com/

For filling missing video handoff fields :
https://lore.kernel.org/all/CAPnjgZ1Hs0rNf0JDirp6YPsOQ5=QqQSP9g9qRwLoOASUV8a4cw@mail.gmail.com/

Changelog:
V2:
- Make a generic function to reserve video memory at SPL stage
- Add debug prints while skipping framebuffer allocation at uboot
- Correct commenting style as suggested

V3: 
- Change spl_reserve_video to spl_reserve_video_from_ram_top
  which enforce framebuffer reservation from end of RAM
- Use gd->ram_top instead of local ram_top and update
  gd->reloc_addr after each reservation
- Print error message on framebuffer reservation
- Update SPL doc with spl splash screen specific info

Test logs (at tip of U-Boot 2024.01-rc1 + these patches):
https://gist.github.com/devarsht/6a748b1d69bd2a4b60695a5e7776db73

Devarsh Thakkar (6):
  arm: mach-k3: common: Reserve video memory from end of the RAM
  board: ti: am62x: evm: Remove video_setup from spl_board_init
  common/board_f: Catch bloblist before starting resevations
  video: Skip framebuffer reservation if already reserved
  video: Fill video handoff in video post probe
  doc: spl: Add info regarding memory reservation and missing Kconfigs

 arch/arm/mach-k3/common.c    | 17 ++++++++++-----
 board/ti/am62x/evm.c         | 18 ----------------
 common/board_f.c             | 33 +++++++++++++++++++++++++---
 common/spl/spl.c             | 27 +++++++++++++++++++++++
 doc/develop/spl.rst          | 22 +++++++++++++++++++
 drivers/video/video-uclass.c | 42 +++++++++++++++++++++++++++---------
 include/spl.h                |  6 ++++++
 7 files changed, 129 insertions(+), 36 deletions(-)

-- 
2.34.1

