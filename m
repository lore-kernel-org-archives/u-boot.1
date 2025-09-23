Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CC0CAC5A5
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 18:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E40CF80C93;
	Tue, 23 Sep 2025 20:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Edkfq4bO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92DF982ADA; Tue, 23 Sep 2025 20:13:14 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5124080107
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 20:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-77e87003967so2293085b3a.1
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 11:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758651191; x=1759255991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EkJQHOxeEDHGGq/Rm8DxmTfFEM+NKKfGCoxvqqi++S8=;
 b=Edkfq4bOuc43rCfxK/aG4LE+otUc3XnRWqw0F/2rlwwHsJnNwPRA9yFvZIojgzgE0I
 bO5Wk63BQFkk56iegx1Hl+kU9BzFlDYjuaXUwBdMLPITNBhfaEVprdbw6uN0TSiIgdjD
 LAdA0zhxDjo4REVSHD+6ZbOH4dvdQtC9HWZPXzZT6o+E7M+lJu9c0oiqT63FU/bWcLeF
 HN/CMjzIuGpxKcjlv8xqbZg04rcfyZgZ/KKtaN6ppLiz0wJqUY5iA6zwQidOTkOXoWdl
 rCRbz6n34Nx0yoPg/rFNYNOtdMYGzJ8HS5wK91XeGzNKGsTsyVDuBgrtQ5UtHOwH579h
 8M/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758651191; x=1759255991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EkJQHOxeEDHGGq/Rm8DxmTfFEM+NKKfGCoxvqqi++S8=;
 b=Lyx4huoGzrxRu54Kq5WDrzLQzdSGb01HWqoMS28wP2PEIyJf7WpJyaUuwfxGKKnq+s
 2S5TWfkAUlU+DCDtfWNfjKU+d/MBMRXkV/bzj3n5khHZuBcUl3X8QLpkTiHRwrV+/JwC
 KI6X4DBmgoSuBGUOZMCO1NOByvS/sIsuAYgc7psTvjQV3uq1X3+T6BQKoKsJYyzTh2oS
 XgZjLBLH7bO3tDBy/63uaNibDTO4yUCTKN/xmwDj7Nv6Hew0LCVJf6O3DTyX/3z5KKFc
 h2STFqNOzLAHh8/skA8GtH/f2v5iTxGceEyJ2UDleLkc67IwvS+jpWhO7FCnASynDaMJ
 UzLQ==
X-Gm-Message-State: AOJu0YzM32qrkgrDfZakAE6NZDTmVnd5qhVF60zArbsrhXtW9239ly94
 UZ4RF4/JnNsd+v53UJenJpREqaOJZQ4UKDnmO4oZbhwmdlDry82hvyIDnsArG9y3mpM=
X-Gm-Gg: ASbGncsyppqhleJERl515R1UNRgM3IEXoQLbNCy7AOFo0ZG5FR/sN6P5D9+Uey2oV+O
 iF8EGJmIBdnNtB2o8Q1Z2uT+4qztDb0raXLTizon0ZeUjdJvBKEs7b6DWuTtflmgt0PODAlv5g5
 VfsQzWouAW7MHoZlV87PxFG92CFfjRd1Z0O4MoJ7xNG2W84lMDZzwW0GFIqxL2sdfdkkJnD00wU
 k9VEew4PDXDfSRSOXcx24EZS/3erRRMqUsG0NwZ2ACRRTfshVw0lnENKujULpjfuZDNRCjqzaUy
 KqoQLX+IEy1wwMeJiIYfIx51+2dkN2CBNzSCcpwcF2j5iWQqm6SLN+zxGksL/4AQjPu1BYWrEpC
 e5OUd5Ed09rjgjHm9AUajkYdHXMSDpZGBogNFvoUE2TCBhZA2
X-Google-Smtp-Source: AGHT+IG95u4NhdBxQOhDfHOSx4zAILEpKXvQmRwMGKhRBpqs4YJlXNBHYBgq6s6sQOBia54lMKWx1A==
X-Received: by 2002:a05:6a20:6a04:b0:2be:cb6d:b136 with SMTP id
 adf61e73a8af0-2cfda0b0d8emr4888513637.22.1758651190511; 
 Tue, 23 Sep 2025 11:13:10 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.76])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77d8c3adfd4sm15284487b3a.82.2025.09.23.11.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 11:13:10 -0700 (PDT)
From: briansune <briansune@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, quentin.schulz@cherry.de,
 briansune <briansune@gmail.com>
Subject: [PATCH v2] cmd/dma: implement dmareset command
Date: Wed, 24 Sep 2025 02:12:54 +0800
Message-ID: <20250923181254.830-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
In-Reply-To: <20250913163913.395-1-briansune@gmail.com>
References: <20250913163913.395-1-briansune@gmail.com>
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

This adds a new U-Boot command 'c5_pl330_dma' for Cyclone V SoCDK
boards. It provides access to the Reset Manager's Per2ModRst register
to release the reset for ARM PrimeCell PL330 DMA channels. This allows
software to initialize and use the PL330 DMA controller properly after
reset.

Signed-off-by: Brian Sune <briansune@gmail.com>
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

