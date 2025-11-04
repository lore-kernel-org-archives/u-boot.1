Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE26CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 12:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C5448144A;
	Tue,  4 Nov 2025 13:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fris.de header.i=@fris.de header.b="hNPidN1G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 707B38144A; Tue,  4 Nov 2025 13:56:12 +0100 (CET)
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 697DF8144A
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 13:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=frieder@fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D94FDC9DCE; Tue,  4 Nov 2025 13:56:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
 t=1762260970; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=xkzAj94Qx6LVfwbtT8HDW6thyyLmencK62vmUDC6xFk=;
 b=hNPidN1GOwk8FNGV6hpclB5Uhx0RX5PjMPNz5Rkx1UBX/NyOy0Kx/e+hmWUXXTUl+SLc6j
 4KExA/tTgudsBhD03ItNmJy1OF7snh0byhRCmzxs8mnsX2oBFKT57uL7SVNzfqEBIpa5ps
 wImJrQ3Q6RI2QYZnjCjzskl6VxfGPzpzw2oLt4sUK5meo0gQn0X21M0xRVmSu3JhRhGrm+
 DGGIPFOSaFWsa+tOY7dCaxAGXUVHCpiYZrf5nXZUriRlUvhQ41VggJ+FkOv5keBhpCXmrY
 +deKqIvLXdKh4g9F7ZOKDgQ2rE8lCOuvVctvlMn1fSgWiA+gNBCQSeBseQZqEg==
From: Frieder Schrempf <frieder@fris.de>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH 2/4] imx: kontron: Add common function to get HW UIDs from OTPs
Date: Tue,  4 Nov 2025 13:54:26 +0100
Message-ID: <20251104125441.138131-3-frieder@fris.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104125441.138131-1-frieder@fris.de>
References: <20251104125441.138131-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The factory provides a CPU UID in the OTPs and the SoM module
and the carrier board might provide additional UIDs in the GP
registers of the OTPs.

Provide a common function to load UIDs from arbitrary OTP
registers and generate a serial number string that is saved
in the "serial#" env variable.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 board/kontron/common/Kconfig  | 14 +++++++
 board/kontron/common/Makefile |  1 +
 board/kontron/common/hw-uid.c | 75 +++++++++++++++++++++++++++++++++++
 board/kontron/common/hw-uid.h | 26 ++++++++++++
 4 files changed, 116 insertions(+)
 create mode 100644 board/kontron/common/Kconfig
 create mode 100644 board/kontron/common/Makefile
 create mode 100644 board/kontron/common/hw-uid.c
 create mode 100644 board/kontron/common/hw-uid.h

diff --git a/board/kontron/common/Kconfig b/board/kontron/common/Kconfig
new file mode 100644
index 00000000000..d581006c203
--- /dev/null
+++ b/board/kontron/common/Kconfig
@@ -0,0 +1,14 @@
+menuconfig KONTRON_HW_UID
+	bool "Enable reading Kontron HW UID from OTP fuses"
+	help
+	  Enable support for reading Kontron hardware UIDs from OTP fuse registers.
+	  The UIDs are factory-programmed for SoMs and boards and are printed to the
+	  console and used as serial numbers if this option is enabled.
+
+menuconfig KONTRON_HW_UID_USE_SOC_FALLBACK
+	bool "Use the unique ID of the SoC as fallback serial number"
+	depends on KONTRON_HW_UID
+	default n
+	help
+	  Enable the fallback to the UID of the SoC programmed by the SoC
+	  manufacturer if no Kontron UID is found in the OTP fuses.
diff --git a/board/kontron/common/Makefile b/board/kontron/common/Makefile
new file mode 100644
index 00000000000..634744dc542
--- /dev/null
+++ b/board/kontron/common/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_KONTRON_HW_UID) += hw-uid.o
diff --git a/board/kontron/common/hw-uid.c b/board/kontron/common/hw-uid.c
new file mode 100644
index 00000000000..5358b1dfcf1
--- /dev/null
+++ b/board/kontron/common/hw-uid.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Kontron Electronics GmbH
+ */
+
+#include <linux/errno.h>
+#include <compiler.h>
+#include <asm/io.h>
+#include <env.h>
+#include <string.h>
+#include <vsprintf.h>
+
+#include "hw-uid.h"
+
+int get_serial_str_from_otp(struct uid_otp_loc loc, char *str, size_t str_len)
+{
+	u64 uid;
+	int ret;
+
+	if (loc.len < 1 || loc.len > 2) {
+		printf("Invalid number of UID OTP registers set!\n");
+		return -EINVAL;
+	}
+
+	uid = readl(loc.addr);
+
+	if (loc.len == 2)
+		uid |= (u64)readl(loc.addr + 0x4) << 32;
+
+	if (!uid)
+		return -ENOENT;
+
+	if (uid) {
+		switch (loc.format) {
+		case UID_OTP_FORMAT_DEC:
+			ret = snprintf(str, str_len, "%010llu", uid);
+			break;
+		case UID_OTP_FORMAT_HEX:
+			ret = snprintf(str, str_len, "%016llX", uid);
+			break;
+		}
+		if (ret < 0 || ret >= str_len) {
+			printf("Failed to convert UID!\n");
+			return -EFAULT;
+		}
+	}
+
+	return 0;
+}
+
+void get_serial_number(struct uid_otp_loc *locs, unsigned int num)
+{
+	char serial_string[17];
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < num; i++) {
+		ret  = get_serial_str_from_otp(locs[i], serial_string, sizeof(serial_string));
+		if (ret == 0)
+			break;
+	}
+
+	/* No valid UID in the OTP fuses, skip. */
+	if (ret) {
+		printf("Serial Number: None\n");
+		return;
+	}
+
+	printf("Serial Number: %s (%s)\n", serial_string, locs[i].desc);
+
+	if (!env_get("serial#"))
+		env_set("serial#", serial_string);
+	else if (strcmp(env_get("serial#"), serial_string))
+		printf("Warning: mismatch of UIDs in env and OTPs!\n");
+}
diff --git a/board/kontron/common/hw-uid.h b/board/kontron/common/hw-uid.h
new file mode 100644
index 00000000000..7eaf2cc9b6c
--- /dev/null
+++ b/board/kontron/common/hw-uid.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024 Kontron Electronics GmbH
+ */
+
+#ifndef _KONTRON_HW_UID_H
+#define _KONTRON_HW_UID_H
+
+#include <compiler.h>
+#include <stddef.h>
+
+enum {
+	UID_OTP_FORMAT_DEC = 0,
+	UID_OTP_FORMAT_HEX,
+};
+
+struct uid_otp_loc {
+	u32 *addr;
+	size_t len;
+	unsigned int format;
+	char *desc;
+};
+
+void get_serial_number(struct uid_otp_loc *locs, unsigned int num);
+
+#endif /* _KONTRON_HW_UID_H */
-- 
2.51.0

