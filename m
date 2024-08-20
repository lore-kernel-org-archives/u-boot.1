Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E517C3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 09:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 253CD88D47;
	Tue, 20 Aug 2024 11:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="mLkgF7tt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9190188D47; Tue, 20 Aug 2024 11:38:35 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B820889D2
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 11:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3db51b8ec15so3005732b6e.1
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724146712; x=1724751512; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CkKlVHf8gxmp3udVp0tro4L2aFk0+3nsX7gIYnvmWio=;
 b=mLkgF7tt8u7s1V1G2TNQqXAOlMZOziR9R938xodz+LOeCy3l/p/HUD5iFyb4eizmy5
 PQEjwZ0po4dXsbv12t7EIQeOFPOKPuhNY6/gC1acM7HSE5fZFNOpmkTx5yxOszQU2McP
 7b3DYB7Ydd5FEyEmhgYzUTaOjOknHF8UQcxwtmgQwZLxS1hLy1fS5To0bWs+6jHKwjpC
 ncGsS+9GvHSnMbg2yPdDpHRg7HxocPDLEUAB2869s2S8vvpJ20sTdBi//mnjKrnI8HSu
 PhiItOjnHjD+6vtmJ51oTwScHtZtkizL7VhKLXNuOgQBQq1nfnOHYaSGc50oEiIOrHfI
 azNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724146712; x=1724751512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CkKlVHf8gxmp3udVp0tro4L2aFk0+3nsX7gIYnvmWio=;
 b=kbsUEIbk2AnK+jLMsvAe6ngnClEHnvfq/bG0CHcR9S3QbrHTJU4L0C3hU5Qi9RwsP5
 3XqvQNyKAS3KMLPHVfOA9xV/9ObReR0bI8rulRTLP2tP58nMFuS+VHyJma2Bc7rJBW50
 TmHZyOhFed8SETgyR/PX9SGX//ogJudO2AJQkcyLbIVBJ/qQX+Iwch7jhgt1/IKEqvg9
 8zIgZI6CPIFg53VmDDct1YYpUgqPOeWRZwwYIw0LifM9uL9fF7I7BjPDBfV0BjTcXlfY
 s8Dr0bzL2UpQqy8EpKSGLWoj7s2XFaCUZggBIdl+iPs7TXIsmg1edyYIJtSQzTBiSJQA
 Z49A==
X-Gm-Message-State: AOJu0YwWXIJ50O4iHv+qbFKe1LeTwv5TgLEw0uewz+wh9PCk9ACM8AER
 VfSPQEY4tH4TBLf8AdspvvwYrUp5R5K9Cq61eXL1UNezHbgUnrhyNVsgzxp7YOxqfFD8YxA/dy5
 m
X-Google-Smtp-Source: AGHT+IHJHhAjpCRg5HJ770+TsbaxM+82l0svwW0hdGLKJ3LzAVeofSciIubepim8JF5LQ5kHsqzBmQ==
X-Received: by 2002:a05:6808:2e91:b0:3d9:2968:5403 with SMTP id
 5614622812f47-3ddbba72449mr1160132b6e.14.1724146712091; 
 Tue, 20 Aug 2024 02:38:32 -0700 (PDT)
Received: from localhost.localdomain ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-3dd33d3fe91sm2795674b6e.9.2024.08.20.02.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 02:38:31 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/3] riscv: Add support for defining instructions
Date: Tue, 20 Aug 2024 09:37:50 +0000
Message-Id: <20240820093800.5436-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820093800.5436-1-mchitale@ventanamicro.com>
References: <20240820093800.5436-1-mchitale@ventanamicro.com>
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

Add insn-def.h which is similar to that in linux and contains the macros
to generate any instruction of type 'I' using the assembler's .insn
directive.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 arch/riscv/include/asm/insn-def.h | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 arch/riscv/include/asm/insn-def.h

diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
new file mode 100644
index 0000000000..99ad5b8f6a
--- /dev/null
+++ b/arch/riscv/include/asm/insn-def.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Ventana Micro Systems Ltd.
+ *
+ * Ported from linux insn-def.h.
+ */
+
+#ifndef _ASM_RISCV_BARRIER_H
+#define _ASM_RISCV_BARRIER_H
+
+#define INSN_I_SIMM12_SHIFT		20
+#define INSN_I_RS1_SHIFT		15
+#define INSN_I_FUNC3_SHIFT		12
+#define INSN_I_RD_SHIFT			 7
+#define INSN_I_OPCODE_SHIFT		 0
+
+#define RV_OPCODE(v)		__ASM_STR(v)
+#define RV_FUNC3(v)		__ASM_STR(v)
+#define RV_FUNC7(v)		__ASM_STR(v)
+#define RV_SIMM12(v)		__ASM_STR(v)
+#define RV_RD(v)		__ASM_STR(v)
+#define RV_RS1(v)		__ASM_STR(v)
+#define RV_RS2(v)		__ASM_STR(v)
+#define __RV_REG(v)		__ASM_STR(x ## v)
+#define RV___RD(v)		__RV_REG(v)
+#define RV___RS1(v)		__RV_REG(v)
+#define RV___RS2(v)		__RV_REG(v)
+
+#define RV_OPCODE_MISC_MEM	RV_OPCODE(15)
+#define RV_OPCODE_SYSTEM	RV_OPCODE(115)
+
+#define RV_OPCODE_MISC_MEM	RV_OPCODE(15)
+#define RV_OPCODE_SYSTEM	RV_OPCODE(115)
+
+#define __INSN_I(opcode, func3, rd, rs1, simm12)	\
+	".insn	i " opcode ", " func3 ", " rd ", " rs1 ", " simm12 "\n"
+
+#define INSN_I(opcode, func3, rd, rs1, simm12)			\
+	__INSN_I(RV_##opcode, RV_##func3, RV_##rd,		\
+		 RV_##rs1, RV_##simm12)
+
+#endif /* _ASM_RISCV_BARRIER_H */
-- 
2.34.1

