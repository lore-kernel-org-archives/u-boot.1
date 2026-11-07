Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D9B606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T9Cg9S//;
	dkim=pass (1024-bit key) header.d=student.uibk.ac.at header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a header.b=eaTRAeeo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5FF3D817BD;
	Sat,  7 Nov 2026 12:51:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hr4hcQLxriMm; Sat,  7 Nov 2026 12:51:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5883E8177A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055880;
	b=WrYy8im7edfcv8fQSKMwm3U/Q1LM7w4LMj/i17GrR21kKRZ9gBjZIlwVLtG4wDI+/eck
	 sQtZt7+ItJJB//N2GeRro/3zCFe/X/A/xdkjNMM4gVhPSw8keNxHniuPYrbGn/9+8YShH
	 S89bI9czVXufTvCEd04ZgFQJgD0AL/mKdn/5RzjQtQcqN8h4vnLiLLmZ83MfoCRcI1+Ua
	 RKtNhPut4kcH5rfV+MzxcPjXh1qiFj5q0k8GPrj4RI8T2BrbHbWsF5F+h4hMo7oNEeX91
	 C/Ex6StBDXO94Vuo+l8yrax/1enIA7FgusW8PTr2CZpjuCdKAZSKMyrAtDfN4Nory5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055880;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Q2tI/z3bBwXbZ3awQKj2KzlyWyZ/4j5TmHvplt8a4YM=;
	b=VfIE1tGiKAQg7lkPREriiF8LqAsPDvHQxYv9ULxfSGk3VmRWecMlmnSRx5vlIIjm17M3
	 sRk1zoO5HlfOIA0DP4CBSeRtWD2NoT5U2F0ZCkPCX9k6AkoRuz0FoVUP2Jb564b3EcacA
	 g26aSlWve27cEVj3aFiq4dpX2v3t6V8fd2hqoLVbtW8RZLcqZV7XyAfZ16dKMgvJ+3tfl
	 0yHeMOb4bB11kamQ+bMbBr5U3BnfPCM+6Y6I3hcAac6ITq3r/vJrkB1BWDnnu06JESH84
	 7+26HXhqTJEf1bnht/34ILeaodp+058uudFPKvcecB66+mxbtDyfczk0HIJVNB8oO6g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055880;
	bh=Q2tI/z3bBwXbZ3awQKj2KzlyWyZ/4j5TmHvplt8a4YM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T9Cg9S//Fj+C1TjUV0eNJK7CNmPf/cRMi37/3+GzgboEKkWHZTYKmO9qusHHRney4
	 hhFwFDB6r6uK67SBttOL2evu/MDot3fhbDSCVPS/s9Bjc7mxWHHyq5rmUQuCD7oGKN
	 mO6KU7jwKzAT4u/9VHuwJltcKmttHWxNErx8wQ8r8R/M/wi29cOnkm9pJf9zozJWAD
	 zy+SJ1/0kIiBLA4KrvAIW2rfDNXqzHO4z6yMKRgzpWp4DE3GvR3HeaZ+3u2PdC8+a6
	 1JElWpuF9GCinKgC6XqelV8YOlqxMkjVHpSsWwyitxESSvINrdXNO9GFM4FDoBMUlN
	 5C6Sh2bTvUbPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5883E8177A;
	Sat,  7 Nov 2026 12:51:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 27E002E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1974040111
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id udKNFz4J1_Dq for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 11:54:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 127A14009B
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=138.232.1.142
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=138.232.1.142;
 helo=lmr1.uibk.ac.at; envelope-from=christian.koever-draxl@student.uibk.ac.at;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=student.uibk.ac.at
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=student.uibk.ac.at
 header.i=@student.uibk.ac.at header.a=rsa-sha256 header.s=prod24a
 header.b=eaTRAeeo
Received: from lmr1.uibk.ac.at (lmr1.uibk.ac.at [138.232.1.142])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 127A14009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 11:54:36 +0000 (UTC)
Received: from surface-pro-5 (178.115.47.78.wireless.dyn.drei.com
 [178.115.47.78]) (authenticated bits=0)
 by smtp.uibk.ac.at (8.15.2/8.15.2/F1) with ESMTPSA id 6A7Bivmu711658
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 7 Nov 2026 12:45:11 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.uibk.ac.at 6A7Bivmu711658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=student.uibk.ac.at;
 s=prod24a; t=1794051911;
 bh=Q2tI/z3bBwXbZ3awQKj2KzlyWyZ/4j5TmHvplt8a4YM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eaTRAeeo39bjhRVH+9V5H+3oL0cyy54KQXdvSwLrQI0/Yzi2OMND5/AhBVAv5JV9K
 A1K4sCGQxLzfUegAfcVanb/6lVKrhdcBepVz8HZ1DJ1iGDhaJ9VsHO5puNFraFVvZ9
 H3/BxKCBy1XjS01Rq8RMt3Hq2xkfCnxMNALvFiOM=
