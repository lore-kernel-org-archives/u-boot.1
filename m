Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E113ECD5BD5
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 09:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 498BB83FF5;
	Wed, 27 May 2026 11:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="WEIEZP4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B66A383FB0; Wed, 27 May 2026 11:52:29 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1E9D84659
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 11:52:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=r1kVL03Kq9l0F8MiP7x/4wA1wGo9Nkov01Cy8Xspdvo=; b=WEIEZP4EBYaBwqqBwh0KOxeC9C
 FamcDkeIZjZoGStvVlLnM8BPH6uJ/+0eUUEKBhBuNnivtIqdG8T9wUeABHF4iFEFV+aTM70efLBWZ
 BGEXBQYggWrVIDUyMSxLIdjN4/hyClCW7V4/lQi5b2AAobEBNBPJowPOtJwSwKNERd/GLWjvWmvLF
 huEzoMELN7UbmFWf1ZmQHoPo76DRM8V4uEGKoom/pYxJqi81o6DJ+WZdWZpTRoNz47WI1UnThGLiL
 g6slyCmMOSTpiAVfT5AiM/p3bXhNCFHqM3HTk0ecsQgM9mZ5W4VqpB2iTLtziJqpQxBTZsUSP40zZ
 vhff5Vlg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wSAw5-0002SQ-2Y; Wed, 27 May 2026 11:52:25 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wSAw4-000JXI-2j; Wed, 27 May 2026 11:52:25 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Alexander Feilke <alexander.feilke@ew.tq-group.com>
Subject: [PATCH v3 4/7] board: tq: common: add sysinfo setup helper
Date: Wed, 27 May 2026 11:51:20 +0200
Message-Id: <20260527095123.50797-5-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
References: <20260527095123.50797-1-Alexander.Feilke@ew.tq-group.com>
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
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 board/tq/common/Kconfig      |  5 +++++
 board/tq/common/Makefile     |  1 +
 board/tq/common/tq_sysinfo.c | 32 ++++++++++++++++++++++++++++++++
 board/tq/common/tq_sysinfo.h | 15 +++++++++++++++
 4 files changed, 53 insertions(+)
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
index 00000000000..6ba6e26f275
--- /dev/null
+++ b/board/tq/common/tq_sysinfo.c
@@ -0,0 +1,32 @@
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
+#include <sysinfo/tq_eeprom.h>
+
+#define MAX_NAME_LENGTH	80
+
+void tq_common_sysinfo_setup(void)
+{
+	struct udevice *sysinfo;
+	char buf[MAX_NAME_LENGTH] = "";
+	int ret;
+
+	ret = sysinfo_get_and_detect(&sysinfo);
+	if (ret) {
+		pr_err("Failed to get sysinfo data: %d\n", ret);
+		return;
+	}
+
+	if (!sysinfo_get_str(sysinfo, SYSID_TQ_MODEL, sizeof(buf), buf))
+		env_set_runtime("boardtype", buf);
+
+	if (!sysinfo_get_str(sysinfo, SYSID_TQ_SERIAL, sizeof(buf), buf))
+		env_set_runtime("serial#", buf);
+}
diff --git a/board/tq/common/tq_sysinfo.h b/board/tq/common/tq_sysinfo.h
new file mode 100644
index 00000000000..094891dbfad
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
+void tq_common_sysinfo_setup(void);
+
+#endif /* __TQ_SYSINFO_H */
-- 
2.34.1

