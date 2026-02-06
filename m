Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01730EE2089
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 10:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5553283A64;
	Fri,  6 Feb 2026 11:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=egym.com header.i=@egym.com header.b="BOEhXnww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD68483AA9; Fri,  6 Feb 2026 11:47:11 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8750C8382A
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 11:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cibil.pankiras@egym.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so20619885e9.2
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 02:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=egym.com; s=egymcom; t=1770374828; x=1770979628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RboGEddfXOxXW0PXLrJ7ivPRTJ+WgaGRf02mxBdD6rE=;
 b=BOEhXnwwTrfcTYoPXKQt7P8tfnOVGC2JXEdh4AiSuw4EkKBlXChaUvAXdVohydlm/p
 fLcnNEZd2KS3PDZZoBtwJQQ7L8P6BkTShgMnIzisYMvCXPOOTg5QhXLKJ99hKqIh4ypY
 I39W8Ku9es3dLyTE4hgI5h8vf+H2DNGOQOQPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770374828; x=1770979628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RboGEddfXOxXW0PXLrJ7ivPRTJ+WgaGRf02mxBdD6rE=;
 b=vhS72nBmN6fRSy7nn3S0mXif0LJkPIUfi1w14f7TiDfxhcStQj8f7YUgo5PUZh/xG8
 y7r36EnNw/9/wAAFMb2+p0dCf839m2fnpYJej/cFQKBnjgO3AIqqHXUPdRDj/htHTNsH
 /7bdvYCdH77JNulxzLzXQ4NFQTSxpYQOByrUHhyWGvxA3jsupEeNGtdCUpPgrx7hqn+e
 Yc0YEaHJiF7dEYb7rcV2/JI2rFGeLsqI8dbTsZqTn5phTJ6J+Nm+Xtu3kZnJMJAvb2rn
 jD3niQCCG0QLadHGQmEGD3/hI3TrLDGJuBx7B6cMrUnn6qPYl49jjNfuGu3k7j4sZzfB
 v/aQ==
X-Gm-Message-State: AOJu0YyIu9+0B7Ikluhj7172QjsEnzfqPzy6/BO6svpyi+NzF4Dygd2D
 0LR330e1k/HFA26zz9P5nHP63yzI5HOF1LZFoEdJOTrDLHhcMXFhda82Dds1pmNdphHW+zAbMig
 i52IM1yMwOaagpFu0RyUkgZZ5oVToEXIK8i7tdAlQcA+LaTflh6eXpI4nEwc4DBQ=
X-Gm-Gg: AZuq6aLoFgiXBv5NG7/bxdAG1Izlmk6olQTdzS+oPsISI5XUaDo/C31XR2Fcpbu8Ipd
 wIkZunKkcEg9AyMBqeLj0LuCcIkgO49FF1csBLLjwjltBzfsNDUnowpbN9pl1202xDk7VFPgffL
 GNSzi9lKEyRb7SPzG+U6ixlsEUOnyxgDE+a0GBhaD1/e0e8/Pd5Wrsi/4pL3rPn49+3xIPuDm06
 2i+cVTNQ2II/HVCQierwn+z+XCosPlTH8JRd3HkFzGViVLcLboAJK/G52iLYP9g8ix7CsbaCkdX
 zqk9mBgmrFKFZOOpHZDoZEWMIfsfgkTFGSDN3MDfTdHsxAvOVvNsMib8tIyOijbWYFdnFl4CJn6
 b2yc6H25dtpT5s2zB2DF78d2rWr/WI2F0YBNHuPbr4EzueXIPJ26HcoTdVnBGsdKsFvxq4S0qeD
 JmWP0wil3C3zQKA4IWMz3A4PMFMZi4U9wPVS0vx5vZ9bHAcWvgq5ml/Y9/6MGaIYRWb39SVJDlp
 wDfPNvom32hPbinvNGm
X-Received: by 2002:a05:600c:3b20:b0:47a:9560:ec28 with SMTP id
 5b1f17b1804b1-4832020df6amr31006795e9.13.1770374828288; 
 Fri, 06 Feb 2026 02:47:08 -0800 (PST)
Received: from cibil-Precision-5570..
 ([2a02:3033:280:4628:c815:77f9:1225:71ed])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320728774sm40932795e9.14.2026.02.06.02.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 02:47:08 -0800 (PST)
From: Cibil Pankiras <cibil.pankiras@egym.com>
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] pinctrl: bcm283x: Fix GPIO pull state register values for
 BCM2711
Date: Fri,  6 Feb 2026 11:47:00 +0100
Message-ID: <20260206104701.34358-1-cibil.pankiras@egym.com>
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
Changes in v2:
- Moved pull value swap logic to bcm2711_gpio_set_pull()
- Updated the function header comment for bcm2711_gpio_set_pull()
---
 drivers/pinctrl/broadcom/pinctrl-bcm283x.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c b/drivers/pinctrl/b=
roadcom/pinctrl-bcm283x.c
index 4ecc8bac645a..90eee88eb137 100644
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
@@ -93,6 +98,17 @@ static void bcm2711_gpio_set_pull(struct udevice *dev, u=
nsigned int gpio, int pu
 	u32 bit_shift;
 	u32 pull_bits;
=20
+	if (!device_is_compatible(dev, "brcm,bcm2711-gpio"))
+		return;
+
+	/* BCM2711's pull values differ from BCM2835 */
+	if (pull =3D=3D BCM2835_PUD_UP)
+		pull =3D BCM2711_PULL_UP;
+	else if (pull =3D=3D BCM2835_PUD_DOWN)
+		pull =3D BCM2711_PULL_DOWN;
+	else
+		pull =3D BCM2711_PULL_NONE;
+
 	/* Findout which GPIO_PUP_PDN_CNTRL register to use */
 	reg_offset =3D BCM2711_GPPUD_CNTRL_REG0 + BCM2711_PUD_REG_OFFSET(gpio);
=20
--=20
2.43.0


--=20
EGYM SE, Einsteinstra=DFe 172, 81677 M=FCnchen
Gesch=E4ftsf=FChrende Direktoren:=20
Patrick Meininger, Philipp Roesch-Schlanderer, Florian Sauter
Gerichtsstand=20
M=FCnchen | Amtsgericht M=FCnchen HRB 303509=A0|=A0USt.-Id. DE275313632
