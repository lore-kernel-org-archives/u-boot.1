Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438B4CD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 642C187F1E;
	Thu, 11 Apr 2024 06:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="LgWlp8mz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B58187F1E; Thu, 11 Apr 2024 06:26:56 +0200 (CEST)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com
 [91.218.175.178])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F05F987D8E
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712809612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NCLxEs15xpPjw4EBMO0macnyKP0cJxProVVji/MKH0k=;
 b=LgWlp8mzqZ1zDWMa8lF2CVh/JOLwV63mhtuL0g7c0llMWadi/uviL80vpBz1agDjcqDRe4
 dDtVh82M/BqsRY517lUW6y+QHSKmiwp/qd0q2YKJFGiWYrYxHgY/BUyGgOK1oniKE/6OCL
 3mJP6FF+4f8NVN3CxET4jOdyKbjHZIOJ5vH+ZqAFCl+AqjaiDIDUKSU4kfzfGC6eg4jjX6
 P/dN2Ms6+pX5pIWPmxEgPSJ/k7D9SQZP1TxHORWeYSp7cmcCwrboU6BbkVEK64OJ3VwfS0
 J0HNLx6LbKy7fctajGn3+2rXBjnvWaNE1ylnCJkr3DK75rbWzH5/6b1pLYqyvg==
From: John Watts <contact@jookia.org>
Subject: [PATCH RFC 00/15] Support SPI NAND booting on the T113
Date: Thu, 11 Apr 2024 14:25:17 +1000
Message-Id: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC1mF2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0ND3eKCzLzEvBTd1CTzFAtjQ0sLQ+MkJaDqgqLUtMwKsEnRSkFuzkq
 xtbUA0T/ee14AAAA=
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>, 
 Maksim Kiselev <bigunclemax@gmail.com>, Sam Edwards <CFSworks@gmail.com>, 
 Icenowy Zheng <uwu@icenowy.me>, Samuel Holland <samuel@sholland.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712809527; l=2185;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=4/7aYLEqMPIX+CWQATKyoWd1casydJstCGlxGIQRSjA=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABABDKM3Mx3ishpHd6qk8sENcs
 1uPFaXVYbM7j6xHf+v2SD+3DLs6mgh2MfRh+DpGuHPCHbM4OiY83KfTJQDNBQAgUAAOkG
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

This series is my current working and tested setup for booting from
SPI NAND chips on the Allwinner T113.

I have included the following patches from others. I may have modified
them to work with the latest mainline:

https://lore.kernel.org/all/20221014030520.3067228-1-uwu@icenowy.me/
https://lore.kernel.org/all/20231111133432.755363-2-bigunclemax@gmail.com/

Hopefully this can get the ball rolling on how to properly implement
SPI NAND support in mainline U-Boot.

Signed-off-by: John Watts <contact@jookia.org>
---
Icenowy Zheng (5):
      sunxi: SPL SPI: extract code for doing SPI transfer
      sunxi: SPL SPI: add support for read command with 2 byte address
      sunxi: SPL SPI: allow multiple boot attempt
      sunxi: SPL SPI: add initial support for booting from SPI NAND
      sunxi: enable support for SPI NAND booting on SUNIV

John Watts (9):
      sunxi: Separate boot device and boot position
      spl: Add BOOT_DEVICE_SPINAND option
      sunxi: Implement BOOT_DEVICE_SPINAND in SPL
      spl: Add SPL_SPINAND configuration options
      sunxi: Use SPL_SPINAND for configuration
      nand: Add spinand_ helper functions
      sunxi: Implement spinand_ helpers
      spl: Support SPI NAND boot in UBI
      spl: Support loading FIT images in UBI

Maksim Kiselev (1):
      sunxi: SPL SPI: Add SPI boot support for the Allwinner R528/T113 SoCs

 arch/arm/include/asm/arch-sunxi/spl.h |   3 +-
 arch/arm/include/asm/spl.h            |   1 +
 arch/arm/mach-sunxi/Kconfig           |   2 +-
 arch/arm/mach-sunxi/board.c           |  31 +--
 arch/arm/mach-sunxi/spl_spi_sunxi.c   | 348 +++++++++++++++++++++++++---------
 arch/mips/include/asm/spl.h           |   1 +
 arch/riscv/include/asm/spl.h          |   1 +
 arch/sandbox/include/asm/spl.h        |   1 +
 common/spl/Kconfig                    |  21 ++
 common/spl/spl_ubi.c                  |  49 ++++-
 include/nand.h                        |   3 +
 11 files changed, 354 insertions(+), 107 deletions(-)
---
base-commit: 777c28460947371ada40868dc994dfe8537d7115
change-id: 20240411-spinand-eb7d8319813b

Best regards,
-- 
John Watts <contact@jookia.org>

