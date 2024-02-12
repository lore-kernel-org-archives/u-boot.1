Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BEAC48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 07:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C57487F14;
	Mon, 12 Feb 2024 08:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D31F87F0C; Mon, 12 Feb 2024 08:48:44 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0C4C487EF9
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:48:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18F2EDA7;
 Sun, 11 Feb 2024 23:49:23 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C23E3F762;
 Sun, 11 Feb 2024 23:48:38 -0800 (PST)
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
Subject: [PATCH v2 18/21] tools: mkfwumdata: add logic to append vendor data
 to the FWU metadata
Date: Mon, 12 Feb 2024 13:17:09 +0530
Message-Id: <20240212074712.3657076-19-sughosh.ganu@linaro.org>
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

The version 2 of the FWU metadata allows for appending opaque vendor
specific data to the metadata structure. Add support for appending
this data to the metadata. The vendor specific data needs to be
provided through a file, passed through a command-line parameter.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---

Changes since V1: New patch

 tools/mkfwumdata.c | 85 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 8 deletions(-)

diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
index fb847e3a78..ab07623e25 100644
--- a/tools/mkfwumdata.c
+++ b/tools/mkfwumdata.c
@@ -12,6 +12,8 @@
 #include <string.h>
 #include <u-boot/crc.h>
 #include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
 #include <uuid/uuid.h>
 
 /* Since we can not include fwu.h, redefine version here. */
@@ -30,7 +32,7 @@ typedef uint64_t u64;
 
 #include <fwu_mdata.h>
 
