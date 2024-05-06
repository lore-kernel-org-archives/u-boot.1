Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77855C25B4F
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 14:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A384D88625;
	Mon,  6 May 2024 16:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bNvit3kr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 948E788638; Mon,  6 May 2024 16:39:07 +0200 (CEST)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 835BB8860E
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 16:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martyn.welch@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1715006345;
 bh=6JSKrjy6iJE0wfOolFLiD8Ys06uloVwOwVOgRWPxRlk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bNvit3krzwn1JYlhkD048Q+FrPzvz+kN+vLNrNvQl4TBOkgdjyq+TJxbs6IV8VbjP
 i3SaHTZMIH/6H8IwSVmTRkm5NIVjxaILtS2V3EXonZMQm20pCrfwBFSoHQ3IxyRAto
 ssNC67NOMGQR0+Ft1w5pxDiIS2cq6Ss+OIDQsPDBqSzqTXUoGoB63VVdtGZsX8oPWa
 1uPaJlJbutQIW/clrOQ998f1TLMv5RaHGmBU78qircjlNz6ewq9lVb+g/L6NidX0Ue
 ANgMi9bCSzhaxc0BKqTwWgFT4bHJ4xTZa1dPjCWTqEJtZJ2re7iRiNfygiXkDaVsJN
 uNGaWthGs/qqg==
Received: from pan.lan (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com
 [34.240.57.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: martyn)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id AF4AE3782134;
 Mon,  6 May 2024 14:39:04 +0000 (UTC)
From: Martyn Welch <martyn.welch@collabora.com>
To: Dave Gerlach <d-gerlach@ti.com>, Tom Rini <trini@konsulko.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Cc: Sjoerd Simons <sjoerd@collabora.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: [PATCH v5 5/6] beagleplay: Add DFU support
Date: Mon,  6 May 2024 15:38:45 +0100
Message-ID: <20240506143846.1252377-6-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240506143846.1252377-1-martyn.welch@collabora.com>
References: <20240506143846.1252377-1-martyn.welch@collabora.com>
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

From: Sjoerd Simons <sjoerd@collabora.com>

DFU mode on a beagleplay can be used via the Type-C connector by holding
the USR switch while powering on.

Configuration is already provided as fragments for both the A53 and R5
u-boot parts. Include the am62x_a53_usbdfu.config config. The
am62x_r5_usbdfu.config fragment needs to be added should DFU boot be
required as this will disable booting from persistent storage due to
binary size constraints.

Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
Changes in v5:
- Use existing config fragment for a53 DFU configuration
- Force usb0 into peripheral mode

Changes in v4:
- New patch

 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 9 +++++++++
 board/beagle/beagleplay/beagleplay.env       | 1 +
 configs/am62x_beagleplay_a53_defconfig       | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index fb2032068d..967a2bdcd1 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -54,6 +54,15 @@
 	>;
 };
 
+&usbss0 {
+	bootph-all;
+};
+
+&usb0 {
+	dr_mode = "peripheral";
+	bootph-all;
+};
+
 #ifdef CONFIG_TARGET_AM625_A53_BEAGLEPLAY
 
 #define SPL_NODTB "spl/u-boot-spl-nodtb.bin"
diff --git a/board/beagle/beagleplay/beagleplay.env b/board/beagle/beagleplay/beagleplay.env
index bbf6b925d0..8dbfc2f7d2 100644
--- a/board/beagle/beagleplay/beagleplay.env
+++ b/board/beagle/beagleplay/beagleplay.env
@@ -1,5 +1,6 @@
 #include <env/ti/ti_common.env>
 #include <env/ti/mmc.env>
+#include <env/ti/k3_dfu.env>
 
 name_kern=Image
 console=ttyS2,115200n8
diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
index 4f1be1df59..ec62670d55 100644
--- a/configs/am62x_beagleplay_a53_defconfig
+++ b/configs/am62x_beagleplay_a53_defconfig
@@ -121,3 +121,5 @@ CONFIG_EXT4_WRITE=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_LZO=y
 CONFIG_EFI_SET_TIME=y
+
+#include <configs/am62x_a53_usbdfu.config>
-- 
2.43.0

