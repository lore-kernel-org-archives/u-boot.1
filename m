Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230EDD277C0
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 23:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AF8B843E8;
	Sat, 10 Jan 2026 00:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NT+6SdGa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9114843F3; Sat, 10 Jan 2026 00:10:51 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD2B8843E6
 for <u-boot@lists.denx.de>; Sat, 10 Jan 2026 00:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+j.ne.posteo.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4017A44004;
 Fri,  9 Jan 2026 23:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FE9CC4CEF1;
 Fri,  9 Jan 2026 23:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768000247;
 bh=gs0FZU9NBedEqFiEWiMOAKZpG375yxXomI2zNaQpEhU=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=NT+6SdGaJgoLnotVKqyzUmnEnwSnhSnjBwebAtepn1GjuCsiOa479Fp7OOcY25irC
 cQbhiR3st85KP8EyuORTH8IT88sdut/Cu69UFYV7pDdWB5fxWqSxGJGNbGG4ZUt1nP
 1D4z4+lJIhgBXOoVj1vg0sybZMx4Wl7lGUkC5BAJFC7U0GCn9Y7wbkDj0lWNicm+H6
 giwHX44vCj5HkeTazSyHZiZx8Q2VZheroiqr1ni1rzsIiMcaiPyKyK359R9zCL82Vn
 QFfyGoydL7cVdjuUiO49ORJqwqSFgxCHqSIFe5621pzthPxo5DUXByre7h9erCTGcF
 OyJ2Zmi3/ZaQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0E451D277C0;
 Fri,  9 Jan 2026 23:10:47 +0000 (UTC)
From: =?utf-8?q?J=2E_Neusch=C3=A4fer_via_B4_Relay?=
 <devnull+j.ne.posteo.net@kernel.org>
Date: Sat, 10 Jan 2026 00:10:32 +0100
Subject: [PATCH next v2] board: amediatech: Add X96Q support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260110-x96q-v2-1-1d6a725eb825@posteo.net>
X-B4-Tracking: v=1; b=H4sIAOeKYWkC/1XMSw7CIBAG4Ks0sxbDQKTFVe9hXEg7WDZQgRBMw
 90l3bn8H/kOSBQdJbgPB0QqLrngexCXAZbt5d/E3NozCC5uKCSyqtWHaT0tKEdFxljo1z2SdfV
 kHuCpZnj2dnMph/g97YLn9s8UZMgkqnXk0kyWy3kPKVO4eupCa+0HQq0tv58AAAA=
X-Change-ID: 20251231-x96q-998c1376ebbf
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Peter Geis <pgwipeout@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?J=2E_Neusch=C3=A4fer?= <j.ne@posteo.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768000246; l=4812;
 i=j.ne@posteo.net; s=20240329; h=from:subject:message-id;
 bh=lwxA+pVpi1zVG1Z9trQLk9vTs+/3l5841fsJtjOQVsQ=;
 b=qqzQucuPNH5WCSrk01ybLOzckSH/h1/5QVsfPLdyD8JO4A68XSdwpGZ2P+TUEnGV0cNE8Sq7O
 oI5YkEijzo3ARbxvkUUoaJvOp6KJad1FLTuuZZCllxppfRXVUEfe1kV
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
Changes in v2:
- Add missing Signed-off-by
- Re-generate x96q_defconfig with 'make savedefconfig'
- Move DRAM frequency comment to commit message
- Use GPL-2.0-or-later instead of deprecated GPL-2.0+
- Link to v1: https://lore.kernel.org/r/20251231-x96q-v1-1-316d703b8f03@posteo.net
---
 configs/x96q_defconfig         | 31 +++++++++++++++++++++++
 doc/board/amediatech/index.rst |  9 +++++++
 doc/board/amediatech/x96q.rst  | 57 ++++++++++++++++++++++++++++++++++++++++++
 doc/board/index.rst            |  1 +
 4 files changed, 98 insertions(+)

diff --git a/configs/x96q_defconfig b/configs/x96q_defconfig
new file mode 100644
index 00000000000..b74a1b61f3c
--- /dev/null
+++ b/configs/x96q_defconfig
@@ -0,0 +1,31 @@
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
+CONFIG_FIT_BEST_MATCH=y
+CONFIG_SPL_I2C=y
+CONFIG_CMD_UFETCH=y
+CONFIG_CMD_CAT=y
+CONFIG_SPL_SYS_I2C_LEGACY=y
+CONFIG_SYS_I2C_MVTWSI=y
+CONFIG_SYS_I2C_SLAVE=0x7f
+CONFIG_SYS_I2C_SPEED=400000
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_SUN8I_EMAC=y
+CONFIG_AXP305_POWER=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_SPL_USE_TINY_PRINTF_POINTER_SUPPORT=y
diff --git a/doc/board/amediatech/index.rst b/doc/board/amediatech/index.rst
new file mode 100644
index 00000000000..fd0241e3459
--- /dev/null
+++ b/doc/board/amediatech/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Amediatech
+==========
+
+.. toctree::
+   :maxdepth: 2
+
+   x96q
diff --git a/doc/board/amediatech/x96q.rst b/doc/board/amediatech/x96q.rst
new file mode 100644
index 00000000000..f220b7005b2
--- /dev/null
+++ b/doc/board/amediatech/x96q.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+U-Boot for the Amediatech X96Q set-top box
+==========================================
+
+Quick Start
+-----------
+
+- Get and Build the ARM Trusted Firmware (TF-A)
+- Build U-Boot
+- Write U-Boot to a microSD card
+- Boot
+
+Get and Build the ARM Trusted Firmware (TF-A)
+---------------------------------------------
+
+.. code-block:: bash
+
+    $ echo "Downloading and building TF-A..."
+    $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
+    $ cd trusted-firmware-a
+
+Then build TF-A:
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-linux-gnu-
+    $ make PLAT=sun50i_h616 bl31
+    $ cp build/sun50i_h616/release/bl31.bin ../
+
+Build U-Boot
+------------
+
+.. code-block:: bash
+
+    $ export CROSS_COMPILE=aarch64-none-elf-
+    $ make x96q_defconfig
+    $ make
+
+After the build succeeds, you will obtain the final ``u-boot-sunxi-with-spl.bin``
+image, which you can then write to a microSD card.
+
+Write U-Boot to a microSD card
+------------------------------
+
+You can then flash U-Boot to the microSD card (replace ``/dev/sdX`` with the
+card's device file):
+
+.. code-block:: bash
+
+    $ dd if=u-boot-sunxi-with-spl.bin of=/dev/sdX bs=8k seek=1
+
+Boot
+----
+
+When the X96Q is booted with the prepared microSD card inserted, it should boot
+into the freshly installed U-Boot.
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 7870f1bc246..767e1831912 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -9,6 +9,7 @@ Board-specific doc
    acer/index
    actions/index
    advantech/index
+   amediatech/index
    andestech/index
    allwinner/index
    amlogic/index

---
base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
change-id: 20251231-x96q-998c1376ebbf

Best regards,
-- 
J. Neuschäfer <j.ne@posteo.net>


