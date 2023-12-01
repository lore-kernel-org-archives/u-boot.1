Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E6DC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 00:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E1868772B;
	Fri,  1 Dec 2023 01:55:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6707A87719; Fri,  1 Dec 2023 01:55:25 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 72D26876B2
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 01:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=microsoft.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=seanedmond@microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 7CDD420B74C2;
 Thu, 30 Nov 2023 16:55:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7CDD420B74C2
From: Sean Edmond <seanedmond@microsoft.com>
To: u-boot@lists.denx.de
Cc: Dhananjay Phadke <dphadke@linux.microsoft.com>,
 Drew Kluemke <ankluemk@microsoft.com>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Brandon Maier <brandon.maier@collins.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH v6 2/5] fdt: kaslr seed from RNG device
Date: Thu, 30 Nov 2023 16:54:41 -0800
Message-ID: <20231201005507.2080396-3-seanedmond@microsoft.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201005507.2080396-1-seanedmond@microsoft.com>
References: <20231201005507.2080396-1-seanedmond@microsoft.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>

BAH

---

Changes in v6:
- Enclose fdt_rng_kaslr_seed() in "#if defined(CONFIG_KASLR_RNG_SEED)"

Changes in v3:
- Populate with RNG device instead of TPM device (this is a more generic solution)

Changes in v2:
- Add error checking in image_setup_libfdt() for return from
  fdt_tpm_kaslr_seed()
- uclass_get_device() -> uclass_first_device_err()

 boot/fdt_support.c        | 35 +++++++++++++++++++++++++++++++++++
 configs/sandbox_defconfig |  2 +-
 lib/Kconfig               |  7 +++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 49d14a949be..b51154f83a5 100644
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
@@ -650,6 +653,38 @@ int fdt_fixup_kaslr_seed(ofnode node, const u8 *seed, int len)
 	return 0;
 }
 
+#if defined(CONFIG_KASLR_RNG_SEED)
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
+EVENT_SPY_FULL(EVT_FT_FIXUP, fdt_rng_kaslr_seed);
+#endif
+
 int fdt_record_loadable(void *blob, u32 index, const char *name,
 			uintptr_t load_addr, u32 size, uintptr_t entry_point,
 			const char *type, const char *os, const char *arch)
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index bc5bcb2a623..b71790e1532 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -348,4 +348,4 @@ CONFIG_EFI_SECURE_BOOT=y
 CONFIG_TEST_FDTDEC=y
 CONFIG_UNIT_TEST=y
 CONFIG_UT_TIME=y
-CONFIG_UT_DM=y
+CONFIG_UT_DM=y
\ No newline at end of file
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

