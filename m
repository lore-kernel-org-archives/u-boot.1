Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866D4CD5BCC
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 15:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA19F88CC4;
	Thu,  5 Sep 2024 17:17:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OlVGM1CY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 818FF88CD1; Thu,  5 Sep 2024 17:17:10 +0200 (CEST)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EA7A88C91
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 17:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sebastian.reichel@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1725549428;
 bh=MaX9knvNNlkcoU7y63UAKlXcI2FWJjBx6Z541dTO9i4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OlVGM1CYARH8jR7hX1JCyzjLoOvYonq4dVpddV7tqHKv1GFwV9kFs0BQ4idvjHy/T
 8dmf8Dp7LkEStFeQOeVF3FgD3kjcRIYq3a5QWQFKwba/sLcp1VQ7mycHrCP+uN1RoX
 /uKEccUu41G7R4ERpXHJ6QrLVyWLcW1x86YZPE/mq17AETdmUfj2OUO/vCeoZ4lpvg
 zTniAnbJTy/4BLPaDtK760efy5eYghMStjR8BfjQNKUWA1h2UAW5anloE/cgSsgWjT
 m9wxvIxG3UqPf1YKEMUUgxOAyu/gjKrdK4rCKEY/ox+UAyg1Q2EQaHWm50UFUlNLjj
 q0jLt7uyLlMvg==
Received: from jupiter.universe (dyndsl-091-248-189-231.ewe-ip-backbone.de
 [91.248.189.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sre)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EDB4F17E145D;
 Thu,  5 Sep 2024 17:17:07 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
 id A34D14800F6; Thu, 05 Sep 2024 17:17:07 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Soeren Moch <smoch@web.de>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH v6 3/6] board: rock5b-rk3588: enable USB-C in operating system
Date: Thu,  5 Sep 2024 17:08:39 +0200
Message-ID: <20240905151707.59101-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240905151707.59101-1-sebastian.reichel@collabora.com>
References: <20240905151707.59101-1-sebastian.reichel@collabora.com>
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

