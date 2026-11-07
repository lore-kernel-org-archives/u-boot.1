Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF64606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K8h/pIc2;
	dkim=pass (1024-bit key) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=Dt/sHp8U
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2C7E819BC;
	Sat,  7 Nov 2026 12:51:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HNNK4jPZn5ll; Sat,  7 Nov 2026 12:51:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2C399815D2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055883;
	b=pllaiwVB/fL+EJc0J5esdTj0es/uPsH1gM1/s1eKimsQiDo+7Qk71D4Og+3Ee+C1L3YB
	 3GQIqW07mZDWI2VCmCVmFLydNOMh31MICUwnvlapEnLowBnO/EYmTpR5kMaviwrsCediO
	 Yqjmr8P/xlcFDd5buBBJYCfto+rLPa040N6mgK7SOwXmNTjLcUSbrl0K9JZGl9ghIGzGX
	 igIp5S2imUapqhyp/b5Grg13QvVLDZTvZ+WZ8L3VP5zLpLpZgQhyZviph3gnqf1Zndi8N
	 DJaZbKklU1/s3EipaTePtcDTeSapv4Is88ni3qo5YjznIJ+DYL7FD3vHZzAEmQ4xZlw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055883;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WZE9f2CBqSAzyBBZPCE7zkIYIWyTpp2UxEjwPzKQzps=;
	b=o4PCTRwehs1/rA70cNnzfc2NujWgSLaOXSCIupI51Ktraw9Yu3EwiZkQpeJ8AXP72Vuo
	 DKmdgWO387S5wMcfZ3k1LxZRsCXNQ3jqVHn7IkrQYomuMuDN7pXi1vu3gTj+3Y0/Uv+/B
	 pzPuBUVmMDN5lXB7oI6Npc/AXPw3RB5rVr2DajhMVy43cLw+WJB4UReR38ODWDNW+GUoq
	 yt6mUq+EJT+PVo82MkLEknsMoklokQGvQ5SK/EIsJzf7Q0EUR+DSq3iim1epjyBTAhYsL
	 U+NrqoRICfKd0Go5FzA2zYSdt1nGbven+FnAC2QkSn/hB6EEgA2XdF6sgv8I6q2G9Lg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055883;
	bh=WZE9f2CBqSAzyBBZPCE7zkIYIWyTpp2UxEjwPzKQzps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K8h/pIc2B6aTq3B6d6fCfjh8C0HThPOadPTXhrxtWR7ue00OMHpigTTjrTu7B+lAi
	 MTaOQkqeKyUvrc5GTT8Uys2OYOp0CUFuyFS1EeTDzqhHVLuKXsL2IiklkMDBxOCOPr
	 jmVLdfWsX9U8m6vOb7w+YAmNEo0HE0nJubGlL9LZxi58IP3FyFeEnYK64Jr26FCnCl
	 1GahKKoe1ae1Ssw3Ndl17103X9B9P4VbWFKlhvRkn7HJHrJnIWhFSG05jhOJR4eyn1
	 f1IGoE8MXhVS2G1cRw4LAUtGDUOFGMBk3eww/q172Ora/TI2of0TRLX8boQ9hl7yAU
	 WuY4kkeBP3sUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C399815D2;
	Sat,  7 Nov 2026 12:51:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 44D342FE
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B5114009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lrdfd86IjuGl for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 11:54:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 16914400BB
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=138.232.1.142
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=138.232.1.142;
 helo=lmr1.uibk.ac.at; envelope-from=christian.koever-draxl@student.uibk.ac.at;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=student.uibk.ac.at
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=student.uibk.ac.at
 header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a
 header.b=Dt/sHp8U
Received: from lmr1.uibk.ac.at (lmr1.uibk.ac.at [138.232.1.142])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 16914400BB
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:37 +0000 (UTC)
Received: from surface-pro-5 (178.115.47.78.wireless.dyn.drei.com
 [178.115.47.78]) (authenticated bits=0)
 by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 6A7Bivn0711658
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 7 Nov 2026 12:45:17 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 6A7Bivn0711658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
 s=prod24a; t=1794051917;
 bh=WZE9f2CBqSAzyBBZPCE7zkIYIWyTpp2UxEjwPzKQzps=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Dt/sHp8U9dYUFZMcWjFXierrW+0aqq8qygy97iDNl0ns4jaRzqlpjCEBct/xLgKBF
 K+g6gjjiHm34I5sJI77fD/Du5o+IBNdQrf0Hu+uiDoneYRXJOcILTHjoIN7zD1z3d0
 2fYrbpptG/lp6w/3bDczCcuPUgGWtTdGDYvGtEOk=
