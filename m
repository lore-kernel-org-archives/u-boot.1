Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9E0C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B6D88880B;
	Sat, 13 Jul 2024 09:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UqmGmhl1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E4A88789; Sat, 13 Jul 2024 09:03:55 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D42FB88800
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42795086628so17904455e9.3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854232; x=1721459032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ShWlEnDcr0x58JI/bAXLpxRo8osfxZlVKydMGlYFPjc=;
 b=UqmGmhl1DDmj4ZOPRAWPJ1BnNqBeCPlOFlNWzvarAvtbUmCMiCDyPhmeBonYyL+b9X
 AHFB5GI5CezaMs7Y12ZGicy6tn3uDePBGmPddlr7TGhLEG4sX7eMCX11662h19dfW4H0
 k2NG+ZGxtc5gGBsIMq4oysSFT7DhaEzstHj60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854232; x=1721459032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ShWlEnDcr0x58JI/bAXLpxRo8osfxZlVKydMGlYFPjc=;
 b=UwxDH2LIM0++4B2f1fSWd3GCPnHLHYfzSivekrY/Q6qOGzEZHWC9ipiQCPfVZpF1dR
 JEYY1EBx7efqL74FV2tF05kaCYK8SA0fmJNOkWa9orALxBbZYmoOl0I4lmrgVYPFEk1h
 JR0QLKKs+y+i2mmxvOD+WDsgupDIulDyEAdyDuB1RHHQK4w2vncHZqZXFrnKOZbA8cd8
 RzAbeLsmY/QzTKXupdre5Fe4U1aH4FN0QpnxTFU1gthHK6Xw2OAh0acj0AVzXFgr1Xfs
 I1jKNNnKAENcaLx/ZxS9WgSRPfq3mEgslrjZujMaKDfU7UC5fJTVXr3pghamom4uRQzf
 Za4A==
X-Gm-Message-State: AOJu0Yy/+01NrXWNSq18QJ3XLFim6kVOxlXP2SgDzawvKHLX9+wdtCdO
 swb3hilszFAMiVQNumfZE9K5p7E4cw3Q77LeR2vEf9SAY/F6zZB5WPSQoM9JJfDwK1xS7/IwjGY
 =
X-Google-Smtp-Source: AGHT+IGJ8HHhC2itNFvdeOpazz73HCyqpkHqqgm9XCQXHdzQMjq/aawXrY7RJHsYRg7ysvpbzNGQnw==
X-Received: by 2002:a05:600c:4f4e:b0:426:6edb:7e14 with SMTP id
 5b1f17b1804b1-426708f9d4cmr87438445e9.35.1720854232090; 
 Sat, 13 Jul 2024 00:03:52 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/21] upl: Add basic tests
Date: Sat, 13 Jul 2024 08:00:46 +0100
Message-Id: <20240713070055.2172883-13-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

Add some unit tests to check that we can write a UPL handoff and read it
back.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Put the upl tests under their own subcommand to avoid bootstd init

 MAINTAINERS           |   1 +
 include/test/suites.h |   1 +
 include/upl.h         |   9 ++
 test/boot/Makefile    |   2 +
 test/boot/upl.c       | 368 ++++++++++++++++++++++++++++++++++++++++++
 test/cmd_ut.c         |   3 +
 6 files changed, 384 insertions(+)
 create mode 100644 test/boot/upl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 23852fbde38..7150c3281ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1700,6 +1700,7 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-dm.git
 F:	boot/upl*
 F:	include/upl.h
+F:	test/boot/upl.c
 
 USB
 M:	Marek Vasut <marex@denx.de>
