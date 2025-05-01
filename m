Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6F0C3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 12:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EC4880FDE;
	Thu,  1 May 2025 14:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D3138056A; Thu,  1 May 2025 14:03:11 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D6D65820EB
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 14:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD80F1CE0;
 Thu,  1 May 2025 05:03:00 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C3563F673;
 Thu,  1 May 2025 05:03:05 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 3/5] lmb: staticise lmb_add_memory()
Date: Thu,  1 May 2025 17:32:37 +0530
Message-Id: <20250501120239.199829-4-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250501120239.199829-1-sughosh.ganu@linaro.org>
References: <20250501120239.199829-1-sughosh.ganu@linaro.org>
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

lmb_add_memory() is only called from the lmb module. Mark the function
as static.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 include/lmb.h | 8 --------
 lib/lmb.c     | 2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index be723d9162a..73df4e07248 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -120,14 +120,6 @@ int lmb_allocate_mem(enum lmb_mem_type type, u64 align, phys_addr_t *addr,
  */
 int lmb_init(void);
 
-/**
- * lmb_add_memory() - Add memory range for LMB allocations.
- *
- * Add the entire available memory range to the pool of memory that
- * can be used by the LMB module for allocations.
- */
-void lmb_add_memory(void);
-
 long lmb_add(phys_addr_t base, phys_size_t size);
 
 phys_size_t lmb_get_free_size(phys_addr_t addr);
diff --git a/lib/lmb.c b/lib/lmb.c
index a21f9c72204..55aca306a90 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -605,7 +605,7 @@ static __maybe_unused void lmb_reserve_common_spl(void)
 	}
 }
 
-void lmb_add_memory(void)
+static void lmb_add_memory(void)
 {
 	int i;
 	phys_addr_t bank_end;
-- 
2.34.1

