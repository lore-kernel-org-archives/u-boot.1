Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64834C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 04:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 928A2848D2;
	Sun,  5 Jul 2026 06:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="jZC0GSXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C28784119; Sun,  5 Jul 2026 05:44:46 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33712846FD
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 05:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DAC6E3F2A0
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 03:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783223082;
 bh=lf+v+ygamAIUt/QGfkSRBGqENmqHasB3Z2Ja+xXflBM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=jZC0GSXew3rXc1fjyAt3vbtkS1dAw2PSfK4Gl3QFCfuSb6kXBsK2sthh9r2jSEiEw
 YgXZ3uyxMHn/bZnBVuGztwZaqX9Gv8ITrwozZM0CoSRPh6LQ1K6cRCfVTIYFChU+2e
 pIwEHWuK5sxA0p5PqKp/U8T2XLcjnzq/ctcqv0oSSB3jCA8ic+JGC13u3xbm4OEgXq
 81mr12eYJ8ZoDFMPKeGEsUDZ6JzpuV0kTqWSsB7TsoDYNcSYxaDhXS5XXVzOfWuk5b
 6jqw8O/pL9VeEIdfAGnOyDTNlwXkI7rUK1ZsEHejY5mfpiUzr1SQgzOqcq8YtJdZAW
 9bVjYBfrR0fY8vHTtA9bHYN92VPkORcLt13rHizmPDJR+RRAfp86hu99S9qkIfX/p2
 U2Ly7tm665/Ci8uaEcIb0gPITLbXZf6kDfqdGjf+g6rDFMsl8k5k8yAn/ANtDK36jm
 No3DcbwN85S/HEQM78UbYLWgjLtLrU5LvExB20oMVezfx0RNtkC16//mQRxDnbdxnS
 bw0uR33Z6cxkHxgm2hNRoPZqrwOTm8KuF0zYyOH6tLvvZqXqdSbPcCO0asgWumug+0
 6R/5qyoZ3OuO/dNqXNSGqbNyfSM5qrdOG1N81+eBxC9ZyyoXP3jrxJzihLiTtLTWOO
 fFhFaNJ2diCBxaurctgn+r7g=
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c9151bf6ce7so2060293a12.3
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 20:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783223081; x=1783827881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lf+v+ygamAIUt/QGfkSRBGqENmqHasB3Z2Ja+xXflBM=;
 b=VcP3vHCyAPhMtB62r1cgltUkgciOKbR77/lLxn0btjn1/2QX53gWNI58R9EtKBSJEy
 8iVVA6jVKOSRnzjSw4UcyuIo7C9xrjrIK3tXEnxJ6wZfY7oe7lSv5L3ue4v+1ph6R9Pr
 kmkXO/DfKsP5kQPzxnaUQuvEB/RZw/3ErNTzJig9J3smO8Lcco7cLhtTuChtxVOSdYMz
 V0c3AxOgWYaKjZg/0DgNCm7ax+GElWWxTp6NfjRWRQkgvXw+QIbZWxkeLyHbcQfm42Vj
 mfBwvGhSizgmlxv1CQhj/VakiIARVPoqdCIBhy0pAJTZ/ZyhfRuJqQqK3v+gbYKpdpGk
 9wCw==
X-Gm-Message-State: AOJu0YzM2gAAiqNIS/+kqY2YS85ZTEInfyjEDylljClLfprnI4esHjxM
 bS9TtmMkCKQl7ToHDGzcXF5+ru8X/gltrC/MI74VD4yywK68Giy2u7bEGuf1fT1UsPfcSb+IRFf
 K/llxoP21yJ1emEDquIBCKq+SAvXO69GowqnqPa+T7I4meMWNAN9xLcClKVBA3aMAHkQCeCSQF9
 ppFYiMVQ==
