Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E3DFED2FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 09:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BCED841B8;
	Thu, 12 Mar 2026 10:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="evGNZgSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E0B83F14; Thu, 12 Mar 2026 10:57:40 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A25628415D
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 10:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=LvTnyIutl6jb5IK/Ipz2LuKm9uLC/X3jGJ9pBPxz5TY=; b=evGNZgShylCcN+jGOK74m+ELCf
 SkB1u/p+wn0owvY6d/Q9xVdO9KRfXSXlcVDSN4/RL2XVJBuawnedKEbHsJysvUELuyIr9B+UADuKZ
 wHel7yWHodWMGpRlREvr5l7UVjPt8KQSJdghGknmYall5iv4Z7Kpt4aErQ7SQhyhddxelkV8U48C7
 AXBU9FX5Lki0GL1iUCdwhkpmx3C5B57alW3W4nGRVG3L9uN4Xh1CrgGm311vt3BzKoMRmmzo3jqrq
 zW2O+tHvlhJs2wJhWmWeG0JTW98k7KTdv+BBhgKNUgUNBij8cvzKa3TWzE/25Tgn2a5NfoKiNX6dP
 dNOwGoZg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnQ-0007xJ-1s; Thu, 12 Mar 2026 10:57:36 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnQ-000Fyo-0t; Thu, 12 Mar 2026 10:57:36 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH 02/13] tqma6: remove board MAINTAINERS
Date: Thu, 12 Mar 2026 10:56:58 +0100
Message-ID: <20260312095711.3219756-3-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

All files are integrate in global MAINTAINERS.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/tqma6/MAINTAINERS | 7 -------
 1 file changed, 7 deletions(-)
 delete mode 100644 board/tq/tqma6/MAINTAINERS

diff --git a/board/tq/tqma6/MAINTAINERS b/board/tq/tqma6/MAINTAINERS
deleted file mode 100644
index 1d3f7d2cf63..00000000000
--- a/board/tq/tqma6/MAINTAINERS
+++ /dev/null
@@ -1,7 +0,0 @@
-TQ-SYSTEMS TQMA6 BOARD
-M:	Markus Niebel <Markus.Niebel@ew.tq-group.com>
-L:	TQ-Systems OSS Team <u-boot@ew.tq-group.com>
-S:	Maintained
-F:	board/tq/tqma6/
-F:	include/configs/tqma6.h
-F:	configs/tqma6*_defconfig
-- 
2.43.0

