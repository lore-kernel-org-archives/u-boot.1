Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC302C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 00:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18315876B2;
	Fri,  1 Dec 2023 01:55:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43CA487729; Fri,  1 Dec 2023 01:55:23 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id DCE4087608
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 01:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=microsoft.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=seanedmond@microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id DD1A720B74C1;
 Thu, 30 Nov 2023 16:55:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DD1A720B74C1
From: Sean Edmond <seanedmond@microsoft.com>
To: u-boot@lists.denx.de
Cc: Dhananjay Phadke <dphadke@linux.microsoft.com>,
 Sean Edmond <senaedmond@microsoft.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 1/5] fdt: common API to populate kaslr seed
Date: Thu, 30 Nov 2023 16:54:40 -0800
Message-ID: <20231201005507.2080396-2-seanedmond@microsoft.com>
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

fdt_fixup_kaslr_seed() will update given ofnode with random seed value.
Source for random seed can be TPM or RNG driver in u-boot or sec
firmware (ARM).

Signed-off-by: Dhananjay Phadke <dphadke@linux.microsoft.com>
Signed-off-by: Sean Edmond <senaedmond@microsoft.com>

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---

Changes in v6:
- root_ofnode_from_fdt()->ofnode_root_from_fdt()

Changes in v5:
- include dm/ofnode-decl.h instead of dm/ofnode.h

Changes in v3:
- Use event spy to do the FDT fixup

Changes in v2:
- fdt_fixup_kaslr_seed() uses the ofnode API
- Add root_ofnode_from_fdt() to get the root node from an FDT and
  perform error checking on the oftree
- add comments to exported functions

 arch/arm/cpu/armv8/sec_firmware.c | 39 +++++++++++--------------------
 boot/fdt_support.c                | 19 +++++++++++++++
 drivers/core/ofnode.c             | 17 ++++++++++++++
 include/dm/ofnode.h               | 12 ++++++++++
 include/fdt_support.h             |  9 +++++++
 5 files changed, 71 insertions(+), 25 deletions(-)

