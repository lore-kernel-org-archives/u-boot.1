Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC97CAC587
	for <u-boot@archiver.kernel.org>; Sun, 14 Sep 2025 13:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5CE981E13;
	Sun, 14 Sep 2025 15:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KuB+LmeY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65DA983043; Sat, 13 Sep 2025 18:39:34 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 160FB82AE1
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 18:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7761b392d50so1701835b3a.0
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757781570; x=1758386370; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mlFir9Yk02C6sbtGyqDzDAhQRzKklGr/tmCxz+XzNrQ=;
 b=KuB+LmeY8XQ3JMqDMQKFOSr9CLP4mCQi4HqEBwGfRGwFmjpV9Pj1MiUvhDVDROQ2v3
 SNCT4WfzVg3j/IK1uXu1saYD0gkSsUEsVdddchNGVCjHHG53zrIFKopZnuuEsvPQm6ET
 RLqn2t1BjQv/ehxb9LY4CyZrb/sK7lzGFYcsCGDAx2dhceNV8DeQL82OW0sBv9B4uzaS
 K5FcUWOdJlu0yMKl617xfktOPQ9EAdgcHXTteY2JGi1T3yx89LezKsX5ggfPf8KZxDOX
 jmtpuLEd67mWheHQ8H/0t88gUmLMNU1G6gQoWQBhtd2ghl+Kg/zE7Qe2YQ7aGh9oYvD0
 p4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757781570; x=1758386370;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mlFir9Yk02C6sbtGyqDzDAhQRzKklGr/tmCxz+XzNrQ=;
 b=tZgbrQnoN4nKYpO5jJLoPmKZeqpSoK2k5AcWjcSgWZ0GVBHWWVeLE2IVTRRmkoEEjK
 SCcc7TwMd6D0H8EDmTPjXENFchQDxxj9qF2c9nIRd9F3xVA5FRK6HS9jqBEGw5o25ir6
 AzBrCcVxtBe1c40mcLg8+yZsE5bVYPklY36kJK3pbO2YP2tTlrbXCrBAl5auMWDG66Kp
 zmP+8yHx9+taweOpclGMoWI7vcPgwZeu9NP6LlEsIAC+VjKn5mDwwpjuO2NLJsQ4lavq
 3sObUoD9fn/LqFMZWjicwsWP4pAOQUPGkbjYkRYcAUaU/3vKSvIjDc8KBaGjGN0b46Fp
 BB8A==
X-Gm-Message-State: AOJu0Yzb5t5fOfZsQ0fHBFkKXIbBXBbv02XCHzVQvTXwbNsNeU8WhOTB
 1g/icwE/uDZ+SWL/I3wo+BQ7PimBW4hc6emkghmWpbKy9ClBlj4fDxpNrqCrHlaR
X-Gm-Gg: ASbGncsRi2xnMSiXkrc8qRd4ojdf8UX5uPUnV5Ugif/HsGqCwT05X/dz98x2EiScYdT
 QjSBckyoDk7Y3vCbkSUXJ5DLTTUQQAfUlwFDfql8lKPPqwjFAUWd4tLTwhOkwOUDXcCqZS5riwC
 3iau+BXkWctmByiVoFbYqs8qHIOHCWw/zmMlg/uaZN5fJt4z6HxlqpNtKzgRE9iZSSi4RPusRuY
 mTc9GIA2FUuPWlWYc8b0QhH5mT2bP4SedxASroHVH+deY4o9mN405y222AxociHJygjY7LvN5Jz
 P041lExKUMbPaawhlcYEcHxKKu4h1jenUReSG8GK8zamFpUthb4illZMlZOHgl7CemubeJ357oY
 uW0ogPjoEjZAbbKIC/ahOig3Y5JV9JkyPIA6k1FoC4ZaaQQWaEyQGI76nlpQ+
X-Google-Smtp-Source: AGHT+IGOjSf91mgP5fBBn04H9MW66EsCg9NOIPBcwwAuR8NmexF8XjwEf0kEmQ/Li/usKTMx4+Fttg==
X-Received: by 2002:a05:6a00:2d22:b0:772:6f95:f326 with SMTP id
 d2e1a72fcca58-7761209531cmr7302432b3a.10.1757781570233; 
 Sat, 13 Sep 2025 09:39:30 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.147])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77607a47d7fsm8804270b3a.31.2025.09.13.09.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 09:39:29 -0700 (PDT)