-static const char *opts_short = "b:i:a:p:gh";
+static const char *opts_short = "b:i:a:p:v:gh";
 
 static struct option options[] = {
 	{"banks", required_argument, NULL, 'b'},
@@ -38,6 +40,7 @@ static struct option options[] = {
 	{"guid", required_argument, NULL, 'g'},
 	{"active-bank", required_argument, NULL, 'a'},
 	{"previous-bank", required_argument, NULL, 'p'},
+	{"vendor-file", required_argument, NULL, 'v'},
 	{"help", no_argument, NULL, 'h'},
 	{NULL, 0, NULL, 0},
 };
@@ -51,6 +54,7 @@ static void print_usage(void)
 		"\t-a, --active-bank  <num>    Active bank (default=0)\n"
 		"\t-p, --previous-bank  <num>  Previous active bank (default=active_bank - 1)\n"
 		"\t-g, --guid                  Use GUID instead of UUID\n"
+		"\t-v, --vendor-file           Vendor data file to append to the metadata\n"
 		"\t-h, --help                  print a help message\n"
 		);
 	fprintf(stderr, "  UUIDs list syntax:\n"
@@ -69,13 +73,16 @@ struct fwu_mdata_object {
 	size_t images;
 	size_t banks;
 	size_t size;
+	size_t vsize;
+	void *vbuf;
 	struct fwu_mdata *mdata;
 };
 
 static int previous_bank, active_bank;
 static bool __use_guid;
 
-static struct fwu_mdata_object *fwu_alloc_mdata(size_t images, size_t banks)
+static struct fwu_mdata_object *fwu_alloc_mdata(size_t images, size_t banks,
+						size_t vendor_size)
 {
 	struct fwu_mdata_object *mobj;
 
@@ -87,16 +94,28 @@ static struct fwu_mdata_object *fwu_alloc_mdata(size_t images, size_t banks)
 		sizeof(struct fwu_fw_store_desc) +
 		(sizeof(struct fwu_image_entry) +
 		 sizeof(struct fwu_image_bank_info) * banks) * images;
+
+	mobj->size += vendor_size;
+	mobj->vsize = vendor_size;
 	mobj->images = images;
 	mobj->banks = banks;
 
 	mobj->mdata = calloc(1, mobj->size);
-	if (!mobj->mdata) {
-		free(mobj);
-		return NULL;
+	if (!mobj->mdata)
+		goto alloc_err;
+
+	if (vendor_size) {
+		mobj->vbuf = calloc(1, mobj->vsize);
+		if (!mobj->vbuf)
+			goto alloc_err;
 	}
 
 	return mobj;
+
+alloc_err:
+	free(mobj->mdata);
+	free(mobj);
+	return NULL;
 }
 
 static struct fwu_image_entry *
@@ -223,6 +242,7 @@ static int fwu_parse_fill_uuids(struct fwu_mdata_object *mobj, char *uuids[])
 {
 	struct fwu_mdata *mdata = mobj->mdata;
 	struct fwu_fw_store_desc *fw_desc;
+	char *vdata;
 	int i, ret;
 
 	mdata->version = FWU_MDATA_VERSION;
@@ -249,23 +269,65 @@ static int fwu_parse_fill_uuids(struct fwu_mdata_object *mobj, char *uuids[])
 			return ret;
 	}
 
+	if (mobj->vsize) {
+		vdata = (char *)mobj->mdata + (mobj->size - mobj->vsize);
+		memcpy(vdata, mobj->vbuf, mobj->vsize);
+	}
+
 	mdata->crc32 = crc32(0, (const unsigned char *)&mdata->version,
 			     mobj->size - sizeof(uint32_t));
 
 	return 0;
 }
 
+static int fwu_read_vendor_data(struct fwu_mdata_object *mobj,
+				const char *vendor_file)
+{
+	int ret = 0;
+	FILE *vfile = NULL;
+
+	vfile = fopen(vendor_file, "r");
+	if (!vfile) {
+		ret = -1;
+		goto out;
+	}
+
+	if (fread(mobj->vbuf, 1, mobj->vsize, vfile) != mobj->vsize)
+		ret = -1;
+
+out:
+	fclose(vfile);
+	return ret;
+}
+
 static int
-fwu_make_mdata(size_t images, size_t banks, char *uuids[], char *output)
+fwu_make_mdata(size_t images, size_t banks, const char *vendor_file,
+	       char *uuids[], char *output)
 {
 	struct fwu_mdata_object *mobj;
 	FILE *file;
+	struct stat sbuf;
+	size_t vendor_size = 0;
 	int ret;
 
-	mobj = fwu_alloc_mdata(images, banks);
+	if (vendor_file) {
+		ret = stat(vendor_file, &sbuf);
+		if (ret)
+			return -errno;
+
+		vendor_size = sbuf.st_size;
+	}
+
+	mobj = fwu_alloc_mdata(images, banks, vendor_size);
 	if (!mobj)
 		return -ENOMEM;
 
+	if (vendor_file) {
+		ret = fwu_read_vendor_data(mobj, vendor_file);
+		if (ret)
+			goto done_make;
+	}
+
 	ret = fwu_parse_fill_uuids(mobj, uuids);
 	if (ret < 0)
 		goto done_make;
@@ -286,6 +348,7 @@ fwu_make_mdata(size_t images, size_t banks, char *uuids[], char *output)
 
 done_make:
 	free(mobj->mdata);
+	free(mobj->vbuf);
 	free(mobj);
 
 	return ret;
@@ -295,11 +358,13 @@ int main(int argc, char *argv[])
 {
 	unsigned long banks = 0, images = 0;
 	int c, ret;
+	const char *vendor_file;
 
 	/* Explicitly initialize defaults */
 	active_bank = 0;
 	__use_guid = false;
 	previous_bank = INT_MAX;
+	vendor_file = NULL;
 
 	do {
 		c = getopt_long(argc, argv, opts_short, options, NULL);
@@ -322,6 +387,9 @@ int main(int argc, char *argv[])
 		case 'a':
 			active_bank = strtoul(optarg, NULL, 0);
 			break;
+		case 'v':
+			vendor_file = optarg;
+			break;
 		}
 	} while (c != -1);
 
@@ -348,7 +416,8 @@ int main(int argc, char *argv[])
 		previous_bank = active_bank > 0 ? active_bank - 1 : banks - 1;
 	}
 
-	ret = fwu_make_mdata(images, banks, argv + optind, argv[argc - 1]);
+	ret = fwu_make_mdata(images, banks, vendor_file, argv + optind,
+			     argv[argc - 1]);
 	if (ret < 0)
 		fprintf(stderr, "Error: Failed to parse and write image: %s\n",
 			strerror(-ret));
-- 
2.34.1

