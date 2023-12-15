Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7A8C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 13:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 333B287BE7;
	Fri, 15 Dec 2023 14:33:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JxMiI0Tl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D199B87BA7; Fri, 15 Dec 2023 14:32:57 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB0E987BC4
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 836D7400F2; 
 Fri, 15 Dec 2023 13:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1702647172;
 bh=R29gHuAb2EzwlAdDKhTTtOY5wGzDWONlDM4j8WsBGxY=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=JxMiI0Tlftk+BlPPqhEoRqKPEJBfdGvR+ux1rYseL1cVgozACtINJJf+khlHR4eh+
 eEpqMK6a1fm2jcmtJKeWESiAiKZczrXlpgmrLcV908y21IKUovjKzMvgvUojm66mae
 T9NfhdT4vzTMhBtFwqae8RS3y1gsr5asTu0ibB6/7uCokLWmbiitHF4Tv+c0b5Han/
 sVdo8f2TLZxoNovpY5Oh9ghSQfHm4AAEEY4+43ByvCg/dETALhTUwNPcD5NJfkSjxC
 CcQRQefcjoXmW031S06/5lFTCAHmFUrjNjT53c9J6c8/OxgsedzGvRFGIx+6EbCZ6P
 cEgwCK7GNc0mQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/9] acpi: Kconfig symbol CONFIG_QFW_ACPI
Date: Fri, 15 Dec 2023 14:32:37 +0100
Message-Id: <20231215133245.7923-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
References: <20231215133245.7923-1-heinrich.schuchardt@canonical.com>
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

We have two implementations of write_acpi_tables(). One for writing ACPI
tables based on ACPI_WRITER() entries another based on copying tables from
QEMU.

Create a symbol CONFIG_QFW_ACPI that signifies copying ACPI tables from
QEMU and use it consistently.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v2:
	no change
---
 drivers/misc/Kconfig   | 7 +++++++
 drivers/misc/qfw.c     | 4 ++--
 lib/acpi/Makefile      | 2 +-
 lib/acpi/acpi_writer.c | 4 ++--
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 97057de8bf..86529efb2e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -540,6 +540,13 @@ config QFW
 	  Hidden option to enable QEMU fw_cfg interface and uclass. This will
 	  be selected by either CONFIG_CMD_QFW or CONFIG_GENERATE_ACPI_TABLE.
 
+config QFW_ACPI
+	bool
+	default y
+	depends on QFW && GENERATE_ACPI_TABLE && !SANDBOX
+	help
+	  Hidden option to read ACPI tables from QEMU.
+
 config QFW_PIO
 	bool
 	depends on QFW
diff --git a/drivers/misc/qfw.c b/drivers/misc/qfw.c
index e3b6b4cd74..307334faf4 100644
--- a/drivers/misc/qfw.c
+++ b/drivers/misc/qfw.c
@@ -21,7 +21,7 @@
 #include <tables_csum.h>
 #include <asm/acpi_table.h>
 
-#if defined(CONFIG_GENERATE_ACPI_TABLE) && !defined(CONFIG_SANDBOX)
+#ifdef QFW_ACPI
 /*
  * This function allocates memory for ACPI tables
  *
@@ -259,7 +259,7 @@ ulong acpi_get_rsdp_addr(void)
 	file = qfw_find_file(dev, "etc/acpi/rsdp");
 	return file->addr;
 }
-#endif
+#endif /* QFW_ACPI */
 
 static void qfw_read_entry_io(struct qfw_dev *qdev, u16 entry, u32 size,
 			      void *address)
diff --git a/lib/acpi/Makefile b/lib/acpi/Makefile
index c1c9675b5d..cc2868488a 100644
--- a/lib/acpi/Makefile
+++ b/lib/acpi/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_$(SPL_)ACPIGEN) += acpi_table.o
 obj-y += acpi_writer.o
 
 # With QEMU the ACPI tables come from there, not from U-Boot
-ifndef CONFIG_QEMU
+ifndef CONFIG_QFW_ACPI
 obj-y += base.o
 obj-y += csrt.o
 obj-y += mcfg.o
diff --git a/lib/acpi/acpi_writer.c b/lib/acpi/acpi_writer.c
index 946f90e8e7..9b9fdc190b 100644
--- a/lib/acpi/acpi_writer.c
+++ b/lib/acpi/acpi_writer.c
@@ -48,7 +48,7 @@ int acpi_write_one(struct acpi_ctx *ctx, const struct acpi_writer *entry)
 	return 0;
 }
 
-#ifndef CONFIG_QEMU
+#ifndef CONFIG_QFW_ACPI
 static int acpi_write_all(struct acpi_ctx *ctx)
 {
 	const struct acpi_writer *writer =
@@ -115,7 +115,7 @@ ulong acpi_get_rsdp_addr(void)
 
 	return map_to_sysmem(gd->acpi_ctx->rsdp);
 }
-#endif /* QEMU */
+#endif /* QFW_ACPI */
 
 void acpi_setup_ctx(struct acpi_ctx *ctx, ulong start)
 {
-- 
2.40.1

