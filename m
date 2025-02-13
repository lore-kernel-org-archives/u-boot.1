Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270F6C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 13:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEEDF80F1A;
	Thu, 13 Feb 2025 14:11:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 314C080F03; Thu, 13 Feb 2025 14:11:41 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 14937806FE
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 14:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=sughosh.ganu@linaro.org
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 386AD16F3;
 Thu, 13 Feb 2025 05:11:59 -0800 (PST)
Received: from a079122.blr.arm.com (a079122.arm.com [10.162.17.48])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB3793F58B;
 Thu, 13 Feb 2025 05:11:35 -0800 (PST)
From: Sughosh Ganu <sughosh.ganu@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH 2/4] lmb: handle scenario of of encompassing overlap
Date: Thu, 13 Feb 2025 18:41:02 +0530
Message-Id: <20250213131104.186663-3-sughosh.ganu@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213131104.186663-1-sughosh.ganu@linaro.org>
References: <20250213131104.186663-1-sughosh.ganu@linaro.org>
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

The lmb_fix_over_lap_regions() function is called if the added region
overlaps with an existing region. The function then fixes the overlap
and removes the redundant region. However, it makes an assumption that
the overlap would not encompass the existing region, and in such a
scenario, it prints a message and returns without making the
fix. Handle the case of an encompassing overlap also in the function.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
---

Note: To be applied after an A-b/R-b/T-b from the original author
of the lmb_fix_over_lap_regions() function on this

 lib/lmb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index aeaf120f57d..a5216bdccc7 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -111,11 +111,9 @@ static void lmb_fix_over_lap_regions(struct alist *lmb_rgn_lst,
 	phys_addr_t base2 = rgn[r2].base;
 	phys_size_t size2 = rgn[r2].size;
 
-	if (base1 + size1 > base2 + size2) {
-		printf("This will not be a case any time\n");
-		return;
-	}
-	rgn[r1].size = base2 + size2 - base1;
+	if (base1 + size1 < base2 + size2)
+		rgn[r1].size = base2 + size2 - base1;
+
 	lmb_remove_region(lmb_rgn_lst, r2);
 }
 
-- 
2.34.1

