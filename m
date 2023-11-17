Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76780C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 02:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD7BC874B1;
	Fri, 17 Nov 2023 03:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qiBhnoxw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04BEB874B1; Fri, 17 Nov 2023 03:02:13 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 1052387206
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 03:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id BD29B20B74C2;
 Thu, 16 Nov 2023 18:02:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD29B20B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1700186528;
 bh=26CyDbVydmTqAZmyz6TebB8aGW0sFlzvmOL/TC0HDFM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qiBhnoxwvAuZxO0Aj59DKPUJx0GfeVCf7wDot8aC35xHZ8cDgnPSBOn8ksGf8FndA
 EgSAU73N9FQvsSl/wsRoDkqoVfoDCgAMd9u186OZ0sRy5l92r0F9oPNnM1ZG4bNuZS
 rbO98usCnU6264ZeUHX0RYPImABjfDUsdvEy437Y=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: dphadke@linux.microsoft.com, ilias.apalodimas@linaro.org,
 trini@konsulko.com, sjg@chromium.org
Subject: [PATCH v5 2/5] fdt: kaslr seed from RNG device
Date: Thu, 16 Nov 2023 18:02:03 -0800
Message-ID: <20231117020207.948636-3-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
References: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
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
 boot/fdt_support.c | 36 ++++++++++++++++++++++++++++++++++++
 lib/Kconfig        |  7 +++++++
 2 files changed, 43 insertions(+)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 49d14a949be..12defcf645c 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
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
index 19649517a39..4f5dfc00d6f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -477,6 +477,13 @@ config VPL_TPM
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
2.42.0

