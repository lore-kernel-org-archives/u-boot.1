Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A09CCF34AB
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 13:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5E7883700;
	Wed, 19 Nov 2025 14:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.b="Qa2SW5ho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D88F783952; Wed, 19 Nov 2025 14:06:40 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18D9B83015
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 14:06:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adriana@arista.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7bb2fa942daso700630b3a.1
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 05:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=google; t=1763557596; x=1764162396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k0hJyf9odCcoz1MSA+OGWxqvNF1f5L16vlf0mHNtkJE=;
 b=Qa2SW5hoH4A9o87hOxSykglE+B/sHQC3PqVFP+EB9yCCmalBhn0ZfVbQXFPGy6MHN9
 MOEJL4NU3uxq03ml/YNaF2VNnNeA5d+IrQB8VHe0bGn3a481/rtJ+BlN9UlifTl9UsY9
 Fnf5m61wO2w4Bh4/DjHGxed2a3n+peydgl8cmRvQfZ5cZrRhMDE5YEIFGYMFZ/Sfubrd
 3u+0/qk1UkWTK+YZWdgD/SRKo5nQxePqXo7l+QCL8Ezhz/1lVDJ9kqIVXTSL3gNsJXqz
 1MxpEFnpf1uMTrpOZGxVCX6Tb2EFMaczOWSftk4+nG6yCB8MBfBau2UFPWhFPU4iArFV
 ZG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763557596; x=1764162396;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0hJyf9odCcoz1MSA+OGWxqvNF1f5L16vlf0mHNtkJE=;
 b=OnxMuZMWxZ1OH80kAzaXCx2oquEGDya3wgtofWJ5zdl3GqynnlAqIlCee3pOwXafUz
 Y7lHXwBBNNASWdSfGndrmWSWYGbQ4xtXPwyoBcqMMOKUZA/6LuPpCRlHMD4zaFqeSlFT
 2jPxZ+q087R3EYCavnte8JzhEMEI6YNWD3JYG8lVmSM/Q6SlXjdXPpAHz9XJH1P9rLkx
 c8++x7eU4brA2036FoATPz3991+iH0ijIKOM3nxaAJRIA7cFR5lfvxZjOY74tVX/0XRn
 XTqIsIfN9XQk3DO5AH26cHaXZd1TNgSj/D/wfWp1nD++NsTBLA47lu5gwNNpFeVt/4Bu
 o8zw==
X-Gm-Message-State: AOJu0Yw8GgevIj/5jZszm9iq8eqZlgsR/3JAhP8D9Uns5kIu1P9W2d/Y
 hRfqJ+XZ21NZAmzEuz8DJINQbIFDQLW8Q7/S+yyIKTDY9wyvkRTqD7rWfKx5aLU/BDh9QOnWo/k
 opTFW5Q==
X-Gm-Gg: ASbGncvGeboBmLJ/isyKJAKwQ1nrxgk9NIrwyIpAWDWtZlNY7M9HmbACL7hvpryO17b
 qKLO6JWRa973OH/ZfqoeTg4KJsLMwlPpCJbiOFmTJSFZ4B37D7BvMdI40QZanFF6RthYUlAMLUX
 mhfG0cBKw23rrFsx1VaU89mkrZot1+t4iGInut6tCyWPvCfq+4+XoPWu6dysPcrUxWdPXyjIpGX
 oWZfFCUskgItXzIZaOvhY1alPGKEnm9HCQybkTL3hW9u0dVXdo+LvZDd2VLdDjf368huHR0itFR
 iNL2CNK+YnXX5T+IWesHrgosBnaUeqm3mHXNFKT1tKfsb8mXP2Xx/cMQb0WmXYMgiBk0c0BJCYi
 7OrqXQ7Sopn6b5d6rqx738APhISYvHTnN8bNAGwMntZNjpbC1SBJWWarIPJ46C9SbMOUcTRtIdZ
 G4rehKuYm/6x11mIa5jAYhr81tgNrNSNUdh5MzLH5m9gzklSc=
X-Google-Smtp-Source: AGHT+IGXY6EesmuKWz8zdCFFBzdEb/Y/cT3pchveUsKNcv98zH8wYQw8r8pWBAJpnK5mEkvm4rZoKg==
X-Received: by 2002:a05:7022:5f13:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-11c796bff27mr1424274c88.5.1763557595976; 
 Wed, 19 Nov 2025 05:06:35 -0800 (PST)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49d695821sm77858465eec.0.2025.11.19.05.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 05:06:35 -0800 (PST)
