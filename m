Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14A8C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 13:06:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAFC18780F;
	Mon, 25 Dec 2023 14:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA1C18780F; Mon, 25 Dec 2023 14:06:13 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D2387480
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 14:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BPD65fV043022
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 21:06:05 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Mon, 25 Dec 2023 21:06:01 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph@andestech.com>, <peterlin@andestech.com>, <ycliang@andestech.com>
Subject: [PATCH 5/5] andes: ae350: Save cpu name to env
Date: Mon, 25 Dec 2023 21:05:28 +0800
Message-ID: <20231225130528.1954968-5-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231225130528.1954968-1-ycliang@andestech.com>
References: <20231225130528.1954968-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BPD65fV043022
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

Detect CPU name through marchid and then save it to env.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 board/AndesTech/ae350/ae350.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/board/AndesTech/ae350/ae350.c b/board/AndesTech/ae350/ae350.c
index bef9e3149e..9faf46d96e 100644
--- a/board/AndesTech/ae350/ae350.c
+++ b/board/AndesTech/ae350/ae350.c
@@ -28,6 +28,26 @@ DECLARE_GLOBAL_DATA_PTR;
  * Miscellaneous platform dependent initializations
  */
 
+int misc_init_r(void)
+{
+    long csr_marchid = 0;
+    const long mask_64 = 0x8000;
+    const long mask_cpu = 0xff;
+    char cpu_name[10] = {};
+
+#if CONFIG_IS_ENABLED(RISCV_SMODE)
+    sbi_get_marchid(&csr_marchid);
+#elif CONFIG_IS_ENABLED(RISCV_MMODE)
+    csr_marchid = csr_read(CSR_MARCHID);
+#endif
+    if (mask_64 & csr_marchid)
+        snprintf(cpu_name, sizeof(cpu_name), "ax%lx", (mask_cpu & csr_marchid));
+    else
+        snprintf(cpu_name, sizeof(cpu_name), "a%lx", (mask_cpu & csr_marchid));
+
+    return env_set("cpu", cpu_name);
+}
+
 #if CONFIG_IS_ENABLED(LOAD_FIT) || CONFIG_IS_ENABLED(LOAD_FIT_FULL)
 #define ANDES_SPL_FDT_ADDR	(CONFIG_TEXT_BASE - 0x100000)
 void spl_perform_fixups(struct spl_image_info *spl_image)
-- 
2.34.1

