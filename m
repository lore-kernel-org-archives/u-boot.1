Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B2ACE79D2
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 13:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A3A586B29;
	Wed, 20 Sep 2023 15:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HlXG6yZj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C1C086AF3; Wed, 20 Sep 2023 15:31:12 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D34086AC0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 15:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-792979d4cb5so261850139f.2
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695216669; x=1695821469; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JvpYofe3mF1jqfqD9j8MCxM0rfC7zOZHbRhcREDFl2I=;
 b=HlXG6yZjl1aE3Nqr6/tm6GMfA8pBctblUSAdV17c19UVWI/gJwta8D074Q9YmG+4FV
 JpJ3v1/5NtRs9GrMKSdID4a4Q7oZAVtmB5Agg/CjqxLjuFf54SCGTq2hIytRvwLbbPJh
 u4IpjLT1HxSXOsuAgbVwJFtNS2g6ugRA+QmjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695216669; x=1695821469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JvpYofe3mF1jqfqD9j8MCxM0rfC7zOZHbRhcREDFl2I=;
 b=BtplzBduVVpLEgcNB1/rltFOZz7E22AVB/oYqQ5xtKAIOp8bj7ALQMR/FSLN0Hgfs/
 du3jzclm0SCFEgJ4Qb+K64Bf+2ibaNBXplUimFJ0fx2+Fiyzo3VGxKg7S6GG1Qf1skE6
 or2jmYK1dicvBc8bax5ksUhlS/GKLGe8tWz3vS3Vc29rBYIgGCDkFrfMRf2hCN6l5mXt
 Az0GKjBPuvcph/MAnRDcf1SxqBvOZjPHWKgVcPRcW+b1mZSp0EzQQk3QPw/GLoHUVBgo
 5mJbUOyDqpJGLEDnQtzVT8waiwvl6c389f/dP0XhExCmJiLBs8msfZ96MH9O+t9lzpfc
 kuLw==
X-Gm-Message-State: AOJu0YxAc50+g0iMhDNE5uPVEpccfM5idoLINmzxCArG2ODWgwLz34Qk
 rHXPXyMt76qjrpEqYINoMQ+WZfvSPr1VPASCRY4=
X-Google-Smtp-Source: AGHT+IGA0WcofQaA56J5r9tvCCCMxHD/Wkvs6FsfNOm+ID7dViyWE+h4fLEVW8/mc5hZ9LhiYqREfQ==
X-Received: by 2002:a6b:dd17:0:b0:787:1555:efca with SMTP id
 f23-20020a6bdd17000000b007871555efcamr2801000ioc.5.1695216668602; 
 Wed, 20 Sep 2023 06:31:08 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 q9-20020a0566380ec900b0042b3f0c94d9sm4218066jas.107.2023.09.20.06.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 06:31:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 15/20] efi: Use the installed SMBIOS tables
Date: Wed, 20 Sep 2023 07:29:51 -0600
Message-ID: <20230920133003.1413865-16-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920133003.1413865-14-sjg@chromium.org>
References: <20230920133003.1413865-14-sjg@chromium.org>
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

U-Boot should set up the SMBIOS tables during startup, as it does on x86.
Ensure that it does this correctly on non-x86 machines too, by creating
an event spy for last-stage init.

Tidy up the installation-condition code while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v6:
- Add a condition for mvebu_db-88f3720 last-stage init

Changes in v4:
- Rewrite this to use events instead

Changes in v3:
- Use log_debug() to show the message
- Squash in the next patch

Changes in v2:
- Add new patch

 board/Marvell/mvebu_armada-37xx/board.c |  3 +-
 lib/Kconfig                             |  1 +
 lib/efi_loader/Makefile                 |  2 +-
 lib/efi_loader/efi_setup.c              | 10 ++--
 lib/efi_loader/efi_smbios.c             | 72 ++++++++++++++++---------
 test/py/tests/test_event_dump.py        |  1 +
 6 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
index 3fe5319437ea..04124d8014dd 100644
--- a/board/Marvell/mvebu_armada-37xx/board.c
+++ b/board/Marvell/mvebu_armada-37xx/board.c
@@ -307,7 +307,8 @@ static int last_stage_init(void)
 	struct udevice *bus;
 	ofnode node;
 
-	if (!of_machine_is_compatible("globalscale,espressobin"))
+	if (!CONFIG_IS_ENABLED(DM_MDIO) ||
+	    !of_machine_is_compatible("globalscale,espressobin"))
 		return 0;
 
 	node = ofnode_by_compatible(ofnode_null(), "marvell,orion-mdio");
diff --git a/lib/Kconfig b/lib/Kconfig
index 6b5389f3a87d..79cf9ef0fa31 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1049,6 +1049,7 @@ config SMBIOS
 	bool "SMBIOS support"
 	depends on X86 || EFI_LOADER
 	default y
+	select LAST_STAGE_INIT
 	help
 	  Indicates that this platform can support System Management BIOS
 	  (SMBIOS) tables. These provide various pieces of information about
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 0eb748ff1a59..8d31fc61c601 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -79,7 +79,7 @@ obj-$(CONFIG_VIDEO) += efi_gop.o
 obj-$(CONFIG_BLK) += efi_disk.o
 obj-$(CONFIG_NETDEVICES) += efi_net.o
 obj-$(CONFIG_ACPI) += efi_acpi.o
