Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90A3CD8CA8
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 17:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9818984704;
	Fri, 12 Jun 2026 19:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="IsK/zLnu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B3A483FF5; Fri, 12 Jun 2026 16:27:39 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07298839A8
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 16:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=roberhu001@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id; bh=iKWleXEkdJXG24V
 XUiFy1zjvoudDOTrVwYJNYpeG6Hw=; b=IsK/zLnuYwVEHpVDhaMoJGyrR0knUWS
 0GLn/H5xCNuFzanyV87R5JhsWfkenK0fZLUo203Lw6fQUHmuviu+9EiiOenkG0Ap
 4QmnhSPVf86+03ZJOZfP+aZttsXu1AizGEnXu20XL4S5L1yCT/MyGEti419LWBqR
 K4bRl2Ogj2YA=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3_zZDFyxqE7bFCg--.588S2;
 Fri, 12 Jun 2026 22:27:16 +0800 (CST)
From: Zunyi Hu <roberhu001@163.com>
To: andre.przywara@arm.com
Cc: trini@konsulko.com, jernej.skrabec@gmail.com, u-boot@lists.denx.de,
 Zunyi Hu <roberhu001@163.com>
Subject: [PATCH] sunxi: board: Map suniv SPI NAND boot source
Date: Fri, 12 Jun 2026 22:27:05 +0800
Message-Id: <20260612142705.19673-1-roberhu001@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3_zZDFyxqE7bFCg--.588S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1kZF4kGw48XFW3Gw4Uurg_yoW8JFyDpw
 nxur1DGanYqFy29F9Iqa48XFWrZa17Ga4qgrnxJw1jk3Z7CF12qrsxKa98Aw1Yqr1rZrWr
 ur45WF4rZ3WDCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRQJ5bUUUUU=
X-Originating-IP: [183.11.142.211]
X-CM-SenderInfo: purev2tkxqiii6rwjhhfrp/xtbCvwR8GGosF0QnwwAA3u
X-Mailman-Approved-At: Fri, 12 Jun 2026 19:22:35 +0200
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

The Allwinner V3s (suniv) BROM returns SUNIV_BOOTED_FROM_NAND when
successfully booting from an attached SPI NAND flash. Currently, U-Boot
lacks the mapping and treats this as an invalid boot source.

Map this to SUNXI_BOOTED_FROM_SPI to ensure the boot environment and
device are correctly identified in U-Boot proper. Note that this patch
only corrects the boot source mapping; specific SPL SPI NAND loading
implementations are handled separately.

Tested-on: Allwinner V3s, SPI NAND boot.

Signed-off-by: Zunyi Hu <roberhu001@163.com>
---
 arch/arm/mach-sunxi/board.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 432b1c10f92..7f85bd0c7d3 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -238,9 +238,8 @@ static int suniv_get_boot_source(void)
 		return SUNXI_BOOTED_FROM_SPI;
 	case SUNIV_BOOTED_FROM_MMC1:
 		return SUNXI_BOOTED_FROM_MMC2;
-	/* SPI NAND is not supported yet. */
 	case SUNIV_BOOTED_FROM_NAND:
-		return SUNXI_INVALID_BOOT_SOURCE;
+		return SUNXI_BOOTED_FROM_SPI;
 	}
 	/* If we get here something went wrong try to boot from FEL.*/
 	printf("Unknown boot source from BROM: 0x%x\n", brom_call);
-- 
2.17.1

