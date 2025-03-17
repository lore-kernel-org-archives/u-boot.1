Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFB4C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 08:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC3BB817EC;
	Mon, 17 Mar 2025 09:34:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBFFB8058A; Mon, 17 Mar 2025 09:34:47 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 32AFB811B2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:34:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 610ED169E;
 Mon, 17 Mar 2025 01:34:53 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F28E53F7B4;
 Mon, 17 Mar 2025 01:34:41 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v9 6/8] blkmap: store type of blkmap slice in corresponding
 structure
Date: Mon, 17 Mar 2025 14:04:00 +0530
Message-Id: <20250317083402.412310-7-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250317083402.412310-1-sughosh.ganu@linaro.org>
References: <20250317083402.412310-1-sughosh.ganu@linaro.org>
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

Add information about the type of blkmap slices as an attribute in the
corresponding slice structure. Put information in the blkmap slice
structure to identify if it is associated with a memory or linear
mapped device. Which can then be used to take specific action based on
the type of the blkmap slice.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Tobias Waldekranz <tobias@waldekranz.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since V8:
* s/blkmap slice/blkmap slices/ in the commit message
* Add comments to the macros added in the patch

 drivers/block/blkmap.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
index 34eed1380dc..08f68570224 100644
--- a/drivers/block/blkmap.c
+++ b/drivers/block/blkmap.c
@@ -16,6 +16,22 @@
 
 struct blkmap;
 
+/**
+ * define BLKMAP_SLICE_LINEAR - Linear mapping to another block device
+ *
+ * This blkmap slice type is used for mapping to other existing block
+ * devices.
+ */
+#define BLKMAP_SLICE_LINEAR	BIT(0)
+
+/**
+ * define BLKMAP_SLICE_MEM - Linear mapping to memory based block device
+ *
+ * This blkmap slice type is used for mapping to memory based block
+ * devices, like ramdisks.
+ */
+#define BLKMAP_SLICE_MEM	BIT(1)
+
 /**
  * struct blkmap_slice - Region mapped to a blkmap
  *
@@ -25,12 +41,14 @@ struct blkmap;
  * @node: List node used to associate this slice with a blkmap
  * @blknr: Start block number of the mapping
  * @blkcnt: Number of blocks covered by this mapping
+ * @attr: Attributes of blkmap slice
  */
 struct blkmap_slice {
 	struct list_head node;
 
 	lbaint_t blknr;
 	lbaint_t blkcnt;
+	uint     attr;
 
 	/**
 	 * @read: - Read from slice
@@ -169,6 +187,7 @@ int blkmap_map_linear(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 		.slice = {
 			.blknr = blknr,
 			.blkcnt = blkcnt,
+			.attr = BLKMAP_SLICE_LINEAR,
 
 			.read = blkmap_linear_read,
 			.write = blkmap_linear_write,
@@ -248,6 +267,7 @@ int __blkmap_map_mem(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 		.slice = {
 			.blknr = blknr,
 			.blkcnt = blkcnt,
+			.attr = BLKMAP_SLICE_MEM,
 
 			.read = blkmap_mem_read,
 			.write = blkmap_mem_write,
-- 
2.34.1

