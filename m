Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF5BCF31AE
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 09:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87B1989028;
	Wed,  2 Oct 2024 11:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="JDafQHuC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ADBD89028; Wed,  2 Oct 2024 11:52:05 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D8F288F1F
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 11:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37cc4e718ecso4345633f8f.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 02:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1727862723; x=1728467523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=giHZbf01rwwoceyMzVoYQRwdeJdDCwkr5xoAGCSLuOM=;
 b=JDafQHuCY6s2WT2TPyotQj+HChsDfNIqB78Q012U1y773hk+Qh1FWC+qEkKNXiZRS8
 JTtVa9LdG+uhKrPsXikk66y4H7BWoQeSWmaOQ5ATEibbpriezJYNKOlOQG0Q5uvCpeeu
 pJhMM51WuiM7ypoPtl62tgkDCaFfTDFI8d6IuTsE0Pt3q152cweIyQW9GAu5/A2bdYCD
 iExZ/KEfe7nObtmNGp/7eMT2PlBPm1JuSBirS+vGs2Rp76p4WaHaBXKq9cqKV80PaXNU
 n/JF5gC8VyXBCIcXybDj4CLMOkxbCStJFPJ3JxIR41HlbH5vnReqAhQ0j+jSYRMev219
 k/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727862723; x=1728467523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=giHZbf01rwwoceyMzVoYQRwdeJdDCwkr5xoAGCSLuOM=;
 b=Zj/rjZFMOuDWM30Zft7UWZUAgX7euJ0Yw8vGgE0dXMtdQctxGnf+OI9aDtGaVkC5mM
 1WFm/iTiDFk9CP4bPJNMb1xFDo5JBlUs7guJtXiEnQpqN6f6xIlIa1fUwh+twFw5+WyH
 Z9Xqs2kpg/dwzI/OJjd5Vvh7Q4FV1IxO17wUEcVwYk7EsYBw/9jqXh4RHfq59e4zDHlM
 +PjGXFX0zwIe7t54KK8pP0/AFAhjiFEDf70f39OtVZrZx5pwTzA6jLKQ5kRZL/PjuKMo
 eFm5mUArRyi6G8BZSMYD4odVZBM6m/bppS6feoVEh5oQJYCDSCQCjA9R9yuv1HYApF/4
 aAeg==
X-Gm-Message-State: AOJu0YxsZZRuUp39LZH9hRkMtB2iBFLj0+6L8UnbCbrH/6FAAfXPLCYP
 x4QpGuWk0Vz9y+fKN9wXbIdyCPOogFGrpFE+3dHXGInUy+wGSZcyA79pJ8do6q1iQbIn49ZkIDr
 I
X-Google-Smtp-Source: AGHT+IGRO8jzTGc4XTlxmqmIcr8RNlZvj1IHKJzJYfWJMR3N3oa8ZD6I6ejL54uvT9udj18bg8MT5g==
X-Received: by 2002:a5d:4586:0:b0:37c:d183:abd6 with SMTP id
 ffacd0b85a97d-37cfb9d01e5mr1489640f8f.32.1727862722665; 
 Wed, 02 Oct 2024 02:52:02 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-078-094-000-050.um19.pools.vodafone-ip.de. [78.94.0.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e94c4sm13555292f8f.62.2024.10.02.02.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 02:52:02 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 14/37] efi_loader: Allocate and write ACPI tables
Date: Wed,  2 Oct 2024 11:47:05 +0200
Message-ID: <20241002094832.24933-15-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002094832.24933-1-patrick.rudolph@9elements.com>
References: <20241002094832.24933-1-patrick.rudolph@9elements.com>
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

Allocate memory for ACPI tables inside the efi_loader and write out
the tables similar to SMBIOS tables. When ACPI is enabled and wasn't
installed in other places, install the ACPI table in EFI. Since EFI
is necessary to pass the ACPI table location when FDT isn't used,
there's no need to install it separately.

When CONFIG_BLOBLIST_TABLES is set the tables will be stored in a
bloblist. The tables are still passed to the OS using EFI.

This allows non x86 platforms to boot using ACPI only in case the
EFI loader is being used.

TEST: Booted QEMU SBSA (no QFW) using EFI and ACPI only.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
Changelog v3:
- Drop memalign and use efi_allocate_pages
- Use log_debug instead of debug
- Clarify commit message
- Skip writing ACPI tables on sandbox
- Rename function
- Add function comment

Changelog v6:
- Update header order

---
 lib/efi_loader/efi_acpi.c        | 76 ++++++++++++++++++++++++++++++++
 test/py/tests/test_event_dump.py |  1 +
 2 files changed, 77 insertions(+)

diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
index 67bd7f8ca2..c11abe17b6 100644
--- a/lib/efi_loader/efi_acpi.c
+++ b/lib/efi_loader/efi_acpi.c
@@ -6,15 +6,23 @@
  */
 
 #include <efi_loader.h>
+#include <bloblist.h>
 #include <log.h>
+#include <malloc.h>
 #include <mapmem.h>
 #include <acpi/acpi_table.h>
 #include <asm/global_data.h>
+#include <asm/io.h>
+#include <linux/sizes.h>
+#include <linux/log2.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
 static const efi_guid_t acpi_guid = EFI_ACPI_TABLE_GUID;
 
+enum {
+	TABLE_SIZE	= SZ_64K,
+};
 /*
  * Install the ACPI table as a configuration table.
  *
@@ -47,3 +55,71 @@ efi_status_t efi_acpi_register(void)
 	return efi_install_configuration_table(&acpi_guid,
 					       (void *)(ulong)addr);
 }
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
+	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE))
+		return 0;
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
+	} else {
+		pages = efi_size_in_pages(TABLE_SIZE);
+
+		ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
+					 EFI_ACPI_RECLAIM_MEMORY,
+					 pages, &new_acpi_addr);
+		if (ret != EFI_SUCCESS)
+			return log_msg_ret("mem", -ENOMEM);
+
+		addr = (void *)(uintptr_t)new_acpi_addr;
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
index e282c67335..459bfa26bb 100644
--- a/test/py/tests/test_event_dump.py
+++ b/test/py/tests/test_event_dump.py
@@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
 --------------------  ------------------------------  ------------------------------
 EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
 EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
+EVT_LAST_STAGE_INIT   alloc_write_acpi_tables         .*lib/efi_loader/efi_acpi.c:.*
 EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
 EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
 EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
-- 
2.46.2

