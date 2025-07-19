Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133F1C83F27
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 22:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 328C6832E6;
	Sun, 20 Jul 2025 00:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=smtpservice.net header.i=@smtpservice.net header.b="ymf35mc+";
	dkim=pass (2048-bit key; unprotected) header.d=on-the-web.ch header.i=@on-the-web.ch header.b="hT/WxAw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA0D832F9; Sun, 20 Jul 2025 00:57:33 +0200 (CEST)
Received: from e3i311.smtp2go.com (e3i311.smtp2go.com [158.120.85.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9B2283096
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 00:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounce.4pe2pfqm95qcyg6=l6omje7k6w8q=0cils6ldq58c2q@em923567.on-the-web.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752965843; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=cLj2sQo9VUpAtsZa01wSUz1lMqPODl9ds1+nHtPsh2c=;
 b=ymf35mc+tsTrAxTsVb85WLlXAaTrXqPNweLlaDOzbxehnvX5AU80uXYVqtX39ETpVFyt1
 9smgMZwkg+7WUlNWv58jns2woezBS1TD9k5VB/c07/kkykk9o5ZdJOYazPbjCu89C00Swsh
 fOyQdfnwsjVR2eEODJ2HbtN+RDMKykMlDvGsxzCWzT3TcRUsh6Yt/t9WG+Lin9Z9jUn0RE2
 dwQnew0tE9fRFD8IJVbLTGnSxcG7QK/FSnSVhapSlSthSYgfzWYUJDIFFGBbz8kbMz1icJL
 yXlRUmSw/MJYHW91CWRs3hT3iBTx76vgjcYS67a21SeCW59wem5RRcZbwKeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
 i=@on-the-web.ch; q=dns/txt; s=s923567; t=1752965843; h=from : subject
 : to : message-id : date;
 bh=cLj2sQo9VUpAtsZa01wSUz1lMqPODl9ds1+nHtPsh2c=;
 b=hT/WxAw8KxXzFrT6ddpFXobU2X6b8gOIwRPLDAoyp+sBSvhmlFvmiLxotWRWyh3b1KVB9
 1N9gLKS70si9nyfnZypaSFsixqE6kxhoLMYkR79clgcg/xi9V2iORd8Eq/jcKSgDQuzCpFJ
 CrU0z1/HtPtRyvbhKh9Kcv2Yxy16p9u5Chto7HqFgwo6coYrnqupHaIEd03It+GXKEb+jHa
 YSDGGQ2OMQOdE7lQNmMHS7uZa02K886vLLmogECf4nL6GW/b0KdM0e7XhEwfaU/hkULRhIP
 slFQVxiN9jw8YTOyCpEaK8GPzKrbYGsQROFCmfupcwse33KJ95JxY/uHXoEQ==
Received: from [10.34.231.120] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96-S2G) (envelope-from <sputnik@on-the-web.ch>)
 id 1udFOt-U24cwK-39; Sat, 19 Jul 2025 21:47:24 +0000
Received: from [10.114.245.143] (helo=ch-web-troubles-5500.home)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <sputnik@on-the-web.ch>)
 id 1udFOs-FnQW0hPvgzA-ndy2; Sat, 19 Jul 2025 21:47:22 +0000
From: Martin Herren <sputnik@on-the-web.ch>
To: u-boot@lists.denx.de
Cc: Martin Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/4] riscv: Set SYS_BOOTM_LEN explicitly to 0x800000
Date: Sat, 19 Jul 2025 23:46:32 +0200
Message-ID: <20250719214650.214931-2-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250719214650.214931-1-sputnik@on-the-web.ch>
References: <20250719214650.214931-1-sputnik@on-the-web.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 923567m:923567atSSOWT:923567sDtWEBps2L
X-smtpcorp-track: i-GEfL1dLuqw.bMPPgTu2s7G6.KWjgmQNEngs
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

For all riscv defconfigs that use the current default value.

This is done in provision of changing the default value to the most
common used value of 0x4000000.

Acked-by: Michal Simek <michal.simek@amd.com> # xilinx_mbv
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
---

