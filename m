Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D18FFC54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 15:00:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A1287E86;
	Mon, 18 Mar 2024 16:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qcNC+/wR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nOWrcEPs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F5787CB1; Mon, 18 Mar 2024 16:00:21 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C963B87A80
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 16:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TyyhL3cVTz9sW5;
 Mon, 18 Mar 2024 16:00:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710774018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gHvaGol+oOaPEjab5QXp1IlRRvXgqpXQNrr5ROCPuw=;
 b=qcNC+/wRuNzHD08fLmkKH8MkhwChLjPyEevM3V8nwULksjC+0XJpdwjlfY8nyw23mEiskH
 ondD4Oa7McEi2RDRc81+TyM6TsFvvt8sM4/klqpBuQm5j9twhP9hJphmbDffnOSeT53tIx
 JCUAAAFWgORBqG+cUUu8r8W8FKHY6+XTvclVFCl48GARftGfa9423XuvIyuZWayokthmG+
 ZBtu5UsfgnYnNXKr2+/gifynTR8dAfWtSN1kMOi9xLqmeoAJtpLJXY3OtgzWO24UbyzK1x
 7Iy5dpNZHQKYQBBEKv3lGMosHJcvcm9m1YOt4UVWF9xIARTlDEmx0Ev2MAStmA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710774016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gHvaGol+oOaPEjab5QXp1IlRRvXgqpXQNrr5ROCPuw=;
 b=nOWrcEPsiD7Sj+v0S87ht2Gs6AjA5waYv0sKYu6BqC/TNkeFnStQQ57mBkkkE8UA6ypISU
 8ut2wRIN5uw+P8hehKSRSht3IfcxjEFzcfS2Tw48BlTXrX+/AmrP9Y5ldkGSwVau5UtWig
 g2J6Vaz4lpxwAqdPcXDJBMZU8tVrbVao1j7L8y1TETrB6Q9AFz0FSOiY9zrwYYB+4e22UL
 gkoKo6ULPmpL4ZEpH/4n17avb3dMIavWApCD+T7Pr+rIYfIgAzIj5F/GMXnE+4pekAHonS
 PYQVZzMc++ItPpk5N0Fznjo3quy78yfhH3pXZKNC86fSmmDoiXfPwoXiF4+CgA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] ARM: dts: renesas: Switch to using upstream DT on 64bit
 Renesas SoCs
Date: Mon, 18 Mar 2024 15:59:38 +0100
Message-ID: <20240318145958.8099-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240318145958.8099-1-marek.vasut+renesas@mailbox.org>
References: <20240318145958.8099-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 14f9229c72319c841b8
X-MBO-RS-META: 4s437m4g48hpcw7r39qk7m3nft7smer9
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

Enable OF_UPSTREAM to use upstream DT and add renesas/ prefix to the
DEFAULT_DEVICE_TREE and OF_LIST. And thereby directly build DTB from
dts/upstream/src/ including *-u-boot.dtsi files from arch/$(ARCH)/dts/
directory.

The configuration update has been done using the following script:
```
sed -i '/^CONFIG_DEFAULT_DEVICE_TREE/ s@="@&renesas/@' `git grep -li renesas configs`
sed -i '/^CONFIG_OF_LIST/ s@r8a@renesas/&@g' `git grep -li renesas configs`
```

There are SoCs which are not included in this patch. The 32bit SoCs
require further infrastructure work. R8A779H0 is coming during the
next upstream DT synchronization cycle as it is not included in
current upstream DTs yet.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-renesas/Kconfig         | 1 +
 configs/hihope_rzg2_defconfig         | 4 ++--
 configs/r8a77970_eagle_defconfig      | 2 +-
 configs/r8a77970_v3msk_defconfig      | 2 +-
 configs/r8a77980_condor_defconfig     | 2 +-
 configs/r8a77980_v3hsk_defconfig      | 2 +-
 configs/r8a77990_ebisu_defconfig      | 2 +-
 configs/r8a77995_draak_defconfig      | 2 +-
 configs/r8a779a0_falcon_defconfig     | 2 +-
 configs/r8a779f0_spider_defconfig     | 2 +-
 configs/r8a779g0_whitehawk_defconfig  | 2 +-
 configs/r8a779h0_grayhawk_defconfig   | 1 +
 configs/rcar3_salvator-x_defconfig    | 4 ++--
 configs/rcar3_ulcb_defconfig          | 4 ++--
 configs/renesas_rzg2l_smarc_defconfig | 2 +-
 configs/rzg2_beacon_defconfig         | 4 ++--
 configs/silinux_ek874_defconfig       | 2 +-
 17 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/Kconfig
