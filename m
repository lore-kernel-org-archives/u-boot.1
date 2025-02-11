Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CB1C021A0
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 05:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89BF380BA8;
	Tue, 11 Feb 2025 06:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BFFA8043C; Tue, 11 Feb 2025 06:34:39 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC8BD807C0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:34:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 51B5Xk4m024751; Tue, 11 Feb 2025 14:33:53 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 jagan@amarulasolutions.com, dsimic@manjaro.org, pbrobinson@gmail.com,
 liujianfeng1994@gmail.com, paulk@sys-base.io, ricardo@pardini.net,
 heiko@sntech.de, macromorgan@hotmail.com, michal.simek@amd.com,
 seb-dev@mail.de, christopher.obbard@linaro.org,
 ilias.apalodimas@linaro.org, marex@denx.de, mkorpershoek@baylibre.com,
 xypron.glpk@gmx.de, jerome.forissier@linaro.org,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 7/7] rockchip: Add DFU to SPL for RK3308
Date: Tue, 11 Feb 2025 05:33:40 +0000
Message-ID: <20250211053340.92919-8-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211053340.92919-1-naoki@radxa.com>
References: <20250211053340.92919-1-naoki@radxa.com>
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

Boot the RK3308 from the USB OTG port using rkflashtool[1] or
rkusbboot[2] and dfu-util.

1a. Download the TPL and SPL using rkflashtool

$ openssl rc4 -provider legacy -K 7c4e0304550509072d2c7b38170d1711 \
	< mkimage-in-simple-bin.mkimage-rockchip-tpl | rkflashtool l
$ openssl rc4 -provider legacy -K 7c4e0304550509072d2c7b38170d1711 \
	< mkimage-in-simple-bin.mkimage-u-boot-spl | rkflashtool L

1b. Download the TPL and SPL using rkusbboot

$ rkusbboot \
	mkimage-in-simple-bin.mkimage-rockchip-tpl \
	mkimage-in-simple-bin.mkimage-u-boot-spl

2. Download the U-Boot

$ dfu-util -a 0 -D u-boot.itb

[1] https://github.com/linux-rockchip/rkflashtool
[2] https://github.com/RadxaNaoki/rkusbboot

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 arch/arm/dts/rk3308-u-boot.dtsi        | 5 +++++
 arch/arm/mach-rockchip/rk3308/rk3308.c | 1 +
 include/configs/rk3308_common.h        | 7 +++++++
 3 files changed, 13 insertions(+)

diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
index b7964e2756f..cf7e41da65b 100644
--- a/arch/arm/dts/rk3308-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-u-boot.dtsi
@@ -122,6 +122,11 @@
 	bootph-some-ram;
 };
 
+&usb20_otg {
+	bootph-pre-ram;
+	bootph-some-ram;
+};
+
 &xin24m {
 	bootph-all;
 };
diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c b/arch/arm/mach-rockchip/rk3308/rk3308.c
index 03d97e1d746..8b2832ef0f2 100644
--- a/arch/arm/mach-rockchip/rk3308/rk3308.c
+++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
@@ -142,6 +142,7 @@ const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff490000",
 	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff4c0000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/mmc@ff480000",
+	[BROM_BOOTSOURCE_USB] = "/usb@ff400000",
 };
 
 int rk_board_init(void)
diff --git a/include/configs/rk3308_common.h b/include/configs/rk3308_common.h
index 2de55538fdf..11eeef3942a 100644
--- a/include/configs/rk3308_common.h
+++ b/include/configs/rk3308_common.h
@@ -25,11 +25,18 @@
 	"kernel_comp_addr_r=0x08000000\0"	\
 	"kernel_comp_size=0x2000000\0"
 
+#if defined(CONFIG_SPL_DFU) && defined(CONFIG_XPL_BUILD)
+#define CFG_EXTRA_ENV_SETTINGS				\
+	"dfu_alt_info_ram=u-boot.itb ram "		\
+	__stringify(CONFIG_SPL_LOAD_FIT_ADDRESS) " "	\
+	__stringify(CONFIG_SYS_DFU_MAX_FILE_SIZE) "\0"
+#else
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
 	"partitions=" PARTS_DEFAULT	\
 	ENV_MEM_LAYOUT_SETTINGS		\
 	ROCKCHIP_DEVICE_SETTINGS	\
 	"boot_targets=" BOOT_TARGETS "\0"
+#endif
 
 #endif /* __CONFIG_RK3308_COMMON_H */
-- 
2.43.0

