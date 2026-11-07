Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFB8606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EzK3b2r1;
	dkim=pass (1024-bit key) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=Ni7w69xK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2DC781602;
	Sat,  7 Nov 2026 12:51:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id llRrt5AoueMK; Sat,  7 Nov 2026 12:51:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 66EAC817B1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055875;
	b=HheXf655Ejj+iJRxgwR9wW5qGAoKBl/Zq6PuZZibBK8pJcvmuW8B5cgVCeh+XS8uWFPZ
	 jqCGn1ts9RztkC0hFrhS9Mg9QZ9jOs26OLA5u5YzeqO+C5pDE/uWkIlM5mo9G3KNf9k4J
	 eYN9xIsKa0LqfXjGk1Z42IBIt/nsWj3b6pHT+LMwDz1fxVisAaVv1uqkHmyDnrxe7RwEH
	 6ZsCsulwwYq1u2Lo4i/cc0kiM2EM3/E+fxx3NOyZUb6hHFhBCZpz+pQbuehz8A/rcjv3A
	 fbrXIg2TAJdtsHc/jGVgyWPoXY8mmYa7NU+HCL3A6vjxkCM2veLNFPnwPbUbOT4toEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055875;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3upXSW7QD+5yF5BF+o4ru9F2zXK0fRNCkEKjmJGShts=;
	b=cbV4W3yfIwze3XxUYT8w0Pla1yAlzACCw5w7RUxoipB4u4vjwXTQMQBP34XJ4BZGOb6H
	 lDNUSR27OiW+PAudYOkahStZXoX2HEPEMrcu/lxy3KA8gkTEGgqwsE/qcMbNUofPEVEYq
	 n+dL0yorqOgBjdY7YJZhOSqrcJ9QqUyCVTRK98nS+pw6/fXvhmMS7QwN8Aedi471hAbvK
	 SuIXAntKI/7MUWk5PKq32g1+Pao6lRvHp1YhNoaUkE0Hkekeodqc3Odl6goFGsbc8ZzUx
	 5Rkl4Qn8SnlhMsgw/gG0zakltH5l67MpVcryoZAsj2BHLg70n4GBdE3cwuOHEcAVLHw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055875;
	bh=3upXSW7QD+5yF5BF+o4ru9F2zXK0fRNCkEKjmJGShts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EzK3b2r11HvbYHmIMj/dStaaIzfnCQPoT++WA0o2BDpvyO+x6Z71xlsdOMYc1EI9E
	 +KIbVFFOXb8p5j+9UjqbrAZiFaA6otNOOLqtqc99teJ61sBgAkHgwSfRh3Iz42kVBv
	 947lyaSnXImL7j3Cw+tdnWh/KgGUebEddUDMSqsmgA1oRohuDfHe8SdDRTuVtY51CD
	 tbroUi5ERlocWAqxR8RdhYxOoIGn6wwe5xQHTxu6kcJitWKCLwTHEevJ8BQGTqGhrT
	 regoCi3A1aa/z0TCisXsh2zwJmXpgUHFnJpW6Kmuzq3TfB6ys2kSVRCk2o4VQjxG64
	 hqJNJ/k4myz8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66EAC817B1;
	Sat,  7 Nov 2026 12:51:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id ED8EF2E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D419A400BB
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HBhw-DAvdrH6 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 11:54:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DA8F84009B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=138.232.1.142
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=138.232.1.142;
 helo=lmr1.uibk.ac.at; envelope-from=christian.koever-draxl@student.uibk.ac.at;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=student.uibk.ac.at
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=student.uibk.ac.at
 header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a
 header.b=Ni7w69xK
Received: from lmr1.uibk.ac.at (lmr1.uibk.ac.at [138.232.1.142])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DA8F84009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:34 +0000 (UTC)
Received: from surface-pro-5 (178.115.47.78.wireless.dyn.drei.com
 [178.115.47.78]) (authenticated bits=0)
 by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 6A7Bivmv711658
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 7 Nov 2026 12:45:12 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 6A7Bivmv711658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
 s=prod24a; t=1794051913;
 bh=3upXSW7QD+5yF5BF+o4ru9F2zXK0fRNCkEKjmJGShts=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ni7w69xK5oinE/a9Cf1nICHNQSiJZAR6Ir5TQvW7GUYl1bojF7ON7rTWFudzh6LPu
 hjw+mlHD9YJew4dK51tDexkg9VX79vvOTqnhcwGicYv+7ljAS7UcA0xJJafPC5EOIr
 IooUznwlv+LnqJmhm0v+MxIpZhcNFeWrteR/D9GE=
