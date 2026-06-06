Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D43CCD6E75
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 04:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60494848A1;
	Sat,  6 Jun 2026 06:27:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="odb4Icfo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA2F484974; Sat,  6 Jun 2026 02:52:46 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57E54848E2
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 02:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A3F1444570;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8457DC2BCFB;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780707160;
 bh=+vU3y8sODv0+s8cSHMA583UuR/jfIrUNUcuD17wsvI0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=odb4Icforlmo9uZgtnLxBDzhc3RC79RxAOVo+PARmevQhA1njOxOpdB71BCc7EgSL
 xDYkmTR+vhcRimFLmoYl9eYU6RqAgngH3Ki1QhalbJou5Lb2elEGWNYDY6ImQ0iZtu
 mW64q10pYQIc+yZQoyisLVW8DvsQSqlRGsk/jEadaDuTnxgrSvLis4juebHxD4zLPc
 11dAn47caGg9h7GXKXFm13XLdgMWkk+NmCbTap2PNwsNlmWrJ0K8eFCtpOUpz9VikU
 +sTNiKLv7uKFBYOYcIeuW3pvGYyzc17WuUMoMOByOPDWWe1FXelcBXcWO1UXxVUYmR
 dnA4/uWiO9Fsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEA0CD8C88;
 Sat,  6 Jun 2026 00:52:40 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Sat, 06 Jun 2026 10:52:39 +1000
Subject: [PATCH 05/13] mach-snapdragon: enable BINMAN
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-android-binman-v1-5-c7a3c14b8a3d@samcday.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780707158; l=2049;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=E+/Np8Vg590y2jx5jnU8GbElSTFhQi505VgTF7MzPN0=;
 b=JxaGmXW06BaivUYwJUnvDkP75/76wFyVhph/4eLySNRQq1Toa28CCK/WsM2rgHdlqRoLNXHrH
 6i5Z/tjOo/NDADutszoI9p9LDEoCM6Z9Zq2aFBkXs4Je+hK352xC8xp
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

Now that binman provides abootimg support and we've defined
configuration for it on a number of qcom devices, let's enable BINMAN
for *all* ARCH_SNAPDRAGON builds.

This is a pragmatic choice: BINMAN needs to be pulled in by an existing
Kconfig symbol so we can't just enable it in a .config fragment. Rather
than defining a new symbol that can be opted into, we just opt in
everywhere. There's plenty of prior art for ARCH_* symbols doing exactly
this.

Not necessarily all (though, I suspect, a vast majority) of qcom devices
need or can benefit from binman. Unfortunately, binman will choke if a
DEVICE_TREE= lacking the `binman{}` DT node is selected as the control
FDT. To accommodate this, we drop in a small globally-included .dtsi
fragment that defines an empty binman{} node, so that no builds are
broken.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/Kconfig       | 1 +
 arch/arm/dts/qcom.dtsi | 5 +++++
 configs/qcom_defconfig | 1 +
 3 files changed, 7 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 514bf2000b4..5816194721c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1135,6 +1135,7 @@ config ARCH_RENESAS
 config ARCH_SNAPDRAGON
 	bool "Qualcomm Snapdragon SoCs"
 	select ARM64
+	select BINMAN
 	select DM
 	select DM_GPIO
 	select DM_SERIAL
diff --git a/arch/arm/dts/qcom.dtsi b/arch/arm/dts/qcom.dtsi
new file mode 100644
index 00000000000..9982e996993
--- /dev/null
+++ b/arch/arm/dts/qcom.dtsi
@@ -0,0 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+/ {
+	binman {
+	};
+};
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index d0d54ec5a70..fe026189ee3 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -50,6 +50,7 @@ CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
+CONFIG_DEVICE_TREE_INCLUDES="qcom.dtsi"
 CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
 CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="board/qualcomm/default.env"
 CONFIG_BUTTON_QCOM_PMIC=y

-- 
2.54.0


