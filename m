Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CADAC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 17:23:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADD7A870B7;
	Thu,  9 Nov 2023 18:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="d6RU0Ede";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2402287108; Thu,  9 Nov 2023 18:23:14 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BD0986F85
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 18:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [156.39.10.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 736F3400E0; 
 Thu,  9 Nov 2023 17:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699550590;
 bh=pYS5GiAv7yr8ppt35E0VBMjafpsB9NkrGHQG6zkfUK0=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=d6RU0Edeqg1GmkrQ9A1T01ML2QeretMmAwdWArsPb7vEVnvzhVvPFyDEb56pOKCgZ
 iZULe9+b/DwOB/v+0e+1NldoxT6AkF7/jYT+q1WzIcP+xbutsaFrb4XXyh5d6OTNim
 7ctrqG5j7j02rzjFDehRbcgl7PXEIgm366w/KoVX6yiZ4Ji8ha1pK6DC7ARGqwetMQ
 k3afDNWzoykmaVyPTO1JbPXKgNYSJtC0MfeI6Y1lKsLX12YkzLIQj9LmzlZFdY2nby
 ee5q32EueUFwB0O6ZelYJJneBUvBBcw3VccXHFL4+b2g9UKgxvaocGd2ve8oai7+iy
 eL7gfRyXneIDQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH] acpi: move acpi_get_rsdp_addr() to acpi/acpi_table.h
Date: Thu,  9 Nov 2023 09:23:02 -0800
Message-Id: <20231109172302.54324-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

Function acpi_get_rsdp_addr() is needed on all architectures which
write ACPI tables. Move the definition from the x86 include to an
architecture independent one.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/x86/include/asm/acpi_table.h | 9 ---------
 drivers/misc/qfw.c                | 1 +
 include/acpi/acpi_table.h         | 9 +++++++++
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/acpi_table.h b/arch/x86/include/asm/acpi_table.h
index 226753b65d..57e41654ce 100644
--- a/arch/x86/include/asm/acpi_table.h
+++ b/arch/x86/include/asm/acpi_table.h
@@ -64,15 +64,6 @@ int acpi_write_dbg2_pci_uart(struct acpi_ctx *ctx, struct udevice *dev,
  */
 int acpi_create_gnvs(struct acpi_global_nvs *gnvs);
 
-/**
- * acpi_get_rsdp_addr() - get ACPI RSDP table address
- *
- * This routine returns the ACPI RSDP table address in the system memory.
- *
- * @return:	ACPI RSDP table address
- */
-ulong acpi_get_rsdp_addr(void);
-
 /**
  * arch_read_sci_irq_select() - Read the system-control interrupt number
  *
diff --git a/drivers/misc/qfw.c b/drivers/misc/qfw.c
index 7c01bf23d5..e3b6b4cd74 100644
--- a/drivers/misc/qfw.c
+++ b/drivers/misc/qfw.c
@@ -7,6 +7,7 @@
 #define LOG_CATEGORY UCLASS_QFW
 
 #include <common.h>
+#include <acpi/acpi_table.h>
 #include <bootdev.h>
 #include <bootflow.h>
 #include <bootmeth.h>
diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
index 1f85de091d..a3b67259e6 100644
--- a/include/acpi/acpi_table.h
+++ b/include/acpi/acpi_table.h
@@ -920,6 +920,15 @@ void acpi_fill_header(struct acpi_table_header *header, char *signature);
  */
 int acpi_fill_csrt(struct acpi_ctx *ctx);
 
+/**
+ * acpi_get_rsdp_addr() - get ACPI RSDP table address
+ *
+ * This routine returns the ACPI RSDP table address in the system memory.
+ *
+ * @return:	ACPI RSDP table address
+ */
+ulong acpi_get_rsdp_addr(void);
+
 /**
  * write_acpi_tables() - Write out the ACPI tables
  *
-- 
2.40.1

