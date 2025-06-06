Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71766C5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 04:28:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA70E81E25;
	Fri,  6 Jun 2025 06:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="eaByvdYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91915828A2; Fri,  6 Jun 2025 06:28:31 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 995CA800C1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 06:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 66CC426150;
 Fri,  6 Jun 2025 06:28:29 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jv83ig-Uih_a; Fri,  6 Jun 2025 06:28:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1749184108; bh=TRBG/+JRH9UD/13BvJGqOBVEF9g0ih/IsVq86d2K1oA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eaByvdYVq2UdE0FA8jnZ6klV5HrdYAds3eDLPBVKKsY6UeEwT4YopzuZxd6gKuHmd
 K/awpx7nxWxXUjndVh2WsIF73bp+q9zTXQ9nrSgWLsUEIi05vmAegLWlFMDwfnRtEC
 wU2us/y7vGX89VPz5jsbtZsrwHV19zcrEAeQlMYjyaXuFQlR8CmSMNVDaiUk/uwb4T
 vGvk+zvGRWtuEJ2rTT3ZSvcu+Z9zzZWnwiZshvxbxPWhXzg7OOMhCIiJ3RAt8hj8fr
 HlKeMeWf6dH336hS1/CO7hng+jT0Td3NT5qA64J/fcqaBYSIJJ8FdK+e+NyrnYl0L0
 ulm6UOcKeEOAA==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Yao Zi <ziyao@disroot.org>, Maksim Kiselev <bigunclemax@gmail.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH 2/5] riscv: cpu: th1520: Setup CPU feature CSRs in
 harts_early_init
Date: Fri,  6 Jun 2025 04:28:01 +0000
Message-ID: <20250606042804.64311-3-ziyao@disroot.org>
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

C910 cores integrated in TH1520 SoC provide various customized CSRs for
configuring core behavior, including cache coherency and timing, branch
predication, and clock gating for internal components.

This patch sets them up for efficient operation and satisfying
requirements of an SMP system.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/cpu/th1520/spl.c | 83 +++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/riscv/cpu/th1520/spl.c b/arch/riscv/cpu/th1520/spl.c
index 362fe895f86..b95470485f6 100644
--- a/arch/riscv/cpu/th1520/spl.c
+++ b/arch/riscv/cpu/th1520/spl.c
@@ -4,6 +4,7 @@
  */
 #include <asm/arch/iopmp.h>
 #include <asm/io.h>
+#include <cpu_func.h>
 #include <dm.h>
 #include <linux/sizes.h>
 #include <log.h>
@@ -21,6 +22,52 @@ DECLARE_GLOBAL_DATA_PTR;
 #define  TH1520_SUBSYS_RST_VI_N		BIT(1)
 #define  TH1520_SUBSYS_RST_DSP_N	BIT(0)
 
