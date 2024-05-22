Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4F5C25B79
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 17:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5209F8888B;
	Wed, 22 May 2024 19:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="RJCIzPBk";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="IeMuzP0W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED9428887C; Wed, 22 May 2024 19:08:16 +0200 (CEST)
Received: from wfhigh1-smtp.messagingengine.com
 (wfhigh1-smtp.messagingengine.com [64.147.123.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6DDD8889F
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 19:08:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.west.internal (Postfix) with ESMTP id 14E3F180012A;
 Wed, 22 May 2024 13:08:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute3.internal (MEProxy); Wed, 22 May 2024 13:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716397692;
 x=1716484092; bh=O/BFss53bjUyOb2sMzU3ESRDq2BnIwXPpQa8FP+a4iQ=; b=
 RJCIzPBkakCgoA5Q9/SUUwCIykALfyzZGQ2A2plG3aM+M5C6eZ5RywlqZhhjHPeH
 z/wJJ9SJtkbhSmXkJ8eXGBl2hcKEsn1bf3FO7OQnRwro+87AFKqjykH7mEUYBFBa
 I3BgCHWH8uRmVCLuzDkGWazKdgCZV9fabyV53Z/Ka/r4ZihoqhmCCo5WUsBgds3G
 FYEVOBFkzMM71LXVyc1pc16Wlq/5FgDBnkQ1y0lOf47nIiLvT1rWJUmY9FHKDxNP
 EjlSVVj1OOgtcVKzPjffZtRXdLDrO/4nVlzbWkU4TGf6sLFvI8lBQHBmHEDtbL5U
 FgU5pmEmqyLHmxNF2fzXrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716397692; x=
 1716484092; bh=O/BFss53bjUyOb2sMzU3ESRDq2BnIwXPpQa8FP+a4iQ=; b=I
 eMuzP0Wk5cfPrbhQDo255isJWUC5wCGGCfksGCOCOXJkxz0RS/ZHLIiaQ/MSm42J
 g9vOPKMM+sORzyVwq8Z552EVZm9DdwyjQChWn4WUO+zFWLoM/nrT8Q8xDDxAExvS
 y2Z0wbRC1xRw7TJcLu3ELvxzkJHQuDNBNWl3iN6/xmij4YY4BkgyHZAGNB2nawQ9
 XmQ8G5bZcIx81e5G0fxhvz56L6lvLNDGdRvy3ikSJj5EPv0ObiNThlftwyPWUsje
 EpZb4p/xDFQ7gUWPahKTkN0qPrTeJ3thwtkeq1FP48Fe4NV+kFzMgisvWplfciTO
 fE/qiT7QmpYYYNE8gjixA==
X-ME-Sender: <xms:fCZOZgSUMs1ixdtYirD1i7qMA-XegaPya2VWEe1Zru99dHsC6wTkEg>
 <xme:fCZOZty5KgO1wnhDuqq66bB8dwvQLWc1La1RTf8-Wmp2ugUKPhdE1etYQ5GiVi6Nl
 4lxf81tlnp2PURj7co>
X-ME-Received: <xmr:fCZOZt0iXdK-iHjcIhctlP40fd5ktAOpq3SA7lFII98RYLUlevjwgqo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeigedgfeegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:fCZOZkDSmU2T7Z3yRBlvgvVTOCAqsl6Bq3D7btkwTwKdGp_MFCQcJw>
 <xmx:fCZOZpjJp8xEKhz796M_3C_1V1S493e8xokS730yCNpzkr2bcHGXig>
 <xmx:fCZOZgoClgt37ZpzjNd4pR1zuId7pl3WGVSy9aK0NLsDJPvtoWfKuw>
 <xmx:fCZOZshribRHN2z6yUwaVBAk34X54c10BgQ1b2iQ_PyqEyPicJryZA>
 <xmx:fCZOZkUCPbybSbEjOdquvp0Owdv2etdLvHF1JJNwhLAduMuUvUNhf8WY>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 13:08:11 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Wed, 22 May 2024 18:08:02 +0100
Subject: [PATCH v2 06/10] drivers: serial: Add xtensa semihosting driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-qemu-xtensa-v2-6-04bf7e42b10b@flygoat.com>
References: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
In-Reply-To: <20240522-qemu-xtensa-v2-0-04bf7e42b10b@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4613;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=GxVMTr9Ga6KZJcmaAHT0zf8pt7UdaQEr6X2GnjSxYNo=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjQ/tTyvngD/iccvrN+g1tfrLcR207qiU7lzv43F3vlXS
 v8W86V2lLIwiHExyIopsoQIKPVtaLy44PqDrD8wc1iZQIYwcHEKwESCtzD8zyhjCC7V+3Ir/6Db
 lhl/0g2/ar5Yd8Xr2c3rZ/nf7WEWqWP4Zyxa5bLEP9dr+X6pP9H8P4NvHdmYwjC/L9X+icaJjE+
 PGAA=
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

