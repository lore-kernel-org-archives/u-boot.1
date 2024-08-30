Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C543CA0EFD
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 18:23:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FC5688D16;
	Fri, 30 Aug 2024 20:23:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="NbNBl9Ly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BF4588D11; Fri, 30 Aug 2024 20:23:33 +0200 (CEST)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FF4588CE5
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 20:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1725042211;
 bh=ZX6axD+oXcLLz2CuEGMGfBzxHwXeAIAlu4qav3t+kfk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NbNBl9LyaKJhJX8OWHy3QYOv14xgdZgzvSJylRf/HebJymUjbN6PlaiRKLuLnncK0
 x8QyAH4LPaFNKrrjc4lUnpHnNZ+vIMnFdjycKiQOIy3sbZAv2Mx9OogSsU/BLDm7qR
 661QhZU9xdYP+eA8DOWtMbW/hOXOiywLIP/GBJdP5/NQh88TzIkqpuHNUMTLZnaqZS
 oyMOq8NwgkRiKTOm1JyUkVl4oEc7W2dDpYNT7VMpiVVOLiB4xiKw5rTPFaw3eCAxkk
 mZEhDwHQXis05IY+JOo47cr2bRP9Ppi3YZJSp3nJbQ5UsFBAPuhIK8FGwEcpEzBE4J
 Aa95nkLbY73NA==
Received: from jupiter.universe (dyndsl-091-248-208-243.ewe-ip-backbone.de
 [91.248.208.243])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EA52317E10D4;
 Fri, 30 Aug 2024 20:23:30 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id A05B14800F6; Fri, 30 Aug 2024 20:23:30 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v4 3/6] board: rock5b-rk3588: enable USB-C in operating system
Date: Fri, 30 Aug 2024 20:22:17 +0200
Message-ID: <20240830182330.49528-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240830182330.49528-1-sebastian.reichel@collabora.com>
References: <20240830182330.49528-1-sebastian.reichel@collabora.com>
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