index 2ac867612bf..aeb55da609b 100644
--- a/arch/arm/mach-renesas/Kconfig
+++ b/arch/arm/mach-renesas/Kconfig
@@ -14,6 +14,7 @@ config RCAR_64
 	imply CMD_GPT
 	imply CMD_MMC_SWRITE if MMC
 	imply CMD_UUID
+	imply OF_UPSTREAM
 	imply SUPPORT_EMMC_RPMB if MMC
 
 choice
diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
index 88c7ed1b98f..149ce0bac0d 100644
--- a/configs/hihope_rzg2_defconfig
+++ b/configs/hihope_rzg2_defconfig
@@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a774a1-hihope-rzg2m"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a774a1-hihope-rzg2m"
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_HIHOPE_RZG2=y
 CONFIG_SYS_MONITOR_LEN=1048576
@@ -40,7 +40,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="r8a774a1-hihope-rzg2m r8a774b1-hihope-rzg2n r8a774e1-hihope-rzg2h"
+CONFIG_OF_LIST="renesas/r8a774a1-hihope-rzg2m renesas/r8a774b1-hihope-rzg2n renesas/r8a774e1-hihope-rzg2h"
 CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_ENV_OVERWRITE=y
diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_defconfig
index a3f695e4238..fc39412f65c 100644
--- a/configs/r8a77970_eagle_defconfig
+++ b/configs/r8a77970_eagle_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77970-eagle"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77970-eagle"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_EAGLE=y
diff --git a/configs/r8a77970_v3msk_defconfig b/configs/r8a77970_v3msk_defconfig
index 05c8d0e3868..bcd70b768ee 100644
--- a/configs/r8a77970_v3msk_defconfig
+++ b/configs/r8a77970_v3msk_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77970-v3msk"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77970-v3msk"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_RCAR_GEN3=y
 CONFIG_R8A77970=y
diff --git a/configs/r8a77980_condor_defconfig b/configs/r8a77980_condor_defconfig
index 9e11c1b27ee..65eb563a712 100644
--- a/configs/r8a77980_condor_defconfig
+++ b/configs/r8a77980_condor_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77980-condor"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77980-condor"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_CONDOR=y
diff --git a/configs/r8a77980_v3hsk_defconfig b/configs/r8a77980_v3hsk_defconfig
index f61574dd02d..38f9da445dd 100644
--- a/configs/r8a77980_v3hsk_defconfig
+++ b/configs/r8a77980_v3hsk_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77980-v3hsk"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77980-v3hsk"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_RCAR_GEN3=y
 CONFIG_R8A77980=y
diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_defconfig
index fe4134226ac..f3cf2f8835d 100644
--- a/configs/r8a77990_ebisu_defconfig
+++ b/configs/r8a77990_ebisu_defconfig
@@ -8,7 +8,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77990-ebisu"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77990-ebisu"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_EBISU=y
diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_defconfig
index a964d4ea51e..ae722724e27 100644
--- a/configs/r8a77995_draak_defconfig
+++ b/configs/r8a77995_draak_defconfig
@@ -8,7 +8,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77995-draak"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77995-draak"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_DRAAK=y
diff --git a/configs/r8a779a0_falcon_defconfig b/configs/r8a779a0_falcon_defconfig
index 6681cb0088f..40097f9dc34 100644
--- a/configs/r8a779a0_falcon_defconfig
+++ b/configs/r8a779a0_falcon_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC00000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a779a0-falcon"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779a0-falcon"
 CONFIG_RCAR_GEN4=y
 CONFIG_TARGET_FALCON=y
 CONFIG_SYS_MONITOR_LEN=1048576
