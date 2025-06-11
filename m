Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B60C677C4
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 09:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E75282B20;
	Wed, 11 Jun 2025 10:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1553982C30; Wed, 11 Jun 2025 10:59:52 +0200 (CEST)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [84.16.66.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55D65828A2
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 10:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bHKNf0DKjzqMr;
 Wed, 11 Jun 2025 10:59:46 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bHKNd1SQczpV5; Wed, 11 Jun 2025 10:59:45 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 11 Jun 2025 10:59:33 +0200
Subject: [PATCH 3/3] configs: ringneck-px30: fix Ethernet
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-ringneck-mdio-v1-3-529a40a0f966@cherry.de>
References: <20250611-ringneck-mdio-v1-0-529a40a0f966@cherry.de>
In-Reply-To: <20250611-ringneck-mdio-v1-0-529a40a0f966@cherry.de>
To: Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Klaus Goger <klaus.goger@cherry.de>
Cc: Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Due to updates to the Device Tree (migrating from snps,reset-*
properties to a PHY node on the MDIO bus) in previous commits and the
inability of the designware net driver to support the old Device Tree
(without the MDIO bus and PHY nodes) with DM_MDIO and DM_ETH_PHY
enabled, support for Ethernet on Ringneck PX30 is currently broken.

Now that the transition was made, we can simply enable DM_MDIO and
DM_ETH_PHY to fix Ethernet support on that board. Ideally, we could
squash this commit with the one migrating the Device Tree, but we want
to keep having upstream changes to the Device Trees made by
tools/update-subtree.sh tool without manual intervention.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 configs/ringneck-px30_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index a6562d03edc96557428d51e2f73609ed3d230895..539a94cb16f1e87e5403e609608eb3cdbab1225e 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -83,6 +83,8 @@ CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_PHY_TI_GENERIC=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y

-- 
2.49.0

