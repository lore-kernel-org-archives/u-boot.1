Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F340606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LTjRoSJq;
	dkim=pass (1024-bit key) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=POSZjLfw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 133778186E;
	Sat,  7 Nov 2026 12:51:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 07v9hnjCg8z2; Sat,  7 Nov 2026 12:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BA48B81697
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055873;
	b=gtkHiwqPe1HGaubh2MbSA5wgdNT4MmyYO5/0jdxP/k0yPhAQoYXCE9/mTPP1MBLnPoDK
	 TcUp9qLt4qOm0Sv+4u5RTYUKpoHwH3/g0kfC8y/MS9Wsz/7tjW+0RE5uT9bbsEGOH/lZG
	 aTpv2zuJS5lA2M9JWMCLo2T21sdA5ZvC/dyd5bG13hM085CwFQxOtVIiUzL9lwTuk1dyr
	 bGTHzCtsSM/sOAOP71hF27QELFDIK/umQz128IFG+kvgVVmceUV+JfOxY8yn5xSPQMfa6
	 SSf/ZetgBQpJYrXHVMNtuhRq/0ata4C8kCrFscGqicCG0ryvdCTKT2Vvmznv5FMkafQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055873;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pV6GtlYR7TF3sTkGq2vlTZhJnO61EmFvAI+0dDGBzSY=;
	b=CsnuaqJyLqnpZeV0ld8v6OJg1kXdsHQDE7+t8DLwWH0IHDLzdia7NJ8aO2Fbxw68nAAl
	 RiIQ6zFImwoiBVcV8gKb0n9T6xQuW1jUJ/DxhIFByc2e9pPg5+y36YODRnJrV95/j+D3U
	 mEAJcLMjRYOsHgL6LudXwopJrUhfwJxOm4C7fSoqkzPPNyw8zNdzrmtqKzg56rm9ewbZJ
	 rpEoL99gSMVWsG+N9tHi1bcNLuQq05YAbpgnSAKCAm1ei18YrUYwH82Sm9MXgoION1oDt
	 rFSaCGQGrn7IWtnwVEo/GMo4feB3XXXtDz2RMTtyCR5hVr9bhr+AX06XR6ppQPmx11w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055873;
	bh=pV6GtlYR7TF3sTkGq2vlTZhJnO61EmFvAI+0dDGBzSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LTjRoSJqukAHBYBP4fJfVqybfL8PrdmM5ZFdX5065XUcZfcz99xZ5q/ygsoPvH8i8
	 05CHY5mBD0K35yJgY5Kp84TBDOHIb4gO173KebGXKhOhwcNZgrgf7ZO+dkDJMEaTmK
	 zBRxsS8jBUb6KTOzd4r4e4N59ILD/7rzo2EE5kXbJ36rVkZq+mq+3j+KFN3oqRuA49
	 kvJDzyuYER3vPnvQtmN9Zxzu41ScBz7+HYcWH08RM5rCdiSp/LwYPP/bgGAePRu8vp
	 W2ZZ1JTvtNEQzGQsN0Wp32vArBamoxbzhNqAeazrOTFQ0zvy1Ne/+CctmVBkOw61TY
	 ba1R1h+MFlniQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA48B81697;
	Sat,  7 Nov 2026 12:51:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DB321211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C195E400BB
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BpwX89vKtOZK for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 11:54:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D67174009B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=138.232.1.142
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=138.232.1.142;
 helo=lmr1.uibk.ac.at; envelope-from=christian.koever-draxl@student.uibk.ac.at;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=student.uibk.ac.at
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=student.uibk.ac.at
 header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a
 header.b=POSZjLfw
Received: from lmr1.uibk.ac.at (lmr1.uibk.ac.at [138.232.1.142])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D67174009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:33 +0000 (UTC)
Received: from surface-pro-5 (178.115.47.78.wireless.dyn.drei.com
 [178.115.47.78]) (authenticated bits=0)
 by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 6A7Bivn1711658
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 7 Nov 2026 12:45:18 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 6A7Bivn1711658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
 s=prod24a; t=1794051919;
 bh=pV6GtlYR7TF3sTkGq2vlTZhJnO61EmFvAI+0dDGBzSY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=POSZjLfwh4R+J1MAAO51NPEGmuqDQP2lWEcXTTuJ50h4KfiTNhzC2NEfwpaPBq+JR
 dcYqTGlt62ippQ7tOhN+V8oa9bQ+TthQ8MC4Jkqova9zPQqNfY6KmDcHqMeHbYfA8A
 VIHfOmFQiHYbzp+uu3Arg1j+1eBZ1ZCU+7QXPGsU=
