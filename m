Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDD1CD37AB
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 18:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B5DF88C8E;
	Tue,  3 Sep 2024 20:21:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="YOevt+JO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1561888C36; Tue,  3 Sep 2024 20:21:46 +0200 (CEST)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [IPv6:2a01:4f8:201:9162::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F9C188B9F
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 20:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1725387697;
 bh=ZX6axD+oXcLLz2CuEGMGfBzxHwXeAIAlu4qav3t+kfk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YOevt+JORoelOAcvHa/ECPfS7ObRLFFanAwKgSQnpsMbJbO6UkV9Sm8O/QIY5U+Wb
 dysG3IYtjp0V+qXyGxK7KnPP4j2iPctJxUpiQTaIpKAoAA4PPgjC1mY1b6dDYzVJLD
 yusn+ehqH+/ugIF0V5vBHXWuXuhtjx3lLhbSMOuymUo6TKZ3mjuyPpM/LsjI4AGddb
 Oxw+4TF86hF1F6ZJZCetlt2OxWp5OXl4C9nctWQow/tWOPHJyzT+vspq7Wb/GwmG1D
 ndUrKHE8IsKeby7iNzG5TPNVfiVelS2MdCuc6iLaXbBH0iXdi3w68WuHjhcyB1FTy/
 K8RM8B5pO+IQw==
Received: from jupiter.universe (dyndsl-091-248-190-124.ewe-ip-backbone.de
 [91.248.190.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id D26E817E121F;
 Tue,  3 Sep 2024 20:21:36 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id 7EC654800F6; Tue, 03 Sep 2024 20:21:36 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v5 3/6] board: rock5b-rk3588: enable USB-C in operating system
Date: Tue,  3 Sep 2024 20:16:55 +0200
Message-ID: <20240903182136.153196-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240903182136.153196-1-sebastian.reichel@collabora.com>
References: <20240903182136.153196-1-sebastian.reichel@collabora.com>
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

