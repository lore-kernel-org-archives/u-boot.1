Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ACCCF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB05E8932E;
	Wed, 23 Oct 2024 15:29:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="G3DyTtkc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F890892AA; Wed, 23 Oct 2024 15:28:59 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2897889268
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4315baec69eso64168735e9.2
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 06:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1729690134; x=1730294934; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HHvYbk4996H74dNl5WyywNl/UI8EHhZ+WRK7MnNsZBM=;
 b=G3DyTtkcHbZ3Wy9bUz2mVDiJRInlw1D8hNcEijZdO/hWYoo394dq8ZvYMZDiRssCIb
 RUr7t4z1CLDB5CSLJuqvwUIV+qof9SaUiFvxUi8rQDF4azKil/1spcHh9hKSRxgGCRL4
 eSyFRLfShg6XR0s4IoLrye8EzRC/KmfGy2tzZBUsyWz/zYtPaTP6XGF8hG4EGHMD2NLI
 uzScrIx4HbgAiNd1KOdtsjttCB2sGgbZW2JQf2mqJEmUPdgqteIB8v8WhmEKMq4Jiu7X
 Spixv2JqcIDkF8tvijd30HdtCbzvhETO6lGIVXCVhPkOMRkBOFYQLKOI8eLiwaSbClRC
 L0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729690134; x=1730294934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HHvYbk4996H74dNl5WyywNl/UI8EHhZ+WRK7MnNsZBM=;
 b=P6WjgWwzeoGPjMnH3OeTSM1QhHKHTXks1phFj+agHlByEaJZIpEck89TFL4X5asv8z
 Bl/LVjEN7q/yyDn8AxjqxhJ3wihYg0m2QYJOY/lE2jikMVitZbMuJFhrSV3GrNMhRwL2
 2Nr4ap1sxPk31QBvOfeAKP7o/WyFlRlahQ07AIL/8iuZHY1xQQ56h9FQtR7eScpOER4R
 LiZ6sFpATaEBYp02FEF1kei8UMmJUWPD2/S3U0L4rpv/+hglLY1k5okahXMZXhMR5wfg
 khqPjjCOGIs8McD8RIr3QwysXzq4nWiuF5Luoph3w+gKRp53IHD5BKPmFAT5hxs0fO3I
 BjNw==
X-Gm-Message-State: AOJu0YzoMSssRIY5LDUZzrlMnAmmN3RnKr8I4aSvbBbmRbGR8KtZrnVQ
 JAEyqiRH0h47CmjNTReTDSnh6tRMpdMHUC30qfsE3p1y8XFUOtAD1P1MkgGtLs/SutqeeKLQe3L
 j
X-Google-Smtp-Source: AGHT+IH5KxOUdRdHIuFWpptqJnFfMjY9OtbGPuvqDfZhowzcAvOhW/u46GiTtpEKnUz4dbe9FWmQtw==
X-Received: by 2002:a05:600c:5108:b0:431:586e:7e7 with SMTP id
 5b1f17b1804b1-431841eb602mr21961055e9.1.1729690134523; 
 Wed, 23 Oct 2024 06:28:54 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9b186sm8907478f8f.91.2024.10.23.06.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 06:28:54 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v10 14/37] acpi: Allocate and write ACPI tables
Date: Wed, 23 Oct 2024 15:19:57 +0200
Message-ID: <20241023132116.970117-15-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241023132116.970117-1-patrick.rudolph@9elements.com>
References: <20241023132116.970117-1-patrick.rudolph@9elements.com>
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

Allocate memory for ACPI tables in generic acpi code. When ACPI wasn't
installed in other places, install the ACPI table using BLOBLISTs.

This allows non x86 platforms to boot using ACPI only in case the
EFI loader is being used, since EFI is necessary to advertise the location
of the ACPI tables in memory.

TEST: Booted QEMU SBSA (no QFW) using EFI and ACPI only.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
Changelog v8:
- Only use bloblist to store tables on arm
---
 lib/acpi/acpi_table.c            | 66 +++++++++++++++++++++++++++++++-
 test/py/tests/test_event_dump.py |  1 +
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index d6357bdc4d..e6ebffcf1b 100644
--- a/lib/acpi/acpi_table.c
+++ b/lib/acpi/acpi_table.c
@@ -5,8 +5,11 @@
  * Copyright 2019 Google LLC
  */
 
-#include <dm.h>
+#include <bloblist.h>
 #include <cpu.h>
+#include <dm.h>
+#include <efi_api.h>
+#include <efi_loader.h>
 #include <log.h>
 #include <mapmem.h>
 #include <tables_csum.h>
@@ -16,6 +19,14 @@
 #include <acpi/acpi_device.h>
 #include <asm/global_data.h>
 #include <dm/acpi.h>
+#include <linux/sizes.h>
+#include <linux/log2.h>
+
+enum {
+	TABLE_SIZE	= SZ_64K,
+};
+
+DECLARE_GLOBAL_DATA_PTR;
 
 /*
  * OEM_REVISION is 32-bit unsigned number. It should be increased only when
@@ -752,3 +763,56 @@ static int acpi_write_iort(struct acpi_ctx *ctx, const struct acpi_writer *entry
 }
 
 ACPI_WRITER(5iort, "IORT", acpi_write_iort, 0);
+
+/*
+ * Allocate memory for ACPI tables and write ACPI tables to the
+ * allocated buffer.
+ *
+ * Return:	status code
+ */
+static int alloc_write_acpi_tables(void)
+{
+	u64 table_end;
+	void *addr;
+
+	if (IS_ENABLED(CONFIG_X86) ||
+	    IS_ENABLED(CONFIG_QFW_ACPI) ||
+	    IS_ENABLED(CONFIG_SANDBOX)) {
+		log_debug("Skipping writing ACPI tables as already done\n");
+		return 0;
+	}
+
+	if (!IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
+		log_debug("Skipping writing ACPI tables as BLOBLIST_TABLES is not selected\n");
+		return 0;
+	}
+
+	/* Align the table to a 4KB boundary to keep EFI happy */
+	addr = bloblist_add(BLOBLISTT_ACPI_TABLES, TABLE_SIZE,
+			    ilog2(SZ_4K));
+
+	if (!addr)
+		return log_msg_ret("mem", -ENOMEM);
+
+	gd->arch.table_start_high = virt_to_phys(addr);
+	gd->arch.table_end_high = gd->arch.table_start_high + TABLE_SIZE;
+
+	table_end = write_acpi_tables(gd->arch.table_start_high);
+	if (!table_end) {
+		log_err("Can't create ACPI configuration table\n");
+		return -EINTR;
+	}
+
+	log_debug("- wrote 'acpi' to %lx, end %llx\n", gd->arch.table_start_high, table_end);
+	if (table_end > gd->arch.table_end_high) {
+		log_err("Out of space for configuration tables: need %llx, have %x\n",
+			table_end - gd->arch.table_start_high, TABLE_SIZE);
+		return log_msg_ret("acpi", -ENOSPC);
+	}
+
+	log_debug("- done writing tables\n");
+
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, alloc_write_acpi_tables);
diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
index e282c67335..45143c1c7d 100644
--- a/test/py/tests/test_event_dump.py
+++ b/test/py/tests/test_event_dump.py
@@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
 --------------------  ------------------------------  ------------------------------
 EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
 EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
+EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         .*lib/acpi/acpi_table.c:.*
 EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
 EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
 EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
-- 
2.46.2

