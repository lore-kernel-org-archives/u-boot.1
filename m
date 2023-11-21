Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEFEC61D90
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 15:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93DFE87582;
	Tue, 21 Nov 2023 16:28:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="FE02ywQZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A08B8875F1; Tue, 21 Nov 2023 16:28:02 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCD2287582
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 16:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D8830423D3; 
 Tue, 21 Nov 2023 15:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1700580479;
 bh=YtPbyBe9YFS+T8Qg5uHgprJqbnlqHJuTTO4hDa46Q6Q=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=FE02ywQZFoc2c0HOqih4y+k17jRNxXdhi1gRLhsgGHK/d9V9h+EEyMOd0yLkY5tP1
 yC39kz4YbFz4VAuUXLBI8nFedpG34se7ek4N59CeyYg67VzjTOGwV1NnBEdjYJdDfv
 hObziMxk3zL6Gi3r02jGWqQfoYLhDW2MK2L2Fc9ul0VdkFHpasUX+GYLHYeVsEskvH
 OOU+cY3sdn2CNN933QFJSMv4ygujRjT/y/XPGuFi61g8nVDw4EwdpxnTlGYuPrPuNt
 WwFcD+e9xO60utEzHJK/uYSTv+qP14SjLwCxb9LhMm6L/D2ULnngdBmUom2Cjoor9F
 Sqm6ZxbBpSn6Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: Yu Chien Peter Lin <peterlin@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, Asherah Connor <ashe@kivikakk.ee>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/7] acpi: Kconfig symbol CONFIG_QFW_ACPI
Date: Tue, 21 Nov 2023 16:27:34 +0100
Message-Id: <20231121152740.24783-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
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
---
v2:
	new patch
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

