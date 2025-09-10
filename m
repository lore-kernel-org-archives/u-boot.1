Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F897CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 09:25:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C67118318E;
	Wed, 10 Sep 2025 11:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE5A083214; Wed, 10 Sep 2025 11:25:18 +0200 (CEST)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id 4027482B20
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 11:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hayashi.kunihiko@socionext.com
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 10 Sep 2025 18:25:15 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
 by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id 0AFEE2091499;
 Wed, 10 Sep 2025 18:25:15 +0900 (JST)
Received: from kinkan3.css.socionext.com ([172.31.9.51]) by m-FILTER with
 ESMTP; Wed, 10 Sep 2025 18:25:15 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
 by kinkan3.css.socionext.com (Postfix) with ESMTP id 915031757;
 Wed, 10 Sep 2025 18:25:14 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: u-boot@lists.denx.de
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tom Rini <trini@konsulko.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] ARM: Remove mistyped GICV3 definition from ARCH_SYNQUACER
Date: Wed, 10 Sep 2025 18:25:01 +0900
Message-Id: <20250910092501.279817-1-hayashi.kunihiko@socionext.com>
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

The config "GIC_V3" seems to be typo, and currently "GICV3" remains
disabled. This should be removed until needed.

Fixes: 5cd4a355e0f0 ("board: synquacer: Add DeveloperBox 96boards EE support")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6ff3f2750ea8..e38e1e0f0c16 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1989,7 +1989,6 @@ config ARCH_SYNQUACER
 	bool "Socionext SynQuacer SoCs"
 	select ARM64
 	select DM
-	select GIC_V3
 	select PSCI_RESET
 	select SYSRESET
 	select SYSRESET_PSCI
-- 
2.34.1

