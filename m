Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2536FC83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8460283046;
	Mon, 14 Jul 2025 15:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=smtpservice.net header.i=@smtpservice.net header.b="S+zbOMI1";
	dkim=pass (2048-bit key; unprotected) header.d=on-the-web.ch header.i=@on-the-web.ch header.b="DAcnI4Jc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F174783102; Mon, 14 Jul 2025 15:34:56 +0200 (CEST)
Received: from a4i432.smtp2go.com (a4i432.smtp2go.com [158.120.81.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D18383045
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:34:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounce.7sif68zxyym72w3=x6a6fzh9g8nj=7xvjrvtzqcczmj@em923567.on-the-web.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752500083; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=FhoiO2djhS1mYq9jR5HGI/i7PEat7yxE9/NC0QX8C7M=;
 b=S+zbOMI15Y5KjIy90v0CN3oliohP5jpZ9WaLBcVBQF6fEMCI5QiO+gsAEm/hkB3xw7r7U
 hMdCUnS39gQwgdx6oyBL8zayjT0YViWo3ehvADufMgrP56g9qPwQgPzpH0FhAOdqlyoJoMe
 3vR4gr6fV8pmTyhWEe5YDnzerIzStliFLHYZgSZnJidHVvkjou9DH3fzR9i+FqD89dzpQYe
 /f7+l2QlGyD6pAT6p2S5k3pCOfZ5FSBlGNFopfjIDJMHI/kxExUyPp36jaxJvrRFTB/DZn9
 61eJkam4orik2dp2dkRdB6+KLQFi8X0c7Knkm9NZV7dZKqT8Xzln0WZNwmUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
 i=@on-the-web.ch; q=dns/txt; s=s923567; t=1752500083; h=from : subject
 : to : message-id : date;
 bh=FhoiO2djhS1mYq9jR5HGI/i7PEat7yxE9/NC0QX8C7M=;
 b=DAcnI4JcJb2ybyroX0m5Ttj9Y9+ak1ARbXfbUkiV0NlbfIGRM18wO9dekIa8uiBqH4TAy
 rmzWn0bGxo2o6J2iy9gqPeyzZwfxShyE3p9y9Di24ZQPoES3UB+1/bsUJXXoC+Q9vRTq225
 Hv4eQUWUQGAybG9ibxnRp6+ZcY4w4uQwdGo5NhB0zG61SVjUDs+EivIZu9A5M3TpDHTztbN
 P/M2tn7rmGPcFLRpgJArfgMQTKhnYDliUEQe302M2PcaxOSgbGuxN6sAwryf4GhhXwHCrhf
 SQUuGmVUZ/RlXG1CgppMm4fOkY7qJuraa+vZOPOW19Np3NOMR1sYQMRAk6Iw==
Received: from [10.114.245.143] (helo=ch-web-troubles-5500.dynv6.net)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <sputnik@on-the-web.ch>)
 id 1ubJKE-FnQW0hPlLyG-mMkd; Mon, 14 Jul 2025 13:34:34 +0000
From: Martin Herren <sputnik@on-the-web.ch>
To: u-boot@lists.denx.de
Cc: Martin Herren <sputnik@on-the-web.ch>,
 Conor Dooley <conor.dooley@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] riscv: Set SYS_BOOTM_LEN explicitly to 0x800000
Date: Mon, 14 Jul 2025 15:33:10 +0200
Message-ID: <20250714133345.128853-2-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714133345.128853-1-sputnik@on-the-web.ch>
References: <20250714133345.128853-1-sputnik@on-the-web.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 923567m:923567atSSOWT:923567sL24q2itR4
X-smtpcorp-track: R2XO8ueLPx5J.VR1FQyOURTvC.0J5gEAVlWYd
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
index bb110225488..8616780f2b4 100644
--- a/configs/microchip_mpfs_icicle_defconfig
+++ b/configs/microchip_mpfs_icicle_defconfig
@@ -5,6 +5,7 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
 CONFIG_ENV_SIZE=0x2000
 CONFIG_DEFAULT_DEVICE_TREE="microchip/mpfs-icicle-kit"
+CONFIG_SYS_BOOTM_LEN=0x800000
 CONFIG_SYS_LOAD_ADDR=0x80200000
 CONFIG_SYS_MEM_TOP_HIDE=0x400000
 CONFIG_TARGET_MICROCHIP_ICICLE=y
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
