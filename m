Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8F606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 22:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rWvg+UvB;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=sgywMqKY;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=KhUkWd3c
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0384F809C0;
	Mon, 26 Oct 2026 22:55:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NbKg-Ek8OGYg; Mon, 26 Oct 2026 22:55:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1A71580C0D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793055323;
	b=XIWqQoX2MzGMVzr4d7ZoU12OHbrs42fRtB06v2WkouT/csvmI8cufQMnGIOqUSviufWK
	 Ix5AyL/Rhbt9EXGHXkU9m/UC8rlwpb9pgiB4zCRMwRitGuMgwR1BpqhyjmYgW+pbmXeNg
	 yh06ybprsy3jrLDzTxQX3wyRRSpqtXAUtqy0kdvdB/clEkVPYLdsVp8NTtw3BhowQ3YNz
	 5Jh09dJAdW0tKso8436W259FRrujKGGALUe5F/YusQq+WLJU+rtU88Xv+xkLeR7Jp1jrq
	 b1Yr6fY5qDAxSeck+fwKR8U3LwtoHE7SdqGAz+qScGb/Jc3RDUFwhzNgMd4pk1PFsOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793055323;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OUlZN9kcyhVyQlJ37gsfdeYx72w8qm6LZL/hvAbnbew=;
	b=mb3BdOB3U/8YfIGnz3hKsO2SgpkNGAyvvZOpWAleukifUNBju18DBfmHqxvIS1feZJFH
	 GjwWPRXF+VslH/qZuItCrPsy+vg7ApADIf57/CbtPMXDHtIK3peftlYRE4WbqTtoz0fBZ
	 b/KndpB3GEagNRx1sTvbPogD5g9ALKfuIJltv/TJinwrn9uIhe2sZFQseqCDAsYxnGcDl
	 QtJFXJ4GgmJ4o8n6WBs9lzD6VZu3mwZRkUwJHoP3NjfVxZMQzjNeiZYPAFmzVhtbVqR2J
	 z99EPiE6HhCnzoy7LR48Qyu5nXgpntNRWkP2/nHZTYYgAzgiocrBB+KpPe3RC9magUQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793055323;
	bh=OUlZN9kcyhVyQlJ37gsfdeYx72w8qm6LZL/hvAbnbew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rWvg+UvBwrl/NFbmv3po2eEIkMGv/i4P1eysXEsfcoGyqC36mY5Hj5RPCnHszg/ED
	 +FqUNYlAn9UN3m0f4xbbXuu4IrfZ46hgddY8m9eBzVEG5jMBwn77X6BsulqjI/Kw+G
	 LhZ7qA7qpDKhkPqKWma4N8FutlorJslSYsC41DNI4M9xFXaQh/1LosDRr5UcWNvtOp
	 7qpLpcfMgb9Op65CA9VO2NQW9H0UJ72SRXpa17A3aXTuAq/5orjfc9Flwenhj6eyaa
	 m0cMTjqrw8afuUfEWKB26S5kYFMiQkXRQ/Oie5fDvRx+hPsBEuBhqQR1L4fzIZJNcx
	 eGxxe7L1DGxew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A71580C0D;
	Mon, 26 Oct 2026 22:55:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 284D8120
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A35A40075
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ubp2pXV8Fkom for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 22:55:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E193D40062
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=69.169.224.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793055310;
 b=E9S3KcAeZ+M/A1Wkn5Xp5zytbSJ5Wh8CfMIutVoCLO8hU7D2CGd77s8AyiONVzOvqONQ
 d3xIJ6jXCTpihBbmkt+PXqIdLGSO9ky5+3lgnsuHUfjJjK8WoThWD0GKdcKsIyXw1kAVx
 ATVD439rRs4RiCiyoaA5VY7ESsuVlGPoe1CpTE1Wflxq8ofPu9LYxOBvH93jLnDpW1amx
 x9/XrqVlBR4LJA/i8ynKDHH/gSy7/4/prkaf88WstJAE916LaFmNZglhBiFObYrizKUyx
 +OJRgWysLgl1MGup4kP5iJAsQt5E3Z0JD9kBQ4DYnR5GsVGZ5p/YQqHCGPNui3Vfxxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793055310;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:Feedback-ID:X-SES-Outgoing;
 bh=OUlZN9kcyhVyQlJ37gsfdeYx72w8qm6LZL/hvAbnbew=;
 b=AqGLHuidU+WRhEPMNZifVSmCdDE3Vpct9Rs+fPmvq3VKoXjs973NdgQP3bpY1ZwAILAQ
 R4hOV67Q0/b+tMhIHP6Ky5q3AVRhUcCUYkLLug6lvyf9u6COMxZEN+1Mi/GZmPg8E4EjH
 d0Rm+mGuXhbcEqvlFGxq7DxV59ycpS4s6CluuPtSauULCCBIVJPH7d0S6k+MKZ54z9KW/
 IGt4c490IS6LOkS2V2bahqYygGhFS4Y0jG7UQkic/1f+KXqE6snrs361N+xSTkcs6IEEC
 Atkr7hnt2OjAZrhzDgnk5soXv8vhuPB3CvD6JyttYhgSYjvu+fsBK2R7KnKvqmADJIA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=freemyipod.org;
 dkim=pass header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=sgywMqKY; 
 dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256
 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=KhUkWd3c; 
 arc=none smtp.remote-ip=69.169.224.12
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.12;
 helo=b224-12.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a17a6cb643-5cd1313b-806c-4624-b87f-1b00f80c8dfd-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=sgywMqKY; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=KhUkWd3c
