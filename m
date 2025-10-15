Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EFFCCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 16:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0811783824;
	Wed, 15 Oct 2025 18:26:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="JpJxPk7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30D9E83303; Wed, 15 Oct 2025 18:26:20 +0200 (CEST)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com
 [IPv6:2001:41d0:203:375::aa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B01B8357F
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 18:26:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1760545577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iCzjoNx85kQjnqtELcVZiI/0ZNha2YwcXg2IRVevnj8=;
 b=JpJxPk7tdiR7T6WbxlfRYjsYPHX/xZ3u32zNmM0pXF0YgMPgqCNMXFQ1cMExjTyM2iq0yJ
 NW7miSyXdhhE/jZnAIphJWFU/zxpRMyKm2sWfeJjRCdqq3F6WAcNDT6H2FomQbfXs/Q6C4
 /ORuxf3DkioPX4/cIVSg7d3pU8LOwbVeSgl4kqbSYQw/yrlHr4qFX5TigEvrHIYxB6CAyb
 Kvt1iOKb8O23BEmsN0YNEuMpEDFhNydRmRJRkMkJzEw06pAHrn6c88TAqcOfvZ3L/IALV9
 yG+K4ovJD6QG7B14VNQw7GIl/UduaeyKqq7gpUYretqaT6hyb3jCLzueBnv/mg==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 15 Oct 2025 16:25:54 +0000
Subject: [PATCH v4 7/8] board: amlogic: add kconfig fragments for SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251015-spl-gx-v4-7-f5d7fe03225b@postmarketos.org>
References: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
In-Reply-To: <20251015-spl-gx-v4-0-f5d7fe03225b@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5624;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=n9dcM1NaWv1N3tiHVLTyEWnkCB0OZsXRcVilFoSK+pA=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBo78sfZZGbJAzF6qkeA0raXdqmqqOMHQow1rwGC
 Mao7wMyfAiJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaO/LHwAKCRCEr8vQ14ma
 A8PQEACjMOWTsWQ7fxRqWqv45Wc1qk2BtqPwsgfKSSHylD1VCqCV60/QrVuCwjRVLd7PoyqlukZ
 wiSgPzoUCpAk4jLt6o5F2jvUrQWxIb+Rn8BLyYVxu36mBRNlwn4HbLMjKWk8VKE2ouIiNU4ziu5
 WiSN7BLtKCdw2g5YbyIyXm8+pqYtCTv5HhJpAzgomTOuuoRTq3ZKuyM22qVIQetx9eOMbAk0I7u
 W/kZTBalmxRN3FjYc47k5ecrYyzPXo4Q4eCbDsrivRHRXLcED4I0siudfQUHxodn5+TSnUw4Rz1
 TMExeUM2HDsHFFFeZAijpd/VnaLviGOhy8Jbkl783k0+FFlMu0NbuPJ33QBCGfbwjtA4cMGH6j1
 Zk6uiX3n7QKQsd3AM/gLj1Cciw71PU6KSKsbEzOzlv/8A7WkVH2zOK67+okNwv3fgK+8Jc/nABW
 VzvmrxuyXO7z1UbI8eTvl1HZ2lz3MPyAzRyolU67H6qFveiCumnHvCC5r0JGybFd5L27ub1Lp6C
 a/ukhvKAoCtb0ZZQTqx5jfceH3hmr3QuFMgCFzMzg5r6f4CfJ2SeELVUVYu6BoR2SK0yNbjiZhO
 V7DqZjossgbQAyU4ofeCnUwD1zo268Sm8rGfr2V0Xhyh/m5x47KmMCFwgCwyyFn1eLVAvnu25EX
 KbzFMNCI0GzoIJg==
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
 board/amlogic/p200/spl-odroid-c2.config           | 37 ++++++++++++++++++++++
 board/amlogic/p200/spl-videostrong-kii-pro.config | 38 +++++++++++++++++++++++
 board/amlogic/p212/spl-libretech-cc-1gb.config    | 35 +++++++++++++++++++++
 board/amlogic/p212/spl-libretech-cc-2gb.config    | 37 ++++++++++++++++++++++
 4 files changed, 147 insertions(+)

diff --git a/board/amlogic/p200/spl-odroid-c2.config b/board/amlogic/p200/spl-odroid-c2.config
new file mode 100644
index 00000000000..d5ea295bc6d
--- /dev/null
+++ b/board/amlogic/p200/spl-odroid-c2.config
@@ -0,0 +1,37 @@
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
index 00000000000..5b3ba9d9908
--- /dev/null
+++ b/board/amlogic/p200/spl-videostrong-kii-pro.config
@@ -0,0 +1,38 @@
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
index 00000000000..0969f9b7444
--- /dev/null
+++ b/board/amlogic/p212/spl-libretech-cc-1gb.config
@@ -0,0 +1,35 @@
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
index 00000000000..e2d9cc765cb
--- /dev/null
+++ b/board/amlogic/p212/spl-libretech-cc-2gb.config
@@ -0,0 +1,37 @@
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
2.51.0

