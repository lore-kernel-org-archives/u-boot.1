Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF65C3DA6E
	for <u-boot@archiver.kernel.org>; Mon, 25 Dec 2023 13:05:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B638760D;
	Mon, 25 Dec 2023 14:05:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AA618753E; Mon, 25 Dec 2023 14:05:55 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4923875FC
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 14:05:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BPD5jDr042658
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 21:05:45 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Mon, 25 Dec 2023 21:05:42 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <randolph@andestech.com>, <peterlin@andestech.com>, <ycliang@andestech.com>
Subject: [PATCH 1/5] andes: csr.h: Clean up CSR definition
Date: Mon, 25 Dec 2023 21:05:24 +0800
Message-ID: <20231225130528.1954968-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BPD5jDr042658
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

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/include/asm/arch-andes/csr.h | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/arch-andes/csr.h b/arch/riscv/include/asm/arch-andes/csr.h
index 393d51c6dd..93aa8b2343 100644
--- a/arch/riscv/include/asm/arch-andes/csr.h
+++ b/arch/riscv/include/asm/arch-andes/csr.h
@@ -15,17 +15,14 @@
 #define CSR_MARCHID 0xf12
 #define CSR_MCCTLCOMMAND 0x7cc
 
-#define MCACHE_CTL_IC_EN_OFFSET 0
-#define MCACHE_CTL_DC_EN_OFFSET 1
-#define MCACHE_CTL_CCTL_SUEN_OFFSET 8
-#define MCACHE_CTL_DC_COHEN_OFFSET 19
-#define MCACHE_CTL_DC_COHSTA_OFFSET 20
-
-#define MCACHE_CTL_IC_EN BIT(MCACHE_CTL_IC_EN_OFFSET)
-#define MCACHE_CTL_DC_EN BIT(MCACHE_CTL_DC_EN_OFFSET)
-#define MCACHE_CTL_CCTL_SUEN BIT(MCACHE_CTL_CCTL_SUEN_OFFSET)
-#define MCACHE_CTL_DC_COHEN BIT(MCACHE_CTL_DC_COHEN_OFFSET)
-#define MCACHE_CTL_DC_COHSTA BIT(MCACHE_CTL_DC_COHSTA_OFFSET)
+/* mcache_ctl register */
+
+#define MCACHE_CTL_IC_EN		BIT(0)
+#define MCACHE_CTL_DC_EN		BIT(1)
+#define MCACHE_CTL_CCTL_SUEN		BIT(8)
+#define MCACHE_CTL_DC_COHEN		BIT(19)
+#define MCACHE_CTL_DC_COHSTA		BIT(20)
+
 
 #define CCTL_L1D_WBINVAL_ALL 6
 
-- 
2.34.1