diff --git a/configs/r8a779f0_spider_defconfig b/configs/r8a779f0_spider_defconfig
index 942e0184412..9ab46a4d5e0 100644
--- a/configs/r8a779f0_spider_defconfig
+++ b/configs/r8a779f0_spider_defconfig
@@ -6,7 +6,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xD00000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a779f0-spider"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779f0-spider"
 CONFIG_RCAR_GEN4=y
 CONFIG_TARGET_SPIDER=y
 CONFIG_SYS_MONITOR_LEN=1048576
diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
index 4cc6203e54d..abc9a3ba611 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a779g0-white-hawk"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a779g0-white-hawk"
 CONFIG_RCAR_GEN4=y
 CONFIG_TARGET_WHITEHAWK=y
 CONFIG_SYS_MONITOR_LEN=1048576
diff --git a/configs/r8a779h0_grayhawk_defconfig b/configs/r8a779h0_grayhawk_defconfig
index 7368708195d..ff317e7c4bc 100644
--- a/configs/r8a779h0_grayhawk_defconfig
+++ b/configs/r8a779h0_grayhawk_defconfig
@@ -72,3 +72,4 @@ CONFIG_SCIF_CONSOLE=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_RENESAS_RPC_SPI=y
+# CONFIG_OF_UPSTREAM is not set
diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index 22d649296e1..3200e3933b0 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -6,7 +6,7 @@ CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77951-salvator-x"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77951-salvator-x"
 CONFIG_SPL_TEXT_BASE=0xe6338000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_SALVATOR_X=y
@@ -48,7 +48,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="r8a77951-salvator-x r8a77960-salvator-x r8a77965-salvator-x"
+CONFIG_OF_LIST="renesas/r8a77951-salvator-x renesas/r8a77960-salvator-x renesas/r8a77965-salvator-x"
 CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_OF_DTB_PROPS_REMOVE=y
diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
index 8349f070ba4..c5cce826efd 100644
--- a/configs/rcar3_ulcb_defconfig
+++ b/configs/rcar3_ulcb_defconfig
@@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77951-ulcb"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a77951-ulcb"
 CONFIG_SPL_TEXT_BASE=0xe6338000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_ULCB=y
@@ -46,7 +46,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="r8a77951-ulcb r8a77960-ulcb r8a77965-ulcb"
+CONFIG_OF_LIST="renesas/r8a77951-ulcb renesas/r8a77960-ulcb renesas/r8a77965-ulcb"
 CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_OF_DTB_PROPS_REMOVE=y
diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
index e4e597f995a..7a1224b3f07 100644
--- a/configs/renesas_rzg2l_smarc_defconfig
+++ b/configs/renesas_rzg2l_smarc_defconfig
@@ -9,7 +9,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x80000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r9a07g044l2-smarc"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r9a07g044l2-smarc"
 CONFIG_RZG2L=y
 CONFIG_SYS_MONITOR_LEN=1048576
 CONFIG_SYS_LOAD_ADDR=0x58000000
diff --git a/configs/rzg2_beacon_defconfig b/configs/rzg2_beacon_defconfig
index f4b63adb41e..4aabb1fe03e 100644
--- a/configs/rzg2_beacon_defconfig
+++ b/configs/rzg2_beacon_defconfig
@@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_OFFSET=0x0
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a774a1-beacon-rzg2m-kit"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a774a1-beacon-rzg2m-kit"
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_BEACON_RZG2M=y
 CONFIG_SYS_MONITOR_LEN=1048576
@@ -39,7 +39,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="r8a774a1-beacon-rzg2m-kit r8a774b1-beacon-rzg2n-kit r8a774e1-beacon-rzg2h-kit"
+CONFIG_OF_LIST="renesas/r8a774a1-beacon-rzg2m-kit renesas/r8a774b1-beacon-rzg2n-kit renesas/r8a774e1-beacon-rzg2h-kit"
 CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_ENV_OVERWRITE=y
diff --git a/configs/silinux_ek874_defconfig b/configs/silinux_ek874_defconfig
index 93902e009b2..4c94d016454 100644
--- a/configs/silinux_ek874_defconfig
+++ b/configs/silinux_ek874_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3F0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a774c0-ek874"
+CONFIG_DEFAULT_DEVICE_TREE="renesas/r8a774c0-ek874"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_SILINUX_EK874=y
-- 
2.43.0

