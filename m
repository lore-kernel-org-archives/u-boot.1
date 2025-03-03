Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DEAC282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 13:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED9CB81280;
	Mon,  3 Mar 2025 14:33:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC37981335; Mon,  3 Mar 2025 14:33:14 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 5F9B681280
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 14:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3FBD113E;
 Mon,  3 Mar 2025 05:33:25 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BC763F673;
 Mon,  3 Mar 2025 05:33:09 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 6/6] lmb: optimise the lmb allocation functions
Date: Mon,  3 Mar 2025 19:02:31 +0530
Message-Id: <20250303133231.405279-7-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303133231.405279-1-sughosh.ganu@linaro.org>
References: <20250303133231.405279-1-sughosh.ganu@linaro.org>
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

The actual logic to allocate a region of memory is in the
_lmb_alloc_base() function. The lmb_alloc() API function calls
lmb_alloc_base(), which then calls _lmb_alloc_base() to do the
allocation. Instead, call the _lmb_alloc_base() directly from both the
allocation API's, and move the error message to the _lmb_alloc_base().

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V2:
* Change the print for allocation failure into a debug message as per
  suggestion from Heinrich

 lib/lmb.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index b42a512f6c0..981ea1b2ca0 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -724,26 +724,22 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
 			base = ALIGN_DOWN(res_base - size, align);
 		}
 	}
+
+	log_debug("%s: Failed to allocate 0x%lx bytes below 0x%lx\n",
+		  __func__, (ulong)size, (ulong)max_addr);
+
 	return 0;
 }
 
 phys_addr_t lmb_alloc(phys_size_t size, ulong align)
 {
-	return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE, LMB_NONE);
+	return _lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE, LMB_NONE);
 }
 
 phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
 			   uint flags)
 {
-	phys_addr_t alloc;
-
-	alloc = _lmb_alloc_base(size, align, max_addr, flags);
-
-	if (alloc == 0)
-		printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
-		       (ulong)size, (ulong)max_addr);
-
-	return alloc;
+	return _lmb_alloc_base(size, align, max_addr, flags);
 }
 
 phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)
-- 
2.34.1

