Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C1BD61020
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 060B483F32;
	Thu, 29 Jan 2026 16:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=egym.com header.i=@egym.com header.b="Ji/Jnn5b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75B1783FAF; Thu, 29 Jan 2026 16:15:26 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C916D83D9C
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cibil.pankiras@egym.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so1049130f8f.3
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 07:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=egym.com; s=egymcom; t=1769699723; x=1770304523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GAsV/+/DsCwbm7WuwyE8XgAVn57BgXNkvg6V8P3XznA=;
 b=Ji/Jnn5bF1FDvkGIsD9ENwgnYiDT5Hboh+taGftmb//2/kV1D9mVIh8wSkNcNun7dP
 6gYXcDlRi+QRyftn5uJYd6Vok+jiNzp5e3wBjpUT5jC64QmAk+NmdkfriHdgFzEoBCyR
 rHPIm19eo2/r4z9n/v90RWUijsJxM4Y8zJ8qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769699723; x=1770304523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAsV/+/DsCwbm7WuwyE8XgAVn57BgXNkvg6V8P3XznA=;
 b=UjhNzli/wb5XWrQ7LW62RyZyAFq3XSvD+/zRPXm6U5X/8ZrHjca5r0YL7hOAYQOyxK
 35rjF0X9Wv6PhsC2do4oZGcQQ33+WpJuykl+SBCojwS00hAsWCKevp9WO/jLL+oQdvsy
 LylIbOg2AZf38HrXLuYRb4ZUFlr7cmunT2tbWAcubVYb0XqngB8WEVOLstdzVO5aigKy
 GHUSO9JUWR5aM3AgH+3ff98rZ3jeX/YPgZEWnYc2cFK8boCIi+vlr7qICGduCMP3Xjbz
 fil/BkmrSsK6Wi7noOu/57VNX3AZ5xyDNotME/GWb1m/5/5M8IajJgrvThfA13lA3Yvi
 ACdA==
X-Gm-Message-State: AOJu0Yzfs1ZMVn9YA5zDowi3PN560L759YPzAOd2lze7mRWlnHYFLPd/
 AQTrwr3ps3pnxXAXOV7c6nl03CqLr1b+y1jgZpL7c6aFst7Ad8aG4zY+yPrr6wWA7wGEp+cfXR9
 SJr5rdd6dKbVYVZIP0TTfPCZx2MAjVi8J1IlFYeFRLpv/fGk2QvLA2XfoUdbA6Dk=
X-Gm-Gg: AZuq6aIlDFzK6wVTcIIpIRQupNnbussBsOddSxkLP43M5G9xs20LMjywduGNIMxwYbs
 0XyErSKY9IxsZMsgSBQRt7MsIIfLQDuCJVWj0KsYC17X/6hlYWcpKV76ss9VV7kuSupzjSLAKNa
 /aILQfpmVqvi2yiga39nHEAfyH3oZkJ7QiTJD9dm0W2ikzkxji7VMRQ37023bgs2jIzDSfl5B1q
 zpjR0rL2wd2qNeObApMhUt8f7lTYVCdjDaEZzy1rWIYZnRdbed03/kZmwiNT2kajCHw1UlCXLQE
 eqFeOfM5gFOkYhUCgSnpLv4S+f08Nhu2KQGXF+TMVMLhaXca8BSBEIIHCWaKETplzgeqnTXkWVi
 O59WC8NV/p6QU7bEcx2M85bWeAYZFAxW24kceQrXJSvanzC5MJ7bLL52Hy1AQLmzQcZDXCJ9ETs
 ah+mSTBtVpaopt/Zwkauq80GhzVc0ztnFQdXvHy+vCJSakR+7IoEURnpDCP+Sa/W4BovWOobbId
 pGel2Lmt9jd31D/GQ==
X-Received: by 2002:a05:6000:3112:b0:430:ff8b:fdc2 with SMTP id
 ffacd0b85a97d-435dd1d948cmr12073534f8f.60.1769699722837; 
 Thu, 29 Jan 2026 07:15:22 -0800 (PST)
