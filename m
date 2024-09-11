Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9FDEE0213
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 06:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C882A891A8;
	Wed, 11 Sep 2024 08:25:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="KOKgf62C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ABCF891A5; Wed, 11 Sep 2024 08:25:45 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6585389164
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 08:25:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d100e9ce0so635600566b.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 23:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1726035943; x=1726640743; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bd75rI/MaM5eaW7o6lxjtl4yKbMMWaxoaArw0dP9bwo=;
 b=KOKgf62C2cBNSit0fRjbrLFJISF5G8dupxakurpVtRx5jb9B/80C9Is6J/ZtGTwB2T
 RqDGKnpSQmd64FNVppIlXPZY52apcjIxiRkIgM4RQEzrpsiu95YYZa9M7FIzsSdSVXVG
 XJ4ksKg5MggG2NpNjbHKJrBO2yAygWe9MVFYLCiP9N3r0vePm3zA5GT7ICaJgYb7CkNr
 dpD952MruPu2/litD3MftHX19JXb+Nz7ztF3T0d0o020myPfDNqDUHrzdWcpY+tIvQkD
 DDk8IFx/vtyOJey/EDGHZ5lhtb5R/M2JJgYC6HxO8u/gdcTeIeXtNc7jI16Ir5Y5763d
 SBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035943; x=1726640743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bd75rI/MaM5eaW7o6lxjtl4yKbMMWaxoaArw0dP9bwo=;
 b=mWx6e4CvmLKvPVyIKBZ88lPKX/wEfb6URs1EKh1DQRlOrpxEAsdSr7x19momKSq97o
 KPs8s24nvx0jedd2ZC6jFmpwEQglImpaAbiDHvv2kuW7lQ5fJBuwAnlvs5tODCBWdw1z
 bcSg8bzPS9Pa9gtFy5FQojU/bGK1qwpfbp4HbJIfxsFePj5PSwJMgQOQRxsdRK95a4Zy
 fvcg/G6f4xcu/GsVKwohFSK5CvWsPTAPXUiga9ArFmPdCn/DVXr4rdUbeIzHJpNTCIeB
 xhLEOht6c8KtXPW0BS87jD/4NwkYN5qtRUXqLVGFhhYvkwVXLFAl76kFj+I4P21X4fVb
 WCoQ==
X-Gm-Message-State: AOJu0YwBkm4hSkfkgSAMV1x/h0CixbuCnvNyND/3PGADNxnOyMd7Iv9Q
 068bYsm0Irtnck1sT3Xp2NSmnfTrwdSW5ecUtjeG7/9ogaYns+ECWTbW2M1+8pOW6tuVNkl42HS
 F
X-Google-Smtp-Source: AGHT+IHVhX0rh5b5sOkfScyrJH+fWbFJ+DMMMktKAbZO++OejYabEVUfmwN8f/8l366IwR2M3a+gvQ==
X-Received: by 2002:a17:907:9484:b0:a8a:926a:d027 with SMTP id
 a640c23a62f3a-a8ffadaca06mr282060666b.45.1726035942743; 
 Tue, 10 Sep 2024 23:25:42 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a43365sm575545366b.94.2024.09.10.23.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:25:42 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 14/30] efi_loader: Allocate and write ACPI tables
Date: Wed, 11 Sep 2024 08:24:04 +0200
Message-ID: <20240911062511.494855-15-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911062511.494855-1-patrick.rudolph@9elements.com>
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
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
---
 lib/efi_loader/efi_acpi.c        | 80 +++++++++++++++++++++++++++++++-
 test/py/tests/test_event_dump.py |  1 +
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
index 67bd7f8ca2..9d38d0060c 100644
--- a/lib/efi_loader/efi_acpi.c
+++ b/lib/efi_loader/efi_acpi.c
@@ -6,15 +6,23 @@
  */
 
 #include <efi_loader.h>
-#include <log.h>
-#include <mapmem.h>
 #include <acpi/acpi_table.h>
 #include <asm/global_data.h>
+#include <asm/io.h>
+#include <bloblist.h>
+#include <linux/sizes.h>
+#include <linux/log2.h>
+#include <log.h>
+#include <malloc.h>
+#include <mapmem.h>
 
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
2.46.0