From: briansune <briansune@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	briansune <briansune@gmail.com>
Subject: [PATCH] cmd/dma: fix generic naming, spacing, and Dependencies
Date: Sun, 14 Sep 2025 00:39:13 +0800
Message-ID: <20250913163913.395-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 14 Sep 2025 15:13:36 +0200
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

This adds a new U-Boot command 'c5_pl330_dma' for Cyclone V SoCDK
boards. It provides access to the Reset Manager's Per2ModRst register
to release the reset for ARM PrimeCell PL330 DMA channels. This allows
software to initialize and use the PL330 DMA controller properly after
reset.

Signed-off-by: briansune <briansune@gmail.com>
---
 cmd/4913           |  0
 cmd/5036           |  0
 cmd/Kconfig        |  9 +++++++++
 cmd/Makefile       |  1 +
 cmd/c5_pl330_dma.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 60 insertions(+)
 create mode 100644 cmd/4913
 create mode 100644 cmd/5036
 create mode 100644 cmd/c5_pl330_dma.c

diff --git a/cmd/4913 b/cmd/4913
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/cmd/5036 b/cmd/5036
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 29de857ba7c..75c388d19da 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1791,6 +1791,15 @@ endmenu
 
 menu "Shell scripting commands"
 
+if TARGET_SOCFPGA_CYCLONE5_SOCDK
+
+config CMD_C5_PL330_DMA
+	bool "Release Reset DMA Channels for PL330 Handshake"
+	help
+	  Provides access to Reset Manager Per2ModRst. Enables DMA
+	  channels for ARM PrimeCell PL330 via reset release.
+endif
+
 config CMD_CAT
 	bool "cat"
 	help
diff --git a/cmd/Makefile b/cmd/Makefile
index 36e79cc3c28..d16e6fae20a 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_CMD_BOOTI) += booti.o
 obj-$(CONFIG_CMD_BTRFS) += btrfs.o
 obj-$(CONFIG_CMD_BUTTON) += button.o
 obj-$(CONFIG_CMD_CAT) += cat.o
+obj-$(CONFIG_CMD_C5_PL330_DMA) += c5_pl330_dma.o
 obj-$(CONFIG_CMD_CACHE) += cache.o
 obj-$(CONFIG_CMD_CBFS) += cbfs.o
 obj-$(CONFIG_CMD_CEDIT) += cedit.o
diff --git a/cmd/c5_pl330_dma.c b/cmd/c5_pl330_dma.c
new file mode 100644
index 00000000000..5267ea2bd44
--- /dev/null
+++ b/cmd/c5_pl330_dma.c
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Brian Sune <briansune@gmail.com>
+ */
+
+#include <vsprintf.h>
+#include <command.h>
+#include <asm/io.h>
+
+#include <asm/arch/base_addr_ac5.h>
+
+#define RSTMGR_PERMODRST 0x18   /* PERMODRST register offset */
+
+static int do_dmareset(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char * const argv[])
+{
+	u8 val;
+	int i, ch;
+
+	if (argc < 2) {
+		printf("Usage: dmareset <channel 0-7> [<channel 0-7> ...]\n");
+		return CMD_RET_USAGE;
+	}
+
+	/* Read current register value */
+	val = readb(SOCFPGA_RSTMGR_ADDRESS + RSTMGR_PERMODRST);
+
+	/* Iterate over all channels given as arguments */
+	for (i = 1; i < argc; i++) {
+		ch = simple_strtoul(argv[i], NULL, 0);
+		if (ch < 0 || ch > 7) {
+			printf("Error: channel must be 0-7\n");
+			return CMD_RET_USAGE;
+		}
+		val &= ~(1 << ch);
+		printf("PL330 DMA channel %d reset released\n", ch);
+	}
+
+	/* Write back */
+	writeb(val, (SOCFPGA_RSTMGR_ADDRESS + RSTMGR_PERMODRST));
+
+	return 0;
+}
+
+U_BOOT_CMD(
+	dmareset, 8, 0, do_dmareset,
+	"Release PL330 DMA channel reset(s) for SoCFPGA",
+	"dmareset <channel 0-7> [<channel 0-7> ...]  - release reset for one or more DMA channels"
+);
+
-- 
2.47.1.windows.1

