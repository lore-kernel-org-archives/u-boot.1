Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165A1FED2FC
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 09:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3A8B841DA;
	Thu, 12 Mar 2026 10:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="e0jfhOSZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C62584051; Thu, 12 Mar 2026 10:57:43 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0B5E8418A
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 10:57:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=KNUHaF2JctCw7Mvz0aIVks9di/HgP3re3Lob/KjfsRk=; b=e0jfhOSZUr75xhFDmAlHJFUZho
 vwK4ls1TDIYkWvhmFwUue7xRNW84RHPIk4mR2F4n/6uSeTcJNY0ylL0UO0OB69dV/jrq+zFUd2wNJ
 QWkKljBBswJiC8t47O1jZr7E9NHpdDoxARdhmi2N25jCUyS74uqoUlUPfprCnfxYE0MdAoAwTlnF+
 HPL+LH1v+9JFet5sukGrQUs6cPVIckqZEiljjUwDAVpMgLVMe3nRQXO3FJ6neEbmX7qeL2g11DzJ+
 soBEcLfwpBHCNXb63gqB91ucflEpFMY6FOwj+W8NLzS04+FCJJEAyw6izn/MgnJV7B9hFnyWl/cAc
 ZcTdo8hg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnS-0007zM-0k; Thu, 12 Mar 2026 10:57:38 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnR-000Fyo-2p; Thu, 12 Mar 2026 10:57:37 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 08/13] board/tq: Add common baseboard API
Date: Thu, 12 Mar 2026 10:57:04 +0100
Message-ID: <20260312095711.3219756-9-Max.Merchel@ew.tq-group.com>
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

TQMa6 and other SOM from TQ-Systems GmbH need a base board. Therefore
functionality of U-Boot board callbacks may be distributed between SOM
and base board implementation.
To prevent code duplication and boilerplate implement a baseboard specific
API for TQ boards with weak defaults that can be filled out for baseboard
implementations as needed.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 board/tq/common/Kconfig  | 10 ++++++
 board/tq/common/Makefile |  8 +++++
 board/tq/common/tq_bb.c  | 78 ++++++++++++++++++++++++++++++++++++++++
 board/tq/common/tq_bb.h  | 39 ++++++++++++++++++++
 4 files changed, 135 insertions(+)
 create mode 100644 board/tq/common/Kconfig
 create mode 100644 board/tq/common/Makefile
 create mode 100644 board/tq/common/tq_bb.c
 create mode 100644 board/tq/common/tq_bb.h

diff --git a/board/tq/common/Kconfig b/board/tq/common/Kconfig
new file mode 100644
index 00000000000..a4a1d17bb9c
--- /dev/null
+++ b/board/tq/common/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2023-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+# D-82229 Seefeld, Germany.
+# Author: Markus Niebel, Max Merchel
+#
+
+config TQ_COMMON_BB
+	bool
+	default y
diff --git a/board/tq/common/Makefile b/board/tq/common/Makefile
new file mode 100644
index 00000000000..b643321fcb0
--- /dev/null
+++ b/board/tq/common/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (c) 2016-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+# D-82229 Seefeld, Germany.
+# Author: Markus Niebel
+#
+
+obj-$(CONFIG_TQ_COMMON_BB) += tq_bb.o
diff --git a/board/tq/common/tq_bb.c b/board/tq/common/tq_bb.c
new file mode 100644
index 00000000000..40cff6ab178
--- /dev/null
+++ b/board/tq/common/tq_bb.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ */
+
+#include <linux/types.h>
+
+#include "tq_bb.h"
+
+int __weak tq_bb_board_mmc_getwp(struct mmc *mmc)
+{
+	return 0;
+}
+
+int __weak tq_bb_board_mmc_getcd(struct mmc *mmc)
+{
+	return 0;
+}
+
+int __weak tq_bb_board_mmc_init(struct bd_info *bis)
+{
+	return 0;
+}
+
+int __weak tq_bb_board_early_init_f(void)
+{
+	return 0;
+}
+
+int __weak tq_bb_board_init(void)
+{
+	return 0;
+}
+
+int __weak tq_bb_board_late_init(void)
+{
+	return 0;
+}
+
+int __weak tq_bb_checkboard(void)
+{
+	return 0;
+}
+
+void __weak tq_bb_board_quiesce_devices(void)
+{
+	;
+}
+
+const char * __weak tq_bb_get_boardname(void)
+{
+	return "INVALID";
+}
+
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+void __weak tq_bb_board_init_f(ulong dummy)
+{
+	;
+}
+
+void __weak tq_bb_spl_board_init(void)
+{
+	;
+}
+#endif /* IS_ENABLED(CONFIG_SPL_BUILD) */
+
+/*
+ * Device Tree Support
+ */
+#if IS_ENABLED(CONFIG_OF_BOARD_SETUP) && IS_ENABLED(CONFIG_OF_LIBFDT)
+int __weak tq_bb_ft_board_setup(void *blob, struct bd_info *bis)
+{
+	return 0;
+}
+
+#endif /* IS_ENABLED(CONFIG_OF_BOARD_SETUP) && IS_ENABLED(CONFIG_OF_LIBFDT) */
diff --git a/board/tq/common/tq_bb.h b/board/tq/common/tq_bb.h
new file mode 100644
index 00000000000..5b1b3f62a8c
--- /dev/null
+++ b/board/tq/common/tq_bb.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2013-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Markus Niebel
+ */
+
+#ifndef __TQ_BB_H
+#define __TQ_BB_H
+
+struct mmc;
+struct bd_info;
+struct node_info;
+
+int tq_bb_board_mmc_getwp(struct mmc *mmc);
+int tq_bb_board_mmc_getcd(struct mmc *mmc);
+int tq_bb_board_mmc_init(struct bd_info *bis);
+
+int tq_bb_board_early_init_f(void);
+int tq_bb_board_init(void);
+int tq_bb_board_late_init(void);
+int tq_bb_checkboard(void);
+void tq_bb_board_quiesce_devices(void);
+
+const char *tq_bb_get_boardname(void);
+
+#if IS_ENABLED(CONFIG_SPL_BUILD)
+void tq_bb_board_init_f(ulong dummy);
+void tq_bb_spl_board_init(void);
+#endif
+
+/*
+ * Device Tree Support
+ */
+#if IS_ENABLED(CONFIG_OF_BOARD_SETUP) && IS_ENABLED(CONFIG_OF_LIBFDT)
+int tq_bb_ft_board_setup(void *blob, struct bd_info *bis);
+#endif /* IS_ENABLED(CONFIG_OF_BOARD_SETUP) && IS_ENABLED(CONFIG_OF_LIBFDT) */
+
+#endif /* __TQ_BB_H */
-- 
2.43.0

