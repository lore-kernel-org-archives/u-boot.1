Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3193ACA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 15:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE4CD839B1;
	Thu, 14 Aug 2025 17:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=tq-group.com header.i=@tq-group.com header.b="W8lMS1fM";
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="al4SC5qX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56827838C5; Thu, 14 Aug 2025 14:04:59 +0200 (CEST)
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA14F838C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 14:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
 t=1755173096; x=1786709096;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oeFb2F0goVpWTro0kvoL7sO0BD8YYptOAA5x5ErGGsM=;
 b=W8lMS1fMqdbnOZXB49nZlk3PPwSQRAJuIU3beu6n8hs9x8xlI1PB43Su
 ihlL6xw4mmef/8b7jxcffNEZzDqIL+c/Gtl3exk8SAQMY9NwAHelSjPt7
 QmBHKVg8zS715TRi/1tGf3C9yewe5mRQg2PSGK3zixgE38HuckY41BjA4
 KWC1qepxlS78BMaFlwJDxy9j4cTaPcRSLsfT6FRoMWCbY9PWBX5oG8CYe
 hCZmrd3fyKJKbupJiF9fWS092ChOVqn2LU/U+poUZ+YFW8XC/+j50roDH
 tRf8Kbt7u0nZu7Pl9xHpWaKv2fWKOy+mA7ZX37Rc0934Z9X9hNUbB6GWT g==;
X-CSE-ConnectionGUID: /14RFrhgR5unvqhV8VxJ4Q==
X-CSE-MsgGUID: QdLfL4kGR8aUpmaHoZQL8Q==
X-IronPort-AV: E=Sophos;i="6.17,287,1747692000"; d="scan'208";a="45742151"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
 by mx1.tq-group.com with ESMTP; 14 Aug 2025 14:04:55 +0200
X-CheckPoint: {689DD0E7-34-9821D066-F5C64F68}
X-MAIL-CPID: F3B9A5CB711535EC3C8BBE5BF32E7590_2
X-Control-Analysis: str=0001.0A002121.689DD085.004E, ss=1, re=0.000, recu=0.000,
 reip=0.000, cl=1, cld=1, fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C783016C525; Thu, 14 Aug 2025 14:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
 s=dkim; t=1755173091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oeFb2F0goVpWTro0kvoL7sO0BD8YYptOAA5x5ErGGsM=;
 b=al4SC5qXjC99+JUHvmPPak8vTEduvMGfqB8xak8TEwwbmcagiMwDr3vnzkGgoGnZafelmg
 TIWV8UGw7LA/W9q3JKSqWsjVP/ikxm/onAz2oToEMoQFbtHFgwItT81AW1HBptvxRlyZWC
 7l8e3PTZn3ixvP9dQvlbILxaop7OYMpFuaj0xxaVz46/wwKP9BiT7MFUSUw4wAVxUnq8Xm
 qAji9iNYa1isb5LIcHcGLxkU95Jsqq/I/WmhgIoGhaCWR0lcoBvf3C3CFfvX7WIjtnPac9
 iTfybxsaNtek6iNgNrTiM7OF0EkZUfuVgV2a/zJ5aaQDk8hIv1gPkik3OY9SFA==
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Subject: [PATCH] net: add missing SPDX-License-Identifier for files
 originating from LiMon
Date: Thu, 14 Aug 2025 14:03:52 +0200
Message-ID: <20250814120354.235147-1-Max.Merchel@ew.tq-group.com>
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

The header of LiMon imported files reference a License file which
does not exist in U-Boot. Some files were forgotten when adding the
SPDX-License-Identifier.
The LiMon files were originally licensed under GPLv2 as can be seen in
commit [2ea91039].

Based on this commit, add the correct SPDX license identifier.
While at it drop the reference to the non-existing License file from all
LiMon files and update the SPDX-License-Identifier to SPDX version 3.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 include/net-legacy.h | 3 +--
 include/net/tftp.h   | 2 +-
 net/arp.c            | 3 +--
 net/arp.h            | 3 +--
 net/bootp.c          | 2 +-
 net/bootp.h          | 2 +-
 net/cdp.c            | 3 +--
 net/cdp.h            | 3 +--
 net/net.c            | 3 +--
 net/net_rand.h       | 2 +-
 net/ping.c           | 3 +--
 net/ping.h           | 3 +--
 12 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/include/net-legacy.h b/include/net-legacy.h
index a7dbcec1506..050fc352920 100644
--- a/include/net-legacy.h
+++ b/include/net-legacy.h
@@ -1,9 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  *	LiMon Monitor (LiMon) - Network.
  *
  *	Copyright 1994 - 2000 Neil Russell.
- *	(See License)
  *
  * History
  *	9/16/00	  bor  adapted to TQM823L/STK8xxL board, RARP/TFTP boot added
diff --git a/include/net/tftp.h b/include/net/tftp.h
index c411c9b2e65..c7e14817280 100644
--- a/include/net/tftp.h
+++ b/include/net/tftp.h
@@ -1,10 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  *	LiMon - BOOTP/TFTP.
  *
  *	Copyright 1994, 1995, 2000 Neil Russell.
  *	Copyright 2011 Comelit Group SpA
  *	               Luca Ceresoli <luca.ceresoli@comelit.it>
