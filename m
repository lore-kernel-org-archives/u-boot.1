Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D61FF886F
	for <u-boot@archiver.kernel.org>; Sun,  3 May 2026 20:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 096D3845C8;
	Sun,  3 May 2026 22:50:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K33k5E8A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 807888460B; Sun,  3 May 2026 22:50:08 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BCF1845C8
 for <u-boot@lists.denx.de>; Sun,  3 May 2026 22:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6948d7ccfbbso1425533eaf.1
 for <u-boot@lists.denx.de>; Sun, 03 May 2026 13:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777841403; x=1778446203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ES1Ix+Z6CP9gnqza070k1M3DXySwxSuWpyBRwFq/fo=;
 b=K33k5E8A+psKjRgthdonT/fh1964AIge0ATXlIcPXY62Sdim788dzeddm6a9WYL7zR
 rLEpJpkaLTFJOsx0YV1suhFV0x+cVAJb52qHYYhk7qlefCBM6eQB7pobauRxfw9bc/dP
 WQWFlvK9lHK0R2lQ5yz9z4LpXxY0J20RFbvVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777841403; x=1778446203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ES1Ix+Z6CP9gnqza070k1M3DXySwxSuWpyBRwFq/fo=;
 b=Qg9jy6TIAKfd1rCs73V5m0w/0ngdSmt08EtyhwKu92TR34ntyVC6FZYBBLcWvWErAI
 GNQHJb7oMwg4EBJSP1CKJ0p0UBcTQ+PteaZOmnpjLIpBCdPXHIsQTp7F5kml6RP54RfD
 9GaPY2PUY6uwgivMWDu3tS/HCKL8bjEgKyAlSNMYtcasdrEBecpXS6F6Z/oa2xE1lSae
 pPjds22lb34R/5JHz8EdTkh5qCxCVPF2xCkQlscGd3GQNa8ScrpR7WuhaedDgTJSemXn
 EjTcwbDNk42GIJ2Nr/ju3RN3sKiUIi+B04tWVVXtNPYMn5Wc9IOa5j/Hqv+iPoLE4EpY
 Ul5Q==
X-Gm-Message-State: AOJu0YyIBnM1dtin25ATnfLPXoDukjkzxFkQiwgAH/P5iVNdZ63XFDiQ
 8XBylwAWn+sAFWqXNoxdsxeFnx99ilG2WoAifPz6/PZBMI0rUNCv6YBQy+ZawdYrNy9VMCTVjX2
 3HYOEZQ==
X-Gm-Gg: AeBDietF2IqPdnWsduo++WgeXcUvVo3ImcH2KlACbxI8SCyC6t1m9WBkRzoJEX8TPiN
 6P5CJjO6P1lelTAt43rkbkLbbHeg24Ajkn0qJtu7ahZTQf0UpQVJ90yUbINLrIz6mUsSePzWi+f
 P9SwuexHi2n1MCZ8StkJSpqva1QIPdeJSqkxlx27acjbXu3rN0yxZq7k0eP2TJyR9ZCENcrTRTB
 bVuyM/HcJZlSeduP1RFJKwMsaG+KBjqNJkhHoINb1nx3yUIbwYjEcetPHet13AioBuFnl5VNQAc
 4O+jHvQJIrbiF8wOl7Mh4NqK88I6vC6K0aslbSRiZFgOfMhprWda/A/wTQN1ft+rl91RP+gXS1X
 C6KLo7LsmQCs/0cD9HOJgB/27CDiMaKSWkryMLAXx6AMkVK289FwSUSoMmsiv5aDdiYCCFdB2Zd
 DFaDsdkJ+0gnYOfCDqrAPVBLnNqdLuECVdtaI4w3k=
X-Received: by 2002:a05:6820:2d4a:b0:696:924d:2959 with SMTP id
 006d021491bc7-69697c2f8b9mr3746089eaf.16.1777841403184; 
 Sun, 03 May 2026 13:50:03 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696aacbb5bbsm1142940eaf.15.2026.05.03.13.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 13:50:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Alice Guo <alice.guo@nxp.com>,
 Andrew Davis <afd@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Bryan Brattlof <bb@ti.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, Peng Fan <peng.fan@nxp.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 1/6] toradex: Quote fdtfile in preboot test
Date: Sun,  3 May 2026 14:49:19 -0600
Message-ID: <20260503204936.3151124-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503204936.3151124-1-sjg@chromium.org>
References: <20260503204936.3151124-1-sjg@chromium.org>
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

