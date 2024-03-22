Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83C6C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A3A0881D5;
	Fri, 22 Mar 2024 11:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 585BF881EC; Fri, 22 Mar 2024 11:58:45 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 6660C881EE
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 11:58:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07D551691;
 Fri, 22 Mar 2024 03:59:17 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0B0F3F64C;
 Fri, 22 Mar 2024 03:58:39 -0700 (PDT)
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
Subject: [PATCH v3 10/20] fwu: add config symbols for enabling FWU metadata
 versions
Date: Fri, 22 Mar 2024 16:27:23 +0530
Message-Id: <20240322105733.203888-11-sughosh.ganu@linaro.org>
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

Support has been added for version 2 of the FWU metadata
structure. Add config symbols to enable either of the two versions.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2:
* New patch

 lib/fwu_updates/Kconfig  | 14 ++++++++++++++
 lib/fwu_updates/Makefile |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/lib/fwu_updates/Kconfig b/lib/fwu_updates/Kconfig
index d35247d0e5..51b7fbbefd 100644
--- a/lib/fwu_updates/Kconfig
+++ b/lib/fwu_updates/Kconfig
@@ -31,4 +31,18 @@ config FWU_TRIAL_STATE_CNT
 	  the platform is allowed to boot in Trial State after an
 	  update.
 
+config FWU_MDATA_V1
+	bool "Enable support FWU Metadata version 1"
+	help
+	  The FWU specification supports two versions of the
+	  metadata structure. This option enables support for FWU
+	  Metadata version 1 access.
+
+config FWU_MDATA_V2
+	bool "Enable support FWU Metadata version 2"
+	help
+	  The FWU specification supports two versions of the
+	  metadata structure. This option enables support for FWU
+	  Metadata version 2 access.
+
 endif
diff --git a/lib/fwu_updates/Makefile b/lib/fwu_updates/Makefile
index c9e3c06b48..3681bef46c 100644
--- a/lib/fwu_updates/Makefile
+++ b/lib/fwu_updates/Makefile
@@ -6,3 +6,5 @@
 obj-$(CONFIG_FWU_MULTI_BANK_UPDATE) += fwu.o
 obj-$(CONFIG_FWU_MDATA_GPT_BLK) += fwu_gpt.o
 obj-$(CONFIG_FWU_MDATA_MTD) += fwu_mtd.o
+obj-$(CONFIG_FWU_MDATA_V1) += fwu_v1.o
+obj-$(CONFIG_FWU_MDATA_V2) += fwu_v2.o
-- 
2.34.1

