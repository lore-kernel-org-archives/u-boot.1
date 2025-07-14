Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F559C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A750083046;
	Mon, 14 Jul 2025 15:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=smtpservice.net header.i=@smtpservice.net header.b="DGnzsOHt";
	dkim=pass (2048-bit key; unprotected) header.d=on-the-web.ch header.i=@on-the-web.ch header.b="iwLIJq+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3030483061; Mon, 14 Jul 2025 15:35:31 +0200 (CEST)
Received: from a4i432.smtp2go.com (a4i432.smtp2go.com [158.120.81.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0F4283045
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounce.w90jmdpa2psm9i6=edbme25wqcwl=xb31qqwd4jfbu2@em923567.on-the-web.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752500118; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=SI1nEZegTRQD3aqG6CHBtNksbiORDkFzd8wex6z4S6M=;
 b=DGnzsOHtfwZBw20GlO/ASrCr1SdFLYlL58L4EDoVBogsBIZnQ/wPGPX+gNnhbPzEE9EHx
 mvJz2gGhr3Hvwjt2wk63UtobzRpTbdv3YFZJQXa5fLwIKxZb76OiPj62R97eYzkq5PcKWuq
 WghSoNW4Tar+4ha7+QvuCYSXL1tEwUtWbJDfdqfgWoU1azvF0PWPADmhmPELgV4sJQEd0qx
 ApVeXzsgZFhVwsM/Wq07n3zX+OoR8+Y0ICi8dp50phsNp4nZawV6J94W+9Z2uVYcv+zN/de
 yvUWBSQqZPlwS13LBBPAR8zuoM4XgESzjbZ+4SYcUxmkplEyb3aDyfTvdTtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
 i=@on-the-web.ch; q=dns/txt; s=s923567; t=1752500118; h=from : subject
 : to : message-id : date;
 bh=SI1nEZegTRQD3aqG6CHBtNksbiORDkFzd8wex6z4S6M=;
 b=iwLIJq+6HUL8TM/EHV0TxBFhKjPh8y+rTJLW7Y9A3oGRlIZXkEq9jW9Y1jK9UZTsLViMB
 W88F0OVkrxWap+BFXoFhoLpO/BSYuuk20D86hoiCoZm8H4ZP+wJbGAqj4bAwq52Adyt0JQn
 oDcQEDS525BNa02FWlOgC0VVqFUWRVwtYFUoeIll9FAi6Alai6S/RJSloG2O9jm+h8th9Hj
 g3JkrWj0jyzm+gJQRNvb+R3IN4HEueNvZd3Ls7B3srFfbGAaFPqW/NSCUErpjocsiU9X8Yd
 DseB6eyFVV1PuN2AO/dZJtNMJ+9fBnjGwKe47p6ZjzGBqE3U/mNBhVnOq1Dw==
Received: from [10.114.245.143] (helo=ch-web-troubles-5500.dynv6.net)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <sputnik@on-the-web.ch>)
 id 1ubJKT-FnQW0hPlLyG-m7B4; Mon, 14 Jul 2025 13:34:49 +0000
From: Martin Herren <sputnik@on-the-web.ch>
To: u-boot@lists.denx.de
Cc: Martin Herren <sputnik@on-the-web.ch>, Andreas Schwab <schwab@suse.de>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>, E Shattow <e@freeshell.de>,
 Green Wan <green.wan@sifive.com>, Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Minda Chen <minda.chen@starfivetech.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yao Zi <ziyao@disroot.org>, Yixun Lan <dlan@gentoo.org>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>
Subject: [PATCH 3/3] riscv: Remove default SYS_BOOTM_LEN from defconfig
Date: Mon, 14 Jul 2025 15:33:12 +0200
Message-ID: <20250714133345.128853-4-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714133345.128853-1-sputnik@on-the-web.ch>
References: <20250714133345.128853-1-sputnik@on-the-web.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 923567m:923567atSSOWT:923567srbcXde-cR
X-smtpcorp-track: jEUlLIzwNnlt.foOvq_RYQryE.GKoPNAQ2Hmx
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

Remove CONFIG_SYS_BOOTM_LEN from all riscv defconfigs where the new
default value is used.

Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
---

(no changes since v1)

 configs/ae350_rv32_defconfig            | 1 -
 configs/ae350_rv32_falcon_defconfig     | 1 -
 configs/ae350_rv32_falcon_xip_defconfig | 1 -
 configs/ae350_rv32_spl_defconfig        | 1 -
 configs/ae350_rv32_spl_xip_defconfig    | 1 -
 configs/ae350_rv32_xip_defconfig        | 1 -
 configs/ae350_rv64_defconfig            | 1 -
 configs/ae350_rv64_falcon_defconfig     | 1 -
 configs/ae350_rv64_falcon_xip_defconfig | 1 -
 configs/ae350_rv64_spl_defconfig        | 1 -
 configs/ae350_rv64_spl_xip_defconfig    | 1 -
 configs/ae350_rv64_xip_defconfig        | 1 -
 configs/ibex-ast2700_defconfig          | 1 -
 configs/milkv_duo_defconfig             | 1 -
 configs/qemu-riscv32_defconfig          | 1 -
 configs/qemu-riscv32_smode_defconfig    | 1 -
 configs/qemu-riscv32_spl_defconfig      | 1 -
 configs/qemu-riscv64_defconfig          | 1 -
 configs/qemu-riscv64_smode_defconfig    | 1 -
 configs/qemu-riscv64_spl_defconfig      | 1 -
 configs/sifive_unleashed_defconfig      | 1 -
 configs/sifive_unmatched_defconfig      | 1 -
 configs/sipeed_licheerv_nano_defconfig  | 1 -
 configs/starfive_visionfive2_defconfig  | 1 -
 configs/th1520_lpi4a_defconfig          | 1 -
 25 files changed, 25 deletions(-)

diff --git a/configs/ae350_rv32_defconfig b/configs/ae350_rv32_defconfig
index 467d61d73df..e87782005f1 100644
--- a/configs/ae350_rv32_defconfig
+++ b/configs/ae350_rv32_defconfig
@@ -7,7 +7,6 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xfffe80
 CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_32"
 CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_ANDES_AE350=y
 CONFIG_SYS_MONITOR_BASE=0x88000000
diff --git a/configs/ae350_rv32_falcon_defconfig b/configs/ae350_rv32_falcon_defconfig
index 66b809d2376..f1d88f8560f 100644
--- a/configs/ae350_rv32_falcon_defconfig
+++ b/configs/ae350_rv32_falcon_defconfig
@@ -9,7 +9,6 @@ CONFIG_DEFAULT_DEVICE_TREE="ae350_32"
 CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000000
 CONFIG_SPL_BSS_START_ADDR=0x400000
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_SPL=y
 CONFIG_TARGET_ANDES_AE350=y
diff --git a/configs/ae350_rv32_falcon_xip_defconfig b/configs/ae350_rv32_falcon_xip_defconfig
index a2f8d4cd236..2355bac5019 100644
--- a/configs/ae350_rv32_falcon_xip_defconfig
+++ b/configs/ae350_rv32_falcon_xip_defconfig
@@ -10,7 +10,6 @@ CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000000
 CONFIG_SPL_TEXT_BASE=0x80000000
 CONFIG_SPL_BSS_START_ADDR=0x400000
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_SPL=y
 CONFIG_TARGET_ANDES_AE350=y
diff --git a/configs/ae350_rv32_spl_defconfig b/configs/ae350_rv32_spl_defconfig
index 098cf7686d6..6655cbd4a96 100644
--- a/configs/ae350_rv32_spl_defconfig
+++ b/configs/ae350_rv32_spl_defconfig
@@ -9,7 +9,6 @@ CONFIG_DEFAULT_DEVICE_TREE="ae350_32"
 CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000000
 CONFIG_SPL_BSS_START_ADDR=0x400000
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_SPL=y
 CONFIG_TARGET_ANDES_AE350=y
diff --git a/configs/ae350_rv32_spl_xip_defconfig b/configs/ae350_rv32_spl_xip_defconfig
index 23927888c87..44a6b6534b8 100644
--- a/configs/ae350_rv32_spl_xip_defconfig
+++ b/configs/ae350_rv32_spl_xip_defconfig
@@ -10,7 +10,6 @@ CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000000
 CONFIG_SPL_TEXT_BASE=0x80000000
 CONFIG_SPL_BSS_START_ADDR=0x400000
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_SPL=y
 CONFIG_TARGET_ANDES_AE350=y
diff --git a/configs/ae350_rv32_xip_defconfig b/configs/ae350_rv32_xip_defconfig
index 75eb0618454..15f3b5c378b 100644
--- a/configs/ae350_rv32_xip_defconfig
+++ b/configs/ae350_rv32_xip_defconfig
@@ -7,7 +7,6 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xfffe80
 CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_32"
 CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_ANDES_AE350=y
 CONFIG_XIP=y
diff --git a/configs/ae350_rv64_defconfig b/configs/ae350_rv64_defconfig
index 932739e5dec..78b9fc439ac 100644
--- a/configs/ae350_rv64_defconfig
+++ b/configs/ae350_rv64_defconfig
@@ -6,7 +6,6 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xfffd70
 CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_64"
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_ANDES_AE350=y
 CONFIG_ARCH_RV64I=y
diff --git a/configs/ae350_rv64_falcon_defconfig b/configs/ae350_rv64_falcon_defconfig
index c9417175ce7..81bebb1a1d4 100644
--- a/configs/ae350_rv64_falcon_defconfig
+++ b/configs/ae350_rv64_falcon_defconfig
@@ -8,7 +8,6 @@ CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_64"
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000000
 CONFIG_SPL_BSS_START_ADDR=0x400000
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_SPL=y
 CONFIG_TARGET_ANDES_AE350=y
diff --git a/configs/ae350_rv64_falcon_xip_defconfig b/configs/ae350_rv64_falcon_xip_defconfig
index e072f7c2ae9..8e1b8e20052 100644
--- a/configs/ae350_rv64_falcon_xip_defconfig
+++ b/configs/ae350_rv64_falcon_xip_defconfig
@@ -9,7 +9,6 @@ CONFIG_DEFAULT_DEVICE_TREE="ae350_64"
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000000
 CONFIG_SPL_TEXT_BASE=0x80000000
 CONFIG_SPL_BSS_START_ADDR=0x400000
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_SPL=y
 CONFIG_TARGET_ANDES_AE350=y
diff --git a/configs/ae350_rv64_spl_defconfig b/configs/ae350_rv64_spl_defconfig
index 83ce28077f0..7950074642e 100644
--- a/configs/ae350_rv64_spl_defconfig
+++ b/configs/ae350_rv64_spl_defconfig
@@ -8,7 +8,6 @@ CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_64"
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000000
 CONFIG_SPL_BSS_START_ADDR=0x400000
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_SPL=y
 CONFIG_TARGET_ANDES_AE350=y
diff --git a/configs/ae350_rv64_spl_xip_defconfig b/configs/ae350_rv64_spl_xip_defconfig
index 5ad1751686c..d5882af1de1 100644
--- a/configs/ae350_rv64_spl_xip_defconfig
+++ b/configs/ae350_rv64_spl_xip_defconfig
@@ -9,7 +9,6 @@ CONFIG_DEFAULT_DEVICE_TREE="ae350_64"
 CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000000
 CONFIG_SPL_TEXT_BASE=0x80000000
 CONFIG_SPL_BSS_START_ADDR=0x400000
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_SPL=y
 CONFIG_TARGET_ANDES_AE350=y
diff --git a/configs/ae350_rv64_xip_defconfig b/configs/ae350_rv64_xip_defconfig
index 5ec2cba670b..46ce063c484 100644
--- a/configs/ae350_rv64_xip_defconfig
+++ b/configs/ae350_rv64_xip_defconfig
@@ -6,7 +6,6 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xfffd70
 CONFIG_ENV_SECT_SIZE=0x1000
 CONFIG_DEFAULT_DEVICE_TREE="ae350_64"
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x100000
 CONFIG_TARGET_ANDES_AE350=y
 CONFIG_ARCH_RV64I=y
diff --git a/configs/ibex-ast2700_defconfig b/configs/ibex-ast2700_defconfig
index f088aec8716..8e8259f291d 100644
--- a/configs/ibex-ast2700_defconfig
+++ b/configs/ibex-ast2700_defconfig
@@ -15,7 +15,6 @@ CONFIG_DM_RESET=y
 CONFIG_SPL_TEXT_BASE=0x14bc0080
 CONFIG_SPL_BSS_START_ADDR=0x14bd7800
 CONFIG_SPL_BSS_MAX_SIZE=0x800
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x83000000
 CONFIG_SPL_SIZE_LIMIT=0x16000
 CONFIG_SPL=y
diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index 70393de5736..f1f3930564b 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -5,7 +5,6 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
 CONFIG_DEFAULT_DEVICE_TREE="cv1800b-milkv-duo"
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x80080000
 CONFIG_IDENT_STRING="milkv_duo"
 CONFIG_TARGET_MILKV_DUO=y
diff --git a/configs/qemu-riscv32_defconfig b/configs/qemu-riscv32_defconfig
index cdffda26281..d77054e5a0e 100644
--- a/configs/qemu-riscv32_defconfig
+++ b/configs/qemu-riscv32_defconfig
@@ -5,7 +5,6 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="qemu-virt32"
 CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_TARGET_QEMU_VIRT=y
 CONFIG_FIT=y
diff --git a/configs/qemu-riscv32_smode_defconfig b/configs/qemu-riscv32_smode_defconfig
index 3d065b6a9fb..22d9462c022 100644
--- a/configs/qemu-riscv32_smode_defconfig
+++ b/configs/qemu-riscv32_smode_defconfig
@@ -5,7 +5,6 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="qemu-virt32"
 CONFIG_SYS_MONITOR_LEN=786432
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_TARGET_QEMU_VIRT=y
 CONFIG_RISCV_SMODE=y
diff --git a/configs/qemu-riscv32_spl_defconfig b/configs/qemu-riscv32_spl_defconfig
index 15f1a5d973d..b43eda1e160 100644
--- a/configs/qemu-riscv32_spl_defconfig
+++ b/configs/qemu-riscv32_spl_defconfig
@@ -6,7 +6,6 @@ CONFIG_ENV_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="qemu-virt32"
 CONFIG_SYS_MONITOR_LEN=786432
 CONFIG_SPL_BSS_START_ADDR=0x84000000
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SPL=y
 CONFIG_TARGET_QEMU_VIRT=y
diff --git a/configs/qemu-riscv64_defconfig b/configs/qemu-riscv64_defconfig
index bf9a0b07400..b5d65db6308 100644
--- a/configs/qemu-riscv64_defconfig
+++ b/configs/qemu-riscv64_defconfig
@@ -4,7 +4,6 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="qemu-virt64"
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_TARGET_QEMU_VIRT=y
 CONFIG_ARCH_RV64I=y
diff --git a/configs/qemu-riscv64_smode_defconfig b/configs/qemu-riscv64_smode_defconfig
index 6cc42817970..d3f7465ff82 100644
--- a/configs/qemu-riscv64_smode_defconfig
+++ b/configs/qemu-riscv64_smode_defconfig
@@ -4,7 +4,6 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="qemu-virt64"
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_TARGET_QEMU_VIRT=y
 CONFIG_ARCH_RV64I=y
diff --git a/configs/qemu-riscv64_spl_defconfig b/configs/qemu-riscv64_spl_defconfig
index 1c7cef056c4..eae94d8d161 100644
--- a/configs/qemu-riscv64_spl_defconfig
+++ b/configs/qemu-riscv64_spl_defconfig
@@ -5,7 +5,6 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DEFAULT_DEVICE_TREE="qemu-virt64"
 CONFIG_SPL_BSS_START_ADDR=0x84000000
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SPL=y
 CONFIG_TARGET_QEMU_VIRT=y
diff --git a/configs/sifive_unleashed_defconfig b/configs/sifive_unleashed_defconfig
index 01963a4e54e..f341e3e0735 100644
--- a/configs/sifive_unleashed_defconfig
+++ b/configs/sifive_unleashed_defconfig
@@ -11,7 +11,6 @@ CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_STACK=0x81cfe70
 CONFIG_SPL_BSS_START_ADDR=0x85000000
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SPL=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
diff --git a/configs/sifive_unmatched_defconfig b/configs/sifive_unmatched_defconfig
index acbea7fe1bb..0a736f2ba95 100644
--- a/configs/sifive_unmatched_defconfig
+++ b/configs/sifive_unmatched_defconfig
@@ -12,7 +12,6 @@ CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_STACK=0x81cfe60
 CONFIG_SPL_BSS_START_ADDR=0x85000000
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SPL=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
diff --git a/configs/sipeed_licheerv_nano_defconfig b/configs/sipeed_licheerv_nano_defconfig
index 14fefa968c6..ab29f327d7a 100644
--- a/configs/sipeed_licheerv_nano_defconfig
+++ b/configs/sipeed_licheerv_nano_defconfig
@@ -5,7 +5,6 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x82300000
 CONFIG_DEFAULT_DEVICE_TREE="sg2002-licheerv-nano-b"
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x80080000
 CONFIG_IDENT_STRING="licheerv_nano"
 CONFIG_TARGET_LICHEERV_NANO=y
diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 3e34e4a87f8..544140c03f7 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -18,7 +18,6 @@ CONFIG_SPL_STACK=0x8180000
 CONFIG_SPL_TEXT_BASE=0x8000000
 CONFIG_SPL_BSS_START_ADDR=0x8040000
 CONFIG_SPL_BSS_MAX_SIZE=0x10000
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x82000000
 CONFIG_SPL=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
index 78e3b25ab82..55a8eaac4a9 100644
--- a/configs/th1520_lpi4a_defconfig
+++ b/configs/th1520_lpi4a_defconfig
@@ -10,7 +10,6 @@ CONFIG_DEFAULT_DEVICE_TREE="th1520-lichee-pi-4a"
 CONFIG_SPL_STACK=0xffe0170000
 CONFIG_SPL_BSS_START_ADDR=0xffe0160000
 CONFIG_SPL_BSS_MAX_SIZE=0x10000
-CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SPL=y
 CONFIG_TARGET_TH1520_LPI4A=y
