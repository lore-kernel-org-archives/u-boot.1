Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFABC27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 13:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAAA88839C;
	Tue, 18 Jun 2024 15:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="UiN472zO";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="IySUuYDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34E01883D3; Tue, 18 Jun 2024 15:56:36 +0200 (CEST)
Received: from wfout7-smtp.messagingengine.com
 (wfout7-smtp.messagingengine.com [64.147.123.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B1AA883BB
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 15:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.west.internal (Postfix) with ESMTP id 8D76C1C000B9;
 Tue, 18 Jun 2024 09:56:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 18 Jun 2024 09:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1718718991;
 x=1718805391; bh=L+9ac5HcORkdKFHsCg0Lgf0Iw7rYfAeVnh1M84lg210=; b=
 UiN472zO6t5U+8hsIu5LgzsWIadEXc0tI2xSjUHHB7DNHVjUlnk4Rmi5oiWLvuuz
 GhwmTlVzs4hDi9heT0LITsrmKsQtw5W40PrekDV1XgJogbWGzH0t5AIOXiRHNzgK
 dhi4lfpxYdm/1D0LSCV8ubwOPQxOs9X9ngELq+rkn4QuiUCjIYsPs/tzCsKY+MJG
 SUsvKWCLf1n9FOVxee3Cqbqf1qykdy7GTlMsR1x+KJdI/rldQsHGANkldB1fRIok
 BswPbkU96e3tLB6Iao/ASjDKljGces7UTYoKMJSE0RQ49SFpPbq9r35DuxoPfqm7
 hLiLmNhnzXfcUOaHOscsRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718718991; x=
 1718805391; bh=L+9ac5HcORkdKFHsCg0Lgf0Iw7rYfAeVnh1M84lg210=; b=I
 ySUuYDkEvXJXDVJiryWeYU9ri8QKQgjyMOCmAfGFDCqIg+ONbebnAuvVtzAW77Hi
 3ySjQN27bI3xbLHoaE1IZIDVP1z0x9Enx4JFC2qr2MEG7q45gpMA0THsuwQxUoT9
 kqj9Ummtg0dM1ccbhKOSAx0q1qMSHxyQ4ZVtFV1YQIvNg+eyowoHtABtL6Te6v7H
 M9af2OmIYZpylZbZLEzTDHR58jHF2tyyN9yvGbnTuoy4FORJ7bP5XWhhsb/vOTwq
 QG5iJJxYsoZai0EvMznOm+UMITMQt7GPid1XkcO7xJ9IyUwi2CbotwjlmXf70LRI
 ngELemFyDQMJGMJpOqIHw==
X-ME-Sender: <xms:D5JxZq_QCeFcZt5OThcRl-eR18dz3Bh9RbHIXHx7xxz6jQUEQzXcHw>
 <xme:D5JxZqsw9Q2Us1bIH7bpYL63YFF2VlD05TFxp7RyRqBtm-xdfM3V_2sTw4M4rv3t-
 bFma4rIDoY2QbVbsEU>
X-ME-Received: <xmr:D5JxZgCzI1ocCKqmCzT7ws4sseEQ4xaEDfaldYz37E7Ao_7a0Vv0FSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedggedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:D5JxZiej6LzjffAGcfQDtS36HXyJyuY_uG5VKd2G6H5RBBZSk9v_WQ>
 <xmx:D5JxZvNF2ucZZijvDni9mtxiZULX6rgMGKBe9wYK8fS_Q2J8fopyJg>
 <xmx:D5JxZsm2sonwpZJyarEl7YC7OTbUN1MBGtfTZn7Puctl_h5f2M-Ugw>
 <xmx:D5JxZhv7OXOWvOuZMUBANxyIHSWYufSyJ-3RDNpZ8r1qpEVc1ZbRIA>
 <xmx:D5JxZrC_2BHpW_lE3oCJH6IdT49YjbN3CzM_R07qvo_vi7vhKovTz_q_>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jun 2024 09:56:30 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 18 Jun 2024 14:56:06 +0100
Subject: [PATCH v3 06/12] drivers: serial: Add xtensa semihosting driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-qemu-xtensa-v3-6-f5af5e6fdd23@flygoat.com>
References: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
In-Reply-To: <20240618-qemu-xtensa-v3-0-f5af5e6fdd23@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4659;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=9iAvGwZ4pH4q40oQ3g8lFoawl4PhBItilZA9JLp/cpQ=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrTCSYzKE30Nvv4zrfh17s9Hy5ppXNtkb/1Zt7xxw4tGh
 e+SojWaHaUsDGJcDLJiiiwhAkp9GxovLrj+IOsPzBxWJpAhDFycAjAROxeGX8zPQ78tONr3rXRS
 aknWzKw3HxYdlJzmvuT6gYN/TQ7efHKPkWHZsunHl3OI3L/9ic30TWx83GertH4z0ZDydb6PS9k
 /qHMBAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Add xtensa semihosting driver.

It can't use regular semihosting driver as Xtensa's has it's own
semihosting ABI.

Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2:
	- Fix simc_serial_pending implementation
	- Get puts work
---
 drivers/serial/Kconfig                     | 18 +++++-
 drivers/serial/Makefile                    |  1 +
 drivers/serial/serial_xtensa_semihosting.c | 92 ++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 1fe4607598eb..3a1e5a6f2877 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -501,6 +501,15 @@ config DEBUG_UART_MT7620
 	  driver will be available until the real driver model serial is
 	  running.
 
+config DEBUG_UART_XTENSA_SEMIHOSTING
+	bool "Xtensa semihosting"
+	depends on XTENSA_SEMIHOSTING_SERIAL
+	help
+	  Select this to enable the debug UART using the Xtensa semihosting driver.
+	  This provides basic serial output from the console without needing to
+	  start up driver model. The driver will be available until the real
+	  driver model serial is running.
+
 endchoice
 
 config DEBUG_UART_BASE
@@ -936,7 +945,6 @@ config SH_SCIF_CLK_FREQ
 config SEMIHOSTING_SERIAL
 	bool "Semihosting UART support"
 	depends on SEMIHOSTING && !SERIAL_RX_BUFFER
-	imply SERIAL_PUTS
 	help
 	  Select this to enable a serial UART using semihosting. Special halt
 	  instructions will be issued which an external debugger (such as a
@@ -1115,6 +1123,14 @@ config XEN_SERIAL
 	  If built without DM support, then requires Xen
 	  to be built with CONFIG_VERBOSE_DEBUG.
 
+config XTENSA_SEMIHOSTING_SERIAL
+	bool "Xtensa Semihosting UART support"
+	depends on DM_SERIAL
+	depends on XTENSA_SEMIHOSTING
+	imply SERIAL_PUTS
+	help
+	  Select this to enable a serial UART using Xtensa semihosting.
+
 choice
 	prompt "Console port"
 	default 8xx_CONS_SMC1
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index dbe598b74064..78810f98367c 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_MT7620_SERIAL) += serial_mt7620.o
 obj-$(CONFIG_HTIF_CONSOLE) += serial_htif.o
 obj-$(CONFIG_SIFIVE_SERIAL) += serial_sifive.o
 obj-$(CONFIG_XEN_SERIAL) += serial_xen.o
+obj-$(CONFIG_XTENSA_SEMIHOSTING_SERIAL) += serial_xtensa_semihosting.o
 obj-$(CONFIG_S5P4418_PL011_SERIAL) += serial_s5p4418_pl011.o
 
 ifndef CONFIG_SPL_BUILD
diff --git a/drivers/serial/serial_xtensa_semihosting.c b/drivers/serial/serial_xtensa_semihosting.c
new file mode 100644
index 000000000000..0e59a9bfdc75
--- /dev/null
+++ b/drivers/serial/serial_xtensa_semihosting.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <dm.h>
+#include <malloc.h>
+#include <serial.h>
+
+#include <asm/platform/simcall.h>
+
+/**
+ * struct simc_serial_priv - Semihosting serial private data
+ * @counter: Counter used to fake pending every other call
+ */
+struct simc_serial_priv {
+	unsigned int counter;
+};
+
+static int simc_serial_getc(struct udevice *dev)
+{
+	char ch = 0;
+
+	simc_read(0, &ch, sizeof(ch));
+
+	return ch;
+}
+
+static int simc_serial_putc(struct udevice *dev, const char ch)
+{
+	char str[2] = {0};
+
+	str[0] = ch;
+	simc_write(1, str, 1);
+
+	return 0;
+}
+
+static int simc_serial_pending(struct udevice *dev, bool input)
+{
+	struct simc_serial_priv *priv = dev_get_priv(dev);
+
+	if (input) {
+		int res = simc_poll(0);
+		return res < 0 ? priv->counter++ & 1 : res;
+	}
+
+	return false;
+}
+
+static ssize_t smh_serial_puts(struct udevice *dev, const char *s, size_t len)
+{
+	int ret;
+
+	ret = simc_write(1, s, len);
+
+	return ret;
+}
+
+static const struct dm_serial_ops simc_serial_ops = {
+	.putc = simc_serial_putc,
+	.puts = smh_serial_puts,
+	.getc = simc_serial_getc,
+	.pending = simc_serial_pending,
+};
+
+U_BOOT_DRIVER(simc_serial) = {
+	.name	= "serial_xtensa_semihosting",
+	.id	= UCLASS_SERIAL,
+	.priv_auto = sizeof(struct simc_serial_priv),
+	.ops	= &simc_serial_ops,
+	.flags	= DM_FLAG_PRE_RELOC,
+};
+
+U_BOOT_DRVINFO(simc_serial) = {
+	.name = "serial_xtensa_semihosting",
+};
+
+#if CONFIG_IS_ENABLED(DEBUG_UART_XTENSA_SEMIHOSTING)
+#include <debug_uart.h>
+
+static inline void _debug_uart_init(void)
+{
+}
+
+static inline void _debug_uart_putc(int c)
+{
+	simc_serial_putc(NULL, c);
+}
+
+DEBUG_UART_FUNCS
+#endif

-- 
2.43.0

