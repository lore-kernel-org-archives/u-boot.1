Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ED9D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFE583D1A;
	Mon,  1 Dec 2025 18:49:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ATqr2FuA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5899883C6C; Mon,  1 Dec 2025 18:49:43 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADFA283CB1
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D098E40F03
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764611365;
 bh=I04SWr+/ylu8E7ccB/fzcEi5Lruw4AbZ8b0oeSNoaRw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ATqr2FuAIZto+dwcK50XxWUFJeRtz84bZAX+TjZTGMu2/jRd6UMZ5J8clOKjLvMP5
 CQmI3Sd52rbGgaj8/QNXwbtBZE3WETdi2BHZLTZj+aBZsBfxo8x5r6zkuG6BNAA4ZG
 3dNuhCsiOnzvRdMHV4xJgSedGkXx1dS3F5Q4i6862AVZmsC2k1rft5G/qcScpmnQ/w
 pUPQQEGbuol3lm7i3JBCmxZWUnQ0O3DnC1Jy3eV69t8linvP7m2e5enQMCow6QwHS1
 LmOsRqw7Y0SDhCkFkTwM6PL9pobAhFxX3+HfmMAK7Hpg6OKQboV4uegOBf9HPH+grt
 nIly/H77/k2IYBUVEV7YbC3Hl9KDLywozOfkv1AxKjensbIoxsM21qKpGAXWoMqDl2
 hXeyMCpKodfgfWW3R81R8cC7TbkH1lDNReR9e8mmO3veTfyrvhf0D+01agv+AFEGhS
 o0jwGV1Z5+eL7PARDGaeBPKstmz5+bjxRXUb0IQAkf+3IDk1V9P1T2Ho1HW4S0JC/w
 PcNWChf6TGJTaa0XqKZrUUHsDB6abeaLerkIllFhB6AeqdjuZdPAnwPd0E1jv4yezK
 BLsGixwZv16KBD9hBXK3eurBOBmH1g4r8UN1bbu0O7uvFPvtUp1WD8s2zhHe9CeTrW
 rHkCQXkbVMh+DnVJ/Zmj6ncE=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477563e531cso39100915e9.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764611358; x=1765216158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I04SWr+/ylu8E7ccB/fzcEi5Lruw4AbZ8b0oeSNoaRw=;
 b=vexAmp9i7eYuzcXKdkOblvRz2ivccOCPPw200Tqwt3jJomXPBq2raEl5kXVOAF8Gk9
 B7wofjN35CCZ+hw4Pl28NgGOyROy/oUCxCAfKllxcbOO1TDz2e7Bfs36knL/1oT4bYzs
 I5x6/HsEu8gqiWcyj9MwVaMrqDTN3PwR/HaeOKYAx4L17m0vItmnBKTZScD6CDEuHrRb
 RIiaeDWX8yjYMOQtPoA8GDUumPvIrzWDxLPIyQwmKkum/1vInOtMA2VV1Tm706Cx2x53
 x1dx8C4UkOKkzdI5JQcUyqliuTGnsLF6yyWYsM8DbXroBrhaqtfOa6dVREHw9UE2jdfg
 /F6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg88T2O4lVBHIF0cisGhOXtkP+y1Hc+oFGnTgh4tP51qVeqfZrICR+Wwg4RusCiSsUYKG/fPU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy26aEd0+sF7X93TRNqmADrtbcoC22VV4v549+fWIR+ibiDzG34
 MIPt+lKLdEOnLIMAkwvaPFWIPBZ8GBlaT8o5ODutTBIFUZTjurB4ERhiPwsAPEhxdt5UnAxqk2W
 RnBUIJhiwR86gGg+twqqsl+gLyicxZZND2wo7pg5IS2TU88xZf52dEk0VpkUQDC0j2Jn5J7M=
X-Gm-Gg: ASbGncuu+ujIvFZvuEhvg/vQgbMTjnEpXX17cMDGBn/uxVM0EY3awhZhRhI1C0y8nT1
 cNsJO8qyKY2zXHpf/T6Pj60cBnXGMeg+ppJ9ij/P4EYuIMqSwcHesW+DOqqJSkgPDOc0F0aAB/B
 eqVbJA9wyaHjIzWbE7kUXj24May2NWYq7WoVKiuoBSdrdW1pHLjWTa1vm+e3zA/8r+hJjThxS+m
 zS2drXUKY1UwnyE9MtuxwR45bUZDXe+l7KF78Rjwe2KLMZkvGiWFX6ID3QJcsjdIjYtglzjO5BZ
 083jME67tEp4F58nYKhMK+jLYS9jmjssLR29SMTdiOcD3lQOttIgXkNJfg0oOsOfixtg0H3vDSr
 kOFad4ZGBa/xfdQkhmfT5RjhXGHyEMZhJKCGXZuVh2o0mpKSutW+T+g0PQiSP9N5vlRFIEa0fgd
 De