The 15 Toradex defconfigs (apalis-imx8, apalis_imx6, the colibri
imx6/imx6ull/imx7/imx8x/vf families, the toradex-smarc-imx8mp/imx95
boards and the verdin am62/am62p/imx8mm/imx8mp boards) all carry the
same preboot expression:

    test -n ${fdtfile} || setenv fdtfile ...

When fdtfile is empty, the unquoted variable expands to nothing and
the command becomes 'test -n' with no operand, relying on a U-Boot
'test' quirk that treats a missing operand as false so the '||'
fallback runs and sets the DTB name.

Quote the variable so an empty fdtfile expands to 'test -n ""' (two
operands, three argv) and the emptiness check is explicit.

Fixes: 8b0619579b22 ("cmd: test: fix handling of single-argument form of test")
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/apalis-imx8_defconfig          | 2 +-
 configs/apalis_imx6_defconfig          | 2 +-
 configs/colibri-imx6ull-emmc_defconfig | 2 +-
 configs/colibri-imx6ull_defconfig      | 2 +-
 configs/colibri-imx8x_defconfig        | 2 +-
 configs/colibri_imx6_defconfig         | 2 +-
 configs/colibri_imx7_defconfig         | 2 +-
 configs/colibri_imx7_emmc_defconfig    | 2 +-
 configs/colibri_vf_defconfig           | 2 +-
 configs/toradex-smarc-imx8mp_defconfig | 2 +-
 configs/toradex-smarc-imx95_defconfig  | 2 +-
 configs/verdin-am62_a53_defconfig      | 2 +-
 configs/verdin-am62p_a53_defconfig     | 2 +-
 configs/verdin-imx8mm_defconfig        | 2 +-
 configs/verdin-imx8mp_defconfig        | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/configs/apalis-imx8_defconfig b/configs/apalis-imx8_defconfig