From: christian.koever-draxl@student.uibk.ac.at
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, patrice.chotard@foss.st.com,
 patrick.delaunay@foss.st.com, uboot-stm32@st-md-mailman.stormreply.com,
 =?UTF-8?q?Christian=20Stefan=20K=C3=B6v=C3=A9r-Draxl?= <ckoever@outlook.de>,
 "Claude Opus 5.5" <noreply@anthropic.com>
Subject: [RFC PATCH 05/10] serial: stm32: add LPUART support
Date: Sat,  7 Nov 2026 12:44:50 +0100
Message-ID: <20261107114455.304896-6-christian.koever-draxl@student.uibk.ac.at>
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

The STM32L4 LPUART shares the USART register offsets of the F7/H7
generation (RM0432 section 51.7), but its baud rate generator differs:
BRR = 256 * fck / baud, 20 bits wide with a minimum of 0x300, and there
is no oversampling selection. Add an info flag and compatible for it,
pick the smallest LPUART_PRESC prescaler that keeps BRR in range, and
let setbrg report -EINVAL for rates that cannot be generated.

Also allow STM32_SERIAL on STM32L4.

This patch was written with heavy use of an AI coding assistant
(Claude Code, model Claude Opus 5.5), reviewed by the submitter and
tested on a NUCLEO-L4R5ZI; see the cover letter for details.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Christian Stefan Kövér-Draxl <ckoever@outlook.de>
---
 drivers/serial/Kconfig        |  4 +--
 drivers/serial/serial_stm32.c | 56 ++++++++++++++++++++++++++++++-----
 drivers/serial/serial_stm32.h | 11 +++++++
 3 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index ffc58d66..92d45567 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1100,9 +1100,9 @@ config STI_ASC_SERIAL
 
 config STM32_SERIAL
 	bool "STMicroelectronics STM32 SoCs on-chip UART"
-	depends on DM_SERIAL && (STM32F4 || STM32F7 || STM32H7 || ARCH_STM32MP)
+	depends on DM_SERIAL && (STM32F4 || STM32F7 || STM32H7 || STM32L4 || ARCH_STM32MP)
 	help
-	  If you have a machine based on a STM32 F4, F7, H7 or MP1 SOC
+	  If you have a machine based on a STM32 F4, F7, H7, L4 or MP1 SOC
 	  you can enable its onboard serial ports, say Y to this option.
 	  If unsure, say N.
 
diff --git a/drivers/serial/serial_stm32.c b/drivers/serial/serial_stm32.c
index 1675a9cb..05edabec 100644
--- a/drivers/serial/serial_stm32.c
+++ b/drivers/serial/serial_stm32.c
@@ -12,6 +12,7 @@
 #include <reset.h>
 #include <serial.h>
 #include <watchdog.h>
+#include <div64.h>
 #include <asm/io.h>
 #include <asm/arch/stm32.h>
 #include <dm/device_compat.h>
@@ -29,15 +30,53 @@
  */
 #define ONE_BYTE_B115200_US		87
 