X-Received: by 2002:a05:600c:3b96:b0:477:b0b9:312a with SMTP id
 5b1f17b1804b1-477c11030a4mr426381495e9.7.1764611358164; 
 Mon, 01 Dec 2025 09:49:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFgVzvLlJ8z6rbt5W7mgBctqx9f/yvE9UPBjm7FLwgjK5/8WZfFDeM8/qR/8vSjpRHu5+IGQ==
X-Received: by 2002:a05:600c:3b96:b0:477:b0b9:312a with SMTP id
 5b1f17b1804b1-477c11030a4mr426381255e9.7.1764611357715; 
 Mon, 01 Dec 2025 09:49:17 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0c3a1dsm324072125e9.10.2025.12.01.09.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 09:49:17 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Yao Zi <ziyao@disroot.org>, E Shattow <e@freeshell.de>,
 Hal Feng <hal.feng@starfivetech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/2] RISC-V: implement private GCC library
Date: Mon,  1 Dec 2025 18:49:03 +0100
Message-ID: <20251201174904.652954-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201174904.652954-1-heinrich.schuchardt@canonical.com>
References: <20251201174904.652954-1-heinrich.schuchardt@canonical.com>
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

The following functions are provided:

Count leading zero bits

* int __clzsi2 (unsigned int a)
* int __clzdi2 (unsigned long a)
* int __clzti2 (unsigned long long a)

Count trailing zero bits

* int __ctzsi2 (unsigned int a)
* int __ctzdi2 (unsigned long a)
* int __ctzti2 (unsigned long long a)

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/Kconfig            |   1 +
 arch/riscv/lib/Makefile |   2 +
 arch/riscv/lib/clz.c    | 105 ++++++++++++++++++++++++++++++++++++++++
 arch/riscv/lib/ctz.c    |  95 ++++++++++++++++++++++++++++++++++++
 lib/Kconfig             |   2 +-
 5 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/lib/clz.c
 create mode 100644 arch/riscv/lib/ctz.c

diff --git a/arch/Kconfig b/arch/Kconfig
index 3133f892f94..4af0da2485f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -159,6 +159,7 @@ config PPC
 config RISCV
 	bool "RISC-V architecture"
 	select CREATE_ARCH_SYMLINK
+	select HAVE_PRIVATE_LIBGCC if 64BIT
 	select HAVE_SETJMP
 	select HAVE_INITJMP
 	select SUPPORT_ACPI
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index f1f50918eff..a527b3e9ae3 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -6,6 +6,8 @@
 # Copyright (C) 2017 Andes Technology Corporation
 # Rick Chen, Andes Technology Corporation <rick@andestech.com>
 
+lib-$(CONFIG_USE_PRIVATE_LIBGCC) += clz.o ctz.o
+
 obj-$(CONFIG_$(PHASE_)LIB_BOOTM) += bootm.o
 obj-$(CONFIG_$(PHASE_)LIB_BOOTI) += image.o
 obj-$(CONFIG_CMD_GO) += boot.o
