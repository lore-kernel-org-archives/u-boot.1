Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBC5CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 16:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B1DE8443A;
	Thu, 27 Nov 2025 17:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.b="afYFpQvs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1753784440; Thu, 27 Nov 2025 17:28:43 +0100 (CET)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27EDA84439
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 17:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adriana@arista.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b983fbc731bso75223a12.2
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 08:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=google; t=1764260918; x=1764865718; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GI+fKGR9VFGrKRAasBEQdIdv13DC/1cAeCRZYMkK7tc=;
 b=afYFpQvsAnjBADbK4Dbo3aZscj42ZG9rzUGzsut4CyHxWKILP9MfWGwuzF9L6rGmk8
 ytTDbHKhoMFVM4wvV01kkDgT60s7y/qdIJ5cItmZ0ya2q9Qnv97WimHS98rf7CK1WI9r
 +86xBl3sSv4DK4y5hYJ2mtKY/S5t8O3qT/EGprrSKc5T3vVruQ5OcKGzmok60qVVtJY9
 aAlLRUO0ieTAb/1uYQBI95QwP006hfh5TYXoim0OgshERgRezjOsb3lH9w5Q7n8ec7LN
 5QJPUibon/lv2sibTY5mxJJeRwfP6KHqz3stWtcWYORELH7WgHnYrShIiJXROFqGMIkz
 dN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764260918; x=1764865718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GI+fKGR9VFGrKRAasBEQdIdv13DC/1cAeCRZYMkK7tc=;
 b=WvCPo5bpElL7NjuT7Hd/ggXVibxjsu3eHiGM7/y9hFv36YRvmMrPrjux2oDw4hh5Eo
 U+SK7BrW1VutxN9iFA+srB9s/v0ILusIejelPbcgZxpWLhyHPkEpOm+olqrnyHY+ph96
 FqZvkBzjVWLZjkFQjpPFsOwfdYGyaB4+jhuPlOEe/oG5IVh1rscXEz/bTOwccu6PKxdK
 ByzaSM0wEnqrPUq9uGGoR5qEeESBmDCl6ddh6BjR691d7yA9gujS3e97nL/yC46ge+Zj
 aZ5Eq0N+kWovd4jdSctvrZEgFzgGZ1YLW9bbjPK2NUHRSJ+hjofXyWRG2UF3u5dxEqZL
 5ztQ==
X-Gm-Message-State: AOJu0YzJYplfHfX5ujadc17JnQm1dk0ZI5OwWNxAF8hpRjHi2FA4Z/A1
 v10Hui2KfUWKMPJS/dPUuAGGl1r9s4oDffDOPwwvLy17ck7Iv7eiCBxzJYzymBgZZs1E1g2dZo+
 d6ZUK2Q==
X-Gm-Gg: ASbGncv7SN5WPAcmR+zK5Y3zVksdN41HC6pif/0c2DpX6nvMl/oHjPzoaPbZ9MUnDfY
 ZTJocITyVN18ShF+ac22ZhPxbE2zWGFVvrAJHfYY5GCAyFt2NZsF88nTW7acJtfEWdRvMFtqhue
 VGlXmy//SjkPDNYiXMH6alA6VZa3h3xatpQRawTs2tLp8aqEGIT/v029FV1XvvNNXvmDNu8IFSe
 2ibdWyq0NhkoMnFw0nW8D3wjGOUuETZdS83WEFQqZYECsRR1/EIgOb90JmMXIrMaDryOslLOXFJ
 AoRJT37qkagLZKgoTdbnRzM8FdC1aJhIkNiLBwTMy+slqq3L/XAE2b3vleLzcQQ5p8J2T/JrVr9
 MfoE8Y4UE6t5n7UqqkBWRa9G6Ic8vpB8pa8ZIbJjH+Dt+Dvlvrd6Mmr7MMxQOB+ZmjbcK2QIYQp
 n4+Ba0lszbV4ZgOuLlj+eX4cz8Ay0yGE+Y0WE6mVJxvXHF2Lg=
