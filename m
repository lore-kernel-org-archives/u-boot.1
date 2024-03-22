Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F51C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 10:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9299881D8;
	Fri, 22 Mar 2024 11:58:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26BAD881E2; Fri, 22 Mar 2024 11:58:31 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 2B147881D5
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:58:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC3061007;
 Fri, 22 Mar 2024 03:59:02 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A12553F64C;
 Fri, 22 Mar 2024 03:58:25 -0700 (PDT)
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
Subject: [PATCH v3 06/20] fwu: metadata: add a version agnostic structure
Date: Fri, 22 Mar 2024 16:27:19 +0530
Message-Id: <20240322105733.203888-7-sughosh.ganu@linaro.org>
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

The FWU specification now has two versions of the FWU metadata
structure, and both are to be supported. Introduce a version agnostic
structure for storing information about the FWU updatable images. This
allows for a split of common version agnostic FWU code and version
specific code.

The version specific code is then responsible for arranging the data
as per the corresponding metadata structure before it gets written to
the metadata partitions.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2:
* New patch

 include/fwu.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/fwu.h b/include/fwu.h
index 6c4d218e13..e681e91027 100644
--- a/include/fwu.h
+++ b/include/fwu.h
@@ -8,6 +8,7 @@
 
 #include <blk.h>
 #include <efi.h>
+#include <fwu_mdata.h>
 #include <mtd.h>
 #include <uuid.h>
 
@@ -35,6 +36,23 @@ struct fwu_mdata_mtd_priv {
 	struct fwu_mtd_image_info *fwu_mtd_images;
 };
 
+struct fwu_data {
+	uint32_t crc32;
+	uint32_t version;
+	uint32_t active_index;
+	uint32_t previous_active_index;
+	uint32_t metadata_size;
+	uint32_t boot_index;
+	uint32_t num_banks;
+	uint32_t num_images;
+	uint8_t  bank_state[4];
+	bool     trial_state;
+
+	struct fwu_mdata *fwu_mdata;
+
+	struct fwu_image_entry fwu_images[CONFIG_FWU_NUM_IMAGES_PER_BANK];
+};
+
 struct fwu_mdata_ops {
 	/**
 	 * read_mdata() - Populate the asked FWU metadata copy
-- 
2.34.1

