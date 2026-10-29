Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB54606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w7oqcPIr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=GyBeBC2V
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE3616067E;
	Thu, 29 Oct 2026 05:10:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VIYAoXnfOLnY; Thu, 29 Oct 2026 05:10:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D60A1606C2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250612;
	b=qTZ+ue6XjCl6fMDgjsNMxMccp+rlMB3RSZvTUWa238LIrKlRPp36ALkW/lMbqtrkwa7A
	 iIes5MxuVJ5+Q3Zd5BoI1MqmaDavrSG5TQlzhXowc/juCSS3fFqfU9OnCojZFkUOQycbc
	 hkKbutiXq88GdmyYzlrYYB+p+JsTKsChdEA92FrzKyzjnDA3+pUv8boHGmfQX+s4qmbk6
	 xdcrxkk3YodCJL2lkgh6o9udKVMRKT0/zbzZRfFzrRmcR7U89v/lNv7QDX42CBPVm2tjI
	 R2SqNftIcKIsADAHyYIUBg48ewOEFu87rqcwgSoe1eHQjGOOqiLUkJOr2rTOYWhqlMg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250612;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=IlfVkdmHO1KCAlG/AEyUBYpQDvJXjX/bulguR5sWQ94=;
	b=ElyMjz2riJBEfCbDrTrZqs0FrUaI1DSihk2ZgoCrX9+aMjLaJsWDpt1vJ29DnluSfTY8
	 p3kdDc9RHIHw6qAlXgIjd0LTVLxqdSvYax1ndSXwGxJVNQnaA+FYb4keSv1D35gCRIKKN
	 olyLAoMQYioVnhB68GdsPZhkbKLQnYwRPssBACYdCd9gYp4t7BO1EE20fk0N6pX0NcqRN
	 BCvgxFmRAeQ+A4wb/uyckkniFOr5VfTvZAXER3J6ECI+LIxBYr/40ecVnLVL+563oZt8r
	 I9BN+e9wgOTnAhj/zsyLKlo8PO4s5EjjlkHHe38yRIT1XJJIJjgryiAHKCJszlQR/cA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=GyBeBC2V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250612;
	bh=IlfVkdmHO1KCAlG/AEyUBYpQDvJXjX/bulguR5sWQ94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w7oqcPIresKCJG9QNySLubP6r7ArLpq6kF4KDvWeONqTnUAdzHl7KfnvvAijfv4D9
	 x+SsmIQfU/MtusiV12aH73E5xlO8is9Is/uQ4TcnPSo4b/5IYg8qj6x8HEqryVjOMx
	 rEqfWnkg6sjmrL5uSfKQwGKEVJWqacP/ff0y3d5hurdtwm5tdkAyS4jqYaFlNtr67v
	 1bh+FiqG0RR8RXAbuM8gm2fmy/FYmR+oP6UytpGh05o8sHRD2ZBbOjuniJ9/72kIR4
	 0LNTUm8Vix7hjWfaAucaJgM+IpzgaXJ+joDEN+ujeBLYcgfOIO54VGm3LAvJBHQB1m
	 FluwzRwQ7MTJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D60A1606C2;
	Thu, 29 Oct 2026 05:10:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 495B0DD7
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:10:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 332CE606C2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:10:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c7deAYpo0xk5 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:10:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2B2876067E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250609;
 b=DQFKcb03R9CrOSSZBfCDQh0hhNFn5YuDFg14M6Z3hJXPgDRDCewwGl12Ngx2rRgSs2PF
 3HpRDERfsSsN+JLr1aoNgSWvxUUDcoQCjo5ZwwH/0ohZJS1jiJjkgaq0OiBJZ+QYOag47
 PUynDGOVWLuKzfQ/QU2BLtZyWQ65qHxP9xVnN22YxR/Vu+YX8AZFSwINKYMKfVDETyyjd
 IEOmFg+AP3bWvgh70YnOZperrG4A7TQPCP4K5d+owKumSm1vkSsnUJwe+UzFPX5iGKKQa
 ZkYgt5lL52p8nSnlM48ALr5fbSpijPivx7jR5da56uT8bXpor1jsp+6qB5Uf78wxPKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250609;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=IlfVkdmHO1KCAlG/AEyUBYpQDvJXjX/bulguR5sWQ94=;
 b=aJhGiORA8hU25KFXXaQsVOkbNJYpscJF1B0EaIr1cD+jMetgQpUvb8evCBPgvUzO56wd
 DukLKZ7qbOobcswZKR2XiKjNzqxnxsqSBm0Sjjr4T7R12aov4k2e+SDPLdFYhBOqnpKsA
 OW9XWWMpt6vvJuN4oCyjdEYxld/sQwLjHP+6sBKmXyEoScb/6iFIuZeOSa3TtQPYqmrL1
 Hxwvz0GpDItUFsDanIMLlKsGwJFdn2ma3LzN08ALmepaKPwDROi+Z8FngE5cxVvTrOgzL
 OrDtOX1DPt6AIRCrR+3KZo7EYvLejvp8tbn617Fky+ctsbNzxtamnvCMkjEeOiMpSCw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=GyBeBC2V; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=GyBeBC2V
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B2876067E
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:10:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250601; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ifXY3RdqvXvAxh/vAx6xsX/iQQVuuRi+KhODSANgeMdR8WDOiaej676H0fyFY1GOv9o/AUS9RlfMt6iFYbJ6M4/MaCATti0KOQ+VJtsaAOgNITWSIRLCuwSGyGwGjYi9qOd0zTsWXbGi6/A4zCisbXNJOv5KWhcDB9hALBNnvKU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250601;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IlfVkdmHO1KCAlG/AEyUBYpQDvJXjX/bulguR5sWQ94=; 
 b=k1gUZ8n+EKxN9712eMy5fYwtfWShyc/htD9znKYo+LzgIhbpa/VtopfMqTtZhI++dMa6E5j0PNZoHi2HDiWpNjUpWrJVGdXFjhmBO8BRp9QO5sCwQCAwqd1/pwnTW/Mkxrx92paUeIR0Zp8YgoHf3BdfAj6/cDZ2JOb8Jp781vE=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=GyBeBC2VuwzK3eI3HEQXYOozCAcCNSzImZUiElYsev1A80JiLLdEXDkMXlyFBCoE9ipulL/L2ZhNY3vWPcK9zicGWCBekrrwrIno4MEc6KTRX9Skr08QNeOC61KubE2f/NIbZIDScCj9pJ7gciSlnXo3fQv5hwvvXywPQzUwPcQ=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=IlfVkdmHO1KCAlG/AEyUBYpQDvJXjX/bulguR5sWQ94=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793250599450362.30214849658455; 
 Wed, 28 Oct 2026 22:09:59 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 11/20] LoongArch: Generic platform type