X-Gm-Gg: AfdE7cnPGHUr6Ap3r5SJzUEpM2IA0SO6U8+qMdYM3EXRTRhO4wH/kXdTLZ8iSrnmBcx
 49M6fZugm/tytTIPC8aHsqSw6g7wavcNF3x8FXPjnNigMvheHLtYnrTP9E2EUlKbZYaUaFRJ5Jw
 ttukQa1Nyhns9wgAtXS0lr4lDql3eIXi/MLgbEqFOAb/kT0tEjwQQQIoRo3jyBmv3oGoO5CcvWB
 GTeGzS9cVoSWBIAuiegBM41jQR4Klm+k0RWC9w6znW0rJk4j3/yMhmDnEMSIs0o2qaTOT1EZ5pk
 5BkY2wxoYYyYrJI84TGDS7wdEFjVVDQSlRiuD7J4RNrNNFdbjzleer4POO0v4gQi2jDvCOwJoj8
 76ZFOqMRJSUll+REJia7hUtz2yg7hd2bFiMGdaTegbItuspgQUpFiy6c2YC7lGg6QrFVxj9guEu
 DxIDzF
X-Received: by 2002:a05:6300:2287:b0:3bf:b3d5:ce1b with SMTP id
 adf61e73a8af0-3c03e20875emr5760591637.12.1783223081251; 
 Sat, 04 Jul 2026 20:44:41 -0700 (PDT)
X-Received: by 2002:a05:6300:2287:b0:3bf:b3d5:ce1b with SMTP id
 adf61e73a8af0-3c03e20875emr5760571637.12.1783223080870; 
 Sat, 04 Jul 2026 20:44:40 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (124-218-37-86.cm.dynamic.apol.com.tw. [124.218.37.86])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c9e926a4294sm4424735a12.26.2026.07.04.20.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 20:44:40 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH v3 3/3] test: vbe: cover vbe_read_fit() external-data bounds
 checks
Date: Sun,  5 Jul 2026 03:44:11 +0000
Message-ID: <20260705034414.2247-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260705034414.2247-1-aristo.chen@canonical.com>
References: <20260702071425.9204-1-aristo.chen@canonical.com>
 <20260705034414.2247-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Jul 2026 06:05:54 +0200
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

vbe_read_fit() rejects FITs whose external-data window extends past the
trusted firmware area on disk by returning -E2BIG. Add two sandbox unit
tests that construct synthetic FITs with attacker-controlled
data-position and data-size values, write them to mmc1, and assert
vbe_read_fit() catches each one before issuing the follow-up
blk_read().

vbe_read_fit_oob_position uses a data-position past area_size, which
trips the load_addr - addr > area_size clause. vbe_read_fit_oversize_data
keeps data-position inside the area but picks a data-size that overruns
area_size - (load_addr - addr), tripping the third clause.

The two remaining bound clauses stay unreachable from a sandbox test.
The load_addr < addr guard trivially holds when addr comes from
CONFIG_VAL(TEXT_BASE), which is 0 on sandbox, and the FDT-region bound
sits behind a !CONFIG_SANDBOX guard in vbe_read_fit(), so fdt_size stays
0 and that block is skipped in this test environment.

The new file follows the existing bootstd VBE test layout and writes
the FIT at block 16, past the version and nvdata blocks already used by
bootstd_setup_for_tests().

Suggested-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/boot/Makefile       |   2 +-
 test/boot/vbe_read_fit.c | 224 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 225 insertions(+), 1 deletion(-)
 create mode 100644 test/boot/vbe_read_fit.c

diff --git a/test/boot/Makefile b/test/boot/Makefile
index 89538d4f0a6..b8e5f64ac82 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -18,7 +18,7 @@ endif
 obj-$(CONFIG_MEASURED_BOOT) += measurement.o
 
 ifdef CONFIG_OF_LIVE
-obj-$(CONFIG_BOOTMETH_VBE_SIMPLE) += vbe_simple.o
+obj-$(CONFIG_BOOTMETH_VBE_SIMPLE) += vbe_simple.o vbe_read_fit.o
 endif
 obj-$(CONFIG_BOOTMETH_VBE) += vbe_fixup.o
 
