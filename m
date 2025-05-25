Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC411C54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED98682B5B;
	Sun, 25 May 2025 12:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="e5XT7Q1j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2880B82B63; Sun, 25 May 2025 12:42:57 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 048CA82B53
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-106-142.46.114.pool.telefonica.de
 [46.114.106.142])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CD7ED4101F; 
 Sun, 25 May 2025 10:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1748169773;
 bh=U1oQ/r4XSsmW6LO3H8elSdSgC3gV7QFWcJUrl4XQRpM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=e5XT7Q1j25m7Cp6L8KMOyqprwoLYhImor3DeR4BMFlFs2dFl69XZeut5pBraqnlq9
 tJQfzja8FEDIX3wl+QwQcBfPXLsI7YAQ2QC2VvMdwATD+W5GqTK4zhRNSIgyNd3Hxy
 SbsTDo/S5+F8I4UxXP735WT7Q88vRKnqVJI6U0ra1OOhlLYywhwdjBM3vIns+TJZF1
 gAAxvXRAgX3Rui55qaazGFrmDuINjbOYkue0tVJUd2uY7ZFWARTjvulsB+L/UdKnDu
 Z0J1EyZpeZuvMjbr6lOx92lpBOtPBajRAzWr27OiU7J+tpn9+Wn5kU+tvq1hysfQwo
 9Yj4hdOW1k3kg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>,
	Rick Chen <rick@andestech.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Peng Fan <peng.fan@nxp.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <malysagreg@gmail.com>, Trevor Woerner <twoerner@gmail.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 E Shattow <e@freeshell.de>, Sumit Garg <sumit.garg@kernel.org>,
 Andreas Schwab <schwab@suse.de>, Maksim Kiselev <bigunclemax@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Yao Zi <ziyao@disroot.org>,
 Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] configs: raise SPL_SYS_MALLOC_SIZE to 8 MiB on RISC-V
Date: Sun, 25 May 2025 12:42:48 +0200
Message-ID: <20250525104248.67180-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

On several RISC-V boards we have seen that 1 MiB is a insufficient value
for CONFIG_SPL_SYS_MALLOC_SIZE.

For instance qemu-riscv32_spl_defconfig fails booting because u-boot.itb
exceeds 1 MiB.

8 MiB is a reasonable value that allows adding FPGA blobs or splash images
to main U-boot.

Reported-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 common/spl/Kconfig                     | 2 +-
 configs/starfive_visionfive2_defconfig | 1 -
 configs/th1520_lpi4a_defconfig         | 1 -
 configs/xilinx_mbv32_defconfig         | 1 -
 configs/xilinx_mbv32_smode_defconfig   | 1 -
 configs/xilinx_mbv64_defconfig         | 1 -
 configs/xilinx_mbv64_smode_defconfig   | 1 -
 7 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 77cf04d38ed..a12f030daed 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -488,7 +488,7 @@ config SPL_CUSTOM_SYS_MALLOC_ADDR
 config SPL_SYS_MALLOC_SIZE
 	hex "Size of the SPL malloc pool"
 	depends on SPL_SYS_MALLOC
-	default 0x180000 if BIOSEMU && RISCV
+	default 0x800000 if RISCV
 	default 0x100000
 
 config SPL_READ_ONLY
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index e145ced8db8..6982d422a82 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -56,7 +56,6 @@ CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80000000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x400000
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2
diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
index b19dc009fde..6ced7afe6b1 100644
--- a/configs/th1520_lpi4a_defconfig
+++ b/configs/th1520_lpi4a_defconfig
@@ -107,4 +107,3 @@ CONFIG_SPL_MMC_y
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x10000000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x400000
diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 861d1475453..c3f33d6454d 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -29,7 +29,6 @@ CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_TIMER=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
index 9398b4c240d..c588bd563ac 100644
--- a/configs/xilinx_mbv32_smode_defconfig
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -30,7 +30,6 @@ CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_TIMER=y
diff --git a/configs/xilinx_mbv64_defconfig b/configs/xilinx_mbv64_defconfig
index c39925bd86a..c2c677d7443 100644
--- a/configs/xilinx_mbv64_defconfig
+++ b/configs/xilinx_mbv64_defconfig
@@ -30,7 +30,6 @@ CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_TIMER=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
diff --git a/configs/xilinx_mbv64_smode_defconfig b/configs/xilinx_mbv64_smode_defconfig
index 811f93a2671..7a26c85dfb7 100644
--- a/configs/xilinx_mbv64_smode_defconfig
+++ b/configs/xilinx_mbv64_smode_defconfig
@@ -31,7 +31,6 @@ CONFIG_SPL_MAX_SIZE=0x40000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
 CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x2
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_TIMER=y
-- 
2.48.1

