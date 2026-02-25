Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4131EF357D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 07:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 888D98366F;
	Wed, 25 Feb 2026 08:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YCSnsTGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8399583946; Wed, 25 Feb 2026 08:17:14 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEA3882A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:17:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EFDCE40A21; 
 Wed, 25 Feb 2026 07:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772003832;
 bh=7EFn0j9pW8OLyWqXf+Y+5k1f+BHtI0rnrukH8TTwCkQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=YCSnsTGdaEUVZdK/x5lGOV4sZkIIhwM9l21E4VACicmTwUX85bD6b9nLJP/+eN882
 uCkxgIGgxrccUHRgaGRXYvJIueshdfvP0kx4ofUkPflyZZ6feKo/oysoxRSAUjuomK
 oAYWAAid62qS45wsubwby49yokguj1ZFSe7TZskfFzKCENVHReBGKvyQY9RrhyQLZ5
 +jXwd0pnz+Wxf1gIJfYb+ZUkdpkKGP2y2tnTaUPRSbm5MA9Z2/+AxkBgU9eY7pwPgD
 7ZkiyELQaNPFV68REZNCpczQ+AY2n3NDVYXyMMrMJRh3yI72puh9i6mnFbRJroBpnx
 BlC3ZaLyxy+qqZY7E5mczPO0Ina699vcldOuUYNsip3fSyufL3A9y6RhHdbcAgomiD
 xSCUh17IzIQXFfhGOfjXPrd72IGYwZlvPO+7MzVOViLeLnugiW4n41XyfxasIqQ9Bv
 39Iyrt1nCPVGoyu7nIM6DVhcvNbLP/ogj2fESOqH9ocm7QO6e8n/zbzsr+mhhpqw61
 6yGdPdG4Y2Lb5WUSjwlAB80xgbYw/q9do7zoS75y31+DBMhynUAxcwPeYUQgTPtRL4
 nuASIqEdqZjdWcJ3mZrU5BVbPhSeAA1LFnwjBnP2bdHnyloA+M2ARzg629f1vVZnwL
 XFg+Fueu0qe6Mtey+2kyNR54=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Warren <twarren@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] tegra: sound: Don't use non-existent TEGRA124_DMA
Date: Wed, 25 Feb 2026 08:17:10 +0100
Message-ID: <20260225071710.50245-1-heinrich.schuchardt@canonical.com>
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

Symbol CONFIG_TEGRA124_DMA does not exist.
Don't select it.

Fixes: 112f2e144342 ("tegra: sound: Add an audio hub driver")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/sound/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/sound/Kconfig b/drivers/sound/Kconfig
index afcc08c27bc..f788124a24c 100644
--- a/drivers/sound/Kconfig
+++ b/drivers/sound/Kconfig
@@ -81,7 +81,6 @@ config SOUND_IVYBRIDGE
 config I2S_TEGRA
 	bool "Enable I2S support for Nvidia Tegra SoCs"
 	depends on I2S && ARCH_TEGRA
-	select TEGRA124_DMA
 	help
 	  Nvidia Tegra SoCs support several I2S interfaces for sending audio
 	  data to an audio codec. This option enables support for this,
-- 
2.51.0

