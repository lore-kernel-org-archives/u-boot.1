Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D133CCF58C6
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 18:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0887183EA6;
	Wed, 19 Nov 2025 19:46:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=arista.com header.i=@arista.com header.b="KzRSBUYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E487583EDE; Wed, 19 Nov 2025 19:46:47 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FACF8397D
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 19:46:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adriana@arista.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7bac5b906bcso3810b3a.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 10:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arista.com; s=google; t=1763578003; x=1764182803; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kUm0Tr7xj9m6PRoOddZ4zBQP27jIEwcqWvyqCGyZhc4=;
 b=KzRSBUYaYpzZAuAfEujxrCuK6WBkYKnlNiJEgjh32kL/z4rB1YkHq0wI1stGZjXl3t
 GgrpQ27BeZdQ2nj9NLWNJYe5IPGbtDPeHgK9samJwYmPdBxG7TBDz0DAKqhuy69NOGuQ
 bul6SpdZd633M8V4IL1KK7k8kNsVUud+7H52xnrptbMIMwP1YTm4SOrZzM8sfjKX4c6I
 FjH8pVw/xEd8VNCTH/U/U24kLaPyxIeNGI4M+6mQZffgR5Vmxxad0+w6i4b+UqUV5jHl
 qznvJCYk27wgG+mZRZk3s2OwZeVLeJJnykVZ/tjC2PpA/c6CZGwSnb/mQTT2YnWp6qNd
 5vLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763578003; x=1764182803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kUm0Tr7xj9m6PRoOddZ4zBQP27jIEwcqWvyqCGyZhc4=;
 b=oPbBO13n2cj47aIqrG2BqEvSaO5uvb9Z/51XPWpYmdqS3qsc6ZTVrU93UkkLSqNl/I
 j5xW1yj9VtolWyozF9E+Ujo6qsdxgufj4XW/EepxCepfVuq1HicLtqu2naFzqZsxtCbV
 PBHHtQEK3FCpu5EWugQeukInkjySjKWtBNDP9nBUimJQZkGbsaG2ZL3geFoj9mMWyqqF
 gHdhEqUBNlvyIp/BW4MKrc/pCTxlLhB90+XdOGozKA3bZiPWuj/eIDuKKvOx1JBaitaR
 qcrI5dVHx4EyOyWMVb87WYgQ2Th64/kr7RdPG6wp9JlTM/GS+xpsBfgxUidmWoRfDxy7
 USxw==
X-Gm-Message-State: AOJu0YzlOcL9jmyIfFEsZLXo3p1LMLb0UAPWLUecq1VYo40kY9hjD3ZM
 X2IAEX4bk1DXtTh/1o1x1yva8DDvQfylKSE3tPBkWsXvjyWS5KUrQmzV3X5KNGhMqedwvCakb4g
 THeAj5g==
X-Gm-Gg: ASbGncuaif482m2PBMKIsGMjPhch06QSOQHvaQEh5brLtsVvQ8i6ZbvhZsYf/5PYQVI
 yx7wTDjiRCxdIAlvbznhM0Sb1ua+bYzXmTWP3zUJUUtzLT/I1HS+T9rJSIavwggVKManKrb2Jrv
 aBcCktQqJ4JmdbD0Q7DKENdAkptUaxt7c4O2sCaaMP7H0fRfZ1NDzXP8mbCEEFRliHRnBfQzR7u
 YLK+4l+4HJ8pmTYDwBjIL/B8h4FF/mLNVSImYyemI6mBZ8FNtTHVKoRyV+kiv0908lNOpdY9nDj
 FDlD3eEyNRmfpZr8CIYvFJ5Xmfkjg4T1DWoQEhwzqEdGfil4L+E3Qlz+Tlfuwk4T7/pP+An+3uS
 O09dCeYPsc6PmZtNPmukNvZpJAWkvx0ZqR/dV1sI133YFUX49W/26c3kWswCxbxnwUFhLI8Sb0/
 oo/Qk2SwpjCeoinq1cy8UFnpqW7LbVK0Zc4Ri5Zm6psPwxePYqS54kksxzldRI0YfZ8elz
X-Google-Smtp-Source: AGHT+IHldd3VF8aaQdvP8hD8GP4YRr6Eaw0Mtfx2x3uLmqQOpGQudDwGwuKOZiYli7KT71Wt+WPvIQ==
X-Received: by 2002:a05:7022:3704:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-11c9385bef1mr104968c88.1.1763578003319; 
 Wed, 19 Nov 2025 10:46:43 -0800 (PST)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93cd457dsm453128c88.0.2025.11.19.10.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 10:46:42 -0800 (PST)
From: Adriana Nicolae <adriana@arista.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, ddrokosov@salutedevices.com,
 ilias.apalodimas@linaro.org, quentin.schulz@cherry.de, xypron.glpk@gmx.de,
 kojima.masahisa@socionext.com, richard@nod.at, semen.protsenko@linaro.org,
 joao.goncalves@toradex.com, adriana@arista.com
Subject: [PATCH v4] boot/bootfdt: Add smbios3-entrypoint to FDT for non-EFI
 boots
Date: Wed, 19 Nov 2025 10:46:40 -0800
Message-ID: <20251119184640.543904-1-adriana@arista.com>
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
index 1f24f1d5dff..1744211d4d1 100644
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