(no changes since v1)

 configs/k230_canmv_defconfig            | 1 +
 configs/microchip_mpfs_icicle_defconfig | 1 +
 configs/sipeed_maix_bitm_defconfig      | 1 +
 configs/sipeed_maix_smode_defconfig     | 1 +
 configs/xilinx_mbv32_defconfig          | 1 +
 configs/xilinx_mbv32_smode_defconfig    | 1 +
 configs/xilinx_mbv64_defconfig          | 1 +
 configs/xilinx_mbv64_smode_defconfig    | 1 +
 8 files changed, 8 insertions(+)

diff --git a/configs/k230_canmv_defconfig b/configs/k230_canmv_defconfig
index 47fa1add2a9..ed49a42b6fc 100644
--- a/configs/k230_canmv_defconfig
+++ b/configs/k230_canmv_defconfig
@@ -4,6 +4,7 @@ CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80400000
 CONFIG_DEFAULT_DEVICE_TREE="k230-canmv"
+CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0xc000000
 CONFIG_TARGET_K230_CANMV=y
 CONFIG_ARCH_RV64I=y
diff --git a/configs/microchip_mpfs_icicle_defconfig b/configs/microchip_mpfs_icicle_defconfig
index 6937aa224a1..99df10dc4c2 100644
--- a/configs/microchip_mpfs_icicle_defconfig
+++ b/configs/microchip_mpfs_icicle_defconfig
@@ -5,6 +5,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="microchip/mpfs-icicle-kit"
+CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SYS_MEM_TOP_HIDE=0x400000
 # CONFIG_DEBUG_UART is not set
diff --git a/configs/sipeed_maix_bitm_defconfig b/configs/sipeed_maix_bitm_defconfig
index b2e21c7d7ae..c21cdace328 100644
--- a/configs/sipeed_maix_bitm_defconfig
+++ b/configs/sipeed_maix_bitm_defconfig
@@ -5,6 +5,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x803fffff
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0xfff000
 CONFIG_ENV_SECT_SIZE=0x1000
+CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80000000
 CONFIG_SF_DEFAULT_BUS=3
 CONFIG_TARGET_SIPEED_MAIX=y
diff --git a/configs/sipeed_maix_smode_defconfig b/configs/sipeed_maix_smode_defconfig
index d838b252d53..3c77e40e47e 100644
--- a/configs/sipeed_maix_smode_defconfig
+++ b/configs/sipeed_maix_smode_defconfig
@@ -6,6 +6,7 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x803fffff
 CONFIG_ENV_SIZE=0x1000
 CONFIG_ENV_OFFSET=0xfff000
 CONFIG_ENV_SECT_SIZE=0x1000
+CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80000000
 CONFIG_SF_DEFAULT_BUS=3
 CONFIG_TARGET_SIPEED_MAIX=y
diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 7dde2fc0a8f..dfcc51cb8e6 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -8,6 +8,7 @@ CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
 CONFIG_SPL_STACK=0x80200000
 CONFIG_SPL_BSS_START_ADDR=0x84000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL=y
diff --git a/configs/xilinx_mbv32_smode_defconfig b/configs/xilinx_mbv32_smode_defconfig
index b96b02c6125..0b14c7ce4c0 100644
--- a/configs/xilinx_mbv32_smode_defconfig
+++ b/configs/xilinx_mbv32_smode_defconfig
@@ -8,6 +8,7 @@ CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv32"
 CONFIG_SPL_STACK=0x80200000
 CONFIG_SPL_BSS_START_ADDR=0x84000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL=y
diff --git a/configs/xilinx_mbv64_defconfig b/configs/xilinx_mbv64_defconfig
index 77fcf4d6865..a437895b5ab 100644
--- a/configs/xilinx_mbv64_defconfig
+++ b/configs/xilinx_mbv64_defconfig
@@ -8,6 +8,7 @@ CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv64"
 CONFIG_SPL_STACK=0x80200000
 CONFIG_SPL_BSS_START_ADDR=0x84000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL=y
diff --git a/configs/xilinx_mbv64_smode_defconfig b/configs/xilinx_mbv64_smode_defconfig
index e53c0771baf..87d1d17d5b9 100644
--- a/configs/xilinx_mbv64_smode_defconfig
+++ b/configs/xilinx_mbv64_smode_defconfig
@@ -8,6 +8,7 @@ CONFIG_DEFAULT_DEVICE_TREE="xilinx-mbv64"
 CONFIG_SPL_STACK=0x80200000
 CONFIG_SPL_BSS_START_ADDR=0x84000000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SPL_SIZE_LIMIT=0x40000
 CONFIG_SPL=y
