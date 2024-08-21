Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE17C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 11:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5205488DC7;
	Wed, 21 Aug 2024 13:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76E7E88C04; Wed, 21 Aug 2024 13:00:10 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7CD6E88DB7
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 13:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A98AFDA7;
 Wed, 21 Aug 2024 04:00:33 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 489813F73B;
 Wed, 21 Aug 2024 04:00:04 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 18/27] lmb: remove the unused board_lmb_reserve() function
Date: Wed, 21 Aug 2024 16:28:30 +0530
Message-Id: <20240821105839.2870293-19-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
References: <20240821105839.2870293-1-sughosh.ganu@linaro.org>
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

The board_lmb_reserve() function is not being used, and currently
there is only an empty weak function defined. Remove this unused
function.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2: New patch

 include/lmb.h | 2 --
 lib/lmb.c     | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 6e435bd35c..79bd2457d3 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -107,8 +107,6 @@ long lmb_free(phys_addr_t base, phys_size_t size);
 void lmb_dump_all(void);
 void lmb_dump_all_force(void);
 
-void board_lmb_reserve(void);
-
 #if CONFIG_IS_ENABLED(UNIT_TEST)
 struct lmb *lmb_get(void);
 int lmb_push(struct lmb *store);
diff --git a/lib/lmb.c b/lib/lmb.c
index 1116b2b868..11959760b6 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -221,7 +221,6 @@ static void lmb_reserve_uboot_region(void)
 
 static void lmb_reserve_common(void *fdt_blob)
 {
-	board_lmb_reserve();
 	lmb_reserve_uboot_region();
 
 	if (CONFIG_IS_ENABLED(OF_LIBFDT) && fdt_blob)
@@ -688,11 +687,6 @@ int lmb_is_reserved_flags(phys_addr_t addr, int flags)
 	return 0;
 }
 
-__weak void board_lmb_reserve(void)
-{
-	/* please define platform specific board_lmb_reserve() */
-}
-
 static int lmb_setup(void)
 {
 	bool ret;
-- 
2.34.1

