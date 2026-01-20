Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983F8D2ED17
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 15:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4BDB83A6A;
	Tue, 20 Jan 2026 16:20:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q5pEcj20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2633783A8D; Tue, 20 Jan 2026 16:20:45 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8083283A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:20:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A7FBA44227;
 Tue, 20 Jan 2026 15:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85481C19422;
 Tue, 20 Jan 2026 15:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768922440;
 bh=yaBHmQAY+03SVzh3vAYb6ADcwVfuLT5cg3ZARHQWEy4=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=Q5pEcj20/CfrE4zuknR+kn5aUuelD+dXqtEgvvnJiR+tnKpTShBGrlShaMRKUi00O
 y/cO21uOug2D7cVsUltNBU4DS8f5pxzgUv2p+ZHACnZalvelJKUk5tks/N8iPodBC+
 7aKwL+dY4jr4xgDw6tsGuuG9/8ho+Gq+5tQyebzAimwyXHtEB9f0wEhpe9o/XU90D6
 n4oi5ZNiyTKz/8ZBRQKwzkOpW+qCm/0NxlPqy8Hih2zcPRzZP+X/vnKYsGFxFLrUNE
 0N/Q6E9Rr20mcr3rHXHAfVwRCtcayS3kecnEvzatt5ra43wVtV0ST82gc4Kx2JYqN0
 1HNWpIo9HOvwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 72440D2ED15;
 Tue, 20 Jan 2026 15:20:40 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Tue, 20 Jan 2026 16:20:38 +0100
Subject: [PATCH next v3] board: sunxi: Add X96Q support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260120-x96q-v3-1-1419ee399fa1@posteo.net>
X-B4-Tracking: v=1; b=H4sIAEWdb2kC/1WMTQ6DIBBGr2JmXRpmiKhdeY+mC9GxsgELhtgY7
 15i24XL7+e9DSIHyxFuxQaBk43WuxzUpYB+6tyThR1yBpJUIikUa6NfomnqHlWl2ZgR8nUOPNr
 10NzB8brAI7eTjYsP78Od8NjOmoQChUI9VFKZepSqnX1c2F8dfw2J/pSWiPJHUaZw0F1FJZuay
 hO17/sHEnpwiNUAAAA=
X-Change-ID: 20251231-x96q-998c1376ebbf
To: u-boot@lists.denx.de
Cc: linux-sunxi <linux-sunxi@lists.linux.dev>, 
 Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Peter Geis <pgwipeout@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Lukas Schmid <lukas.schmid@netcube.li>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768922439; l=3015;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=lQ0P3AFYQWqSxsOBdi4MNMycxGc0DyWm9yvx4fujLD0=;
 b=aKdiVIWuFj1j1ap4MA8QBhJ/kLAteO04yG7KEIHlfAKZX0gOxDUL97xy1bgvIKiHwy0ITl9h+
 nCLLE5EtUqHAzkQSUExzyykZsZr00hFJHDcn3Iw/GKXO1qmU8ZOTGzN
X-Developer-Key: i=j.ne@posteo.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Endpoint-Received: by B4 Relay for j.ne@posteo.net/20240329 with auth_id=156
X-Original-From: =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
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
Reply-To: j.ne@posteo.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: "J. Neuschäfer" <j.ne@posteo.net>

The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
output, and infrared input.

  https://x96mini.com/products/x96q-tv-box-android-10-set-top-box

This commit adds a defconfig and some documentation. The devicetree is
already in dts/upstream.

The CONFIG_DRAM_SUNXI_* settings are chosen such that the register
values in the DRAM PHY's MMIO space are as close as possible to those
observed when booting with the preinstalled vendor U-Boot. The DRAM
clock frequency of 600 MHz was reported in the vendor U-Boot's output.

Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
---
Changes in v3:
- Remove CONFIG_FIT_BEST_MATCH, CONFIG_CMD_UFETCH/CAT, CONFIG_SYS_I2C_SLAVE
  and CONFIG_SPL_USE_TINY_PRINTF_POINTER_SUPPORT from defconfig
- Add board/sunxi/MAINTAINERS entry
- Remove board-specific documentation
- Link to v2: https://lore.kernel.org/r/20260110-x96q-v2-1-1d6a725eb825@posteo.net

Changes in v2:
- Add missing Signed-off-by
- Re-generate x96q_defconfig with 'make savedefconfig'
- Move DRAM frequency comment to commit message
- Use GPL-2.0-or-later instead of deprecated GPL-2.0+
- Link to v1: https://lore.kernel.org/r/20251231-x96q-v1-1-316d703b8f03@posteo.net
---
 board/sunxi/MAINTAINERS |  5 +++++
 configs/x96q_defconfig  | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index c52e8a34c85..775d0f7ae83 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -611,6 +611,11 @@ M:	Andre Przywara <andre.przywara@arm.com>
 S:	Maintained
 F:	configs/x96_mate_defconfig
 
+X96Q TV BOX
+M:	J. Neuschäfer <j.ne@posteo.net>
+S:	Maintained
+F:	configs/x96q_defconfig
+
 X96Q PRO+ TV BOX
 M:	Andre Przywara <andre.przywara@arm.com>
 S:	Maintained
diff --git a/configs/x96q_defconfig b/configs/x96q_defconfig
new file mode 100644
index 00000000000..24c214b4c63
--- /dev/null
+++ b/configs/x96q_defconfig
@@ -0,0 +1,26 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="allwinner/sun50i-h313-x96q"
+CONFIG_DRAM_CLK=600
+CONFIG_SPL=y
+CONFIG_DRAM_SUNXI_DX_ODT=0x03030303
+CONFIG_DRAM_SUNXI_DX_DRI=0x0e0e0e0e
+CONFIG_DRAM_SUNXI_CA_DRI=0x1f12
+CONFIG_DRAM_SUNXI_TPR0=0xc0001002
+CONFIG_DRAM_SUNXI_TPR2=0x00000100
+CONFIG_DRAM_SUNXI_TPR10=0x002f0107
+CONFIG_DRAM_SUNXI_TPR11=0xddddcccc
+CONFIG_DRAM_SUNXI_TPR12=0xeddc7665
+CONFIG_MACH_SUN50I_H616=y
+CONFIG_SUNXI_DRAM_H616_DDR3_1333=y
+CONFIG_R_I2C_ENABLE=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_I2C=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_SUN8I_EMAC=y
+CONFIG_AXP305_POWER=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y

---
base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
change-id: 20251231-x96q-998c1376ebbf

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


