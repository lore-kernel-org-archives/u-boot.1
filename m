Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 112A8C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 12:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D12F82D32;
	Wed, 30 Jul 2025 14:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79EC980C93; Wed, 30 Jul 2025 14:47:08 +0200 (CEST)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8fa8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12B4381E13
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 14:47:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bsX6K5XThz9vY;
 Wed, 30 Jul 2025 14:47:05 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bsX6K22qDzjcF; Wed, 30 Jul 2025 14:47:05 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 30 Jul 2025 14:46:33 +0200
Subject: [PATCH 1/3] board: theobroma-systems: update instructions for
 newer Rockchip rkbin
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-tsd-readme-update-v1-1-5a96672d2211@cherry.de>
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

The instructions are regularly out of date because the generated or
prebuilt binaries are updated and the filename doesn't match our
instructions anymore.

Additionally, since commit 55a95caaef15 ("tools: ddrbin_tool: add
ddrbin_tool.py and update to v1.21 20241211") end of October 2024,
ddrbin_tool doesn't exist anymore and has been replaced by
ddrbin_tool.py python script (which currently isn't an executable) so
let's update these instructions as well.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/theobroma-systems/jaguar_rk3588.rst | 9 ++++-----
 doc/board/theobroma-systems/puma_rk3399.rst   | 6 ++++--
 doc/board/theobroma-systems/ringneck_px30.rst | 3 ++-
 doc/board/theobroma-systems/tiger_rk3588.rst  | 9 ++++-----
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/doc/board/theobroma-systems/jaguar_rk3588.rst b/doc/board/theobroma-systems/jaguar_rk3588.rst
index cba4fd066ab8c3575a3e39c7a95c6d84f04909c8..33cd7276852c5b74b750ad14ce2beb4a9440ef3f 100644
--- a/doc/board/theobroma-systems/jaguar_rk3588.rst
+++ b/doc/board/theobroma-systems/jaguar_rk3588.rst
@@ -39,13 +39,12 @@ Get the TF-A and DDR init (TPL) binaries
 
    git clone https://github.com/rockchip-linux/rkbin
    cd rkbin
-   export RKBIN=$(pwd)
-   export BL31=$RKBIN/bin/rk35/rk3588_bl31_v1.47.elf
-   export ROCKCHIP_TPL=$RKBIN/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.18.bin
+   export BL31=$(readlink -f bin/rk35/rk3588_bl31_v*.elf | head -1)
+   export ROCKCHIP_TPL=$(readlink -f bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v*.bin | head -1)
    sed -i 's/^uart baudrate=.*$/uart baudrate=115200/' tools/ddrbin_param.txt
-   ./tools/ddrbin_tool rk3588 tools/ddrbin_param.txt "$ROCKCHIP_TPL"
+   python3 ./tools/ddrbin_tool.py rk3588 tools/ddrbin_param.txt "$ROCKCHIP_TPL"
    ./tools/boot_merger RKBOOT/RK3588MINIALL.ini
-   export RKDB=$RKBIN/rk3588_spl_loader_v1.11.112.bin
+   export RKDB=$(readlink -f rk3588_spl_loader_v*.bin | head -1)
 
 This will setup all required external dependencies for compiling U-Boot. This will
 be updated in the future once upstream Trusted-Firmware-A supports RK3588 or U-Boot
diff --git a/doc/board/theobroma-systems/puma_rk3399.rst b/doc/board/theobroma-systems/puma_rk3399.rst
index a2a5e7bca4b90c7d85084c7e5dd8abb0d5108d4c..1a8d33f188d336d90dfa3966d1fc45eeab87aae9 100644
--- a/doc/board/theobroma-systems/puma_rk3399.rst
+++ b/doc/board/theobroma-systems/puma_rk3399.rst
@@ -95,8 +95,9 @@ To flash U-Boot on the eMMC with ``rkdeveloptool``:
    git clone https://github.com/rockchip-linux/rkbin.git
    cd rkbin
    ./tools/boot_merger RKBOOT/RK3399MINIALL.ini
+   export RKDB=$(readlink -f rk3399_loader_v*.bin | head -1)
    cd ..
-   ./rkdeveloptool db rkbin/rk3399_loader_v1.30.130.bin
+   ./rkdeveloptool db "$RKDB"
    ./rkdeveloptool wl 64 ../u-boot-rockchip.bin
 
 NOR-Flash
@@ -121,7 +122,8 @@ To flash U-Boot on the SPI with ``rkdeveloptool``:
    git clone https://github.com/rockchip-linux/rkbin.git
    cd rkbin
    ./tools/boot_merger RKBOOT/RK3399MINIALL_SPINOR.ini
+   export RKDB=$(readlink -f rk3399_loader_spinor_v*.bin | head -1)
    cd ..
-   ./rkdeveloptool db rkbin/rk3399_loader_spinor_v1.30.114.bin
+   ./rkdeveloptool db "$RKDB"
    ./rkdeveloptool ef
    ./rkdeveloptool wl 0 ../u-boot-rockchip-spi.bin
diff --git a/doc/board/theobroma-systems/ringneck_px30.rst b/doc/board/theobroma-systems/ringneck_px30.rst
index c16b9ed17edf6e6264d80f38e591b0bc5a0bd4b7..d3feedf6062bb9cd3c8622491d45bc93ff6fbb76 100644
--- a/doc/board/theobroma-systems/ringneck_px30.rst
+++ b/doc/board/theobroma-systems/ringneck_px30.rst
@@ -90,6 +90,7 @@ To flash U-Boot on the eMMC with ``rkdeveloptool``:
    git clone https://github.com/rockchip-linux/rkbin.git
    cd rkbin
    ./tools/boot_merger RKBOOT/PX30MINIALL.ini
+   export RKDB=$(readlink -f px30_loader_v*.bin | head -1)
    cd ..
-   ./rkdeveloptool db rkbin/px30_loader_v2.08.135.bin
+   ./rkdeveloptool db "$RKDB"
    ./rkdeveloptool wl 64 ../u-boot-rockchip.bin
diff --git a/doc/board/theobroma-systems/tiger_rk3588.rst b/doc/board/theobroma-systems/tiger_rk3588.rst
index 4586b8d8b5a801c7646c5a85ea608e86eb33eb2f..71dbe4c59de8f8b3ccb6ece440a780459db127b1 100644
--- a/doc/board/theobroma-systems/tiger_rk3588.rst
+++ b/doc/board/theobroma-systems/tiger_rk3588.rst
@@ -46,14 +46,13 @@ Get the TF-A and DDR init (TPL) binaries
 
    git clone https://github.com/rockchip-linux/rkbin
    cd rkbin
-   export RKBIN=$(pwd)
-   export BL31=$RKBIN/bin/rk35/rk3588_bl31_v1.47.elf
-   export ROCKCHIP_TPL=$RKBIN/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.18.bin
+   export BL31=$(readlink -f bin/rk35/rk3588_bl31_v*.elf | head -1)
+   export ROCKCHIP_TPL=$(readlink -f bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v*.bin | head -1)
    sed -i 's/^uart baudrate=.*$/uart baudrate=115200/' tools/ddrbin_param.txt
    sed -i 's/^uart iomux=.*$/uart iomux=2/' tools/ddrbin_param.txt
-   ./tools/ddrbin_tool rk3588 tools/ddrbin_param.txt "$ROCKCHIP_TPL"
+   python3 ./tools/ddrbin_tool.py rk3588 tools/ddrbin_param.txt "$ROCKCHIP_TPL"
    ./tools/boot_merger RKBOOT/RK3588MINIALL.ini
-   export RKDB=$RKBIN/rk3588_spl_loader_v1.11.112.bin
+   export RKDB=$(readlink -f rk3588_spl_loader_v*.bin | head -1)
 
 This will setup all required external dependencies for compiling U-Boot. This will
 be updated in the future once upstream Trusted-Firmware-A supports RK3588 or U-Boot

-- 
2.50.1

