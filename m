Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4849DC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 018628856F;
	Mon, 10 Jun 2024 15:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C718E88532; Mon, 10 Jun 2024 15:14:04 +0200 (CEST)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 579E188537
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VyXLx6zsTznsJ;
 Mon, 10 Jun 2024 15:14:01 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VyXLx0m7SzGQD; Mon, 10 Jun 2024 15:14:01 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 10 Jun 2024 15:13:35 +0200
Subject: [PATCH next v3 5/8] arm64: dts: rockchip: fix comment for upper
 usb3 port
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240610-tiger-v3-5-2b4731f95757@cherry.de>
References: <20240610-tiger-v3-0-2b4731f95757@cherry.de>
In-Reply-To: <20240610-tiger-v3-0-2b4731f95757@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14-dev-a6ee3
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

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The comment for the host2_xhci points to the wrong port on the board.
The upper usb3 port is the correct one, so fix the comment to prevent
confusion.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Link: https://lore.kernel.org/r/20240422163951.2604273-2-heiko@sntech.de
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: 3482efee1144262dc839792103e6a9e29defecbc ]

(cherry picked from commit 56f3031edf22d163f10bc4b631d37a9aaa82d4d4)
---
 dts/upstream/src/arm64/rockchip/rk3588-tiger-haikou.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dts/upstream/src/arm64/rockchip/rk3588-tiger-haikou.dts b/dts/upstream/src/arm64/rockchip/rk3588-tiger-haikou.dts
index 9bdd14799ef..2aa43e7430e 100644
--- a/dts/upstream/src/arm64/rockchip/rk3588-tiger-haikou.dts
+++ b/dts/upstream/src/arm64/rockchip/rk3588-tiger-haikou.dts
@@ -239,12 +239,12 @@
 	status = "okay";
 };
 
-/* host0 on Q7_USB_P2, lower usb3 port */
+/* host0 on Q7_USB_P2, upper usb3 port */
 &usb_host0_ehci {
 	status = "okay";
 };
 
-/* host0 on Q7_USB_P2, lower usb3 port */
+/* host0 on Q7_USB_P2, upper usb3 port */
 &usb_host0_ohci {
 	status = "okay";
 };
@@ -259,7 +259,7 @@
 	status = "okay";
 };
 
-/* host2 on Q7_USB_P2, lower usb3 port */
+/* host2 on Q7_USB_P2, upper usb3 port */
 &usb_host2_xhci {
 	status = "okay";
 };

-- 
2.45.2

