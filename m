Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21F6CE7AB9
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 07:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5766788D23;
	Fri,  6 Sep 2024 09:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="U5pp0yFa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD91E88D7C; Fri,  6 Sep 2024 09:22:53 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05CA388D13
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 09:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8a7929fd64so165932966b.0
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 00:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1725607368; x=1726212168; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OWgxkBqO8/rDM5B1ENseLpxAV430L4JHa7oQUk8bpkE=;
 b=U5pp0yFaW3MCb7uCk3ZS/MofjrYeWl2rS8HoaTDSFKxty+XGNspY6zKUrmZvfmsm7C
 Zgr+UGPQcjSTbBsim6tJ6IJLuQymGxpqWNOylSGD4HyCQE63lSHm9JCPNwC0Qlk7R5Dy
 AG5nm5EVnCgIqvDzM47jiMehfgxu1+ng7ENKuHM71ldAb8oRJSwIQpuIWfUOaVGJAE0h
 w2OVYK2Tztonn2MLFHdaDzT4DlfzDd0DwQ9QK3TeaTorqMVdisVUx4kBe7fbrDHPwT/t
 7XqnVpoxEabgceydteZ7XaZqk2SnrupsgjSI8MvogN0KhgCQb+NM/5LtgB6DQkvIsPI1
 bfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725607368; x=1726212168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OWgxkBqO8/rDM5B1ENseLpxAV430L4JHa7oQUk8bpkE=;
 b=eXQaGUT+KL17HrO/UlmmfDTm/MUbY14cU/nwYhOr3fHR2CJMkSPBwJcxeQ0yjujSHK
 b2+SS7grV+G/1e8GRSiLwNlkYjS5geUrdwq27EEutuNrW5r45f0FAMOwaHutME5w2Hhb
 660fAKAw3jqO+r7s5J6TpYyI2HlU+PWuWu7WaPWs0NAOylUVWQ+sowN6sNeVuIQkm72V
 TzFygG5pmGI/Qc9YfB8wFTJFWhR8gBtVo+JlZ7DoZbguc11iTU6vAHQpwdvgYWYdO72D
 oY9mCPEuFYBHrOB9f5Z/DuC/KpO71dftRLhrxK6ms/BKR3IYkt0YbBgEW+KSPP5oobWB
 KROA==
X-Gm-Message-State: AOJu0Yx48LfmeXofJalIqcytOroVFs3W4KbOqRdIu8eUfXfqCHw3LQWT
 ZZus5YpcTdXxHq6pnJAHnCcABM81udc54cMl1QTEbNdDF6+0ZV9L6umQlz0euqCKKcZjSf0Qq9n
 w
X-Google-Smtp-Source: AGHT+IH3DcH/+W0E8OjCGkpqVyt9nV6oP43vydZWZ8pXRCH3veZuxhZglFEdDEloTvUgZ4mVuglI3w==
X-Received: by 2002:a17:906:dc91:b0:a7a:c256:3ce with SMTP id
 a640c23a62f3a-a8a885f97e3mr120061566b.21.1725607368391; 
 Fri, 06 Sep 2024 00:22:48 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7f7f541csm107748466b.193.2024.09.06.00.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 00:22:48 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, bmeng.cn@gmail.com, trini@konsulko.com, sr@denx.de,
 pbrobinson@gmail.com, mbrugger@suse.com, maximilian.brune@9elements.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH v2 14/28] efi_loader: Install ACPI tables
Date: Fri,  6 Sep 2024 09:22:16 +0200
Message-ID: <20240906072231.2531491-15-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
References: <20240906072231.2531491-1-patrick.rudolph@9elements.com>
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

Install ACPI tables inside the efi_loader similar to SMBIOS tables.
When ACPI is enabled and wasn't installed in other places, install
the ACPI table in EFI. Since EFI is necessary to pass the ACPI
table location when FDT isn't used, there's no need to install it
separately.

When CONFIG_BLOBLIST_TABLES is set the tables will be stored in a
bloblist.

TEST: Booted QEMU SBSA using EFI and ACPI only.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
---
 lib/efi_loader/efi_acpi.c        | 57 ++++++++++++++++++++++++++++++--
 test/py/tests/test_event_dump.py |  1 +
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_acpi.c b/lib/efi_loader/efi_acpi.c
index 67bd7f8ca2..9262f21ea6 100644
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
@@ -47,3 +55,48 @@ efi_status_t efi_acpi_register(void)
 	return efi_install_configuration_table(&acpi_guid,
 					       (void *)(ulong)addr);
 }
+
+static int install_acpi_table(void)
+{
+	u64 rom_addr, rom_table_end;
+	void *addr;
+
+	if (!IS_ENABLED(CONFIG_GENERATE_ACPI_TABLE) ||
+	    IS_ENABLED(CONFIG_X86) ||
+	    IS_ENABLED(CONFIG_QFW_ACPI))
+		return 0;
+
+	/* Align the table to a 4KB boundary to keep EFI happy */
+	if (IS_ENABLED(CONFIG_BLOBLIST_TABLES))
+		addr = bloblist_add(BLOBLISTT_ACPI_TABLES, TABLE_SIZE,
+				    ilog2(SZ_4K));
+	else
+		addr = memalign(SZ_4K, TABLE_SIZE);
+
+	if (!addr)
+		return log_msg_ret("mem", -ENOBUFS);
+
+	rom_addr = virt_to_phys(addr);
+
+	gd->arch.table_start_high = rom_addr;
+
+	rom_table_end = write_acpi_tables(rom_addr);
+	if (!rom_table_end) {
+		log_err("Can't create ACPI configuration table\n");
+		return -EINTR;
+	}
+
+	debug("- wrote 'acpi' to %llx, end %llx\n", rom_addr, rom_table_end);
+	if (rom_table_end - rom_addr > TABLE_SIZE) {
+		log_err("Out of space for configuration tables: need %llx, have %x\n",
+			rom_table_end - rom_addr, TABLE_SIZE);
+		return log_msg_ret("acpi", -ENOSPC);
+	}
+	gd->arch.table_end_high = rom_table_end;
+
+	debug("- done writing tables\n");
+
+	return 0;
+}
+
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_acpi_table);
diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
index e282c67335..88bbf34f71 100644
--- a/test/py/tests/test_event_dump.py
+++ b/test/py/tests/test_event_dump.py
@@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
 --------------------  ------------------------------  ------------------------------
 EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
 EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
+EVT_LAST_STAGE_INIT   install_acpi_table              .*lib/efi_loader/efi_acpi.c:.*
 EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
 EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
 EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
-- 
2.45.2

