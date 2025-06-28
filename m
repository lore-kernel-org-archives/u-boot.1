Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1AAC7EE39
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 22:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00E1F8206E;
	Sun, 29 Jun 2025 00:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=benettiengineering.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aruba.it header.i=@aruba.it header.b="jv4YFzN7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D975D8206E; Sun, 29 Jun 2025 00:19:53 +0200 (CEST)
Received: from smtpdh20-1.aruba.it (smtpdh20-1.aruba.it [62.149.155.164])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECA4580B9B
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 00:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=benettiengineering.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=giulio.benetti@benettiengineering.com
Received: from localhost.localdomain ([84.33.84.190])
 by Aruba SMTP with ESMTPSA
 id VdthuPF6Sqg4pVdthueayB; Sun, 29 Jun 2025 00:19:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
 t=1751149185; bh=cjgUeBTD9u4CqY2XOSqkcRhYbqidiFC1lHf17YT2OMQ=;
 h=From:To:Subject:Date:MIME-Version;
 b=jv4YFzN7uFX9dUs1raSITL/6twMc6FzetPO+rCTGD1HkvD/+QCLnEhLl8DpWUMDUr
 Gipow7JArWcvWgBVO+danfHVd97XG8e2CY1gBxJJitQiL7mUvsqzvSQ5xHksSZeHQO
 wMEbhJlCOhivCfQflI6lG1NXkakDO+h/1c14Q6jJDRj6eTWSxDGCmd1MZWXGN4MCer
 G32OMX8VpELykge3R9sQE1cPpkfj6K5qO6rDcl27Spz1X0BR05Qbs8frv6Ru1QC87k
 GHEoX2uJ+IGUTORzskdBanNFk5lSHhwkXESfl0KK0AzXKHgGQ5d6GtmO+h79I/YEKC
 HnQEESV/fnHfw==
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
To: Stefano Babic <sbabic@nabladev.com>,
	Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2] arch/arm/include/asm/arch-imxrt/gpio.h: imxrt gpio use
 common gpio.h
Date: Sun, 29 Jun 2025 00:19:44 +0200
Message-Id: <20250628221944.2412860-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAOMZO5BZR9e2EFKJho1QFM4B96L9oCKf=3+ZohfYujh7iFzUsg@mail.gmail.com>
References: <CAOMZO5BZR9e2EFKJho1QFM4B96L9oCKf=3+ZohfYujh7iFzUsg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJ10eueEB/SzepL+J0Q1rhtcc1C1/AqCCo7DR30wVZ5uOYMSo4pdXJiXSm639HslxikHx2cuiuYip2xq8DcIdB8+pGobG/ot6knLXxpjEqcTtRGpv/NE
 9D7NNYu5hwAyuUoB/UHVpxJxaaOURIbspJWNYRkQn2z8B6PPjiUnwLEZCjlt1Lem23JgmZ2/hDYcv7uG2otEPFU539tx7HEjJkCL0YeOL8ns5xi0OeHar2zA
 Omnjzb4b3IZ5fhGEv0vjg1dTGrlQcA+XdOhdrxt6IbPhf9ghMvYiN7xA2OQU+uVgKXvhkKL84MCghK+aLOhe0X9H2nnhucwoeJFKGCQhxYcmhpuKZM3OobQA
 osCeF0FuSaySXlc07QgSHdxUndFbc1Qk3PXD1+XSDzIQ6UqDbwc=
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

The current file defines a struct gpio_regs identical to the one in
<asm/mach-imx/gpio.h>. To eliminate code duplication and align with
the approach used for i.MX8M, include the common header instead of
redefining the struct.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
V1->V2:
* fix typo on subject and improve commit log as requested by Fabio Estevam
---
 arch/arm/include/asm/arch-imxrt/gpio.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm/include/asm/arch-imxrt/gpio.h b/arch/arm/include/asm/arch-imxrt/gpio.h
index da31a7438aa..be130e00652 100644
--- a/arch/arm/include/asm/arch-imxrt/gpio.h
+++ b/arch/arm/include/asm/arch-imxrt/gpio.h
@@ -7,13 +7,6 @@
 #ifndef __ASM_ARCH_GPIO_H__
 #define __ASM_ARCH_GPIO_H__
 
-#if !(defined(__KERNEL_STRICT_NAMES) || defined(__ASSEMBLY__))
-/* GPIO registers */
-struct gpio_regs {
-	u32 gpio_dr;	/* data */
-	u32 gpio_dir;	/* direction */
-	u32 gpio_psr;	/* pad satus */
-};
-#endif
+#include <asm/mach-imx/gpio.h>
 
 #endif /* __ASM_ARCH_GPIO_H__ */
-- 
2.39.5

