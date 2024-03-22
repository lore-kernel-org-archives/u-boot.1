Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57620C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 683D5881F7;
	Fri, 22 Mar 2024 11:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F12C881F8; Fri, 22 Mar 2024 11:58:52 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6C6A1881F6
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A11D169E;
 Fri, 22 Mar 2024 03:59:24 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E360F3F64C;
 Fri, 22 Mar 2024 03:58:46 -0700 (PDT)
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
Subject: [PATCH v3 12/20] fwu: mtd: get MTD partition specific info from driver
Date: Fri, 22 Mar 2024 16:27:25 +0530
Message-Id: <20240322105733.203888-13-sughosh.ganu@linaro.org>
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

Information about FWU images on MTD partitions is now stored with the
corresponding driver instead of a global variable. Get this
information from the driver.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2:
* New patch

 lib/fwu_updates/fwu_mtd.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/fwu_updates/fwu_mtd.c b/lib/fwu_updates/fwu_mtd.c
index d48de19009..f4e0e3107b 100644
--- a/lib/fwu_updates/fwu_mtd.c
+++ b/lib/fwu_updates/fwu_mtd.c
@@ -15,16 +15,21 @@
 
 #include <dm/ofnode.h>
 
-struct fwu_mtd_image_info
-fwu_mtd_images[CONFIG_FWU_NUM_BANKS * CONFIG_FWU_NUM_IMAGES_PER_BANK];
-
 static struct fwu_mtd_image_info *mtd_img_by_uuid(const char *uuidbuf)
 {
-	int num_images = ARRAY_SIZE(fwu_mtd_images);
+	int num_images;
+	struct fwu_mdata_mtd_priv *mtd_priv = dev_get_priv(fwu_get_dev());
+	struct fwu_mtd_image_info *image_info = mtd_priv->fwu_mtd_images;
+
+	if (!image_info)
+		return NULL;
+
+	num_images = CONFIG_FWU_NUM_BANKS *
+		CONFIG_FWU_NUM_IMAGES_PER_BANK;
 
 	for (int i = 0; i < num_images; i++)
-		if (!strcmp(uuidbuf, fwu_mtd_images[i].uuidbuf))
-			return &fwu_mtd_images[i];
+		if (!strcmp(uuidbuf, image_info[i].uuidbuf))
+			return &image_info[i];
 
 	return NULL;
 }
-- 
2.34.1

