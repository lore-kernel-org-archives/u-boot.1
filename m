Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B823EE49A8
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 13:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2019E8700E;
	Sat, 19 Aug 2023 15:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NZ7vR1MO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A87BA87008; Sat, 19 Aug 2023 15:12:36 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A64987001
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 15:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 7F587400AC; 
 Sat, 19 Aug 2023 13:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692450751;
 bh=y6BboHVphk/rVMJOZDeUSw7eGIdAeSA8NJ3fOLLWYRs=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=NZ7vR1MOUZxO5wxEpznfsstv52TDwDy5qGuWDHqPMvW8CJvgqZSTsn39UkELLWtcl
 3i5TNlQmdTeBZgqIDeUIbVlZ3vXhpst7UweBizg4aBFPR4mbOvFuUIrDCWaU0QbXID
 fsqWncHmVMdIlEHPm3PauAUF8Wbwjee9WiA0A78AMi1df6g8UCCIord0JoR+N4p0d0
 DtVSO81aDAbo0F3mevdd21FQ3qXma/TyaQaWsyxPWgMgV3h/QNyxkD02WdU33yzAM0
 158H4A6xPi6xmqbziZepUxTid4ommn7t1zj4Jl/SqJbd8UdN//bdMslAe7n0XvW12l
 VBpz3YCHQqhAg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo <ycliang@andestech.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Anup Patel <apatel@ventanamicro.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] risc-v: implement DBCN based debug console
Date: Sat, 19 Aug 2023 15:12:50 +0200
Message-Id: <20230819131250.10251-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230819131250.10251-1-heinrich.schuchardt@canonical.com>
References: <20230819131250.10251-1-heinrich.schuchardt@canonical.com>
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
 drivers/serial/Kconfig      |  3 ++-
 drivers/serial/serial_sbi.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index a1e089962a..8421c5c047 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -218,6 +218,7 @@ config DEBUG_UART
 choice
 	prompt "Select which UART will provide the debug UART"
 	depends on DEBUG_UART
+	default DEBUG_SBI_CONSOLE if RISCV_SMODE
 	default DEBUG_UART_NS16550
 
 config DEBUG_UART_ALTERA_JTAGUART
@@ -289,7 +290,7 @@ config DEBUG_EFI_CONSOLE
 
 config DEBUG_SBI_CONSOLE
 	bool "SBI"
-	depends on SBI_V01
+	depends on RISCV_SMODE
 	help
 	  Select this to enable a debug console which calls back to SBI to
 	  output to the console. This can be useful for early debugging of
diff --git a/drivers/serial/serial_sbi.c b/drivers/serial/serial_sbi.c
index b9f35ed36e..093c7309d3 100644
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
@@ -13,4 +15,21 @@ static inline void _debug_uart_putc(int c)
 		sbi_console_putchar(c);
 }
 
+#else
+
+static int sbi_dbcn_available;
+
+static inline void _debug_uart_init(void)
+{
+	sbi_dbcn_available = sbi_probe_extension(SBI_EXT_DBCN);
+}
+
+static inline void _debug_uart_putc(int ch)
+{
+	if (sbi_dbcn_available)
+		sbi_dbcn_write_byte(ch);
+}
+
+#endif
+
 DEBUG_UART_FUNCS
-- 
2.40.1