Received: from cibil-Precision-5570.. ([217.111.51.126])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee04csm15327839f8f.12.2026.01.29.07.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 07:15:22 -0800 (PST)
From: Cibil Pankiras <cibil.pankiras@egym.com>
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] pinctrl: bcm283x: Fix GPIO pull state register values for
 BCM2711
Date: Thu, 29 Jan 2026 16:15:08 +0100
Message-ID: <20260129151509.548538-1-cibil.pankiras@egym.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
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

BCM2711 has different pull-up/down register values compared to BCM2835

- BCM2835: NONE=3D0, DOWN=3D1, UP=3D2
- BCM2711: NONE=3D0, UP=3D1, DOWN=3D2

This patch fixes the pull state register values for BCM2711.

Fixes: 2c39d975f87c ("pinctrl: bcm283x: Add GPIO pull-up/down control for B=
CM2835 and BCM2711")
Signed-off-by: Cibil Pankiras <cibil.pankiras@egym.com>
---
 drivers/pinctrl/broadcom/pinctrl-bcm283x.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c b/drivers/pinctrl/b=
roadcom/pinctrl-bcm283x.c
index 4ecc8bac645a..33638515b5db 100644
--- a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
+++ b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
@@ -30,6 +30,11 @@ struct bcm283x_pinctrl_priv {
=20
 #define MAX_PINS_PER_BANK 16
=20
+/* pull states for BCM2711 */
+#define BCM2711_PULL_NONE 0
+#define BCM2711_PULL_UP   1
+#define BCM2711_PULL_DOWN 2
+
 static void bcm2835_gpio_set_func_id(struct udevice *dev, unsigned int gpi=
o,
 				     int func)
 {
@@ -84,7 +89,7 @@ static void bcm2835_gpio_set_pull(struct udevice *dev, un=
signed int gpio, int pu
  * bcm2711_gpio_set_pull: Set GPIO pull-up/down resistor for BCM2711
  * @dev: the pinctrl device
  * @gpio: the GPIO pin number
- * @pull: pull setting (BCM2835_PUD_OFF, BCM2835_PUD_DOWN, BCM2835_PUD_UP)
+ * @pull: pull setting (BCM2711_PULL_NONE, BCM2711_PULL_DOWN, BCM2711_PULL=
_UP)
  */
 static void bcm2711_gpio_set_pull(struct udevice *dev, unsigned int gpio, =
int pull)
 {
@@ -108,10 +113,19 @@ static void bcm2711_gpio_set_pull(struct udevice *dev=
, unsigned int gpio, int pu
=20
 static void bcm283x_gpio_set_pull(struct udevice *dev, unsigned int gpio, =
int pull)
 {
-	if (device_is_compatible(dev, "brcm,bcm2835-gpio"))
+	if (device_is_compatible(dev, "brcm,bcm2835-gpio")) {
 		bcm2835_gpio_set_pull(dev, gpio, pull);
-	else
+	} else {
+		/* BCM2711's pull values differ from BCM2835 */
+		if (pull =3D=3D BCM2835_PUD_UP)
+			pull =3D BCM2711_PULL_UP;
+		else if (pull =3D=3D BCM2835_PUD_DOWN)
+			pull =3D BCM2711_PULL_DOWN;
+		else
+			pull =3D BCM2711_PULL_NONE;
+
 		bcm2711_gpio_set_pull(dev, gpio, pull);
+	}
 }
=20
 /*
--=20
2.43.0


--=20
EGYM SE, Einsteinstra=DFe 172, 81677 M=FCnchen
Gesch=E4ftsf=FChrende Direktoren:=20
Patrick Meininger, Philipp Roesch-Schlanderer, Florian Sauter
Gerichtsstand=20
M=FCnchen | Amtsgericht M=FCnchen HRB 303509=A0|=A0USt.-Id. DE275313632
