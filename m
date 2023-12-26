Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E5CC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 06:18:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F97E87855;
	Tue, 26 Dec 2023 07:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73BA38771E; Tue, 26 Dec 2023 07:18:09 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3281D8785D
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:18:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3BQ6I0u8084101
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 14:18:00 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Tue, 26 Dec 2023 14:17:55 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <ycliang@andestech.com>, <randolph@andestech.com>, <peterlin@andestech.com>
Subject: [PATCH v2 4/6] andes: cpu: Enable cache and TLB ECC support
Date: Tue, 26 Dec 2023 14:17:35 +0800
Message-ID: <20231226061736.482416-4-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231226061736.482416-1-ycliang@andestech.com>
References: <20231226061736.482416-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3BQ6I0u8084101
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

Andes CPU supports cache and TLB ECC.
Enable them by default.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/cpu/andesv5/cpu.c            | 3 ++-
 arch/riscv/include/asm/arch-andes/csr.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/cpu/andesv5/cpu.c b/arch/riscv/cpu/andesv5/cpu.c
index a23b7948d9..d25ecba0e8 100644
--- a/arch/riscv/cpu/andesv5/cpu.c
+++ b/arch/riscv/cpu/andesv5/cpu.c
@@ -35,7 +35,8 @@ void harts_early_init(void)
 
 		mcache_ctl_val |= (MCACHE_CTL_CCTL_SUEN | \
 				MCACHE_CTL_IC_PREFETCH_EN | MCACHE_CTL_DC_PREFETCH_EN | \
-				MCACHE_CTL_DC_WAROUND_EN | MCACHE_CTL_L2C_WAROUND_EN);
+				MCACHE_CTL_DC_WAROUND_EN | MCACHE_CTL_L2C_WAROUND_EN | \
+				MCACHE_CTL_IC_ECCEN | MCACHE_CTL_DC_ECCEN | MCACHE_CTL_TLB_ECCEN);
 
 		if (!CONFIG_IS_ENABLED(SYS_ICACHE_OFF))
 			mcache_ctl_val |= MCACHE_CTL_IC_EN;
diff --git a/arch/riscv/include/asm/arch-andes/csr.h b/arch/riscv/include/asm/arch-andes/csr.h
index 3f3f05b348..028fd01c2f 100644
--- a/arch/riscv/include/asm/arch-andes/csr.h
+++ b/arch/riscv/include/asm/arch-andes/csr.h
@@ -18,11 +18,14 @@
 
 #define MCACHE_CTL_IC_EN		BIT(0)
 #define MCACHE_CTL_DC_EN		BIT(1)
+#define MCACHE_CTL_IC_ECCEN		BIT(3)
+#define MCACHE_CTL_DC_ECCEN		BIT(5)
 #define MCACHE_CTL_CCTL_SUEN		BIT(8)
 #define MCACHE_CTL_IC_PREFETCH_EN	BIT(9)
 #define MCACHE_CTL_DC_PREFETCH_EN	BIT(10)
 #define MCACHE_CTL_DC_WAROUND_EN	BIT(13)
 #define MCACHE_CTL_L2C_WAROUND_EN	BIT(15)
+#define MCACHE_CTL_TLB_ECCEN		BIT(18)
 #define MCACHE_CTL_DC_COHEN		BIT(19)
 #define MCACHE_CTL_DC_COHSTA		BIT(20)
 
-- 
2.34.1

