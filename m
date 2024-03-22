Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7CDC47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8220288208;
	Fri, 22 Mar 2024 11:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F1788820F; Fri, 22 Mar 2024 11:59:10 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3C68B8817E
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:59:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7F891007;
 Fri, 22 Mar 2024 03:59:37 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC7373F64C;
 Fri, 22 Mar 2024 03:59:00 -0700 (PDT)
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
Subject: [PATCH v3 16/20] tools: mkfwumdata: add logic to append vendor data
 to the FWU metadata
Date: Fri, 22 Mar 2024 16:27:29 +0530
Message-Id: <20240322105733.203888-17-sughosh.ganu@linaro.org>
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

The version 2 of the FWU metadata allows for appending opaque vendor
specific data to the metadata structure. Add support for appending
this data to the metadata. The vendor specific data needs to be
provided through a file, passed through a command-line parameter. Make
corresponding changes to the tool's manpage.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2:
* Added documentation changes.

 doc/mkfwumdata.1   |  7 ++++
 tools/mkfwumdata.c | 99 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 91 insertions(+), 15 deletions(-)

diff --git a/doc/mkfwumdata.1 b/doc/mkfwumdata.1
index 5e61c615ea..2ed0fb100b 100644
--- a/doc/mkfwumdata.1
+++ b/doc/mkfwumdata.1
@@ -10,6 +10,7 @@ mkfwumdata \- create FWU metadata image
 .OP \-a activeidx
 .OP \-p previousidx
 .OP \-g
+.OP \-V vendor-file
 .BI \-i\~ imagecount
 .BI \-b\~ bankcount
 .I UUIDs
@@ -57,6 +58,12 @@ Convert the
 as GUIDs before use.
 .
 .TP
+.B \-V
+Pass
+.IR vendor-file
+for appending vendor data to the metadata. Supported only with version 2.
+.
+.TP
 .B \-i
 Specify there are
 .IR imagecount
diff --git a/tools/mkfwumdata.c b/tools/mkfwumdata.c
index 634453d421..fbc2067bc1 100644
--- a/tools/mkfwumdata.c
+++ b/tools/mkfwumdata.c
@@ -12,6 +12,8 @@
 #include <string.h>
 #include <unistd.h>
 #include <generated/autoconf.h>
+#include <sys/types.h>
+#include <sys/stat.h>
 #include <u-boot/crc.h>
 #include <uuid/uuid.h>
 
@@ -36,9 +38,7 @@ typedef uint64_t u64;
 
 #include <fwu_mdata.h>
 
