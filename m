Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9DAC3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 18:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4D8088BE0;
	Fri,  2 Aug 2024 20:00:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bX3+XLKo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3851A88BA4; Fri,  2 Aug 2024 20:00:35 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39AB888BE3
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 20:00:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1722621628;
 bh=ckQgGWtFoGaYN0khiBY557zlz5HDNzckGU7tJx3pQBU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bX3+XLKokWSHYMootWUSJKdaMEtcY3eu/rNPgTpKOScvfS915G8U9nORawkDuCGwb
 q5p7eaAjUSWLrbLFZ2Jn1wqNfCtUkAyiVcsBwrbHedqK7SMOHIGnFql0r988zllr6L
 QT3GVhjndstud1UD5EK3f8jlusT7KbPzmUOAvPJb0Rx2TdP2v0+6iPzicDXmR6nbxc
 i0NnDp9uURY74c2MmG5409bwNma0MjtqoGtJ0zL14xQL7paM+PtjudaTW0oBgkYqZB
 Ta4LIIjuXSGtCzoWDEzvZv34S2nsCTFLu6ItCasTCdzEQ5aDqpj5vGX6FsYTMrTDT3
 kNhFYa5XNCPcA==
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 52CEC378221C;
 Fri,  2 Aug 2024 18:00:28 +0000 (UTC)
Received: by jupiter.universe (Postfix, from userid 1000)
 id CFE144800F4; Fri, 02 Aug 2024 20:00:27 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Soeren Moch <smoch@web.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v3 3/7] board: rock5b-rk3588: add USB-C controller support
Date: Fri,  2 Aug 2024 19:59:33 +0200
Message-ID: <20240802180027.139193-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802180027.139193-1-sebastian.reichel@collabora.com>
References: <20240802180027.139193-1-sebastian.reichel@collabora.com>
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

Enable support for the fusb302 USB Type-C controller.

This will do early USB PD (power deliver) negotiation, which must happen
within 5 seconds after the USB-C connector has plugged in according to
the specification. It takes almost 5 seconds to go through the bootchain
on Rock 5B and jump to the operating system. When the Linux initializes
the fusb302 usually 20-30 seconds have gone since the device has been
plugged, which is far too late. The USB PD power source reacts with a
hard reset, which disables VBUS for some time. This is not a problem for
a battery driven device, but Rock 5B will loose its power-supply and
reset. By initializing PD in U-Boot, this can be avoided.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 board/radxa/rock5b-rk3588/Makefile        |  6 ++++
 board/radxa/rock5b-rk3588/rock5b-rk3588.c | 35 +++++++++++++++++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 board/radxa/rock5b-rk3588/Makefile
 create mode 100644 board/radxa/rock5b-rk3588/rock5b-rk3588.c

diff --git a/board/radxa/rock5b-rk3588/Makefile b/board/radxa/rock5b-rk3588/Makefile
new file mode 100644
index 000000000000..95d813596da4
--- /dev/null
+++ b/board/radxa/rock5b-rk3588/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier:     GPL-2.0+
+#
+# Copyright (c) 2022 Collabora Ltd.
+#
+
+obj-y += rock5b-rk3588.o
diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
new file mode 100644
index 000000000000..1c17ae93c76c
--- /dev/null
+++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023-2024 Collabora Ltd.
+ */
+
+#include <usb/tcpm.h>
+
+#ifdef CONFIG_MISC_INIT_R
+int misc_init_r(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	/*
+	 * This will do early USB PD (power deliver) negotiation, which must
+	 * happen within 5 seconds after the USB-C connector has plugged in
+	 * according to the specification. It takes almost 5 seconds to go
+	 * through the bootchain on Rock 5B and jump to the operating system.
+	 * When the Linux initializes the fusb302 usually 20-30 seconds have
+	 * gone since the device has been plugged, which is far too late.
+	 *
+	 * The USB PD power source reacts with a hard reset, which disables
+	 * VBUS for some time. This is not a problem for a battery driven
+	 * device, but Rock 5B will loose its power-supply and reset. By
+	 * initializing PD in U-Boot, this can be avoided.
+	 */
+	ret = tcpm_get("usb-typec@22", &dev);
+	if (ret) {
+		printf("Failed to probe Type-C controller\n");
+		return 0;
+	}
+
+	return 0;
+}
+#endif
-- 
2.43.0

