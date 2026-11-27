Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF14606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FtzkD89j;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NVgjkN8r
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7F7F60AC4;
	Fri, 27 Nov 2026 06:36:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PmOQssdj7AXv; Fri, 27 Nov 2026 06:36:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 353CC60B18
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795761410;
	b=B38vgIRRQzCwIUQPNe3ARObYxNBSYOWbpN7d7iM5sybIDRi6VqcbmhZzJCEN8IISJfHx
	 5f+E5ogHtlMRMaoYG9qU8J36qAAN3faEsPCXNnOHW4amCsRFwgmdVo6tnU7QBosT62Nw7
	 J7MhUsPzOwno7QBQcyGwHmTw1qrXQ96uuCNwqeQi6hgr6nIxW7zPqYQ5/y55/p0IfIC3s
	 wAulTjy3ZTXPohRMfQcLZH5Gf63bTdxc7xGXzYb5tQIaZ2NtnAHfkuFbILI+NDdEfqYNx
	 AfRIr9sza4GhQebokrBvk0cXtIhMSSkLy6MJqmgErj5wmxfpEZTDI5bv5x3Wq2/cldA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795761410;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Gl5sMrHu3YoBIt1AS8EwuWwhpMlbU35oEoHsIoU6rSM=;
	b=QBzKUw4r7y6S5IA7fE9XAjcczqIBtiKa59vQMegtcovlLuZS21Kdysi8SnM//5qBo0W/
	 mTinSB6QWi3gmru8AVvmIVI/RmJkGBNH3odEeijK4mhs+/J4rNWKOgHfEOhYN3yV7mrc8
	 PzxZSsgRBzQbsih2p09S+Gn9Nk7/kBJkbGWWB6mw/MI73YWAay3r6wobiql72RI0jQXvp
	 wec8srKGJ/1zuzebVQ1MdGMXVGonssMhC3RhOgXSoEU4Tbv2ifqe7eBRbdW20DIyZGn0J
	 09FTIXrPv0OpJ/ea0hJsl6NkjQYRNX8supk2uQUtzW/T6jrUyQMRGjTomWQkC15qKzg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795761410;
	bh=Gl5sMrHu3YoBIt1AS8EwuWwhpMlbU35oEoHsIoU6rSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FtzkD89jYPvtaHvhDOAKTeXjMhOR9pRXRV2rK7gIG+A2Xvy1F3PdXR4SYLMMgTdY4
	 Ad9RlVbUqNeBOqP7QMCMY7OV1LvpWOahHUy8sD+43dxEtVdQNynEPTYQfK4BzTP0Mz
	 w4zuTw89pVC+GVXy4PnLuH4hbKOGRfdBBgF5NOKt8rxufAsoeLDm6IfhHU+kZCdvF/
	 FZFnFy2hMO2wMhMDLFEbO9tXqZ1ESD892ai960CjtclgRLqMltey3fZ9YArlvSZIwo
	 OanJwAvAY04nCLh+UjL4S8gP17ZqO+bPqDNR7H4pxH7lW+j7ifgs4ii6mVHHMfZ69Z
	 2hcg181nURQ9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 353CC60B18;
	Fri, 27 Nov 2026 06:36:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8471F3C0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69D86811FD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t3FWTjqDrp5N for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 06:36:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AE7558115E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=NVgjkN8r
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com
 [IPv6:2607:f8b0:4864:20::1230])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE7558115E
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:44 +0000 (UTC)
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-1b546061d58so17969100c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 22:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795761403; x=1796366203;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gl5sMrHu3YoBIt1AS8EwuWwhpMlbU35oEoHsIoU6rSM=;
 b=NVgjkN8rlgrdrewbFpuwOXJkkRsYIixwLT2BSgux7WEXyvztMdP4taepyWUH1acfvm
 UEiG7GrylVzbf96lpNBav8MMLcNC7Qo+zSfkxlFYJ8yE+jDiaR9olHffeiisaNgCv05a
 1FLroAFluQcm/xY7eW3DCsY/Zn+K37gHTrE9YXMdNhGyiPSEop0W2Oq72Uft9Hz+uUGj
 KQJLN2h9ZVwB0Ts36nj3buqotwKRP5u+OUQQOvgjV2LpEOcDd/GLw2aGGo6S+ycPwd9j
 uGYg/X6rVCk6TCMdPwPhgBAP2JqCcM6pOdT9o6QmNyNcbH6cFMgrOkn6OkO90gNQGoU8
 mRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795761403; x=1796366203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gl5sMrHu3YoBIt1AS8EwuWwhpMlbU35oEoHsIoU6rSM=;
 b=iw910DEFRJlCbKsoJR9Qn6sJQLI/csC5ThcqjVu5b2CCVPo9UjZm9qmvY2BqcnEoSU
 2pjKo5Gbq4ZRwZDW54ogjB2HNBhB5cQ4Nv/RGeKa1/+YrmlANTiAGOT96T4ts5Qb36/V
 71/5JbXBEdnpyCyK+q4q/IArohS+B1YUePWTL+U2kXSvh6ct0zCeQpSe6t/ctDi0sKvf
 9lry32kG1wp+oeGN/8ZS62NzU47xbblLf6T43SFR6v5TIeGKSTd0SpTjKnJmnUy2cOhQ
 vjmF6aQpmaBDVTGof1uw/dlnW4UoGNVWe+D7amdty8pMGk0GYTIilzPXeGN/T9kkp6SZ
 vCMQ==
