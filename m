Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04520C6FD1F
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 335488812B;
	Fri, 22 Mar 2024 12:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE4D78819D; Fri, 22 Mar 2024 12:36:57 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A5488113
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 12:36:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=randolph@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42MBamAf065129;
 Fri, 22 Mar 2024 19:36:48 +0800 (+08)
 (envelope-from randolph@andestech.com)
Received: from atctrx.andestech.com (10.0.15.173) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Fri, 22 Mar 2024
 19:36:44 +0800
From: Randolph <randolph@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph.sklin@gmail.com>, <dylan@andestech.com>, <tim609@andestech.com>, 
 Randolph <randolph@andestech.com>
Subject: [PATCH] spl: riscv: opensbi: fix check of PAYLOAD_ARGS_ADDR
Date: Fri, 22 Mar 2024 19:36:37 +0800
Message-ID: <20240322113637.2217932-1-randolph@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.173]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42MBamAf065129
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

When Falcon Mode is enabled on RISC-V, use CONFIG_VAL
to check PAYLOAD_ARGS_ADDR, not CONFIG_IS_ENABLED.

Signed-off-by: Randolph <randolph@andestech.com>
---
 common/spl/spl_opensbi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/spl/spl_opensbi.c b/common/spl/spl_opensbi.c
index 8127ebc946..ec62aab929 100644
--- a/common/spl/spl_opensbi.c
+++ b/common/spl/spl_opensbi.c
@@ -66,7 +66,7 @@ void __noreturn spl_invoke_opensbi(struct spl_image_info *spl_image)
 	 * Moving DTB in front of the kernel can avoid the error.
 	 */
 #if CONFIG_IS_ENABLED(LOAD_FIT_OPENSBI_OS_BOOT) && \
-    CONFIG_IS_ENABLED(PAYLOAD_ARGS_ADDR)
+    CONFIG_VAL(PAYLOAD_ARGS_ADDR)
 	memcpy((void *)CONFIG_SPL_PAYLOAD_ARGS_ADDR, spl_image->fdt_addr,
 	       fdt_totalsize(spl_image->fdt_addr));
 	spl_image->fdt_addr = map_sysmem(CONFIG_SPL_PAYLOAD_ARGS_ADDR, 0);
-- 
2.34.1

