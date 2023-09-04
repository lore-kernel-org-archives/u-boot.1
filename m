Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA174C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 11:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 671FA868C0;
	Mon,  4 Sep 2023 13:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Q21pvfoJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69F0886908; Mon,  4 Sep 2023 13:23:27 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2278B86898
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 13:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [46.114.152.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7282243CDC; 
 Mon,  4 Sep 2023 11:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693826602;
 bh=aC+YjhB99D6W1YO4rl9uO9kTtL5MlAIl39dkddKx44Y=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=Q21pvfoJ2dSDLP2OXRDwPr1J/aBXaH+8uthBagqRhiDsMOCgw0fP4jvwY1YlsOgkS
 OpJ7xzNpNX4EAbEGv2d8OMyanE2PGkbctS2pJ5ymUqQ1U6h82kQAVSStKW1jsGZkBH
 LIeEVUb4Wfq4+AitpYskT1fI7Oh5H/3BnjyS4QE1ma49UVv1LxQ0J9RtkFgZ0rrTLg
 +KvtGKKIXJF5pu8ZB+QQf5zQMpKyGoPB7ChcfMrVcOOdJeF4jxJKq5ZiNgrgFQqtN+
 UZOAm0S6eLccOi/ixbSgmK9GXjXYeDqxbuYNKBAWv4Ae11D1JJh7tUX54gIi1l7J7M
 K94StbVVdfXzw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Anup Patel <apatel@ventanamicro.com>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 2/2] risc-v: implement DBCN based debug console
Date: Mon,  4 Sep 2023 13:24:04 +0200
Message-Id: <20230904112404.81899-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230904112404.81899-1-heinrich.schuchardt@canonical.com>
References: <20230904112404.81899-1-heinrich.schuchardt@canonical.com>
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

Use the DBCN SBI extension to implement a debug console.
Make it the default for S-mode RISC-V.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	check that we are in S-mode
---
 drivers/serial/Kconfig      |  5 ++++-
 drivers/serial/serial_sbi.c | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 7ca42df6a7..fb108f0189 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -218,6 +218,7 @@ config DEBUG_UART
 choice
 	prompt "Select which UART will provide the debug UART"
 	depends on DEBUG_UART
+	default DEBUG_SBI_CONSOLE if RISCV_SMODE
 	default DEBUG_UART_NS16550
 
 config DEBUG_UART_ALTERA_JTAGUART
@@ -289,11 +290,13 @@ config DEBUG_EFI_CONSOLE
 
 config DEBUG_SBI_CONSOLE
 	bool "SBI"
-	depends on SBI_V01
+	depends on RISCV_SMODE
 	help
 	  Select this to enable a debug console which calls back to SBI to
 	  output to the console. This can be useful for early debugging of
 	  U-Boot when running on top of SBI (Supervisor Binary Interface).
+	  This implementation of the debug UART is not available while in
+	  M-mode (e.g. during SPL).
 
 config DEBUG_UART_S5P
 	bool "Samsung S5P"
diff --git a/drivers/serial/serial_sbi.c b/drivers/serial/serial_sbi.c
index b9f35ed36e..a51a96c1ef 100644
--- a/drivers/serial/serial_sbi.c
+++ b/drivers/serial/serial_sbi.c
@@ -3,6 +3,8 @@
 #include <debug_uart.h>
 #include <asm/sbi.h>
 
+#ifdef CONFIG_SBI_V01
+
 static inline void _debug_uart_init(void)
 {
 }
@@ -13,4 +15,22 @@ static inline void _debug_uart_putc(int c)
 		sbi_console_putchar(c);
 }
 
+#else
+
+static int sbi_dbcn_available;
+
+static inline void _debug_uart_init(void)
+{
+	if (CONFIG_IS_ENABLED(RISCV_SMODE))
+		sbi_dbcn_available = sbi_probe_extension(SBI_EXT_DBCN);
+}
+
+static inline void _debug_uart_putc(int ch)
+{
+	if (CONFIG_IS_ENABLED(RISCV_SMODE) && sbi_dbcn_available)
+		sbi_dbcn_write_byte(ch);
+}
+
+#endif
+
 DEBUG_UART_FUNCS
-- 
2.40.1

