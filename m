Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2617C4450A
	for <u-boot@archiver.kernel.org>; Sun, 19 Jul 2026 01:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B880842FC;
	Sun, 19 Jul 2026 03:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1786584659; Sun, 19 Jul 2026 03:52:19 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42F4280398
 for <u-boot@lists.denx.de>; Sun, 19 Jul 2026 03:52:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wlGhR-000000001mj-3evD; Sun, 19 Jul 2026 01:52:13 +0000
Date: Sun, 19 Jul 2026 02:52:11 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Daniel Golle <daniel@makrotopia.org>, u-boot@lists.denx.de
Subject: [PATCH] rockchip: only build GPT capsule update helpers with
 PARTITION_TYPE_GUID
Message-ID: <af0ac32e2bf603c39f490f15fe62319fd73c5282.1784423864.git.daniel@makrotopia.org>
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

The GPT-based capsule update helpers match updatable images by
partition type GUID and fail to build if PARTITION_TYPE_GUID is not
enabled:

  arch/arm/mach-rockchip/board.c:50:29: error: 'struct disk_partition'
  has no member named 'type_guid'

Boards which keep their firmware on SPI-NOR use a static dfu_string
instead of scanning GPT partitions and have no use for this code, so
guard it accordingly.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/arm/mach-rockchip/board.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
index 2e6bb38b923..98c890d3bdc 100644
--- a/arch/arm/mach-rockchip/board.c
+++ b/arch/arm/mach-rockchip/board.c
@@ -35,7 +35,8 @@
 #include <asm/arch-rockchip/periph.h>
 #include <power/regulator.h>
 
-#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION) && \
+	IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)
 
 #define DFU_ALT_BUF_LEN			SZ_1K
 
@@ -193,7 +194,8 @@ int board_late_init(void)
 {
 	setup_boot_mode();
 
-#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION)
+#if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) && IS_ENABLED(CONFIG_EFI_PARTITION) && \
+	IS_ENABLED(CONFIG_PARTITION_TYPE_GUID)
 	gpt_capsule_update_setup();
 #endif
 

base-commit: ece349ade2973e220f524ce59e59711cc919263f
-- 
2.55.0
