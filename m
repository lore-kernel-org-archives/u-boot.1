Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DE6D10F2E
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 12:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32E6B84209;
	Wed, 26 Nov 2025 13:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="M7bLwJ2x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29C78841E6; Wed, 26 Nov 2025 13:17:43 +0100 (CET)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [91.218.175.182])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24D9883FF4
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 13:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1764159460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v5w3G5+jJ80JH0+11X3sN2NQveP4GrQbceClBlgZop8=;
 b=M7bLwJ2xKVDWW67BF80Iou8Tlf/msdZ5gHR+Mb85FVsKMpVQcmHB1Osb4yOat7s2C/+kAI
 9K9F5A3C4KrBBXl4JuUfatI6CNNCq91a75dsG1UXR/3f+R7oexF8uTaMjdzKedztb5jSGt
 ozewXadbrznQwXyrmve+CJ7tMUhbs4xg9GSlY8OV3OPG33RpucOyQtLeY7LpEpcEM0k1Uu
 teXQ8i5KJMfaX9eQiS0EHASpQ0dYCIuOqwNGhSN9AwLbtPZ+JhAeJKXqKheLV3v8ItBAOK
 9iXikRFGN2X6wjyEkz8Nt3qDO/usVC4f9yQw3VD9wzv5t0G/0r1KgqzaItOA/w==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 26 Nov 2025 12:17:10 +0000
Subject: [PATCH v5 08/10] board: amlogic: add kconfig fragments for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251126-spl-gx-v5-8-6cbffb2451ca@postmarketos.org>
References: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
In-Reply-To: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5712;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=C4S9pQIp+LaB6zzOnV84Ei9aOHwtxpZhVOG1cdJ9iSA=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpJu/Z0uvidZTrZgxPBa38e8r4iTg8OhSlwP8HI
 m4hmNPMgg6JAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaSbv2QAKCRCEr8vQ14ma
 AyIdD/0aJm6ijqwTKeZ/c7B05nETIxDobcvV8p3i+9Bp8eqwNZ0YNhu545EVtGTBD7np2QPsu1k
 aelaJS1bIhO8tI7axPuAbpnnswyUUA6+iDVSBMpEXoEYO+O+XFnc81L1a5Qr/TjWKRaujXN4EeF
 mRc49gySqhJ6/0OffQL7/VcnjKWYJ/wZNgKdOZvb4IzmvdVGQaN+9pZ/2xpKFiMYPPkjipmA5ua
 tTIUK/g/vS8S3UervEbSqoA6X0ZYhyuHyItnbjMVKF4VkQg7O6dJ3rOE3jZ90ZP1Av3cMtEVQfz
 MdQDJwkxyWSlQ9VG2DsMa7QArkDssAW/8wqU6nclDDEqmjsjCcr475upJttBRoIHTtPrbbviMGI
 9B+Q8s3FLz94lhGp6SI9zdwK7EQVoane+3a4blx2f0fy4BmXrWS8h2ySqvclSTl4Bb4WRBMTCu9
 vefXNh/PkeSuORskXq45Be0+jnRlg80D+VqdlYDj4bVUktMNEIuj4nUR0Oa9QOCXBvTpZ07fWE4
 McOcFUGBGxg29x63eX3n9OK9/K86oXIjCXHGbVPfiGEs1RkmCu9GGxxn1rcEsCFoMcBE1vOYDLu
 VQPFh7zRc1lTJNPWCH2ORmY+01CpH0YxMd19P2he7TeqZw3XT2hzqOX0nJ3JRO1TYc9yak5lYZU
 3uvmv3hAcIj/zpg==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

Add kconfig fragments for building SPL binaries for:
 · ODROID-C2
 · Videostrong KII Pro
 · Libre Computer LePotato (1 GB and 2 GB variants)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 board/amlogic/p200/spl-odroid-c2.config           | 38 ++++++++++++++++++++++
 board/amlogic/p200/spl-videostrong-kii-pro.config | 39 +++++++++++++++++++++++
 board/amlogic/p212/spl-libretech-cc-1gb.config    | 36 +++++++++++++++++++++
 board/amlogic/p212/spl-libretech-cc-2gb.config    | 38 ++++++++++++++++++++++
 4 files changed, 151 insertions(+)