From: christian.koever-draxl@student.uibk.ac.at
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, uboot-stm32@st-md-mailman.stormreply.com,
 =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>,
 "Claude Opus 5.5" <noreply@anthropic.com>
Subject: [RFC PATCH 10/10] board: st: stm32l4r5zi-nucleo: enable bootapp
Date: Sat,  7 Nov 2026 12:44:55 +0100
Message-ID: <20261107114455.304896-11-christian.koever-draxl@student.uibk.ac.at>
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

Enable the bootapp command and let it accept vector tables in the
internal flash, where applications are placed right after U-Boot
(0x08040000). Document how to start them.

This patch was written with heavy use of an AI coding assistant
(Claude Code, model Claude Opus 5.5), reviewed by the submitter and
tested on a NUCLEO-L4R5ZI; see the cover letter for details.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 board/st/stm32l4r5zi-nucleo/stm32l4r5zi-nucleo.c | 15 +++++++++++++++
 configs/stm32l4r5zi-nucleo_defconfig             |  1 +
 doc/board/st/stm32_MCU.rst                       | 11 +++++++++++
 3 files changed, 27 insertions(+)

diff --git a/board/st/stm32l4r5zi-nucleo/stm32l4r5zi-nucleo.c b/board/st/stm32l4r5zi-nucleo/stm32l4r5zi-nucleo.c
index 5854e757..ee9a14b6 100644
--- a/board/st/stm32l4r5zi-nucleo/stm32l4r5zi-nucleo.c
+++ b/board/st/stm32l4r5zi-nucleo/stm32l4r5zi-nucleo.c
@@ -13,6 +13,10 @@
 #include <vsprintf.h>
 #include <asm/io.h>
 #include <asm/arch/stm32.h>
+#include <asm/global_data.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 /*
  * U-Boot keeps its stack, malloc area and device tree in SRAM1 + SRAM2;
@@ -35,6 +39,17 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	return STM32L4R5_SRAM3_BASE;
 }
 
+/* bootapp: applications may also run from the internal flash */
+bool bootapp_addr_valid(ulong addr, ulong len)
+{
+	ulong size = (readl(STM32_FLASH_SIZE_REG) & 0xffff) * SZ_1K;
+
+	if (addr >= STM32_FLASH_BASE && addr - STM32_FLASH_BASE + len <= size)
+		return true;
+
+	return addr >= gd->ram_base && addr - gd->ram_base + len <= gd->ram_size;
+}
+
 int board_early_init_f(void)
 {
 	struct udevice *dev;
diff --git a/configs/stm32l4r5zi-nucleo_defconfig b/configs/stm32l4r5zi-nucleo_defconfig
index c57cdb3a..da3e0e06 100644
--- a/configs/stm32l4r5zi-nucleo_defconfig
+++ b/configs/stm32l4r5zi-nucleo_defconfig
@@ -22,6 +22,7 @@ CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_MISC_INIT_R=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="U-Boot > "
+CONFIG_CMD_BOOTAPP=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_SETEXPR is not set
diff --git a/doc/board/st/stm32_MCU.rst b/doc/board/st/stm32_MCU.rst
index 25965674..a521df7f 100644
--- a/doc/board/st/stm32_MCU.rst
+++ b/doc/board/st/stm32_MCU.rst
@@ -198,3 +198,14 @@ not relocated. Its stack, malloc area and device tree stay in SRAM1 + SRAM2;
 SRAM3 (0x20040000 - 0x2009ffff) is left free for applications.
 
 The console is LPUART1, connected to the ST-Link virtual COM port.
+
+Bare-metal applications linked to run from reset at 0x08040000 (vector table
+first) are started with::
+
+  => bootapp 0x08040000
+
+bootapp checks the stack pointer and reset vector in the vector table, then
+disables interrupts, SysTick and the MPU, sets VTOR and MSP and jumps to the
+reset handler. The application inherits the clock tree set up by U-Boot
+(SYSCLK 120 MHz from the PLL) and must enable interrupts itself.
+
-- 
2.56.0

