Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3831E9B25A
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 06:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 316798366F;
	Wed, 25 Feb 2026 07:14:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bhvODCO8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5D2B83946; Wed, 25 Feb 2026 07:14:33 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1F5382A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:14:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 32CF8403C1; 
 Wed, 25 Feb 2026 06:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772000071;
 bh=TthNMYwx9EYX3akHaZXkDgVSVONxyMMyoJJnV9nrU3Q=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=bhvODCO8OzO0Oya0CNqpbnsxgtsyrjLXJ+JbFLTQ436XXeGpce1JqE3eu1A8Poxr3
 JknHPKJdbqY233VoPjJsndMBl3bQXuwh5ockXockHx7Ya6eL/ECOqGzrGEPCl3jP/C
 MIChcMpT0T9jxLTZ0Q4c+Wkois8+6seoaIz1pVO5ORdn5n3gocF1XG5Twl8iteByFG
 iapdrFa+E6tX/BfyP/+cKnujBDyUltyA1NWgCnqLCDSA4+B/OH2s+OqIs47SPzY6Ra
 xsxogUqFx2IV+DjWVv85DAlQK2TxVE6UuGqLalSgX8rHTnPzK2ni6WhhJX+iHVBzjF
 VYua39he+36DOipIYJSlhcVIz0KWruSgB5mJaTuPWT0KWB/4cPaQKmnl2fEneOQ2eZ
 OW/7lm3jdoEh7oz43oQ2OnhXTsYxnp16U+zXenbiPq1Ee3aUwMg7si1AMnZcEVAkFz
 tdffxMlqywCCG5MEQEB38J+IZZidjjOehQoS9L+x6864xoBotDuCYwwiJkg2EF72Sk
 /4WhJMdmTiuWREYfjlONXWwahawSi/bTHkTbDS1QJMU50oh5oqZjUw+7pqKoeuRi02
 gYZqRLNmGMbcWcLKnHiHWa84UKTh74xFLoSFms/x1swoPpfi9hy30LM2HFwjsffYbF
 kPzozGLDlgGj8Kp+96fg2fmE=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] net: do not use non-existent CONFIG_DM_CLK
Date: Wed, 25 Feb 2026 07:14:26 +0100
Message-ID: <20260225061426.45981-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

For enabling the clock driver we use symbol CONFIG_CLK.
Select this symbol for the HiSilicon Fast Ethernet Controller driver.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
@Jerome

I could not find any usage of the drivers.
Should they be removed?
---
 drivers/net/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index d3ef050d1a1..17ceb7be57a 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -979,7 +979,7 @@ source "drivers/net/mtk_eth/Kconfig"
 
 config HIFEMAC_ETH
 	bool "HiSilicon Fast Ethernet Controller"
-	select DM_CLK
+	select CLK
 	select DM_RESET
 	select PHYLIB
 	help
@@ -989,7 +989,7 @@ config HIFEMAC_ETH
 config HIFEMAC_MDIO
 	bool "HiSilicon Fast Ethernet Controller MDIO interface"
 	depends on DM_MDIO
-	select DM_CLK
+	select CLK
 	help
 	  This driver supports the internal MDIO interface of HIFEMAC
 	  Ethernet controller.
-- 
2.51.0

