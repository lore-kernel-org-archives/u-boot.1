Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0669C3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:37:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D460A888CC;
	Thu,  4 Jul 2024 09:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35B8B888B8; Thu,  4 Jul 2024 09:36:34 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 70C6C888B8
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5066DA7;
 Thu,  4 Jul 2024 00:36:54 -0700 (PDT)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEB043F762;
 Thu,  4 Jul 2024 00:36:26 -0700 (PDT)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [RFC PATCH v2 07/48] lmb: remove the unused lmb_is_reserved() function
Date: Thu,  4 Jul 2024 13:05:03 +0530
Message-Id: <20240704073544.670249-8-sughosh.ganu@linaro.org>
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

The lmb_is_reserved() API is not used. There is another API,
lmb_is_reserved_flags() which can be used to check if a particular
memory region is reserved. Remove the unused API.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since V1: None

 include/lmb.h | 11 -----------
 lib/lmb.c     |  5 -----
 2 files changed, 16 deletions(-)

diff --git a/include/lmb.h b/include/lmb.h
index 231b68b27d..6c50d93e83 100644
--- a/include/lmb.h
+++ b/include/lmb.h
@@ -117,17 +117,6 @@ phys_addr_t __lmb_alloc_base(struct lmb *lmb, phys_size_t size, ulong align,
 phys_addr_t lmb_alloc_addr(struct lmb *lmb, phys_addr_t base, phys_size_t size);
 phys_size_t lmb_get_free_size(struct lmb *lmb, phys_addr_t addr);
 
-/**
- * lmb_is_reserved() - test if address is in reserved region
- *
- * The function checks if a reserved region comprising @addr exists.
- *
- * @lmb:	the logical memory block struct
- * @addr:	address to be tested
- * Return:	1 if reservation exists, 0 otherwise
- */
-int lmb_is_reserved(struct lmb *lmb, phys_addr_t addr);
-
 /**
  * lmb_is_reserved_flags() - test if address is in reserved region with flag bits set
  *
diff --git a/lib/lmb.c b/lib/lmb.c
index 44f9820531..adc3abd5b4 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -565,11 +565,6 @@ int lmb_is_reserved_flags(struct lmb *lmb, phys_addr_t addr, int flags)
 	return 0;
 }
 
-int lmb_is_reserved(struct lmb *lmb, phys_addr_t addr)
-{
-	return lmb_is_reserved_flags(lmb, addr, LMB_NONE);
-}
-
 __weak void board_lmb_reserve(struct lmb *lmb)
 {
 	/* please define platform specific board_lmb_reserve() */
-- 
2.34.1

