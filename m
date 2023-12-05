Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF52C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 15:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C9498784C;
	Tue,  5 Dec 2023 16:55:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="guLY9Tn+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D77887716; Tue,  5 Dec 2023 16:55:34 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 297DC86F28
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 16:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B5FtP0R126658;
 Tue, 5 Dec 2023 09:55:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701791725;
 bh=2LXs9ZUA8uy1wOm9/6zA/S0AH2Pr4lioUv+OSvQp0MY=;
 h=From:To:CC:Subject:Date;
 b=guLY9Tn+IB8CqEWd7Wb7znDp5uFKnm9SuoB4N5nXHDjynvRHSs262NkFv+121wclb
 uWVQD01PoV46bgeeo81QR4Bpg8VdCzhvMT5V2EbJEdT1iTQQ04XRnd4l4GxPrLj5XZ
 1/X4zjJW+lxjhm+x2PJNjuD3PlQDoLsd0pBywaa0=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B5FtPdb024652
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Dec 2023 09:55:25 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Dec 2023 09:55:24 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Dec 2023 09:55:24 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B5FtOkh018288;
 Tue, 5 Dec 2023 09:55:24 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v5 0/8] Move framebuffer reservation for SPL to RAM end
Date: Tue, 5 Dec 2023 21:25:15 +0530
Message-ID: <20231205155523.721784-1-devarsht@ti.com>
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
- Make a generic function to reserve video memory at SPL stage.
- Add debug prints while skipping framebuffer allocation at uboot.
- Correct commenting style as suggested.

V3:
- Change spl_reserve_video to spl_reserve_video_from_ram_top
  which enforce framebuffer reservation from end of RAM.
- Use gd->ram_top instead of local ram_top and update
  gd->reloc_addr after each reservation.
- Print error message on framebuffer reservation.
- Update SPL doc with spl splash screen specific info.

V4:
- Split patches into atomic commits.
- Remove duplicate check for video blob passed addresses and error out
  if invalid address/size received from blob.
- Improve SPL documentation memory reservation scheme and print message
  for video memory reservation from bloblist. 
- Add Reviewed-By.

V5:
 - Add comment for filling video handoff size with aligned size
 - Use PHASE_BOARD_F while checking for U-boot proper stage
 - Add Reviewed-by

Test logs:
https://gist.github.com/devarsht/30a3c1591270c9ebae00714b48d33058

Devarsh Thakkar (8):
  spl: Enforce framebuffer reservation from end of RAM
  arm: mach-k3: common: Reserve video memory from end of the RAM
  board: ti: am62x: evm: Remove video_setup from spl_board_init
  common/board_f: Catch bloblist before starting reservations
  video: Skip framebuffer reservation if already reserved
  video: Fill video handoff in video post probe
  doc: spl: Add info for missing Kconfigs
  doc: spl: Add info regarding memory reservation

 arch/arm/mach-k3/common.c    | 17 ++++++++++-----
 board/ti/am62x/evm.c         | 18 ----------------
 common/board_f.c             | 41 +++++++++++++++++++++++++++++++-----
 common/spl/spl.c             | 19 +++++++++++++++++
 doc/develop/spl.rst          | 37 ++++++++++++++++++++++++++++++++
 drivers/video/video-uclass.c | 40 ++++++++++++++++++++++++-----------
 include/spl.h                | 10 +++++++++
 7 files changed, 142 insertions(+), 40 deletions(-)

-- 
2.34.1

