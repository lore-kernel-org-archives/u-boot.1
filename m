Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396DACA1002
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 13:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8288E83A03;
	Mon,  1 Sep 2025 15:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JWkW3UPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F32F83447; Mon,  1 Sep 2025 00:25:21 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D486583192
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 00:25:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-323267bc2eeso2874914a91.1
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756679117; x=1757283917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q9/dLZXRwtBo1Na9veKnVuPWLAIpHg7Hkgs1VxB8ifs=;
 b=JWkW3UPUJFEyFoUnfvb6IyWoJ/mu+WiH3SQxkWQ09i5gMQTByNBJ7Lz7sdWgWxwNwI
 QMtqvh+UqEdjM1THjS5miDnpNdCrIhrsU6xktwaYqFVeAIJn57v953KevM1KHZgsHn/m
 l3MwFzkwfDRV8yQnKJQvu7cTeZ/XOf2TUlaxRPkQP4btomyEftg5SQDkjtVYOyJEBpet
 PLeE0mDjRKsGEDHspiSYjiuvYwmx2eGflcC6Wj7WFFa6+QV8GjysrCxU2XwEBCTnjCB2
 RpcyjM6FRBrbW/QnWa7phNFyHNkSF8TiRFPbxbjJUVT3y019NSNr7kuD45ob1Da7nA4p
 1tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756679117; x=1757283917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q9/dLZXRwtBo1Na9veKnVuPWLAIpHg7Hkgs1VxB8ifs=;
 b=KDMQ2iYlvB07vSxCZD/SvDN0q+FAttProkw/ETn+DilJOPTIYvMimgYXpIdXosk/lF
 GJqVsg3TRR0r9xWZvvJ0f478RkiMYN0KMRnwJJyQ3rdAzeHz947j1dkIocT6loHhWSQo
 hCeFD/tTeaUnSdX2klGctR+jGTWyChc5ikBOXMyDyhM4VViQj7cNau2ehVjgRnsJkUIk
 vHR9gEXA67Oo2maQe9pCOu1KEC24d8o1ndPexn8MbGHP7sy9aklk6gqMymxKkgVedj1u
 FmpHSKSPGOVPn6Os2a55tMs9UQR1gZ03z5xFT0c8rv3S8E52ImzWQe9hWa57sIQBP5eM
 d8ZQ==
X-Gm-Message-State: AOJu0Yx0LpDdHwOK+jMg2lL3QZDDZ0kmEhLMhQqLT4wVPTZ4ten4GknP
 m2aKcsYiQ5k11NpYbvjbL7zsZFBDU2TPofpASoLLxXDUHru4bT6YICACSQQUDx5s4pA=
X-Gm-Gg: ASbGncvNSEVDnVd5KO/LmvO2inlwkOQjTXYDlYhiE9G2HH4poOx7Xlco7JcfjGYcWgq
 ubsGW009i4DH9SYx2ZXfGb0ZkTiEcsgKVlSnQcdMwpTxmiMpZMfkMQqmeUMXWTtGDgcc9d76vO0
 6TpteMzKzo2rlnGfAZl5wxg3j3ZIl+C2nX5j5dYDmu2lF2tROsO60KLCQ3/7QjhKB78x/Nfwzkq
 tQ80B7K3d12ImPtdHfnHxuASx6KNBzXavKTLNZ9YXB3MnfFyM1Lp9CQRnk8jLwAPhm4wXbxhTqp
 NqUnFSR6mYbcfN/hPdl+kiFw7lwhfG0/iCOitghW7JzCecyAdXdh3v7ZupennDOGqoKNs0Pv1hu
 RMbqAybN9A2ZQ3oY3x3DMTFSVkZMUasgNjGejbQu//vU49y7w
X-Google-Smtp-Source: AGHT+IH5xV3fkSEC/ZMXC3Fe9LKO9a9h4/dYC7Q0XUwy++CDS9vbKvmHHqYqIWQQqmDomkwgV9n+aA==
X-Received: by 2002:a17:90b:4c0c:b0:327:d8e1:faea with SMTP id
 98e67ed59e1d1-328156b6373mr9478759a91.20.1756679116969; 
 Sun, 31 Aug 2025 15:25:16 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.67])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeec547sm9195929a91.28.2025.08.31.15.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 15:25:16 -0700 (PDT)
From: briansune <briansune@gmail.com>
To: u-boot@lists.denx.de
Cc: briansune <briansune@gmail.com>
Subject: [PATCH] cmd/dma: implement dmareset command
Date: Mon,  1 Sep 2025 06:25:01 +0800
Message-ID: <20250831222501.2045-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 01 Sep 2025 15:15:28 +0200
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

Add dmareset command to release PL330 DMA channel resets.

Signed-off-by: briansune <briansune@gmail.com>
---
 cmd/Kconfig  |  7 +++++++
 cmd/Makefile |  1 +
 cmd/dma.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)
 create mode 100644 cmd/dma.c

diff --git a/cmd/Kconfig b/cmd/Kconfig
index e55a48a49af..720e3121018 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1149,6 +1149,13 @@ config CMD_DM
 	  can be useful to see the state of driver model for debugging or
 	  interest.
 
+config CMD_DMA
+	bool "dma - Release Reset DMA Channels for PL330 Handshake"
+	default y
+	help
+	  Provides access to Reset Manager Per2ModRst. Enables DMA
+	  channels for ARM PrimeCell PL330 via reset release.
+
 config CMD_FASTBOOT
 	bool "fastboot - Android fastboot support"
 	depends on FASTBOOT
diff --git a/cmd/Makefile b/cmd/Makefile
index 082470fa104..748c53767b8 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_CMD_CPU) += cpu.o
 obj-$(CONFIG_CMD_DATE) += date.o
 obj-$(CONFIG_CMD_DEMO) += demo.o
 obj-$(CONFIG_CMD_DM) += dm.o
+obj-$(CONFIG_CMD_DMA) += dma.o
 obj-$(CONFIG_CMD_UFETCH) += ufetch.o
 obj-$(CONFIG_CMD_SOUND) += sound.o
 ifdef CONFIG_POST
diff --git a/cmd/dma.c b/cmd/dma.c
new file mode 100644
index 00000000000..b35c2f32fcc
--- /dev/null
+++ b/cmd/dma.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Brian Sune <briansune@gmail.com>
+ */
+
+#include <vsprintf.h>
+#include <command.h>
+#include <asm/io.h>
+
+#ifdef CONFIG_TARGET_SOCFPGA_GEN5
+#include <asm/arch/base_addr_ac5.h>
+#endif
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
+	"Release PL330 DMA channel reset(s)",
+	"dmareset <channel 0-7> [<channel 0-7> ...]  - release reset for one or more DMA channels"
+);
+
-- 
2.47.1.windows.1

