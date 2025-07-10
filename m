Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D59C83F09
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 03:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E68FA8367F;
	Thu, 10 Jul 2025 05:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="LkfIalGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8648A8368E; Thu, 10 Jul 2025 05:43:24 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24BC28367E
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 05:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id E47CB23C95;
 Thu, 10 Jul 2025 05:43:21 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 45pE7fRTznSL; Thu, 10 Jul 2025 05:43:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1752119001; bh=IMYNX417k1GS1eGVYvaAFNqffITylB6m+gbpYilS+dk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LkfIalGs/hLm5/BWpqgcoIpIQX5v1Kn3NMytmYg4ZUrgk4ZLwHvRt7WJErUloApHx
 X1ShYFVt3LJYmr37rn4wvhWiwbM/YGIEE2d9ENi+ZZMKThGyn8GhDwRke3Xxhq2EVm
 rTGdoLMgDknLV6wTRkyqG+1x48JnoB8olxYP0rkYP31Sp5Uvyg7nR/hrpxXv+m7mdR
 CCfjiPrsC7yGg5i/sq3XEayO6UmleYrDpl49P/nPWLTTeTLzarsynWTCJb7ACw2z/B
 btdmzMHEYaNEz3vIwrXM3Tw73Iprrz+Tu/CWE6WNTgppWKbDSKYtOGWdqyajyKyHdH
 gP/J872H8V6nA==
From: Yao Zi <ziyao@disroot.org>
To: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 5/5] configs: th1520_lpi4a: Enable network support
Date: Thu, 10 Jul 2025 03:42:01 +0000
Message-ID: <20250710034201.39901-6-ziyao@disroot.org>
In-Reply-To: <20250710034201.39901-1-ziyao@disroot.org>
References: <20250710034201.39901-1-ziyao@disroot.org>
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

Enable the network stack, the designware ethernet driver and
corresponding glue driver. The Lichee Pi 4A board ships two RTL8211F
phys, both attached to GMAC 0, thus support for Realtek phys and DM
support for MDIO devices are enabled as well.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 configs/th1520_lpi4a_defconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
index 78e3b25ab82..2763cbb428a 100644
--- a/configs/th1520_lpi4a_defconfig
+++ b/configs/th1520_lpi4a_defconfig
@@ -76,7 +76,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_ENV_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
-CONFIG_NO_NET=y
+CONFIG_NET_RANDOM_ETHADDR=y
 # CONFIG_BLOCK_CACHE is not set
 CONFIG_DWAPB_GPIO=y
 # CONFIG_I2C is not set
@@ -90,6 +90,11 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_SNPS=y
 # CONFIG_MTD is not set
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_ETH_DESIGNWARE_THEAD=y
 CONFIG_PINCTRL=y
 # CONFIG_POWER is not set
 CONFIG_RAM=y
-- 
2.50.0