From: christian.koever-draxl@student.uibk.ac.at
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, uboot-stm32@st-md-mailman.stormreply.com,
 =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>,
 "Claude Opus 5.5" <noreply@anthropic.com>
Subject: [RFC PATCH 09/10] cmd: add bootapp command for ARMv7-M
Date: Sat,  7 Nov 2026 12:44:54 +0100
Message-ID: <20261107114455.304896-10-christian.koever-draxl@student.uibk.ac.at>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107114455.304896-1-christian.koever-draxl@student.uibk.ac.at>
References: <20261107114455.304896-1-christian.koever-draxl@student.uibk.ac.at>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang_3.2_at_uibk.ac.at
X-Mailman-Approved-At: Sat, 07 Nov 2026 12:50:14 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

Add "bootapp <addr>" to start a bare-metal Cortex-M application from
its vector table. The command checks VTOR alignment, that the initial
stack pointer lies in RAM and that the reset vector is a Thumb address
in readable memory, then hands over the way a reset would: interrupts,
SysTick and MPU disabled, NVIC enables and pending bits cleared,
VTOR = <addr>, MSP loaded from the table and a jump to the reset
handler. Applications linked to run from reset at that address
therefore run unchanged.

Boards with execute-in-place flash can override bootapp_addr_valid()
to also accept flash addresses.

Add the NVIC, SysTick and ICSR definitions it needs to asm/armv7m.h.

This patch was written with heavy use of an AI coding assistant
(Claude Code, model Claude Opus 5.5), reviewed by the submitter and
tested on a NUCLEO-L4R5ZI; see the cover letter for details.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 arch/arm/include/asm/armv7m.h |   9 +++
 cmd/Kconfig                   |   7 ++
 cmd/Makefile                  |   1 +
 cmd/bootapp.c                 | 126 ++++++++++++++++++++++++++++++++++
 4 files changed, 143 insertions(+)
 create mode 100644 cmd/bootapp.c

diff --git a/arch/arm/include/asm/armv7m.h b/arch/arm/include/asm/armv7m.h
index ad67b4fa..d2c0e798 100644
--- a/arch/arm/include/asm/armv7m.h
+++ b/arch/arm/include/asm/armv7m.h
@@ -51,6 +51,15 @@ struct v7m_scb {
 #define V7M_AIRCR_SYSRESET		(1 << 2)
 
 #define V7M_ICSR_VECTACT_MSK		0xFF
+#define V7M_ICSR_PENDSTCLR		(1 << 25)
+#define V7M_ICSR_PENDSVCLR		(1 << 27)
+
+/* NVIC: 8 banks of 32 interrupt enable/pending bits */
+#define V7M_NVIC_BANKS			8
+#define V7M_NVIC_ICER0			(V7M_NVIC_BASE + 0x080)
+#define V7M_NVIC_ICPR0			(V7M_NVIC_BASE + 0x180)
+
+#define V7M_SYST_CSR			(V7M_SCS_BASE + 0x010)
 
 #define V7M_CCR_DCACHE			16
 #define V7M_CCR_ICACHE			17
diff --git a/cmd/Kconfig b/cmd/Kconfig
index ff90a870..378c87f6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -593,6 +593,13 @@ config CMD_GO
 	help
 	  Start an application at a given address.
 
+config CMD_BOOTAPP
+	bool "bootapp"
+	depends on CPU_V7M
+	help
+	  Start a bare-metal ARMv7-M application from its vector table, as
+	  after a reset: VTOR, MSP and entry point are taken from the table.
+
 config CMD_RUN
 	bool "run"
 	default y
diff --git a/cmd/Makefile b/cmd/Makefile
index ce772e55..de62adcd 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_CMD_BLKMAP) += blkmap.o
 obj-$(CONFIG_CMD_BLOBLIST) += bloblist.o
 obj-$(CONFIG_CMD_BLOCK_CACHE) += blkcache.o
 obj-$(CONFIG_CMD_BMP) += bmp.o
+obj-$(CONFIG_CMD_BOOTAPP) += bootapp.o
 obj-$(CONFIG_CMD_BOOTCOUNT) += bootcount.o
 obj-$(CONFIG_CMD_BOOTEFI) += bootefi.o
 obj-$(CONFIG_CMD_BOOTMENU) += bootmenu.o
