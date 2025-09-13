Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FBFCAC587
	for <u-boot@archiver.kernel.org>; Sat, 13 Sep 2025 13:30:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D4E82AE1;
	Sat, 13 Sep 2025 15:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IOdhlQdm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73FB3833EB; Sat, 13 Sep 2025 10:04:55 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E99A82AE1
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 10:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-24c89867a17so26673335ad.1
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 01:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757750691; x=1758355491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NjMbXIKvs/Lakqn/XEledI3vKSZB0dglI1Hid+LyrnE=;
 b=IOdhlQdm7iW+e5cMo56/c8/HRlHvPwAOFyBonuRCUmLw3bpymosafrvklazQsBW4Ty
 AvE9aj67uyAQ6RO4uUWEgsl0kGLLuApm2r/g0TQlIzzTzZ9EHlcR8Sd6nHWmYlfuyBLq
 fhojBnw7hBBeD+t5tXCa7HQ75AZpTsvalngJmaHpSv4A3EHZRf6AlpFjIz9DTg3ioIGx
 1nsEXFAfZ4djquTP6APQFw14StrS43DG+rjpQPqsCjxatt8yhO8Y5iPLiXpFdsP/A4sN
 Z/dYXqyv51wKNbnBfxFixhlR0VI7Hckwi4ABS/ClUdmgo4hnp7Evdxwd5Yy8HTcftQrc
 4vMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757750691; x=1758355491;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NjMbXIKvs/Lakqn/XEledI3vKSZB0dglI1Hid+LyrnE=;
 b=TY8s7q691kM8nP660hf9CKnQKpbxH4AP1NLL3eaNZpq8KZWnmVBPW6e9pT4+686hHZ
 642ETL2LuW4xb4FTiGirXEpf4E2cqNWFBwG37KJRa4UP2kjb7rGKWi4RdSsoJkrR+Es6
 x3MDRO0Y1alt4zshBMnqn/lW8rYq3xv1yhWTIjA2RVhHJq40mb15eitO4GqdV/3oDO/z
 6j17pis4oom5APa8Sp6v1bXM4yW0A8b5/oJF1Tl7WEJ3RyGtqlSA/P5d9HHl9qLr7bpB
 mzauUthEXzRns6N8H9fDsMK9G+Ga3fR05EOruKC8gV+FBo2f6anPdOOVAAi/TYwtFCy9
 BT1A==
X-Gm-Message-State: AOJu0YwflRMAdx+aaDij7dGxanCpCyiFzFW0XQy1RoytFlMVnFV3DWd6
 O7TBwSDH54yx4emLQSkNE1z9zohJ0ynELz8skpRQFjGleCgG0x7Z4thogiLGBrfs
X-Gm-Gg: ASbGncuPIQal/WRSp4sra9KtCz5pkR1EddVmg+eWYWhC6uii222g6dQuCa/scop9ylF
 hWieXLYUIX4E52i4fVua061HC3dndn2Sw9o7OmQo3s2N8UWAEu7kwoA/mYgKP1ba6+RMZZCtd1B
 REoVTdpy8AnYLANSgJjbYs9Uf7PABM0iZVPofvMhkQseMKXiBypgAqi+53EoBSXDHEjWJd9HM3d
 V7XR6hX0SdQpYlUdihGadjSK/hJv4jQ3efLa3rxao4BSFuGX70mmhtoYPslrcCsBzJjtpaB8yyN
 NbvKwVCYWh7cjkf8LHm2WLgUd/2qMmCc7yo1opu3C8pz4BlqnlX/InUwQUosFTZ18MkMQfSnFMz
 tji6gUiloXI0MU2T1FeuL2yrWPat3oPfoIOUw8tc+FfvQyJTP/vw1x7F2wXx9
X-Google-Smtp-Source: AGHT+IGI87BuCDms0922stXOSDcuAaxeVQ+4y2qgVLrypmknrQ2abl7+RC4lS8OfldAFA9MvK2kdog==
X-Received: by 2002:a17:902:ec8e:b0:25d:d848:1cca with SMTP id
 d9443c01a7336-25dd8481fbdmr60634215ad.35.1757750691399; 
 Sat, 13 Sep 2025 01:04:51 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-26175efc667sm10409095ad.112.2025.09.13.01.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:04:51 -0700 (PDT)
From: briansune <briansune@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	briansune <briansune@gmail.com>
Subject: [PATCH] cmd/dma: fix generic naming, spacing, and Dependencies
Date: Sat, 13 Sep 2025 16:04:14 +0800
Message-ID: <20250913080414.1687-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 13 Sep 2025 15:30:54 +0200
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

Tested-by: Sune Brian <briansune@gmail.com>
Tested on: Cyclone V SoCDK

Signed-off-by: briansune <briansune@gmail.com>
---
 cmd/Kconfig        |  9 +++++++++
 cmd/Makefile       |  1 +
 cmd/c5_pl330_dma.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 cmd/c5_pl330_dma.c

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
index 00000000000..53bd7a44b7e
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
+	char * const argv[])
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

