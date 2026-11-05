Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36767606A923
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pYbce2pW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=QC0Oi18P
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0423080E1E;
	Thu,  5 Nov 2026 16:42:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5APBbqltXg0c; Thu,  5 Nov 2026 16:42:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8F09180AD0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793896962;
	b=CNGvGgb0NdVw77LuVdGeaJcKA1p3Q37CtlsX6wU3DnU3i9+e9SXLYhbcBcAzknQe5GCl
	 buS1DIcEILDn5hWuN9VvRmBehwwqEKG++ym5nwZoiSA7mBF+kAps+jdG/01VmcPty0YkN
	 78r8qwx7eeTSuoyGGbgH/JWOCDYg3rKLHuzrVEJEhJ6mKQVulTA7MOtt5jqaG5LmSeAZx
	 Ko7/iMCU7pglUXnE85QYnnkqTR7piMAGUa+UxG6kjTJAw9ZfnPUsRmrtbulQ6Xq+TRykO
	 cltnilLSBPufXoKQ6IhV78sT+9S3pb2MQWcTy3QtDUiKFJaLJH8yIL+pTxwpbWBP3Vg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793896962;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ZohoMailClient:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zhIU14FGz/vw6S/p7U3iZ82yK/ewJE6DtEK95j9KHjg=;
	b=KpZlnhOjU9Ebrs0vwwNAAsTVEa76ehNf1tcAXw2L+xgPy6+rZj9Fy3zO0kb4wQhO4OeS
	 fbqq5GIkOe/Pr8tGbp3uzzArJtqoCRbj8fzn1kR0PL9fbhrHeuVJfPHbHe+Zjcco7SWzH
	 Iqs6AMA1MhgOhL+74xiJzrKQMDdUsdtX6fy2ReuXb7VdkAjwVEF6WhM7+NxhsX0d0E75v
	 +aJ7kTmH4ycycTek1xWoAycgSJsdt5nRVvvM4DuXFXcYeYhF2gf3uMbEBz0l8LHxnXLQR
	 2czH2CJea7ftJjtvRaJEo8BppgT2/HN711VYtwgMzXJ34eOAKlR8JJmOa+/Cp37DxAw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793896962;
	bh=zhIU14FGz/vw6S/p7U3iZ82yK/ewJE6DtEK95j9KHjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pYbce2pWZTkLnzIEkhDZoA9qb1XD2VeHlPf+Wghx3rS1vhDkIihGCWy+XiLhL9fZn
	 E26tqcZ7aDbkxaE93UcS30OmUZHG0is/rEBzysrof7vXx+ZfxJQRw79yNWQMpb0sAP
	 sXcNVQPMyy2waIMbEhQsmv+1CrO0OjfdVSyQ9R/bGhcZcTDEX6toPdUEEBo/+V0KTL
	 vW9lv0qyKQ+AoZQsBuU2w8Q+jPpLUpimQkqTTaY5SYq9fEJrQqb0aURNLxLlgh2A/p
	 7VFD9bVkwYJcQlv3R+Gt2zsfCTEZAl713d23PKGD81d1X4KC0fN8ZCyl4V7AOnyM3s
	 /PB0WVx2+LXgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F09180AD0;
	Thu,  5 Nov 2026 16:42:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3705F31F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:42:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28074400E6
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:42:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X5AkZuJusYju for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 16:42:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B0C6B40072
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=QC0Oi18P
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B0C6B40072
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 16:42:37 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=QC0Oi18P/JjNJoZauh0cu5KcWyHNFtfXI6TnWbz7x60c1Bkxtu18zVtdPdPQZbU7ykztgfP3yi9dC9FfoIGTJz+NuHcWX+N1kcueP2l4dZ1vr8x5pS+3fkdCMLJ/etokI2HB0TWw6Cz+PfXwS/b3NV41YyEtZtJlimIRFiHhiQ8=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=zhIU14FGz/vw6S/p7U3iZ82yK/ewJE6DtEK95j9KHjg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793896941860470.64373488787396; 
 Thu, 5 Nov 2026 08:42:21 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Fri, 06 Nov 2026 00:40:40 +0800
Subject: [PATCH 2/5] riscv: spacemit: k3: Add SPL initialization support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-k3-ddr-v1-2-1e60e1d78020@pigmoral.tech>
References: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
In-Reply-To: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@kernel.org>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, E Shattow <e@freeshell.de>, 
 Huan Zhou <pericycle.cc@gmail.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8151;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=HrLGCyrf+/6wwFDhQALBCgwjWIRHIijhus6nAFJ5EEA=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLLebDy69PdT80jtD3Psk7Llvt8vXq1osXHrteVv0yoFb
 760SPbl7ChlYRDjYpAVU2Th8hf/Z63D8+2IQOt9mDmsTCBDGLg4BWAix/oY/in+/j3l2pTbbUff
 BU77e7Ui/vdmZav0BWIbpI0M27qMnecy/A9euzAx3anhuZOul88Lxq0W7adU3freii8+7Mx/ge2
 aED8A
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add SPL initialization support for SpacemiT K3. Enable instruction and
data caches and cache snooping during early hart initialization, and
provide the timer configuration needed for M-mode execution.

