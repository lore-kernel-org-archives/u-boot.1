Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0A6C87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 13:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ACB2838D4;
	Thu, 31 Jul 2025 15:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=cknow.org header.i=@cknow.org header.b="PPjzFdJw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D034838DC; Thu, 31 Jul 2025 14:51:30 +0200 (CEST)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89CF583537
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 14:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cknow.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=didi.debian@cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
 t=1753966285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IbiUhDSoo/Bbf4taLJST+B5+ITOspcUGPxqjqeqcqnI=;
 b=PPjzFdJw6bRcjQSJEYYPQDMDw3idlsyEwAkPnXTw97iiTrUkKABW3C48C6h8591y5surk8
 QBWXyIZGGO6XtwWDhP/tAB47lSV1R9v5Fmyk9J+yapqy3S5PHNtrWcffpgMneRZBQF8yFR
 YHkHc/si8B7Rq/i4NeHRyn7t3EywANheMvML5qYpeQa549+YfRbsIpE53BFrUM9KgEPsI1
 lu+xOxCTg477cH1WdMkpy+ngBU9c2LjXiv4S9aGvdsvdX/m5yvPHat+nxxaZrMMHaqGuHh
 +nJu6FnXLNBSTA1NrHiGcp6JLbw+DMrjf0bZ5ZYsJbBlETlJfZrdJj/9H8Q4Fw==
From: Diederik de Haas <didi.debian@cknow.org>
To: Tianling Shen <cnsztl@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] rockchip: rk3568-nanopi-r5s: Enable ROCKUSB on NanoPi R5S
Date: Thu, 31 Jul 2025 14:47:05 +0200
Message-ID: <20250731125108.184224-1-didi.debian@cknow.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Thu, 31 Jul 2025 15:01:09 +0200
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

Enable the needed modules so that ROCKUSB can be used to update the
NanoPi R5S.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
The needed DeviceTree parts landed in Linus' tree here:
https://git.kernel.org/linus/07e04c071a35abe12957b575cd1453ccafc02eb6

and will be part of upstream kernel 6.17.

 configs/nanopi-r5s-rk3568_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
index 8e5e7e3e1e5..1653ab8b44f 100644
--- a/configs/nanopi-r5s-rk3568_defconfig
+++ b/configs/nanopi-r5s-rk3568_defconfig
@@ -28,6 +28,8 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
@@ -38,6 +40,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_SYSCON=y
 CONFIG_SPL_CLK=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MISC=y
@@ -73,4 +76,8 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_GENERIC=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_ERRNO_STR=y
-- 
2.50.1

