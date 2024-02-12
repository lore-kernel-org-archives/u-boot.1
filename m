Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85997C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 07:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B07F887ECA;
	Mon, 12 Feb 2024 08:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B0AF87F03; Mon, 12 Feb 2024 08:48:40 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 49B7187808
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55B3ADA7;
 Sun, 11 Feb 2024 23:49:19 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 898693F762;
 Sun, 11 Feb 2024 23:48:34 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 17/21] tools: mkfwumdata: migrate to metadata version 2
Date: Mon, 12 Feb 2024 13:17:08 +0530
Message-Id: <20240212074712.3657076-18-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
References: <20240212074712.3657076-1-sughosh.ganu@linaro.org>
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

Migrate the metadata generation tool to generate the version 2
metadata.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Changes since V1:
* Compute location of struct fwu_fw_store_desc using pointer
  arithmetic.

 tools/mkfwumdata.c | 45 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
index 9732a8ddc5..fb847e3a78 100644
--- a/tools/mkfwumdata.c
+++ b/tools/mkfwumdata.c
@@ -14,12 +14,13 @@
 #include <unistd.h>
 #include <uuid/uuid.h>
 
-/* This will dynamically allocate the fwu_mdata */
-#define CONFIG_FWU_NUM_BANKS		0
-#define CONFIG_FWU_NUM_IMAGES_PER_BANK	0
-
 /* Since we can not include fwu.h, redefine version here. */
-#define FWU_MDATA_VERSION		1
+#define FWU_MDATA_VERSION		2
+
+#define MAX_BANKS			4
+
+#define BANK_INVALID			0xFF
+#define BANK_ACCEPTED			0xFC
 
 typedef uint8_t u8;
 typedef int16_t s16;
@@ -29,8 +30,6 @@ typedef uint64_t u64;
 
 #include <fwu_mdata.h>
 
-/* TODO: Endianness conversion may be required for some arch. */
-
 static const char *opts_short = "b:i:a:p:gh";
 
 static struct option options[] = {
@@ -48,7 +47,7 @@ static void print_usage(void)
 	fprintf(stderr, "Usage: mkfwumdata [options] <UUIDs list> <output file>\n");
 	fprintf(stderr, "Options:\n"
 		"\t-i, --images <num>          Number of images (mandatory)\n"
-		"\t-b, --banks  <num>          Number of banks (mandatory)\n"
+		"\t-b, --banks  <num>          Number of banks(1-4) (mandatory)\n"
 		"\t-a, --active-bank  <num>    Active bank (default=0)\n"
 		"\t-p, --previous-bank  <num>  Previous active bank (default=active_bank - 1)\n"
 		"\t-g, --guid                  Use GUID instead of UUID\n"
@@ -85,6 +84,7 @@ static struct fwu_mdata_object *fwu_alloc_mdata(size_t images, size_t banks)
 		return NULL;
 
 	mobj->size = sizeof(struct fwu_mdata) +
+		sizeof(struct fwu_fw_store_desc) +
 		(sizeof(struct fwu_image_entry) +
 		 sizeof(struct fwu_image_bank_info) * banks) * images;
 	mobj->images = images;
@@ -105,6 +105,7 @@ fwu_get_image(struct fwu_mdata_object *mobj, size_t idx)
 	size_t offset;
 
 	offset = sizeof(struct fwu_mdata) +
+		sizeof(struct fwu_fw_store_desc) +
 		(sizeof(struct fwu_image_entry) +
 		 sizeof(struct fwu_image_bank_info) * mobj->banks) * idx;
 
@@ -117,6 +118,7 @@ fwu_get_bank(struct fwu_mdata_object *mobj, size_t img_idx, size_t bnk_idx)
 	size_t offset;
 
 	offset = sizeof(struct fwu_mdata) +
+		sizeof(struct fwu_fw_store_desc) +
 		(sizeof(struct fwu_image_entry) +
 		 sizeof(struct fwu_image_bank_info) * mobj->banks) * img_idx +
 		sizeof(struct fwu_image_entry) +
@@ -188,7 +190,7 @@ fwu_parse_fill_image_uuid(struct fwu_mdata_object *mobj,
 		return -EINVAL;
 
 	if (strcmp(uuid, "0") &&
-	    uuid_guid_parse(uuid, (unsigned char *)&image->location_uuid) < 0)
+	    uuid_guid_parse(uuid, (unsigned char *)&image->location_guid) < 0)
 		return -EINVAL;
 
 	/* Image type UUID */
@@ -196,7 +198,7 @@ fwu_parse_fill_image_uuid(struct fwu_mdata_object *mobj,
 	if (!uuid)
 		return -EINVAL;
 
-	if (uuid_guid_parse(uuid, (unsigned char *)&image->image_type_uuid) < 0)
+	if (uuid_guid_parse(uuid, (unsigned char *)&image->image_type_guid) < 0)
 		return -EINVAL;
 
 	/* Fill bank image-UUID */
@@ -210,7 +212,7 @@ fwu_parse_fill_image_uuid(struct fwu_mdata_object *mobj,
 			return -EINVAL;
 
 		if (strcmp(uuid, "0") &&
-		    uuid_guid_parse(uuid, (unsigned char *)&bank->image_uuid) < 0)
+		    uuid_guid_parse(uuid, (unsigned char *)&bank->image_guid) < 0)
 			return -EINVAL;
 	}
 	return 0;
@@ -220,11 +222,26 @@ fwu_parse_fill_image_uuid(struct fwu_mdata_object *mobj,
 static int fwu_parse_fill_uuids(struct fwu_mdata_object *mobj, char *uuids[])
 {
 	struct fwu_mdata *mdata = mobj->mdata;
+	struct fwu_fw_store_desc *fw_desc;
 	int i, ret;
 
 	mdata->version = FWU_MDATA_VERSION;
 	mdata->active_index = active_bank;
 	mdata->previous_active_index = previous_bank;
+	mdata->metadata_size = mobj->size;
+	mdata->desc_offset = sizeof(struct fwu_mdata);
+
+	for (i = 0; i < MAX_BANKS; i++)
+		mdata->bank_state[i] = i < mobj->banks ?
+			BANK_ACCEPTED : BANK_INVALID;
+
+	fw_desc = (struct fwu_fw_store_desc *)((u8 *)mdata + sizeof(*mdata));
+	fw_desc->num_banks = mobj->banks;
+	fw_desc->num_images = mobj->images;
+	fw_desc->img_entry_size = sizeof(struct fwu_image_entry) +
+		(sizeof(struct fwu_image_bank_info) * mobj->banks);
+	fw_desc->bank_info_entry_size =
+		sizeof(struct fwu_image_bank_info);
 
 	for (i = 0; i < mobj->images; i++) {
 		ret = fwu_parse_fill_image_uuid(mobj, i, uuids[i]);
@@ -313,6 +330,12 @@ int main(int argc, char *argv[])
 		return -EINVAL;
 	}
 
+	if (banks > MAX_BANKS) {
+		fprintf(stderr, "Error: The number of banks must not be more than %u.\n",
+			MAX_BANKS);
+		return -EINVAL;
+	}
+
 	/* This command takes UUIDs * images and output file. */
 	if (optind + images + 1 != argc) {
 		fprintf(stderr, "Error: UUID list or output file is not specified or too much.\n");
-- 
2.34.1

