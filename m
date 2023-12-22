Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F677C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 14:43:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C0CB877CD;
	Fri, 22 Dec 2023 15:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="b87t+XZK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2749B8785F; Fri, 22 Dec 2023 15:43:47 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45B27877B2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 15:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c41b43e1eso23057735e9.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 06:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1703256224; x=1703861024;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6ug1b/u0jEH/GlOKuclvLQBMpKrr0p4fGjy0qRoQtGo=;
 b=b87t+XZKyFHxw5/USg2T8/z0++DNNBbbof3A4xdElrkbZLkdi6SlJxzFABDSt8I/yR
 uyEAtfC6zJcTZ04ZDIjmzRGaFvIYvAVr1Bl9lDvZA6EGcjn8iCjicrTaFJxdPQOVd5xX
 jALT+Tj6j4FCxs642nJX80lXBxUQrXSH4N8ohgP4weCW1Sh/bbZa/Ais0Su7PKZTG4Ej
 7IZyNksP/JMvrTkOUG7WQCJ3SD1hstpyZJiTJFLRo21CK6J22nLalZir50f4kmgLWFD4
 auYLJWCVyRPFZmnBxPbHfpD3rN0UFQDellFHW5ZdU3XCYatIMEASpmuMVgutTY1JinhF
 3tFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703256224; x=1703861024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ug1b/u0jEH/GlOKuclvLQBMpKrr0p4fGjy0qRoQtGo=;
 b=Hmw9/WeQgvJPQB6W13Az7EQYUTebMjVy9WIcL065xxTbQ4rfISQJGC2tFgooeMrHYW
 j4Jp7W8/Jq3bXP7rqcUhkJRihGfu7Dh6Mf0kLbdFBjYtjixOZxGQ2tBs2Y2APjejkFvH
 1oA2CQ7oG2ZFgMScNe00dplz5dQM7vRr+3ec/7GEf5eL3GJ6yLSvXJ70apzgi+1vqVtL
 Hi7j0p4hWUXSXreNUmrUTivk/+cLUW4nnmTSVEy/Qm58i58piuqtUEzVNwAZAys+eCm0
 gn9UzmI1w8sUMlogziZ//C64T25cN951fa+caRlYDeGJ4LQ7Vhh6xVXkzQKi5OQReRdb
 JL7w==
X-Gm-Message-State: AOJu0YzbgHIDHqpOotv+Y50lyQ+eIBqC2Kd7vYq10xy8AZ50Zq1MohnT
 JAnMPRyHwqg3d23Za9FjaEEXxnTZPjdNhw==
X-Google-Smtp-Source: AGHT+IEMNAVSTiYymuGnBRWlgKwVc9khdrS6OiiQ9aXP559QadJhozB9Bww+IHs97MxZAmXnS4SBZA==
X-Received: by 2002:a7b:cb8f:0:b0:40d:3756:97d7 with SMTP id
 m15-20020a7bcb8f000000b0040d375697d7mr667822wmi.148.1703256224640; 
 Fri, 22 Dec 2023 06:43:44 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 f18-20020a5d50d2000000b003366827c9c6sm4478221wrt.2.2023.12.22.06.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 06:43:44 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: marex@denx.de
Cc: bmeng.cn@gmail.com, clamor95@gmail.com, Shantur Rathore <i@shantur.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: [PATCH v4] dts: rockpro64: Disable usb regulators-always-on
Date: Fri, 22 Dec 2023 14:42:35 +0000
Message-Id: <20231222144236.509978-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
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

USB port regulators should be controlled by PHYs
so we remove always-on property and let phy manage the
regulator.

phy-supply isn't configured for TypeC port in upstream and
now that we are removing always-on, we need to add the
phy-supply until its fixed upstream.

Signed-off-by: Shantur Rathore <i@shantur.com>

---

Changes in v4:
- otg port must be configured with phy-supply instead of host port node

Changes in v3:
- Split up patches as seperate series

Changes in v2:
- As requested, added fix for regulator-always-on in RockPro64

 arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
index 732727d9b0..0ac9fa9a03 100644
--- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
@@ -22,6 +22,18 @@
 	};
 };
 
+&u2phy0_otg {
+	phy-supply = <&vcc5v0_typec>;
+};
+
+&vcc5v0_host {
+	/delete-property/ regulator-always-on;
+};
+
+&vcc5v0_typec {
+	/delete-property/ regulator-always-on;
+};
+
 &vdd_center {
 	regulator-min-microvolt = <950000>;
 	regulator-max-microvolt = <950000>;
-- 
2.40.1