-static void _stm32_serial_setbrg(void __iomem *base,
-				 struct stm32_uart_info *uart_info,
-				 u32 clock_rate,
-				 int baudrate)
+/* LPUART_PRESC encodings 0..11 (RM0432 51.7.12) */
+static const u16 lpuart_presc_div[] = {
+	1, 2, 4, 6, 8, 10, 12, 16, 32, 64, 128, 256,
+};
+
+/*
+ * LPUART: BRR = 256 * (fck / prescaler) / baud, 20 bits wide, >= 0x300.
+ * Use the smallest prescaler that brings BRR into range.
+ */
+static int _stm32_lpuart_setbrg(void __iomem *base, u8 uart_enable_bit,
+				u32 clock_rate, int baudrate)
+{
+	u64 div = 0;
+	int presc;
+
+	for (presc = 0; presc < ARRAY_SIZE(lpuart_presc_div); presc++) {
+		u64 den = (u64)baudrate * lpuart_presc_div[presc];
+
+		div = DIV_ROUND_CLOSEST_ULL(256ULL * clock_rate, den);
+		if (div <= LPUART_BRR_MAX)
+			break;
+	}
+	if (div < LPUART_BRR_MIN || div > LPUART_BRR_MAX)
+		return -EINVAL;
+
+	/* BRR register must be set when uart is disabled */
+	clrbits_le32(base + CR1_OFFSET(false), BIT(uart_enable_bit));
+	writel(presc, base + LPUART_PRESC_OFFSET);
+	writel(div, base + BRR_OFFSET(false));
+	setbits_le32(base + CR1_OFFSET(false), BIT(uart_enable_bit));
+
+	return 0;
+}
+
+static int _stm32_serial_setbrg(void __iomem *base,
+				struct stm32_uart_info *uart_info,
+				u32 clock_rate,
+				int baudrate)
 {
 	bool stm32f4 = uart_info->stm32f4;
 	u32 int_div, mantissa, fraction, oversampling;
 	u8 uart_enable_bit = uart_info->uart_enable_bit;
 
+	if (uart_info->lpuart)
+		return _stm32_lpuart_setbrg(base, uart_enable_bit, clock_rate,
+					    baudrate);
+
 	/* BRR register must be set when uart is disabled */
 	clrbits_le32(base + CR1_OFFSET(stm32f4), BIT(uart_enable_bit));
 
@@ -57,16 +96,16 @@ static void _stm32_serial_setbrg(void __iomem *base,
 	writel(mantissa | fraction, base + BRR_OFFSET(stm32f4));
 
 	setbits_le32(base + CR1_OFFSET(stm32f4), BIT(uart_enable_bit));
+
+	return 0;
 }
 
 static int stm32_serial_setbrg(struct udevice *dev, int baudrate)
 {
 	struct stm32x7_serial_plat *plat = dev_get_plat(dev);
 
-	_stm32_serial_setbrg(plat->base, plat->uart_info,
-			     plat->clock_rate, baudrate);
-
-	return 0;
+	return _stm32_serial_setbrg(plat->base, plat->uart_info,
+				    plat->clock_rate, baudrate);
 }
 
 static int stm32_serial_setconfig(struct udevice *dev, uint serial_config)
@@ -243,6 +282,7 @@ static const struct udevice_id stm32_serial_id[] = {
 	{ .compatible = "st,stm32-uart", .data = (ulong)&stm32f4_info},
 	{ .compatible = "st,stm32f7-uart", .data = (ulong)&stm32f7_info},
 	{ .compatible = "st,stm32h7-uart", .data = (ulong)&stm32h7_info},
+	{ .compatible = "st,stm32l4-lpuart", .data = (ulong)&stm32l4_lpuart_info},
 	{}
 };
 
diff --git a/drivers/serial/serial_stm32.h b/drivers/serial/serial_stm32.h
index d2c92ba4..ca479eda 100644
--- a/drivers/serial/serial_stm32.h
+++ b/drivers/serial/serial_stm32.h
@@ -27,6 +27,7 @@ struct stm32_uart_info {
 	u8 uart_enable_bit;	/* UART_CR1_UE */
 	bool stm32f4;		/* true for STM32F4, false otherwise */
 	bool has_fifo;
+	bool lpuart;		/* LPUART: BRR = 256 * fck / baud */
 };
 
 struct stm32_uart_info stm32f4_info = {
@@ -47,6 +48,11 @@ struct stm32_uart_info stm32h7_info = {
 	.has_fifo = true,
 };
 
+struct stm32_uart_info stm32l4_lpuart_info = {
+	.has_fifo = true,
+	.lpuart = true,
+};
+
 /* Information about a serial port */
 struct stm32x7_serial_plat {
 	void __iomem *base;  /* address of registers in physical memory */
@@ -76,6 +82,11 @@ struct stm32x7_serial_plat {
 #define USART_BRR_M_SHIFT		4
 #define USART_BRR_M_MASK		GENMASK(15, 4)
 
+/* RM0432 51.4.7: LPUART BRR is 20 bits wide and must be >= 0x300 */
+#define LPUART_BRR_MIN			0x300
+#define LPUART_BRR_MAX			GENMASK(19, 0)
+#define LPUART_PRESC_OFFSET		0x2c
+
 #define USART_ICR_ORECF			BIT(3)
 #define USART_ICR_FECF			BIT(1)
 #define USART_ICR_PCECF			BIT(0)
-- 
2.56.0

