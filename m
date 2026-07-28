Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB721C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88DE2608DD;
	Tue, 28 Jul 2026 13:21:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pli1M6AamTbG; Tue, 28 Jul 2026 13:21:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C793608E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785244875;
	bh=IUYgXe5VvDCPMfyodmBE4XWsYW20kPipgbr72ibeBcg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XNGULlVaNNKaKufFhveXjHIVmZ9wT+uKcA8EANs6GxkDmGSpHbd+WJmKi3ZNKu25I
	 NcpxtZN5EAbkp9QkC7HSdrHmKXTOw3bJomluvzb+bxHR/rt855PouzXCU6kptjqBSJ
	 4VSxC6EgapvXG3tMAqKtdzCIU5q168vpx2AsuJDtWYJiZdA2f5AzOfbdvoBOUOFg7z
	 nIZwoyBomaMR0X7pc730qdw7qZTEatbo6hhyYnO6NwPPocwzwt+XQSnY2H+dfKvlqt
	 j5FpuGfgllsV18+F7Rpo7aBSHiyEga89RGGkOJEifsjQMru+V07HUXXIc9fPQ9IBU4
	 vPTect1pl0DVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C793608E3;
	Tue, 28 Jul 2026 13:21:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC7FF4BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:21:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AEFC04006F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:21:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id umxaDrhzw_w8 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 13:21:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0D5674005A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D5674005A
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D5674005A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:21:04 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so36836625e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785244863; x=1785849663;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IUYgXe5VvDCPMfyodmBE4XWsYW20kPipgbr72ibeBcg=;
 b=ZLF3PHLPBGhVhMVnMXzSYAkQlyn/p3RzNDeSevVZTFtrN9LDda1gwDOZw+yajGXYMj
 6t5hCV70mSCxQ0SwdQ1sKKMCrjuOUfHZieli6bwieQDG8t/ZMuPbR3NneE7zw3Mt61Ye
 jzcRlhn/ap/jvfoq42qkgIRYewzzflGNjpMgjW7znOK4IJB7eAVA32x6Zf65dKXWgAIL
 uxDgafhERpZ0LV/El3WHZqORWPXjzITJQXaa67zFNHLfXiraAUAbALNkA2XSEymIPS9q
 /0qR0i+F/4Jl4mLfa0H8R5veULNn0ttYYihHP29UcnvHCBLDbj/sDYsn/smc01VaCDJV
 rzTg==
X-Gm-Message-State: AOJu0YylC5WIYXx0VqnfRM+gjShtCEGOcwxArKZa7BB0RTIphPSCkC6f
 VWPL3TcP6N00Q2xCNciB7X+2t//iSnbAUbwXSu0/RUa/Vz9i3LWsgIybX/Pvb4bsWlU=
X-Gm-Gg: AR+sD13t1VaQIact1NWjCaWbqwO50Fb+soSHc5JNYcEfM0hfcqA57tXdH3Mkl04Zv7q
 VUP0zLwWDkyjZVpUYf9ZY17L3vib5jD3JcuMu1Vk3+Tp2h1dXSfsy0XTDjbAAyLWDtNXNe51s8Z
 TMQUhFri1uBKhvwFydawHMzWzHF/2dbUNTxbgcbMfRn2AF67MnWQnwMfAOEt8/vwzJX6BOUOL1U
 xMHThOkvwxkm6PQ/sJ8E/Twg9pfLmoGweJizTWroFsWksIpG5nQuSsbTybDf0LvLQqbzLnnMYWU
 tLtyrGjeAfb1oPsJU8EIufY8LIR9N8CZBnUpua26BBGLIyKHgfwpqyitw+X2uG41JCvQ/KqApPQ
 u67ndZdNP4pOFuf2DDS7tWLSxWOsWCobdVYkuELUfqdWuOiyK68eIsUzH3lB0tU6NTzFzVFxdqw
 X6rruh1oF5LXfe7OsCP5pIqp7jD0tkikVdDNUgyUlM0G8NffuyfQMRsQb7o9A=
