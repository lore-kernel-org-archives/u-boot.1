Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16689C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 18:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97916830F6;
	Mon,  4 Aug 2025 20:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="T+UyTmah";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39EFF831A4; Mon,  4 Aug 2025 20:25:55 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3CE581FEE
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 20:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4ce3=2R=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1754331951;
 bh=DX3xHejouWKPe55vX9mz9oeC6H2TUWo6JH4bpm760go=;
 b=T+UyTmahERTCq2xIn9oFip05MrUWKdWko30EwQDIh42G1T4qkoFclzOCkH8p9RfnGBF+pFTyH
 ih1MAcbz/DxCCUk7LUSrmskJkyW/VnW9Z3wm01keK0x/kVxQLF40b+JLeWycwn6R5TwkwR9m2tP
 kAoBLXJPKKPJO564+iiserSJkBHRv3i31gchL83SMtcBnl/SlXd0PqoydEnyRSlqj0VgCz/a78T
 0P1yCLnxzGC5eOsHQ7WrEvSj55I5ASVCLrwSzoKvKg4dG25wpZLSt3kucAFuiJy1woByS+8d90j
 xHLF3fH8i6D3IsT010TfOIwr8ZwV+xX3JYJFbBp6ye3w==
X-Forward-Email-ID: 6890fb2a010e4d2155812d12
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Subject: [PATCH v2] rockchip: spl-boot-order: Defer probe of boot device
Date: Mon,  4 Aug 2025 18:25:39 +0000
Message-ID: <20250804182541.3858351-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
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

Boot devices are being probed when SPL boot order is determined, this
may unnecessarily delay boot slightly.

Instead defer probe of the boot device until SPL try to load image from
the boot device by using uclass_find_device_by_of_offset() instead of
the get variant.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Update commit message
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
2.50.1

