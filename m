Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F25CE7A89
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 09:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 951E686BEC;
	Mon, 25 Sep 2023 11:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 507B686B3A; Mon, 25 Sep 2023 11:27:35 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1091A86B89
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 11:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38P9RMS5061388;
 Mon, 25 Sep 2023 17:27:22 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Mon, 25 Sep 2023 17:27:19 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 <peterlin@andestech.com>, Randolph <randolph@andestech.com>
Subject: [PATCH 3/7] spl: riscv: opensbi: change the default os_type as varible
Date: Mon, 25 Sep 2023 17:25:39 +0800
Message-ID: <20230925092543.1408725-4-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925092543.1408725-1-randolph@andestech.com>
References: <20230925092543.1408725-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38P9RMS5061388
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

In order to introduce the Opensbi OS boot mode, the next stage boot
image of OpenSBI should be configurable.

Signed-off-by: Randolph <randolph@andestech.com>
---
 common/spl/spl_opensbi.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
index e2aaa46046..a0c5f35dab 100644
--- a/common/spl/spl_opensbi.c
+++ b/common/spl/spl_opensbi.c
@@ -20,7 +20,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 struct fw_dynamic_info opensbi_info;
 
-static int spl_opensbi_find_uboot_node(void *blob, int *uboot_node)
+static int spl_opensbi_find_os_node(void *blob, int *uboot_node, int os_type)
 {
 	int fit_images_node, node;
 	const char *fit_os;
@@ -34,7 +34,7 @@ static int spl_opensbi_find_uboot_node(void *blob, int *uboot_node)
 		if (!fit_os)
 			continue;
 
-		if (genimg_get_os_id(fit_os) == IH_OS_U_BOOT) {
+		if (genimg_get_os_id(fit_os) == os_type) {
 			*uboot_node = node;
 			return 0;
 		}
@@ -45,8 +45,9 @@ static int spl_opensbi_find_uboot_node(void *blob, int *uboot_node)
 
 void __noreturn spl_invoke_opensbi(struct spl_image_info *spl_image)
 {
-	int ret, uboot_node;
-	ulong uboot_entry;
+	int ret, os_node;
+	ulong os_entry;
+	int os_type;
 	typedef void __noreturn (*opensbi_entry_t)(ulong hartid, ulong dtb, ulong info);
 	opensbi_entry_t opensbi_entry;
 
@@ -55,22 +56,27 @@ void __noreturn spl_invoke_opensbi(struct spl_image_info *spl_image)
 		hang();
 	}
 
-	/* Find U-Boot image in /fit-images */
-	ret = spl_opensbi_find_uboot_node(spl_image->fdt_addr, &uboot_node);
+	/*
+	 * Find next os image in /fit-images
+	 * The next os image default is u-boot proper
+	 */
+	os_type = IH_OS_U_BOOT;
+	ret = spl_opensbi_find_os_node(spl_image->fdt_addr, &os_node, os_type);
 	if (ret) {
-		pr_err("Can't find U-Boot node, %d\n", ret);
+		pr_err("Can't find %s node for opensbi, %d\n",
+		       genimg_get_os_name(os_type), ret);
 		hang();
 	}
 
 	/* Get U-Boot entry point */
-	ret = fit_image_get_entry(spl_image->fdt_addr, uboot_node, &uboot_entry);
+	ret = fit_image_get_entry(spl_image->fdt_addr, os_node, &os_entry);
 	if (ret)
-		ret = fit_image_get_load(spl_image->fdt_addr, uboot_node, &uboot_entry);
+		ret = fit_image_get_load(spl_image->fdt_addr, os_node, &os_entry);
 
 	/* Prepare opensbi_info object */
 	opensbi_info.magic = FW_DYNAMIC_INFO_MAGIC_VALUE;
 	opensbi_info.version = FW_DYNAMIC_INFO_VERSION;
-	opensbi_info.next_addr = uboot_entry;
+	opensbi_info.next_addr = os_entry;
 	opensbi_info.next_mode = FW_DYNAMIC_INFO_NEXT_MODE_S;
 	opensbi_info.options = CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS;
 	opensbi_info.boot_hart = gd->arch.boot_hart;
-- 
2.34.1