X-Received: by 2002:a05:600c:a44:b0:495:4811:d71c with SMTP id
 5b1f17b1804b1-496c6439472mr26748285e9.13.1785244862703; 
 Tue, 28 Jul 2026 06:21:02 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bd9e980sm306898645e9.0.2026.07.28.06.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 06:21:02 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Tue, 28 Jul 2026 15:20:47 +0200
Subject: [PATCH v2 5/5] test: boot: add firmware-FDT source tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-ccaione-upstream-ebbr-v2-5-4efb529140d6@baylibre.com>
References: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
In-Reply-To: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Randolph Sapp <rs@ti.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785244863; x=1785849663;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IUYgXe5VvDCPMfyodmBE4XWsYW20kPipgbr72ibeBcg=;
 b=VcLMBG2wO4gsNBAKI8LU8h9g/46aayx7xRzLQEv/mhKVupW7AJjwm1rYCw0vKPUZTe
 yy1mMssIbfsaN5042kPUB0MxRPNwgrdY95TJflFu24iIJWvhfiDLouXD7gE2YVAGza4/
 GxIDameREnWsQBihzkyrjPuvPSXSqGueMlwBQTtfgqtKOhE/xtAWedjtC+0L6VP+MA+W
 vCJokc07tx04Bn2wcAAlZiojbDJtoarbsb9DPJ1nLIR8RW4c9CvvZjpJ5UwaYvE1lv1A
 799MO7PzARdPY1GzBbOFi3UE/vGKKDMVP5W8p7wyVq2Gb8n/AVI1TuFfM9DHbv2oTUOs
 9LWw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VcLMBG2w
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add sandbox coverage for firmware_fdt_load(). The Python fixture creates
mmc11.img in persistent_data_dir with A/B firmware partitions. Its first
FAT partition carries FITs for a base-plus-overlay configuration,
compatible best-match, external-data rejection and corrupt-hash rejection.

Construct the complete MMC provider and firmware-FDT source topology in
each flat-tree test, including the provider phandle. Nothing is added to
the shared sandbox control devicetree, and the sandbox test framework
restores its FDT snapshot even when an assertion fails.

Cover default and explicit configuration selection, compatible best-match,
owned and borrowed assembled-FDT storage, EFI staging and its returned
filename, and the fail-closed cases: corrupt base or overlay data,
configuration chaining, a missing configuration or partition, an invalid
source phandle, external data and mismatched partition selectors. Verify
that only a genuinely absent source returns -ENOENT.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/sandbox_defconfig |   1 +
 test/boot/Makefile        |   1 +
 test/boot/firmware_fdt.c  | 411 ++++++++++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py  | 181 ++++++++++++++++++++
 4 files changed, 594 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 79f46317e45..b2affd96831 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -27,6 +27,7 @@ CONFIG_FIT_VERITY=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_BOOTMETH_ANDROID=y
 CONFIG_BOOTMETH_RAUC=y
+CONFIG_FIRMWARE_FDT=y
 CONFIG_UPL=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_MEASURED_BOOT=y
diff --git a/test/boot/Makefile b/test/boot/Makefile
index 59a87028704..681c8c4c94f 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -4,6 +4,7 @@
 
 ifdef CONFIG_UT_BOOTSTD
 obj-$(CONFIG_BOOTSTD) += bootdev.o bootstd_common.o bootflow.o bootmeth.o
+obj-$(CONFIG_FIRMWARE_FDT) += firmware_fdt.o
 obj-$(CONFIG_FIT) += image.o
 
 ifdef CONFIG_VIDEO_SANDBOX_SDL