From: christian.koever-draxl@student.uibk.ac.at
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, uboot-stm32@st-md-mailman.stormreply.com,
 =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>,
 "Claude Opus 5.5" <noreply@anthropic.com>
Subject: [RFC PATCH 06/10] arm: stm32: add STM32L4 family
Date: Sat,  7 Nov 2026 12:44:51 +0100
Message-ID: <20261107114455.304896-7-christian.koever-draxl@student.uibk.ac.at>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Stefan Kövér-Draxl <ckoever@outlook.de>

Add the STM32L4/L4+ family (Cortex-M4) to mach-stm32. These parts have
no external memory controller, so unlike F4/F7/H7 the family does not
select RAM/STM32_SDRAM. The F4 MPU setup applies unchanged.

This patch was written with heavy use of an AI coding assistant
(Claude Code, model Claude Opus 5.5), reviewed by the submitter and
tested on a NUCLEO-L4R5ZI; see the cover letter for details.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 arch/arm/include/asm/arch-stm32l4/stm32.h | 34 +++++++++++++++++++++++
 arch/arm/mach-stm32/Kconfig               | 17 ++++++++++++
 arch/arm/mach-stm32/soc.c                 |  2 +-
 3 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/asm/arch-stm32l4/stm32.h

diff --git a/arch/arm/include/asm/arch-stm32l4/stm32.h b/arch/arm/include/asm/arch-stm32l4/stm32.h
new file mode 100644
index 00000000..88cfda4a
--- /dev/null
+++ b/arch/arm/include/asm/arch-stm32l4/stm32.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026
+ * Author(s): Christian Stefan Kövér-Draxl <ckoever@outlook.de>
+ *
+ * STM32L4/L4+ SoC definitions
+ */
+
+#ifndef _ASM_ARCH_HARDWARE_H
+#define _ASM_ARCH_HARDWARE_H
+
+#include <linux/types.h>
+
+#define STM32_FLASH_BASE	0x08000000
+
+#define STM32_SYSMEM_BASE	0x1FFF0000
+#define STM32_PERIPH_BASE	0x40000000
+#define STM32_AHB1PERIPH_BASE	(STM32_PERIPH_BASE + 0x00020000)
+
+#define STM32_FLASH_CNTL_BASE	(STM32_AHB1PERIPH_BASE + 0x2000)
+
+/* RM0432 "Device electronic signature" */
+#define STM32_U_ID_BASE		(STM32_SYSMEM_BASE + 0x7590)
+#define STM32_FLASH_SIZE_REG	(STM32_SYSMEM_BASE + 0x75E0)
+
+struct stm32_u_id_regs {
+	u32 u_id_low;
+	u32 u_id_mid;
+	u32 u_id_high;
+};
+
+#define STM32_U_ID	((struct stm32_u_id_regs *)STM32_U_ID_BASE)
+
+#endif /* _ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 1c6de559..1fe4285d 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -52,6 +52,23 @@ config STM32H7
 	select TIMER
 	imply OF_UPSTREAM
 
+config STM32L4
+	bool "stm32l4 family"
+	select CLK
+	select DM_GPIO
+	select DM_RESET
+	select MISC
+	select PINCTRL
+	select PINCTRL_STM32
+	select STM32_RCC
+	select STM32_SERIAL
+	select STM32_TIMER
+	select TIMER
+	help
+	  Support for the STM32L4 / STM32L4+ family of Cortex-M4 MCUs.
+	  These parts have no external memory controller, so U-Boot runs
+	  from internal flash and uses internal SRAM only.
+
 source "arch/arm/mach-stm32/stm32f4/Kconfig"
 source "arch/arm/mach-stm32/stm32f7/Kconfig"
 source "arch/arm/mach-stm32/stm32h7/Kconfig"
diff --git a/arch/arm/mach-stm32/soc.c b/arch/arm/mach-stm32/soc.c
index 737e6809..7dec6e8a 100644
--- a/arch/arm/mach-stm32/soc.c
+++ b/arch/arm/mach-stm32/soc.c
@@ -16,7 +16,7 @@ int arch_cpu_init(void)
 		/*
 		 * Make SDRAM area cacheable & executable.
 		 */
-#if defined(CONFIG_STM32F4)
+#if defined(CONFIG_STM32F4) || defined(CONFIG_STM32L4)
 		{ 0x00000000, REGION_0, XN_DIS, PRIV_RW_USR_RW,
 		O_I_WB_RD_WR_ALLOC, REGION_512MB },
 #endif
-- 
2.56.0