X-Gm-Message-State: APuU4Z93YhyxdHzRxB4+PH+yPBabIUl4ejGIvCzRf9Ga91BXzeUNo6TZ
 Av+9XWedfekBxUW4b/b2OjlTUt3v/PVjtc2AFb0mTnKuko5c/4Y7DWD6
X-Gm-Gg: AZFdTZdkrF1JaOJhs6oguWYcdOzVbOhQyLzvb0s9aL/wHZHdioFLx75cXNJbRooAEnI
 wNqU57wViPx3xBq1Vqs1g431SfVrw06HOx62EWh3Vxd7zg3LEyTAb1XSEyxJVs9ycAMbARgjw+u
 9j+bpKqNTDIo2MwKE6RZ2TG2H5wZX9/qxRnvuObquS+s5Tovhu3UAWQi5DFWq8DzosKCVBoY5sI
 dh3laVNjI1kwXZOK7i4MOW0t9UKAsiSb3mC9YGvnM9Bq954XFxhcjGp1qhFagN4PgjyLn6FN6xM
 9/UINQTo/jirbhnuBbyDZHJRGFY+MJDhDO1cdAjFGcB6NOvbnevxk6YLML4Da+adhx5VnCqs1DL
 gzgO5P06G6qU2xgmQ6KrtBHIR7DdRevD5Jwqc/Z44NcD5NGGhtBvekUZpcHwmOZoGL+1hAIhuVU
 UlHmRMoTdXJtO6JZ8s788JJoQbRls8tGAinnJBp1qhqM4ohSdRv+Z3fVIJ1I1BUgPJdpbaFtpSH
 fbBj5RZ6p+iLH7cdGn3dc/DIBVybRWpYw2YKtKTNtXQ+7YvqdMEH9RQiKvROqzvIy7PXWd6bmAW
 XJeQbUSFIHTrbbatly/C6Leo1+cIa1O39S+R+mBGCTKxBw/55qi+mtxlAJc6mDkYO/SItddvon0
 i0v/A9zXQ4CfIjADqUfDZLyU=
X-Received: by 2002:a05:701b:4513:10b0:1b5:56d8:d596 with SMTP id
 a92af1059eb24-1b556d8d6fdmr23401978c88.12.1795761403286; 
 Thu, 26 Nov 2026 22:36:43 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (55.11.81.34.bc.googleusercontent.com. [34.81.11.55])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385672c6f31sm67452444eec.15.2026.11.26.22.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 22:36:43 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com,
	ilias.apalodimas@linaro.org
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, marscheng@google.com,
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, visitorckw@gmail.com
Subject: [PATCH v2 5/8] board: google: Add Google Tensor G5 board support
Date: Fri, 27 Nov 2026 06:36:17 +0000
Message-ID: <20261127063620.399391-6-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127063620.399391-1-visitorckw@gmail.com>
References: <20261127063620.399391-1-visitorckw@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add initial board support for Google Tensor G5 SoC boards. U-Boot
runs as BL33 loaded at 0xbe000000. Configure the MMU map, DRAM
bounds, and disable the APC watchdog left running by earlier
bootloader stages.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS                  |  1 +
 arch/arm/mach-google/Kconfig | 10 ++++++
 board/google/lga/Kconfig     | 11 ++++++
 board/google/lga/MAINTAINERS |  4 +++
 board/google/lga/Makefile    |  3 ++
 board/google/lga/lga.c       | 65 ++++++++++++++++++++++++++++++++++++
 6 files changed, 94 insertions(+)
 create mode 100644 board/google/lga/Kconfig
 create mode 100644 board/google/lga/MAINTAINERS
 create mode 100644 board/google/lga/Makefile
 create mode 100644 board/google/lga/lga.c

