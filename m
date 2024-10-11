Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE39CFD31D
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67AA78932D;
	Fri, 11 Oct 2024 12:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="a/hyrTaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B052F89327; Fri, 11 Oct 2024 12:34:52 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9E358931E
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9953bdc341so175093266b.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642890; x=1729247690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nloMzF7nCdp69ohm7b64TFd9QODroRHTcjmOy2DXE34=;
 b=a/hyrTaXtcWIfKaVyYLfqiK+z4g5Qa0pfryB8WbmlVx/0P2jUupnE56x7CF5ZXi7UM
 LzzJbEwNlDR6uAqHMgHdC9XcPo65kn86/pFmMaXLjwZJ0pMBge5bUWe4Aa4Syc4Drryo
 j4ttPi0Uf6Q5F7GcwUmVZGFAKSFAHn1fvF6eMPkAFfjbd1DoNYjxRq8uekPGKbEqUQw+
 l0hpFsYiiANdDK+bATFwKmzRf6A/mG0Lfnccow6k7QcxuC3AGBi+PL4fVvcf616+cFGY
 1aQq4zeYaxEEzHypiYgcslgfoMs3sdv6j6ZMYnjuwXDwCb9Iy/3hIEFhbGXjago3V0AE
 T08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642890; x=1729247690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nloMzF7nCdp69ohm7b64TFd9QODroRHTcjmOy2DXE34=;
 b=GtHdkFfo57W5nsto2oa1rl4KEAktNNHEO4ePKRK6OIknM3jje4DI6Sw13xc2ty5bpo
 7qJBt+49LqD9PAzoiZCjw+zKeXxacXvwxU5Ic3cJ6yqQg4k5cdv0MHX0nABqSxIZOFEB
 TiuA5CAARln5Uk8qe0o7mtZsnwnTuwJlsbeFVCXREqUluNfITGq8VZF1Rxd0kF26Yj83
 8hdx9AevlhrU7jXLE1A60VCrpkTCktn9HMqgvKVL0TvDM1YFsD5fg6PNNT6I1Co1xhwc
 vNp/My4O5JCs6skhY7dh9QsKzBd6Iqwgysp9b6JF55jKCP0a5sSA8Trcibi9zfDAany+
 19YQ==
X-Gm-Message-State: AOJu0YwVCHsAQgoOCVtKClUWvpW2dx9zG/4PIFMauYD12t6Ps5fOHwtE
 e3bg4JIxO7Tr6cDA6pWIbqCRTaI+SHkC5G+nihJjGvezytZqS5z6kPyW2aCTHQPet/Mw0sqMl4i
 E+F0=
X-Google-Smtp-Source: AGHT+IGcdCLsO2XLLYhuzW+nnoLqDuc8/dZlCnHCP1BF7nczi0qOEyQK9b/IjVTmsh5zkqgVR4iCaA==
X-Received: by 2002:a17:907:7da5:b0:a99:4b56:cf76 with SMTP id
 a640c23a62f3a-a99b9585d90mr162759066b.47.1728642890057; 
 Fri, 11 Oct 2024 03:34:50 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:34:49 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 14/37] acpi: Allocate and write ACPI tables
Date: Fri, 11 Oct 2024 12:22:55 +0200
Message-ID: <20241011102419.12523-15-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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
installed in other places, install the ACPI table using either BLOBLISTs
or EFI allocate pages.

This allows non x86 platforms to boot using ACPI only in case the
EFI loader is being used, since EFI is necessary to advertise the location
of the ACPI tables in memory.

TEST: Booted QEMU SBSA (no QFW) using EFI and ACPI only.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/acpi/acpi_table.c            | 80 +++++++++++++++++++++++++++++++-
 test/py/tests/test_event_dump.py |  1 +
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
index d6357bdc4d..d8112e58ca 100644
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
@@ -752,3 +763,70 @@ static int acpi_write_iort(struct acpi_ctx *ctx, const struct acpi_writer *entry
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
+	u64 table_addr, table_end;
+	u64 new_acpi_addr = 0;
+	efi_uintn_t pages;
+	efi_status_t ret;
+	void *addr;
+
+	if (IS_ENABLED(CONFIG_X86) ||
+	    IS_ENABLED(CONFIG_QFW_ACPI) ||
+	    IS_ENABLED(CONFIG_SANDBOX)) {
+		log_debug("Skipping writing ACPI tables as already done\n");
+		return 0;
+	}
+
+	/* Align the table to a 4KB boundary to keep EFI happy */
+	if (IS_ENABLED(CONFIG_BLOBLIST_TABLES)) {
+		addr = bloblist_add(BLOBLISTT_ACPI_TABLES, TABLE_SIZE,
+				    ilog2(SZ_4K));
+
+		if (!addr)
+			return log_msg_ret("mem", -ENOMEM);
+	} else if (IS_ENABLED(CONFIG_EFI_LOADER)) {
+		pages = efi_size_in_pages(TABLE_SIZE);
+
+		ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
+					 EFI_ACPI_RECLAIM_MEMORY,
+					 pages, &new_acpi_addr);
+		if (ret != EFI_SUCCESS)
+			return log_msg_ret("mem", -ENOMEM);
+
+		addr = (void *)(uintptr_t)new_acpi_addr;
+	} else {
+		return log_msg_ret("mem", -ENOMEM);
+	}
+
+	table_addr = virt_to_phys(addr);
+
+	gd->arch.table_start_high = table_addr;
+
+	table_end = write_acpi_tables(table_addr);
+	if (!table_end) {
+		log_err("Can't create ACPI configuration table\n");
+		return -EINTR;
+	}
+
+	log_debug("- wrote 'acpi' to %llx, end %llx\n", table_addr, table_end);
+	if (table_end - table_addr > TABLE_SIZE) {
+		log_err("Out of space for configuration tables: need %llx, have %x\n",
+			table_end - table_addr, TABLE_SIZE);
+		return log_msg_ret("acpi", -ENOSPC);
+	}
+	gd->arch.table_end_high = table_end;
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

