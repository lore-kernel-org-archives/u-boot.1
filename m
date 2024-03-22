Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C8AC54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1C33881F9;
	Fri, 22 Mar 2024 11:59:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40FB1881C2; Fri, 22 Mar 2024 11:59:00 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 339CE881C5
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C56641691;
 Fri, 22 Mar 2024 03:59:30 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E66723F64C;
 Fri, 22 Mar 2024 03:58:53 -0700 (PDT)
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
Subject: [PATCH v3 14/20] cmd: fwu: make changes for supporting FWU metadata
 version 2
Date: Fri, 22 Mar 2024 16:27:27 +0530
Message-Id: <20240322105733.203888-15-sughosh.ganu@linaro.org>
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

Add support for displaying data specific to FWU metadata version
2. Because the size of the v2 metadata structure is read from the
structure itself, allocate memory for the metadata structure by first
getting the size of the structure.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2:
* Earlier patch was migrating to v2 only support. These changes
  support both versions.

 cmd/fwu_mdata.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
index 5ecda455df..3c8be576ac 100644
--- a/cmd/fwu_mdata.c
+++ b/cmd/fwu_mdata.c
@@ -13,27 +13,33 @@
 
 #include <linux/types.h>
 
-static void print_mdata(struct fwu_mdata *mdata)
+static void print_mdata(struct fwu_data *data)
 {
 	int i, j;
 	struct fwu_image_entry *img_entry;
 	struct fwu_image_bank_info *img_info;
 
 	printf("\tFWU Metadata\n");
-	printf("crc32: %#x\n", mdata->crc32);
-	printf("version: %#x\n", mdata->version);
-	printf("active_index: %#x\n", mdata->active_index);
-	printf("previous_active_index: %#x\n", mdata->previous_active_index);
+	printf("crc32: %#x\n", data->crc32);
+	printf("version: %#x\n", data->version);
+	printf("active_index: %#x\n", data->active_index);
+	printf("previous_active_index: %#x\n", data->previous_active_index);
+
+	if (data->version == 2) {
+		for (i = 0; i < 4; i++)
+			printf("bank_state[%d]: %#x\n",
+			       i, data->bank_state[i]);
+	}
 
 	printf("\tImage Info\n");
 	for (i = 0; i < CONFIG_FWU_NUM_IMAGES_PER_BANK; i++) {
-		img_entry = &mdata->img_entry[i];
+		img_entry = &data->fwu_images[i];
 		printf("\nImage Type Guid: %pUL\n",
-		       &img_entry->image_type_uuid);
-		printf("Location Guid: %pUL\n", &img_entry->location_uuid);
+		       &img_entry->image_type_guid);
+		printf("Location Guid: %pUL\n", &img_entry->location_guid);
 		for (j = 0; j < CONFIG_FWU_NUM_BANKS; j++) {
 			img_info = &img_entry->img_bank_info[j];
-			printf("Image Guid:  %pUL\n", &img_info->image_uuid);
+			printf("Image Guid:  %pUL\n", &img_info->image_guid);
 			printf("Image Acceptance: %s\n",
 			       img_info->accepted == 0x1 ? "yes" : "no");
 		}
@@ -43,20 +49,11 @@ static void print_mdata(struct fwu_mdata *mdata)
 int do_fwu_mdata_read(struct cmd_tbl *cmdtp, int flag,
 		     int argc, char * const argv[])
 {
-	int ret = CMD_RET_SUCCESS, res;
-	struct fwu_mdata mdata;
-
-	res = fwu_get_mdata(&mdata);
-	if (res < 0) {
-		log_err("Unable to get valid FWU metadata\n");
-		ret = CMD_RET_FAILURE;
-		goto out;
-	}
+	struct fwu_data *data = fwu_get_data();
 
-	print_mdata(&mdata);
+	print_mdata(data);
 
-out:
-	return ret;
+	return CMD_RET_SUCCESS;
 }
 
 U_BOOT_CMD(
-- 
2.34.1