Date: Thu, 29 Oct 2026 05:07:28 +0000
Message-ID: <20261029050738.1107663-12-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Provide a generic platform with some common routines expected to be
implemented at CPU level.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

No changes since v5

Changed from v4
- Avoid using LoongArch-specific cache_flush() helpers in
  cleanup_before_linux()

No changes since v3

Changed from v2
- Select CPU if DISPLAY_INFO is enabled
- Reword the commit message, re-titled as "LoongArch: Generic platform
  type"
- Fix the comment for cleanup_before_linux() to note that cache isn't
  disabled, captilize Linux
- Drop unused DECLARE_GLOBAL_DATA_PTR from cpu/generic/dram.c

No changes since v1
---
 arch/loongarch/Kconfig              |  1 +
 arch/loongarch/cpu/generic/Kconfig  | 13 +++++++++++++
 arch/loongarch/cpu/generic/Makefile |  7 +++++++
 arch/loongarch/cpu/generic/cpu.c    | 23 +++++++++++++++++++++++
 arch/loongarch/cpu/generic/dram.c   | 16 ++++++++++++++++
 5 files changed, 60 insertions(+)
 create mode 100644 arch/loongarch/cpu/generic/Kconfig
 create mode 100644 arch/loongarch/cpu/generic/Makefile
 create mode 100644 arch/loongarch/cpu/generic/cpu.c
 create mode 100644 arch/loongarch/cpu/generic/dram.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ac4be2c837c0..1f376ca291c1 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -12,6 +12,7 @@ endchoice
 # board-specific options below
 
 # platform-specific options below
+source "arch/loongarch/cpu/generic/Kconfig"
 
 # architecture-specific options below
 choice
diff --git a/arch/loongarch/cpu/generic/Kconfig b/arch/loongarch/cpu/generic/Kconfig
new file mode 100644
index 000000000000..5fcc2156906d
--- /dev/null
+++ b/arch/loongarch/cpu/generic/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
+#
+
+config GENERIC_LOONGARCH
+	bool
+	select SYS_CACHE_SHIFT_6
+	imply CPU
+	imply CPU_LOONGARCH
+	imply LOONGARCH_TIMER
+	imply CMD_CPU
+	select CPU if DISPLAY_CPUINFO
diff --git a/arch/loongarch/cpu/generic/Makefile b/arch/loongarch/cpu/generic/Makefile
new file mode 100644
index 000000000000..c98d63b4f831
--- /dev/null
+++ b/arch/loongarch/cpu/generic/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
+#
+
+obj-y += dram.o
+obj-y += cpu.o
diff --git a/arch/loongarch/cpu/generic/cpu.c b/arch/loongarch/cpu/generic/cpu.c
new file mode 100644
index 000000000000..eb11f1349856
--- /dev/null
+++ b/arch/loongarch/cpu/generic/cpu.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <cpu_func.h>
+#include <irq_func.h>
+
+/*
+ * cleanup_before_linux() is called just before we call Linux, it prepares the
+ * processor for linux
+ *
+ * We disable interrupts and flush caches.
+ */
+int cleanup_before_linux(void)
+{
+	disable_interrupts();
+
+	flush_dcache_all();
+	invalidate_icache_all();
+
+	return 0;
+}
diff --git a/arch/loongarch/cpu/generic/dram.c b/arch/loongarch/cpu/generic/dram.c
new file mode 100644
index 000000000000..26cabc4b3ccf
--- /dev/null
+++ b/arch/loongarch/cpu/generic/dram.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <fdtdec.h>
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base_lowest();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
-- 
2.56.0