diff --git a/test/boot/firmware_fdt.c b/test/boot/firmware_fdt.c
new file mode 100644
index 00000000000..098aeea4873
--- /dev/null
+++ b/test/boot/firmware_fdt.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for the firmware-owned devicetree source (firmware_fdt_load()).
+ *
+ * Uses a sandbox mmc image (mmc11) carrying a GPT 'firmware' partition with
+ * a FAT filesystem holding the FIT (fdt.itb: a base DTB and one
+ * overlay, with two configurations). The image is built by
+ * setup_firmware_fdt_image() in test/py/tests/test_ut.py.
+ *
+ * The tests create the complete source topology at runtime, including the
+ * mmc11 provider and its phandle. The shared test.dts stays unconfigured,
+ * while the sandbox DM test framework restores its FDT snapshot after every
+ * test, including a failed one.
+ */
+
+#include <dm.h>
+#include <env.h>
+#include <firmware_fdt.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <os.h>
+#include <asm/global_data.h>
+#include <dm/lists.h>
+#include <dm/ofnode.h>
+#include <dm/root.h>
+#include <linux/libfdt.h>
+#include <test/test.h>
+#include <test/ut.h>
+#include "bootstd_common.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define FWFDT_NODE_PATH		"/fw-fdt"
+#define FWFDT_STORE_PROP	"firmware-fdt-store"
+#define FWFDT_STORE_PHANDLE	0x10000
+#define FWFDT_TYPE_UUID		"384e979b-eb76-435a-a3a6-1a071dbad91d"
+#define FWFDT_TEST_FLAGS	(UTF_DM | UTF_SCAN_FDT | UTF_FLAT_TREE)
+
+static ofnode fwfdt_source_node(void)
+{
+	return ofnode_path(FWFDT_NODE_PATH);
+}
+
+/* Bind the runtime-created mmc node that owns the firmware-FDT image */
+static int fwfdt_bind_mmc(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	ofnode node;
+
+	node = ofnode_path("/mmc11");
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
+
+	return 0;
+}
+
+/*
+ * Create the full firmware-FDT topology. Set @with_source to false for the
+ * no-source test, which still needs the media device.
+ */
+static int fwfdt_configure(struct unit_test_state *uts, bool with_source)
+{
+	char fname[256];
+	ofnode root, mmc, src;
+
+	ut_assertok(os_persistent_file(fname, sizeof(fname), "mmc11.img"));
+	root = oftree_root(oftree_default());
+	ut_assertok(ofnode_add_subnode(root, "mmc11", &mmc));
+	ut_assertok(ofnode_write_string(mmc, "compatible", "sandbox,mmc"));
+	ut_assertok(ofnode_write_string(mmc, "filename", fname));
+	ut_assertok(ofnode_write_u32(mmc, "phandle", FWFDT_STORE_PHANDLE));
+
+	if (!with_source)
+		return 0;
+
+	ut_assertok(ofnode_add_subnode(root, "fw-fdt", &src));
+	ut_assertok(ofnode_write_string(src, "compatible",
+					"u-boot,firmware-fdt-block"));
+	ut_assertok(ofnode_write_u32(src, FWFDT_STORE_PROP,
+				     FWFDT_STORE_PHANDLE));
+	ut_assertok(ofnode_write_string(src, "partition-type-uuid",
+					FWFDT_TYPE_UUID));
+	ut_assertok(ofnode_write_string(src, "partition-name", "firmware"));
+	ut_assertok(ofnode_write_string(src, "filename", "fdt.itb"));
+
+	return 0;
+}
+
+/* Clear the environment values used by the tests */
+static int fwfdt_clear_env(struct unit_test_state *uts)
+{
+	env_set("fw_fdt_part", NULL);
+	env_set("fw_fdt_config", NULL);
+
+	return 0;
+}
+
+/* Happy path: the FIT's default configuration applies base + overlay */
+static int firmware_fdt_test_load(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	void *fdt;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_assertok(firmware_fdt_load(&fw));
+
+	ut_asserteq_str("fdt.itb", fw.name);
+	ut_assert(fw.size > 0);
+	ut_assert(fw.fdt_owned);
+
+	fdt = fw.fdt;
+	ut_assertok(fdt_check_header(fdt));
+	/* the size reports the packed devicetree, not a padded buffer */
+	ut_asserteq(fw.size, fdt_totalsize(fdt));
+	/* the base property is present... */
+	ut_assertnonnull(fdt_getprop(fdt, 0, "fw-base-prop", NULL));
+	/* ...and the overlay was applied on top */
+	ut_assertnonnull(fdt_getprop(fdt, 0, "fw-overlay-prop", NULL));
+
+	firmware_fdt_free(&fw);
+	ut_assertnull(fw.fdt);
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_load, FWFDT_TEST_FLAGS);
+
+/* 'fw_fdt_config' selects another configuration the FIT ships */
+static int firmware_fdt_test_select(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	void *fdt;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_assertok(env_set("fw_fdt_config", "conf-base"));
+	ut_assertok(firmware_fdt_load(&fw));
+
+	fdt = fw.fdt;
+	ut_assert(!fw.fdt_owned);
+	ut_assertnonnull(fdt_getprop(fdt, 0, "fw-base-prop", NULL));
+	/* the base-only configuration applies no overlay */
+	ut_assertnull(fdt_getprop(fdt, 0, "fw-overlay-prop", NULL));
+
+	firmware_fdt_free(&fw);
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_select, FWFDT_TEST_FLAGS);
+
+/*
+ * Configuration chaining could assemble a combination which was never signed
+ * as one unit. Only one FIT configuration may be selected.
+ */
+static int firmware_fdt_test_config_chain(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_assertok(env_set("fw_fdt_config", "conf-base#conf-overlay"));
+	ut_asserteq(-EINVAL, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_config_chain, FWFDT_TEST_FLAGS);
+
+/* The shared EFI helper stages the result and owns its returned filename */
+static int firmware_fdt_test_stage(struct unit_test_state *uts)
+{
+	char *name;
+	ulong size;
+	void *buf;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	buf = malloc(FIRMWARE_FDT_MAX_SIZE);
+	ut_assertnonnull(buf);
+	ut_assertok(efi_stage_firmware_fdt(map_to_sysmem(buf), &size, &name));
+	ut_asserteq_str("fdt.itb", name);
+	ut_asserteq(size, fdt_totalsize(buf));
+	ut_assertnonnull(fdt_getprop(buf, 0, "fw-base-prop", NULL));
+	ut_assertnonnull(fdt_getprop(buf, 0, "fw-overlay-prop", NULL));
+	free(name);
+	free(buf);
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_stage, FWFDT_TEST_FLAGS);
+
+/* Compatible best-match against the control DT selects conf-sandbox */
+static int firmware_fdt_test_best_match(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	const char *value;
+	ofnode node;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	node = fwfdt_source_node();
+	ut_assert(ofnode_valid(node));
+	ut_assertok(ofnode_write_string(node, "filename", "fdt-best.itb"));
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_assertok(firmware_fdt_load(&fw));
+	value = fdt_getprop(fw.fdt, 0, "fw-best-prop", NULL);
+	ut_assertnonnull(value);
+	ut_asserteq_str("sandbox", value);
+	firmware_fdt_free(&fw);
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_best_match, FWFDT_TEST_FLAGS);
+
+/* A corrupted base fails hash verification and cannot fall back */
+static int firmware_fdt_test_corrupt(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	ofnode node;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	node = fwfdt_source_node();
+	ut_assert(ofnode_valid(node));
+	ut_assertok(ofnode_write_string(node, "filename", "fdt-corrupt.itb"));
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_asserteq(-EACCES, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_corrupt, FWFDT_TEST_FLAGS);
+
+/* A corrupted overlay is fatal too; it must never be silently skipped */
+static int firmware_fdt_test_corrupt_overlay(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	ofnode node;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	node = fwfdt_source_node();
+	ut_assert(ofnode_valid(node));
+	ut_assertok(ofnode_write_string(node, "filename",
+					"fdt-corrupt-overlay.itb"));
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_asserteq(-EACCES, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_corrupt_overlay, FWFDT_TEST_FLAGS);
+
+/*
+ * A selector naming a configuration the FIT does not ship must be
+ * fatal: -ENOENT strictly means "no source configured", so the inner miss
+ * must not leak out and let the caller fall back (fail closed).
+ */
+static int firmware_fdt_test_bad_config(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_assertok(env_set("fw_fdt_config", "conf-nonexistent"));
+	ut_asserteq(-ENODEV, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_bad_config, FWFDT_TEST_FLAGS);
+
+/* Pinning a partition that does not exist is a hard error (fail closed) */
+static int firmware_fdt_test_no_part(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_assertok(env_set("fw_fdt_part", "9"));
+	ut_asserteq(-ENODEV, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_no_part, FWFDT_TEST_FLAGS);
+
+/*
+ * Without a source node, -ENOENT is the only result which lets callers fall
+ * back. This also proves the provider alone does not configure the feature.
+ */
+static int firmware_fdt_test_no_source(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+
+	ut_assertok(fwfdt_configure(uts, false));
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_asserteq(-ENOENT, firmware_fdt_load(&fw));
+	/* Source detection precedes address validation in the EFI helper */
+	ut_asserteq(-ENOENT, efi_stage_firmware_fdt(0, NULL, NULL));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_no_source, FWFDT_TEST_FLAGS);
+
+/*
+ * A 'firmware-fdt-store' phandle that does not resolve is a broken
+ * configuration and must be fatal, not mistaken for "no source".
+ */
+static int firmware_fdt_test_bad_source(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	fdt32_t bad;
+	ofnode node;
+
+	ut_assertok(fwfdt_configure(uts, true));
+	node = fwfdt_source_node();
+	ut_assert(ofnode_valid(node));
+
+	bad = cpu_to_fdt32(0x7fffffff);
+	ut_assertok(ofnode_write_prop(node, FWFDT_STORE_PROP, &bad,
+				      sizeof(bad), true));
+	ut_asserteq(-EINVAL, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_bad_source, FWFDT_TEST_FLAGS);
+
+/* A FIT using external data is refused: it must be self-contained */
+static int firmware_fdt_test_external(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	ofnode node;
+
+	ut_assertok(fwfdt_configure(uts, true));
+
+	node = fwfdt_source_node();
+	ut_assert(ofnode_valid(node));
+	ut_assertok(ofnode_write_string(node, "filename", "fdt-ext.itb"));
+
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_asserteq(-EINVAL, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_external, FWFDT_TEST_FLAGS);
+
+/*
+ * When both partition-type-uuid and partition-name are configured, both
+ * must match: a name matching nothing must not fall back to whichever
+ * same-type (A/B) partition comes first.
+ */
+static int firmware_fdt_test_part_mismatch(struct unit_test_state *uts)
+{
+	struct firmware_fdt fw;
+	ofnode node;
+
+	ut_assertok(fwfdt_configure(uts, true));
+
+	node = fwfdt_source_node();
+	ut_assert(ofnode_valid(node));
+	/* the type UUID matches both A/B partitions; this name matches none */
+	ut_assertok(ofnode_write_string(node, "partition-name", "nomatch"));
+
+	ut_assertok(fwfdt_bind_mmc(uts));
+
+	ut_asserteq(-ENODEV, firmware_fdt_load(&fw));
+
+	ut_assertok(fwfdt_clear_env(uts));
+
+	return 0;
+}
+
+BOOTSTD_TEST(firmware_fdt_test_part_mismatch, FWFDT_TEST_FLAGS);
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index fa50c8008a5..7678795dd0f 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -614,6 +614,186 @@ def setup_rauc_image(ubman):
     boot.cleanup()
     root.cleanup()
 
+def setup_firmware_fdt_image(ubman):
+    """Create mmc11.img for the firmware_fdt tests
+
+    A GPT disk with two firmware partitions (A/B) sharing a firmware type
+    UUID; partition 1 (label 'firmware') holds a FAT filesystem with the
+    FIT (fdt.itb) carrying a base DTB and an overlay, with two
+    configurations: the default applies the overlay, 'conf-base' does not.
+    """
+    Partition = collections.namedtuple('part', 'start,size,name')
+    parts = {}
+
+    mmc_dev = 11
+    fname = os.path.join(ubman.config.persistent_data_dir,
+                         f'mmc{mmc_dev}.img')
+    fw_type = '384e979b-eb76-435a-a3a6-1a071dbad91d'
+    sect_size = 512
+
+    # Compile a tiny base DTB and an overlay, then wrap them in the FIT
+    src = os.path.join(ubman.config.persistent_data_dir, 'fwfdt')
+    mkdir_cond(src)
+    base_dtb = os.path.join(src, 'base.dtb')
+    match_dtb = os.path.join(src, 'match.dtb')
+    ovl_dtbo = os.path.join(src, 'overlay.dtbo')
+    utils.run_and_log(
+        ubman, f'dtc -O dtb -o {base_dtb}',
+        stdin=b'/dts-v1/; / { compatible = "test,fw-fdt-base"; '
+              b'fw-base-prop = "base"; };')
+    utils.run_and_log(
+        ubman, f'dtc -O dtb -o {ovl_dtbo}',
+        stdin=b'/dts-v1/; /plugin/; &{/} { fw-overlay-prop = "applied"; };')
+    utils.run_and_log(
+        ubman, f'dtc -O dtb -o {match_dtb}',
+        stdin=b'/dts-v1/; / { compatible = "sandbox"; '
+              b'fw-best-prop = "sandbox"; };')
+
+    its = os.path.join(src, 'fdt.its')
+    with open(its, 'w', encoding='ascii') as outf:
+        outf.write(f'''
+/dts-v1/;
+/ {{
+\tdescription = "Firmware-owned OS devicetree";
+\t#address-cells = <1>;
+
+\timages {{
+\t\tfdt-base {{
+\t\t\tdata = /incbin/("{base_dtb}");
+\t\t\ttype = "flat_dt";
+\t\t\tarch = "sandbox";
+\t\t\tcompression = "none";
+\t\t\thash-1 {{ algo = "sha256"; }};
+\t\t}};
+\t\tfdt-overlay {{
+\t\t\tdata = /incbin/("{ovl_dtbo}");
+\t\t\ttype = "flat_dt";
+\t\t\tarch = "sandbox";
+\t\t\tcompression = "none";
+\t\t\thash-1 {{ algo = "sha256"; }};
+\t\t}};
+\t}};
+
+\tconfigurations {{
+\t\tdefault = "conf-overlay";
+\t\tconf-overlay {{
+\t\t\tfdt = "fdt-base", "fdt-overlay";
+\t\t}};
+\t\tconf-base {{
+\t\t\tfdt = "fdt-base";
+\t\t}};
+\t}};
+}};
+''')
+
+    fs_dir = os.path.join(src, 'fs')
+    mkdir_cond(fs_dir)
+    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
+    fit = os.path.join(fs_dir, 'fdt.itb')
+    utils.run_and_log(ubman, f'{mkimage} -f {its} {fit}')
+
+    # An external-data variant, which firmware_fdt_load() must refuse
+    utils.run_and_log(
+        ubman, f'{mkimage} -E -f {its} {os.path.join(fs_dir, "fdt-ext.itb")}')
+
+    # A FIT with two distinct compatibles for CONFIG_FIT_BEST_MATCH coverage
+    best_its = os.path.join(src, 'fdt-best.its')
+    with open(best_its, 'w', encoding='ascii') as outf:
+        outf.write(f'''
+/dts-v1/;
+/ {{
+\tdescription = "Firmware-owned compatible selection test";
+\t#address-cells = <1>;
+
+\timages {{
+\t\tfdt-generic {{
+\t\t\tdata = /incbin/("{base_dtb}");
+\t\t\ttype = "flat_dt";
+\t\t\tarch = "sandbox";
+\t\t\tcompression = "none";
+\t\t\thash-1 {{ algo = "sha256"; }};
+\t\t}};
+\t\tfdt-sandbox {{
+\t\t\tdata = /incbin/("{match_dtb}");
+\t\t\ttype = "flat_dt";
+\t\t\tarch = "sandbox";
+\t\t\tcompression = "none";
+\t\t\thash-1 {{ algo = "sha256"; }};
+\t\t}};
+\t}};
+
+\tconfigurations {{
+\t\tdefault = "conf-generic";
+\t\tconf-generic {{
+\t\t\tfdt = "fdt-generic";
+\t\t}};
+\t\tconf-sandbox {{
+\t\t\tfdt = "fdt-sandbox";
+\t\t}};
+\t}};
+}};
+''')
+    utils.run_and_log(
+        ubman,
+        f'{mkimage} -f {best_its} {os.path.join(fs_dir, "fdt-best.itb")}')
+
+    # Corrupt base data without updating its hash: loading must fail closed
+    with open(fit, 'rb') as inf:
+        corrupt_data = bytearray(inf.read())
+    with open(base_dtb, 'rb') as inf:
+        base_data = inf.read()
+    data_offset = corrupt_data.find(base_data)
+    if data_offset < 0:
+        raise ValueError('Cannot locate base DTB in firmware-FDT FIT')
+    corrupt_data[data_offset + len(base_data) - 1] ^= 1
+    with open(os.path.join(fs_dir, 'fdt-corrupt.itb'), 'wb') as outf:
+        outf.write(corrupt_data)
+
+    # A corrupt overlay must be fatal too, never silently skipped
+    with open(fit, 'rb') as inf:
+        corrupt_data = bytearray(inf.read())
+    with open(ovl_dtbo, 'rb') as inf:
+        overlay_data = inf.read()
+    data_offset = corrupt_data.find(overlay_data)
+    if data_offset < 0:
+        raise ValueError('Cannot locate overlay DTBO in firmware-FDT FIT')
+    corrupt_data[data_offset + len(overlay_data) - 1] ^= 1
+    with open(os.path.join(fs_dir, 'fdt-corrupt-overlay.itb'), 'wb') as outf:
+        outf.write(corrupt_data)
+
+    fat_img = fs_helper.mk_fs(ubman.config, 'vfat', 1 << 20, 'fwfdt',
+                              src_dir=fs_dir)
+    with open(fat_img, 'rb') as inf:
+        fat_data = inf.read()
+
+    # GPT with two same-type firmware partitions; the FAT goes in partition 1
+    fat_sects = (len(fat_data) + sect_size - 1) // sect_size
+    utils.run_and_log(ubman, f'qemu-img create {fname} 8M')
+    utils.run_and_log(ubman, f'cgpt create {fname}')
+    ptr = 40
+    for num, label in ((1, 'firmware'), (2, 'firmware_b')):
+        utils.run_and_log(
+            ubman,
+            f'cgpt add -i {num} -b {ptr} -s {fat_sects} -t {fw_type} '
+            f'-l {label} {fname}')
+        ptr += fat_sects
+    utils.run_and_log(ubman, f'cgpt boot -p {fname}')
+    out = utils.run_and_log(ubman, f'cgpt show -q {fname}')
+    for line in out.splitlines():
+        start, size, num, name = line.split(maxsplit=3)
+        parts[int(num)] = Partition(int(start), int(size), name)
+
+    # Splice the FAT image into partition 1
+    with open(fname, 'rb') as inf:
+        disk_data = inf.read()
+    start = parts[1].start * sect_size
+    disk_data = disk_data[:start] + fat_data + disk_data[start + len(fat_data):]
+    with open(fname, 'wb') as outf:
+        outf.write(disk_data)
+
+    return fname
+
+
 @pytest.mark.buildconfigspec('cmd_bootflow')
 @pytest.mark.buildconfigspec('sandbox')
 def test_ut_dm_init_bootstd(ubman):
@@ -626,6 +806,7 @@ def test_ut_dm_init_bootstd(ubman):
     setup_android_image(ubman)
     setup_efi_image(ubman)
     setup_rauc_image(ubman)
+    setup_firmware_fdt_image(ubman)
 
     # Restart so that the new mmc1.img is picked up
     ubman.restart_uboot()

-- 
2.55.0

