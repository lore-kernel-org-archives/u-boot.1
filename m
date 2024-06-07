Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA875C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 18:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2909884BE;
	Fri,  7 Jun 2024 20:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2C67884BC; Fri,  7 Jun 2024 20:53:57 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id EB309884A7
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 20:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9C101480;
 Fri,  7 Jun 2024 11:54:19 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1D123F792;
 Fri,  7 Jun 2024 11:53:52 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH 07/31] lmb: remove lmb_init_and_reserve_range() function
Date: Sat,  8 Jun 2024 00:22:16 +0530
Message-Id: <20240607185240.1892031-8-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
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

With the move to make the LMB allocations persistent and the common
memory regions being reserved during board init, the
lmb_init_and_reserve_range() API can be replaced with a simple
lmb_add() call.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
 boot/bootm.c  | 2 +-
 include/lmb.h | 2 --
 lib/lmb.c     | 8 --------
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index cd1003120c..73e72a710d 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -248,7 +248,7 @@ static void boot_start_lmb(void)
 	mem_start = env_get_bootm_low();
 	mem_size = env_get_bootm_size();
 
-	lmb_init_and_reserve_range(mem_start, mem_size, NULL);
+	lmb_add(mem_start, mem_size);
 }
 #else
 #define lmb_reserve(base, size)
diff --git a/include/lmb.h b/include/lmb.h
index d2b829ace1..f3e3f716e5 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -85,8 +85,6 @@ struct lmb {
 };
 
 void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob);
-void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
-				void *fdt_blob);
 long lmb_add(phys_addr_t base, phys_size_t size);
 long lmb_reserve(phys_addr_t base, phys_size_t size);
 /**
diff --git a/lib/lmb.c b/lib/lmb.c
index 8003aae6f7..5c056800c3 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -253,14 +253,6 @@ void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob)
 	lmb_reserve_common(fdt_blob);
 }
 
-/* Initialize the struct, add memory and call arch/board reserve functions */
-void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
-				void *fdt_blob)
-{
-	lmb_add(base, size);
-	lmb_reserve_common(fdt_blob);
-}
-
 /* This routine called with relocation disabled. */
 static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
 				 phys_size_t size, enum lmb_flags flags)
-- 
2.34.1

