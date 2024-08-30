Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EE5CA0FE4
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 11:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 698D688A9B;
	Fri, 30 Aug 2024 13:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B74A888AFA; Fri, 30 Aug 2024 13:41:14 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B59C088A92
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 13:41:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70E73339;
 Fri, 30 Aug 2024 04:41:38 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60D8D3F66E;
 Fri, 30 Aug 2024 04:41:10 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 1/6] fwu: v2: perform some checks before reading metadata
Date: Fri, 30 Aug 2024 17:10:52 +0530
Message-Id: <20240830114057.891069-2-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830114057.891069-1-sughosh.ganu@linaro.org>
References: <20240830114057.891069-1-sughosh.ganu@linaro.org>
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

The version 2 of the FWU metadata has a top level structure, followed
by optional information on the updatable images. Perform some sanity
checks on some of the fields in the top level structure to determine
if the rest of the structure has to be read.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 lib/fwu_updates/fwu_v2.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/lib/fwu_updates/fwu_v2.c b/lib/fwu_updates/fwu_v2.c
index 108bc9bb4a..d0d8a25929 100644
--- a/lib/fwu_updates/fwu_v2.c
+++ b/lib/fwu_updates/fwu_v2.c
@@ -58,24 +58,6 @@ static int fwu_mdata_sanity_checks(void)
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
 
@@ -238,6 +220,24 @@ int fwu_init(void)
 		return ret;
 	}
 
+	if (mdata.version != FWU_MDATA_VERSION) {
+		log_err("FWU metadata version %u. Expected value of %u\n",
+			mdata.version, FWU_MDATA_VERSION);
+		return -EINVAL;
+	}
+
+	if (!mdata.desc_offset) {
+		log_err("No image information provided with the Metadata. ");
+		log_err("Image information expected in the metadata\n");
+		return -EINVAL;
+	}
+
+	if (mdata.desc_offset != 0x20) {
+		log_err("Descriptor Offset(0x%x) in the FWU Metadata not equal to 0x20\n",
+			mdata.desc_offset);
+		return -EINVAL;
+	}
+
 	ret = fwu_mdata_copies_allocate(mdata.metadata_size);
 	if (ret)
 		return ret;
-- 
2.34.1

