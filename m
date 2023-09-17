Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0895BCD37B4
	for <u-boot@archiver.kernel.org>; Sun, 17 Sep 2023 11:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 616E7863E5;
	Sun, 17 Sep 2023 13:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EvRWbMXS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZC6bNu4c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D18F58654A; Sun, 17 Sep 2023 13:51:16 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06C9286308
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 13:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RpR8f6pHJz9sSy;
 Sun, 17 Sep 2023 13:51:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694951474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+A+asH3ARlYShT0Ho2DzirRimkvQ6IfubIZcnFYLSN0=;
 b=EvRWbMXSqMKwqXEMS1O0F7iT8DN9yIfbBEGniZHSE42TFgc/B29UQIvu2DCC8thp4EvicX
 sqy1p2wOeXOMufCPO6DJfTFt26CMfkS4fsbpP6XaQRO1LKnvRdTQovRZMmfmLVBxIuiUtP
 kAUQuDYGP46ejUfgrM4j/Z9qmRy6NccF1RPKMmmC1jbkNcF4cK6TKnl7e4OHR5yV0F5MsL
 eC2O0AgoCQyaU70W/grV4ThaTHXLHdqRozOGDIuANQMNHfWUX1uCV71vlNgiHe0RoJdv0N
 F4kHw3COk+7x6+hMAuDiu2VVG0R2KpuXEO/FWO595/tX9oQQCBdmGbF8Xw9PRw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694951473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+A+asH3ARlYShT0Ho2DzirRimkvQ6IfubIZcnFYLSN0=;
 b=ZC6bNu4cuXs5ciWl5TicgMRYlig97rs6yfHfaRgueSOOlzYABC4FjF6ZB2+pH8Yd3T+C13
 uNQBfZ/snAPyA/H1JJ4j6H2kjETjRiLGS8gByXH/L+yYIX29UV9Try9amGGj7tgV9HsIB0
 r/K2XOW15NjTjNNQqcbVgMmHH/gliXHc0IusY4uYveysIMBaThFKaxGOV42AX/WdQ1xinc
 P2NCCKL+OhPOSEG8/EViMxaxd7k3lq73IlZQx3v8WZVMOrGsOlcrGtvWMINg7Yj79yMfDO
 I0pkuc32erC1WoJVt5RqEa6i3+zhiDmNqvuKepk4OzwDgoTjlkwfOhkCYOl+zw==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] ARM: renesas: Enable DM_ETH_PHY on 64-bit R-Car boards
Date: Sun, 17 Sep 2023 13:51:03 +0200
Message-Id: <20230917115103.203031-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cee50eb6bf185bab554
X-MBO-RS-META: bqwuempjgnn7kjtiqk6byqpsb5tna8bb
X-Rspamd-Queue-Id: 4RpR8f6pHJz9sSy
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

Enable DM_ETH_PHY to correctly release the PHY on these boards from reset.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 configs/r8a77970_eagle_defconfig     | 1 +
 configs/r8a77970_v3msk_defconfig     | 1 +
 configs/r8a77980_condor_defconfig    | 1 +
 configs/r8a77980_v3hsk_defconfig     | 1 +
 configs/r8a77990_ebisu_defconfig     | 1 +
 configs/r8a77995_draak_defconfig     | 1 +
 configs/r8a779a0_falcon_defconfig    | 1 +
 configs/r8a779g0_whitehawk_defconfig | 1 +
 configs/rcar3_salvator-x_defconfig   | 1 +
 configs/rcar3_ulcb_defconfig         | 1 +
 10 files changed, 10 insertions(+)

diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_defconfig
index 56d62bcfd2f..4d40dbf66ac 100644
--- a/configs/r8a77970_eagle_defconfig
+++ b/configs/r8a77970_eagle_defconfig
@@ -71,6 +71,7 @@ CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_RENESAS_RAVB=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
diff --git a/configs/r8a77970_v3msk_defconfig b/configs/r8a77970_v3msk_defconfig
index e26607a897e..61e261857e4 100644
--- a/configs/r8a77970_v3msk_defconfig
+++ b/configs/r8a77970_v3msk_defconfig
@@ -76,6 +76,7 @@ CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_RENESAS_RAVB=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
diff --git a/configs/r8a77980_condor_defconfig b/configs/r8a77980_condor_defconfig
index 57df450a169..b73129f9f73 100644
--- a/configs/r8a77980_condor_defconfig
+++ b/configs/r8a77980_condor_defconfig
@@ -79,6 +79,7 @@ CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_SH_ETHER=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
diff --git a/configs/r8a77980_v3hsk_defconfig b/configs/r8a77980_v3hsk_defconfig
index 0025c044c0e..f48ed6caaa2 100644
--- a/configs/r8a77980_v3hsk_defconfig
+++ b/configs/r8a77980_v3hsk_defconfig
@@ -72,6 +72,7 @@ CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_SH_ETHER=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_defconfig
index 95eb911593d..55bc3034764 100644
--- a/configs/r8a77990_ebisu_defconfig
+++ b/configs/r8a77990_ebisu_defconfig
@@ -93,6 +93,7 @@ CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_RENESAS_RAVB=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_defconfig
index 4b679716c62..1c1b7256a4e 100644
--- a/configs/r8a77995_draak_defconfig
+++ b/configs/r8a77995_draak_defconfig
@@ -90,6 +90,7 @@ CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_RENESAS_RAVB=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
diff --git a/configs/r8a779a0_falcon_defconfig b/configs/r8a779a0_falcon_defconfig
index 5350447c755..93f10552250 100644
--- a/configs/r8a779a0_falcon_defconfig
+++ b/configs/r8a779a0_falcon_defconfig
@@ -65,6 +65,7 @@ CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_RENESAS_RAVB=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
index 45471541843..1d0805c4e3e 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -63,6 +63,7 @@ CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_RENESAS_RAVB=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index 8de39c6e6d8..6aaf24e0126 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -97,6 +97,7 @@ CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_RENESAS_RAVB=y
 CONFIG_NVME_PCI=y
 CONFIG_PCI_REGION_MULTI_ENTRY=y
diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
index b8fdb5e3826..489e710e1e7 100644
--- a/configs/rcar3_ulcb_defconfig
+++ b/configs/rcar3_ulcb_defconfig
@@ -94,6 +94,7 @@ CONFIG_BITBANGMII=y
 CONFIG_BITBANGMII_MULTI=y
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_RENESAS_RAVB=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
-- 
2.40.1

