Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3937C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EBB382C79;
	Tue, 17 Jun 2025 12:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D997C82BA1; Tue, 17 Jun 2025 12:44:29 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D7AB682E08
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 378C91596;
 Tue, 17 Jun 2025 03:44:06 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.164.21.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D30B3F58B;
 Tue, 17 Jun 2025 03:44:23 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v5 6/7] mach-snapdragon: add a check before copying FDT to
 fdt_addr_r
Date: Tue, 17 Jun 2025 16:13:45 +0530
Message-Id: <20250617104346.1379981-7-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250617104346.1379981-1-sughosh.ganu@linaro.org>
References: <20250617104346.1379981-1-sughosh.ganu@linaro.org>
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

The board_late_init() function allocates memory for a bunch of
environment variables, including fdt_addr_r. The device-tree then gets
copied to the memory pointed to by fdt_addr_r. However, the memory
allocation request can fail, in which case the address that is being
written to would not be allocated. Add a check that the memory
allocation has succeeded before copying the device-tree.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V4: None

 arch/arm/mach-snapdragon/board.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 87a173e0acb..ed2bd5dbade 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -497,7 +497,7 @@ void __weak qcom_late_init(void)
 /* Stolen from arch/arm/mach-apple/board.c */
 int board_late_init(void)
 {
-	u32 status = 0;
+	u32 status = 0, fdt_status = 0;
 	phys_addr_t addr;
 	struct fdt_header *fdt_blob = (struct fdt_header *)gd->fdt_blob;
 
@@ -520,14 +520,19 @@ int board_late_init(void)
 		status |= !lmb_alloc(FASTBOOT_BUF_SIZE, &addr) ?
 			env_set_hex("fastboot_addr_r", addr) : 1;
 
-	status |= !lmb_alloc(SZ_2M, &addr) ?
+	fdt_status |= !lmb_alloc(SZ_2M, &addr) ?
 		env_set_hex("fdt_addr_r", addr) : 1;
 
-	if (status)
+	if (status || fdt_status)
 		log_warning("%s: Failed to set run time variables\n", __func__);
 
 	/* By default copy U-Boots FDT, it will be used as a fallback */
-	memcpy((void *)addr, (void *)gd->fdt_blob, fdt32_to_cpu(fdt_blob->totalsize));
+	if (fdt_status)
+		log_warning("%s: Failed to reserve memory for copying FDT\n",
+			    __func__);
+	else
+		memcpy((void *)addr, (void *)gd->fdt_blob,
+		       fdt32_to_cpu(fdt_blob->totalsize));
 
 	configure_env();
 	qcom_late_init();
-- 
2.34.1

