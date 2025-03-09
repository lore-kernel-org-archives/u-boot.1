Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CBCC282EC
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 02:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DAFF80F0B;
	Sun,  9 Mar 2025 03:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741486004;
	bh=xni/w+Kq967GihZxUuDRlLaRnQF6yNCYBcsqPUN1oi0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YHHtWrnluxt73AX5lsGLhCtEwsq9Bq72RMVlJ/7ldzCsbEerFNiSLFtjXYrjEQ1DM
	 3byguCcA0S4KRsJUb5XLuKrw9+G+ugz+01Y2AB6+feOXHiccnPDrccYaALk1vfu9Ch
	 JjLKTpa2RGyXYcUmRKZIRksPQo428U4b+ozM8BJWFEBClpOSh0P8/hNuRdl4kDOt5L
	 fU5xUWctx8bA10sKv8EVHGBfyE+qaS7IHl4Y+pKRvylQi2xCSiqYz4JjT7vNySjsmz
	 3DZpZeGHY4nLr0e5ED6zr7MDpMvxRm/Hi9Ww3x/kAXif20hm5+Gmk5G1T9IVH60zmJ
	 uudKmX/kwSLAQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86363810F5; Sun,  9 Mar 2025 03:06:42 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB5D18043C
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 03:06:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="TEo8Ljei"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C477610382F00; Sun,  9 Mar 2025 03:06:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741485998; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=xni/w+Kq967GihZxUuDRlLaRnQF6yNCYBcsqPUN1oi0=;
 b=TEo8LjeiMDoSZbMZ+ILRx1JmvnU+V1YDWr7y/JFyB1TNlJSbnvajqWJBjlXxGGMypnOnAH
 iEpBvma1pVuYWhwvPDxpI0vqCt5+OFa3pv+uP1iHwd1RZiDR3nBi0BMHJMo3075E2KksiE
 t3nwKFhFh4RzBfmI//m0Bx+vIbITatDsNKoNHz11h1V/HUMnV8LaZrJM4rATT+sG6sMb+k
 MljRhWI5y35f59E5nP09UviJ1t1wHnmVJHkJRrH5XVlq4R6TxUa1XFryS21QEyvIOntLai
 oaVU2quqyjmQpXyusmnrBUt+fI2LoF8yTLir0uSq+eOrPmLP4jm84p9AVjDg9g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32mp: Fix dram_bank_mmu_setup() for ram_top=0
Date: Sun,  9 Mar 2025 03:05:54 +0100
Message-ID: <20250309020623.1605623-1-marex@denx.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On STM32MP15xx with 1 GiB of DRAM, the gd->ram_top becomes 0,
because DRAM base 0xc0000000 + DRAM size 0x40000000 leads to
gd->ram_top overflow which resets it to 0. Handle this special
case simply by checking for gd->ram_top being zero, and if it
is, assume there is no addr >= gd->ram_top .

This fixes boot hang on STM32MP15xx with 1 GiB of DRAM.

Fixes: 25fb58e88aba ("ARM: stm32mp: Fix dram_bank_mmu_setup() for LMB located above ram_top")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Marek Vasut <marex@denx.de>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/mach-stm32mp/stm32mp1/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
index cb1b84c9af9..d5eaf6711b6 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
+++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
@@ -82,7 +82,7 @@ void dram_bank_mmu_setup(int bank)
 		option = DCACHE_DEFAULT_OPTION;
 		if (use_lmb &&
 		    (lmb_is_reserved_flags(i << MMU_SECTION_SHIFT, LMB_NOMAP) ||
-		    addr >= gd->ram_top)
+		     (gd->ram_top && addr >= gd->ram_top))
 		   )
 			option = 0; /* INVALID ENTRY in TLB */
 		set_section_dcache(i, option);
-- 
2.47.2

