Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF914C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 09:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E23888868;
	Fri, 23 Aug 2024 11:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="No9dKFTa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AE5E88872; Fri, 23 Aug 2024 11:41:57 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D63888861
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 11:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-428141be2ddso13122895e9.2
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1724406115; x=1725010915; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CkKlVHf8gxmp3udVp0tro4L2aFk0+3nsX7gIYnvmWio=;
 b=No9dKFTa5RNm+cdZO0pdLB7j5F7QQXf0TI2nZUPbBPZ4Y+f5o7iM/obyMq9EvgvpXE
 otaoGdjmctcCelEV7uv2HDi7uBiY6wQwewoeTkKs9T+3G6I4tVO+Yp21Uu+5GU0EQshM
 fTozYF1Pm3b6Tanwu7whurBVQ5AvqgD0a++1x/znRSovwdR1FPQd94D2EK2WDBM1sQm9
 OZVyjov6MUsXYJ0XrrQw7eDJU2qFyaU2kqZCM+dykxnEBBaVt2UFqAbYIb4NGRQYvMGQ
 j7sTO4bJelpeegt9BqinJubXp+WcxzmyJjDhnqaT3Yaz9CjqZdytquzSGuHzZwM/ZmZW
 chBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724406115; x=1725010915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CkKlVHf8gxmp3udVp0tro4L2aFk0+3nsX7gIYnvmWio=;
 b=QYfV/+qQ6Sz+iH5tzGMFk2SN+SvpyJh/WTk59o5g7sArnCJHHxtuxBWWqGb9SWe9g3
 GpBC2pCF0inubdspu0iEXVo9M0Atny4aEWyVVQE4GqZtSf4Aptn0335MItc2Y9VMwJgj
 O5HkS7mLZECFSBMK+JLc47lgzC16O9oz0xIB9q/Kd8WLDYSE0lke9ThIa+pkyR7ik522
 T7zmZ6KqyCad9R3457//IOmxCdBKXkGurf3UfWftrTnGlN2au3ZkE8aeOJcVBPS6R5zI
 heQebrdloCSxbSEjXDKO1EiiOPkmrj/f0p/2OcSqH9ErzXhFe+N9C6V5ixPazn3o4HZ2
 Z+rw==
X-Gm-Message-State: AOJu0YzLa5rdLUKeehBrAfZzMBKgmP8U2F0K4hCFiXg0wEsZUGXQLT2j
 ZE32l3Nl+uo4dSV8T3yaEkpFBkCas2MNI25s5SpvNScN4S+IlTwP7VrwwqhbHCBOMjb2cTQ+9jq
 r
X-Google-Smtp-Source: AGHT+IF2NkHV+sBM/dmEd2kaOZP1+olVmh0PlN9TTQyiAdNb1z0NImVseel3CTFWAXrp0FqbNpfKBQ==
X-Received: by 2002:a05:600c:4706:b0:426:5ef5:bcb1 with SMTP id
 5b1f17b1804b1-42acd534883mr8854745e9.6.1724406114136; 
 Fri, 23 Aug 2024 02:41:54 -0700 (PDT)
Received: from localhost.localdomain ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-42ac516251fsm52909335e9.25.2024.08.23.02.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 02:41:53 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 1/2] riscv: Add support for defining instructions
Date: Fri, 23 Aug 2024 09:41:25 +0000
Message-Id: <20240823094127.207866-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240823094127.207866-1-mchitale@ventanamicro.com>
References: <20240823094127.207866-1-mchitale@ventanamicro.com>
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