-/* TODO: Endianness conversion may be required for some arch. */
-
-static const char *opts_short = "b:i:a:p:v:gh";
+static const char *opts_short = "b:i:a:p:v:V:gh";
 
 static struct option options[] = {
 	{"banks", required_argument, NULL, 'b'},
@@ -47,6 +47,7 @@ static struct option options[] = {
 	{"active-bank", required_argument, NULL, 'a'},
 	{"previous-bank", required_argument, NULL, 'p'},
 	{"version", required_argument, NULL, 'v'},
+	{"vendor-file", required_argument, NULL, 'V'},
 	{"help", no_argument, NULL, 'h'},
 	{NULL, 0, NULL, 0},
 };
@@ -61,6 +62,7 @@ static void print_usage(void)
 		"\t-a, --active-bank  <num>    Active bank (default=0)\n"
 		"\t-p, --previous-bank  <num>  Previous active bank (default=active_bank - 1)\n"
 		"\t-g, --guid                  Use GUID instead of UUID\n"
+		"\t-V, --vendor-file           Vendor data file to append to the metadata\n"
 		"\t-h, --help                  print a help message\n"
 		);
 	fprintf(stderr, "  UUIDs list syntax:\n"
@@ -80,6 +82,8 @@ struct fwu_mdata_object {
 	size_t banks;
 	size_t size;
 	u8 version;
+	size_t vsize;
+	void *vbuf;
 	struct fwu_mdata *mdata;
 };
 
@@ -98,7 +102,7 @@ static bool supported_mdata_version(unsigned long version)
 }
 
 static struct fwu_mdata_object *fwu_alloc_mdata(size_t images, size_t banks,
-						u8 version)
+						u8 version, size_t vendor_size)
 {
 	struct fwu_mdata_object *mobj;
 
@@ -115,6 +119,9 @@ static struct fwu_mdata_object *fwu_alloc_mdata(size_t images, size_t banks,
 			sizeof(struct fwu_fw_store_desc) +
 			(sizeof(struct fwu_image_entry) +
 			 sizeof(struct fwu_image_bank_info) * banks) * images;
+
+		mobj->size += vendor_size;
+		mobj->vsize = vendor_size;
 	}
 
 	mobj->images = images;
@@ -122,12 +129,21 @@ static struct fwu_mdata_object *fwu_alloc_mdata(size_t images, size_t banks,
 	mobj->version = version;
 
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
@@ -297,6 +313,7 @@ static void fwu_fill_version_specific_mdata(struct fwu_mdata_object *mobj)
 static int fwu_parse_fill_uuids(struct fwu_mdata_object *mobj, char *uuids[])
 {
 	struct fwu_mdata *mdata = mobj->mdata;
+	char *vdata;
 	int i, ret;
 
 	mdata->version = mobj->version;
@@ -311,24 +328,65 @@ static int fwu_parse_fill_uuids(struct fwu_mdata_object *mobj, char *uuids[])
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
 
-static int
-fwu_make_mdata(size_t images, size_t banks, u8 version, char *uuids[],
-	       char *output)
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
+static int fwu_make_mdata(size_t images, size_t banks, u8 version,
+			  const char *vendor_file, char *uuids[],
+			  char *output)
 {
-	struct fwu_mdata_object *mobj;
-	FILE *file;
 	int ret;
+	FILE *file;
+	struct stat sbuf;
+	size_t vendor_size = 0;
+	struct fwu_mdata_object *mobj;
 
-	mobj = fwu_alloc_mdata(images, banks, version);
+	if (vendor_file) {
+		ret = stat(vendor_file, &sbuf);
+		if (ret)
+			return -errno;
+
+		vendor_size = sbuf.st_size;
+	}
+
+	mobj = fwu_alloc_mdata(images, banks, version, vendor_size);
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
@@ -349,6 +407,7 @@ fwu_make_mdata(size_t images, size_t banks, u8 version, char *uuids[],
 
 done_make:
 	free(mobj->mdata);
+	free(mobj->vbuf);
 	free(mobj);
 
 	return ret;
@@ -358,11 +417,13 @@ int main(int argc, char *argv[])
 {
 	unsigned long banks = 0, images = 0, version = 0;
 	int c, ret;
+	const char *vendor_file;
 
 	/* Explicitly initialize defaults */
 	active_bank = 0;
 	__use_guid = false;
 	previous_bank = INT_MAX;
+	vendor_file = NULL;
 
 	do {
 		c = getopt_long(argc, argv, opts_short, options, NULL);
@@ -388,6 +449,9 @@ int main(int argc, char *argv[])
 		case 'v':
 			version = strtoul(optarg, NULL, 0);
 			break;
+		case 'V':
+			vendor_file = optarg;
+			break;
 		}
 	} while (c != -1);
 
@@ -402,6 +466,11 @@ int main(int argc, char *argv[])
 		return -EINVAL;
 	}
 
+	if (version == 1 && vendor_file) {
+		fprintf(stderr, "Error: Vendor Data can only be appended in version 2 of FWU Metadata.\n");
+		return -EINVAL;
+	}
+
 	/* This command takes UUIDs * images and output file. */
 	if (optind + images + 1 != argc) {
 		fprintf(stderr, "Error: UUID list or output file is not specified or too much.\n");
@@ -414,8 +483,8 @@ int main(int argc, char *argv[])
 		previous_bank = active_bank > 0 ? active_bank - 1 : banks - 1;
 	}
 
-	ret = fwu_make_mdata(images, banks, (u8)version, argv + optind,
-			     argv[argc - 1]);
+	ret = fwu_make_mdata(images, banks, (u8)version, vendor_file,
+			     argv + optind, argv[argc - 1]);
 	if (ret < 0)
 		fprintf(stderr, "Error: Failed to parse and write image: %s\n",
 			strerror(-ret));
-- 
2.34.1

