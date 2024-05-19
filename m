Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3CFC25B75
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 20:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1277B88670;
	Sun, 19 May 2024 22:54:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="4bh20e12";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="hc2t2Orq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C52088621; Sun, 19 May 2024 22:54:01 +0200 (CEST)
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com
 [103.168.172.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 521F9882E2
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 22:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailfout.nyi.internal (Postfix) with ESMTP id 87E9C13803B4;
 Sun, 19 May 2024 16:53:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Sun, 19 May 2024 16:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1716152038;
 x=1716238438; bh=HZQwP/TefB4DrEr7JRK8OuvY9jBQ7zrvNZwNb05GDVI=; b=
 4bh20e12H/F7Qf2EO72zKa4wK0/7JZYCdnGC/VtKRkifX9oOapsNYLBSZbS+kQ+d
 jczdpU/TbUnhlWPKN/8Fa3TYn+JuU8DP7MnlNBdotYR0clTxe+pxc+DsW4ndqAze
 OwkQN4QDgh9cOXw/4zdskF2BPX3Jn+cjs4+6kGrsG11r2iOfvWcsSErBpQADjxIt
 +wM7O8RRVNyHRt9+/xw6QdNyCxVXnrC8QfB0QwWzmFPf7peVZLbmdajMyyBdIj0e
 MGEqPQ1ayvzkMXHKJavJT/ai/VMnkP7IvmpFq9rU11pm5aN20NoKDmPqQUlDupLe
 uPFaMXg8eR16iCEMnIZ4Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716152038; x=
 1716238438; bh=HZQwP/TefB4DrEr7JRK8OuvY9jBQ7zrvNZwNb05GDVI=; b=h
 c2t2Orq+Q9gwknYsX8Hl+EUSGnPB3Jw3H3Kp755u/WIy5ncP2eRYse2urFtRIhNB
 wYbjetNyQWbXaYR5RIW8CSIBN3OQevntv6lpbtAO7HomQp90z0mYfE2/VvS2Y5OI
 G/KC4sgA/qQ600VJgzoXLKge17+dMczbP4dsnev7CIeKqr226F/GS/UptXx8G7JX
 af2ebLz1UeRXA3GdREMbqd0AO4deuKggWa1yWaSVt1b/BRB8JMSyOUs+1Szebr3Q
 9efM1/GOsVhlYPI9srGudvhfGPG63Vd9BBsIWHStlxdfWZO/YhMeKwYAJLsCQy3p
 rYwEfLVd1xBWWGsINSsFw==
X-ME-Sender: <xms:5mZKZqVZLy9BH0v98VPhvTkt6MESvXy0nCWYZNEz_9PadbEO785xww>
 <xme:5mZKZmmFxaNBHbbTz3i2foC48a3fINPzaTIrHJ40aWi42LXpFGYjo8DY4Y95BAzwb
 JZxV4nB0otX5CunqIM>
X-ME-Received: <xmr:5mZKZuZ7IjOJIUaRk3ma6n00oaIebMBTg_XWFneRKy51L9oDNLoTb6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehkedgudehvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhi
 rgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqe
 enucggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefh
 ueevgeffgedukeejleenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrih
 hlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:5mZKZhXR6rGsawVZ3L3vWTeyPCM6yA1dbD6l2PN9wiKijY4XC75Vrw>
 <xmx:5mZKZkmoc-pAstmVtpSkhhU_KGLVlVFHY000iUVUneUO8Tspl-y0qQ>
 <xmx:5mZKZmfZoq54gnT1wjXvx2guODCymjJjjY_i1d7-UJpXgILHrddesA>
 <xmx:5mZKZmGsOtopr5l89Qe6mxedqcCOHzaUlcNZmw-IG6yMwyi5Vhlp4A>
 <xmx:5mZKZiZy6oOpFUZQtTlpb3pPMJp9s1sHTv6hnBWfPagDPMXWtRPYu-8u>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 May 2024 16:53:57 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Sun, 19 May 2024 21:53:53 +0100
Subject: [PATCH 06/10] drivers: serial: Add xtensa semihosting driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240519-qemu-xtensa-v1-6-8fff0cb11c19@flygoat.com>
References: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
In-Reply-To: <20240519-qemu-xtensa-v1-0-8fff0cb11c19@flygoat.com>
To: u-boot@lists.denx.de, Sean Anderson <sean.anderson@seco.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4416;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=wb4zG40OBADaXJxSAQClCTSpA00UoOn25iLGHVNaxoc=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhjSvtHv5KjWfjt2pZVkgdpNB7cJ9w41tv7hvS7s1T34tY
 LTjgYViRwkLgxgXg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEzkRinDF868/RMMVVcsnlzu
 Xekp6Piv/l7JvXpeE6fT4S92vdhXzfA/e1uJoWTHO1XDPG2hiKn+10s+/XLZLLq+8Mz/mEDzAH4
 OAA==
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

Note that semihosting supports puts in serial but I never managed to
get it work, so it's putc only for now.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/serial/Kconfig                     | 18 ++++++-
 drivers/serial/Makefile                    |  1 +
 drivers/serial/serial_xtensa_semihosting.c | 79 ++++++++++++++++++++++++++++++
 3 files changed, 97 insertions(+), 1 deletion(-)

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
index 000000000000..1bf3c18537e7
--- /dev/null
+++ b/drivers/serial/serial_xtensa_semihosting.c
@@ -0,0 +1,79 @@
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
+	if (input)
+		return priv->counter++ & 1;
+	return false;
+}
+
+static const struct dm_serial_ops simc_serial_ops = {
+	.putc = simc_serial_putc,
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

