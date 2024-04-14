Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCCAC4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 18:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 545A588124;
	Sun, 14 Apr 2024 20:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713119937;
	bh=vvbY4rgNYy0L0mmDHyHQv92j8o1c/3R7HzJfmAN2n3M=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NBoCqAtWAqfU+SiIogw02/M8hbdjDr+0Nk7IQ7NDaN7NfnZICaT/OgnmtI3SkdXZJ
	 azJimG2T8EAsOfOMXV3gOB0tuzGSxjHakB7w+AVe3JcWnpOcTRdTIBQXbolMpEUyBX
	 B5NJZnwjhEK/h6KUoKTlRNNZM0K21g4uYKZ26wbyyCMu2yhoJT0aoVO+XsRawvvXT4
	 QmqsiuSZFHrX3ziChoTQIipTDHbVs1p/9Pf/KUPqrQLbTtDo6x3Sn82/rB95dMbLHv
	 f8ydmY3yfIaheiIYnyytlTyEF5HEryniLjY9jO1Nbdo8NhFWIDUOBJ+CFxQJ2Z/jX8
	 aACJVRurmsbUQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B8B9288059;
 Sun, 14 Apr 2024 20:38:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713119936;
 bh=vvbY4rgNYy0L0mmDHyHQv92j8o1c/3R7HzJfmAN2n3M=;
 h=From:To:Cc:Subject:Date:From;
 b=Yfm93qsvnxCr5TiVsVYWGNaJnQU/o5sQ0KK35KQpaYFpNXpvnqfFVp7ESh+Nxgd3l
 WPrAN+jSrTEUMhbfX1rbZBWgBwKezeEZiftdXYwr+BUWD5LEfTvQRITxDOIV3AAYEN
 B25D3ah9M3bS8Aka/4uXwnTK/C5C5g/zg17loOPfQOsHQetwvnQ00gitvRhr1oBCWC
 Fp2Gmbykrn8pPBV9bUHyCCbAoy0w4FBChQ0BL0hgF3gD2YPeJJTIDA4VucdP+PcZt2
 5ZNtrXoSizuGFDzuUVYFTYNGl2tyhUxb9t1+0U1NrMllMu5NpvvFhJOB2CXJIKsakD
 KLqDkk/uf9Ccw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Igor Opaniuk <igor.opaniuk@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] ARM: stm32: Drop superfluous Makefile entry for ecdsa_romapi.o
Date: Sun, 14 Apr 2024 20:38:31 +0200
Message-ID: <20240414183843.146985-1-marex@denx.de>
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

The source file is in arch/arm/mach-stm32mp/ecdsa_romapi.c and not
in arch/arm/mach-stm32mp/stm32mp1/ecdsa_romapi.c . There are two
Makefile entries in each subdirectory. Drop the bogus one and keep
only the correct one, the one in arch/arm/mach-stm32mp/Makefile .

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: uboot-stm32@st-md-mailman.stormreply.com
---
 arch/arm/mach-stm32mp/stm32mp1/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-stm32mp/stm32mp1/Makefile b/arch/arm/mach-stm32mp/stm32mp1/Makefile
index 857148747ef..ebae50f66c9 100644
--- a/arch/arm/mach-stm32mp/stm32mp1/Makefile
+++ b/arch/arm/mach-stm32mp/stm32mp1/Makefile
@@ -8,7 +8,6 @@ obj-y += cpu.o
 obj-$(CONFIG_STM32MP13X) += stm32mp13x.o
 obj-$(CONFIG_STM32MP15X) += stm32mp15x.o
 
-obj-$(CONFIG_STM32_ECDSA_VERIFY) += ecdsa_romapi.o
 ifdef CONFIG_SPL_BUILD
 obj-y += spl.o
 obj-y += tzc400.o
-- 
2.43.0