diff --git a/MAINTAINERS b/MAINTAINERS
index af52a4f60e5..dfbd3bca8b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -360,6 +360,7 @@ ARM GOOGLE TENSOR SOC SUPPORT
 M:	Kuan-Wei Chiu <visitorckw@gmail.com>
 S:	Maintained
 F:	arch/arm/mach-google/
+F:	board/google/lga/
 K:	[gG]oogle.?[tT]ensor
 
 ARM HISILICON
diff --git a/arch/arm/mach-google/Kconfig b/arch/arm/mach-google/Kconfig
index bb74890b457..f6a5c9c43f2 100644
--- a/arch/arm/mach-google/Kconfig
+++ b/arch/arm/mach-google/Kconfig
@@ -5,4 +5,14 @@ if ARCH_GOOGLE
 config SYS_VENDOR
 	default "google"
 
+config TARGET_GOOGLE_LGA
+	bool "Google Tensor G5 (LGA)"
+	default y
+	help
+	  Support for Google Tensor G5 (Laguna) SoC and boards based on it,
+	  including Frankel (Pixel 10), Blazer (Pixel 10 Pro), and Mustang
+	  (Pixel 10 Pro XL).
+
+source "board/google/lga/Kconfig"
+
 endif
diff --git a/board/google/lga/Kconfig b/board/google/lga/Kconfig
new file mode 100644
index 00000000000..e4cee5c1fe2
--- /dev/null
+++ b/board/google/lga/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+if TARGET_GOOGLE_LGA
+
+config SYS_BOARD
+	default "lga"
+
+config SYS_SOC
+	default "lga"
+
+endif
diff --git a/board/google/lga/MAINTAINERS b/board/google/lga/MAINTAINERS
new file mode 100644
index 00000000000..81894f1e0e7
--- /dev/null
+++ b/board/google/lga/MAINTAINERS
@@ -0,0 +1,4 @@
+GOOGLE TENSOR G5 (LGA) BOARD
+M:	Kuan-Wei Chiu <visitorckw@gmail.com>
+S:	Maintained
+F:	board/google/lga/
diff --git a/board/google/lga/Makefile b/board/google/lga/Makefile
new file mode 100644
index 00000000000..4343e05c78f
--- /dev/null
+++ b/board/google/lga/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+obj-y += lga.o
diff --git a/board/google/lga/lga.c b/board/google/lga/lga.c
new file mode 100644
index 00000000000..9968543a910
--- /dev/null
+++ b/board/google/lga/lga.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2026 Google LLC
+ */
+
+#include <init.h>
+#include <asm/armv8/mmu.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define LGA_WDT1_BASE		0x200c5000
+#define LGA_WDT_CONTROL		0x08
+#define LGA_WDT_CONTROL_ENABLE	BIT(0)
+#define LGA_WDT_KEY		0x10
+#define LGA_WDT_KEY_UNLOCK	0x00c0ffee
+
+#define LGA_SDRAM_BASE		0x80000000UL
+#define LGA_SDRAM_SIZE		0x80000000UL
+#define LGA_BL33_RAM_TOP	0xbe000000UL
+
+static struct mm_region lga_mem_map[] = {
+	{
+		.virt = 0x00000000UL,
+		.phys = 0x00000000UL,
+		.size = 0x80000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN,
+	}, {
+		.virt = LGA_SDRAM_BASE,
+		.phys = LGA_SDRAM_BASE,
+		.size = LGA_SDRAM_SIZE,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE,
+	}, {
+		0,
+	}
+};
+
+struct mm_region *mem_map = lga_mem_map;
+
+int dram_init(void)
+{
+	gd->ram_base = LGA_SDRAM_BASE;
+	gd->ram_size = LGA_SDRAM_SIZE;
+
+	return 0;
+}
+
+phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	return LGA_BL33_RAM_TOP;
+}
+
+int board_init(void)
+{
+	writel(LGA_WDT_KEY_UNLOCK, LGA_WDT1_BASE + LGA_WDT_KEY);
+	clrbits_le32(LGA_WDT1_BASE + LGA_WDT_CONTROL, LGA_WDT_CONTROL_ENABLE);
+	writel(0, LGA_WDT1_BASE + LGA_WDT_KEY);
+
+	return 0;
+}
-- 
2.56.1.839.g22a8290db9-goog

