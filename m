Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9469EC47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:00:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DE11881C5;
	Fri, 22 Mar 2024 11:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57C008817E; Fri, 22 Mar 2024 11:58:56 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E62C8881F9
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:58:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86475169C;
 Fri, 22 Mar 2024 03:59:27 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B2433F64C;
 Fri, 22 Mar 2024 03:58:50 -0700 (PDT)
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
Subject: [PATCH v3 13/20] fwu: mtd: obtain image information from version
 agnostic structure
Date: Fri, 22 Mar 2024 16:27:26 +0530
Message-Id: <20240322105733.203888-14-sughosh.ganu@linaro.org>
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

Make changes to the functions used for generating the DFU's alt
variable so that the FWU image information is obtained from the common
version agnostic structure instead of reading the metadata.

While here, also update the name of the field used for storing the
image GUID in the FWU metadata.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2:
* New patch

 lib/fwu_updates/fwu_mtd.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/lib/fwu_updates/fwu_mtd.c b/lib/fwu_updates/fwu_mtd.c
index f4e0e3107b..e8211dd5ba 100644
--- a/lib/fwu_updates/fwu_mtd.c
+++ b/lib/fwu_updates/fwu_mtd.c
@@ -136,7 +136,7 @@ static int gen_image_alt_info(char *buf, size_t len,
 
 		/* Query a partition by image UUID */
 		bank = &img->img_bank_info[i];
-		uuid_bin_to_str(bank->image_uuid.b, uuidbuf, UUID_STR_FORMAT_STD);
+		uuid_bin_to_str(bank->image_guid.b, uuidbuf, UUID_STR_FORMAT_STD);
 
 		mtd_img_info = mtd_img_by_uuid(uuidbuf);
 		if (!mtd_img_info) {
@@ -163,17 +163,13 @@ static int gen_image_alt_info(char *buf, size_t len,
 
 int fwu_gen_alt_info_from_mtd(char *buf, size_t len, struct mtd_info *mtd)
 {
-	struct fwu_mdata mdata;
 	int i, l, ret;
-
-	ret = fwu_get_mdata(&mdata);
-	if (ret < 0) {
-		log_err("Failed to get the FWU mdata.\n");
-		return ret;
-	}
+	struct fwu_data *data = fwu_get_data();
+	struct fwu_image_entry *img_entry;
 
 	for (i = 0; i < CONFIG_FWU_NUM_IMAGES_PER_BANK; i++) {
-		ret = gen_image_alt_info(buf, len, &mdata.img_entry[i], mtd);
+		img_entry = &data->fwu_images[i];
+		ret = gen_image_alt_info(buf, len, img_entry, mtd);
 		if (ret)
 			break;
 
-- 
2.34.1