diff --git a/arch/arm/cpu/armv8/sec_firmware.c b/arch/arm/cpu/armv8/sec_firmware.c
index c0e8726346f..5f256939277 100644
--- a/arch/arm/cpu/armv8/sec_firmware.c
+++ b/arch/arm/cpu/armv8/sec_firmware.c
@@ -411,46 +411,35 @@ int sec_firmware_init(const void *sec_firmware_img,
 /*
  * fdt_fix_kaslr - Add kalsr-seed node in Device tree
  * @fdt:		Device tree
- * @eret:		0 in case of error, 1 for success
+ * @eret:		0 for success
  */
 int fdt_fixup_kaslr(void *fdt)
 {
-	int nodeoffset;
-	int err, ret = 0;
-	u8 rand[8];
+	int ret = 0;
 
 #if defined(CONFIG_ARMV8_SEC_FIRMWARE_SUPPORT)
+	u8 rand[8];
+	ofnode root;
+
 	/* Check if random seed generation is  supported */
 	if (sec_firmware_support_hwrng() == false) {
 		printf("WARNING: SEC firmware not running, no kaslr-seed\n");
-		return 0;
+		return -EOPNOTSUPP;
 	}
 
-	err = sec_firmware_get_random(rand, 8);
-	if (err < 0) {
+	ret = sec_firmware_get_random(rand, 8);
+	if (ret < 0) {
 		printf("WARNING: No random number to set kaslr-seed\n");
-		return 0;
+		return ret;
 	}
 
-	err = fdt_check_header(fdt);
-	if (err < 0) {
-		printf("fdt_chosen: %s\n", fdt_strerror(err));
-		return 0;
+	ret = ofnode_root_from_fdt(fdt, &root);
+	if (ret < 0) {
+		printf("WARNING: Unable to get root ofnode\n");
+		return ret;
 	}
 
-	/* find or create "/chosen" node. */
-	nodeoffset = fdt_find_or_add_subnode(fdt, 0, "chosen");
-	if (nodeoffset < 0)
-		return 0;
-
-	err = fdt_setprop(fdt, nodeoffset, "kaslr-seed", rand,
-				  sizeof(rand));
-	if (err < 0) {
-		printf("WARNING: can't set kaslr-seed %s.\n",
-		       fdt_strerror(err));
-		return 0;
-	}
-	ret = 1;
+	ret = fdt_fixup_kaslr_seed(root, rand, sizeof(rand));
 #endif
 
 	return ret;
diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index b15d07765fe..49d14a949be 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -631,6 +631,25 @@ void fdt_fixup_ethernet(void *fdt)
 	}
 }
 
+int fdt_fixup_kaslr_seed(ofnode node, const u8 *seed, int len)
+{
+	ofnode chosen;
+	int ret;
+
+	/* find or create "/chosen" node. */
+	ret = ofnode_add_subnode(node, "chosen", &chosen);
+	if (ret && ret != -EEXIST)
+		return -ENOENT;
+
+	ret = ofnode_write_prop(chosen, "kaslr-seed", seed, len, true);
+	if (ret) {
+		printf("WARNING: can't set kaslr-seed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 int fdt_record_loadable(void *blob, u32 index, const char *name,
 			uintptr_t load_addr, u32 size, uintptr_t entry_point,
 			const char *type, const char *os, const char *arch)
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index f72ea416cf1..557a4a1b969 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -966,6 +966,23 @@ ofnode oftree_path(oftree tree, const char *path)
 	}
 }
 
+int ofnode_root_from_fdt(void *fdt, ofnode *root_node)
+{
+	oftree tree;
+	/* If OFNODE_MULTI_TREE is not set, and if fdt is not the control FDT,
+	 *  oftree_from_fdt() will return NULL
+	 */
+	tree = oftree_from_fdt(fdt);
+
+	if (!oftree_valid(tree)) {
+		printf("Cannot create oftree\n");
+		return -EINVAL;
+	}
+	*root_node = oftree_root(tree);
+
+	return 0;
+}
+
 const void *ofnode_read_chosen_prop(const char *propname, int *sizep)
 {
 	ofnode chosen_node;
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 5795115c490..b3bb133df19 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -936,6 +936,18 @@ ofnode oftree_path(oftree tree, const char *path);
  */
 ofnode oftree_root(oftree tree);
 
+/**
+ * ofnode_root_from_fdt() - Gets the root ofnode given an FDT blob.
+ *                          Note, this will fail if OFNODE_MULTI_TREE
+ *                          is not set.
+ *
+ * @fdt: Device tree to use
+ * @root_node : Root ofnode
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int ofnode_root_from_fdt(void *fdt, ofnode *root_node);
+
 /**
  * ofnode_read_chosen_prop() - get the value of a chosen property
  *
diff --git a/include/fdt_support.h b/include/fdt_support.h
index 2cd83668982..0624650dcee 100644
--- a/include/fdt_support.h
+++ b/include/fdt_support.h
@@ -11,6 +11,7 @@
 	!defined(USE_HOSTCC)
 
 #include <asm/u-boot.h>
+#include <dm/ofnode_decl.h>
 #include <linux/libfdt.h>
 #include <abuf.h>
 
@@ -121,6 +122,14 @@ static inline int fdt_fixup_memory_banks(void *blob, u64 start[], u64 size[],
 #endif
 
 void fdt_fixup_ethernet(void *fdt);
+
+/*
+ * fdt_fixup_kaslr_seed - Add kaslr-seed node in Device tree
+ * @node:		ofnode
+ * @eret:		0 for success
+ */
+int fdt_fixup_kaslr_seed(ofnode node, const u8 *seed, int len);
+
 int fdt_find_and_setprop(void *fdt, const char *node, const char *prop,
 			 const void *val, int len, int create);
 void fdt_fixup_qe_firmware(void *fdt);
-- 
2.42.0