Initialize I2C and read the DDR part number from the board's TLV EEPROM.
Populate the RAM driver's platform data before probing it to initialize
DRAM. Set up the DRAM PMA boundary and record the RAM base and size in
global data.

Loading the next boot stage is not yet supported.

Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 arch/riscv/cpu/k3/Kconfig            |   6 +-
 arch/riscv/cpu/k3/Makefile           |   1 +
 arch/riscv/cpu/k3/spl.c              |  52 ++++++++++++++
 arch/riscv/include/asm/arch-k3/csr.h |  20 ++++++
 arch/riscv/include/asm/arch-k3/spl.h |  11 +++
 board/spacemit/k3/Makefile           |   5 ++
 board/spacemit/k3/spl.c              | 127 +++++++++++++++++++++++++++++++++++
 include/configs/spacemit-k3.h        |   3 +
 8 files changed, 224 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/cpu/k3/Kconfig b/arch/riscv/cpu/k3/Kconfig
index 5474ac11243..dee79644b87 100644
--- a/arch/riscv/cpu/k3/Kconfig
+++ b/arch/riscv/cpu/k3/Kconfig
@@ -9,10 +9,14 @@ config SPACEMIT_K3
 	select BINMAN
 	select ARCH_EARLY_INIT_R
 	select SYS_CACHE_SHIFT_6
+	select SUPPORT_SPL
 	imply CPU
 	imply CPU_RISCV
-	imply RISCV_TIMER if RISCV_SMODE
+	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
+	imply RISCV_ACLINT if RISCV_MMODE
+	imply SPL_RISCV_ACLINT if SPL_RISCV_MMODE
 	imply CMD_CPU
+	imply SPL_CPU
 	imply OF_UPSTREAM
 
 endif
diff --git a/arch/riscv/cpu/k3/Makefile b/arch/riscv/cpu/k3/Makefile
index fba4e4b0a3f..6afe6caac69 100644
--- a/arch/riscv/cpu/k3/Makefile
+++ b/arch/riscv/cpu/k3/Makefile
@@ -3,3 +3,4 @@
 # Copyright (C) 2026 Yixun Lan <dlan@kernel.org>
 
 obj-y += dram.o