index 6ab4dd3dc57..17090ac682b 100644
--- a/configs/apalis-imx8_defconfig
+++ b/configs/apalis-imx8_defconfig
@@ -25,7 +25,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-apalis${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile ${soc}-apalis${variant}-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2068
 CONFIG_LOG=y
diff --git a/configs/apalis_imx6_defconfig b/configs/apalis_imx6_defconfig
index cd9811aca61..791be4df283 100644
--- a/configs/apalis_imx6_defconfig
+++ b/configs/apalis_imx6_defconfig
@@ -31,7 +31,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_BOOTCOMMAND="run distro_bootcmd; usb start; setenv stdout serial,vidconsole; setenv stdin serial,usbkbd"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6q-apalis${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx6q-apalis${variant}-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=1024
 CONFIG_SYS_PBSIZE=1055
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
diff --git a/configs/colibri-imx6ull-emmc_defconfig b/configs/colibri-imx6ull-emmc_defconfig
index 439ddeb8f0b..c54ff48fdf7 100644
--- a/configs/colibri-imx6ull-emmc_defconfig
+++ b/configs/colibri-imx6ull-emmc_defconfig
@@ -18,7 +18,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6ull-colibri${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx6ull-colibri${variant}-${fdt_board}.dtb"
 CONFIG_SYS_PBSIZE=547
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/colibri-imx6ull_defconfig b/configs/colibri-imx6ull_defconfig
index 1c400f9534d..cda7a6ada3a 100644
--- a/configs/colibri-imx6ull_defconfig
+++ b/configs/colibri-imx6ull_defconfig
@@ -21,7 +21,7 @@ CONFIG_BOOTDELAY=1
 CONFIG_OF_ENV_SETUP=y
 CONFIG_BOOTCOMMAND="run ubiboot || run distro_bootcmd;"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6ull-colibri${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx6ull-colibri${variant}-${fdt_board}.dtb"
 CONFIG_SYS_PBSIZE=547
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/colibri-imx8x_defconfig b/configs/colibri-imx8x_defconfig
index fd6a6b47fcf..3300922b172 100644
--- a/configs/colibri-imx8x_defconfig
+++ b/configs/colibri-imx8x_defconfig
@@ -26,7 +26,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile ${soc}-colibri-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2068
 CONFIG_LOG=y
diff --git a/configs/colibri_imx6_defconfig b/configs/colibri_imx6_defconfig
index 0f5abb51f76..34037e1c134 100644
--- a/configs/colibri_imx6_defconfig
+++ b/configs/colibri_imx6_defconfig
@@ -30,7 +30,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_BOOTCOMMAND="run distro_bootcmd; usb start; setenv stdout serial,vidconsole; setenv stdin serial,usbkbd"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx6dl-colibri${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx6dl-colibri${variant}-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=1024
 CONFIG_SYS_PBSIZE=1056
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
diff --git a/configs/colibri_imx7_defconfig b/configs/colibri_imx7_defconfig
index 2a3cb84c3b6..8a84f49f42f 100644
--- a/configs/colibri_imx7_defconfig
+++ b/configs/colibri_imx7_defconfig
@@ -22,7 +22,7 @@ CONFIG_BOOTDELAY=1
 CONFIG_OF_ENV_SETUP=y
 CONFIG_BOOTCOMMAND="run ubiboot ; echo ; echo ubiboot failed ; run distro_bootcmd;"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri${variant}-${fdt_board}.dtb "
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile ${soc}-colibri${variant}-${fdt_board}.dtb "
 CONFIG_SYS_PBSIZE=544
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/colibri_imx7_emmc_defconfig b/configs/colibri_imx7_emmc_defconfig
index a95a3214d0c..4c661d4cda1 100644
--- a/configs/colibri_imx7_emmc_defconfig
+++ b/configs/colibri_imx7_emmc_defconfig
@@ -19,7 +19,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile ${soc}-colibri${variant}-${fdt_board}.dtb"
 CONFIG_SYS_PBSIZE=544
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/colibri_vf_defconfig b/configs/colibri_vf_defconfig
index 1364fe45291..4ce14baef4f 100644
--- a/configs/colibri_vf_defconfig
+++ b/configs/colibri_vf_defconfig
@@ -23,7 +23,7 @@ CONFIG_FDT_FIXUP_PARTITIONS=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="run ubiboot || run distro_bootcmd;"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile ${soc}-colibri-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile ${soc}-colibri-${fdt_board}.dtb"
 CONFIG_SYS_PBSIZE=1056
 CONFIG_LOGLEVEL=3
 # CONFIG_DISPLAY_BOARDINFO is not set
diff --git a/configs/toradex-smarc-imx8mp_defconfig b/configs/toradex-smarc-imx8mp_defconfig
index 13a0e5f028b..7be67df3130 100644
--- a/configs/toradex-smarc-imx8mp_defconfig
+++ b/configs/toradex-smarc-imx8mp_defconfig
@@ -40,7 +40,7 @@ CONFIG_BOOTDELAY=1
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="bootflow scan -b"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx8mp-toradex-smarc-dev.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx8mp-toradex-smarc-dev.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2081
 CONFIG_LOG=y
diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
index 61abeff1afb..144d8501ce7 100644
--- a/configs/toradex-smarc-imx95_defconfig
+++ b/configs/toradex-smarc-imx95_defconfig
@@ -37,7 +37,7 @@ CONFIG_BOOTDELAY=1
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTCOMMAND="bootflow scan -b"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx95-toradex-smarc-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx95-toradex-smarc-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_LOG=y
diff --git a/configs/verdin-am62_a53_defconfig b/configs/verdin-am62_a53_defconfig
index f04858099da..3f3cd2a53b1 100644
--- a/configs/verdin-am62_a53_defconfig
+++ b/configs/verdin-am62_a53_defconfig
@@ -34,7 +34,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile k3-am625-verdin-${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile k3-am625-verdin-${variant}-${fdt_board}.dtb"
 CONFIG_LOG=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/verdin-am62p_a53_defconfig b/configs/verdin-am62p_a53_defconfig
index 3dbffa78662..6cca7427485 100644
--- a/configs/verdin-am62p_a53_defconfig
+++ b/configs/verdin-am62p_a53_defconfig
@@ -36,7 +36,7 @@ CONFIG_BOOTDELAY=1
 CONFIG_OF_BOARD_SETUP_EXTENDED=y
 CONFIG_BOOTCOMMAND="bootflow scan -b"
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile k3-am62p5-verdin-${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile k3-am62p5-verdin-${variant}-${fdt_board}.dtb"
 CONFIG_LOG=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index 45437205837..88f337bd347 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -33,7 +33,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx8mm-verdin-${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx8mm-verdin-${variant}-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2081
 CONFIG_LOG=y
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index 455a601b07d..368bd4aeeeb 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -38,7 +38,7 @@ CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=1
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_PREBOOT=y
-CONFIG_PREBOOT="test -n ${fdtfile} || setenv fdtfile imx8mp-verdin-${variant}-${fdt_board}.dtb"
+CONFIG_PREBOOT="test -n \"${fdtfile}\" || setenv fdtfile imx8mp-verdin-${variant}-${fdt_board}.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2081
 CONFIG_LOG=y
-- 
2.43.0

