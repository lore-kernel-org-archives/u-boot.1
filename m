Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52772CF855D
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 08:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 798108406D;
	Thu, 20 Nov 2025 09:51:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.b="byYrl8qY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A16884073; Thu, 20 Nov 2025 09:51:07 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DB3184062
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 09:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adriana@arista.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-295351ad2f5so1166425ad.3
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 00:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=google; t=1763628661; x=1764233461; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CJOE/NYRh/O3bhgm9GOkqDWamgpIUUrl9NxhRVzWOKk=;
 b=byYrl8qY/KIX12Ro6CDjQquAeR5ir7sai1CdRxIPunjOjoE9wBEmVCzRuOFEk95wu+
 mA/nZxZgosZY2GOdnk5YIk5wmT9SIH5wUDMcRjkucor0DaJWvmggpcE6K6Wa9ls8b9cY
 BIvTh+Tv51ZvhoMzlPBMNy3mq1j+z63X86V2TPKIctpB/ZN80CFsRvvRtOKGhZ2PnWNj
 Lydqga1WdVgUmX8aHosL6WwSGt3A3/H360Nweig9kM9Ncde5vKXkwscazuyCJSlgpeZn
 CInAoNrb3yT7fuHlwRuRacA0MWUpT3WABqOaQyiQ5/PhiZHdmHYDiCSduPhpnYvENyYq
 IQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763628661; x=1764233461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJOE/NYRh/O3bhgm9GOkqDWamgpIUUrl9NxhRVzWOKk=;
 b=R/q+uT0IdJV50YKG3YnTk6/yiyLM/Rnn3kdt5Gl3dg+vY+OOF6+uT8Pfj6yNRaQ3+v
 3Marfb1PQeJDfuVi72Fs4zTJt3v/0EZn3txC4QU8NbOJyEVmLzTsY/AqDtg1P9eBK7x9
 GsWCSnHPPHLFFS7gkI0K5ZF2JlKxyNsduR9matqJXEAHeek3KhK+O8xJC6D4Ty0D6Tj8
 rZM9eSG9OgUz5mWTPiKIKRTSsRyYcuIK6qx2zCdez/0ypPbA5FjXR7QxVMkzNhICGx0u
 scMeyEyzRs9A565XkXIp02XIJ/8wYr6riYQtSGvOVwRi4iSQ/eBf6pFiT6VGiXOI6lUj
 y8Jw==
X-Gm-Message-State: AOJu0Yw2RYFGjkx9oqMhKYwZcfwrhVAjlSwPUEHsg9hGOPaB4TF0rzz1
 l5Mh6Q8AsAmtVwiHVAxpH7nZE+lSvY2uJLEc6gB80disgmRnTOIXmja/HkRH8zPicwhVoOeIZx+
 QkMd4PQ==
X-Gm-Gg: ASbGncvUn04lvIPBkm5jiLFr/ww9o6c8FgisqQ5cb6EDmbGgeQgkkcOJuC1pQkJ3xSa
 F0FMU5AST8WYckfTxEVe6gIJKv3hTXDF1SRqB/CjXnuFqPtdYscMoppjKvihrSpSWAKmYWx2Joi
 1LPEqu2OS/Bj2S8ec8pHwRL/Hla2PIV9+XOC6quXnxMCx5risinLT2w18we5bed3NJMNnclfxGz
 pFVhx0zNaKGzvRGfv5RhCO95oeX3Xnn41mA03fttHuyROK97NjFRnbT/rxCB5faJF6t1bNdtAS1
 HJNt4vFnzld/CYIEmVtoOrwwLlKz7gwigTpmKgDkhcyjiKVWzn2DK7dHi9bAGUIVmjSbifTUtI2
 s788w2Sko4kLo9IsMIEFUgQCwGC0xpWplMtv/WHcaZjhDmNzevds1wuMkJtn7K/51CUBJ8xaw6B
 TkWQtKXgq/OH7ygeKp3n09LXka3yM7M815rfz9RGQfx21W0MBPyG/D5sP6cQ==
X-Google-Smtp-Source: AGHT+IGnATTJT+qV59+HUqqoITvD8aQTMx6cGtMyArhbDVZEpygztHHgoFE4Gdjpsu13sTpyghskKQ==
X-Received: by 2002:a05:7022:ea46:10b0:11b:acd7:4e48 with SMTP id
 a92af1059eb24-11c9382df20mr726159c88.2.1763628661190; 
 Thu, 20 Nov 2025 00:51:01 -0800 (PST)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e5674csm9062261c88.8.2025.11.20.00.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 00:51:00 -0800 (PST)
From: Adriana Nicolae <adriana@arista.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, ddrokosov@salutedevices.com,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, xypron.glpk@gmx.de,
 kojima.masahisa@socionext.com, richard@nod.at, semen.protsenko@linaro.org,
 joao.goncalves@toradex.com, adriana@arista.com
Subject: [PATCH v5] boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI
 boots
Date: Thu, 20 Nov 2025 00:50:57 -0800
Message-ID: <20251120085057.549221-1-adriana@arista.com>
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

From: adriana <adriana@arista.com>

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
 test/dm/fdtdec.c   | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

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

