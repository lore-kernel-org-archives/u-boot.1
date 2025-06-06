Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7AAC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 04:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84917828F8;
	Fri,  6 Jun 2025 06:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="B3PWkxEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FA02828A2; Fri,  6 Jun 2025 06:29:28 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29B5E807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 06:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id E6AC325CE4;
 Fri,  6 Jun 2025 06:29:25 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gty8PXTO_FTP; Fri,  6 Jun 2025 06:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1749184165; bh=bVRQuqsABYRirD4eytcMFFay0TtJ3RgGpVBdgdXczE0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B3PWkxEXOKNaUi64NmygsXRxVDcE/oDElKa4KgxhyVyOy48CMpYyL9IuNBA7WRu1G
 O2EjwWIZya6J06KGncl05lDWnSW4xyu0ft4anIW/aF412i+1v7WJHahcz+mhqwqSoA
 zvuNuJ4QQPoF/DKOGR+kKA6Ep6CXYHYr95FdGXyEq+bJ/HnjQTycKLha4fhRtxoK97
 gpive3HsANd5rGWzBKntp3LLQKPNOcyZ/+rMeUMLIWpsW6M6XdYGqqht7yxd/97KW/
 bsG1km71uEfvafUIv9i/YEd+rMFfDc5GgoDwFxcf5qAsqpI/XTiuMWUV3W8FIQHOWW
 olJqgK5kA6thg==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Yao Zi <ziyao@disroot.org>, Maksim Kiselev <bigunclemax@gmail.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH 3/5] riscv: cpu: th1520: Add a routine to bring up secondary
 cores
Date: Fri,  6 Jun 2025 04:28:02 +0000
Message-ID: <20250606042804.64311-4-ziyao@disroot.org>
In-Reply-To: <20250606042804.64311-1-ziyao@disroot.org>
References: <20250606042804.64311-1-ziyao@disroot.org>
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

On coldboot, only HART 0 among the four HARTs of TH1520 is brought up by
hardware, and the remaining HARTs are in reset states, requiring manual
setup of reset address and deassertion to function normal. Introduce a
routine to do the work.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/cpu/th1520/cpu.c              | 29 +++++++++++++++++++++++-
 arch/riscv/include/asm/arch-th1520/cpu.h |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/cpu/th1520/cpu.c b/arch/riscv/cpu/th1520/cpu.c
index b83f1272c67..f60446fd772 100644
--- a/arch/riscv/cpu/th1520/cpu.c
+++ b/arch/riscv/cpu/th1520/cpu.c
@@ -9,8 +9,35 @@
 
 #include <asm/io.h>
 #include <cpu_func.h>
+#include <linux/bitops.h>
 
-#define TH1520_PMP_BASE		(void *)0xffdc020000
+#define TH1520_C910_RST			(void __iomem *)(0xffef014000 + 0x004)
+#define  TH1520_C910_CORE_RST_N(n)	BIT((n) + 1)
+#define TH1520_SYSCFG_AP_BASE		(void __iomem *)(0xffef018000)
+#define TH1520_SYSCFG_CORE_START_L(n)	(TH1520_SYSCFG_AP_BASE + 0x50 + 8 * (n))
+#define TH1520_SYSCFG_CORE_START_H(n)	(TH1520_SYSCFG_AP_BASE + 0x54 + 8 * (n))
+#define TH1520_PMP_BASE			(void *)0xffdc020000
+
+void th1520_kick_secondary_cores(void)
+{
+	int i;
+
+	/*
+	 * On coldboot, only HART 0 is brought up by hardware, and resets for
+	 * secondary cores are asserted. Set reset address of secondary cores
+	 * to the entry of SPL, then deassert the resets to bring them up.
+	 */
+	for (i = 1; i < 4; i++) {
+		writel(CONFIG_SPL_TEXT_BASE & 0xffffffff,
+		       TH1520_SYSCFG_CORE_START_L(i));
+		writel(CONFIG_SPL_TEXT_BASE >> 32,
+		       TH1520_SYSCFG_CORE_START_H(i));
+	}
+
+	setbits_le32(TH1520_C910_RST, TH1520_C910_CORE_RST_N(1) |
+				      TH1520_C910_CORE_RST_N(2) |
+				      TH1520_C910_CORE_RST_N(3));
+}
 
 void th1520_invalidate_pmp(void)
 {
diff --git a/arch/riscv/include/asm/arch-th1520/cpu.h b/arch/riscv/include/asm/arch-th1520/cpu.h
index 837f0b8d06b..e164e9ab979 100644
--- a/arch/riscv/include/asm/arch-th1520/cpu.h
+++ b/arch/riscv/include/asm/arch-th1520/cpu.h
@@ -5,5 +5,6 @@
 
 #ifndef _ASM_TH1520_CPU_H_
 #define _ASM_TH1520_CPU_H_
+void th1520_kick_secondary_cores(void);
 void th1520_invalidate_pmp(void);
 #endif /* _ASM_TH1520_CPU_H_ */
-- 
2.49.0

