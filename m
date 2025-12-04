Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3D8D1F9DD
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BA2F840D7;
	Thu,  4 Dec 2025 13:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kGlAv4fU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BC9683FE9; Thu,  4 Dec 2025 11:26:50 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D18B983FE6
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 11:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b76b5afdf04so108420166b.1
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 02:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764844002; x=1765448802;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lovfR9kk73gjIY+JdQ985NkL6w9bp2wOSMyRYQvcPlY=;
 b=kGlAv4fUxV1JXe26zNFbbJGOd8DHy7evifsv5oWmWJSTDGYZi1okRH480ylu/Imo0S
 FZB28yneDeqSq87SZTf4kiU0tlJRYeeKDxNbeD87Cdk2YaYUAlPExu2HbaK1CZtASUKK
 pS1mri77hzNgcXejkz3EIxFvRAkJH9gNYlJGMNCqFwSPbxOnLYTn9NyhqYAytYW1t8ZH
 +r1ZOhx0IL4PJtxJ+zbld4YTiUKnqrmtYXW4TT3P6q9rBm6Kmo1UA1rVb/Vi9wxzsHj+
 i/TRXuYIjqy2Bi6geklV9NE191c/hdOfSfK3AsYjSM+kqPfEDStZeKUQBusmVhXLtUOP
 0Rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764844002; x=1765448802;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lovfR9kk73gjIY+JdQ985NkL6w9bp2wOSMyRYQvcPlY=;
 b=XuVaFLTcdhB04BuJyfyl9n4NbzG4yati4w+ox0bAmuN/EpoUclhTFm1otadsFHKded
 Uj/C6YHOrpKLthfJTBkspOzte9G9jHdtI3RS0KyAVGPPHUU9WW0yvIqEEhlzyIJRPBtU
 3qX1lM61LK0mSvdaysaL6DEF2najGkEXs4HlG6wEXVm4HeonSCaRxrxsXTwKbyyWjbbl
 Uj3mLs3Rn06JwBpeYKCvA75VErDxMF7QKC79rCEUfqb713PDjo4NcBHjBaCQ/8/QaO/p
 HQR5TxvNV2QlMLbfjheRtwtl7DsXeyZzCSSzpUEVFVfe+SPDx/mmjzhDXvVxS8vMq7Sd
 fDAg==
X-Gm-Message-State: AOJu0Yxd3HVgoqVFnt2DbQKGGJLF87e1JJncty22g9uB/qVmugZ6q4ZF
 YctISynpQ41ps7EcGCzqRDk4YzDCK4U9EGaM7t9y2Cd1nU0ILfgUx9Qfw9er02a0oMI=
X-Gm-Gg: ASbGncug7hV4IqhNArpt+W6z/XM/EhqBcINK12fSzX7lX8ddTXPIghdq/n7YD1xf+va
 d4C9/b+ybQIWn+jd3Z/WIuJiCi/7qM96PbveLZQFEC31qKpJrgt2aZOXEezgKGSol5XFuQRgwKa
 TrGNhQ8YtBHFlvMs06oyfgFN9xH1D6KTJLe2EczLC4KKprHCqihLNnTFHtyeKniukHK/Cf+BrGh
 jO7AgR9FqrRAsOdiYAZ8DjqOYicujsAQbx8qy8BwzS/0qJ5PmRnnFT8S3cSvu6LNeU9BmdJy9nq
 gbTK6mwEi0s7Zp0migYJ+t8v2KsKrhGM/H08sFKi2RxnW7M0HfiVhQ4udKJFER8J1Pnajm2pnVj
 VpgzWDYO4deB+M95Nvzq5va5J96bcg2g4PzhihWSOZyfOCwHoTAu9EaA+kkACRr2ub+bAqozhf3
 mh5BGb640=
X-Google-Smtp-Source: AGHT+IEcU0GNxeKJmNJVN44nLtYLNrg71xBNoCgLPbV99WQbskmmmkoSu7/e3SKOpUeCLj61ZOnJzw==
X-Received: by 2002:a17:907:6e91:b0:b70:df0d:e2e9 with SMTP id
 a640c23a62f3a-b79dc76d523mr616151266b.44.1764844002247; 
 Thu, 04 Dec 2025 02:26:42 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f4975c88sm89430766b.35.2025.12.04.02.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 02:26:41 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 04 Dec 2025 11:25:45 +0100
Subject: [PATCH v3 9/9] configs: am335x_evm_defconfig: Switch to upstream
 devicetree
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-topic-am33-evm-oftree-v2026-01-v3-9-3d1566ce4dc7@baylibre.com>
References: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
In-Reply-To: <20251204-topic-am33-evm-oftree-v2026-01-v3-0-3d1566ce4dc7@baylibre.com>
To: u-boot@lists.denx.de, Marc Murphy <marc.murphy@sancloud.com>
Cc: Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>, 
 Paul Barker <paul.barker@sancloud.com>, "Andrew F. Davis" <afd@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4612; i=msp@baylibre.com;
 h=from:subject:message-id; bh=JsLpW7uodswfYJMA71vrO+SAKUs1c0Gbt3Kriu00++8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzDxMvTJ5u/NPi99Pmdt5XTthTcyF25uX7RRKf7l5fsy
 gncapxn2VHKwiDGxSArpsjSmRia9l9+57HkRcs2w8xhZQIZwsDFKQATeWbKyPA/O/CM6gKxLUe+
 dgqKMGTevLTFfbH+/Nvrep0k/G/v0uNhZGjkUTucPu/GAfmrxZlH3GW25O9W2XNg9abVO4/3sy9
 drMMKAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:52:18 +0100
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

