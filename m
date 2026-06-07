Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3791ECD8C9F
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 23:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A281F8488A;
	Mon,  8 Jun 2026 01:37:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WxTP1gwd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97170846E6; Mon,  8 Jun 2026 01:37:23 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAE02847C3
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 01:37:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D369445C4;
 Sun,  7 Jun 2026 23:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F2BFC2BCB4;
 Sun,  7 Jun 2026 23:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780875435;
 bh=DSstjh/7xUJmKDNmodvz/zeYjwEhUZkVTI8BgGZiT+M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=WxTP1gwdfSbvAkE4dlXb2EbRZj7eL3uREPd2aYfx/Bm+IeKRyXZiavOtGDkUxTA2f
 TYdMLa4DNnPQK+eeMEGDNY62oqVuEq8UhyhpyCkM3WZ7waTX88o8uSUCHixp221aUa
 rH9KyWhAsslGj1q8XUNqtt3muOVT7VnMWHGzf6fCMe5WFGKGbSErzmBRSAzzsbrTMm
 5/e8YkuY5UnehV5EiFEgSAxs+PoKMRRA0HpB1HPAGSBbDZpFAv03T4U3XTfnMK/3Ru
 Oub4JtTYZpgtRD4j4jacKSpfAVPdsGywm/peCUfjSKTFX400o7gxtlVWi4fDA7SwNa
 4kTCojw8qpskw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7835DCD8C9F;
 Sun,  7 Jun 2026 23:37:15 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Mon, 08 Jun 2026 09:37:17 +1000
Subject: [PATCH v2 8/8] configs: exynos-mobile: pull in BINMAN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-android-binman-v2-8-b8203682507f@samcday.com>
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
In-Reply-To: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
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
 Henrik Grimler <henrik@grimler.se>, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780875433; l=1723;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=AwJf3/zy873wIvJbnCoM+ZN4PCzMAP0EqTx9xh5hUOY=;
 b=9qSkJDMOVXU+kWOgKNVuzZnmQnL2idHgGf0XOWFyLkH7Ra4M2yPghtRn9+CJuLwn4EQbDS8te
 cPej9kv3/KEA8U9vlyfzfJ2M0hauDRA1xx4HVWaspyXzkquLULoZvwp
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