diff --git a/board/amlogic/p200/spl-odroid-c2.config b/board/amlogic/p200/spl-odroid-c2.config
new file mode 100644
index 00000000000..f3497c54153
--- /dev/null
+++ b/board/amlogic/p200/spl-odroid-c2.config
@@ -0,0 +1,38 @@
+#
+# U-Boot SPL fragment for odroid-c2
+#
+
+CONFIG_SPL=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_TEXT_BASE=0xd9001000
+CONFIG_SPL_STACK=0xd9013000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0xd900c000
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_BSS_MAX_SIZE=0x1000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+# CONFIG_SPL_SERIAL_PRESENT is not set
+CONFIG_SPL_SHA256=y
+# CONFIG_SPL_SHA1 is not set
+
+# Enable MMC and serial drivers
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
+# CONFIG_SYS_MMCSD_FS_BOOT is not set
+
+# Image things
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_FIT_IMAGE_POST_PROCESS=y
+CONFIG_SPL_MAX_SIZE=0xb000
+CONFIG_SPL_PAD_TO=0x1fe00
+CONFIG_SPL_ATF=y
+CONFIG_SPL_OF_CONTROL=y
+# DRAM configuration
+CONFIG_DRAM_SIZE=2048
+CONFIG_DRAM_2T_MODE=y
+CONFIG_DRAM_TWO_IDENTICAL_RANKS=y
diff --git a/board/amlogic/p200/spl-videostrong-kii-pro.config b/board/amlogic/p200/spl-videostrong-kii-pro.config
new file mode 100644
index 00000000000..62df2333717
--- /dev/null
+++ b/board/amlogic/p200/spl-videostrong-kii-pro.config
@@ -0,0 +1,39 @@
+#
+# U-Boot SPL fragment for videostrong-kii-pro
+#
+
+CONFIG_SPL=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_TEXT_BASE=0xd9001000
+CONFIG_SPL_STACK=0xd9013000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0xd900c000
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_BSS_MAX_SIZE=0x1000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+# CONFIG_SPL_SERIAL_PRESENT is not set
+CONFIG_SPL_SHA256=y
+# CONFIG_SPL_SHA1 is not set
+
+# Enable MMC and serial drivers
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
+# CONFIG_SYS_MMCSD_FS_BOOT is not set
+
+# Image things
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_FIT_IMAGE_POST_PROCESS=y
+CONFIG_SPL_MAX_SIZE=0xb000
+CONFIG_SPL_PAD_TO=0x1fe00
+CONFIG_SPL_ATF=y
+CONFIG_SPL_OF_CONTROL=y
+# DRAM configuration
+CONFIG_DRAM_SIZE=2048
+CONFIG_DRAM_2T_MODE=y
+CONFIG_DRAM_TWO_DIFF_RANKS=y
+
diff --git a/board/amlogic/p212/spl-libretech-cc-1gb.config b/board/amlogic/p212/spl-libretech-cc-1gb.config
new file mode 100644
index 00000000000..be414c8770e
--- /dev/null
+++ b/board/amlogic/p212/spl-libretech-cc-1gb.config
@@ -0,0 +1,36 @@
+#
+# U-Boot SPL fragment for libretech-cc (1 GB variant)
+#
+
+CONFIG_SPL=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_TEXT_BASE=0xd9001000
+CONFIG_SPL_STACK=0xd9013000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0xd900c000
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_BSS_MAX_SIZE=0x1000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+# CONFIG_SPL_SERIAL_PRESENT is not set
+CONFIG_SPL_SHA256=y
+# CONFIG_SPL_SHA1 is not set
+
+# Enable MMC and serial drivers
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
+# CONFIG_SYS_MMCSD_FS_BOOT is not set
+
+# Image things
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_MAX_SIZE=0xb000
+CONFIG_SPL_PAD_TO=0x1fe00
+CONFIG_SPL_ATF=y
+CONFIG_SPL_OF_CONTROL=y
+# DRAM configuration
+CONFIG_DRAM_2T_MODE=y
+CONFIG_DRAM_DQS_CORR=y
diff --git a/board/amlogic/p212/spl-libretech-cc-2gb.config b/board/amlogic/p212/spl-libretech-cc-2gb.config
new file mode 100644
index 00000000000..9f7b81fd6e9
--- /dev/null
+++ b/board/amlogic/p212/spl-libretech-cc-2gb.config
@@ -0,0 +1,38 @@
+#
+# U-Boot SPL fragment for libretech-cc (2 GB variant)
+#
+
+CONFIG_SPL=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_TEXT_BASE=0xd9001000
+CONFIG_SPL_STACK=0xd9013000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0xd900c000
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_BSS_MAX_SIZE=0x1000
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+# CONFIG_SPL_SERIAL_PRESENT is not set
+CONFIG_SPL_SHA256=y
+# CONFIG_SPL_SHA1 is not set
+
+# Enable MMC and serial drivers
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
+# CONFIG_SYS_MMCSD_FS_BOOT is not set
+
+# Image things
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_MAX_SIZE=0xb000
+CONFIG_SPL_PAD_TO=0x1fe00
+CONFIG_SPL_ATF=y
+CONFIG_SPL_OF_CONTROL=y
+# DRAM configuration
+CONFIG_DRAM_SIZE=2048
+CONFIG_DRAM_2T_MODE=y
+CONFIG_DRAM_DQS_CORR=y
+CONFIG_DRAM_TWO_IDENTICAL_RANKS=y

-- 
2.51.2