diff --git a/arch/riscv/lib/clz.c b/arch/riscv/lib/clz.c
new file mode 100644
index 00000000000..7b173d3c858
--- /dev/null
+++ b/arch/riscv/lib/clz.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * libgcc replacement - count leading bits
+ *
+ * Copyright 2025, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
+ */
+
+#include <linux/types.h>
+
+/**
+ * __clzti2() - count number of leading zero bits
+ *
+ * @x:		number to check
+ * Return:	number of leading zero bits
+ */
+int __clzti2(long long x)
+{
+	int ret = 64;
+
+	if (!x)
+		return 64;
+
+	if (x & 0xFFFFFFFF00000000LL) {
+		ret -= 32;
+		x >>= 32;
+	}
+	if (x & 0xFFFF0000LL) {
+		ret -= 16;
+		x >>= 16;
+	}
+	if (x & 0xFF00LL) {
+		ret -= 8;
+		x >>= 8;
+	}
+	if (x & 0xF0LL) {
+		ret -= 4;
+		x >>= 4;
+	}
+	if (x & 0xCLL) {
+		ret -= 2;
+		x >>= 2;
+	}
+	if (x & 0x2LL) {
+		ret -= 1;
+		x >>= 1;
+	}
+	if (x)
+		ret -= 1;
+
+	return ret;
+}
+
+/**
+ * __clzsi2() - count number of leading zero bits
+ *
+ * @x:		number to check
+ * Return:	number of leading zero bits
+ */
+int __clzsi2(int x)
+{
+	int ret = 32;
+
+	if (!x)
+		return 32;
+
+	if (x & 0xFFFF0000) {
+		ret -= 16;
+		x >>= 16;
+	}
+	if (x & 0xFF00) {
+		ret -= 8;
+		x >>= 8;
+	}
+	if (x & 0xF0) {
+		ret -= 4;
+		x >>= 4;
+	}
+	if (x & 0xC) {
+		ret -= 2;
+		x >>= 2;
+	}
+	if (x & 0x2) {
+		ret -= 1;
+		x >>= 1;
+	}
+	if (x)
+		ret -= 1;
+
+	return ret;
+}
+
+/**
+ * __clzdi2() - count number of leading zero bits
+ *
+ * @x:		number to check
+ * Return:	number of leading zero bits
+ */
+int __clzdi2(long x)
+{
+#if BITS_PER_LONG == 64
+	return __clzti2(x);
+#else
+	return __clzsi2(x);
+#endif
+}
diff --git a/arch/riscv/lib/ctz.c b/arch/riscv/lib/ctz.c
new file mode 100644
index 00000000000..6c875e39f0e
--- /dev/null
+++ b/arch/riscv/lib/ctz.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * libgcc replacement - count trailing bits
+ */
+
+#include <linux/types.h>
+
+/**
+ * __ctzti2() - count number of trailing zero bits
+ *
+ * @x:		number to check
+ * Return:	number of trailing zero bits
+ */
+int __ctzti2(long long x)
+{
+	int ret = 0;
+
+	if (!x)
+		return 64;
+
+	if (!(x & 0xFFFFFFFFLL)) {
+		ret += 32;
+		x >>= 32;
+	}
+	if (!(x & 0xFFFFLL)) {
+		ret += 16;
+		x >>= 16;
+	}
+	if (!(x & 0xFFLL)) {
+		ret += 8;
+		x >>= 8;
+	}
+	if (!(x & 0xFLL)) {
+		ret += 4;
+		x >>= 4;
+	}
+	if (!(x & 0x3LL)) {
+		ret += 2;
+		x >>= 2;
+	}
+	if (!(x & 0x1ll))
+		ret += 1;
+
+	return ret;
+}
+
+/**
+ * __ctzsi2() - count number of trailing zero bits
+ *
+ * @x:		number to check
+ * Return:	number of trailing zero bits
+ */
+int __ctzsi2(int x)
+{
+	int ret = 0;
+
+	if (!x)
+		return 32;
+
+	if (!(x & 0xFFFF)) {
+		ret += 16;
+		x >>= 16;
+	}
+	if (!(x & 0xFF)) {
+		ret += 8;
+		x >>= 8;
+	}
+	if (!(x & 0xF)) {
+		ret += 4;
+		x >>= 4;
+	}
+	if (!(x & 0x3)) {
+		ret += 2;
+		x >>= 2;
+	}
+	if (!(x & 0x1))
+		ret += 1;
+
+	return ret;
+}
+
+/**
+ * __ctzdi2() - count number of trailing zero bits
+ *
+ * @x:		number to check
+ * Return:	number of trailing zero bits
+ */
+int __ctzdi2(long x)
+{
+#if BITS_PER_LONG == 64
+	return __ctzti2(x);
+#else
+	return __ctzsi2(x);
+#endif
+}
diff --git a/lib/Kconfig b/lib/Kconfig
index f5c1731f456..7b390608b33 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -212,7 +212,7 @@ config IMAGE_SPARSE_FILLBUF_SIZE
 config USE_PRIVATE_LIBGCC
 	bool "Use private libgcc"
 	depends on HAVE_PRIVATE_LIBGCC
-	default y if HAVE_PRIVATE_LIBGCC && ((ARM && !ARM64) || MIPS)
+	default y if HAVE_PRIVATE_LIBGCC && ((ARM && !ARM64) || MIPS || RISCV)
 	help
 	  This option allows you to use the built-in libgcc implementation
 	  of U-Boot instead of the one provided by the compiler.
-- 
2.51.0

