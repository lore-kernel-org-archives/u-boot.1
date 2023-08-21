Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A73EE4996
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:40:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEF0087066;
	Mon, 21 Aug 2023 21:40:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F57787042; Mon, 21 Aug 2023 21:40:01 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0642F867A8
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.96) (envelope-from <daniel@makrotopia.org>)
 id 1qYAkd-0003fh-2u; Mon, 21 Aug 2023 19:39:48 +0000
Date: Mon, 21 Aug 2023 20:38:23 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Sam Shih <sam.shih@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH] configs: set CONFIG_LMB_MAX_REGIONS=64 for MT7988 boards
Message-ID: <568a8030acf9056266b5c96055cea54f810496c9.1692646620.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Similar to MT7981 and MT7986 also MT7988 can have a high number of
reserved-memory regions used by the various hardware offloading
subsystems.

Raise CONFIG_LMB_MAX_REGIONS to 64 to avoid errors when trying to boot
Linux with more then 6 reserved regions:

ERROR: reserving fdt memory region failed (addr=4f700000 size=240000 flags=4)
ERROR: reserving fdt memory region failed (addr=15194000 size=1000 flags=4)
ERROR: reserving fdt memory region failed (addr=15294000 size=1000 flags=4)
ERROR: reserving fdt memory region failed (addr=15394000 size=1000 flags=4)
ERROR: Failed to allocate 0xb161 bytes below 0x80000000.
device tree - allocation error

Fixes: bc4adc97cfb ("board: mediatek: add MT7988 reference boards")
Reported-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 configs/mt7988_rfb_defconfig    | 1 +
 configs/mt7988_sd_rfb_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/mt7988_rfb_defconfig b/configs/mt7988_rfb_defconfig
index dc97bb36ea..ced52edecf 100644
--- a/configs/mt7988_rfb_defconfig
+++ b/configs/mt7988_rfb_defconfig
@@ -81,3 +81,4 @@ CONFIG_MTK_SPIM=y
 CONFIG_LZO=y
 CONFIG_HEXDUMP=y
 # CONFIG_EFI_LOADER is not set
+CONFIG_LMB_MAX_REGIONS=64
diff --git a/configs/mt7988_sd_rfb_defconfig b/configs/mt7988_sd_rfb_defconfig
index 421999da86..670f5eae18 100644
--- a/configs/mt7988_sd_rfb_defconfig
+++ b/configs/mt7988_sd_rfb_defconfig
@@ -69,3 +69,4 @@ CONFIG_MTK_SPIM=y
 CONFIG_LZO=y
 CONFIG_HEXDUMP=y
 # CONFIG_EFI_LOADER is not set
+CONFIG_LMB_MAX_REGIONS=64
-- 
2.41.0
