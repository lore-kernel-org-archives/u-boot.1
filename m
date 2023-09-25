Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CB5CE7A89
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 09:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66C3F86C96;
	Mon, 25 Sep 2023 11:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26CD786B3A; Mon, 25 Sep 2023 11:27:45 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F368386D24
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 11:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38P9RWGG061455;
 Mon, 25 Sep 2023 17:27:32 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Mon, 25 Sep 2023 17:27:29 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 <peterlin@andestech.com>, Randolph <randolph@andestech.com>
Subject: [PATCH 5/7] spl: riscv: add os type for next booting stage
Date: Mon, 25 Sep 2023 17:25:41 +0800
Message-ID: <20230925092543.1408725-6-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925092543.1408725-1-randolph@andestech.com>
References: <20230925092543.1408725-1-randolph@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38P9RWGG061455
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

If SPL_LOAD_FIT_OPENSBI_OS_BOOT is enabled, the function
spl_invoke_opensbi should change the target OS type to IH_OS_LINUX.
OpenSBI will load the Linux image as the next boot stage.
The os_takes_devicetree function returns a value of true or false
depending on whether or not SPL_LOAD_FIT_OPENSBI_OS_BOOT is enabled.

Signed-off-by: Randolph <randolph@andestech.com>
---
 common/spl/spl_fit.c     | 4 ++++
 common/spl/spl_opensbi.c | 7 ++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 730639f756..750562721a 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -351,7 +351,11 @@ static bool os_takes_devicetree(uint8_t os)
 	case IH_OS_U_BOOT:
 		return true;
 	case IH_OS_LINUX:
+#ifdef CONFIG_RISCV
+		return IS_ENABLED(CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT);
+#else
 		return IS_ENABLED(CONFIG_SPL_OS_BOOT);
+#endif
 	default:
 		return false;
 	}
diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
index a0c5f35dab..708869ad48 100644
--- a/common/spl/spl_opensbi.c
+++ b/common/spl/spl_opensbi.c
@@ -58,9 +58,14 @@ void __noreturn spl_invoke_opensbi(struct spl_image_info *spl_image)
 
 	/*
 	 * Find next os image in /fit-images
-	 * The next os image default is u-boot proper
+	 * The next os image default is u-boot proper, once enable
+	 * OpenSBI OS boot mode, the OS image should be linux.
 	 */
+#if CONFIG_IS_ENABLED(LOAD_FIT_OPENSBI_OS_BOOT)
+	os_type = IH_OS_LINUX;
+#else
 	os_type = IH_OS_U_BOOT;
+#endif
 	ret = spl_opensbi_find_os_node(spl_image->fdt_addr, &os_node, os_type);
 	if (ret) {
 		pr_err("Can't find %s node for opensbi, %d\n",
-- 
2.34.1