diff --git a/cmd/bootapp.c b/cmd/bootapp.c
new file mode 100644
index 00000000..67246d64
--- /dev/null
+++ b/cmd/bootapp.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026
+ * Author(s): Christian Stefan Kövér-Draxl <ckoever@outlook.de>
+ *
+ * bootapp: start a bare-metal ARMv7-M application as if from reset
+ */
+
+#include <command.h>
+#include <irq_func.h>
+#include <vsprintf.h>
+#include <asm/armv7_mpu.h>
+#include <asm/armv7m.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <linux/errno.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* VTOR alignment: the table size rounded up, 512 bytes covers 112 vectors */
+#define BOOTAPP_VTOR_ALIGN	0x200
+
+static bool in_dram(ulong addr, ulong len, bool end_inclusive)
+{
+	int i;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		ulong start = gd->dram[i].start;
+		ulong size = gd->dram[i].size;
+
+		if (!size || addr < start)
+			continue;
+		if (end_inclusive ? addr - start <= size :
+				    addr - start + len <= size)
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * bootapp_addr_valid() - check that memory at an address can be read/executed
+ *
+ * @addr: start address
+ * @len: number of bytes
+ * Return: true if [addr, addr + len) is in RAM or other memory the board
+ *	   allows. Boards with execute-in-place flash override this.
+ */
+__weak bool bootapp_addr_valid(ulong addr, ulong len)
+{
+	return in_dram(addr, len, false);
+}
+
+static void __noreturn bootapp_jump(ulong addr, u32 sp, u32 pc)
+{
+	int i;
+
+	disable_interrupts();
+	__asm__ volatile ("cpsid i" ::: "memory");
+
+	/* Stop SysTick and clear everything that could still be pending */
+	writel(0, V7M_SYST_CSR);
+	for (i = 0; i < V7M_NVIC_BANKS; i++) {
+		writel(0xffffffff, V7M_NVIC_ICER0 + 4 * i);
+		writel(0xffffffff, V7M_NVIC_ICPR0 + 4 * i);
+	}
+	writel(V7M_ICSR_PENDSTCLR | V7M_ICSR_PENDSVCLR, &V7M_SCB->icsr);
+
+	/* The application expects the default memory map, as after reset */
+	if (IS_ENABLED(CONFIG_SYS_ARM_MPU))
+		disable_mpu();
+
+	writel(addr, &V7M_SCB->vtor);
+	__asm__ volatile ("dsb\n\tisb" ::: "memory");
+
+	/* PRIMASK stays set; the application enables interrupts itself */
+	__asm__ volatile ("msr msp, %0\n\t"
+			  "bx %1\n\t"
+			  : : "r" (sp), "r" (pc) : "memory");
+	unreachable();
+}
+
+static int do_bootapp(struct cmd_tbl *cmdtp, int flag, int argc,
+		      char *const argv[])
+{
+	ulong addr;
+	u32 sp, pc;
+
+	if (argc != 2)
+		return CMD_RET_USAGE;
+
+	addr = hextoul(argv[1], NULL);
+	if (addr % BOOTAPP_VTOR_ALIGN) {
+		printf("bootapp: 0x%08lx is not %d-byte aligned\n", addr,
+		       BOOTAPP_VTOR_ALIGN);
+		return CMD_RET_FAILURE;
+	}
+
+	/* Reading an unmapped address would fault: check before touching it */
+	if (!bootapp_addr_valid(addr, 8)) {
+		printf("bootapp: 0x%08lx is not in flash or RAM\n", addr);
+		return CMD_RET_FAILURE;
+	}
+
+	sp = readl(addr);
+	pc = readl(addr + 4);
+
+	/* Initial SP in RAM (may equal the end of a bank), Thumb entry point */
+	if (sp % 4 || !in_dram(sp, 0, true) || !(pc & 1) ||
+	    !bootapp_addr_valid(pc & ~1UL, 2)) {
+		printf("bootapp: no valid vector table at 0x%08lx (SP 0x%08x, PC 0x%08x)\n",
+		       addr, sp, pc);
+		return CMD_RET_FAILURE;
+	}
+
+	printf("## Starting application at 0x%08lx (SP 0x%08x, entry 0x%08x)\n",
+	       addr, sp, pc);
+
+	bootapp_jump(addr, sp, pc);
+}
+
+U_BOOT_CMD(bootapp, 2, 0, do_bootapp,
+	   "start a bare-metal application from its vector table",
+	   "<addr>\n"
+	   "    - start the application whose vector table is at <addr>\n"
+	   "      as after a reset (interrupts, SysTick, MPU off; VTOR = addr)");
-- 
2.56.0

