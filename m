Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C566CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 01:28:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D70D3849CA;
	Wed, 10 Jun 2026 03:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ua3gvxy8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C607849BD; Wed, 10 Jun 2026 03:27:49 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8DDA849BF
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 03:27:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E6A3602D3;
 Wed, 10 Jun 2026 01:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2D34C4AF13;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1781054861;
 bh=CbRFiWSD1WFg6GbB3kTOBu9D8OGFjuaUz8zloCd+rqU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ua3gvxy8epS1aB/I3pCm8dv326jak5bMSmw6KBwCRgyf+Mg85L+H0oRrF9ROzLBm8
 P5yRp65/oZzSvgwIQNac8YIWXNEPaOeYHrY7avGTwgzhNeIZ5FKp0nofKUt4JXTPZG
 QxNmtFOXFaKzgWSkYONJwetlnHIZ4Gctg8bRD5Q2mU+aUKx+H0d4YQZjQocafE/1g/
 PhW1694VfzdBUcsEmr3+LKVilfxXa55+zqOn590lnHjp33xV7iFN+KZTDYgCcJcazL
 Olv4hEKTLYB/eAP3v9kl8plQaNj2iRIBmbjZNQtL/O7uM1wU66UGy2uPEsg34KZh8G
 Pr+T1IZs0baBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id DA8BDCD98C7;
 Wed, 10 Jun 2026 01:27:41 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Wed, 10 Jun 2026 11:27:48 +1000
Subject: [PATCH v3 10/10] configs: exynos-mobile: pull in binman
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-android-binman-v3-10-710298a38fcc@samcday.com>
References: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
In-Reply-To: <20260610-android-binman-v3-0-710298a38fcc@samcday.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>, 
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>, yan wang <yan.wang@softathome.com>, 
 Marek Vasut <marex@nabladev.com>, Denis Mukhin <dmukhin@ford.com>, 
 Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781054859; l=1768;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=NRBHpe34CND7n6voXLMnN6rRvIFMkJs8mIzyqLmR+Uk=;
 b=C9Z4cucraCqjuataCkCM/TVL3trF5h3nVX46fAmkzi/DEFe8qWoDuW+DzeCMo1vBIy62CzJyE
 j8pgu6JS32YBIfQRDTncga7FfmJCKruP+DsXB0zOdsb0hMFvw9u/3pN
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
from the fused S-BOOT bootloader. So we enable binman everywhere.
Ideally we'll have full coverage of these devices with binman configs in
the overlay DTSIs but, for now, we ensure there's a placeholder node.
That way no existing devices will regress their cleanly buildable state.

Reviewed-by: Simon Glass <sjg@chromium.org>
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


