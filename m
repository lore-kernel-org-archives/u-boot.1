Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7A5C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 09:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 384AC80C98;
	Thu, 20 Feb 2025 10:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2BDD80F7B; Thu, 20 Feb 2025 10:57:37 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9F37780C98
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 10:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D16F1BB0;
 Thu, 20 Feb 2025 01:57:53 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58CBE3F59E;
 Thu, 20 Feb 2025 01:57:32 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 4/6] lmb: remove superfluous address overlap check from
 lmb_add_region_flags()
Date: Thu, 20 Feb 2025 15:26:52 +0530
Message-Id: <20250220095654.121634-5-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250220095654.121634-1-sughosh.ganu@linaro.org>
References: <20250220095654.121634-1-sughosh.ganu@linaro.org>
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

The lmb_reserve() function now does a check for a reservation request
with existing reserved regions, and returns -EEXIST in case of an
overlap. Remove this now redundant check from lmb_add_region_flags().

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
---
Changes since V1: New patch

 lib/lmb.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 45888989457..061f9a07541 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -199,9 +199,6 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
 			coalesced++;
 			break;
 		} else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
-			if (flags != LMB_NONE)
-				return -EEXIST;
-
 			ret = lmb_resize_regions(lmb_rgn_lst, i, base, size);
 			if (ret < 0)
 				return -1;
-- 
2.34.1