diff --git a/test/boot/vbe_read_fit.c b/test/boot/vbe_read_fit.c
new file mode 100644
index 00000000000..f67de0e7165
--- /dev/null
+++ b/test/boot/vbe_read_fit.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Bounds-check tests for vbe_read_fit()
+ *
+ * vbe_read_fit() pulls a firmware-phase FIT from a trusted firmware area
+ * on a block device. The external-data location and size carried in the
+ * FIT image node are attacker-controllable when the firmware area is on
+ * mutable boot media, so vbe_read_fit() must reject FITs whose external
+ * data extends past @area_size before issuing the follow-up blk_read().
+ *
+ * These tests build small synthetic FITs with deliberately out-of-range
+ * values and confirm vbe_read_fit() returns -E2BIG for each.
+ *
+ * Copyright 2026 Canonical Ltd.
+ * Written by Aristo Chen <aristo.chen@canonical.com>
+ */
+
+#include <blk.h>
+#include <dm.h>
+#include <image.h>
+#include <memalign.h>
+#include <mmc.h>
+#include <test/test.h>
+#include <test/ut.h>
+#include <linux/libfdt.h>
+#include "bootstd_common.h"
+#include "../../boot/vbe_common.h"
+
+/*
+ * The synthetic FIT is written to mmc1 starting at block TEST_FIT_BLK.
+ * bootstd_setup_for_tests() uses blocks 4 and 6 (see bootstd_common.h);
+ * block 16 leaves a comfortable gap.
+ */
+#define TEST_FIT_BLK	16
+#define TEST_FIT_OFF	((ulong)TEST_FIT_BLK * MMC_MAX_BLOCK_LEN)
+#define TEST_AREA_SIZE	0x1000
+
+/**
+ * build_fit() - Build a minimal external-data FIT for vbe_read_fit()
+ *
+ * The FIT advertises a single firmware image whose @data-position and
+ * @data-size are passed in directly. Both values are attacker-controlled
+ * in the real threat model.
+ *
+ * @buf:		Destination buffer (must be at least 512 bytes)
+ * @buf_size:		Size of @buf
+ * @data_position:	Value written to the image's data-position property
+ * @data_size:		Value written to the image's data-size property
+ * Returns: 0 on success, libfdt error otherwise
+ */
+static int build_fit(void *buf, size_t buf_size, u32 data_position,
+		     u32 data_size)
+{
+	int ret;
+
+	ret = fdt_create(buf, buf_size);
+	if (ret)
+		return ret;
+	ret = fdt_finish_reservemap(buf);
+	if (ret)
+		return ret;
+
+	ret = fdt_begin_node(buf, "");
+	if (ret)
+		return ret;
+	ret = fdt_property_string(buf, FIT_DESC_PROP, "vbe-read-fit test");
+	if (ret)
+		return ret;
+	ret = fdt_property_u32(buf, FIT_TIMESTAMP_PROP, 0);
+	if (ret)
+		return ret;
+
+	ret = fdt_begin_node(buf, "images");
+	if (ret)
+		return ret;
+	ret = fdt_begin_node(buf, "u-boot");
+	if (ret)
+		return ret;
+	ret = fdt_property_string(buf, FIT_DESC_PROP, "U-Boot");
+	if (ret)
+		return ret;
+	ret = fdt_property_string(buf, FIT_TYPE_PROP, "firmware");
+	if (ret)
+		return ret;
+	ret = fdt_property_string(buf, FIT_ARCH_PROP, "sandbox");
+	if (ret)
+		return ret;
+	ret = fdt_property_string(buf, FIT_OS_PROP, "u-boot");
+	if (ret)
+		return ret;
+	ret = fdt_property_string(buf, FIT_PHASE_PROP, "u-boot");
+	if (ret)
+		return ret;
+	ret = fdt_property_string(buf, FIT_COMP_PROP, "none");
+	if (ret)
+		return ret;
+	ret = fdt_property_u32(buf, FIT_DATA_POSITION_PROP, data_position);
+	if (ret)
+		return ret;
+	ret = fdt_property_u32(buf, FIT_DATA_SIZE_PROP, data_size);
+	if (ret)
+		return ret;
+	ret = fdt_end_node(buf);	/* u-boot */
+	if (ret)
+		return ret;
+	ret = fdt_end_node(buf);	/* images */
+	if (ret)
+		return ret;
+
+	ret = fdt_begin_node(buf, "configurations");
+	if (ret)
+		return ret;
+	ret = fdt_property_string(buf, FIT_DEFAULT_PROP, "conf-1");
+	if (ret)
+		return ret;
+	ret = fdt_begin_node(buf, "conf-1");
+	if (ret)
+		return ret;
+	ret = fdt_property_string(buf, "compatible", "sandbox");
+	if (ret)
+		return ret;
+	ret = fdt_property_string(buf, FIT_FIRMWARE_PROP, "u-boot");
+	if (ret)
+		return ret;
+	ret = fdt_end_node(buf);	/* conf-1 */
+	if (ret)
+		return ret;
+	ret = fdt_end_node(buf);	/* configurations */
+	if (ret)
+		return ret;
+
+	ret = fdt_end_node(buf);	/* root */
+	if (ret)
+		return ret;
+
+	return fdt_finish(buf);
+}
+
+/**
+ * place_fit_on_mmc() - Write a synthetic FIT to mmc1 and return its blk dev
+ *
+ * @uts: Unit test state
+ * @fit: FIT image to write
+ * @blkp: On success, receives the block udevice for mmc1
+ * Returns: 0 on success, -ve on error
+ */
+static int place_fit_on_mmc(struct unit_test_state *uts, const void *fit,
+			    struct udevice **blkp)
+{
+	ALLOC_CACHE_ALIGN_BUFFER(u8, blkbuf, MMC_MAX_BLOCK_LEN);
+	struct udevice *mmc;
+	struct blk_desc *desc;
+	size_t fit_size = fdt_totalsize(fit);
+	size_t pos;
+	int blknum = TEST_FIT_BLK;
+
+	ut_assertok(uclass_get_device(UCLASS_MMC, 1, &mmc));
+	desc = blk_get_by_device(mmc);
+	if (!desc)
+		return log_msg_ret("desc", -ENODEV);
+
+	for (pos = 0; pos < fit_size; pos += MMC_MAX_BLOCK_LEN, blknum++) {
+		size_t this_blk = min(fit_size - pos,
+				      (size_t)MMC_MAX_BLOCK_LEN);
+
+		memset(blkbuf, '\0', MMC_MAX_BLOCK_LEN);
+		memcpy(blkbuf, (const u8 *)fit + pos, this_blk);
+		if (blk_dwrite(desc, blknum, 1, blkbuf) != 1)
+			return log_msg_ret("wr", -EIO);
+	}
+	*blkp = desc->bdev;
+
+	return 0;
+}
+
+/*
+ * data-position points past area_size: vbe_read_fit() must reject the
+ * FIT with -E2BIG before issuing the external-data blk_read().
+ */
+static int vbe_read_fit_oob_position(struct unit_test_state *uts)
+{
+	u8 fit[1024] __aligned(8);
+	struct udevice *blk;
+	ulong load_addr = 0, len = 0;
+	char *name = NULL;
+	int ret;
+
+	ut_assertok(build_fit(fit, sizeof(fit),
+			      TEST_AREA_SIZE + 0x10, 0x40));
+	ut_assertok(place_fit_on_mmc(uts, fit, &blk));
+
+	ret = vbe_read_fit(blk, TEST_FIT_OFF, TEST_AREA_SIZE,
+			   NULL, &load_addr, &len, &name);
+	ut_asserteq(-E2BIG, ret);
+
+	return 0;
+}
+
+BOOTSTD_TEST(vbe_read_fit_oob_position, UTF_DM | UTF_SCAN_FDT);
+
+/*
+ * data-position is inside the area but data-size pushes the end past
+ * area_size: vbe_read_fit() must reject the FIT with -E2BIG.
+ */
+static int vbe_read_fit_oversize_data(struct unit_test_state *uts)
+{
+	u8 fit[1024] __aligned(8);
+	struct udevice *blk;
+	ulong load_addr = 0, len = 0;
+	char *name = NULL;
+	int ret;
+
+	ut_assertok(build_fit(fit, sizeof(fit),
+			      0x400, TEST_AREA_SIZE));
+	ut_assertok(place_fit_on_mmc(uts, fit, &blk));
+
+	ret = vbe_read_fit(blk, TEST_FIT_OFF, TEST_AREA_SIZE,
+			   NULL, &load_addr, &len, &name);
+	ut_asserteq(-E2BIG, ret);
+
+	return 0;
+}
+
+BOOTSTD_TEST(vbe_read_fit_oversize_data, UTF_DM | UTF_SCAN_FDT);
-- 
2.43.0

