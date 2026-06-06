Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E56CD6E55
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 04:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4BF984987;
	Sat,  6 Jun 2026 06:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rIl4ptyI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84D0B84671; Sat,  6 Jun 2026 02:52:50 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAF3A84957
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 02:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B5404446E;
 Sat,  6 Jun 2026 00:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2C001C2BCB4;
 Sat,  6 Jun 2026 00:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780707161;
 bh=DSstjh/7xUJmKDNmodvz/zeYjwEhUZkVTI8BgGZiT+M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=rIl4ptyI2WjokLnkI+tRDCsm11yuGq2NPwNXCasGz1ljm1/o+zuY2CFNYJOsuAtK+
 mYGHYXWalde1PsgiIpFhk9bzoSnDVBy7NWIxJ2CkeQJdmuwwpT1odLztRNP3jhJw6j
 5DkC3XnFoFMNn5r1fpYIQE6wVoyglmsdKRxG2HoGx2cwdpy/dTUkLHn7KvSeT9edGC
 CAuKSszb4NAharyZU1gwhID1+LmtAkhou7hC/S4FieoHage2YB7uksVUdzyyn2lX3S
 6hgkL1qY0IAU9kUisYO+4ky1EbLU1ngH392DOLR8WObrbOAHpCGOZktm+nBdZBA0+X
 4u3JRwtx6l6IQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 23D2DCD8C89;
 Sat,  6 Jun 2026 00:52:41 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 06 Jun 2026 10:52:47 +1000
Subject: [PATCH 13/13] configs: exynos-mobile: pull in BINMAN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-android-binman-v1-13-c7a3c14b8a3d@samcday.com>
References: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
In-Reply-To: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>, 
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Denis Mukhin <dmukhin@ford.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Javier Tia <floss@jetm.me>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780707158; l=1723;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=AwJf3/zy873wIvJbnCoM+ZN4PCzMAP0EqTx9xh5hUOY=;
 b=czWyhKharYCSFYrllNJQshY/OUhqTb1IXHvdXffSNtvdjw90rg+1gQDxXZ0O5cbglxXlfhui5
 r5p4Xag2SonCorlkL2hWxgPFWsCiQ9MX06ZUn91eHWN8K5dry5k0+n/
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
X-Mailman-Approved-At: Sat, 06 Jun 2026 06:27:39 +0200
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

All Exynos7 mobile devices need abootimg+DTBH wrapping to be bootable
from the fused S-BOOT bootloader. So we enable BINMAN everywhere.
Ideally we'll have full coverage of these devices with binman configs in
the overlay DTSIs but, for now, we ensure there's a placeholder node.
That way no existing devices will regress their cleanly buildable state.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/dts/exynos-mobile.dtsi | 5 +++++
 arch/arm/mach-exynos/Kconfig    | 1 +
 configs/exynos-mobile_defconfig | 1 +
 3 files changed, 7 insertions(+)

diff --git a/arch/arm/dts/exynos-mobile.dtsi b/arch/arm/dts/exynos-mobile.dtsi
new file mode 100644
index 00000000000..9982e996993
--- /dev/null
+++ b/arch/arm/dts/exynos-mobile.dtsi
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+/ {
+	binman {
+	};
+};
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index b084b7284aa..d4ae182030d 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -255,6 +255,7 @@ endif
 config TARGET_EXYNOS_MOBILE
 	bool "Samsung Exynos Generic Boards (for mobile devices)"
 	select ARM64
+	select BINMAN
 	select BOARD_EARLY_INIT_F
 	select CLK_EXYNOS
 	select LINUX_KERNEL_IMAGE_HEADER
diff --git a/configs/exynos-mobile_defconfig b/configs/exynos-mobile_defconfig
index 45ab998bb45..fcaff3d1608 100644
--- a/configs/exynos-mobile_defconfig
+++ b/configs/exynos-mobile_defconfig
@@ -32,6 +32,7 @@ CONFIG_EFI_PARTITION=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
 CONFIG_OF_BOARD=y
+CONFIG_DEVICE_TREE_INCLUDES="exynos-mobile.dtsi"
 CONFIG_BLKMAP=y
 CONFIG_BUTTON_REMAP_PHONE_KEYS=y
 CONFIG_CLK_EXYNOS7870=y

-- 
2.54.0


