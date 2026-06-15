Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A46CD98CE
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 21:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E624C848A2;
	Mon, 15 Jun 2026 23:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pGk4DzCo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B7CC848A6; Mon, 15 Jun 2026 23:07:32 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FCCB8484C
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 23:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-68c14ac8ebcso645904a12.2
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 14:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781557650; x=1782162450; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xqJVDDUtVs3r2qpkFRkrFst//SlR3CDD8qy6f7/KJn4=;
 b=pGk4DzCoBAQZ1iRBxDo1/vCI04LYSV65mK7AMFiH/gUEF/5jlZqfFXPnYRLWzPCU1w
 zL7EtEtxYa2NrS724qpMmoRWiZ64fPAbq1FI6uXtlsZTcDCQY8G8dVArXBaKdrpCGgjG
 ooxR0Z3x8S0LM0RzrXYDyYJrfKdKHobGlK+C/PZOzPk503BwzVbKSarFB0kipeHSmkQC
 +qoq9Mkvv8+yn/tXSE1rKfq7Uvbb7wIjRwkMDfNEseD0azQnouJHG63kFrDgjWjKZMLj
 Jmm4O25jtAeoHN2WD/cgLcMcEpYk7W0c0fcSZAx6AdYiB0+sPPE7k51x59ecJvvL5hX+
 1qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781557650; x=1782162450;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xqJVDDUtVs3r2qpkFRkrFst//SlR3CDD8qy6f7/KJn4=;
 b=UiXjo4RbCtan248L8C5RuFqtuE5wigoxt9i6vt84wi9CpyOBCpyvk0gGzM8VaOlWyx
 KmjKh6z1ISb/9pw0D1wiX1Zww37moeOb/6vIn4dxbfB/6wTw+T4jMOMs9ONTvOcXJ88j
 Ay8ng60m3ubexkAfkpOR+Rt0fkz12d06dmebfLi01OsyNbspwTvnGXalq2bB4PvWtnjb
 AB5CqRizaXyFTAgzB3SXCs9rVLGycCbYmuukt4+0fDavilapDmx1XE4gfFdt7yceNrxr
 xYRrdBcReXNGx91Sd5XgvVy5Avt8vGluEfS8pZdsFtTV1KAlPOTnEgFIw5apL4O7Blzh
 ypkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ91qHtjlOrDamTaMY6P7324eozhSnI03mQW4IH4wzZGs3K9KiNW/u8LBmX5DqybVisZ+9jNRag=@lists.denx.de
X-Gm-Message-State: AOJu0YzAPb3TqXT60HiIwsFknQGCkyIn6inXhQ0sTULs55Dr04Og5UvL
 lQKGvl7c3BkgZ+7qk9MlbLDNw5RL6MYXej8LpkRSQ6Jj33GLHpyFaAmF
X-Gm-Gg: Acq92OFUfy/neS8r9I/xCeUI7IWGHm14hKpdKjQZxL0powD0XrF+rlsKhFs1Twbjh2u
 l+tHHhkdAB6O4PcEgoEMDueWGiamYyjITakKFy/zpOMPks+CcsH90GSMHMxfW4+p2+3UdddLBUo
 g90jUc8QzqlCa7GxT6CpzL49pJsD0t2F83DjjTMSUZ7HEjd/CRbBrp54Jdh7J1+LXrv/umBE+hD
 oJIvIwxzbam4y5EtGdWMKWqc7NRSRN40N00z9nGgoV0jlTbwjstOGOrmSXuTAbCCYnATt/dpvWC
 zFeXfxwVOcRm1xELuX8zQcVaSmkAdK9fPv51pEgvOaEton6Lsai/6ZSQ/13mK7jQPoy4+moI6ta
 ngJ238a2wWN7+bf3Uqs9TemDXqtBQdw/q76mUovyXm42KWIHQ4ZULE5c1oZ4+ctFjb4o9XqzsDt
 nUQw+Za1a3xMtu8yaKSGa4FlP/1MxMZpMUNAuutcA8xDdcIbNn6Y4GEA++afX+UA==
X-Received: by 2002:a05:6402:26d2:b0:66e:431a:ac3a with SMTP id
 4fb4d7f45d1cf-693787f67c5mr3006672a12.2.1781557649726; 
 Mon, 15 Jun 2026 14:07:29 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6937949fb19sm3873106a12.27.2026.06.15.14.07.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 14:07:28 -0700 (PDT)
Message-ID: <fe8f401b-142e-487d-9b3e-6cda88dd9cff@gmail.com>
Date: Mon, 15 Jun 2026 23:07:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 03/10] phy: rockchip: sort Makefile and Kconfig
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, marex@denx.de, u-boot@lists.denx.de,
 upstream@lists.phytec.de
References: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <9e688aba-c88f-404a-adc7-cf9472699d66@gmail.com>
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