The upstream devicetree uses simple-pm-bus, so CONFIG_POWER_DOMAIN is
required now. CONFIG_POWER_DOMAIN enables probing power domains, the PRM
power domain driver is requierd as well now.

This switches all evm defconfig variants to use the upstream devicetree.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 configs/am335x_evm.config            | 6 +++++-
 configs/am335x_evm_defconfig         | 2 +-
 configs/am335x_evm_spiboot_defconfig | 2 +-
 configs/am335x_hs_evm.config         | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/configs/am335x_evm.config b/configs/am335x_evm.config
index ba39ae274c4095a61f2d102f0bc3de6d0637f53a..6d0b02c3d80c58a19cf6e4390eaec4e2dedd95c6 100644
--- a/configs/am335x_evm.config
+++ b/configs/am335x_evm.config
@@ -3,7 +3,10 @@ CONFIG_ARCH_CPU_INIT=y
 CONFIG_ARCH_OMAP2PLUS=y
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SF_DEFAULT_SPEED=24000000
-CONFIG_DEFAULT_DEVICE_TREE="am335x-evm"
+CONFIG_DEFAULT_DEVICE_TREE="ti/omap/am335x-evm"
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_OMAP_PRM_POWER_DOMAIN=y
+CONFIG_SIMPLE_PM_BUS=y
 CONFIG_AM33XX=y
 CONFIG_CLOCK_SYNTHESIZER=y
 CONFIG_SYS_BOOTM_LEN=0x1000000
@@ -12,6 +15,7 @@ CONFIG_TIMESTAMP=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_BOARD_SETUP=y
+CONFIG_OF_UPSTREAM=y
 CONFIG_BOOTCOMMAND="run findfdt; run init_console; run finduuid; run distro_bootcmd"
 CONFIG_LOGLEVEL=3
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
diff --git a/configs/am335x_evm_defconfig b/configs/am335x_evm_defconfig
index 448b0a8308fcca04732b81313c72f7fd2247d1ca..9281178f914085b199e3d35e95d0ce1f3c0faaa5 100644
--- a/configs/am335x_evm_defconfig
+++ b/configs/am335x_evm_defconfig
@@ -24,7 +24,7 @@ CONFIG_CMD_SPL_NAND_OFS=0x00080000
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
-CONFIG_OF_LIST="am335x-evm am335x-bone am335x-sancloud-bbe am335x-sancloud-bbe-lite am335x-sancloud-bbe-extended-wifi am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
+CONFIG_OF_LIST="ti/omap/am335x-evm ti/omap/am335x-bone ti/omap/am335x-sancloud-bbe ti/omap/am335x-sancloud-bbe-lite ti/omap/am335x-sancloud-bbe-extended-wifi ti/omap/am335x-boneblack ti/omap/am335x-evmsk ti/omap/am335x-bonegreen ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle ti/omap/am335x-bonegreen-eco"
 CONFIG_SPL_ENV_IS_NOWHERE=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
diff --git a/configs/am335x_evm_spiboot_defconfig b/configs/am335x_evm_spiboot_defconfig
index eebd916c02a2cad0d01ab738aab37b11dd3a9645..bbaca6c8800baf19377a457e49db446159e338a8 100644
--- a/configs/am335x_evm_spiboot_defconfig
+++ b/configs/am335x_evm_spiboot_defconfig
@@ -12,7 +12,7 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
+CONFIG_OF_LIST="ti/omap/am335x-evm ti/omap/am335x-bone ti/omap/am335x-boneblack ti/omap/am335x-evmsk ti/omap/am335x-bonegreen ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle ti/omap/am335x-bonegreen-eco"
 # CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SPL_ENV_IS_NOWHERE=y
diff --git a/configs/am335x_hs_evm.config b/configs/am335x_hs_evm.config
index 7ade2fb163b204ad8bcc9554455fdd3e81657890..0bc8556b1d4b18a413ecd6879ab85be54f2730ef 100644
--- a/configs/am335x_hs_evm.config
+++ b/configs/am335x_hs_evm.config
@@ -8,7 +8,7 @@ CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_MTDIDS_DEFAULT="nand0=nand.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=nand.0:128k(NAND.SPL),128k(NAND.SPL.backup1),128k(NAND.SPL.backup2),128k(NAND.SPL.backup3),256k(NAND.u-boot-spl-os),1m(NAND.u-boot),128k(NAND.u-boot-env),128k(NAND.u-boot-env.backup1),8m(NAND.kernel),-(NAND.file-system)"
-CONFIG_OF_LIST="am335x-evm am335x-bone am335x-boneblack am335x-evmsk am335x-bonegreen am335x-icev2 am335x-pocketbeagle am335x-bonegreen-eco"
+CONFIG_OF_LIST="ti/omap/am335x-evm ti/omap/am335x-bone ti/omap/am335x-boneblack ti/omap/am335x-evmsk ti/omap/am335x-bonegreen ti/omap/am335x-icev2 ti/omap/am335x-pocketbeagle ti/omap/am335x-bonegreen-eco"
 CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_SPL_TINY_MEMSET=y
 CONFIG_RSA=y

-- 
2.51.0

