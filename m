Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724FCC43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 14:46:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EB88849C5;
	Fri, 26 Jun 2026 16:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UTbTgYMJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A3084987; Fri, 26 Jun 2026 16:45:54 +0200 (CEST)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com
 [IPv6:2607:f8b0:4864:20::122b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7531B849EF
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 16:45:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-139d5c9a495so3515c88.0
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782485151; x=1783089951; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBT1+Mm5G8FUFxzbA87mUyRoTR1o+Sh/kt+xu7eq2j4=;
 b=UTbTgYMJ6AT4b0GVl4i+rNmKTGX06J6Bdze7KOQ3M5WaVsZnUnMcd+mh4rRtgrP80D
 rxCFtXwgUyLu3fgJi/zKIneWJr2I5gzVDzQ6Wx2uNYp9yk9FHX+PeB77zf05H2dKrbJI
 E9qYLcp0hyFrR1sfAce4cI1cu/iDK+mchhN0UoOk6+tmQnvhBLsqL0anfZwLtM2WD1XG
 d4gf+dRw4gTVj6AYdIirK1H9w7mYQULUTg85TEESSKBNHfpUO2eeVwT7GA8p8bgcpeTE
 PMmHyc+Qm7I0X/XiR4b+LNxYGysqqwb2RjhZ/Aws9sNZWRYHq5fDhUSvhYwxOIjU+Fze
 DpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782485151; x=1783089951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TBT1+Mm5G8FUFxzbA87mUyRoTR1o+Sh/kt+xu7eq2j4=;
 b=MeyItdkYbCMJtfckDGrpxDSZWIKX0+/AXG0rGzZzBLSAZbcl4aVKjj57s6/9UxLaD0
 DLVObajtfEZC7pxfebLpiHKeTN26yuqjkrsSfft8g6xvAWdX+Bg/gem9gSWwfOyleT9w
 xmc2FU4GLS7xPEiJsP1AxrRbqjee+dZIdj3wMnIj22Kl96ABIe7NaDb9zUF3N+qXxRw7
 pnLR+Xj2Rqq7e01CEae3QmV5tuY6z0KY7g7yMiHElBj7YC7s6Uhfv6pA11/+Ou/xIhGg
 ALyPhJ4c5dOGiIldqE3tPFav7sWFZZIGv+hn7LbSgMiLLhJ1CEJ8s/BcbAxjNgv5hv/P
 kr5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XW9YLejLRLv2Zw3G24KXfa23erciNrZXwD7xLj2HV2eyot84fKxA6Brv3pA1KUjF4aN9jrNg=@lists.denx.de
X-Gm-Message-State: AOJu0YxPaaUOtp4ByRnd1w0W2cofVgyh1IpwVhdSWZLPUfzpY40NaCzC
 n9dJPdRKRMCwqdThTf/b2PqfwAG/NmBTsek7kkOZB3AyxKOXN5fw/nuGV/dsDg==
X-Gm-Gg: AfdE7cmpIvMGnsKxs3t96qhQwpeY9sEimPdOZi/kq5yu3IbqcH7hgxddiOIW3JRIv4O
 TLXbXGbhbOpKACkGof3fkN7ZNz4pTnORKqqCIRNGBQjvy/iH/LMWPOOsO0FEIacz5dbbkZFTZky
 +wvfx9Id7REq4hFfqeosGyuzI36jewmWZel4ZNzzDoqHXyiuBoV17jNXphyPGBpBwthcUNolwOd
 mVVdglMlzbXItNOhM9nQf24ddmjkIwi81hAX689R4K1jWNf3XZQULOyrSxlwHa+KjtB/JaGDZ13
 uhn3PSiEQXsaRnxkimXJ7NudRRIRJv22Or1mue0pNUkJw25cr3G2NuMPi8/SrtzUHD7c761D7xD
 US69lRenZ2Ae1sdmksaEC8drYK1XHcmLUiGyt7+QUO1tFOVAiENWclQFECEmP/4SlqUNr5eoi91
 0DAJqjtTWaBEZKtinfKIz7ZVE7mLdD+2OJhi+qRSK+vIwV5d1ScneL78RiebNZhb6/j6x/hg==
X-Received: by 2002:a05:7022:fa09:b0:138:14dd:16c6 with SMTP id
 a92af1059eb24-139dbb5b04dmr5785038c88.34.1782485150714; 
 Fri, 26 Jun 2026 07:45:50 -0700 (PDT)
Received: from fabio-Precision-3551..
 ([2804:1b3:a800:24b8:381f:62d1:5cfb:ac63])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d9105b57sm18823739c88.14.2026.06.26.07.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 07:45:50 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: djw@t-chip.com.cn, sunil@amarulasolutions.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH 5/5] roc-pc-plus-rk3399: Enable USB Mass Storage support
Date: Fri, 26 Jun 2026 11:45:33 -0300
Message-ID: <20260626144533.2925490-5-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626144533.2925490-1-festevam@gmail.com>
References: <20260626144533.2925490-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

Configure the USB0 DWC3 controller for peripheral mode and enable the
required USB gadget options to support the U-Boot 'ums' command on the
ROC-RK3399-PC Plus.

The 'ums' command provides a convenient way to expose the on-board eMMC
as a USB Mass Storage device to a host computer, simplifying development,
image installation and recovery without requiring removable media or
network access.

Limit the controller to High-Speed operation by using the USB2 OTG PHY.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
 arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi | 7 +++++++
 configs/roc-pc-plus-rk3399_defconfig        | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
index 7d5af3e234da..f613d75646c3 100644
--- a/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
@@ -7,3 +7,10 @@
 &dc_12v {
 	/delete-property/ vin-supply;
 };
+
+&usbdrd_dwc3_0 {
+	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
+	phys = <&u2phy0_otg>;
+	phy-names = "usb2-phy";
+};
diff --git a/configs/roc-pc-plus-rk3399_defconfig b/configs/roc-pc-plus-rk3399_defconfig
index 4ec2f7d44b5f..f3d78c53e672 100644
--- a/configs/roc-pc-plus-rk3399_defconfig
+++ b/configs/roc-pc-plus-rk3399_defconfig
@@ -2,3 +2,6 @@
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-roc-pc-plus"
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-roc-pc-plus.dtb"
 CONFIG_SPI_FLASH_XMC=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_USB_GADGET_DOWNLOAD=y
-- 
2.43.0

