Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5103A1075278
	for <u-boot@archiver.kernel.org>; Thu, 19 Mar 2026 08:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6167E83FDB;
	Thu, 19 Mar 2026 09:34:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40C9083FDB; Thu, 19 Mar 2026 09:34:06 +0100 (CET)
Received: from Atcsqr.andestech.com (unknown [60.248.187.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B739C83E16
 for <u-boot@lists.denx.de>; Thu, 19 Mar 2026 09:34:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTP id 62J8XlAd016336;
 Thu, 19 Mar 2026 16:33:47 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Mar
 2026 16:33:47 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <rick@andestech.com>, <ycliang@andestech.com>, <trini@konsulko.com>,
 <me@ziyao.cc>, <anshuld@ti.com>, <xypron.glpk@gmx.de>,
 <qemu-devel@nongnu.org>
Subject: [PATCH 2/2] riscv: andes: Add Smstateen extension support
Date: Thu, 19 Mar 2026 16:33:39 +0800
Message-ID: <20260319083339.3429776-2-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319083339.3429776-1-ycliang@andestech.com>
References: <20260319083339.3429776-1-ycliang@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 62J8XlAd016336
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

Use the CSR detection mechanism to probe for the Smstateen extension
and initialize mstateen0/sstateen0 CSRs when present.

The mstateen0 register is configured to allow S-mode access to fcsr,
AIA, IMSIC, indirect CSR access, environment configuration, and
sstateen0. The sstateen0 register enables U-mode access to compressed
extension state and fcsr.

Supports both RV32 (using MSTATEEN0/MSTATEEN0H split) and RV64.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/cpu/andes/cpu.c   | 29 +++++++++++++++++++++++++++++
 arch/riscv/include/asm/csr.h | 15 +++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/riscv/cpu/andes/cpu.c b/arch/riscv/cpu/andes/cpu.c
index d25ecba0e88..feb755a4f0d 100644
--- a/arch/riscv/cpu/andes/cpu.c
+++ b/arch/riscv/cpu/andes/cpu.c
@@ -9,6 +9,7 @@
 #include <irq_func.h>
 #include <asm/cache.h>
 #include <asm/csr.h>
+#include <asm/csr_detect.h>
 #include <asm/arch-andes/csr.h>
 
 /*
@@ -60,5 +61,33 @@ void harts_early_init(void)
 		mmisc_ctl_val |= MMISC_CTL_NON_BLOCKING_EN;
 
 		csr_write(CSR_MMISC_CTL, mmisc_ctl_val);
+
+		/* Initialize Smstateen if the extension is present */
+		{
+			int trap = 0;
+			unsigned long long mstateen0;
+
+			mstateen0 = csr_read_allowed(CSR_MSTATEEN0, trap);
+			if (!trap) {
+#if __riscv_xlen == 32
+				mstateen0 |= (unsigned long long)
+					csr_read(CSR_MSTATEEN0H) << 32;
+#endif
+				mstateen0 |= SMSTATEEN0_CS | SMSTATEEN0_FCSR |
+					     SMSTATEEN0_CONTEXT |
+					     SMSTATEEN0_IMSIC |
+					     SMSTATEEN0_AIA |
+					     SMSTATEEN0_CSRIND |
+					     SMSTATEEN0_ENVCFG |
+					     SMSTATEEN0_SE0;
+				csr_write(CSR_MSTATEEN0, mstateen0);
+#if __riscv_xlen == 32
+				csr_write(CSR_MSTATEEN0H, mstateen0 >> 32);
+#endif
+				csr_write(CSR_SSTATEEN0,
+					  csr_read(CSR_SSTATEEN0) |
+					  SMSTATEEN0_CS | SMSTATEEN0_FCSR);
+			}
+		}
 	}
 }
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 986f951c31a..cef0fd906da 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -97,6 +97,18 @@
 #define SIE_STIE		(_AC(0x1, UL) << IRQ_S_TIMER)
 #define SIE_SEIE		(_AC(0x1, UL) << IRQ_S_EXT)
 
+/* Smstateen: mstateen0 / sstateen0 bit definitions */
+#define SMSTATEEN0_CS		(_AC(0x1, ULL) << 0)
+#define SMSTATEEN0_FCSR		(_AC(0x1, ULL) << 1)
+#define SMSTATEEN0_JVT		(_AC(0x1, ULL) << 2)
+#define SMSTATEEN0_CONTEXT	(_AC(0x1, ULL) << 57)
+#define SMSTATEEN0_IMSIC	(_AC(0x1, ULL) << 58)
+#define SMSTATEEN0_AIA		(_AC(0x1, ULL) << 59)
+#define SMSTATEEN0_CSRIND	(_AC(0x1, ULL) << 60)
+#define SMSTATEEN0_P1P13	(_AC(0x1, ULL) << 61)
+#define SMSTATEEN0_ENVCFG	(_AC(0x1, ULL) << 62)
+#define SMSTATEEN0_SE0		(_AC(0x1, ULL) << 63)
+
 #define CSR_FCSR		0x003
 #define CSR_CYCLE		0xc00
 #define CSR_TIME		0xc01
@@ -105,6 +117,7 @@
 #define CSR_SIE			0x104
 #define CSR_STVEC		0x105
 #define CSR_SCOUNTEREN		0x106
+#define CSR_SSTATEEN0		0x10c
 #define CSR_SSCRATCH		0x140
 #define CSR_SEPC		0x141
 #define CSR_SCAUSE		0x142
@@ -126,6 +139,8 @@
 #else
 #define CSR_MCOUNTEREN		0x306
 #endif
+#define CSR_MSTATEEN0		0x30c
+#define CSR_MSTATEEN0H		0x31c
 #define CSR_MSCRATCH		0x340
 #define CSR_MEPC		0x341
 #define CSR_MCAUSE		0x342
-- 
2.34.1

