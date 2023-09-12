Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146FCEE3F31
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 21:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E8CE86E80;
	Tue, 12 Sep 2023 23:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="R3WBQaKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8533386D0A; Tue, 12 Sep 2023 23:35:09 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id D75B486CFC
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 23:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id CB93F212BC3D;
 Tue, 12 Sep 2023 14:35:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CB93F212BC3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1694554505;
 bh=r2LsGKiIO1Iuw9RKkVIdwDT0PmjGrhZVsciMfZMFmj0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=R3WBQaKvHsekzAmzkZz3WxckwYc3Mj/rB418Z8bw1ErWWSVdSWbX9YfGdMfgmtfUU
 yiTYzr/WcwsXt3EyqQmduq5CnaAmSCPBbNnKfJsOuQtC+TKeIPU73MjxbmxG9HJy11
 zGZ914Eu6LiQDz3wLTf+rr7WE8QqxO6euoZfswXI=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, dphadke@linux.microsoft.com, ilias.apalodimas@linaro.org
Subject: [PATCH v3 2/5] fdt: kaslr seed from RNG device
Date: Tue, 12 Sep 2023 14:35:01 -0700
Message-Id: <20230912213504.65513-3-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230912213504.65513-1-seanedmond@linux.microsoft.com>
References: <20230912213504.65513-1-seanedmond@linux.microsoft.com>
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

From: Dhananjay Phadke <dphadke@linux.microsoft.com>

Add support for KASLR seed from the RNG device. Invokes dm_rng_read()
API to read 8-bytes of random bytes.  Performs the FDT fixup using event
spy.  To enable use CONFIG_KASLR_RNG_SEED

Signed-off-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 common/fdt_support.c | 36 ++++++++++++++++++++++++++++++++++++
 lib/Kconfig          |  7 +++++++
 2 files changed, 43 insertions(+)

diff --git a/common/fdt_support.c b/common/fdt_support.c
index 52be4375b4..09ce582865 100644
--- a/common/fdt_support.c
+++ b/common/fdt_support.c
@@ -12,7 +12,10 @@
 #include <log.h>
 #include <mapmem.h>
 #include <net.h>
+#include <rng.h>
 #include <stdio_dev.h>
+#include <dm/device.h>
+#include <dm/uclass.h>
 #include <dm/ofnode.h>
 #include <linux/ctype.h>
 #include <linux/types.h>
@@ -650,6 +653,39 @@ int fdt_fixup_kaslr_seed(ofnode node, const u8 *seed, int len)
 	return 0;
 }
 
+int fdt_rng_kaslr_seed(void *ctx, struct event *event)
+{
+	u8 rand[8] = {0};
+	struct udevice *dev;
+	int ret;
+	oftree tree = event->data.ft_fixup.tree;
+	ofnode root_node = oftree_root(tree);
+
+	ret = uclass_first_device_err(UCLASS_RNG, &dev);
+	if (ret) {
+		printf("ERROR: Failed to find RNG device\n");
+		return ret;
+	}
+
+	ret = dm_rng_read(dev, rand, sizeof(rand));
+	if (ret) {
+		printf("ERROR: RNG read failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	ret = fdt_fixup_kaslr_seed(root_node, rand, sizeof(rand));
+	if (ret) {
+		printf("ERROR: failed to add kaslr-seed to fdt\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+#if defined(CONFIG_KASLR_RNG_SEED)
+EVENT_SPY(EVT_FT_FIXUP, fdt_rng_kaslr_seed);
+#endif
+
 int fdt_record_loadable(void *blob, u32 index, const char *name,
 			uintptr_t load_addr, u32 size, uintptr_t entry_point,
 			const char *type, const char *os, const char *arch)
diff --git a/lib/Kconfig b/lib/Kconfig
index 3926652db6..545a14343e 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -465,6 +465,13 @@ config VPL_TPM
 	  for the low-level TPM interface, but only one TPM is supported at
 	  a time by the TPM library.
 
+config KASLR_RNG_SEED
+	bool "Use RNG driver for KASLR random seed"
+	depends on DM_RNG
+	help
+	  This enables support for using the RNG driver as entropy source for
+	  KASLR seed populated in kernel's device tree.
+
 endmenu
 
 menu "Android Verified Boot"
-- 
2.40.0

