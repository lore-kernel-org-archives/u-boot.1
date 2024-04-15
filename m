Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED9BC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09FBB881FA;
	Mon, 15 Apr 2024 08:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A218888246; Mon, 15 Apr 2024 08:08:23 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE44788220
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4VHxYc18DXz9t5l;
 Mon, 15 Apr 2024 08:08:20 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s_zrRo87hXwn; Mon, 15 Apr 2024 08:08:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4VHxYL0RTmz9tCB;
 Mon, 15 Apr 2024 08:08:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 072988B770;
 Mon, 15 Apr 2024 08:08:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 9uRx_d6WPsID; Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id E16418B775;
 Mon, 15 Apr 2024 08:08:05 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jean-Michel CASAUBON <jean-michel.casaubon@csgroup.eu>,
 DUBOIS Hugo <hugo.dubois.ext@csgroup.eu>, florent.trinh-thai@csgroup.eu,
 Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH v2 15/17] board: cssi: Use HAVE_VENDOR_COMMON_LIB logic
Date: Mon, 15 Apr 2024 08:07:28 +0200
Message-ID: <c1e2330cb0082b9b4a4ae3c13005335eda43113b.1713160866.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1713160866.git.christophe.leroy@csgroup.eu>
References: <cover.1713160866.git.christophe.leroy@csgroup.eu>
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

Instead of cross using cross-directory makefile directives,
add a Makefile in board/cssi/common/ directory in order to
benefit from HAVE_VENDOR_COMMON_LIB logic.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 board/cssi/cmpc885/Makefile | 2 +-
 board/cssi/cmpcpro/Makefile | 2 +-
 board/cssi/common/Makefile  | 8 ++++++++
 3 files changed, 10 insertions(+), 2 deletions(-)
 create mode 100644 board/cssi/common/Makefile

diff --git a/board/cssi/cmpc885/Makefile b/board/cssi/cmpc885/Makefile
index baf9e5ab4f..6c055097cd 100644
--- a/board/cssi/cmpc885/Makefile
+++ b/board/cssi/cmpc885/Makefile
@@ -5,6 +5,6 @@
 # Christophe Leroy <christophe.leroy@c-s.fr>
 #
 
-obj-y += cmpc885.o ../common/common.o
+obj-y += cmpc885.o
 obj-y += sdram.o
 obj-$(CONFIG_CMD_NAND) += nand.o
diff --git a/board/cssi/cmpcpro/Makefile b/board/cssi/cmpcpro/Makefile
index 73ff451ea1..30837781af 100644
--- a/board/cssi/cmpcpro/Makefile
+++ b/board/cssi/cmpcpro/Makefile
@@ -5,4 +5,4 @@
 # SPDX-License-Identifier:	GPL-2.0+
 #
 
-obj-y += cmpcpro.o nand.o ../common/common.o
+obj-y += cmpcpro.o nand.o
diff --git a/board/cssi/common/Makefile b/board/cssi/common/Makefile
new file mode 100644
index 0000000000..973582639e
--- /dev/null
+++ b/board/cssi/common/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 CS GROUP France
+# Christophe Leroy <christophe.leroy@csgroup.eu>
+#
+
+obj-$(CONFIG_TARGET_CMPC885) += common.o
+obj-$(CONFIG_TARGET_CMPCPRO) += common.o
-- 
2.43.0

