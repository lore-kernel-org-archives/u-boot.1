Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD58CD4F59
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 08:30:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F126788CC2;
	Thu,  5 Sep 2024 10:29:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B383888CA2; Thu,  5 Sep 2024 10:29:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B332188CC0
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 10:29:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0EC2FEC;
 Thu,  5 Sep 2024 01:29:32 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE1EE3F66E;
 Thu,  5 Sep 2024 01:29:03 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 11/16] lmb: allow for boards to specify memory map
Date: Thu,  5 Sep 2024 13:58:06 +0530
Message-Id: <20240905082811.1585467-12-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
References: <20240905082811.1585467-1-sughosh.ganu@linaro.org>
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

Some architectures have special or unique aspects which need
consideration when adding memory ranges to the list of available
memory map. Enable this config in such scenarios which allow
architectures and boards to define their own memory map.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 include/lmb.h |  2 ++
 lib/Kconfig   | 18 ++++++++++++++++++
 lib/lmb.c     |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/include/lmb.h b/include/lmb.h
index f711b8fac8..6ef03f9b63 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -116,6 +116,8 @@ long lmb_free_flags(phys_addr_t base, phys_size_t size, uint flags);
 void lmb_dump_all(void);
 void lmb_dump_all_force(void);
 
+void lmb_arch_add_memory(void);
+
 struct lmb *lmb_get(void);
 int lmb_push(struct lmb *store);
 void lmb_pop(struct lmb *store);
diff --git a/lib/Kconfig b/lib/Kconfig
index 2e73cda580..f2fb90c12d 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1127,6 +1127,24 @@ config SPL_LMB
 	  SPL. This will require a malloc() implementation for defining
 	  the data structures needed for maintaining the LMB memory map.
 
+config LMB_ARCH_MEM_MAP
+	bool "Add an architecture specific memory map"
+	depends on LMB
+	help
+	  Some architectures have special or unique aspects which need
+	  consideration when adding memory ranges to the list of available
+	  memory map. Enable this config in such scenarios which allow
+	  architectures and boards to define their own memory map.
+
+config SPL_LMB_ARCH_MEM_MAP
+	bool "Add an architecture specific memory map"
+	depends on SPL_LMB
+	help
+	  Some architectures have special or unique scenarios which need
+	  consideration when adding memory ranges to the list of available
+	  memory map. Enable this config in such scenarios which allow
+	  architectures and boards to define their own memory map.
+
 config PHANDLE_CHECK_SEQ
 	bool "Enable phandle check while getting sequence number"
 	help
diff --git a/lib/lmb.c b/lib/lmb.c
index aff2830cb9..ec5078527e 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -309,6 +309,9 @@ void lmb_add_memory(void)
 	u64 ram_top = gd->ram_top;
 	struct bd_info *bd = gd->bd;
 
+	if (CONFIG_IS_ENABLED(LMB_ARCH_MEM_MAP))
+		return lmb_arch_add_memory();
+
 	/* Assume a 4GB ram_top if not defined */
 	if (!ram_top)
 		ram_top = 0x100000000ULL;
-- 
2.34.1