- *	(See License)
  */
 
 #ifndef __TFTP_H__
diff --git a/net/arp.c b/net/arp.c
index bc1e25f941f..4801dca6213 100644
--- a/net/arp.c
+++ b/net/arp.c
@@ -1,9 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  *	Copied from Linux Monitor (LiMon) - Networking.
  *
  *	Copyright 1994 - 2000 Neil Russell.
- *	(See License)
  *	Copyright 2000 Roland Borde
  *	Copyright 2000 Paolo Scaffardi
  *	Copyright 2000-2002 Wolfgang Denk, wd@denx.de
diff --git a/net/arp.h b/net/arp.h
index c50885fb9a5..882f3ec31fc 100644
--- a/net/arp.h
+++ b/net/arp.h
@@ -1,9 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  *	Copied from Linux Monitor (LiMon) - Networking.
  *
  *	Copyright 1994 - 2000 Neil Russell.
- *	(See License)
  *	Copyright 2000 Roland Borde
  *	Copyright 2000 Paolo Scaffardi
  *	Copyright 2000-2002 Wolfgang Denk, wd@denx.de
diff --git a/net/bootp.c b/net/bootp.c
index 95d906e3b2d..19e7453daed 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -1,8 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  *	Based on LiMon - BOOTP.
  *
  *	Copyright 1994, 1995, 2000 Neil Russell.
- *	(See License)
  *	Copyright 2000 Roland Borde
  *	Copyright 2000 Paolo Scaffardi
  *	Copyright 2000-2004 Wolfgang Denk, wd@denx.de
diff --git a/net/bootp.h b/net/bootp.h
index 68320bf66cf..47c743479e7 100644
--- a/net/bootp.h
+++ b/net/bootp.h
@@ -1,8 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  *	Copied from LiMon - BOOTP.
  *
  *	Copyright 1994, 1995, 2000 Neil Russell.
- *	(See License)
  *	Copyright 2000 Paolo Scaffardi
  */
 
diff --git a/net/cdp.c b/net/cdp.c
index d4cfc587ee3..6e404981d4a 100644
--- a/net/cdp.c
+++ b/net/cdp.c
@@ -1,9 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  *	Copied from Linux Monitor (LiMon) - Networking.
  *
  *	Copyright 1994 - 2000 Neil Russell.
- *	(See License)
  *	Copyright 2000 Roland Borde
  *	Copyright 2000 Paolo Scaffardi
  *	Copyright 2000-2002 Wolfgang Denk, wd@denx.de
diff --git a/net/cdp.h b/net/cdp.h
index 16ccbf4b59e..606fabba957 100644
--- a/net/cdp.h
+++ b/net/cdp.h
@@ -1,9 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  *	Copied from Linux Monitor (LiMon) - Networking.
  *
  *	Copyright 1994 - 2000 Neil Russell.
- *	(See License)
  *	Copyright 2000 Roland Borde
  *	Copyright 2000 Paolo Scaffardi
  *	Copyright 2000-2002 Wolfgang Denk, wd@denx.de
diff --git a/net/net.c b/net/net.c
index 5219367e391..ac9b65c0ca4 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1,9 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  *	Copied from Linux Monitor (LiMon) - Networking.
  *
  *	Copyright 1994 - 2000 Neil Russell.
- *	(See License)
  *	Copyright 2000 Roland Borde
  *	Copyright 2000 Paolo Scaffardi
  *	Copyright 2000-2002 Wolfgang Denk, wd@denx.de
diff --git a/net/net_rand.h b/net/net_rand.h
index 686e85f2b53..e21dff8569b 100644
--- a/net/net_rand.h
+++ b/net/net_rand.h
@@ -1,8 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  *	Copied from LiMon - BOOTP.
  *
  *	Copyright 1994, 1995, 2000 Neil Russell.
- *	(See License)
  *	Copyright 2000 Paolo Scaffardi
  */
 
diff --git a/net/ping.c b/net/ping.c
index 075df3663fe..fb981f62084 100644
--- a/net/ping.c
+++ b/net/ping.c
@@ -1,9 +1,8 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  *	Copied from Linux Monitor (LiMon) - Networking.
  *
  *	Copyright 1994 - 2000 Neil Russell.
- *	(See License)
  *	Copyright 2000 Roland Borde
  *	Copyright 2000 Paolo Scaffardi
  *	Copyright 2000-2002 Wolfgang Denk, wd@denx.de
diff --git a/net/ping.h b/net/ping.h
index 76ac225fc07..739f128408e 100644
--- a/net/ping.h
+++ b/net/ping.h
@@ -1,9 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  *	Copied from Linux Monitor (LiMon) - Networking.
  *
  *	Copyright 1994 - 2000 Neil Russell.
- *	(See License)
  *	Copyright 2000 Roland Borde
  *	Copyright 2000 Paolo Scaffardi
  *	Copyright 2000-2002 Wolfgang Denk, wd@denx.de
-- 
2.43.0

