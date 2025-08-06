Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58370C87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 22:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 322E083B23;
	Thu,  7 Aug 2025 00:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hmm0VgTb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D565183457; Thu,  7 Aug 2025 00:27:34 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8401483981
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 00:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-61b6ee10b94so253887eaf.2
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 15:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754519234; x=1755124034; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QVyPqyG30Q7COjhRWwAhpcI31Om13IiSdf7p6svsac=;
 b=hmm0VgTbKE+aWv7qgzIfBqDi20ROgEUyamAafY9RDwTnbqZiJedGVbRVLohr/8+N23
 n719itLuYteLp57fd955eczBQgVIXC49iGq1tay6ff+lv7XM9Z/+ZbhbpTHklTwdr8F6
 WStOocsWcXnsbjaGJim3Kpe3UyakRBQvP93/1R4JdxVoHwNPuPERAQ8wId+J/ixrGEfc
 J3V68qn9fuuOKZKhX9+6wmdM92aJPKnWFVSgjd4HG2VzPZ/bZ9AS0KzC7mh3Hs8nd33f
 UiurBuBz/KRAQmPEdWTGHq1JejSB/tZPFQl7spldh676iWn0HGw/MeG8imM+yI9yOr8O
 t9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754519234; x=1755124034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7QVyPqyG30Q7COjhRWwAhpcI31Om13IiSdf7p6svsac=;
 b=PtMkKg8u6+osjOY21PttcTQvvBkoh10DxHeWD5xYT/aw3Af+2l0i/vs6/8AlY9f6Md
 eaOQfdKzrWKDC8e48PtheqEIdBYLNwQAhWbYx2stCXdPIDxCFf657Hl+R3pqVUMKb7QZ
 X08Wf42rxRn/TwA2c7TEuL3jE12onvdsVnypBPpp0NHc5Wk/1ugeYtRl/j0OTWmc7P/V
 YPadQbEJ1bZzgA6wT3NEovc+98xEJOhDfzF2beKsHlzMp/epfhneoQZWaen3pHDneir3
 h8YAzTfwVovxyktmJ3hUusL5Yq0h0CX5wyRviiMCwk1LLLPppQEJ9IktZ35qxgzo7GOr
 IIsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYBcOh7U6zkRB3aSftLUMKhoJL+4r4bJ+XD8Tima8N2WnyQOL8LTB9YAfYhSJvAVtIBxVvKgc=@lists.denx.de
X-Gm-Message-State: AOJu0YyYDfPisdgzTQcgx/vX4gVz9vi57crEbB9pf3nqX1H9Ek3LoQSZ
 jdNayrw7E4Vtt8uBYc4B60HMp7lqCNOSPxkCfHkeKNNnO2ie0ZUgkgNUjKpqFAw+/8g=
X-Gm-Gg: ASbGncuK3yDWhEE857kbqbs6X3Q8y4lkfC7dD/ca4kZno/mpjO16AXweL51RopuklGZ
 QU8kew9ceSVlilABkAImWYNEfLPtKvTtrd41WhyWVMvUZLZDjcm5F0DdvGpi+ihf9/hRVWMCzGS
 PLFh3BAQe3i+AkBla6j+CpgSXqbYKMdB5xD2pU4ar4nBvgQmqeCkhjSwzeVXrhAIw27lLer+0wp
 aky4hwSM3ItxC1k1RZA3gTEGkrCZdAj1jDVZzx5QSROte/rMZdotcLRoC3mdNCKHm7IvgLgrpSG
 xekRAKYHi+BtIYzMxyt/cuBCj1zKYKWh1zNtkEnImEPntmecSrcDYJweJc7HWyCNvWRwDH5FAsc
 6dRx59emG8RiI6eup6BBNLmcdmw==
X-Google-Smtp-Source: AGHT+IG/aS+t1mJlE1jMOR2lFk71VlczaswUyHu53FRpw/MwObo9C56GkccJUdlUC44IM76OcrR2vA==
X-Received: by 2002:a05:6870:20b:b0:30b:abec:23ff with SMTP id
 586e51a60fabf-30c01b8c5d0mr723763fac.33.1754519234241; 
 Wed, 06 Aug 2025 15:27:14 -0700 (PDT)
Received: from localhost ([136.49.61.16]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm2540030a34.30.2025.08.06.15.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 15:27:13 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 03/10] board: samsung: e850-96: Add ACPM code
Date: Wed,  6 Aug 2025 17:27:03 -0500
Message-Id: <20250806222710.23773-4-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250806222710.23773-1-semen.protsenko@linaro.org>
References: <20250806222710.23773-1-semen.protsenko@linaro.org>
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

Add functions to access I3C bus via APM (Active Power Management) core
by using ACPM IPC protocol. It will be further used for configuring PMIC
chip voltage regulators.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/Makefile |   2 +-
 board/samsung/e850-96/acpm.c   | 169 +++++++++++++++++++++++++++++++++
 board/samsung/e850-96/acpm.h   |  27 ++++++
 3 files changed, 197 insertions(+), 1 deletion(-)
 create mode 100644 board/samsung/e850-96/acpm.c
 create mode 100644 board/samsung/e850-96/acpm.h

