Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0015C3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12641888EA;
	Thu,  4 Jul 2024 09:37:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF44888A9; Thu,  4 Jul 2024 09:37:13 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 3160588919
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B16E51063;
 Thu,  4 Jul 2024 00:37:35 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D6123F762;
 Thu,  4 Jul 2024 00:37:07 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 18/48] lmb: introduce a function to add memory to the
 lmb memory map
Date: Thu,  4 Jul 2024 13:05:14 +0530
Message-Id: <20240704073544.670249-19-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704073544.670249-1-sughosh.ganu@linaro.org>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
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

Introduce a function lmb_add_memory() to add available memory to the
LMB memory map. Call this function during board init once the LMB data
structures have been initialised.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1:
* Add memory only till ram_top to the LMB memory map, instead of all
  enumerated memory.

 include/lmb.h | 11 +++++++++++
 lib/lmb.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/lmb.h b/include/lmb.h
index 27cdb18c37..d0c094107c 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -36,6 +36,17 @@ struct lmb_region {
 	enum lmb_flags flags;
 };
 
+/**
+ * lmb_add_memory() - Add memory range for LMB allocations
+ *
+ * Add the entire available memory range to the pool of memory that
+ * can be used by the LMB module for allocations.
+ *
+ * Return: None
+ *
+ */
+void lmb_add_memory(void);
+
 long lmb_add(phys_addr_t base, phys_size_t size);
 long lmb_reserve(phys_addr_t base, phys_size_t size);
 /**
diff --git a/lib/lmb.c b/lib/lmb.c
index a46bc8a7a3..e4733b82ac 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -239,6 +239,46 @@ void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob)
 	lmb_reserve_common(fdt_blob);
 }
 
+/**
+ * lmb_add_memory() - Add memory range for LMB allocations
+ *
+ * Add the entire available memory range to the pool of memory that
+ * can be used by the LMB module for allocations.
+ *
+ * This can be overridden for specific boards/architectures.
+ *
+ * Return: None
+ *
+ */
+__weak void lmb_add_memory(void)
+{
+	int i;
+	phys_size_t size;
+	phys_addr_t rgn_top;
+	u64 ram_top = gd->ram_top;
+	struct bd_info *bd = gd->bd;
+
+	/* Assume a 4GB ram_top if not defined */
+	if (!ram_top)
+		ram_top = 0x100000000ULL;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		size = bd->bi_dram[i].size;
+		if (size) {
+			if (bd->bi_dram[i].start > ram_top)
+				continue;
+
+			rgn_top = bd->bi_dram[i].start +
+				bd->bi_dram[i].size;
+
+			if (rgn_top > ram_top )
+				size -= rgn_top - ram_top;
+
+			lmb_add(bd->bi_dram[i].start, size);
+		}
+	}
+}
+
 /* Initialize the struct, add memory and call arch/board reserve functions */
 void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
 				void *fdt_blob)
@@ -710,5 +750,7 @@ int lmb_mem_regions_init(void)
 		return -1;
 	}
 
+	lmb_add_memory();
+
 	return 0;
 }
-- 
2.34.1

