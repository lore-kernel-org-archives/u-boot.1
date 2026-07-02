Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F8AC43327
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 09:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C72B084CF1;
	Thu,  2 Jul 2026 11:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gTEyQcE7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B823384C92; Thu,  2 Jul 2026 09:15:03 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C00E8056B
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 09:15:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C5AF43F442
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 07:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782976500;
 bh=Nil6vBIFezd5am/KZ1ZLg8CUVIqR6EtRPVnn4mbYlrQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=gTEyQcE7lnbMLgkCk8THM4XxxtorK0/HbeJa1PWmwyIzIaRlIWGIvcMqucgnDUb16
 WGw1FUzzBlOSew3CCTgk8OC2j1PRx3///cl1W4wv1wUmsfYyCuPQMQtuRBR/i68b/J
 L9O9ZAuVAYn/BGFnDBnMJeDvLiU8RO3OfLty5hkFL/3L9VnVZTDQFtvqY+0IMRzByc
 WLfdzDxGTQc6cK8j/hIEnN1uloGEp+6cPRv/GESXp9P41GE+e4F3CSXYmC3X0jy/2/
 gLIrYoSVsuQCiXSE7Psu80dM1ERcK3HevkeCY4ZuvwTsArH+QlhdKq6L3VJk/XkzwW
 6J+q4qLOaJSs7rYLpvnfV3POImf6FvT76uXp4kv8K4Na2xt4ktYYlUu/5JSTwifszk
 V8WGxfcokrIos7R1QIkOxMj8d3kVoYCbLDUoqjn7aRlJufWylmUBEzp43oYwFDYWKo
 m1ZrHAUF2oghLMVkociLGALR/kAz5iaSvgxBO3tMEJka1KllhUyEYTcYN5GchekI+1
 YhNXDyusJ5492CNr2ZkeaK63Mx/NkbKLW2SIG7Rvu9oej349dAItm6mY8Pflj9EAuC
 qcmRUiWjqkp167p42n1Dqk3ppvjcmcJdIpDRvvU76K/zA6a3Iu+qTwzozVZe7x5nHY
 Pr8iJ+WsC/QVjtsSw05UnD0M=
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84696ed3b24so1936460b3a.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 00:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782976499; x=1783581299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nil6vBIFezd5am/KZ1ZLg8CUVIqR6EtRPVnn4mbYlrQ=;
 b=CFTFCEiIfj3l+VUwykuXeo8ng05g6vJc2g8OuYjwMyTtT+/uwitRsuECmUKKQ5Lb+Q
 0qFvgh2ORRcZzUYVY0ZKiZPvD+dTaHvl7x23PMCeOVOnza9UMVLM5wKK6ASKXMvuerb6
 YDJctuIqm4ukRNJf1/pCMuUN4M/YRZ9k8V+KeeV8pwMsMifu/V8DJixzn8cHiwb68Jhz
 LwY7cxw3P8H/eB8BTtXUHlOkH5oBkl8991B3FyXpJsztIJkx225paOTKonTiwcPfyYVv
 XvcSLDRC1Tqw0RM/hSTkKHOqsqSZYWuH1OvH6mJpBYb81raJ1qly30iaKf4cCPwSDuJn
 BRyA==
X-Gm-Message-State: AOJu0YyzJMNInBd2XBoz3wAaaxH/YOujUynl9MycDZUGIwkDFsgS+Pqh
 9gtyvtGv35eJhBNkXtqVAlXMQWqjml7F8MXSGzQOQOk+XQqyFZdb2GilvhH2JrRLusLAbuZZsYE
 X5zuhiM2JM53/Ff14q7Jhc/rH7rQSgGeIXKnSRIWkbvQxpXwKN9SmxDlMWfPOlkH9tQoIRrWir2
 LBg/xoyg==
X-Gm-Gg: AfdE7cniTnzvK5WHVfOPeLf2YXPlBXHeoE0x6mGuaN1gxSwh6kfiLU/3V9ft2VUH5ez
 40S9zerFBqswYhZXuqnGWQF71CTHVhVaK3GryPPWDM7ZPtL7ELy53g/ay7M1JyfJQi1w4LHJgEZ
 x8893rPZmzA5LbMI4Y6SqvgNcJnHOpk4KoD9xob9YMR3Uy6EGBSvWd20uOF2Kuhm5/0jV7JD0+6
 1nTXa+6oRQnCi2K65+QoZLXwFIN2QEqujoowTGpLQvLZiOKPMzwztREzRYvv5669xq3SVy0T7wb
 mGOlWkgdh0euohvAzyUCyhkVfTS/STUWocOLzN9UcmHuaOJxiff5UYNBZtPTGap0NKfiblyv1Ll
 flMgokg9WMmOrtXMbH/3VTVAQlCX9C4BfNg1Fag3rtHACPQuliPB8x5dv18BG6q/Hmp+4Bv31h0
 +XgA==
X-Received: by 2002:a05:6a00:ad84:b0:847:95a6:eb74 with SMTP id
 d2e1a72fcca58-847c073141dmr4917471b3a.23.1782976499073; 
 Thu, 02 Jul 2026 00:14:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:ad84:b0:847:95a6:eb74 with SMTP id
 d2e1a72fcca58-847c073141dmr4917424b3a.23.1782976498521; 
 Thu, 02 Jul 2026 00:14:58 -0700 (PDT)
Received: from noble-uboot.tail872496.ts.net
 (211-75-139-218.hinet-ip.hinet.net. [211.75.139.218])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cba05575sm894056b3a.61.2026.07.02.00.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 00:14:57 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH v2 3/3] test: vbe: cover vbe_read_fit() external-data bounds
 checks
Date: Thu,  2 Jul 2026 07:13:59 +0000
Message-ID: <20260702071425.9204-4-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702071425.9204-1-aristo.chen@canonical.com>
References: <20260621143938.2863-1-aristo.chen@canonical.com>
 <20260702071425.9204-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 11:20:23 +0200
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

The new file follows the existing bootstd VBE test layout and writes
the FIT at block 16, past the version and nvdata blocks already used by
bootstd_setup_for_tests().

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/boot/Makefile       |   2 +-
 test/boot/vbe_read_fit.c | 225 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 226 insertions(+), 1 deletion(-)
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
index 00000000000..dbfcf399b70
--- /dev/null
+++ b/test/boot/vbe_read_fit.c
@@ -0,0 +1,225 @@
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
+#include <mapmem.h>
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

