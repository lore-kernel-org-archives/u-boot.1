Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8908D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:47:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1929C83CDF;
	Mon,  1 Dec 2025 18:47:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LBJaHtV2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A452883CEA; Mon,  1 Dec 2025 18:47:34 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3AA783CDF
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8CA1D3F2EF
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764611249;
 bh=sAdi+y+zimNenhWEsrMr1uxdxb/Zn9gPGk+hD5EMApA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=LBJaHtV2usQfvTDQ6S3c3SHDEF+vRgoAXlvieQ4Ny1QXWdZz28/+mVRfu+odolt3j
 /9dluYqQb9UEeqNTG+fJPh/SfHygFk5Z1M4tIg5rwM4t0ocgx4sutc0sj8M3s3dBUG
 fks1gzYPYeiaB+2W70ijXvkOo02V4dNMq3p9zzb21MMKNpFjL6G1Cx6nHIccvZwy25
 IaAwXBL/8QQvv3ps4peMPbH4Ne5IF2AfriVwithvPPRoufAnvhkdSlyYnrxRdQOowB
 fOQNgPkpGjaYfFqQnnJHzkG52LTL0CeHaJXmXKMyNZew4oSNWzlg1egcCfgBDABsVu
 4QDxRQiHI4tFng9DR2GgLzkXnDTfLps/7oBgmM8RqGno8fkfEep1ne4yBjITLRIcFV
 fxW+NbJuiYFqb23FbsmM10yf8IBeKffEZ1SyCUq6MvUkiaA8mjIcvGWmHWvE8ReoSX
 aEr5f6Vixjqlq7/D4F5aPRkyKfSTW5K4ettk8LDsYPAr7X+ZsCCMI6YTogaSrW3n8O
 njF8Vm5FSgkkRjFWW2dkNpdV6jdI3K2deWoN+Gnwb3M1ZjPlm2ndjSlhHtF2mGxHMK
 Ge2Qat2a8dN6Zyv2rMuHY8FlbLxVKlKmcywakDyF6oOgPlGADHOqXJlFrhGXP+UsC4
 IqWjW3UytkhE19B5tK1fZttg=
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b735efd650fso529949866b.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764611249; x=1765216049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sAdi+y+zimNenhWEsrMr1uxdxb/Zn9gPGk+hD5EMApA=;
 b=DI+CBOWUa2nZ77nxgrxF+LHfGL+Z03IogmA89whPvl9QfJniFkC2BMgPUlXu9eeup/
 A7i/ifFR7vd4blCIN8zyRmMS7FUDnWsvu/M0YbMH5m75wZrfAjTQPja/RIOBzAnYXE44
 4stbM/PueZ1mV2KDOeAuOQi0yxSWktgLeFJgiRfn3PEx9jGHJhVhkYSz5A958t+GMhVW
 AExMzHdULACkecXieXAbNRcvsCtTkaQ1NWYq1HCBGaGQutx3vQC0/RN5JrQTX2woz/q3
 4BKtasT49prq4Y1xcG+MGpAIrZpjVggY++Rd2Ua0SGmDihKOMj2BKlgz6pZnHT4vND/R
 UD6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR6MizzzPaw+os4otHf7XkAGxdtfV9SJ4GjoE7ap72lQHTEnB1PHb+cKX7/nqemOcfYUS8zlc=@lists.denx.de
X-Gm-Message-State: AOJu0YyrIOEmvV+tbLz6q5DIi5w807AZdmtU6CfX0kNyhdLHLEpI0Sg2
 1Xmqk7S7Cdl9q6soY0nuK2dGGpyJiLS1tx1GRfCx0bjZLTc0LkZEu1PVDpQVr+8SDD5IjzADgcQ
 woRSB6+ggtuvtomm+tC12I8l6eXodGYoQSTQaNbj+92T35Fc5oMY6Mi5ip08h29i6RLAII9M=
X-Gm-Gg: ASbGncuQouyncJ20nWIdwltHNQ6A51Xmw+OqFJybI84IEGs0pVgYd0L+U9r2xhvlaR9
 3GdkJZVkcaoEN7/hcrFwHQxz2vKjhby3y2AMRwQroWwWHjjYabdIHLgjj1MK6Wx9b4WXyz4C4UV
 AQxnlYRv3P8sGq+YKisPJYhFlkbZv3fVLROiX7lOs+W/SdpfbFZk3bUOC36MSBLKvht52A+xDDS
 ZSimgxJyljhJP1uL41AJ9rv1rGzS8eRlCYHt/vaFIlFn5vAa8s1palGMhOCSmg5ZEJPHa2GbhRW
 KWGT0Mpd/J2kygwdImQBGhYic2W7dzbk+7ROooXvRrW3RJcLTMG2DJB5w44o//u+36+By/ACy04
 JU/NJ+EN1ApONhoEpZeQ7EFuLUcOJNKxm5ke3q4FERKoMWYattNwuz5cEuA==
X-Received: by 2002:a17:906:6a13:b0:b72:c261:3ad2 with SMTP id
 a640c23a62f3a-b7671ad9240mr4179725366b.50.1764611249049; 
 Mon, 01 Dec 2025 09:47:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGj+in5nS6Y9JPx0oZ2NNbBGl/FK8MIOadljIxK3GKYjF0LOyHiEjm+Pu4Naz97LGUZBPgicQ==
X-Received: by 2002:a17:906:6a13:b0:b72:c261:3ad2 with SMTP id
 a640c23a62f3a-b7671ad9240mr4179722766b.50.1764611248670; 
 Mon, 01 Dec 2025 09:47:28 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f51c67e2sm1288993566b.27.2025.12.01.09.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 09:47:28 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <zfsdt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Yao Zi <ziyao@disroot.org>, E Shattow <e@freeshell.de>,
 Hal Feng <hal.feng@starfivetech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Minda Chen <minda.chen@starfivetech.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Heinrich Schuchardt <zfsdt@canonical.com>
Subject: [PATCH 1/2] RISC-V: implement private GCC library
Date: Mon,  1 Dec 2025 18:47:04 +0100
Message-ID: <20251201174705.652626-2-zfsdt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201174705.652626-1-zfsdt@canonical.com>
References: <20251201174705.652626-1-zfsdt@canonical.com>
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

From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

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
Signed-off-by: Heinrich Schuchardt <zfsdt@canonical.com>
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

