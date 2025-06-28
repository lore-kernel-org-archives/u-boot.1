Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5840C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 28 Jun 2025 21:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8380182B34;
	Sat, 28 Jun 2025 23:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=benettiengineering.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aruba.it header.i=@aruba.it header.b="UPB77MCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF95E82DA1; Sat, 28 Jun 2025 23:47:03 +0200 (CEST)
Received: from smtpdh20-2.aruba.it (smtpdh20-2.aruba.it [62.149.155.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A9A982977
 for <u-boot@lists.denx.de>; Sat, 28 Jun 2025 23:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=benettiengineering.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=giulio.benetti@benettiengineering.com
Received: from localhost.localdomain ([84.33.84.190])
 by Aruba SMTP with ESMTPSA
 id VdNxuP0vFqg4pVdNxueXMy; Sat, 28 Jun 2025 23:46:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
 t=1751147217; bh=qduT7FvIQ+GpbnjokndKde1ahizGL3fjfCcE4PTmnrg=;
 h=From:To:Subject:Date:MIME-Version;
 b=UPB77MCSX1LWgETkSNw/Lo7MOrlcf05S8ChifrtaDAFmJwobbKiHlLRsNluRuqtK2
 mEYEjqG/SSV5IQs55eBtloOoGpaausaxmPTCyXBkfzvCa8uFIHmOw/fLTggC5f4zyD
 aMRrknq/LBzH5TK3vacdihTScIUwDNOzGOd8KbW84LOO+KUYPKr0GuAXmmlUHbOoyU
 Pn9Vko2Dpo1p8r+jrcFeY+n7JFZt9fJkIHQxrhD7WvcIIukS26aDJHbzYkV7o59wUZ
 EepHJlYNY6L7uCHa7jHhDwsh5xyB8h+UUBuZg66V38qT4XQ6LvIUOmSURlYm9a1rRi
 w7z2+cJzrQEAA==
From: Giulio Benetti <giulio.benetti@benettiengineering.com>
To: Stefano Babic <sbabic@nabladev.com>,
	Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 u-boot@lists.denx.de
Subject: [PATCH] arch/arm/include/asm/arch-imxrt/gpio.h: imxrt gpio use
 commong gpio.h
Date: Sat, 28 Jun 2025 23:46:56 +0200
Message-Id: <20250628214656.2395915-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfMqn2+msqRMJi0IXmFdzURIbJuOB/B0u6gM9w09KZe+kQpWpuamWWqlZlB9sXhNnL+7LXmI0nquQyYGjdbvfCeK/z/68olfu3IcaLOxoHz2DnE6Pq/5X
 869Y4QgWNWipKeicFpOUnw2dZay+YTywXo5gXqvLEm03XZMA0eFnE/DewSWlNT/DjtV5q3YsKTrWXJltrgOJZvNhe0XLMLJUGVnTimqW5vvmo/h0PSaCr8nM
 8B2muRxA0MFjFU/LuUt4b288s1ipoWa6tfjJOm5GZBCNfOLgoJmt3+fMCJhzLZdFWM+ZahxmaBZ/XxBy/vu/xxbLYsox0Qvt8b7ZIVE8uL1rzu2e7uVIXK0+
 NUK7Wv9RtPWP/2zcP5E3SWKzCNk47+EdJxX0dXI4JV5ZQVkltNU=
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

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
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

