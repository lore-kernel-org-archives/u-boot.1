Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A1FC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 13:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD3CD87C9D;
	Tue, 31 Oct 2023 14:12:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DnmC2zjF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FF9E87B47; Tue, 31 Oct 2023 14:12:18 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31A2B878FC
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39VDC91o058669;
 Tue, 31 Oct 2023 08:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698757929;
 bh=1jqiVEXjNHrdezMZ/yjkWstmthQhn7U3L6qhnmUHFc8=;
 h=From:To:CC:Subject:Date;
 b=DnmC2zjFWWA64If64Q1s7WmuOAs5p1MimwWVUcle26HgmFRe/nq4IbiPEvBRkDTT0
 5e6EZ4LnSO0tSc5hwjWybpB3BWxVFAth9uPEIG/oLIqR6vI+Zmj3IzSBFfWGq0xbSQ
 vPrrhvmWFZGVq51++vXgk+RWPhnb0riKIAmlCV0o=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39VDC9Yo101894
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 31 Oct 2023 08:12:09 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 08:12:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 08:12:09 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39VDC8xA015117;
 Tue, 31 Oct 2023 08:12:09 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>, <devarsht@ti.com>
Subject: [PATCH v2 0/5]  Move video memory reservation for SPL to the
Date: Tue, 31 Oct 2023 18:42:03 +0530
Message-ID: <20231031131208.435268-1-devarsht@ti.com>
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

Changelog (w.r.t previous RFC series that was sent before):
V2:
- Make a generic function to reserve video memory at SPL stage
- Add debug prints while skipping framebuffer allocation at uboot
- Correct commenting style as suggested

Previous RFC series:
https://lore.kernel.org/all/20231016160611.1353458-1-devarsht@ti.com/

Test logs (at tip of U-Boot 2024.01-rc1+ this series (with debugs)):
https://gist.github.com/devarsht/43dbcc02c585a0b18f8f99e910bf5ef9

Devarsh Thakkar (5):
  arm: mach-k3: common: Reserve video memory from end of the RAM
  board: ti: am62x: evm: Remove video_setup from spl_board_init
  common/board_f: Catch bloblist before starting resevations
  video: Skip framebuffer reservation if already reserved
  video: Fill video handoff in video post probe

 arch/arm/mach-k3/common.c    |  2 ++
 board/ti/am62x/evm.c         | 18 ------------------
 common/board_f.c             | 33 +++++++++++++++++++++++++++++---
 common/spl/spl.c             | 19 ++++++++++++++++++
 drivers/video/video-uclass.c | 37 ++++++++++++++++++++++++++----------
 include/spl.h                |  4 ++++
 6 files changed, 82 insertions(+), 31 deletions(-)

-- 
2.34.1