diff --git a/board/samsung/e850-96/Makefile b/board/samsung/e850-96/Makefile
index 71d46ea3d2b4..08eb8dca5bf7 100644
--- a/board/samsung/e850-96/Makefile
+++ b/board/samsung/e850-96/Makefile
@@ -3,4 +3,4 @@
 # Copyright (C) 2024, Linaro Limited
 # Sam Protsenko <semen.protsenko@linaro.org>
 
-obj-y	:= e850-96.o fw.o
+obj-y := e850-96.o fw.o acpm.o
diff --git a/board/samsung/e850-96/acpm.c b/board/samsung/e850-96/acpm.c
new file mode 100644
index 000000000000..1cc5c6d0e4a3
--- /dev/null
+++ b/board/samsung/e850-96/acpm.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025 Linaro Ltd.
+ * Author: Sam Protsenko <semen.protsenko@linaro.org>
+ *
+ * ACPM (Active Clock and Power Management) is an IPC protocol for communicating
+ * with APM (Active Power Management) core. The message exchange between AP
+ * (Application Processor) and APM is happening by using shared memory in SRAM
+ * (iRAM) and generating interrupts using Mailbox block. By using this IPC
+ * interface it's possible to offload power management tasks to APM core, which
+ * acts as a supervisor for CPU. One of the main tasks of APM is controlling
+ * PMIC chip over I3C bus. So in order to access PMIC chip registers it's
+ * recommended to do so by sending corresponding commands to APM via ACPM IPC
+ * protocol. The IPC interaction sequence looks like this:
+ *
+ *     AP (CPU) <-> ACPM IPC (Mailbox + SRAM) <-> APM <-> I3C <-> PMIC
+ *
+ * This file contains functions for accessing I3C bus via APM block using
+ * ACPM IPC.
+ */
+
+#include <linux/iopoll.h>
+#include <linux/time.h>
+#include <asm/io.h>
+#include "acpm.h"
+
+/* Mailbox registers */
+#define MBOX_INTGR0			0x8	/* Interrupt Generation */
+#define MBOX_INTCR1			0x20	/* Interrupt Clear */
+#define MBOX_INTSR1			0x28	/* Interrupt Status */
+#define MBOX_INTGR_OFFSET		16
+#define MBOX_TIMEOUT			(1 * USEC_PER_SEC)
+
+/* APM shared memory registers */
+#define SHMEM_SR0			0x0
+#define SHMEM_SR1			0x4
+#define SHMEM_SR2			0x8
+#define SHMEM_SR3			0xc
+
+/* IPC functions */
+#define IPC_FUNC_READ			0x0
+#define IPC_FUNC_WRITE			0x1
+/* Command 0 shifts and masks */
+#define IPC_REG_SHIFT			0
+#define IPC_REG_MASK			0xff
+#define IPC_TYPE_SHIFT			8
+#define IPC_TYPE_MASK			0xf
+#define IPC_CHANNEL_SHIFT		12
+#define IPC_CHANNEL_MASK		0xf
+/* Command 1 shifts and masks */
+#define IPC_FUNC_SHIFT			0
+#define IPC_FUNC_MASK			0xff
+#define IPC_WRITE_VAL_SHIFT		8
+#define IPC_WRITE_VAL_MASK		0xff
+/* Command 3 shifts and masks */
+#define IPC_DEST_SHIFT			8
+#define IPC_DEST_MASK			0xff
+#define IPC_RETURN_SHIFT		24
+#define IPC_RETURN_MASK			0xff
+
+/**
+ * acpm_ipc_send_data_async() - Send data to I3C block over ACPM IPC
+ * @acpm: ACPM data
+ * @cmd0: Command 0 value to send
+ * @cmd1: Command 1 value to send
+ */
+static void acpm_ipc_send_data_async(struct acpm *acpm, u32 cmd0, u32 cmd1)
+{
+	u32 irq_bit = 1 << acpm->ipc_ch;
+	u32 intgr = irq_bit << MBOX_INTGR_OFFSET;
+
+	/* Write data to the shared memory */
+	writel(cmd0, acpm->sram_base + SHMEM_SR0);
+	writel(cmd1, acpm->sram_base + SHMEM_SR1);
+	dsb();
+
+	/* Generate interrupt for I3C block */
+	writel(intgr, acpm->mbox_base + MBOX_INTGR0);
+}
+
+/**
+ * acpm_ipc_wait_resp() - Read response data from I3C block over ACPM IPC
+ * @acpm: ACPM data
+ * @cmd2: Will contain read value for command 2
+ * @cmd3: Will contain read value for command 3
+ *
+ * Return: 0 on success or negative value on error.
+ */
+static int acpm_ipc_wait_resp(struct acpm *acpm, u32 *cmd2, u32 *cmd3)
+{
+	u32 irq_bit = 1 << acpm->ipc_ch;
+	u32 reg;
+	int ret;
+
+	/* Wait for the interrupt from I3C block */
+	ret = readl_poll_timeout(acpm->mbox_base + MBOX_INTSR1, reg,
+				 reg & irq_bit, MBOX_TIMEOUT);
+	if (ret < 0)
+		return ret;
+
+	/* Clear the interrupt */
+	writel(irq_bit, acpm->mbox_base + MBOX_INTCR1);
+
+	/* Read data from the shared memory */
+	*cmd2 = readl(acpm->sram_base + SHMEM_SR2);
+	*cmd3 = readl(acpm->sram_base + SHMEM_SR3);
+
+	return 0;
+}
+
+/**
+ * acpm_i3c_read() - Read an I3C register of some I3C slave device
+ * @acpm: ACPM data
+ * @ch: I3C channel (bus) number (0-15)
+ * @addr: I3C address of slave device (0-15)
+ * @reg: Address of I3C register in the slave device to read from
+ * @val: Will contain the read value
+ *
+ * Return: 0 on success or non-zero code on error (may be positive).
+ */
+int acpm_i3c_read(struct acpm *acpm, u8 ch, u8 addr, u8 reg, u8 *val)
+{
+	u32 cmd[4] = { 0 };
+	u8 ret;
+
+	cmd[0] = (ch & IPC_CHANNEL_MASK) << IPC_CHANNEL_SHIFT |
+		 (addr & IPC_TYPE_MASK) << IPC_TYPE_SHIFT |
+		 (reg & IPC_REG_MASK) << IPC_REG_SHIFT;
+	cmd[1] = IPC_FUNC_READ << IPC_FUNC_SHIFT;
+
+	acpm_ipc_send_data_async(acpm, cmd[0], cmd[1]);
+	ret = acpm_ipc_wait_resp(acpm, &cmd[2], &cmd[3]);
+	if (ret)
+		return ret;
+
+	*val = (cmd[3] >> IPC_DEST_SHIFT) & IPC_DEST_MASK;
+	ret = (cmd[3] >> IPC_RETURN_SHIFT) & IPC_RETURN_MASK;
+	return ret;
+}
+
+/**
+ * acpm_i3c_write() - Write an I3C register of some I3C slave device
+ * @acpm: ACPM data
+ * @ch: I3C channel (bus) number (0-15)
+ * @addr: I3C address of slave device (0-15)
+ * @reg: Address of I3C register in the slave device to write into
+ * @val: Value to write
+ *
+ * Return: 0 on success or non-zero code on error (may be positive).
+ */
+int acpm_i3c_write(struct acpm *acpm, u8 ch, u8 addr, u8 reg, u8 val)
+{
+	u32 cmd[4] = { 0 };
+	u8 ret;
+
+	cmd[0] = (ch & IPC_CHANNEL_MASK) << IPC_CHANNEL_SHIFT |
+		 (addr & IPC_TYPE_MASK) << IPC_TYPE_SHIFT |
+		 (reg & IPC_REG_MASK) << IPC_REG_SHIFT;
+	cmd[1] = IPC_FUNC_WRITE << IPC_FUNC_SHIFT |
+		 (val & IPC_WRITE_VAL_MASK) << IPC_WRITE_VAL_SHIFT;
+
+	acpm_ipc_send_data_async(acpm, cmd[0], cmd[1]);
+	ret = acpm_ipc_wait_resp(acpm, &cmd[2], &cmd[3]);
+	if (ret)
+		return ret;
+
+	ret = (cmd[3] >> IPC_RETURN_SHIFT) & IPC_RETURN_MASK;
+	return ret;
+}
diff --git a/board/samsung/e850-96/acpm.h b/board/samsung/e850-96/acpm.h
new file mode 100644
index 000000000000..9373969209fa
--- /dev/null
+++ b/board/samsung/e850-96/acpm.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2025 Linaro Ltd.
+ * Sam Protsenko <semen.protsenko@linaro.org>
+ */
+
+#ifndef __E850_96_ACPM_H
+#define __E850_96_ACPM_H
+
+#include <linux/types.h>
+
+/**
+ * struct acpm - Data for I3C communication over ACPM IPC protocol
+ * @mbox_base: Base address of APM mailbox block
+ * @sram_base: Base address of shared memory used for APM messages
+ * @ipc_ch: Mailbox channel number used for communication with I3C block (0-15)
+ */
+struct acpm {
+	void __iomem *mbox_base;
+	void __iomem *sram_base;
+	u8 ipc_ch;
+};
+
+int acpm_i3c_read(struct acpm *acpm, u8 ch, u8 addr, u8 reg, u8 *val);
+int acpm_i3c_write(struct acpm *acpm, u8 ch, u8 addr, u8 reg, u8 val);
+
+#endif /* __E850_96_ACPM_H */
-- 
2.39.5