X-Google-Smtp-Source: AGHT+IFu/F3tnrZPVuRD0Uiw2icdYjQiWhaQjIvmRonmvlMAGY1HgwipH0TG+T3u/V7fzhgQuanURw==
X-Received: by 2002:a05:693c:2a0c:b0:2a4:3593:5fc8 with SMTP id
 5a478bee46e88-2a719277278mr10639508eec.2.1764260918140; 
 Thu, 27 Nov 2025 08:28:38 -0800 (PST)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.12])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a965b47caasm7788709eec.6.2025.11.27.08.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 08:28:37 -0800 (PST)
From: Adriana Nicolae <adriana@arista.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, ddrokosov@salutedevices.com,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, xypron.glpk@gmx.de,
 kojima.masahisa@socionext.com, richard@nod.at, semen.protsenko@linaro.org,
 joao.goncalves@toradex.com, adriana@arista.com
Subject: [PATCH v6] boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI
 boots
Date: Thu, 27 Nov 2025 08:28:34 -0800
Message-ID: <20251127162834.596695-1-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
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

The Linux kernel can discover SMBIOS tables through two primary methods:
1. Via EFI tables, when using EFI boot;
2. Via the 'smbios3-entrypoint' property in the /chosen node of the
device tree.

When U-Boot boots a Linux kernel using a non-EFI command ("bootm",
"bootz", or "booti"), the kernel relies on the device tree to detect
the hardware. If SMBIOS tables are available in U-Boot, they should
be passed to the kernel via this device tree property.

This patch modifies boot_fdt_prepare(), to inject the SMBIOSv3 table
address into the device tree if there is a table generated by U-boot.
The "board_fdt_chosen_smbios" is weak in order to leave the possibilty
for specific boards to select custom SMBIOS addresses.

The changes in this patch are added in the context of supporting this
device tree property in linux kernel:
https://lkml.org/lkml/2025/10/24/1393

Device tree schema was updated to include the "smbios3-entrypoint" node
in pull request: https://github.com/devicetree-org/dt-schema/pull/177

Signed-off-by: Adriana Nicolae <adriana@arista.com>
---
Changes in v6:
  - Update fdt_test_chosen to include smbios3-entrypoint.

Changes in v5:
  - Allocate 4KiB extra space for fdt blob and align it to 8 bytes.

Changes in v4:
  - Remove weak function board_fdt_chosen_smbios(), replace with
    gd_smbios_start();
  - Return -EAGAIN in test if GENERATE_SMBIOS_TABLE is not enabled;
  - Remove unnecessary fdt cleanup at the end of the test;
  - Added missing newlines at the end of the modified files.

Changes in v3:
  - Moved "board_fdt_chosen_smbios" function to lib/smbios.c
  - Return physical address of smbios entry and use map_sysmem to
    access the entry point;
  - Removed check for config enabled and added check for
    GENERATE_SMBIOS_TABLE;
  - Add test to check that smbios entry address is added into fdt;

Changes in v2:
  - Renamed device tree property to "smbios3-entrypoint".
  - Removed redundant check for CONFIG_SMBIOS.
---
 boot/fdt_support.c | 19 ++++++++++++++++++
 test/cmd/fdt.c     |  9 +++++++++
 test/dm/fdtdec.c   | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 92f2f534ee0..1c215e548db 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -27,6 +27,7 @@
 #include <fdtdec.h>
 #include <version.h>
 #include <video.h>
+#include <smbios.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -333,6 +334,7 @@ int fdt_chosen(void *fdt)
 	int   nodeoffset;
 	int   err;
 	const char *str;		/* used to set string properties */
+	ulong smbiosaddr;		/* SMBIOS table address */
 
 	err = fdt_check_header(fdt);
 	if (err < 0) {
@@ -387,6 +389,23 @@ int fdt_chosen(void *fdt)
 		return err;
 	}
 
+	if (CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE)) {
+		/* Inject SMBIOS address when we have a valid address.
+		* This is useful for systems using booti/bootm instead of bootefi.
+		* Failure to set this property is non-fatal, we only generate a
+		* warning.
+		*/
+		smbiosaddr = gd_smbios_start();
+		if (smbiosaddr) {
+			err = fdt_setprop_u64(fdt, nodeoffset, "smbios3-entrypoint",
+					smbiosaddr);
+			if (err < 0) {
+				printf("WARNING: could not set smbios3-entrypoint %s.\n",
+				fdt_strerror(err));
+			}
+		}
+	}
+
 	return fdt_fixup_stdout(fdt, nodeoffset);
 }
 
diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index 96a8488e172..c519ecd3793 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -1268,6 +1268,7 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 	const char *env_bootargs = env_get("bootargs");
 	char fdt[8192];
 	ulong addr;
+	ulong smbios_addr = gd_smbios_start();
 
 	ut_assertok(make_test_fdt(uts, fdt, sizeof(fdt), &addr));
 	fdt_shrink_to_minimum(fdt, 4096);	/* Resize with 4096 extra bytes */
@@ -1281,6 +1282,10 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 	ut_assertok(run_commandf("fdt chosen"));
 	ut_assertok(run_commandf("fdt print /chosen"));
 	ut_assert_nextline("chosen {");
+	if (CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE))
+		ut_assert_nextline("\tsmbios3-entrypoint = <0x%08x 0x%08x>;",
+				   upper_32_bits(smbiosaddr),
+				   lower_32_bits(smbiosaddr));
 	ut_assert_nextlinen("\tu-boot,version = "); /* Ignore the version string */
 	if (env_bootargs)
 		ut_assert_nextline("\tbootargs = \"%s\";", env_bootargs);
@@ -1300,6 +1305,10 @@ static int fdt_test_chosen(struct unit_test_state *uts)
 			   lower_32_bits(0x1234 + 0x5678 - 1));
 	ut_assert_nextline("\tlinux,initrd-start = <0x%08x 0x%08x>;",
 			   upper_32_bits(0x1234), lower_32_bits(0x1234));
+	if (CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE))
+		ut_assert_nextline("\tsmbios3-entrypoint = <0x%08x 0x%08x>;",
+				   upper_32_bits(smbiosaddr),
+				   lower_32_bits(smbiosaddr));
 	ut_assert_nextlinen("\tu-boot,version = "); /* Ignore the version string */
 	if (env_bootargs)
 		ut_assert_nextline("\tbootargs = \"%s\";", env_bootargs);
diff --git a/test/dm/fdtdec.c b/test/dm/fdtdec.c
index 1f24f1d5dff..ea5a494612c 100644
--- a/test/dm/fdtdec.c
+++ b/test/dm/fdtdec.c
@@ -7,6 +7,9 @@
 #include <asm/global_data.h>
 #include <dm/of_extra.h>
 #include <dm/test.h>
+#include <fdt_support.h>
+#include <mapmem.h>
+#include <smbios.h>
 #include <test/ut.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -129,3 +132,48 @@ static int dm_test_fdtdec_add_reserved_memory(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_fdtdec_add_reserved_memory,
 	UTF_SCAN_PDATA | UTF_SCAN_FDT | UTF_FLAT_TREE);
+
+static int dm_test_fdt_chosen_smbios(struct unit_test_state *uts)
+{
+	void *blob;
+	ulong val;
+	struct smbios3_entry *entry;
+	int chosen, blob_sz;
+	const fdt64_t *prop;
+
+	if (!CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE)) {
+		return -EAGAIN;
+	}
+
+	blob_sz = fdt_totalsize(gd->fdt_blob) + 4096;
+	blob = memalign(8, blob_sz);
+	ut_assertnonnull(blob);
+
+	/* Make a writable copy of the fdt blob */
+	ut_assertok(fdt_open_into(gd->fdt_blob, blob, blob_sz));
+
+	/* Mock SMBIOS table */
+	entry = map_sysmem(gd->arch.smbios_start, sizeof(struct smbios3_entry));
+	memcpy(entry->anchor, "_SM3_", 5);
+	entry->length = sizeof(struct smbios3_entry);
+	unmap_sysmem(entry);
+
+	/* Force fdt_chosen to run */
+	ut_assertok(fdt_chosen(blob));
+
+	chosen = fdt_path_offset(blob, "/chosen");
+	ut_assert(chosen >= 0);
+
+	/* Verify the property exists */
+	prop = fdt_getprop(blob, chosen, "smbios3-entrypoint", NULL);
+	ut_assertnonnull(prop);
+
+	/* Verify the property matches smbios_start */
+	val = fdt64_to_cpu(*prop);
+	ut_asserteq_64(gd->arch.smbios_start, val);
+
+	free(blob);
+
+	return 0;
+}
+DM_TEST(dm_test_fdt_chosen_smbios, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.51.0