diff --git a/include/test/suites.h b/include/test/suites.h
index 365d5f20dfe..2ceef577f7f 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -63,5 +63,6 @@ int do_ut_str(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_time(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_unicode(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
+int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 
 #endif /* __TEST_SUITES_H__ */
diff --git a/include/upl.h b/include/upl.h
index 793d1e86dbb..26c5d4bc8cb 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -307,6 +307,15 @@ int upl_create_handoff_tree(const struct upl *upl, oftree *treep);
  */
 int upl_read_handoff(struct upl *upl, oftree tree);
 
+/**
+ * upl_get_test_data() - Fill a UPL with some test data
+ *
+ * @uts: Test state (can be uninited)
+ * @upl: Returns test data
+ * Return: 0 on success, 1 on error
+ */
+int upl_get_test_data(struct unit_test_state *uts, struct upl *upl);
+
 #if CONFIG_IS_ENABLED(UPL)
 
 /**
diff --git a/test/boot/Makefile b/test/boot/Makefile
index 068522cb9e0..8ec5daa7bfe 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -13,3 +13,5 @@ ifdef CONFIG_OF_LIVE
 obj-$(CONFIG_BOOTMETH_VBE_SIMPLE) += vbe_simple.o
 endif
 obj-$(CONFIG_BOOTMETH_VBE) += vbe_fixup.o
+
+obj-$(CONFIG_UPL) += upl.o
diff --git a/test/boot/upl.c b/test/boot/upl.c
new file mode 100644
index 00000000000..e9d92efd80d
--- /dev/null
+++ b/test/boot/upl.c
@@ -0,0 +1,368 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * UPL handoff testing
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#include <abuf.h>
+#include <mapmem.h>
+#include <upl.h>
+#include <dm/ofnode.h>
+#include <test/suites.h>
+#include <test/test.h>
+#include <test/ut.h>
+#include "bootstd_common.h"
+
+/* Declare a new upl test */
+#define UPL_TEST(_name, _flags)	UNIT_TEST(_name, _flags, upl_test)
+
+static int add_region(struct unit_test_state *uts, struct alist *lst,
+		      ulong base, ulong size)
+{
+	struct memregion region;
+
+	region.base = base;
+	region.size = size;
+	ut_assertnonnull(alist_add(lst, region, struct memregion));
+
+	return 0;
+}
+
+int upl_get_test_data(struct unit_test_state *uts, struct upl *upl)
+{
+	struct upl_memmap memmap;
+	struct upl_memres memres;
+	struct upl_image img;
+	struct upl_mem mem;
+
+	upl_init(upl);
+
+	upl->addr_cells = 1;
+	upl->size_cells = 1;
+	upl->smbios = 0x123;
+	upl->acpi = 0x456;
+	upl->bootmode = BIT(UPLBM_DEFAULT) | BIT(UPLBM_S3);
+	upl->fit = 0x789;
+	upl->conf_offset = 0x234;
+	upl->addr_width = 46;
+	upl->acpi_nvs_size = 0x100;
+
+	/* image[0] */
+	img.load = 0x1;
+	img.size = 0x2;
+	img.offset = 0x3;
+	img.description = "U-Boot";
+	ut_assertnonnull(alist_add(&upl->image, img, struct upl_image));
+
+	/* image[1] */
+	img.load = 0x4;
+	img.size = 0x5;
+	img.offset = 0x6;
+	img.description = "ATF";
+	ut_assertnonnull(alist_add(&upl->image, img, struct upl_image));
+
+	/* mem[0] : 3 regions */
+	memset(&mem, '\0', sizeof(mem));
+	alist_init_struct(&mem.region, struct memregion);
+	ut_assertok(add_region(uts, &mem.region, 0x10, 0x20));
+	ut_assertok(add_region(uts, &mem.region, 0x30, 0x40));
+	ut_assertok(add_region(uts, &mem.region, 0x40, 0x50));
+	ut_assertnonnull(alist_add(&upl->mem, mem, struct upl_mem));
+
+	/* mem[0] : 1 region */
+	alist_init_struct(&mem.region, struct memregion);
+	ut_assertok(add_region(uts, &mem.region, 0x70, 0x80));
+	mem.hotpluggable = true;
+	ut_assertnonnull(alist_add(&upl->mem, mem, struct upl_mem));
+	mem.hotpluggable = false;
+
+	/* memmap[0] : 5 regions */
+	alist_init_struct(&memmap.region, struct memregion);
+	memmap.name = "acpi";
+	memmap.usage = BIT(UPLUS_ACPI_RECLAIM);
+	ut_assertok(add_region(uts, &memmap.region, 0x11, 0x12));
+	ut_assertok(add_region(uts, &memmap.region, 0x13, 0x14));
+	ut_assertok(add_region(uts, &memmap.region, 0x15, 0x16));
+	ut_assertok(add_region(uts, &memmap.region, 0x17, 0x18));
+	ut_assertok(add_region(uts, &memmap.region, 0x19, 0x1a));
+	ut_assertnonnull(alist_add(&upl->memmap, memmap, struct upl_memmap));
+
+	/* memmap[1] : 1 region */
+	memmap.name = "u-boot";
+	memmap.usage = BIT(UPLUS_BOOT_DATA);
+	alist_init_struct(&memmap.region, struct memregion);
+	ut_assertok(add_region(uts, &memmap.region, 0x21, 0x22));
+	ut_assertnonnull(alist_add(&upl->memmap, memmap, struct upl_memmap));
+
+	/* memmap[2] : 1 region */
+	alist_init_struct(&memmap.region, struct memregion);
+	memmap.name = "efi";
+	memmap.usage = BIT(UPLUS_RUNTIME_CODE);
+	ut_assertok(add_region(uts, &memmap.region, 0x23, 0x24));
+	ut_assertnonnull(alist_add(&upl->memmap, memmap, struct upl_memmap));
+
+	/* memmap[3]: 2 regions */
+	alist_init_struct(&memmap.region, struct memregion);
+	memmap.name = "empty";
+	memmap.usage = 0;
+	ut_assertok(add_region(uts, &memmap.region, 0x25, 0x26));
+	ut_assertok(add_region(uts, &memmap.region, 0x27, 0x28));
+	ut_assertnonnull(alist_add(&upl->memmap, memmap, struct upl_memmap));
+
+	/* memmap[4]: 1 region */
+	alist_init_struct(&memmap.region, struct memregion);
+	memmap.name = "acpi-things";
+	memmap.usage = BIT(UPLUS_RUNTIME_CODE) | BIT(UPLUS_ACPI_NVS);
+	ut_assertok(add_region(uts, &memmap.region, 0x29, 0x2a));
+	ut_assertnonnull(alist_add(&upl->memmap, memmap, struct upl_memmap));
+
+	/* memres[0]: 1 region */
+	alist_init_struct(&memres.region, struct memregion);
+	memset(&memres, '\0', sizeof(memres));
+	memres.name = "mmio";
+	ut_assertok(add_region(uts, &memres.region, 0x2b, 0x2c));
+	ut_assertnonnull(alist_add(&upl->memres, memres, struct upl_memres));
+
+	/* memres[1]: 2 regions */
+	alist_init_struct(&memres.region, struct memregion);
+	memres.name = "memory";
+	ut_assertok(add_region(uts, &memres.region, 0x2d, 0x2e));
+	ut_assertok(add_region(uts, &memres.region, 0x2f, 0x30));
+	memres.no_map = true;
+	ut_assertnonnull(alist_add(&upl->memres, memres, struct upl_memres));
+
+	upl->serial.compatible = "ns16550a";
+	upl->serial.clock_frequency = 1843200;
+	upl->serial.current_speed = 115200;
+	alist_init_struct(&upl->serial.reg, struct memregion);
+	ut_assertok(add_region(uts, &upl->serial.reg, 0xf1de0000, 0x100));
+	upl->serial.reg_io_shift = 2;
+	upl->serial.reg_offset = 0x40;
+	upl->serial.reg_io_width = 1;
+	upl->serial.virtual_reg = 0x20000000;
+	upl->serial.access_type = UPLSAT_MMIO;
+
+	alist_init_struct(&upl->graphics.reg, struct memregion);
+	ut_assertok(add_region(uts, &upl->graphics.reg, 0xd0000000, 0x10000000));
+	upl->graphics.width = 1280;
+	upl->graphics.height = 1280;
+	upl->graphics.stride = upl->graphics.width * 4;
+	upl->graphics.format = UPLGF_ARGB32;
+
+	return 0;
+}
+
+static int compare_upl_image(struct unit_test_state *uts,
+			     const struct upl_image *base,
+			     const struct upl_image *cmp)
+{
+	ut_asserteq(base->load, cmp->load);
+	ut_asserteq(base->size, cmp->size);
+	ut_asserteq(base->offset, cmp->offset);
+	ut_asserteq_str(base->description, cmp->description);
+
+	return 0;
+}
+
+static int compare_upl_memregion(struct unit_test_state *uts,
+				 const struct memregion *base,
+				 const struct memregion *cmp)
+{
+	ut_asserteq(base->base, cmp->base);
+	ut_asserteq(base->size, cmp->size);
+
+	return 0;
+}
+
+static int compare_upl_mem(struct unit_test_state *uts,
+			   const struct upl_mem *base,
+			   const struct upl_mem *cmp)
+{
+	int i;
+
+	ut_asserteq(base->region.count, cmp->region.count);
+	ut_asserteq(base->hotpluggable, cmp->hotpluggable);
+	for (i = 0; i < base->region.count; i++) {
+		ut_assertok(compare_upl_memregion(uts,
+			alist_get(&base->region, i, struct memregion),
+			alist_get(&cmp->region, i, struct memregion)));
+	}
+
+	return 0;
+}
+
+static int check_device_name(struct unit_test_state *uts, const char *base,
+			     const char *cmp)
+{
+	const char *p;
+
+	p = strchr(cmp, '@');
+	if (p) {
+		ut_assertnonnull(p);
+		ut_asserteq_strn(base, cmp);
+		ut_asserteq(p - cmp, strlen(base));
+	} else {
+		ut_asserteq_str(base, cmp);
+	}
+
+	return 0;
+}
+
+static int compare_upl_memmap(struct unit_test_state *uts,
+			      const struct upl_memmap *base,
+			      const struct upl_memmap *cmp)
+{
+	int i;
+
+	ut_assertok(check_device_name(uts, base->name, cmp->name));
+	ut_asserteq(base->region.count, cmp->region.count);
+	ut_asserteq(base->usage, cmp->usage);
+	for (i = 0; i < base->region.count; i++)
+		ut_assertok(compare_upl_memregion(uts,
+			alist_get(&base->region, i, struct memregion),
+			alist_get(&cmp->region, i, struct memregion)));
+
+	return 0;
+}
+
+static int compare_upl_memres(struct unit_test_state *uts,
+			      const struct upl_memres *base,
+			      const struct upl_memres *cmp)
+{
+	int i;
+
+	ut_assertok(check_device_name(uts, base->name, cmp->name));
+	ut_asserteq(base->region.count, cmp->region.count);
+	ut_asserteq(base->no_map, cmp->no_map);
+	for (i = 0; i < base->region.count; i++)
+		ut_assertok(compare_upl_memregion(uts,
+			alist_get(&base->region, i, struct memregion),
+			alist_get(&cmp->region, i, struct memregion)));
+
+	return 0;
+}
+
+static int compare_upl_serial(struct unit_test_state *uts,
+			      struct upl_serial *base, struct upl_serial *cmp)
+{
+	int i;
+
+	ut_asserteq_str(base->compatible, cmp->compatible);
+	ut_asserteq(base->clock_frequency, cmp->clock_frequency);
+	ut_asserteq(base->current_speed, cmp->current_speed);
+	for (i = 0; i < base->reg.count; i++)
+		ut_assertok(compare_upl_memregion(uts,
+			alist_get(&base->reg, i, struct memregion),
+			alist_get(&cmp->reg, i, struct memregion)));
+	ut_asserteq(base->reg_io_shift, cmp->reg_io_shift);
+	ut_asserteq(base->reg_offset, cmp->reg_offset);
+	ut_asserteq(base->reg_io_width, cmp->reg_io_width);
+	ut_asserteq(base->virtual_reg, cmp->virtual_reg);
+	ut_asserteq(base->access_type, cmp->access_type);
+
+	return 0;
+}
+
+static int compare_upl_graphics(struct unit_test_state *uts,
+				struct upl_graphics *base,
+				struct upl_graphics *cmp)
+{
+	int i;
+
+	for (i = 0; i < base->reg.count; i++)
+		ut_assertok(compare_upl_memregion(uts,
+			alist_get(&base->reg, i, struct memregion),
+			alist_get(&cmp->reg, i, struct memregion)));
+	ut_asserteq(base->width, cmp->width);
+	ut_asserteq(base->height, cmp->height);
+	ut_asserteq(base->stride, cmp->stride);
+	ut_asserteq(base->format, cmp->format);
+
+	return 0;
+}
+
+static int compare_upl(struct unit_test_state *uts, struct upl *base,
+		       struct upl *cmp)
+{
+	int i;
+
+	ut_asserteq(base->addr_cells, cmp->addr_cells);
+	ut_asserteq(base->size_cells, cmp->size_cells);
+
+	ut_asserteq(base->smbios, cmp->smbios);
+	ut_asserteq(base->acpi, cmp->acpi);
+	ut_asserteq(base->bootmode, cmp->bootmode);
+	ut_asserteq(base->fit, cmp->fit);
+	ut_asserteq(base->conf_offset, cmp->conf_offset);
+	ut_asserteq(base->addr_width, cmp->addr_width);
+	ut_asserteq(base->acpi_nvs_size, cmp->acpi_nvs_size);
+
+	ut_asserteq(base->image.count, cmp->image.count);
+	for (i = 0; i < base->image.count; i++)
+		ut_assertok(compare_upl_image(uts,
+			alist_get(&base->image, i, struct upl_image),
+			alist_get(&cmp->image, i, struct upl_image)));
+
+	ut_asserteq(base->mem.count, cmp->mem.count);
+	for (i = 0; i < base->mem.count; i++)
+		ut_assertok(compare_upl_mem(uts,
+			alist_get(&base->mem, i, struct upl_mem),
+			alist_get(&cmp->mem, i, struct upl_mem)));
+
+	ut_asserteq(base->memmap.count, cmp->memmap.count);
+	for (i = 0; i < base->memmap.count; i++)
+		ut_assertok(compare_upl_memmap(uts,
+			alist_get(&base->memmap, i, struct upl_memmap),
+			alist_get(&cmp->memmap, i, struct upl_memmap)));
+
+	ut_asserteq(base->memres.count, cmp->memres.count);
+	for (i = 0; i < base->memres.count; i++)
+		ut_assertok(compare_upl_memres(uts,
+			alist_get(&base->memres, i, struct upl_memres),
+			alist_get(&cmp->memres, i, struct upl_memres)));
+
+	ut_assertok(compare_upl_serial(uts, &base->serial, &cmp->serial));
+	ut_assertok(compare_upl_graphics(uts, &base->graphics, &cmp->graphics));
+
+	return 0;
+}
+
+/* Basic test of writing and reading UPL handoff */
+static int upl_test_base(struct unit_test_state *uts)
+{
+	oftree tree, check_tree;
+	struct upl upl, check;
+	struct abuf buf;
+
+	if (!CONFIG_IS_ENABLED(OFNODE_MULTI_TREE))
+		return -EAGAIN;  /* skip test */
+	ut_assertok(upl_get_test_data(uts, &upl));
+
+	ut_assertok(upl_create_handoff_tree(&upl, &tree));
+	ut_assertok(oftree_to_fdt(tree, &buf));
+
+	/*
+	 * strings in check_tree and therefore check are only valid so long as
+	 * buf stays around. As soon as we call abuf_uninit they go away
+	 */
+	check_tree = oftree_from_fdt(abuf_data(&buf));
+	ut_assert(ofnode_valid(oftree_path(check_tree, "/")));
+
+	ut_assertok(upl_read_handoff(&check, check_tree));
+	ut_assertok(compare_upl(uts, &upl, &check));
+	abuf_uninit(&buf);
+
+	return 0;
+}
+UPL_TEST(upl_test_base, 0);
+
+int do_ut_upl(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	struct unit_test *tests = UNIT_TEST_SUITE_START(upl_test);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(upl_test);
+
+	return cmd_ut_category("cmd_upl", "cmd_upl_", tests, n_ents, argc,
+			       argv);
+}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 4e4aa8f1cb2..38ba89ee33e 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -133,6 +133,9 @@ static struct cmd_tbl cmd_ut_sub[] = {
 #ifdef CONFIG_CMD_SEAMA
 	U_BOOT_CMD_MKENT(seama, CONFIG_SYS_MAXARGS, 1, do_ut_seama, "", ""),
 #endif
+#ifdef CONFIG_CMD_UPL
+	U_BOOT_CMD_MKENT(upl, CONFIG_SYS_MAXARGS, 1, do_ut_upl, "", ""),
+#endif
 };
 
 static int do_ut_all(struct cmd_tbl *cmdtp, int flag, int argc,
-- 
2.34.1

