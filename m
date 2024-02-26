Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97EC0C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 23:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE6B987F8E;
	Tue, 27 Feb 2024 00:08:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="PMogLaqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3668C87F71; Tue, 27 Feb 2024 00:08:48 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D23487F73
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 00:08:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b6e=KE=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708988911; bh=LmJwtE7i4QKrwJZ9bhpJ1RSFHtTsgZsTvlqnftT43Vc=;
 b=PMogLaqN36EKvbFdqixdfpXC2ai1GNev1GeHffj0VjwVVxlnHae5/50038BaTqcrtcvmZhf5g
 H96JupDCzcUwNeABQvjP8SjmXy6rzGVoO5F+q05Qy7jOVUDSwxhN6WcDVAcW1k1O5pzg/zsP7Vn
 DOQiM+rKsSnFNBHJG4MlcZnXzUoBjS9v+B4o7KShhqc+66b+8o/t5i/N2vZe5fZ9UDmsp2JdiB3
 8ZtLE6ESzI+VuLDEta7POwUNClP3qR0e0zh+CI68JqcN6X77nP7svqcSNDDVTwytB6tOPvmiuNN
 67RJXF5+k3R4Ca82IpCKdHcZl96CRpFaSa1zyIORdyxA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/4] rockchip: Update the default USB Product ID value
Date: Mon, 26 Feb 2024 23:08:13 +0000
Message-ID: <20240226230822.2430391-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226230822.2430391-1-jonas@kwiboo.se>
References: <20240226230822.2430391-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65dd19ee81fb330034973efa
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

RK3036 is using the USB product id normally used by RK3066B, and RK3328
is using the product id normally used by RK3368.

Fix this and update the default USB_GADGET_PRODUCT_NUM Kconfig option
for remaining supported Rockchip SoCs to match the product id used in
Mask ROM mode. Also remove a reference to the unknown ROCKCHIP_RK3229
symbol.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/usb/gadget/Kconfig | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index c72a8047635c..4621a6fd5e64 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -70,12 +70,21 @@ config USB_GADGET_PRODUCT_NUM
 	hex "Product ID of the USB device"
 	default 0x701a if ARCH_TEGRA
 	default 0x1010 if ARCH_SUNXI
-	default 0x310a if ROCKCHIP_RK3036
+	default 0x110a if ROCKCHIP_RV1108
+	default 0x110b if ROCKCHIP_RV1126
 	default 0x300a if ROCKCHIP_RK3066
+	default 0x301a if ROCKCHIP_RK3036
+	default 0x310b if ROCKCHIP_RK3188
 	default 0x310c if ROCKCHIP_RK3128
-	default 0x320a if ROCKCHIP_RK3229 || ROCKCHIP_RK3288
-	default 0x330a if ROCKCHIP_RK3328
+	default 0x320a if ROCKCHIP_RK3288
+	default 0x320b if ROCKCHIP_RK322X
+	default 0x320c if ROCKCHIP_RK3328
+	default 0x330a if ROCKCHIP_RK3368
 	default 0x330c if ROCKCHIP_RK3399
+	default 0x330d if ROCKCHIP_PX30
+	default 0x330e if ROCKCHIP_RK3308
+	default 0x350a if ROCKCHIP_RK3568
+	default 0x350b if ROCKCHIP_RK3588
 	default 0x0
 	help
 	  Product ID of the USB device emulated, reported to the host device.
-- 
2.43.0

