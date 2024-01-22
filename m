Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FC1C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF8CA87BF6;
	Mon, 22 Jan 2024 12:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96B1587BC9; Mon, 22 Jan 2024 12:55:55 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7837F87C00
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 058D91FB;
 Mon, 22 Jan 2024 03:56:39 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50E333F73F;
 Mon, 22 Jan 2024 03:55:50 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Yann Gautier <yann.gautier@st.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 13/18] cmd: fwu: Align the command with metadata version 2
Date: Mon, 22 Jan 2024 17:24:34 +0530
Message-Id: <20240122115439.653871-14-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122115439.653871-1-sughosh.ganu@linaro.org>
References: <20240122115439.653871-1-sughosh.ganu@linaro.org>
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

Make changes to the fwu_mdata_read command to have it align with the
metadata version 2.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 cmd/fwu_mdata.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/cmd/fwu_mdata.c b/cmd/fwu_mdata.c
index 5ecda455df..7d99b8287f 100644
--- a/cmd/fwu_mdata.c
+++ b/cmd/fwu_mdata.c
@@ -16,6 +16,8 @@
 static void print_mdata(struct fwu_mdata *mdata)
 {
 	int i, j;
+	uint8_t num_banks;
+	uint16_t num_images;
 	struct fwu_image_entry *img_entry;
 	struct fwu_image_bank_info *img_info;
 
@@ -25,15 +27,22 @@ static void print_mdata(struct fwu_mdata *mdata)
 	printf("active_index: %#x\n", mdata->active_index);
 	printf("previous_active_index: %#x\n", mdata->previous_active_index);
 
+	num_banks = mdata->fw_desc[0].num_banks;
+	num_images = mdata->fw_desc[0].num_images;
+
+	for (i = 0; i < 4; i++)
+		printf("bank_state[%d]: %#x\n", i, mdata->bank_state[i]);
+
 	printf("\tImage Info\n");
-	for (i = 0; i < CONFIG_FWU_NUM_IMAGES_PER_BANK; i++) {
-		img_entry = &mdata->img_entry[i];
+
+	for (i = 0; i < num_images; i++) {
+		img_entry = &mdata->fw_desc[0].img_entry[i];
 		printf("\nImage Type Guid: %pUL\n",
-		       &img_entry->image_type_uuid);
-		printf("Location Guid: %pUL\n", &img_entry->location_uuid);
-		for (j = 0; j < CONFIG_FWU_NUM_BANKS; j++) {
+		       &img_entry->image_type_guid);
+		printf("Location Guid: %pUL\n", &img_entry->location_guid);
+		for (j = 0; j < num_banks; j++) {
 			img_info = &img_entry->img_bank_info[j];
-			printf("Image Guid:  %pUL\n", &img_info->image_uuid);
+			printf("Image Guid:  %pUL\n", &img_info->image_guid);
 			printf("Image Acceptance: %s\n",
 			       img_info->accepted == 0x1 ? "yes" : "no");
 		}
@@ -43,19 +52,35 @@ static void print_mdata(struct fwu_mdata *mdata)
 int do_fwu_mdata_read(struct cmd_tbl *cmdtp, int flag,
 		     int argc, char * const argv[])
 {
+	uint32_t mdata_size;
+	struct fwu_mdata *mdata = NULL;
 	int ret = CMD_RET_SUCCESS, res;
-	struct fwu_mdata mdata;
 
-	res = fwu_get_mdata(&mdata);
+	res = fwu_get_mdata_size(&mdata_size);
+	if (res) {
+		log_err("Unable to get FWU metadata size\n");
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
+	mdata = malloc(mdata_size);
+	if (!mdata) {
+		log_err("Unable to allocate memory for FWU metadata\n");
+		ret = CMD_RET_FAILURE;
+		goto out;
+	}
+
+	res = fwu_get_mdata(mdata);
 	if (res < 0) {
 		log_err("Unable to get valid FWU metadata\n");
 		ret = CMD_RET_FAILURE;
 		goto out;
 	}
 
-	print_mdata(&mdata);
+	print_mdata(mdata);
 
 out:
+	free(mdata);
 	return ret;
 }
 
-- 
2.34.1

