Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBD1CD6E60
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 23:49:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4110F8467E;
	Thu,  4 Jun 2026 01:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J7vb6FnI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73ECF84881; Thu,  4 Jun 2026 01:49:45 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B9383EF9
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 01:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-68d05f6b3cbso10646a12.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 16:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780530583; x=1781135383; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xqJVDDUtVs3r2qpkFRkrFst//SlR3CDD8qy6f7/KJn4=;
 b=J7vb6FnICc6FIhhi+XvlBJ7HF0u2X5KZg2FfvBMz85om5g8p91M6iD5MylqKaWBaPH
 aih6kci17qUvdQRNnAee4+ugs+Rn+kePLa1Bpi2m1GSUXOGnrAt4lLe9pArJV/XNfPHN
 IBEdzMl1qgft45ku+5Y6Hei+Qd1SLGJSyjdA0FGTIhDJDpzAPXEVW6lyuCYA2gqUR34t
 6gMR1obNWbrSdBbhP8AJ/7yTP22jPuTcnjrJ3tYokkryaMTn0e8s21AN+4Ru41+GZten
 sr0TwTjh8fTP6lxtpCA1GoNp3pIr4ySc0lqOrdZhqerfaxesx3aKbzZfSWbMfJA3SJTB
 0KBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780530583; x=1781135383;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xqJVDDUtVs3r2qpkFRkrFst//SlR3CDD8qy6f7/KJn4=;
 b=hax3X2hesQ9yiIrYOaZHytmEEAX2pwO3XOoLEdKdY3teg3blMgO62QDb0BU4fSiTfN
 w74GvGHtE9DP+2gz9t5HqCHa7LLSEkqZWBQD4/8RtqookSNm8tjMZkuzP0EVmqtIkz/s
 JUJAf0K9lAnSa/B/YbgxaUV7ao1vH+TloqLjIweeds6DD+0upAjXTVZVc6UpS3m2Vcva
 aWEZg2IRux+OuFlqK3WOoxdfJjMcFzbUUIFWTTYXY7tUpM13IhIZT9yEk7WpYC/+Likt
 pmbeEpwNvNDM8M+5PC3FCMUF5ssRXjVnhss1l24BvFJmlPLUNDphaLABc7YwphV36Ezp
 3KGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Xh+BzemcPwRbApVADu8vTXF+AdgdkFJ3XzipaAv5E2UkWKjGdYqFhKh2Q/fZpr86MatbFfKY=@lists.denx.de
X-Gm-Message-State: AOJu0Ywh5oGH/1BXQ+NcIdZTPoroW+eYsor3vIqyuYNAM7TaJubXaGDw
 mhQEtH4R9A1goEr+ngDBSgwuxVMdD72vxHYLl6OZfT2fSQ6/kueOuIL0
X-Gm-Gg: Acq92OFQkhhuiwEDmSFmOyvH9e5alK9MFyw1pU5w7/BDB7mjE5lUTNZGzd3EdnqcJEI
 qTmkJveqjswV7ZA2gAcCbdz96Wbf/HcTr33ghUsIufAaidh5o36Ez+SHiN84FSaG9ZI0mJ26qeY
 53WBLFSONszZjgfgLzlRsn77IZukwUXYqbu8Qd790ufk9W4FSxbHln6pEA0f0MXIlfwMoll+xUv
 y3as3n4Rz03O1COOdw7sGRaJo2S7c0hHS//6BcwCThbGseMA0xFtJP6SqM54pbAm/xi32tGDU1h
 Oym9hxqTT9bZtBh+YfU6fabjPkbW3JTVbmVhixa+N5ccPKfzAXMJsHi9PFo6f1l+c9JVI4B9yRI
 HB1WCmvidcTTmc0UJFAqV0p1iaGsO4k7LOtLY2bTJGkWWMXyrxz9JML7/Qb+3xyvJOs8YG1Ndzh
 Y78AUDe4w8hTWdfVnsyzfsDclcZKmU0b1z/iZsXIDKl6Npgii7Xv7p6GGsgzmb92qNRppcOzRTF
 T2UBqNmnm4=
X-Received: by 2002:a17:907:9726:b0:bec:19c3:51f6 with SMTP id
 a640c23a62f3a-bf220e8c3ffmr8988166b.0.1780530582608; 
 Wed, 03 Jun 2026 16:49:42 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf04e9e3847sm228113866b.0.2026.06.03.16.49.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 16:49:42 -0700 (PDT)
