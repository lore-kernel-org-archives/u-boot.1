Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A35CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 15:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03F7A839BE;
	Thu, 14 Aug 2025 17:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="gMB3Rytt";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="mfxxwjnK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6C07838E3; Thu, 14 Aug 2025 14:05:32 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEAE7838C5
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 14:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1755173131; x=1786709131;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3lh6HQbRM0CTblyQLQ87XWHoLDQ6bTadyvT36c9Yl5k=;
 b=gMB3Ryttv3Sp/C8LR9SXfNH2dexbPQvaDtXi0KfbJNf2iZ4/ha5oinpZ
 8cMmiG9kn0B/rFliZNhq+ssI7/HnGT60sqETrrXjxtWWM+R9dfcdkGiTS
 9LVTy0JxuzGS7R6rKcHdC9PPmjMpDPQxkAhnF2l729grze4+V5hKHB1DC
 +QuJWcowlbVIEmd7S4q8hutAUw6gyKu82NAruIVKYshvTetx2Stf7RTzO
 nZYIBX9UR1ZBEwZ5FKTT4RMyYHXy6iyG+bBW643SB3WSKEgy+bvPORHGp
 M+er2wLjlI6Yu3cxRRE1XdNDXVJebrCkmy55fWxPTaNJNTLiusmPHvUiX g==;
X-CSE-ConnectionGUID: O2RepZddRHusyGjnoLzNmQ==
X-CSE-MsgGUID: TrziOyGXToazb2RXitmKiA==
X-IronPort-AV: E=Sophos;i="6.17,287,1747692000"; d="scan'208";a="45742171"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 14 Aug 2025 14:05:26 +0200
X-CheckPoint: {689DD106-19-299FBAB0-EF52EDE7}
X-MAIL-CPID: EB4CAD67305C73E1551AD811E0541421_5
X-Control-Analysis: str=0001.0A00210A.689DD105.0018, ss=1, re=0.000, recu=0.000,
 reip=0.000, cl=1, cld=1, fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D2515164F7A; Thu, 14 Aug 2025 14:05:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1755173122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3lh6HQbRM0CTblyQLQ87XWHoLDQ6bTadyvT36c9Yl5k=;
 b=mfxxwjnKt+zSHeCMD8yOYVd955Xln0Iluulfsy2OkUxnWUpIR4l7eKZnGr7G02om5JqSBW
 WooExRPstlWN819/MvTMHeXvSLC3T1lQjT7LyDs5S/4VIe9svfUpTpv/i86wNK5G0Q70as
 yrHmoOwDWBJ+UGMx7HYo498NI5tw5DzIz1yEHjaGO0Oyd109CGNFNUTx5yPmH/zMSZ7RSY
 Y2FWwyIn3r5b46tBYMDR9CbggEJaLKFoV5E4ci1Euml/74ZzQ9compLr93eep5HmSUIBA1
 AHSKJeqkIYPVbyi+h0zxioI5Q7pkj5JYN2HgRr6RrAyPrjbhIkO7vKNhTyLzTw==
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Kuan Lim Lee <kuanlim.lee@starfivetech.com>,
 Wei Liang Lim <weiliang.lim@starfivetech.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH] mmc: sdhci-cadence6: fix SPDX-License-Identifier to
 GPL-2.0-or-later
Date: Thu, 14 Aug 2025 14:04:22 +0200
Message-ID: <20250814120424.235254-1-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 14 Aug 2025 17:15:25 +0200
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

GPL-2.0-or-platform_driver is not the correct license identifier.
The -or- indicates that this is the -or-later variant of GPL-2.0.
Furthermore, sdhci.h and sdhci-cadence.h are also licensed under GPL-2.0-or-later.
The GPL-2.0-or-platform_driver is corrected to GPL-2.0-or-later.

Fixes: fe11aa0b ("mmc: sdhci-cadence: Add support for Cadence sdmmc v6")
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 drivers/mmc/sdhci-cadence6.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index 9a92b8437a6..f8f5ad4a4e0 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-platform_driver
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2023 Starfive.
  *   Author: Kuan Lim Lee <kuanlim.lee@starfivetech.com>
-- 
2.43.0

