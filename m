Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36810CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 14:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E30D84698;
	Fri,  1 Sep 2023 16:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75366846EE; Fri,  1 Sep 2023 16:29:21 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 9D56484003
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 16:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.02,219,1688396400"; d="scan'208";a="178445398"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2023 23:29:13 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.179])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 909B04227DD2;
 Fri,  1 Sep 2023 23:29:11 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de,
	Joe Hershberger <joe.hershberger@ni.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH] env: Improve ENV_OFFSET help message
Date: Fri,  1 Sep 2023 15:28:59 +0100
Message-Id: <20230901142859.1569900-1-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
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

When reading Kconfig help messages to understand ENV_OFFSET and
ENV_OFFSET_REDUND, developers may not realise that they need to also
look at the chosen ENV_IS_IN_* options to see how the offsets will be
interpreted.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 env/Kconfig | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/env/Kconfig b/env/Kconfig
index 13e32104b4c1..66a918c6fe5f 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -576,7 +576,12 @@ config ENV_OFFSET
 	default 0x260000 if ARCH_OMAP2PLUS
 	default 0x1080000 if MICROBLAZE && ENV_IS_IN_SPI_FLASH
 	help
-	  Offset from the start of the device (or partition)
+	  Offset from the start of the device (or partition).
+
+	  This offset may be interpreted differently depending on the chosen
+	  ENV_IS_IN_* options. For example, for ENV_IS_IN_MMC=y, this offset may
+	  be negative to indicate an offset backwards from the end of the
+	  partition. See the relevant help messages for more details.
 
 config ENV_OFFSET_REDUND
 	hex "Redundant environment offset"
@@ -588,6 +593,11 @@ config ENV_OFFSET_REDUND
 	  Offset from the start of the device (or partition) of the redundant
 	  environment location.
 
+	  This offset may be interpreted differently depending on the chosen
+	  ENV_IS_IN_* options. For example, for ENV_IS_IN_MMC=y, this offset may
+	  be negative to indicate an offset backwards from the end of the
+	  partition. See the relevant help messages for more details.
+
 config ENV_SIZE
 	hex "Environment Size"
 	default 0x40000 if ENV_IS_IN_SPI_FLASH && ARCH_ZYNQMP
-- 
2.34.1