+obj-$(CONFIG_XPL_BUILD) += spl.o
diff --git a/arch/riscv/cpu/k3/spl.c b/arch/riscv/cpu/k3/spl.c
new file mode 100644
index 00000000000..e8ee32e37fd
--- /dev/null
+++ b/arch/riscv/cpu/k3/spl.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#include <asm/arch/csr.h>
+#include <asm/arch/spl.h>
+#include <asm/csr.h>
+#include <asm/global_data.h>
+#include <dm.h>
+#include <ram.h>
+
+#define K3_DRAM_UPPER_LIMIT_ADDR	0x1100000000ULL
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static void setup_dram_pma(void)
+{
+	csr_write(CSR_X100_PMAADDR8, K3_DRAM_UPPER_LIMIT_ADDR >> 2);
+	asm volatile("sfence.vma zero, zero" ::: "memory");
+}
+
+int spl_dram_init(void)
+{
+	struct ram_info info;
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+	if (ret) {
+		printf("DRAM init failed: %d\n", ret);
+		return ret;
+	}
+
+	setup_dram_pma();
+
+	ret = ram_get_info(dev, &info);
+	if (ret)
+		return ret;
+
+	gd->ram_base = info.base;
+	gd->ram_size = info.size;
+
+	return 0;
+}
+
+void harts_early_init(void)
+{
+	csr_set(CSR_X100_CACHE_CTL, CSR_X100_CACHE_CTL_ICACHE_EN |
+				    CSR_X100_CACHE_CTL_DCACHE_EN);
+	csr_set(CSR_X100_SNOOP_CTL, CSR_X100_SNOOP_CTL_EN);
+}
diff --git a/arch/riscv/include/asm/arch-k3/csr.h b/arch/riscv/include/asm/arch-k3/csr.h
new file mode 100644
index 00000000000..a6c3e6af9f5
--- /dev/null
+++ b/arch/riscv/include/asm/arch-k3/csr.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#ifndef _ASM_ARCH_K3_CSR_H_
+#define _ASM_ARCH_K3_CSR_H_
+
+#include <linux/bitops.h>
+
+#define CSR_X100_CACHE_CTL		0x7c0
+#define  CSR_X100_CACHE_CTL_ICACHE_EN	BIT(1)
+#define  CSR_X100_CACHE_CTL_DCACHE_EN	BIT(0)
+
+#define CSR_X100_SNOOP_CTL		0x7f0
+#define  CSR_X100_SNOOP_CTL_EN		BIT(0)
+
+#define CSR_X100_PMAADDR8		0x7e8
+
+#endif /* _ASM_ARCH_K3_CSR_H_ */
diff --git a/arch/riscv/include/asm/arch-k3/spl.h b/arch/riscv/include/asm/arch-k3/spl.h
new file mode 100644
index 00000000000..7dda93cfda8
--- /dev/null
+++ b/arch/riscv/include/asm/arch-k3/spl.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#ifndef _ASM_ARCH_K3_SPL_H_
+#define _ASM_ARCH_K3_SPL_H_
+
+int spl_dram_init(void);
+
+#endif /* _ASM_ARCH_K3_SPL_H_ */
diff --git a/board/spacemit/k3/Makefile b/board/spacemit/k3/Makefile
new file mode 100644
index 00000000000..67f30a40e6c
--- /dev/null
+++ b/board/spacemit/k3/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+
+obj-$(CONFIG_SPL_BUILD) += spl.o
diff --git a/board/spacemit/k3/spl.c b/board/spacemit/k3/spl.c
new file mode 100644
index 00000000000..4798e5c9ebc
--- /dev/null
+++ b/board/spacemit/k3/spl.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ */
+
+#include <asm/arch/spl.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <display_options.h>
+#include <dm/device.h>
+#include <dm/uclass.h>
+#include <errno.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <soc/spacemit/k3-ddr.h>
+#include <spl.h>
+#include <tlv_eeprom.h>
+
+#define MUX_MODE5		5
+#define EDGE_NONE		BIT(6)
+#define PULL_UP			(6 << 13)
+#define I2C_PIN_CONFIG(x)	((x) | EDGE_NONE | PULL_UP)
+
+#define MFP_GPIO_46		0xd401e0b8
+#define MFP_GPIO_47		0xd401e0bc
+
+#define K3_TLV_CODE_DDR_PART_NUMBER	0x45
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static void i2c_early_init(void)
+{
+	struct udevice *bus;
+
+	/* EEPROM uses I2C2 on GPIO46 and GPIO47. */
+	writel(I2C_PIN_CONFIG(MUX_MODE5), (void __iomem *)MFP_GPIO_46);
+	writel(I2C_PIN_CONFIG(MUX_MODE5), (void __iomem *)MFP_GPIO_47);
+
+	udelay(100);
+
+	uclass_first_device(UCLASS_I2C, &bus);
+	while (bus) {
+		uclass_next_device(&bus);
+		if (!bus)
+			break;
+	}
+}
+
+static int read_ddr_part_number(char *part, size_t part_size)
+{
+	struct tlvinfo_header *header;
+	u8 contents[TLV_INFO_MAX_LEN];
+	struct tlvinfo_tlv *entry;
+	u8 *end;
+	int ret;
+
+	ret = read_tlvinfo_tlv_eeprom(contents, &header, &entry, 0);
+	if (ret)
+		return ret;
+
+	end = (u8 *)(header + 1) + be16_to_cpu(header->totallen);
+
+	while ((u8 *)entry + sizeof(*entry) <= end) {
+		if ((u8 *)entry + sizeof(*entry) + entry->length > end)
+			return -EINVAL;
+
+		if (entry->type == TLV_CODE_CRC_32)
+			break;
+
+		if (entry->type == K3_TLV_CODE_DDR_PART_NUMBER) {
+			if (!entry->length || entry->length >= part_size)
+				return -EINVAL;
+
+			memcpy(part, entry->value, entry->length);
+			part[entry->length] = '\0';
+
+			return 0;
+		}
+
+		entry = (void *)(entry->value + entry->length);
+	}
+
+	return -ENOENT;
+}
+
+static int setup_ddr_plat(void)
+{
+	struct k3_ddr_plat *plat;
+	struct udevice *dev;
+
+	dev = uclass_try_first_device(UCLASS_RAM);
+	if (!dev)
+		return -ENODEV;
+
+	if (!device_is_compatible(dev, "spacemit,k3-ddrc"))
+		return -ENODEV;
+
+	plat = dev_get_plat(dev);
+
+	return read_ddr_part_number(plat->part_number, sizeof(plat->part_number));
+}
+
+int spl_board_init_f(void)
+{
+	int ret;
+
+	i2c_early_init();
+
+	ret = setup_ddr_plat();
+	if (ret) {
+		printf("DDR identification failed: %d\n", ret);
+		return ret;
+	}
+
+	puts("DRAM:  ");
+	ret = spl_dram_init();
+	if (ret)
+		return ret;
+	print_size(gd->ram_size, "\n");
+
+	return 0;
+}
+
+u32 spl_boot_device(void)
+{
+	return BOOT_DEVICE_NONE;
+}
diff --git a/include/configs/spacemit-k3.h b/include/configs/spacemit-k3.h
index 9dd545e2a3b..ccd900ce91c 100644
--- a/include/configs/spacemit-k3.h
+++ b/include/configs/spacemit-k3.h
@@ -8,6 +8,9 @@
 
 #define CFG_SYS_NS16550_IER	0x40
 
+#define RISCV_MMODE_TIMERBASE	0xf1810000
+#define RISCV_MMODE_TIMEROFF	0xbff8
+#define RISCV_MMODE_TIMER_FREQ	24000000
 #define RISCV_SMODE_TIMER_FREQ	24000000
 
 #endif /* __SPACEMIT_K3_H */

-- 
2.56.0

