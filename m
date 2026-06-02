Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5C9CD6E60
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 11:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36657848D2;
	Tue,  2 Jun 2026 13:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ldgeFGh8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38AAF84878; Tue,  2 Jun 2026 13:58:17 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ACC984874
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 13:58:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=ACxnlkvxV0lcaTG0y3qip4n+mjjWxXnDLXuTugPICS4=; b=ldgeFGh8JUBoo0Zr51I1wLH4+k
 uv6GAQH0Q5+mchPKaqs1g1sTtwzyVaXQJ0utenCJ9Qp6CRwmfiGijpg0ERsSgw/9ntuZrUymJwRhL
 fOSaUnKFnVvGGXL9mT1V1ATopkmOVvn2+2B22+ffoKJ771yrclABKqh3FT1V3uV1Q+nXEeeOqxsEn
 MlyI4CH6uXTDoUnmsDmzr415DLxr2l9wD95DuXlhPabXfQpgt1FeC2CMPTb/XQi4YVC4nV3iwV/FP
 gv52IlvdXsv1KkL0sFW3bRFHW+E7qcJY75fTnyjvZIM2GwvK6ItI+dN3lof343XGKv0bH/9766/2l
 ASwxX2XQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wUNl6-000LiQ-2f; Tue, 02 Jun 2026 13:58:12 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wUNl5-000J89-2L; Tue, 02 Jun 2026 13:58:12 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH v4 4/7] board: tq: common: add sysinfo setup helper
Date: Tue,  2 Jun 2026 13:57:52 +0200
Message-Id: <20260602115755.371164-5-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602115755.371164-1-Alexander.Feilke@ew.tq-group.com>
References: <20260602115755.371164-1-Alexander.Feilke@ew.tq-group.com>
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

From: Nora Schiffer <nora.schiffer@ew.tq-group.com>

Add a setup helper based on the tq_eeprom sysinfo driver
and set up the U-Boot environment.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 board/tq/common/Kconfig      |  5 +++++
 board/tq/common/Makefile     |  1 +
 board/tq/common/tq_sysinfo.c | 37 ++++++++++++++++++++++++++++++++++++
 board/tq/common/tq_sysinfo.h | 15 +++++++++++++++
 4 files changed, 58 insertions(+)
 create mode 100644 board/tq/common/tq_sysinfo.c
 create mode 100644 board/tq/common/tq_sysinfo.h

diff --git a/board/tq/common/Kconfig b/board/tq/common/Kconfig
index 2fe2ca30072..567b6e2380a 100644
--- a/board/tq/common/Kconfig
+++ b/board/tq/common/Kconfig
@@ -14,3 +14,8 @@ config TQ_COMMON_SDMMC
 
 config TQ_COMMON_SOM
 	bool
+
+config TQ_COMMON_SYSINFO
+	bool
+	select SYSINFO
+	imply SYSINFO_TQ_EEPROM
diff --git a/board/tq/common/Makefile b/board/tq/common/Makefile
index 4af9207da4a..6cb39a1925e 100644
--- a/board/tq/common/Makefile
+++ b/board/tq/common/Makefile
@@ -8,3 +8,4 @@
 obj-$(CONFIG_TQ_COMMON_BB) += tq_bb.o
 obj-$(CONFIG_TQ_COMMON_SOM) += tq_som.o
 obj-$(CONFIG_TQ_COMMON_SDMMC) += tq_sdmmc.o
+obj-$(CONFIG_$(PHASE_)TQ_COMMON_SYSINFO) += tq_sysinfo.o
diff --git a/board/tq/common/tq_sysinfo.c b/board/tq/common/tq_sysinfo.c
new file mode 100644
index 00000000000..8d21d1e97c6
--- /dev/null
+++ b/board/tq/common/tq_sysinfo.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Common sysinfo helpers for TQ-Systems SOMs
+ *
+ * Copyright (c) 2020-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>
+ * D-82229 Seefeld, Germany.
+ * Author: Nora Schiffer
+ */
+
+#include <env.h>
+#include <log.h>
+#include <sysinfo/tq_eeprom.h>
+
+#include "tq_sysinfo.h"
+
+#define MAX_NAME_LENGTH	80
+
+int tq_common_sysinfo_setup(void)
+{
+	struct udevice *sysinfo;
+	char buf[MAX_NAME_LENGTH];
+	int ret;
+
+	ret = sysinfo_get_and_detect(&sysinfo);
+	if (ret) {
+		log_debug("Failed to get sysinfo data: %d\n", ret);
+		return ret;
+	}
+
+	if (!sysinfo_get_str(sysinfo, SYSID_TQ_MODEL, sizeof(buf), buf))
+		env_set_runtime("boardtype", buf);
+
+	if (!sysinfo_get_str(sysinfo, SYSID_TQ_SERIAL, sizeof(buf), buf))
+		env_set_runtime("serial#", buf);
+
+	return 0;
+}
diff --git a/board/tq/common/tq_sysinfo.h b/board/tq/common/tq_sysinfo.h
new file mode 100644
index 00000000000..d73b00eb8d7
--- /dev/null
+++ b/board/tq/common/tq_sysinfo.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Common sysinfo helpers for TQ-Systems SOMs
+ *
+ * Copyright (c) 2025-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>
+ * D-82229 Seefeld, Germany.
+ * Author: Nora Schiffer
+ */
+
+#ifndef __TQ_SYSINFO_H
+#define __TQ_SYSINFO_H
+
+int tq_common_sysinfo_setup(void);
+
+#endif /* __TQ_SYSINFO_H */
-- 
2.34.1

