Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C293CCF9E3
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 06:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB4FA83C64;
	Fri,  7 Nov 2025 07:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B7A83C72; Fri,  7 Nov 2025 07:47:39 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7559883C63
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 07:47:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 5A76lKcM006684; Fri, 7 Nov 2025 15:47:20 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, eugen.hristev@linaro.org, jonas@kwiboo.se,
 heiko@sntech.de, cnsztl@gmail.com, xuhui.lin@rock-chips.com,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH] rockchip: rock5b-rk3588: Add support for Radxa ROCK 5T
Date: Fri,  7 Nov 2025 06:47:16 +0000
Message-ID: <20251107064716.27196-1-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
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

Include the FDT for Radxa ROCK 5T in the FIT, in addition to those for
5B and 5B+, and add board selection code to load the 5T FDT when the
DRAM type is LPDDR5 and ADC channel 5 value is close to 1016.

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
This patch depends on the following Jonas's patch series:
 https://patchwork.ozlabs.org/project/uboot/list/?series=467612
---
 arch/arm/dts/rk3588-rock-5t-u-boot.dtsi   | 3 +++
 board/radxa/rock5b-rk3588/rock5b-rk3588.c | 1 +
 configs/rock5b-rk3588_defconfig           | 2 +-
 doc/board/rockchip/rockchip.rst           | 2 +-
 4 files changed, 6 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/dts/rk3588-rock-5t-u-boot.dtsi

diff --git a/arch/arm/dts/rk3588-rock-5t-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5t-u-boot.dtsi
new file mode 100644
index 00000000000..c07696c8391
--- /dev/null
+++ b/arch/arm/dts/rk3588-rock-5t-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588-rock-5b-u-boot.dtsi"
diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
index 6bf4497ce3a..2c172d04499 100644
--- a/board/radxa/rock5b-rk3588/rock5b-rk3588.c
+++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
@@ -23,6 +23,7 @@ struct board_model {
 };
 
 static const struct board_model board_models[] = {
+	{ LPDDR5,  926, 1106, "rockchip/rk3588-rock-5t.dtb" },
 	{ LPDDR5, 4005, 4185, "rockchip/rk3588-rock-5b-plus.dtb" },
 };
 
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index 967cebc2054..567f649ea69 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-CONFIG_OF_LIST="rockchip/rk3588-rock-5b rockchip/rk3588-rock-5b-plus"
+CONFIG_OF_LIST="rockchip/rk3588-rock-5b rockchip/rk3588-rock-5b-plus rockchip/rk3588-rock-5t"
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 9af701feb5d..6ae4d4371ff 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -162,7 +162,7 @@ List of mainline supported Rockchip boards:
      - Pine64 QuartzPro64 (quartzpro64-rk3588)
      - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
      - Radxa ROCK 5A (rock5a-rk3588s)
-     - Radxa ROCK 5B/5B+ (rock5b-rk3588)
+     - Radxa ROCK 5B/5B+/5T (rock5b-rk3588)
      - Radxa ROCK 5C (rock-5c-rk3588s)
      - Rockchip Toybrick TB-RK3588X (toybrick-rk3588)
      - Theobroma Systems RK3588-SBC Jaguar (jaguar-rk3588)
-- 
2.43.0