-obj-$(CONFIG_GENERATE_SMBIOS_TABLE) += efi_smbios.o
+obj-$(CONFIG_SMBIOS) += efi_smbios.o
 obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_rng.o
 obj-$(CONFIG_EFI_TCG2_PROTOCOL) += efi_tcg2.o
 obj-$(CONFIG_EFI_RISCV_BOOT_PROTOCOL) += efi_riscv.o
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index ad719afd6328..e6de685e8795 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -326,11 +326,11 @@ efi_status_t efi_init_obj_list(void)
 		if (ret != EFI_SUCCESS)
 			goto out;
 	}
-#ifdef CONFIG_GENERATE_SMBIOS_TABLE
-	ret = efi_smbios_register();
-	if (ret != EFI_SUCCESS)
-		goto out;
-#endif
+	if (IS_ENABLED(CONFIG_SMBIOS)) {
+		ret = efi_smbios_register();
+		if (ret != EFI_SUCCESS)
+			goto out;
+	}
 	ret = efi_watchdog_register();
 	if (ret != EFI_SUCCESS)
 		goto out;
diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
index 306c0bc54f90..48446f654d9b 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -10,8 +10,14 @@
 #include <common.h>
 #include <efi_loader.h>
 #include <log.h>
+#include <malloc.h>
 #include <mapmem.h>
 #include <smbios.h>
+#include <linux/sizes.h>
+
+enum {
+	TABLE_SIZE	= SZ_4K,
+};
 
 /*
  * Install the SMBIOS table as a configuration table.
@@ -20,36 +26,50 @@
  */
 efi_status_t efi_smbios_register(void)
 {
-	/* Map within the low 32 bits, to allow for 32bit SMBIOS tables */
-	u64 dmi_addr = U32_MAX;
+	ulong addr;
 	efi_status_t ret;
-	void *dmi;
 
-	/* Reserve 4kiB page for SMBIOS */
-	ret = efi_allocate_pages(EFI_ALLOCATE_MAX_ADDRESS,
-				 EFI_RUNTIME_SERVICES_DATA, 1, &dmi_addr);
+	addr = gd->arch.smbios_start;
+	if (!addr) {
+		log_err("No SMBIOS tables to install\n");
+		return EFI_NOT_FOUND;
+	}
+
+	/* Mark space used for tables */
+	ret = efi_add_memory_map(addr, TABLE_SIZE, EFI_RUNTIME_SERVICES_DATA);
+	if (ret)
+		return ret;
+
+	log_debug("EFI using SMBIOS tables at %lx\n", addr);
+
+	/* Install SMBIOS information as configuration table */
+	return efi_install_configuration_table(&smbios_guid,
+					       map_sysmem(addr, 0));
+}
+
+static int install_smbios_table(void)
+{
+	ulong addr;
+	void *buf;
 
-	if (ret != EFI_SUCCESS) {
-		/* Could not find space in lowmem, use highmem instead */
-		ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
-					 EFI_RUNTIME_SERVICES_DATA, 1,
-					 &dmi_addr);
+	if (!IS_ENABLED(CONFIG_GENERATE_SMBIOS_TABLE) || IS_ENABLED(CONFIG_X86))
+		return 0;
 
-		if (ret != EFI_SUCCESS)
-			return ret;
+	/* Align the table to a 4KB boundary to keep EFI happy */
+	buf = memalign(SZ_4K, TABLE_SIZE);
+	if (!buf)
+		return log_msg_ret("mem", -ENOMEM);
+
+	addr = map_to_sysmem(buf);
+	if (!write_smbios_table(addr)) {
+		log_err("Failed to write SMBIOS table\n");
+		return log_msg_ret("smbios", -EINVAL);
 	}
 
-	/*
-	 * Generate SMBIOS tables - we know that efi_allocate_pages() returns
-	 * a 4k-aligned address, so it is safe to assume that
-	 * write_smbios_table() will write the table at that address.
-	 */
-	assert(!(dmi_addr & 0xf));
-	dmi = (void *)(uintptr_t)dmi_addr;
-	if (write_smbios_table(map_to_sysmem(dmi)))
-		/* Install SMBIOS information as configuration table */
-		return efi_install_configuration_table(&smbios_guid, dmi);
-	efi_free_pages(dmi_addr, 1);
-	log_err("Cannot create SMBIOS table\n");
-	return EFI_SUCCESS;
+	/* Make a note of where we put it */
+	log_debug("SMBIOS tables written to %lx\n", addr);
+	gd->arch.smbios_start = addr;
+
+	return 0;
 }
+EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, install_smbios_table);
diff --git a/test/py/tests/test_event_dump.py b/test/py/tests/test_event_dump.py
index a6df9e10e54e..e282c67335cd 100644
--- a/test/py/tests/test_event_dump.py
+++ b/test/py/tests/test_event_dump.py
@@ -18,6 +18,7 @@ def test_event_dump(u_boot_console):
 --------------------  ------------------------------  ------------------------------
 EVT_FT_FIXUP          bootmeth_vbe_ft_fixup           .*boot/vbe_request.c:.*
 EVT_FT_FIXUP          bootmeth_vbe_simple_ft_fixup    .*boot/vbe_simple_os.c:.*
+EVT_LAST_STAGE_INIT   install_smbios_table            .*lib/efi_loader/efi_smbios.c:.*
 EVT_MISC_INIT_F       sandbox_early_getopt_check      .*arch/sandbox/cpu/start.c:.*
 EVT_TEST              h_adder_simple                  .*test/common/event.c:'''
     assert re.match(expect, out, re.MULTILINE) is not None
-- 
2.42.0.459.ge4e396fd5e-goog

