Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C02ECE579
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 11:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E57188DB3;
	Mon,  9 Sep 2024 13:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD99C88DAB; Mon,  9 Sep 2024 13:20:39 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 821F388CBD
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 13:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 935F3FEC;
 Mon,  9 Sep 2024 04:21:05 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3628C3F73B;
 Mon,  9 Sep 2024 04:20:34 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 1/6] fwu: v2: try reading both copies of metadata
Date: Mon,  9 Sep 2024 16:50:16 +0530
Message-Id: <20240909112021.1962801-2-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909112021.1962801-1-sughosh.ganu@linaro.org>
References: <20240909112021.1962801-1-sughosh.ganu@linaro.org>
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

In the version 2 of the FWU metadata, the metadata is broken into two
parts, a top-level structure, which provides information on the total
size of the structure among other things. Try reading the primary
partition first, and if that fails, try reading the secondary
partition. This will help in the scenario where the primary metadata
partition has been corrupted, but the secondary partition is intact.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1:
* Squash patch 1 and 2 in the earlier version into a single patch.
* Have a single check for image descriptor offset, and have a log
  message mention that image descriptor mandatory.
* Use a macro FWU_IMG_DESC_OFFSET for the image descriptor offset.
* Use the enum names for primary and secondary partitions from fwu.h
  instead of defining new macros.

 lib/fwu_updates/fwu_v2.c | 78 +++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/lib/fwu_updates/fwu_v2.c b/lib/fwu_updates/fwu_v2.c
index 108bc9bb4a..a055a207bf 100644
--- a/lib/fwu_updates/fwu_v2.c
+++ b/lib/fwu_updates/fwu_v2.c
@@ -10,6 +10,9 @@
 #include <linux/types.h>
 
 #define FWU_MDATA_VERSION	0x2U
+#define FWU_IMG_DESC_OFFSET	0x20U
+
+static struct fwu_mdata g_mdata;
 
 static inline struct fwu_fw_store_desc *fwu_get_fw_desc(struct fwu_mdata *mdata)
 {
@@ -58,24 +61,6 @@ static int fwu_mdata_sanity_checks(void)
 	struct fwu_data *data = fwu_get_data();
 	struct fwu_mdata *mdata = data->fwu_mdata;
 
-	if (mdata->version != FWU_MDATA_VERSION) {
-		log_err("FWU metadata version %u. Expected value of %u\n",
-			mdata->version, FWU_MDATA_VERSION);
-		return -EINVAL;
-	}
-
-	if (!mdata->desc_offset) {
-		log_err("No image information provided with the Metadata. ");
-		log_err("Image information expected in the metadata\n");
-		return -EINVAL;
-	}
-
-	if (mdata->desc_offset != 0x20) {
-		log_err("Descriptor Offset(0x%x) in the FWU Metadata not equal to 0x20\n",
-			mdata->desc_offset);
-		return -EINVAL;
-	}
-
 	num_banks = fwu_get_fw_desc(mdata)->num_banks;
 	num_images = fwu_get_fw_desc(mdata)->num_images;
 
@@ -127,6 +112,35 @@ static int fwu_trial_state_start(uint update_index)
 	return 0;
 }
 
+static bool fwu_get_mdata_mandatory(uint part)
+{
+	int ret = 0;
+	struct udevice *fwu_dev = fwu_get_dev();
+
+	memset(&g_mdata, 0, sizeof(struct fwu_mdata));
+
+	ret = fwu_read_mdata(fwu_dev, &g_mdata,
+			     part == PRIMARY_PART ? true : false,
+			     sizeof(struct fwu_mdata));
+	if (ret)
+		return false;
+
+	if (g_mdata.version != FWU_MDATA_VERSION) {
+		log_err("FWU partition %u has metadata version %u. Expected value of %u\n",
+			part, g_mdata.version, FWU_MDATA_VERSION);
+		return false;
+	}
+
+	if (g_mdata.desc_offset != FWU_IMG_DESC_OFFSET) {
+		log_err("Descriptor Offset(0x%x) in the FWU Metadata partition %u not equal to 0x20\n",
+			g_mdata.desc_offset, part);
+		log_err("Image information expected in the metadata\n");
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * fwu_populate_mdata_image_info() - Populate the image information
  * of the metadata
@@ -187,24 +201,14 @@ int fwu_state_machine_updates(bool trial_state, uint32_t update_index)
  */
 int fwu_get_mdata_size(uint32_t *mdata_size)
 {
-	int ret = 0;
-	struct fwu_mdata mdata = { 0 };
 	struct fwu_data *data = fwu_get_data();
-	struct udevice *fwu_dev = fwu_get_dev();
 
 	if (data->metadata_size) {
 		*mdata_size = data->metadata_size;
 		return 0;
 	}
 
-	ret = fwu_read_mdata(fwu_dev, &mdata, 1,
-			     sizeof(struct fwu_mdata));
-	if (ret) {
-		log_err("FWU metadata read failed\n");
-		return ret;
-	}
-
-	*mdata_size = mdata.metadata_size;
+	*mdata_size = g_mdata.metadata_size;
 	if (!*mdata_size)
 		return -EINVAL;
 
@@ -224,21 +228,23 @@ int fwu_get_mdata_size(uint32_t *mdata_size)
 int fwu_init(void)
 {
 	int ret;
-	struct fwu_mdata mdata = { 0 };
-	struct udevice *fwu_dev = fwu_get_dev();
 
 	/*
 	 * First we read only the top level structure
 	 * and get the size of the complete structure.
+	 * Try reading the first partition first, if
+	 * that does not work, try the secondary
+	 * partition. The idea is, if one of the
+	 * partitions is corrupted, it should be restored
+	 * from the intact partition.
 	 */
-	ret = fwu_read_mdata(fwu_dev, &mdata, 1,
-			     sizeof(struct fwu_mdata));
-	if (ret) {
+	if (!fwu_get_mdata_mandatory(PRIMARY_PART) &&
+	    !fwu_get_mdata_mandatory(SECONDARY_PART)) {
 		log_err("FWU metadata read failed\n");
-		return ret;
+		return -1;
 	}
 
-	ret = fwu_mdata_copies_allocate(mdata.metadata_size);
+	ret = fwu_mdata_copies_allocate(g_mdata.metadata_size);
 	if (ret)
 		return ret;
 
-- 
2.34.1

