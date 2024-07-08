Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607B4C3DA44
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 11:44:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6B1D886EE;
	Mon,  8 Jul 2024 13:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720439039;
	bh=pFos5dthmBQ8aWDdYOEHpJBAdqmUEX0q6stsFS39s+c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kiM3XauaBMN1O1b0HxjJQgNBe+QOCkrj4P7Su9yUJKm/AUQxsMmjKoRqx3taPnhdk
	 NSOiMUHZKsezi58wZR/UiucInboihLbGKAg9MIQ8BBpvx3AZkqklzGGm0BK/E0qogz
	 /YJAGE2GgcSXi7+AKpt4xAJPcCN8Ybc1ttjKpS0wfiYHtK/xI1BUg8E4v5bbv/2hZF
	 7cqkmDV2RCHjJ8Mlbp10y8BljCPgTx22jh3sc9CeqXFkdvWRQbioqX8EUPiN/FFAL3
	 u0ddj0azyl0q8KPNGDMnLVmN/hSXUyQJEShzC4/4zCKsbfqmqZ6zVmtIVhv4R5MBZT
	 2aXWlOhtJSkHw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3ED4E886F0;
 Mon,  8 Jul 2024 13:43:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1720439038;
 bh=pFos5dthmBQ8aWDdYOEHpJBAdqmUEX0q6stsFS39s+c=;
 h=From:To:Cc:Subject:Date:From;
 b=VukovIlduOef0qDa6ZNsZgtctmbEZMv7Vl50c03xjy+FALG9eWbshwijZj5VECNkn
 6OvdBLro8fuKHzNhj3L+yLeRk9b1DF94PQ8KpO3oD8h4HYAn91JiUllXlx7RykiUvF
 ZpQ8jKEPW/XpA6vD9t7fRhkM+XiL+LA6mYeM2z73Plk5y178tAv6JL+akZIarb9uRV
 eSzECjaW+/ucds4be5Ojh3BuK6W2LpdbaGTuVpg5gGOpSbnLpcgLCciIViObM1klNb
 u7iRsGSun+wupQO/MWzmebLHPYZFVHG6sP7jlfcZGgWUxQA/1pMOma6dKPLwezOpiv
 6Lx5pyyftrkog==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Fix secure_waitbits() mask check
Date: Mon,  8 Jul 2024 13:43:23 +0200
Message-ID: <20240708114344.18354-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Do not apply bitwise AND to register value and expected value, only
apply bitwise AND to register value and mask, and only then compare
the result with expected value that the function polls for.

Fixes: b49105320a5b ("stm32mp: psci: Implement PSCI system suspend and DRAM SSR")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/mach-stm32mp/stm32mp1/psci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/psci.c b/arch/arm/mach-stm32mp/stm32mp1/psci.c
index e99103910d9..ffdafea464d 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/psci.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/psci.c
@@ -393,8 +393,7 @@ static int __secure secure_waitbits(u32 reg, u32 mask, u32 val)
 	asm volatile("mrrc p15, 0, %Q0, %R0, c14" : "=r" (start));
 	for (;;) {
 		tmp = readl(reg);
-		tmp &= mask;
-		if ((tmp & val) == val)
+		if ((tmp & mask) == val)
 			return 0;
 		asm volatile("mrrc p15, 0, %Q0, %R0, c14" : "=r" (end));
 		if ((end - start) > delay)
-- 
2.43.0

