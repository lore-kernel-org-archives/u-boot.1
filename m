Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E132C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04DAD881F0;
	Fri, 22 Mar 2024 11:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6686881C2; Fri, 22 Mar 2024 11:58:48 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E480A881F0
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82F6E1692;
 Fri, 22 Mar 2024 03:59:20 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67FA83F64C;
 Fri, 22 Mar 2024 03:58:43 -0700 (PDT)
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
Subject: [PATCH v3 11/20] fwu: mtd: remove unused argument from function call
Date: Fri, 22 Mar 2024 16:27:24 +0530
Message-Id: <20240322105733.203888-12-sughosh.ganu@linaro.org>
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

The third argument passed to the function gen_image_alt_info() is not
used and is superfluous. Remove this unused argument from the function
call.

Fixes: 4898679e190 (FWU: Add FWU metadata access driver for MTD storage regions)
Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2:
* New patch

 lib/fwu_updates/fwu_mtd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/fwu_updates/fwu_mtd.c b/lib/fwu_updates/fwu_mtd.c
index 69cd3d7001..d48de19009 100644
--- a/lib/fwu_updates/fwu_mtd.c
+++ b/lib/fwu_updates/fwu_mtd.c
@@ -107,7 +107,7 @@ __weak int fwu_plat_get_alt_num(struct udevice *dev, efi_guid_t *image_id,
 	return fwu_mtd_get_alt_num(image_id, alt_num, "nor1");
 }
 
-static int gen_image_alt_info(char *buf, size_t len, int sidx,
+static int gen_image_alt_info(char *buf, size_t len,
 			      struct fwu_image_entry *img, struct mtd_info *mtd)
 {
 	char *p = buf, *end = buf + len;
@@ -168,8 +168,7 @@ int fwu_gen_alt_info_from_mtd(char *buf, size_t len, struct mtd_info *mtd)
 	}
 
 	for (i = 0; i < CONFIG_FWU_NUM_IMAGES_PER_BANK; i++) {
-		ret = gen_image_alt_info(buf, len, i * CONFIG_FWU_NUM_BANKS,
-					 &mdata.img_entry[i], mtd);
+		ret = gen_image_alt_info(buf, len, &mdata.img_entry[i], mtd);
 		if (ret)
 			break;
 
-- 
2.34.1

