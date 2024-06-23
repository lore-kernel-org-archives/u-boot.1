Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B79C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 18:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3961A881BA;
	Sun, 23 Jun 2024 20:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719168285;
	bh=xFfq6IMls8R/GFy0awkeKfG3UUB4RaNR//ykkxGG2DY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rVi2ZS7l7qJ2DUSwlA9agNBSGs/N4Mrnoy016UwFDQZ1js+3tkUyT7XFAwzyRjTFM
	 6lJQw6xf3Yhrmq7OQNk7JsvYDK239xXDK/5cDEz5K4U61z2isRsWjtWjaRXjjQgc5/
	 q3jaKfBjY08hIbDLQn2t1BY35/7WS9ALXRgafR71Gt0rYN/sBiZx4+ipSyaQNxK17L
	 /thfRQU1RAKAHdnwBnSJedqHpUyrlUFboOmWFhsLebkIykRPwmPeCagu5tdQrBUi/H
	 jih49736yvqBG/n9hnb8Uw3d3wewJnDNeu8v0PoabyevXN4m6GVswjb1uA4e7u3T9S
	 Hch1O5+YFptLw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 297BF878E2;
 Sun, 23 Jun 2024 20:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719168284;
 bh=xFfq6IMls8R/GFy0awkeKfG3UUB4RaNR//ykkxGG2DY=;
 h=From:To:Cc:Subject:Date:From;
 b=zwhAbt7lu6Y38tMz+x+iqYfy66ETqld/02ynQxg3m8OF7JM80H3xfPYiACs6jwGMt
 HudMaGL0jdnX/tZBAFqV47KhBl1KY4dc7KeYzXKNnOegDR7xWg1CTkOOB2DHY4+Xta
 ZvvmYYKMwZ/fW977Z0urjYabEc0EeEACOfWSEMVOBqOrR6X+TDO+Ud0EP5JPHDrl7L
 TQ+kIxsWwVKPznpYuoREHKHePJPm93AoDJyQwtTVz08q701Yyk8Qm7Bjv0V8mzo2PR
 uJekzaQEm8gSS4edkFVVcm6AVpZMMqR8B5rT5rh6FO8OGTEXW43afYkrhqbIbu91Jg
 xh7ieDIp4v6xA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
Subject: [PATCH] ARM: imx: Enable SPL DTO application support for i.MX8MP
 DHCOM PDK2
Date: Sun, 23 Jun 2024 20:44:19 +0200
Message-ID: <20240623184427.56551-1-marex@denx.de>
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

Enable SPL DTO support to apply matching SoM specific DTOs to cater
for the SoM differences in DH i.MX8MP DHCOM PDK2 configuration. This
is already enabled in DH i.MX8MP DHCOM PDK3 configuration so align
the two configurations.

Fixes: ad1158c50e0e ("arm64: dts: imx8mp: Switch to DT overlays for i.MX8MP DHCOM SoM")
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Fabio Estevam <festevam@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 configs/imx8mp_dhcom_pdk2_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_pdk2_defconfig
index e5d74a9bdb2..cbc608dd912 100644
--- a/configs/imx8mp_dhcom_pdk2_defconfig
+++ b/configs/imx8mp_dhcom_pdk2_defconfig
@@ -15,7 +15,6 @@ CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8mp-dhcom-pdk2"
 CONFIG_SPL_TEXT_BASE=0x920000
 CONFIG_TARGET_IMX8MP_DH_DHCOM_PDK2=y
-CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SPL_MMC=y
@@ -41,6 +40,7 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x44000000
+CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY=y
 CONFIG_SYS_BOOTM_LEN=0x8000000
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_OF_SYSTEM_SETUP=y
@@ -66,6 +66,7 @@ CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x4c000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x300
+# CONFIG_SPL_FIT_IMAGE_TINY is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_WATCHDOG=y
-- 
2.43.0