+#define CSR_MXSTATUS			0x7c0
+#define  CSR_MXSTATUS_THEADISAEE	BIT(22)
+#define  CSR_MXSTATUS_MAEE		BIT(21)
+#define  CSR_MXSTATUS_CLINTEE		BIT(17)
+#define  CSR_MXSTATUS_UCME		BIT(16)
+#define  CSR_MXSTATUS_MM		BIT(15)
+#define CSR_MHCR			0x7c1
+#define  CSR_MHCR_WBR			BIT(8)
+#define  CSR_MHCR_BTB			BIT(6)
+#define  CSR_MHCR_BPE			BIT(5)
+#define  CSR_MHCR_RS			BIT(4)
+#define  CSR_MHCR_WB			BIT(3)
+#define  CSR_MHCR_WA			BIT(2)
+#define  CSR_MHCR_DE			BIT(1)
+#define  CSR_MHCR_IE			BIT(0)
+#define CSR_MCOR			0x7c2
+#define  CSR_MCOR_IBP_INV		BIT(18)
+#define  CSR_MCOR_BTB_INV		BIT(17)
+#define  CSR_MCOR_BHT_INV		BIT(16)
+#define  CSR_MCOR_CACHE_INV		BIT(4)
+#define CSR_MCCR2			0x7c3
+#define  CSR_MCCR2_TPRF			BIT(31)
+#define  CSR_MCCR2_IPRF(n)		((n) << 29)
+#define  CSR_MCCR2_TSETUP		BIT(25)
+#define  CSR_MCCR2_TLNTCY(n)		((n) << 22)
+#define  CSR_MCCR2_DSETUP		BIT(19)
+#define  CSR_MCCR2_DLNTCY(n)		((n) << 16)
+#define  CSR_MCCR2_L2EN			BIT(3)
+#define  CSR_MCCR2_RFE			BIT(0)
+#define CSR_MHINT			0x7c5
+#define  CSR_MHINT_FENCERW_BROAD_DIS	BIT(22)
+#define  CSR_MHINT_TLB_BRAOD_DIS	BIT(21)
+#define  CSR_MHINT_NSFE			BIT(18)
+#define  CSR_MHINT_L2_PREF_DIST(n)	((n) << 16)
+#define  CSR_MHINT_L2PLD		BIT(15)
+#define  CSR_MHINT_DCACHE_PREF_DIST(n)	((n) << 13)
+#define  CSR_MHINT_LPE			BIT(9)
+#define  CSR_MHINT_ICACHE_PREF		BIT(8)
+#define  CSR_MHINT_AMR			BIT(3)
+#define  CSR_MHINT_DCACHE_PREF		BIT(2)
+#define CSR_MHINT2			0x7cc
+#define  CSR_MHINT2_LOCAL_ICG_EN(n)	BIT((n) + 14)
+#define CSR_MHINT4			0x7ce
+#define CSR_MSMPR			0x7f3
+#define  CSR_MSMPR_SMPEN		BIT(0)
+
 int spl_dram_init(void)
 {
 	int ret;
@@ -77,6 +124,42 @@ void harts_early_init(void)
 {
 	int i;
 
+	/* Invalidate cache and buffer entries */
+	csr_write(CSR_MCOR, CSR_MCOR_IBP_INV | CSR_MCOR_BTB_INV |
+			    CSR_MCOR_BHT_INV | CSR_MCOR_CACHE_INV | 0x3);
+
+	/* Enable cache snooping */
+	csr_write(CSR_MSMPR, CSR_MSMPR_SMPEN);
+
+	/*
+	 * Configure and enable L2 cache,
+	 *	Enable tag/data RAM prefetch, both cost 2 cycles
+	 *	Prefetch 3 cache lines of instructions
+	 *	Enable read allocation
+	 */
+	csr_write(CSR_MCCR2, CSR_MCCR2_TPRF   | CSR_MCCR2_IPRF(3)	|
+			     CSR_MCCR2_TSETUP | CSR_MCCR2_TLNTCY(1)	|
+			     CSR_MCCR2_DSETUP | CSR_MCCR2_DLNTCY(1)	|
+			     CSR_MCCR2_L2EN   | CSR_MCCR2_RFE);
+	csr_write(CSR_MXSTATUS, CSR_MXSTATUS_THEADISAEE | CSR_MXSTATUS_MAEE |
+				CSR_MXSTATUS_CLINTEE    | CSR_MXSTATUS_UCME |
+				CSR_MXSTATUS_MM);
+	csr_write(CSR_MHINT, CSR_MHINT_FENCERW_BROAD_DIS	|
+			     CSR_MHINT_TLB_BRAOD_DIS		|
+			     CSR_MHINT_NSFE			|
+			     CSR_MHINT_L2_PREF_DIST(2)		|
+			     CSR_MHINT_L2PLD			|
+			     CSR_MHINT_DCACHE_PREF_DIST(3)	|
+			     CSR_MHINT_LPE			|
+			     CSR_MHINT_ICACHE_PREF		|
+			     CSR_MHINT_AMR			|
+			     CSR_MHINT_DCACHE_PREF);
+	csr_write(CSR_MHCR, CSR_MHCR_WBR | CSR_MHCR_BTB | CSR_MHCR_BPE |
+			    CSR_MHCR_RS  | CSR_MHCR_WB  | CSR_MHCR_WA | 0x3);
+	csr_write(CSR_MHINT2, CSR_MHINT2_LOCAL_ICG_EN(8)	|
+			      CSR_MHINT2_LOCAL_ICG_EN(3));
+	csr_write(CSR_MHINT4, 0x410);
+
 	/*
 	 * Set IOPMPs to the default attribute, allowing the application
 	 * processor to access various peripherals. Subsystem clocks should be
-- 
2.49.0

