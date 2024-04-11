Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49816CD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFE51881DE;
	Thu, 11 Apr 2024 06:27:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="zk/iSFAb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A3AE881DE; Thu, 11 Apr 2024 06:27:45 +0200 (CEST)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [91.218.175.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7EEF88120
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712809663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xfQZmLAJaS+JWl2/qTwa8Q8cY1KW0DqPgpjLZrcd4E=;
 b=zk/iSFAbTmagFK4++wLcTmmdcLLRWM6axTCBwYtXjEs8hhcL+6JmTFtdfocXPryiKpjbN3
 7bGSAxusKMa+H5fGfyWjrAnNL5UN3HlPMw1nNPhG+TAgtNr91yxdh/6f16i+XXDQLdCDuZ
 UgSs8vJgAqwctOcA5DlGTfi+xsLatWf0jUNKReG6xh8F03U4GmbqTlBi2P3Tm4PlizZEi1
 Wy06VH651Ezxm+kW/MoEKfQkgvUqFXQ8F8uQWS6lGsPECKmUgKebzFG+m+NudPG9y7Ar7q
 IKqUA55mtyad+q0WKeiuuYXEfPH3GdxWd3KY+PVEdoyILAaedpa0ktsDLI8+Pg==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 14:25:23 +1000
Subject: [PATCH RFC 06/15] sunxi: enable support for SPI NAND booting on SUNIV
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-spinand-v1-6-62d31bb188e8@jookia.org>
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
In-Reply-To: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>, 
 Icenowy Zheng <uwu@icenowy.me>, Samuel Holland <samuel@sholland.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712809554; l=1197;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=GIHFo+VadtyezH1ouqQLkaMXEO69Jv0ZDQ7wBMpFGe8=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAZN4lCxmkCZVYUpL5GUPraOs
 BOxFr121RNHBgIjy3Ds+JalW+bB94Y6M4SxhBHHN1c4hN0NJbjXKWNVebsSSPDAUAAOkz
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

From: Icenowy Zheng <uwu@icenowy.me>

As we added support for SPI NAND to the existing SPL SPI codepath, route
the boot code to it when it detects the BROM loads SPL from SPI NAND, as
for SoCs with both SPI NAND and boot media indicator support, the boot
media indicator is the same for SPI NOR and NAND.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Reviewed-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/mach-sunxi/board.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index f4dbb2a740..9b0d68a7a0 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -223,12 +223,10 @@ static int suniv_get_boot_source(void)
 	case SUNIV_BOOTED_FROM_MMC0:
 		return SUNXI_BOOTED_FROM_MMC0;
 	case SUNIV_BOOTED_FROM_SPI:
+	case SUNIV_BOOTED_FROM_NAND:
 		return SUNXI_BOOTED_FROM_SPI;
 	case SUNIV_BOOTED_FROM_MMC1:
 		return SUNXI_BOOTED_FROM_MMC2;
-	/* SPI NAND is not supported yet. */
-	case SUNIV_BOOTED_FROM_NAND:
-		return SUNXI_INVALID_BOOT_SOURCE;
 	}
 	/* If we get here something went wrong try to boot from FEL.*/
 	printf("Unknown boot source from BROM: 0x%x\n", brom_call);

-- 
2.44.0

