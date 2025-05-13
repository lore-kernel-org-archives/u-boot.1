Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875B2C3ABC9
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 09:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B2DF82998;
	Tue, 13 May 2025 11:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="FuRDGeJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF1BD82A0A; Tue, 13 May 2025 11:05:30 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B42848295C
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 11:05:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 7B14C25C08;
 Tue, 13 May 2025 11:05:28 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lQ_RrHdJqzfc; Tue, 13 May 2025 11:05:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1747127127; bh=YtAGSh6dG6NQnXn0Wx+FwLsYnuSchS0ZnIznGnDbEsA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FuRDGeJkEGd4ezQgXkiQ8yeFfwqibvUfeSWgzsSh9guBwEw9a4CG64juiE/HxIJCi
 PcKNSM5nag0GfhtiUS0RwA4FL0nosm0vPv74b323Ll4Spcabss88UK9tFEFPWGi+FB
 axUZWj/YkaCSHKJYpJW+F9BnqpD6u+DhxbGkyhIqIdADGgWkxlyX+7Yh9fY7w/4V0O
 SKt0J3+E6q5p9jQTqACd9zvdUzfBhHeobT7KtCGLqTf4J89s79bhfkbOvVZekFnQCr
 ukJQsI3x3TW+uqhgBDo9e2c1qSsTs3RjmtgDRTEzK3m8B84W/cMM8+YfTSVXGTHbXJ
 MQ7No3+RqxKXw==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Vaishnav Achath <vaishnav.a@ti.com>, Andrew Davis <afd@ti.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH v2 01/10] riscv: lib: Split out support for T-Head cache
 management operations
Date: Tue, 13 May 2025 09:04:54 +0000
Message-ID: <20250513090503.46670-2-ziyao@disroot.org>
In-Reply-To: <20250513090503.46670-1-ziyao@disroot.org>
References: <20250513090503.46670-1-ziyao@disroot.org>
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

Designed before a standard set of cache management operations defined in
RISC-V, earlier T-Head cores like C906 and C910 provide CMO through the
customized extension XTheadCMO, which has been used in the CV1800B port
of U-Boot.

This patch splits XTheadCMO-related code into a generic module, allowing
SoCs shipping T-Head cores to share the code.

Link: https://github.com/XUANTIE-RV/thead-extension-spec
Signed-off-by: Yao Zi <ziyao@disroot.org>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/Kconfig                                  | 8 ++++++++
 arch/riscv/cpu/cv1800b/Kconfig                      | 1 +
 arch/riscv/cpu/cv1800b/Makefile                     | 1 -
 arch/riscv/lib/Makefile                             | 1 +
 arch/riscv/{cpu/cv1800b/cache.c => lib/thead_cmo.c} | 0
 5 files changed, 10 insertions(+), 1 deletion(-)
 rename arch/riscv/{cpu/cv1800b/cache.c => lib/thead_cmo.c} (100%)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index b24623590f2..dc36d9b8566 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -77,6 +77,14 @@ config SYS_DCACHE_OFF
 	help
 	  Do not enable data cache in U-Boot.
 
+config SYS_CACHE_THEAD_CMO
+	bool "THEAD non-standard cache operations"
+	depends on !SYS_DCACHE_OFF
+	default n
+	help
+	  Support for non-standard cache management operations on SoCs based on
+	  T-Head C906/C910 cores.
+
 config SPL_SYS_DCACHE_OFF
 	bool "Do not enable dcache in SPL"
 	depends on SPL
diff --git a/arch/riscv/cpu/cv1800b/Kconfig b/arch/riscv/cpu/cv1800b/Kconfig
index 7225b1210c5..57f724ae043 100644
--- a/arch/riscv/cpu/cv1800b/Kconfig
+++ b/arch/riscv/cpu/cv1800b/Kconfig
@@ -6,6 +6,7 @@ config SOPHGO_CV1800B
 	bool
 	select ARCH_EARLY_INIT_R
 	select SYS_CACHE_SHIFT_6
+	select SYS_CACHE_THEAD_CMO
 	imply CPU
 	imply CPU_RISCV
 	imply RISCV_TIMER
diff --git a/arch/riscv/cpu/cv1800b/Makefile b/arch/riscv/cpu/cv1800b/Makefile
index 95beb34b51a..da12e0f64e1 100644
--- a/arch/riscv/cpu/cv1800b/Makefile
+++ b/arch/riscv/cpu/cv1800b/Makefile
@@ -4,4 +4,3 @@
 
 obj-y += dram.o
 obj-y += cpu.o
-obj-y += cache.o
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 189b35c24d3..db8d235c699 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_CMD_BOOTI) += bootm.o image.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-y	+= cache.o
 obj-$(CONFIG_SIFIVE_CACHE) += sifive_cache.o
+obj-$(CONFIG_SYS_CACHE_THEAD_CMO) += thead_cmo.o
 ifeq ($(CONFIG_$(PHASE_)RISCV_MMODE),y)
 obj-$(CONFIG_$(PHASE_)RISCV_ACLINT) += aclint_ipi.o
 obj-$(CONFIG_ANDES_PLICSW) += andes_plicsw.o
diff --git a/arch/riscv/cpu/cv1800b/cache.c b/arch/riscv/lib/thead_cmo.c
similarity index 100%
rename from arch/riscv/cpu/cv1800b/cache.c
rename to arch/riscv/lib/thead_cmo.c
-- 
2.49.0