Message-ID: <4d1879de-1083-4137-8138-3effacd982c5@gmail.com>
Date: Thu, 4 Jun 2026 01:49:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 03/10] phy: rockchip: sort Makefile and Kconfig
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <bfa214a7-4d46-490f-8581-5cd29b2504e4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Sort Makefile and Kconfig, so that new phy drivers entries
insert in a clean proper orderly way.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/phy/rockchip/Kconfig  | 27 ++++++++++++++-------------
 drivers/phy/rockchip/Makefile |  6 +++---
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index 80128335d52f..1662aef0b8fe 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -17,7 +17,7 @@ config PHY_ROCKCHIP_INNO_HDMI
 	depends on ARCH_ROCKCHIP
 	select PHY
 	help
-	  Enable this to support the Rockchip Innosilicon HDMI PHY.
+	  Support for Rockchip Innosilicon HDMI PHY.

 config PHY_ROCKCHIP_INNO_USB2
 	bool "Rockchip INNO USB2PHY Driver"
@@ -27,40 +27,41 @@ config PHY_ROCKCHIP_INNO_USB2
 	  Support for Rockchip USB2.0 PHY with Innosilicon IP block.

 config PHY_ROCKCHIP_NANENG_COMBOPHY
-	bool "Support Rockchip NANENG combo PHY Driver"
+	bool "Rockchip NANENG combo PHY Driver"
 	depends on ARCH_ROCKCHIP
 	select PHY
 	help
-	  Enable this to support the Rockchip NANENG combo PHY.
+	  Support for Rockchip NANENG combo PHY.

 config PHY_ROCKCHIP_PCIE
 	bool "Rockchip PCIe PHY Driver"
 	depends on ARCH_ROCKCHIP
 	select PHY
 	help
-	  Enable this to support the Rockchip PCIe PHY.
+	  Support for Rockchip PCIe PHY.

 config PHY_ROCKCHIP_SNPS_PCIE3
-	bool "Rockchip Snps PCIe3 PHY Driver"
-	depends on PHY && ARCH_ROCKCHIP
+	bool "Rockchip SNPS PCIe3 PHY Driver"
+	depends on ARCH_ROCKCHIP
+	select PHY
 	help
 	  Support for Rockchip PCIe3 PHY with Synopsys IP block.
 	  It could support PCIe Gen3 single root complex, and could
 	  also be able splited into multiple combinations of lanes.

-config PHY_ROCKCHIP_USBDP
-	tristate "Rockchip USBDP COMBO PHY Driver"
+config PHY_ROCKCHIP_TYPEC
+	bool "Rockchip TYPEC PHY Driver"
 	depends on ARCH_ROCKCHIP
 	select PHY
 	help
-	  Enable this to support the Rockchip USB3.0/DP
-	  combo PHY with Samsung IP block.
+	  Support for Rockchip USB TYPEC PHY.

-config PHY_ROCKCHIP_TYPEC
-	bool "Rockchip TYPEC PHY Driver"
+config PHY_ROCKCHIP_USBDP
+	bool "Rockchip USBDP COMBO PHY Driver"
 	depends on ARCH_ROCKCHIP
 	select PHY
 	help
-	  Enable this to support the Rockchip USB TYPEC PHY.
+	  Support for Rockchip USB3.0/DP
+	  combo PHY with Samsung IP block.

 endmenu
diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
index 04200174254e..b5e4763572bb 100644
--- a/drivers/phy/rockchip/Makefile
+++ b/drivers/phy/rockchip/Makefile
@@ -3,11 +3,11 @@
 # Copyright (C) 2020 Amarula Solutions(India)
 #

+obj-$(CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY)	+= phy-rockchip-inno-dsidphy.o
 obj-$(CONFIG_PHY_ROCKCHIP_INNO_HDMI)	+= phy-rockchip-inno-hdmi.o
 obj-$(CONFIG_PHY_ROCKCHIP_INNO_USB2)	+= phy-rockchip-inno-usb2.o
-obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY) += phy-rockchip-naneng-combphy.o
+obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY)	+= phy-rockchip-naneng-combphy.o
 obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
 obj-$(CONFIG_PHY_ROCKCHIP_SNPS_PCIE3)	+= phy-rockchip-snps-pcie3.o
 obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
-obj-$(CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY)	+= phy-rockchip-inno-dsidphy.o
-obj-$(CONFIG_PHY_ROCKCHIP_USBDP) += phy-rockchip-usbdp.o
+obj-$(CONFIG_PHY_ROCKCHIP_USBDP)	+= phy-rockchip-usbdp.o
--
2.39.5

