Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D937C83F10
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 08:27:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B219A8006D;
	Sat, 12 Jul 2025 10:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=on-the-web.ch header.i=@on-the-web.ch header.b="cDZquoJ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A916800D7; Sat, 12 Jul 2025 10:27:20 +0200 (CEST)
Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch
 [109.224.244.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98E668003E
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 10:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=on-the-web.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sputnik@on-the-web.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
 s=protonmail3; t=1752308838; x=1752568038;
 bh=rDJ4EQhu6RWc/0E0CmNsYM16C2arYB1/p41fRrFrfNg=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=cDZquoJ7QMGnpQYKWrILKV596ihh/lyjeQZrTMMDybsKEXewkc3mBZukOLvoNp284
 CSKAoBZYagcXmjHHxzjF0BXoEh6tcnFEIEYjE6i4B1dHDbJiOiBrjiBcgUlQncJWFR
 AyfOw97Dj47D++eTiIEo9Wm0Ybtt4erT48+cFKsp28FDf+DtOGM3zRri2Jq8A2b2wa
 ijLj3HtSSVMkrFJ4Zo/qR13vZbv1zgpqpcjSVP1voW4exTJih+YHfycBmQG6gCmqVu
 cDQXGnQN70F+MdNR5DpP9htCs/ymK6TBfogLTpJEj5tq4e353ZRVNVA+NFK1CBT2KE
 ZNk/eneLZmdjw==
Date: Sat, 12 Jul 2025 08:27:10 +0000
To: u-boot@lists.denx.de
From: Martin Herren <sputnik@on-the-web.ch>
Cc: Martin Herren <sputnik@on-the-web.ch>,
 Conor Dooley <conor.dooley@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] riscv: Set SYS_BOOTM_LEN explicitly to 0x800000
Message-ID: <20250712082540.14091-2-sputnik@on-the-web.ch>
In-Reply-To: <20250712082540.14091-1-sputnik@on-the-web.ch>
References: <20250712082540.14091-1-sputnik@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: ff876d817e958617cb47ecb32bfefd3432f06f06
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------d1ae378d81ab611ed9114281e021e89f89630d1d89c90f9f026fd68193e38772";
 charset=utf-8
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------d1ae378d81ab611ed9114281e021e89f89630d1d89c90f9f026fd68193e38772
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
	Sean Anderson <seanga2@gmail.com>,
	Simon Glass <sjg@chromium.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] riscv: Set SYS_BOOTM_LEN explicitly to 0x800000
Date: Sat, 12 Jul 2025 10:25:21 +0200
Message-ID: <20250712082540.14091-2-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250712082540.14091-1-sputnik@on-the-web.ch>
References: <20250712082540.14091-1-sputnik@on-the-web.ch>
MIME-Version: 1.0

For all riscv defconfigs that use the current default value.

This is done in provision of changing the default value to the most
common used value of 0x4000000.

Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
---

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
 CONFIG_ENV_SECT_
SIZE=0x1000
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
 CONFI
G_SPL_SIZE_LIMIT=0x40000
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

--------d1ae378d81ab611ed9114281e021e89f89630d1d89c90f9f026fd68193e38772
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmhyHFsJkIiu+thqKlAPNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdMi79vgi0tMegghqB4ViFxFiEEJgeVlthQxcLg
gu1biK762GoqUA8AAN8DAP4mNx9xN4XNLYcFK0tu7czEsb/IeMVe0yjLr5is
QSfARwD/f7VfQq9Ul5HBVq2GFzi6Oyig0E6p8m3Q8rFY10reDAw=
=bD/u
-----END PGP SIGNATURE-----


--------d1ae378d81ab611ed9114281e021e89f89630d1d89c90f9f026fd68193e38772--

