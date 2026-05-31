Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB1CCD6E52
	for <u-boot@archiver.kernel.org>; Sun, 31 May 2026 21:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4856884825;
	Sun, 31 May 2026 23:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BWwG2tC4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61E9E84701; Sun, 31 May 2026 23:03:51 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 789B484825
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 23:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-68d22a95815so169134a12.3
 for <u-boot@lists.denx.de>; Sun, 31 May 2026 14:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780261429; x=1780866229; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ah1r05ZNinwV/fWM1hLIVpN9ap42suOmA4YlQdZ/VgU=;
 b=BWwG2tC46dID6kRy4Am4ksaNUAJHwFVfn7/Hv9HioOGyAh9bqPMxp+gngoO9/u97gB
 VgX2rD+yJ1opteR9jUE+sqM4UxoZtcocC6a3lv/y3U2rgK7PZwPlD5FIXBGpT2AYoMap
 Re1iHT8jGtgYlLsSdvhcCfs1I/GkcOe+JGyKejKu9sCaOW2I3amDyMNCPQVtdgzPYTBK
 yhyFIJpfgEd/2vmUpGmsD6rm7D05AceIIBXwxqnr762WOa5deMogp2WgBjjwp9HooQzJ
 E5gG7FjS1CYOW1m2OVorDV2zhNL+k++90bIN3wPRhlO9U311R4AZyeXjv7wNmV2qGegT
 uqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780261429; x=1780866229;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ah1r05ZNinwV/fWM1hLIVpN9ap42suOmA4YlQdZ/VgU=;
 b=ZTeuRwPsPPbMqh4Ia94M+ael0CPmC1bkpGvr7zuJS+lutrJXs+hGQjnNlzQrEKT54m
 iVXqVEpcJZiV+X46AB6Ryjx6z/lHadXR0Si8XEEe3wNLICQ3H1eiS0ivIf3rkJ/EPjm4
 foDCW2X3PSAkKOKhVUI4fAXVmNIqJxQ2T7FgGDbWfNvMO9G1BjMmoguapX+msTTO1DgU
 QwG7hqgMLsvqSVaypfIC4PI43ih3CB4pJheiUJMwHwrimKOeC34bRaLTkDKxHE4zU9Rz
 FsVbnKKknV5iLGra1auhfh9TEq+ctHeQsHpwHQ3P9BxCgKci307hYRcjof1ziNf+DdBy
 iZqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ89LJ8/x9TPGaDOZsji9NhuxPz/eBQk99Ujtm0TQId330k1lKwKJuZMDkxRsShpNcRoLGpokuE=@lists.denx.de
X-Gm-Message-State: AOJu0YxfAeWwTwZOdZ57WrSf0BrKBE/yEPk2kQJHRrlSX/naE9gMRCUl
 Txu001/r3+knWNFSch1a0BKaieHcau8Tw2TxmFvS6D7N7u1Z/lEh840U
X-Gm-Gg: Acq92OHQqoieEQcJOB4DmfoUGb/RaQKSZKZ3kwjARvrjPROgn2tHz92S+C/hpV8frWG
 Ncy1/d/cjCPBahUsQvtfCpYSz3aDpJ40ps2dkpxLFVfd5FBwTR/76Bi3ZhWE8qtj9pOU/sMrijS
 tLQOdlkavUJ2WZaVAn04NsRoI36qbjn+tg7OFV4C+76oCubhSz3SncfXSleX7sMh9MNYr1KowkI
 rIDiu4RcvfKGAaEafCbzs5co0Xm4knhps43OWFUvphQYS5V3EoB7ml7YR/x1WSLL/JnF3Jxjf4h
 axl8pefGleSP9jweUmTFmCv4Q1eXz2/HPil7cwFanJ+eRgVHIHgnbUo9+f3JKaiZb/g3hoLW90d
 230AkwYDnH5fLa1Mpv0jmIWlJR28IL+D3klV1FiHamkZQ3Ry7AwZGmpQ2VU7iaUCmRQttG2Sxjn
 0y7CyM9Xly8QhROqM+FShhAontg1ccvNWA58ofsSfuiCK5QYv4TB9JhmjVNrQd0KusUNckmFtK
X-Received: by 2002:a17:907:2d89:b0:beb:8aa7:61d4 with SMTP id
 a640c23a62f3a-beb8aa7630emr129700666b.5.1780261428868; 
 Sun, 31 May 2026 14:03:48 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bec273b6b2fsm101023866b.43.2026.05.31.14.03.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 31 May 2026 14:03:47 -0700 (PDT)
Message-ID: <54982f90-0cea-498e-bafa-fe2bf3a43dda@gmail.com>
Date: Sun, 31 May 2026 23:03:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v3 08/12] rockchip: phy: make phy-rockchip-usb2 available in
 SPL
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 hl@rock-chips.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jagan@amarulasolutions.com, heiko@sntech.de, jonas@kwiboo.se,
 michael@amarulasolutions.com, lukma@denx.de, marex@denx.de,
 u-boot@lists.denx.de, upstream@lists.phytec.de
References: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <3a63b606-621d-486c-9aae-3a819ef05430@gmail.com>
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

Make phy-rockchip-usb2 available as phy for dwc2 USB
in SPL to load U-boot (full) from a USB disk.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/phy/rockchip/Kconfig  | 10 ++++++++++
 drivers/phy/rockchip/Makefile |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/Kconfig b/drivers/phy/rockchip/Kconfig
index 745e0ea67b8d..754b178a0bbb 100644
--- a/drivers/phy/rockchip/Kconfig
+++ b/drivers/phy/rockchip/Kconfig
@@ -60,6 +60,16 @@ config PHY_ROCKCHIP_USB2
 	bool "Rockchip USB2 PHY"
 	depends on ARCH_ROCKCHIP
 	select PHY
+	select RESET_ROCKCHIP
+	help
+	  Support for Rockchip USB 2.0 PHY.
+
+config SPL_PHY_ROCKCHIP_USB2
+	bool "Rockchip USB2 PHY in SPL"
+	depends on ARCH_ROCKCHIP && SPL
+	default n
+	select SPL_PHY
+	select SPL_RESET_ROCKCHIP
 	help
 	  Support for Rockchip USB 2.0 PHY.

diff --git a/drivers/phy/rockchip/Makefile b/drivers/phy/rockchip/Makefile
index f296dc8f3d2a..c5577dfe86e8 100644
--- a/drivers/phy/rockchip/Makefile
+++ b/drivers/phy/rockchip/Makefile
@@ -10,5 +10,5 @@ obj-$(CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY) += phy-rockchip-naneng-combphy.o
 obj-$(CONFIG_PHY_ROCKCHIP_PCIE)		+= phy-rockchip-pcie.o
 obj-$(CONFIG_PHY_ROCKCHIP_SNPS_PCIE3)	+= phy-rockchip-snps-pcie3.o
 obj-$(CONFIG_PHY_ROCKCHIP_TYPEC)	+= phy-rockchip-typec.o
-obj-$(CONFIG_PHY_ROCKCHIP_USB2)		+= phy-rockchip-usb2.o
+obj-$(CONFIG_$(PHASE_)PHY_ROCKCHIP_USB2)	+= phy-rockchip-usb2.o
 obj-$(CONFIG_PHY_ROCKCHIP_USBDP)	+= phy-rockchip-usbdp.o
--
2.39.5

