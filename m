Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF14FD1D879
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 15:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C183288730;
	Tue, 15 Oct 2024 17:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="lNAV+5/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E493B88902; Tue, 15 Oct 2024 17:27:28 +0200 (CEST)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A42C088B6D
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 17:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1729006044;
 bh=4Cyn3OfAdCFRcdDnrsKPxZ+zTc043BxcWuyBSFMwvoA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lNAV+5/swfwA+ZwKo1zGYti6LDVP3va9MQ5hxspPn1yhn5HYrUtvCgHCeMSyt3DzP
 nSciU4NDAVmI4Gg7AFRL0cx35I/m+4QKxUkVaJB8WdJLx3yZM84AZ/uu1DYuxfWwKX
 i0BeAes9itRZa5BYUWmkcq6HYY9EmNmq+14KsQ0Qb6g9FrtORaQRtL31I369QcBXPx
 nUVbmshmR3RqO0Tzwyys9EGBlD1iIpXDCpU/FNnh9mdZtLc1cTDL8lCdEIKJnzrlDj
 405s/mp05r/S1J6W8ebwRoYdyulRWplUUK9EdyPRvtXfwFqte98BiitZFTzBUPwHIr
 tJMKSbJcHwfwQ==
Received: from jupiter.universe (dyndsl-091-248-191-104.ewe-ip-backbone.de
 [91.248.191.104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5662917E362E;
 Tue, 15 Oct 2024 17:27:24 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 1D6E14800F6; Tue, 15 Oct 2024 17:27:19 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Anand Moon <linux.amoon@gmail.com>, Maxim Kiselev <bigunclemax@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v7 3/6] board: rock5b-rk3588: enable USB-C in operating system
Date: Tue, 15 Oct 2024 17:26:45 +0200
Message-ID: <20241015152719.88678-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015152719.88678-1-sebastian.reichel@collabora.com>
References: <20241015152719.88678-1-sebastian.reichel@collabora.com>
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

Since older U-Boot releases do not negotiate USB PD, the kernel
DT may not enable the USB-C controller by default to avoid a
regression. The plan is to upstream it with 'status = "fail";'
instead. U-Boot should then mark it as 'status = "okay";' if
it negotiated USB PD. Currently existing upstream kernel DTs do
not yet have the USB-C controller at all, so we ignore any
failures.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Tested-by: Soeren Moch <smoch@web.de>
Tested-by: Anand Moon <linux.amoon@gmail.com>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 board/radxa/rock5b-rk3588/Makefile        |  6 ++++++
 board/radxa/rock5b-rk3588/rock5b-rk3588.c | 16 ++++++++++++++++
 2 files changed, 22 insertions(+)
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
index 000000000000..fc2f69db2241
--- /dev/null
+++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2023-2024 Collabora Ltd.
+ */
+
+#include <fdtdec.h>
+#include <fdt_support.h>
+
+#ifdef CONFIG_OF_BOARD_SETUP
+int ft_board_setup(void *blob, struct bd_info *bd)
+{
+	if (IS_ENABLED(CONFIG_TYPEC_FUSB302))
+		fdt_status_okay_by_compatible(blob, "fcs,fusb302");
+	return 0;
+}
+#endif
-- 
2.45.2

