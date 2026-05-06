Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBE3CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 17:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BA5581E18;
	Wed,  6 May 2026 19:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B37F848EA; Wed,  6 May 2026 19:52:48 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E717803C6
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 19:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 650901F80041
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 17:52:45 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id DAE6BB405E9; Wed,  6 May 2026 17:52:44 +0000 (UTC)
Received: from collins (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 1C576B405E7;
 Wed,  6 May 2026 17:51:11 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, Paul Kocialkowski <paulk@sys-base.io>,
 Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v3 3/3] sunxi: Add support for the Lichee Pi Zero with Dock
Date: Wed,  6 May 2026 19:50:57 +0200
Message-ID: <20260506175057.3374586-4-paulk@sys-base.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506175057.3374586-1-paulk@sys-base.io>
References: <20260506175057.3374586-1-paulk@sys-base.io>
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

From: Paul Kocialkowski <contact@paulk.fr>

This adds a U-Boot config and device-tree build for the Lichee Pi Zero
with Dock. Compared to the Lichee Pi Zero, it has an ethernet port
(with internal PHY) so the EMAC driver and network support are enabled.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 configs/LicheePi_Zero_Dock_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 configs/LicheePi_Zero_Dock_defconfig

diff --git a/configs/LicheePi_Zero_Dock_defconfig b/configs/LicheePi_Zero_Dock_defconfig
new file mode 100644
index 000000000000..0ae53c0c067f
--- /dev/null
+++ b/configs/LicheePi_Zero_Dock_defconfig
@@ -0,0 +1,6 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun8i-v3s-licheepi-zero-dock"
+CONFIG_SPL=y
+CONFIG_MACH_SUN8I_V3S=y
+CONFIG_SUN8I_EMAC=y
-- 
2.54.0

