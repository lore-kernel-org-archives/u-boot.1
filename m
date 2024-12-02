Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA6CE69EA0
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 23:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DE9A89589;
	Tue,  3 Dec 2024 00:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C5C89562; Tue,  3 Dec 2024 00:40:40 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F9689589
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 00:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 4B2NeOH4004140; Tue, 3 Dec 2024 08:40:24 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, chris.obbard@collabora.com,
 pbrobinson@gmail.com, jonas@kwiboo.se, sjg@chromium.org,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH] rockchip: rk3399: expand space for decompressed kernel
Date: Mon,  2 Dec 2024 23:40:18 +0000
Message-ID: <20241202234018.92120-1-naoki@radxa.com>
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

fix following error by using same ENV_MEM_LAYOUT_SETTINGS with rk35xx:

U-Boot 2025.01-rc3-00001-g1527c7dcdb01 (Dec 02 2024 - 22:57:18 +0000)
  :
Retrieving file: /boot/extlinux/../nixos/dhqjsnprmzjxncil3m0g9l09a479crn3-linux-6.12.1-Image
Retrieving file: /boot/extlinux/../nixos/6fq8fmmab31yxdwcs7zw44p78fq9fy1s-initrd-linux-6.12.1-initrd
append: init=/nix/store/yjbxgzf1vkwbw6ab738bf4kxazhyypa1-nixos-system-rock-5b-25.05.20241201.ac35b10/init console=ttyS2,1500000n8 console=ttyAMA0,115200n8 console=tty0 loglevel=7
Retrieving file: /boot/extlinux/../nixos/dhqjsnprmzjxncil3m0g9l09a479crn3-linux-6.12.1-dtbs/rockchip/rk3399-rock-4se.dtb
Moving Image from 0x2080000 to 0x2200000, end=0x60d0000
ERROR: RD image overlaps OS image (OS=2200000..60d0000)
Boot failed (err=-14)

$ ls -lh boot/nixos/
total 84M
-r--r--r--  1 root root  24M Jan  1  1970 6fq8fmmab31yxdwcs7zw44p78fq9fy1s-initrd-linux-6.12.1-initrd
-r--r--r--  1 root root  62M Jan  1  1970 dhqjsnprmzjxncil3m0g9l09a479crn3-linux-6.12.1-Image
dr-xr-xr-x 36 root root 4.0K Jan  1  1970 dhqjsnprmzjxncil3m0g9l09a479crn3-linux-6.12.1-dtbs

similar problem was fixed for rk35xx by:

commit 69b73877f02c ("rockchip: rk35xx: expand space for decompressed kernel")

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 include/configs/rk3399_common.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/configs/rk3399_common.h b/include/configs/rk3399_common.h
index c5bcd7dc5e8a..76f40e7cd5f8 100644
--- a/include/configs/rk3399_common.h
+++ b/include/configs/rk3399_common.h
@@ -20,16 +20,16 @@
 #endif
 
 #define ENV_MEM_LAYOUT_SETTINGS		\
-	"scriptaddr=0x00500000\0"	\
+	"scriptaddr=0x00c00000\0"	\
 	"script_offset_f=0xffe000\0"	\
 	"script_size_f=0x2000\0"	\
-	"pxefile_addr_r=0x00600000\0"	\
-	"fdt_addr_r=0x01e00000\0"	\
-	"fdtoverlay_addr_r=0x01f00000\0"	\
-	"kernel_addr_r=0x02080000\0"	\
-	"ramdisk_addr_r=0x06000000\0"	\
-	"kernel_comp_addr_r=0x08000000\0"	\
-	"kernel_comp_size=0x2000000\0"
+	"pxefile_addr_r=0x00e00000\0"	\
+	"kernel_addr_r=0x02000000\0"	\
+	"kernel_comp_addr_r=0x0a000000\0"	\
+	"fdt_addr_r=0x12000000\0"	\
+	"fdtoverlay_addr_r=0x12100000\0"	\
+	"ramdisk_addr_r=0x12180000\0"	\
+	"kernel_comp_size=0x8000000\0"
 
 #define CFG_EXTRA_ENV_SETTINGS		\
 	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0"	\
-- 
2.43.0

