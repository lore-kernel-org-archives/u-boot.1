Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEA1C71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 20:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C68E18652E;
	Tue, 29 Aug 2023 22:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gS1qq07H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06C1186508; Tue, 29 Aug 2023 22:32:18 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 02727864F5
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 22:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id BC38E2129BE5;
 Tue, 29 Aug 2023 13:32:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC38E2129BE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1693341131;
 bh=p96aupymbwIcZ15B6g7kBrnwTQpv+zzmONQrlCn2MUA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gS1qq07Ho/RM6bObbeIbfznNBe+fEbcXOT5TM4r9Cnp6zo+L3+N/+ARzk3zcVpeeV
 BOW1+IZimsHaYkNGo78rSiLI6nTMvfQKmF3HPF07VZa+yzF0WNsSV++6aFjvtdVHk/
 2UyYQdwDAye9RCvwKtUswQu7TJYc03IMcAbbh2s0=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: dphadke@linux.microsoft.com,
	macromorgan@hotmail.com,
	sjg@chromium.org
Subject: [PATCH 2/4] fdt: kaslr seed from tpm entropy
Date: Tue, 29 Aug 2023 13:32:03 -0700
Message-Id: <20230829203210.83914-2-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230829203210.83914-1-seanedmond@linux.microsoft.com>
References: <20230829203210.83914-1-seanedmond@linux.microsoft.com>
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

Add support for KASLR seed from TPM device. Invokes tpm_get_random()
API to read 8-bytes of random bytes for KASLR.

Signed-off-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
Signed-off-by: Drew Kluemke <ankluemk@microsoft.com>
Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 boot/image-fdt.c      | 15 +++++++++++++++
 common/fdt_support.c  | 30 ++++++++++++++++++++++++++++++
 include/fdt_support.h |  8 ++++++++
 lib/Kconfig           |  9 +++++++++
 4 files changed, 62 insertions(+)

diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index f10200f647..ed38ed77b9 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -624,6 +624,21 @@ int image_setup_libfdt(struct bootm_headers *images, void *blob,
 		goto err;
 	}
 
+	if (IS_ENABLED(CONFIG_KASLR_TPM_SEED)) {
+		ofnode root;
+
+		ret = root_ofnode_from_fdt(blob, &root);
+		if (ret) {
+			printf("ERROR: Unable to get root ofnode\n");
+			goto err;
+		}
+		ret = fdt_tpm_kaslr_seed(root);
+		if (ret) {
+			printf("ERROR: fdt fixup KASLR failed: %d\n", ret);
+			goto err;
+		}
+	}
+
 	fdt_ret = optee_copy_fdt_nodes(blob);
 	if (fdt_ret) {
 		printf("ERROR: transfer of optee nodes to new fdt failed: %s\n",
diff --git a/common/fdt_support.c b/common/fdt_support.c
index 52be4375b4..d338fcde54 100644
--- a/common/fdt_support.c
+++ b/common/fdt_support.c
@@ -13,6 +13,9 @@
 #include <mapmem.h>
 #include <net.h>
 #include <stdio_dev.h>
+#include <tpm_api.h>
+#include <dm/device.h>
+#include <dm/uclass.h>
 #include <dm/ofnode.h>
 #include <linux/ctype.h>
 #include <linux/types.h>
@@ -650,6 +653,33 @@ int fdt_fixup_kaslr_seed(ofnode node, const u8 *seed, int len)
 	return 0;
 }
 
+int fdt_tpm_kaslr_seed(ofnode node)
+{
+	u8 rand[8] = {0};
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_first_device_err(UCLASS_TPM, &dev);
+	if (ret) {
+		printf("ERROR: Failed to find TPM device\n");
+		return ret;
+	}
+
+	ret = tpm_get_random(dev, rand, sizeof(rand));
+	if (ret) {
+		printf("ERROR: TPM GetRandom failed, ret=%d\n", ret);
+		return ret;
+	}
+
+	ret = fdt_fixup_kaslr_seed(node, rand, sizeof(rand));
+	if (ret) {
+		printf("ERROR: failed to add kaslr-seed to fdt\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 int fdt_record_loadable(void *blob, u32 index, const char *name,
 			uintptr_t load_addr, u32 size, uintptr_t entry_point,
 			const char *type, const char *os, const char *arch)
diff --git a/include/fdt_support.h b/include/fdt_support.h
index d967118bed..117ca14ca5 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -130,6 +130,14 @@ void fdt_fixup_ethernet(void *fdt);
  */
 int fdt_fixup_kaslr_seed(ofnode node, const u8 *seed, int len);
 
+/*
+ * fdt_add_tpm_kaslr_seed - Add kalsr-seed node in Device tree with random
+ *			    bytes from TPM device
+ * @node:		ofnode
+ * @eret:		0 for success
+ */
+int fdt_tpm_kaslr_seed(ofnode node);
+
 int fdt_find_and_setprop(void *fdt, const char *node, const char *prop,
 			 const void *val, int len, int create);
 void fdt_fixup_qe_firmware(void *fdt);
diff --git a/lib/Kconfig b/lib/Kconfig
index 3926652db6..1530ef7c86 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -465,6 +465,15 @@ config VPL_TPM
 	  for the low-level TPM interface, but only one TPM is supported at
 	  a time by the TPM library.
 
+config KASLR_TPM_SEED
+	bool "Use TPM for KASLR random seed"
+	depends on TPM_V1 || TPM_V2
+	help
+	  This enables support for using TPMs as entropy source for KASLR seed
+	  populated in kernel's device tree. Both TPMv1 and TPMv2 are supported
+	  for the low-level TPM interface, but only one TPM is supported at
+	  a time by the library.
+
 endmenu
 
 menu "Android Verified Boot"
-- 
2.40.0

