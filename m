Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9516DC83F1D
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 21:13:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE9AF808AF;
	Sat, 12 Jul 2025 23:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="esp/voHN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C2BA81D5D; Sat, 12 Jul 2025 23:13:13 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE58A80050
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 23:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9534=Z2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1752354762;
 bh=J0AJ/c0+I6y1Q/NdzS4aXz3pkLErX2gXDf+BCcULBtI=;
 b=esp/voHNP7WCPIPRsBoEjIA8QvBxeV45TZrDglu4gqBn9n+ATmi0p5sZsXnPw6lk/mFG0bJos
 +/ZSMY9HMlbD8IYFGUwRNLMLggLJ0Zl76yJPhuVsjljXzax6JigENKVK1zCLN8qoPMpg7hs16gi
 VMbUfhIDe1VDvPqeUhZK9GFuh1FjBqF4btq8Ej5rJb0EL4F1kblzcPPyGpM546wZocui8ygDbld
 TKt1dN2u8FEBf4/FXCGb3N21ca7eHLq/6EIita0qfIEI7IkZVJRKPsyu5Rm8GieZJ1HNrAod9cM
 bWQSzfyEXN9VKbiAIxbWSHDqqjrRw0CMB5jkcohwx97w==
X-Forward-Email-ID: 6872cfc5e9b61efbb89c04e2
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] rockchip: spl-boot-order: Defer probe of boot device
Date: Sat, 12 Jul 2025 21:12:29 +0000
Message-ID: <20250712211232.680047-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
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

Boot devices are being probed when SPL boot order is determined. This
may delay boot slightly and can prevent booting from SPI Flash on boards
that use same pins for SPI Flash and eMMC due to pinctrl being applied
prior to booting.

Instead defer probe of the boot device until SPL try to load image from
the boot device by using uclass_find_device_by_of_offset() instead of
the get variant.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/spl-boot-order.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 3dce9b30898d..6b1b84dc86d1 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -40,7 +40,7 @@ static int spl_node_to_boot_device(int node)
 	 * aware of the block-device layer.  Until then (and to avoid unneeded
 	 * delays in getting this feature out), it lives at the board-level.
 	 */
-	if (!uclass_get_device_by_of_offset(UCLASS_MMC, node, &parent)) {
+	if (!uclass_find_device_by_of_offset(UCLASS_MMC, node, &parent)) {
 		struct udevice *dev;
 		struct blk_desc *desc = NULL;
 
@@ -72,7 +72,7 @@ static int spl_node_to_boot_device(int node)
 	 * extended with awareness of the BLK layer (and matching OF_CONTROL)
 	 * soon.
 	 */
-	if (!uclass_get_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
+	if (!uclass_find_device_by_of_offset(UCLASS_SPI_FLASH, node, &parent))
 		return BOOT_DEVICE_SPI;
 
 	return -1;
-- 
2.49.0

