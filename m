Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4F3C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4453C8820C;
	Fri, 22 Mar 2024 11:59:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21B75881FF; Fri, 22 Mar 2024 11:59:08 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id ADFAB881D7
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C2071063;
 Fri, 22 Mar 2024 03:59:34 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31A1B3F64C;
 Fri, 22 Mar 2024 03:58:56 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Yann GAUTIER <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Patrick DELAUNAY - foss <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Michal Simek <monstr@monstr.eu>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 15/20] tools: mkfwumdata: add support for metadata version 2
Date: Fri, 22 Mar 2024 16:27:28 +0530
Message-Id: <20240322105733.203888-16-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322105733.203888-1-sughosh.ganu@linaro.org>
References: <20240322105733.203888-1-sughosh.ganu@linaro.org>
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

Add support for generating the FWU metadata version 2. The tool now
requires the version to be provided as a command-line option. Make
corresponding changes to the tool's manpage.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2:
* Support both metadata versions instead of only v2.

 doc/mkfwumdata.1   |   9 ++-
 tools/mkfwumdata.c | 148 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 127 insertions(+), 30 deletions(-)

diff --git a/doc/mkfwumdata.1 b/doc/mkfwumdata.1
index 7dd718b26e..5e61c615ea 100644
--- a/doc/mkfwumdata.1
+++ b/doc/mkfwumdata.1
@@ -6,6 +6,7 @@ mkfwumdata \- create FWU metadata image
 .
 .SH SYNOPSIS
 .SY mkfwumdata
+.OP \-v version
 .OP \-a activeidx
 .OP \-p previousidx
 .OP \-g
@@ -28,6 +29,12 @@ creates metadata info to be used with FWU.
 Print usage information and exit.
 .
 .TP
+.B \-v
+Set 
+.IR version
+as the metadata version to generate. Valid values 1 or 2.
+.
+.TP
 .B \-a
 Set 
 .IR activeidx
@@ -81,7 +88,7 @@ Create a metadata image with 2 banks and 1 image/bank, BankAct=0, BankPrev=1:
 .EX
 .in +4
 $ \c
-.B mkfwumdata \-a 0 \-p 1 \-b 2 \-i 1 \\\\\&
+.B mkfwumdata \-v 2 \-a 0 \-p 1 \-b 2 \-i 1 \\\\\&
 .in +6
 .B 17e86d77-41f9-4fd7-87ec-a55df9842de5,\\\\\&
 .B 10c36d7d-ca52-b843-b7b9-f9d6c501d108,\\\\\&
diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
index b2d90ca7c9..634453d421 100644
--- a/tools/mkfwumdata.c
+++ b/tools/mkfwumdata.c
@@ -10,28 +10,35 @@
 #include <stdint.h>
 #include <stdlib.h>
 #include <string.h>
-#include <u-boot/crc.h>
 #include <unistd.h>
+#include <generated/autoconf.h>
+#include <u-boot/crc.h>
 #include <uuid/uuid.h>
 
-/* This will dynamically allocate the fwu_mdata */
-#define CONFIG_FWU_NUM_BANKS		0
-#define CONFIG_FWU_NUM_IMAGES_PER_BANK	0
-
-/* Since we can not include fwu.h, redefine version here. */
-#define FWU_MDATA_VERSION		1
-
 typedef uint8_t u8;
 typedef int16_t s16;
 typedef uint16_t u16;
 typedef uint32_t u32;
 typedef uint64_t u64;
 
+#undef CONFIG_FWU_NUM_BANKS
+#undef CONFIG_FWU_NUM_IMAGES_PER_BANK
+
+/* This will dynamically allocate the fwu_mdata */
+#define CONFIG_FWU_NUM_BANKS		0
+#define CONFIG_FWU_NUM_IMAGES_PER_BANK	0
+
+/* version 2 supports maximum of 4 banks */
+#define MAX_BANKS_V2			4
+
+#define BANK_INVALID			(u8)0xFF
+#define BANK_ACCEPTED			(u8)0xFC
+
 #include <fwu_mdata.h>
 
 /* TODO: Endianness conversion may be required for some arch. */
 
