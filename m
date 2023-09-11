Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BFBEE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 10:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EDC986D75;
	Mon, 11 Sep 2023 12:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EA3686DA6; Mon, 11 Sep 2023 12:01:55 +0200 (CEST)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E675986D6B
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 12:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 38BA1cf5002973; Mon, 11 Sep 2023 19:01:40 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: andy.yan@rock-chips.com, gajjar04akash@gmail.com, sjg@chromium.org,
 jonas@kwiboo.se, kever.yang@rock-chips.com, FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 2/2] configs: rockchip: rk3308: enable CONFIG_OF_LIBFDT_OVERLAY
Date: Mon, 11 Sep 2023 19:01:21 +0900
Message-Id: <20230911100121.122228-2-naoki@radxa.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911100121.122228-1-naoki@radxa.com>
References: <20230911100121.122228-1-naoki@radxa.com>
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

enable CONFIG_OF_LIBFDT_OVERLAY and use it on Radxa ROCK Pi S.

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 configs/rock-pi-s-rk3308_defconfig | 1 +
 include/configs/rk3308_common.h    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index e2abe4b4f7..ca4a1800e7 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -9,6 +9,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_DEFAULT_DEVICE_TREE="rk3308-rock-pi-s"
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
 CONFIG_ROCKCHIP_SPL_RESERVE_IRAM=0x0
diff --git a/include/configs/rk3308_common.h b/include/configs/rk3308_common.h
index a413af1bd4..861154fbeb 100644
--- a/include/configs/rk3308_common.h
+++ b/include/configs/rk3308_common.h
@@ -17,6 +17,7 @@
 	"scriptaddr=0x00500000\0" \
 	"pxefile_addr_r=0x00600000\0" \
 	"fdt_addr_r=0x03e00000\0" \
+	"fdtoverlay_addr_r=0x03f00000\0" \
 	"kernel_addr_r=0x00680000\0" \
 	"ramdisk_addr_r=0x04000000\0"
 
-- 
2.39.2

