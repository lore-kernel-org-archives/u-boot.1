Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05396CDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 16:06:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63C9286B73;
	Mon, 16 Oct 2023 18:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xVzuw0TU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9909D86940; Mon, 16 Oct 2023 18:06:25 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 977E686BF2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 18:06:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GG6Di2063695;
 Mon, 16 Oct 2023 11:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697472373;
 bh=94z1uN9fEyCWfroLBWaRxXeyOmIBiz7SQWEg2ge3U4g=;
 h=From:To:CC:Subject:Date;
 b=xVzuw0TUC3WOFOdLI8DSXQUbiZgFr5WGQu46NRQ+EVaIssQL5QZGVzm/d7XH9Mxsi
 gjqS1BQ1bJ8U2DfhDWRUVJHzDtRtkoiXAczSgi/WE4J+gDaYKox8VjWQdp737mY5wB
 /5f+H2tE2F+bjskabqIFYMWwsZhG1pS2Z4pw7N9U=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GG6DY1102379
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 16 Oct 2023 11:06:13 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 11:06:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 11:06:12 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GG6BR6112800;
 Mon, 16 Oct 2023 11:06:11 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <devarsht@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>
Subject: [RFC PATCH 0/5] Move video memory reservation for SPL at the end of
 RAM
Date: Mon, 16 Oct 2023 21:36:06 +0530
Message-ID: <20231016160611.1353458-1-devarsht@ti.com>
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
https://lore.kernel.org/all/CAPnjgZ1Hs0rNf0JDirp6YPsOQ5=QqQSP9g9qRwLoOASUV8a4cw@mail.gmail.com/ *** SUBJECT HERE ***

Devarsh Thakkar (5):
  arm: mach-k3: common: Reserve video memory from end of the RAM
  board: ti: am62x: evm: Remove video_setup from spl_board_init
  common/board_f: Catch bloblist before starting resevatinos
  video: Skip framebuffer reservation if already reserved
  video: Fill video handoff in video post probe

 arch/arm/mach-k3/common.c    | 21 +++++++++++++++++++++
 board/ti/am62x/evm.c         | 18 ------------------
 common/board_f.c             | 36 +++++++++++++++++++++++++++++++++---
 drivers/video/video-uclass.c | 33 +++++++++++++++++++++++----------
 4 files changed, 77 insertions(+), 31 deletions(-)

-- 
2.34.1