-static const char *opts_short = "b:i:a:p:gh";
+static const char *opts_short = "b:i:a:p:v:gh";
 
 static struct option options[] = {
 	{"banks", required_argument, NULL, 'b'},
@@ -39,6 +46,7 @@ static struct option options[] = {
 	{"guid", required_argument, NULL, 'g'},
 	{"active-bank", required_argument, NULL, 'a'},
 	{"previous-bank", required_argument, NULL, 'p'},
+	{"version", required_argument, NULL, 'v'},
 	{"help", no_argument, NULL, 'h'},
 	{NULL, 0, NULL, 0},
 };
@@ -49,6 +57,7 @@ static void print_usage(void)
 	fprintf(stderr, "Options:\n"
 		"\t-i, --images <num>          Number of images (mandatory)\n"
 		"\t-b, --banks  <num>          Number of banks (mandatory)\n"
+		"\t-v, --version               Metadata version (mandatory)\n"
 		"\t-a, --active-bank  <num>    Active bank (default=0)\n"
 		"\t-p, --previous-bank  <num>  Previous active bank (default=active_bank - 1)\n"
 		"\t-g, --guid                  Use GUID instead of UUID\n"
@@ -70,13 +79,26 @@ struct fwu_mdata_object {
 	size_t images;
 	size_t banks;
 	size_t size;
+	u8 version;
 	struct fwu_mdata *mdata;
 };
 
 static int previous_bank, active_bank;
 static bool __use_guid;
 
-static struct fwu_mdata_object *fwu_alloc_mdata(size_t images, size_t banks)
+static bool supported_mdata_version(unsigned long version)
+{
+	switch (version) {
+	case 1:
+	case 2:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static struct fwu_mdata_object *fwu_alloc_mdata(size_t images, size_t banks,
+						u8 version)
 {
 	struct fwu_mdata_object *mobj;
 
@@ -84,11 +106,20 @@ static struct fwu_mdata_object *fwu_alloc_mdata(size_t images, size_t banks)
 	if (!mobj)
 		return NULL;
 
-	mobj->size = sizeof(struct fwu_mdata) +
-		(sizeof(struct fwu_image_entry) +
-		 sizeof(struct fwu_image_bank_info) * banks) * images;
+	if (version == 1) {
+		mobj->size = sizeof(struct fwu_mdata) +
+			(sizeof(struct fwu_image_entry) +
+			 sizeof(struct fwu_image_bank_info) * banks) * images;
+	} else {
+		mobj->size = sizeof(struct fwu_mdata) +
+			sizeof(struct fwu_fw_store_desc) +
+			(sizeof(struct fwu_image_entry) +
+			 sizeof(struct fwu_image_bank_info) * banks) * images;
+	}
+
 	mobj->images = images;
 	mobj->banks = banks;
+	mobj->version = version;
 
 	mobj->mdata = calloc(1, mobj->size);
 	if (!mobj->mdata) {
@@ -104,9 +135,18 @@ fwu_get_image(struct fwu_mdata_object *mobj, size_t idx)
 {
 	size_t offset;
 
-	offset = sizeof(struct fwu_mdata) +
-		(sizeof(struct fwu_image_entry) +
-		 sizeof(struct fwu_image_bank_info) * mobj->banks) * idx;
+	if (mobj->version == 1) {
+		offset = sizeof(struct fwu_mdata) +
+			(sizeof(struct fwu_image_entry) +
+			 sizeof(struct fwu_image_bank_info) * mobj->banks) *
+			idx;
+	} else {
+		offset = sizeof(struct fwu_mdata) +
+			sizeof(struct fwu_fw_store_desc) +
+			(sizeof(struct fwu_image_entry) +
+			 sizeof(struct fwu_image_bank_info) * mobj->banks) *
+			idx;
+	}
 
 	return (struct fwu_image_entry *)((char *)mobj->mdata + offset);
 }
@@ -116,11 +156,20 @@ fwu_get_bank(struct fwu_mdata_object *mobj, size_t img_idx, size_t bnk_idx)
 {
 	size_t offset;
 
-	offset = sizeof(struct fwu_mdata) +
-		(sizeof(struct fwu_image_entry) +
-		 sizeof(struct fwu_image_bank_info) * mobj->banks) * img_idx +
-		sizeof(struct fwu_image_entry) +
-		sizeof(struct fwu_image_bank_info) * bnk_idx;
+	if (mobj->version == 1) {
+		offset = sizeof(struct fwu_mdata) +
+			(sizeof(struct fwu_image_entry) +
+			 sizeof(struct fwu_image_bank_info) * mobj->banks) *
+			img_idx + sizeof(struct fwu_image_entry) +
+			sizeof(struct fwu_image_bank_info) * bnk_idx;
+	} else {
+		offset = sizeof(struct fwu_mdata) +
+			sizeof(struct fwu_fw_store_desc) +
+			(sizeof(struct fwu_image_entry) +
+			 sizeof(struct fwu_image_bank_info) * mobj->banks) *
+			img_idx + sizeof(struct fwu_image_entry) +
+			sizeof(struct fwu_image_bank_info) * bnk_idx;
+	}
 
 	return (struct fwu_image_bank_info *)((char *)mobj->mdata + offset);
 }
@@ -188,7 +237,7 @@ fwu_parse_fill_image_uuid(struct fwu_mdata_object *mobj,
 		return -EINVAL;
 
 	if (strcmp(uuid, "0") &&
-	    uuid_guid_parse(uuid, (unsigned char *)&image->location_uuid) < 0)
+	    uuid_guid_parse(uuid, (unsigned char *)&image->location_guid) < 0)
 		return -EINVAL;
 
 	/* Image type UUID */
@@ -196,7 +245,7 @@ fwu_parse_fill_image_uuid(struct fwu_mdata_object *mobj,
 	if (!uuid)
 		return -EINVAL;
 
-	if (uuid_guid_parse(uuid, (unsigned char *)&image->image_type_uuid) < 0)
+	if (uuid_guid_parse(uuid, (unsigned char *)&image->image_type_guid) < 0)
 		return -EINVAL;
 
 	/* Fill bank image-UUID */
@@ -210,22 +259,52 @@ fwu_parse_fill_image_uuid(struct fwu_mdata_object *mobj,
 			return -EINVAL;
 
 		if (strcmp(uuid, "0") &&
-		    uuid_guid_parse(uuid, (unsigned char *)&bank->image_uuid) < 0)
+		    uuid_guid_parse(uuid, (unsigned char *)&bank->image_guid) < 0)
 			return -EINVAL;
 	}
 	return 0;
 }
 
+#if defined(CONFIG_FWU_MDATA_V1)
+static void fwu_fill_version_specific_mdata(struct fwu_mdata_object *mobj)
+{
+}
+#else
+static void fwu_fill_version_specific_mdata(struct fwu_mdata_object *mobj)
+{
+	int i;
+	struct fwu_fw_store_desc *fw_desc;
+	struct fwu_mdata *mdata = mobj->mdata;
+
+	mdata->metadata_size = mobj->size;
+	mdata->desc_offset = sizeof(struct fwu_mdata);
+
+	for (i = 0; i < MAX_BANKS_V2; i++)
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
+}
+#endif /* CONFIG_FWU_MDATA_V1 */
+
 /* Caller must ensure that @uuids[] has @mobj->images entries. */
 static int fwu_parse_fill_uuids(struct fwu_mdata_object *mobj, char *uuids[])
 {
 	struct fwu_mdata *mdata = mobj->mdata;
 	int i, ret;
 
-	mdata->version = FWU_MDATA_VERSION;
+	mdata->version = mobj->version;
 	mdata->active_index = active_bank;
 	mdata->previous_active_index = previous_bank;
 
+	fwu_fill_version_specific_mdata(mobj);
+
 	for (i = 0; i < mobj->images; i++) {
 		ret = fwu_parse_fill_image_uuid(mobj, i, uuids[i]);
 		if (ret < 0)
@@ -239,13 +318,14 @@ static int fwu_parse_fill_uuids(struct fwu_mdata_object *mobj, char *uuids[])
 }
 
 static int
-fwu_make_mdata(size_t images, size_t banks, char *uuids[], char *output)
+fwu_make_mdata(size_t images, size_t banks, u8 version, char *uuids[],
+	       char *output)
 {
 	struct fwu_mdata_object *mobj;
 	FILE *file;
 	int ret;
 
-	mobj = fwu_alloc_mdata(images, banks);
+	mobj = fwu_alloc_mdata(images, banks, version);
 	if (!mobj)
 		return -ENOMEM;
 
@@ -276,7 +356,7 @@ done_make:
 
 int main(int argc, char *argv[])
 {
-	unsigned long banks = 0, images = 0;
+	unsigned long banks = 0, images = 0, version = 0;
 	int c, ret;
 
 	/* Explicitly initialize defaults */
@@ -305,6 +385,9 @@ int main(int argc, char *argv[])
 		case 'a':
 			active_bank = strtoul(optarg, NULL, 0);
 			break;
+		case 'v':
+			version = strtoul(optarg, NULL, 0);
+			break;
 		}
 	} while (c != -1);
 
@@ -313,6 +396,12 @@ int main(int argc, char *argv[])
 		return -EINVAL;
 	}
 
+	if (!version || !supported_mdata_version(version)) {
+		fprintf(stderr, "Error: Version value can only be either 1 or 2, not %ld.\n",
+			version);
+		return -EINVAL;
+	}
+
 	/* This command takes UUIDs * images and output file. */
 	if (optind + images + 1 != argc) {
 		fprintf(stderr, "Error: UUID list or output file is not specified or too much.\n");
@@ -325,7 +414,8 @@ int main(int argc, char *argv[])
 		previous_bank = active_bank > 0 ? active_bank - 1 : banks - 1;
 	}
 
-	ret = fwu_make_mdata(images, banks, argv + optind, argv[argc - 1]);
+	ret = fwu_make_mdata(images, banks, (u8)version, argv + optind,
+			     argv[argc - 1]);
 	if (ret < 0)
 		fprintf(stderr, "Error: Failed to parse and write image: %s\n",
 			strerror(-ret));
-- 
2.34.1

