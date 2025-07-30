Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1C5C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 12:47:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A16758313B;
	Wed, 30 Jul 2025 14:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26E2C82F14; Wed, 30 Jul 2025 14:47:11 +0200 (CEST)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [45.157.188.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6093782D32
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 14:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bsX6L1VM7zdjd;
 Wed, 30 Jul 2025 14:47:06 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bsX6K5RqbzlSD; Wed, 30 Jul 2025 14:47:05 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 30 Jul 2025 14:46:34 +0200
Subject: [PATCH 2/3] board: theobroma-systems: add instructions for how to
 use upstream TF-A
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-tsd-readme-update-v1-2-5a96672d2211@cherry.de>
References: <20250730-tsd-readme-update-v1-0-5a96672d2211@cherry.de>
In-Reply-To: <20250730-tsd-readme-update-v1-0-5a96672d2211@cherry.de>
To: Klaus Goger <klaus.goger@cherry.de>, 
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Upstream TF-A has support for RK3588 since v2.12 so let's document how
to use upstream TF-A instead of the prebuilt binary blob from Rockchip
if one wants to do that.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/theobroma-systems/jaguar_rk3588.rst | 38 +++++++++++++++++++++++----
 doc/board/theobroma-systems/tiger_rk3588.rst  | 38 +++++++++++++++++++++++----
 2 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/doc/board/theobroma-systems/jaguar_rk3588.rst b/doc/board/theobroma-systems/jaguar_rk3588.rst
index 33cd7276852c5b74b750ad14ce2beb4a9440ef3f..eff0ee7347c7d0e810d9dba542ce3aaf28ef359d 100644
--- a/doc/board/theobroma-systems/jaguar_rk3588.rst
+++ b/doc/board/theobroma-systems/jaguar_rk3588.rst
@@ -32,14 +32,13 @@ It provides the following features:
 Here is the step-by-step to boot to U-Boot on SBC-RK3588-AMR Jaguar from Theobroma
 Systems.
 
-Get the TF-A and DDR init (TPL) binaries
-----------------------------------------
+Get DDR init (TPL) binary
+-------------------------
 
 .. prompt:: bash
 
    git clone https://github.com/rockchip-linux/rkbin
    cd rkbin
-   export BL31=$(readlink -f bin/rk35/rk3588_bl31_v*.elf | head -1)
    export ROCKCHIP_TPL=$(readlink -f bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v*.bin | head -1)
    sed -i 's/^uart baudrate=.*$/uart baudrate=115200/' tools/ddrbin_param.txt
    python3 ./tools/ddrbin_tool.py rk3588 tools/ddrbin_param.txt "$ROCKCHIP_TPL"
@@ -47,8 +46,32 @@ Get the TF-A and DDR init (TPL) binaries
    export RKDB=$(readlink -f rk3588_spl_loader_v*.bin | head -1)
 
 This will setup all required external dependencies for compiling U-Boot. This will
-be updated in the future once upstream Trusted-Firmware-A supports RK3588 or U-Boot
-gains support for open-source DRAM initialization in TPL.
+be updated in the future once U-Boot gains support for open-source DRAM initialization
+in TPL.
+
+Get TF-A
+--------
+
+There are two possible options, pick one or the other. Note that the instructions need
+to be run from the ``rkbin`` directory.
+
+Prebuilt binary from Rockchip
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. prompt:: bash
+
+   export BL31=$(readlink -f bin/rk35/rk3588_bl31_v*.elf | head -1)
+
+Upstream
+~~~~~~~~
+
+.. prompt:: bash
+
+   cd ../
+   git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
+   cd trusted-firmware-a
+   make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3588 bl31
+   export BL31=$PWD/build/rk3588/release/bl31/bl31.elf
 
 Build U-Boot
 ------------
@@ -58,6 +81,11 @@ Build U-Boot
    cd ../u-boot
    make CROSS_COMPILE=aarch64-linux-gnu- jaguar-rk3588_defconfig all
 
+.. note::
+   If using upstream TF-A, one should disable ``SPL_ATF_NO_PLATFORM_PARAM`` symbol in
+   U-Boot config (via e.g. ``make CROSS_COMPILE=aarch64-linux-gnu- menuconfig``) which
+   will, among other things, enable console output in TF-A.
+
 This will build ``u-boot-rockchip.bin`` which can be written to an MMC device
 (eMMC or SD card).
 
diff --git a/doc/board/theobroma-systems/tiger_rk3588.rst b/doc/board/theobroma-systems/tiger_rk3588.rst
index 71dbe4c59de8f8b3ccb6ece440a780459db127b1..493f191020fd4326bd19aa3a3c927ea9258a4720 100644
--- a/doc/board/theobroma-systems/tiger_rk3588.rst
+++ b/doc/board/theobroma-systems/tiger_rk3588.rst
@@ -39,14 +39,13 @@ It provides the following feature set:
 Here is the step-by-step to boot to U-Boot on SOM-RK3588-Q7 Tiger from Theobroma
 Systems.
 
-Get the TF-A and DDR init (TPL) binaries
-----------------------------------------
+Get DDR init (TPL) binary
+-------------------------
 
 .. prompt:: bash
 
    git clone https://github.com/rockchip-linux/rkbin
    cd rkbin
-   export BL31=$(readlink -f bin/rk35/rk3588_bl31_v*.elf | head -1)
    export ROCKCHIP_TPL=$(readlink -f bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v*.bin | head -1)
    sed -i 's/^uart baudrate=.*$/uart baudrate=115200/' tools/ddrbin_param.txt
    sed -i 's/^uart iomux=.*$/uart iomux=2/' tools/ddrbin_param.txt
@@ -55,8 +54,32 @@ Get the TF-A and DDR init (TPL) binaries
    export RKDB=$(readlink -f rk3588_spl_loader_v*.bin | head -1)
 
 This will setup all required external dependencies for compiling U-Boot. This will
-be updated in the future once upstream Trusted-Firmware-A supports RK3588 or U-Boot
-gains support for open-source DRAM initialization in TPL.
+be updated in the future once U-Boot gains support for open-source DRAM initialization
+in TPL.
+
+Get TF-A
+--------
+
+There are two possible options, pick one or the other. Note that the instructions need
+to be run from the ``rkbin`` directory.
+
+Prebuilt binary from Rockchip
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. prompt:: bash
+
+   export BL31=$(readlink -f bin/rk35/rk3588_bl31_v*.elf | head -1)
+
+Upstream
+~~~~~~~~
+
+.. prompt:: bash
+
+   cd ../
+   git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
+   cd trusted-firmware-a
+   make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3588 bl31
+   export BL31=$PWD/build/rk3588/release/bl31/bl31.elf
 
 Build U-Boot
 ------------
@@ -66,6 +89,11 @@ Build U-Boot
    cd ../u-boot
    make CROSS_COMPILE=aarch64-linux-gnu- tiger-rk3588_defconfig all
 
+.. note::
+   If using upstream TF-A, one should disable ``SPL_ATF_NO_PLATFORM_PARAM`` symbol in
+   U-Boot config (via e.g. ``make CROSS_COMPILE=aarch64-linux-gnu- menuconfig``) which
+   will, among other things, enable console output in TF-A.
+
 This will build ``u-boot-rockchip.bin`` which can be written to an MMC device
 (eMMC or SD card).
 

-- 
2.50.1