From: Adriana Nicolae <adriana@arista.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, ddrokosov@salutedevices.com,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, xypron.glpk@gmx.de,
 kojima.masahisa@socionext.com, richard@nod.at, semen.protsenko@linaro.or,
 joao.goncalves@toradex.com, adriana@arista.com
Subject: [PATCH v3] boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI
 boots
Date: Wed, 19 Nov 2025 05:06:09 -0800
Message-ID: <20251119130609.540014-1-adriana@arista.com>
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
 boot/fdt_support.c | 19 +++++++++++++++++
 include/smbios.h   | 10 +++++++++
 lib/smbios.c       | 38 +++++++++++++++++++++++++++++++++
 test/dm/fdtdec.c   | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 119 insertions(+)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 92f2f534ee0..7da6e7cb2b3 100644
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
+		smbiosaddr = board_fdt_chosen_smbios();
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
 
diff --git a/include/smbios.h b/include/smbios.h
index b5fed57aba2..c37d79aa530 100644
--- a/include/smbios.h
+++ b/include/smbios.h
@@ -383,4 +383,14 @@ int smbios_update_version_full(void *smbios_tab, const char *version);
 void smbios_prepare_measurement(const struct smbios3_entry *entry,
 				struct smbios_header *header);
 
+/**
+ * board_fdt_chosen_smbios() - Provide SMBIOS address for /chosen node
+ *
+ * This function is called by fdt_chosen() to get the SMBIOS table address
+ * that should be added to the /chosen node for non-UEFI boot scenarios.
+ *
+ * Return: Physical address of SMBIOS table, or 0 if not available
+ */
+ulong board_fdt_chosen_smbios(void);
+
 #endif /* _SMBIOS_H_ */
diff --git a/lib/smbios.c b/lib/smbios.c
index b8c2846277a..45ae2d11009 100644
--- a/lib/smbios.c
+++ b/lib/smbios.c
@@ -980,3 +980,41 @@ ulong write_smbios_table(ulong addr)
 
 	return addr;
 }
+
+/**
+ * board_fdt_chosen_smbios - boards may override this function to provide
+ *                           specific SMBIOS address
+ */
+__weak ulong board_fdt_chosen_smbios(void)
+{
+	ulong ret = 0;
+	const struct smbios3_entry *entry;
+
+	ret = gd->arch.smbios_start;
+	if (!ret)
+		return 0;
+
+	/* Verify this is SMBIOS 3 */
+	entry = map_sysmem(ret, sizeof(struct smbios3_entry));
+
+	/* Check for "_SM3_" signature */
+	if (memcmp(entry->anchor, "_SM3_", 5) != 0) {
+		printf("SMBIOS: Not version 3, skipping DTB injection\n");
+		ret = 0;
+		goto out;
+	}
+
+	/* Verify entry point length and version */
+	if (entry->length < sizeof(struct smbios3_entry)) {
+		printf("SMBIOS: Invalid entry length %d\n", entry->length);
+		ret = 0;
+		goto out;
+	}
+
+	printf("SMBIOS: Found version %d.%d at 0x%llx\n",
+	       entry->major_ver, entry->minor_ver, (u64)ret);
+
+out:
+	unmap_sysmem(entry);
+	return ret;
+}
\ No newline at end of file
diff --git a/test/dm/fdtdec.c b/test/dm/fdtdec.c
index 1f24f1d5dff..6d695a84f5a 100644
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
@@ -129,3 +132,52 @@ static int dm_test_fdtdec_add_reserved_memory(struct unit_test_state *uts)
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
+	blob_sz = fdt_totalsize(gd->fdt_blob) + 128;
+	blob = malloc(blob_sz);
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
+	/* Verify the property exists only when GENERATE_SMBIOS_TABLE */
+	prop = fdt_getprop(blob, chosen, "smbios3-entrypoint", NULL);
+	if (!CONFIG_IS_ENABLED(GENERATE_SMBIOS_TABLE)) {
+		ut_assertnull(prop);
+		goto out;
+	}
+	ut_assertnonnull(prop);
+
+	/* Verify the property matches smbios_start */
+	val = fdt64_to_cpu(*prop);
+	ut_asserteq_64(gd->arch.smbios_start, val);
+
+	/* Remove property */
+	fdt_delprop(blob, chosen, "smbios3-entrypoint");
+
+out:
+	free(blob);
+
+	return 0;
+}
+DM_TEST(dm_test_fdt_chosen_smbios, UTF_SCAN_PDATA | UTF_SCAN_FDT);
\ No newline at end of file
-- 
2.51.0