Received: from b224-12.smtp-out.eu-central-1.amazonses.com
 (b224-12.smtp-out.eu-central-1.amazonses.com [69.169.224.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E193D40062
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 22:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1793055307;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=Gf3Fv4f5PlownI2+2zfoWuGLR27GJ7Sn42rYKCNhaxg=;
 b=sgywMqKYnO5Ml3JXAK1xwWxJ3GUGkcX7gZd9+Zmg6V7dxIrjXhEUpu4pN71tIGIe
 eHTjqrS3a+rCd/VWic2cSI774fOPCSzwq1khvcxQr9fpr4PRnw1WrtVpqKN4qen+dFR
 hbtwlchl/eCPsQTWirM/wXXUYxXRDoZJ/Hh+g6AnQI7MzmHTfhkrJkwgoMRdwDZe2iK
 NSk0U144/iKVZukMW6giI/rfDxBKd+/CkjUckRg7UybFgp3T0d/ZlCfX/TYZekwB6tT
 e5VX9raleb1YJ0zzlNCBGSbOwpnrbKWJsyExxTi3SXV8mk4Fv4BQfgV9RLY6N/qwGJd
 theRBqMbJg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1793055307;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=Gf3Fv4f5PlownI2+2zfoWuGLR27GJ7Sn42rYKCNhaxg=;
 b=KhUkWd3c6T/qEph1ECiWCBrCZjx39Wmse0fIy+xLodlenQGSoz2RKgzxf5BFQDwt
 x5ZKdlg2hHUN9pOzLszs4BsVUjnvrLpwG4zvuvv4k4J4YqRA3WwriV90Og7LAzAqQIg
 AbyO87sPwH8cUhSBjXazUGGKbjbW0AiwqB9dHxKQ=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Mon, 26 Oct 2026 22:55:07 +0000
Subject: [PATCH v2 07/14] serial: Add support for S5L87xx to serial_s5p
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a17a6cb643-5cd1313b-806c-4624-b87f-1b00f80c8dfd-000000@eu-central-1.amazonses.com>
References: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
In-Reply-To: <20261027-s5l87xx-v2-v2-0-1de63803510b@freemyipod.org>
To: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Vencislav Atanasov <user890104@freemyipod.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793055301; l=6507;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=Gf3Fv4f5PlownI2+2zfoWuGLR27GJ7Sn42rYKCNhaxg=;
 b=XDl0E1UcfyVsaHNEmKVl5xtcwB9DgXLkgGoMIkcKS9i0ZJMBOlSYQ3GtiUijd2sPFUAcjH/8y
 5UjF2nssFu9BRIx9QzPIRZVvUO83IRJtPh89Z/0HxViEXCYLX+Kbz8J
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.10.26-69.169.224.12
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

The S5L87xx UART peripheral does not support UDIVSLOT, also it needs
the NCLK bit to be set (clock source selection).

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 MAINTAINERS                              |  5 ++++
 arch/arm/include/asm/arch-s5l87xx/uart.h | 29 +++++++++++++++++++
 drivers/serial/Kconfig                   |  4 +--
 drivers/serial/serial_s5p.c              | 49 +++++++++++++++++++++-----------
 4 files changed, 69 insertions(+), 18 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 95b1f3b5ab3..da8e413dd35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -600,6 +600,11 @@ F:	drivers/clk/exynos/clk-exynos850.c
 F:	drivers/phy/phy-exynos-usbdrd.c
 F:	drivers/pinctrl/exynos/pinctrl-exynos850.c
 
+ARM SAMSUNG S5L87XX SOC
+M:	Vencislav Atanasov <user890104@freemyipod.org>
+S:	Maintained
+F:	arch/arm/include/asm/arch-s5l87*
+
 ARM SAMSUNG SOC DRIVERS
 M:	Sam Protsenko <semen.protsenko@linaro.org>
 S:	Maintained
diff --git a/arch/arm/include/asm/arch-s5l87xx/uart.h b/arch/arm/include/asm/arch-s5l87xx/uart.h
new file mode 100644
index 00000000000..61b7cf43890
--- /dev/null
+++ b/arch/arm/include/asm/arch-s5l87xx/uart.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2009 Samsung Electronics
+ * Minkyu Kang <mk7.kang@samsung.com>
+ * Heungjun Kim <riverful.kim@samsung.com>
+ */
+
+#ifndef __ASM_ARCH_S5L87XX_UART_H_
+#define __ASM_ARCH_S5L87XX_UART_H_
+
+#ifndef __ASSEMBLY__
+
+struct s5p_uart {
+	unsigned int	ulcon;
+	unsigned int	ucon;
+	unsigned int	ufcon;
+	unsigned int	umcon;
+	unsigned int	utrstat;
+	unsigned int	uerstat;
+	unsigned int	ufstat;
+	unsigned int	umstat;
+	unsigned int	utxh;
+	unsigned int	urxh;
+	unsigned int	ubrdiv;
+};
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* __ASM_ARCH_S5L87XX_UART_H_ */
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index bcb0c865437..fa1959b2c30 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -321,7 +321,7 @@ config DEBUG_SBI_CONSOLE
 
 config DEBUG_UART_S5P
 	bool "Samsung S5P"
-	depends on ARCH_APPLE || ARCH_EXYNOS || ARCH_S5PC1XX
+	depends on ARCH_APPLE || ARCH_EXYNOS || ARCH_S5PC1XX || ARCH_S5L87XX
 	help
 	  Select this to enable a debug UART using the serial_s5p driver. You
 	  will need to provide parameters to make this work. The driver will
@@ -905,7 +905,7 @@ config ROCKCHIP_SERIAL
 
 config S5P_SERIAL
 	bool "Support for Samsung S5P UART"
-	depends on ARCH_APPLE || ARCH_EXYNOS || ARCH_S5PC1XX
+	depends on ARCH_APPLE || ARCH_EXYNOS || ARCH_S5PC1XX || ARCH_S5L87XX
 	default y
 	help
 	  Select this to enable Samsung S5P UART support.
diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
index d46a88610ab..eec0fa0a10f 100644
--- a/drivers/serial/serial_s5p.c
+++ b/drivers/serial/serial_s5p.c
@@ -13,10 +13,14 @@
 #include <asm/global_data.h>
 #include <linux/compiler.h>
 #include <asm/io.h>
-#if !IS_ENABLED(CONFIG_ARCH_APPLE)
+#if !IS_ENABLED(CONFIG_ARCH_APPLE) && !IS_ENABLED(CONFIG_ARCH_S5L87XX)
 #include <asm/arch/clk.h>
 #endif
+#if IS_ENABLED(CONFIG_ARCH_S5L87XX)
+#include <asm/arch-s5l87xx/uart.h>
+#else
 #include <asm/arch/uart.h>
+#endif
 #include <serial.h>
 #include <clk.h>
 
@@ -40,6 +44,7 @@ enum {
 #define S5L_TX_FIFO_COUNT_SHIFT	4
 #define S5L_TX_FIFO_COUNT_MASK	(0xf << S5L_TX_FIFO_COUNT_SHIFT)
 #define S5L_TX_FIFO_FULL	BIT(9)
+#define S5L_CLK_NCLK		BIT(10)
 
 #define S5P_RX_FIFO_COUNT_SHIFT	0
 #define S5P_RX_FIFO_COUNT_MASK	(0xff << S5P_RX_FIFO_COUNT_SHIFT)
@@ -61,6 +66,7 @@ struct s5p_serial_plat {
 	u32 tx_fifo_full;
 };
 
+#if !IS_ENABLED(CONFIG_ARCH_S5L87XX)
 /*
  * The coefficient, used to calculate the baudrate on S5P UARTs is
  * calculated as
@@ -86,6 +92,7 @@ static const int udivslot[] = {
 	0xdfdf,
 	0xffdf,
 };
+#endif
 
 static void __maybe_unused s5p_serial_init(struct s5p_uart *uart)
 {
@@ -98,6 +105,14 @@ static void __maybe_unused s5p_serial_init(struct s5p_uart *uart)
 	/* No interrupts, no DMA, pure polling */
 	writel(UCON_RX_IRQ_OR_POLLING | UCON_TX_IRQ_OR_POLLING |
 	       UCON_RX_ERR_IRQ_EN | UCON_TX_IRQ_LEVEL, &uart->ucon);
+
+	if (IS_ENABLED(CONFIG_ARCH_S5L87XX)) {
+		u32 val;
+
+		val = readl(&uart->ucon);
+		val |= S5L_CLK_NCLK;
+		writel(val, &uart->ucon);
+	}
 }
 
 static void __maybe_unused s5p_serial_baud(struct s5p_uart *uart, u8 reg_width,
@@ -109,12 +124,14 @@ static void __maybe_unused s5p_serial_baud(struct s5p_uart *uart, u8 reg_width,
 
 	writel(val / 16 - 1, &uart->ubrdiv);
 
+#if !IS_ENABLED(CONFIG_ARCH_S5L87XX)
 	if (s5p_uart_divslot())
 		writew(udivslot[val % 16], &uart->rest.slot);
 	else if (reg_width == 4)
 		writel(val % 16, &uart->rest.value);
 	else
 		writeb(val % 16, &uart->rest.value);
+#endif
 }
 
 #ifndef CONFIG_XPL_BUILD
@@ -124,7 +141,8 @@ int s5p_serial_setbrg(struct udevice *dev, int baudrate)
 	struct s5p_uart *const uart = plat->reg;
 	u32 uclk;
 
-#if IS_ENABLED(CONFIG_CLK_EXYNOS) || IS_ENABLED(CONFIG_ARCH_APPLE)
+#if IS_ENABLED(CONFIG_CLK_EXYNOS) || IS_ENABLED(CONFIG_ARCH_APPLE) || \
+	IS_ENABLED(CONFIG_ARCH_S5L87XX)
 	struct clk clk;
 	int ret;
 
@@ -286,26 +304,25 @@ static inline void _debug_uart_init(void)
 	struct s5p_uart *uart = (struct s5p_uart *)CONFIG_VAL(DEBUG_UART_BASE);
 
 	s5p_serial_init(uart);
-#if IS_ENABLED(CONFIG_ARCH_APPLE)
-	s5p_serial_baud(uart, 4, CONFIG_DEBUG_UART_CLOCK, CONFIG_BAUDRATE);
-#else
-	s5p_serial_baud(uart, 1, CONFIG_DEBUG_UART_CLOCK, CONFIG_BAUDRATE);
-#endif
+	if (IS_ENABLED(CONFIG_ARCH_APPLE) || IS_ENABLED(CONFIG_ARCH_S5L87XX))
+		s5p_serial_baud(uart, 4, CONFIG_DEBUG_UART_CLOCK, CONFIG_BAUDRATE);
+	else
+		s5p_serial_baud(uart, 1, CONFIG_DEBUG_UART_CLOCK, CONFIG_BAUDRATE);
 }
 
 static inline void _debug_uart_putc(int ch)
 {
 	struct s5p_uart *uart = (struct s5p_uart *)CONFIG_VAL(DEBUG_UART_BASE);
 
-#if IS_ENABLED(CONFIG_ARCH_APPLE)
-	while (readl(&uart->ufstat) & S5L_TX_FIFO_FULL)
-		;
-	writel(ch, &uart->utxh);
-#else
-	while (readl(&uart->ufstat) & S5P_TX_FIFO_FULL)
-		;
-	writeb(ch, &uart->utxh);
-#endif
+	if (IS_ENABLED(CONFIG_ARCH_APPLE) || IS_ENABLED(CONFIG_ARCH_S5L87XX)) {
+		while (readl(&uart->ufstat) & S5L_TX_FIFO_FULL)
+			;
+		writel(ch, &uart->utxh);
+	} else {
+		while (readl(&uart->ufstat) & S5P_TX_FIFO_FULL)
+			;
+		writeb(ch, &uart->utxh);
+	}
 }
 
 DEBUG_UART_FUNCS

-- 
Git-157)

