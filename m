Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC2EC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B487681ECD;
	Fri, 28 Mar 2025 17:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gyiHVFmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F35CA820A1; Fri, 28 Mar 2025 16:36:45 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9FE3820AA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-85d9a87660fso184047739f.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743176198; x=1743780998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xF+xQeUHrhIsxpOWKNAYCYyNpAoae7apTz5NZkFUvw0=;
 b=gyiHVFmEPvdgMD7OyXSSS7O/DD6kT6NpaN2XQgkqqLgan8lAEyJrSTocaJy862rXx8
 RzVxUOw5oFtQsmr8CxCXwIoQCAgZ+U08Z9b+HvRyiS5zgC4++5Y/1J+WhemMkswJmCw4
 xGeql654DaRjBgXwvIqPqNzt6kRI4EqqHU5es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743176198; x=1743780998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xF+xQeUHrhIsxpOWKNAYCYyNpAoae7apTz5NZkFUvw0=;
 b=lSPaVMRT+nNK7ZjvSGYrmrj8vPdPviR+99dWYwwP7PzraIIFRsFNdxua8Rm5jc2VCh
 Rgu0J5fBscINi3vta5CIlo0m7fZ3lYvei+z5kfCUMYNthEzW79BLikMDs45lyDdPgw6v
 CE/zY7L+L9FYz7ddx6kQmg1GdcfrEcUGyF4+aLRN7sjmMgXf/iJvBHTRlnIZyskYitDK
 JjEqboY+q2FpR56bDdjd/igGLiSkqz09WrWZbb4+MplB9wpNQI9vCNgfTb6AYqrr2wHW
 w1h3IJZrP9FT4/gjjXnHI9IyzUErVcgDzKmeZPxFDdpCZch/VNDEIXqNNuGUU8b/VRHn
 T2UA==
X-Gm-Message-State: AOJu0YziVy4mWNBc4GmI7owcKL5f7tx5K41UYhqv0LPzddYmjjWFLXAv
 +Uq/bbuNZ6arZ6udna8i31UVThLUVvv8o8mvIvrdHrJJBLfAYIilt4WiyQm0Woj3mhVrsi+qipk
 =
X-Gm-Gg: ASbGncs/maQJrr465CYpWGRC4VkECW/+yOhFIrEqsdC2kM+RCYSxnH1cRtq3EnnZpLj
 60KZHuEQ2HnR8/7EiBy3uCRbkzkfdb5C5j27RJvgomlEzGDRRpDF1tYBojRz2YdmdNQB9G3kRr7
 BRPpsln5kLjXQM7h1LDRO2emDFEZscd1D+DGtHx1wJos1Siv1D8rpvd0BTIWAX7GUlrfVv9Wjnz
 2+mXiAXnbMkRUn7viINQBizH9wkcZOuuC3mGUVGedyTGSh4JWXtVvPOaH9vIBRsJtrlYnlRpIhS
 kuE6Yf7wFrqMfabr9iKgti5pXmMN05sHAYL/U6YlpxtbAPr1DkqtS+w36LF7w9Kk72XODyAGJmd
 My5jkCQ==
X-Google-Smtp-Source: AGHT+IHMW7vJBBdsJ1uY2t5IdjTTnZ59mKRWJDqhwLUbGKQYxIaNySV0tgPFOnvpgWqNI2hPwMDjAQ==
X-Received: by 2002:a05:6602:3788:b0:85d:9ea6:59a6 with SMTP id
 ca18e2360f4ac-85e82084400mr1010824139f.5.1743176197601; 
 Fri, 28 Mar 2025 08:36:37 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f4648714b4sm484922173.87.2025.03.28.08.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 08:36:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexandre Vicenzi <linux@alxd.me>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anand Moon <anand@edgeble.ai>,
 Andy Yan <andyshrk@163.com>, Banglang Huang <banglang.huang@foxmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Christopher Obbard <chris.obbard@collabora.com>,
 David Bauer <mail@david-bauer.net>, Dragan Simic <dsimic@manjaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>,
 Joshua Riek <jjriek@verizon.net>, Loic Devulder <ldevulder@suse.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Sebastian Kropatsch <seb-dev@mail.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Suniel Mahesh <sunil@amarulasolutions.com>,
 Tianling Shen <cnsztl@gmail.com>, Tim Lunn <tim@feathertop.org>,
 Tom Rini <trini@konsulko.com>, Wadim Egorov <w.egorov@phytec.de>,
 Xiaobo Tian <peterwillcn@gmail.com>, huang lin <hl@rock-chips.com>
Subject: [PATCH v3 26/31] rockchip: Set the skip-at-start property correctly
Date: Fri, 28 Mar 2025 09:35:06 -0600
Message-ID: <20250328153522.3555472-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328153522.3555472-1-sjg@chromium.org>
References: <20250328153522.3555472-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 28 Mar 2025 17:14:05 +0100
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

The rockchip image is written to the media at block 64, which is a 32K
offset, so set the skip-at-start property to 0x8000

Update CONFIG_SPL_PAD_TO to point to the offset in the image, since
Binman is dealing with the 'missing' 32K now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Move this patch to the end of the series
- Drop 0x8000 offset for SPI

 arch/arm/dts/rockchip-u-boot.dtsi             | 1 +
 configs/anbernic-rgxx3-rk3566_defconfig       | 2 +-
 configs/bpi-r2-pro-rk3568_defconfig           | 2 +-
 configs/chromebit_mickey_defconfig            | 2 +-
 configs/chromebook_bob_defconfig              | 2 +-
 configs/chromebook_jerry_defconfig            | 2 +-
 configs/chromebook_kevin_defconfig            | 2 +-
 configs/chromebook_minnie_defconfig           | 2 +-
 configs/chromebook_speedy_defconfig           | 2 +-
 configs/cm3588-nas-rk3588_defconfig           | 2 +-
 configs/coolpi-4b-rk3588s_defconfig           | 2 +-
 configs/coolpi-cm5-evb-rk3588_defconfig       | 2 +-
 configs/coolpi-cm5-genbook-rk3588_defconfig   | 2 +-
 configs/eaidk-610-rk3399_defconfig            | 2 +-
 configs/evb-px30_defconfig                    | 2 +-
 configs/evb-px5_defconfig                     | 2 +-
 configs/evb-rk3036_defconfig                  | 2 +-
 configs/evb-rk3229_defconfig                  | 2 +-
 configs/evb-rk3288_defconfig                  | 2 +-
 configs/evb-rk3308_defconfig                  | 2 +-
 configs/evb-rk3328_defconfig                  | 2 +-
 configs/evb-rk3399_defconfig                  | 2 +-
 configs/evb-rk3568_defconfig                  | 2 +-
 configs/evb-rk3588_defconfig                  | 2 +-
 configs/ficus-rk3399_defconfig                | 2 +-
 configs/firefly-px30_defconfig                | 2 +-
 configs/firefly-rk3288_defconfig              | 2 +-
 configs/firefly-rk3399_defconfig              | 2 +-
 configs/generic-rk3568_defconfig              | 2 +-
 configs/generic-rk3588_defconfig              | 2 +-
 configs/jaguar-rk3588_defconfig               | 2 +-
 configs/khadas-edge-captain-rk3399_defconfig  | 2 +-
 configs/khadas-edge-rk3399_defconfig          | 2 +-
 configs/khadas-edge-v-rk3399_defconfig        | 2 +-
 configs/khadas-edge2-rk3588s_defconfig        | 2 +-
 configs/kylin-rk3036_defconfig                | 2 +-
 configs/leez-rk3399_defconfig                 | 2 +-
 configs/lubancat-2-rk3568_defconfig           | 2 +-
 configs/miqi-rk3288_defconfig                 | 2 +-
 configs/mk808_defconfig                       | 2 +-
 configs/nanopc-t4-rk3399_defconfig            | 2 +-
 configs/nanopc-t6-rk3588_defconfig            | 2 +-
 configs/nanopi-m4-2gb-rk3399_defconfig        | 2 +-
 configs/nanopi-m4-rk3399_defconfig            | 2 +-
 configs/nanopi-m4b-rk3399_defconfig           | 2 +-
 configs/nanopi-neo4-rk3399_defconfig          | 2 +-
 configs/nanopi-r2c-plus-rk3328_defconfig      | 2 +-
 configs/nanopi-r2c-rk3328_defconfig           | 2 +-
 configs/nanopi-r2s-plus-rk3328_defconfig      | 2 +-
 configs/nanopi-r2s-rk3328_defconfig           | 2 +-
 configs/nanopi-r3s-rk3566_defconfig           | 2 +-
 configs/nanopi-r4s-rk3399_defconfig           | 2 +-
 configs/nanopi-r5c-rk3568_defconfig           | 2 +-
 configs/nanopi-r5s-rk3568_defconfig           | 2 +-
 configs/nanopi-r6c-rk3588s_defconfig          | 2 +-
 configs/nanopi-r6s-rk3588s_defconfig          | 2 +-
 configs/neu2-io-rv1126_defconfig              | 2 +-
 configs/neu6a-io-rk3588_defconfig             | 2 +-
 configs/neu6b-io-rk3588_defconfig             | 2 +-
 configs/nova-rk3588s_defconfig                | 2 +-
 configs/odroid-go2_defconfig                  | 2 +-
 configs/odroid-m1-rk3568_defconfig            | 2 +-
 configs/odroid-m1s-rk3566_defconfig           | 2 +-
 configs/odroid-m2-rk3588s_defconfig           | 2 +-
 configs/orangepi-3b-rk3566_defconfig          | 2 +-
 configs/orangepi-5-plus-rk3588_defconfig      | 2 +-
 configs/orangepi-5-rk3588s_defconfig          | 2 +-
 configs/orangepi-r1-plus-lts-rk3328_defconfig | 2 +-
 configs/orangepi-r1-plus-rk3328_defconfig     | 2 +-
 configs/orangepi-rk3399_defconfig             | 2 +-
 configs/phycore-rk3288_defconfig              | 2 +-
 configs/pinebook-pro-rk3399_defconfig         | 2 +-
 configs/pinephone-pro-rk3399_defconfig        | 2 +-
 configs/pinetab2-rk3566_defconfig             | 2 +-
 configs/popmetal-rk3288_defconfig             | 2 +-
 configs/powkiddy-x55-rk3566_defconfig         | 2 +-
 configs/puma-rk3399_defconfig                 | 2 +-
 configs/px30-core-ctouch2-of10-px30_defconfig | 2 +-
 configs/px30-core-ctouch2-px30_defconfig      | 2 +-
 configs/px30-core-edimm2.2-px30_defconfig     | 2 +-
 configs/qnap-ts433-rk3568_defconfig           | 2 +-
 configs/quartz64-a-rk3566_defconfig           | 2 +-
 configs/quartz64-b-rk3566_defconfig           | 2 +-
 configs/quartzpro64-rk3588_defconfig          | 2 +-
 configs/radxa-cm3-io-rk3566_defconfig         | 2 +-
 configs/radxa-e25-rk3568_defconfig            | 2 +-
 configs/radxa-zero-3-rk3566_defconfig         | 2 +-
 configs/rk3399-generic-ddr3_defconfig         | 2 +-
 configs/roc-cc-rk3308_defconfig               | 2 +-
 configs/roc-cc-rk3328_defconfig               | 2 +-
 configs/roc-pc-mezzanine-rk3399_defconfig     | 2 +-
 configs/roc-pc-rk3399_defconfig               | 2 +-
 configs/rock-3a-rk3568_defconfig              | 2 +-
 configs/rock-3b-rk3568_defconfig              | 2 +-
 configs/rock-3c-rk3566_defconfig              | 2 +-
 configs/rock-4c-plus-rk3399_defconfig         | 2 +-
 configs/rock-4se-rk3399_defconfig             | 2 +-
 configs/rock-5-itx-rk3588_defconfig           | 2 +-
 configs/rock-5c-rk3588s_defconfig             | 2 +-
 configs/rock-pi-4-rk3399_defconfig            | 2 +-
 configs/rock-pi-4c-rk3399_defconfig           | 2 +-
 configs/rock-pi-e-rk3328_defconfig            | 2 +-
 configs/rock-pi-e-v3-rk3328_defconfig         | 2 +-
 configs/rock-pi-n10-rk3399pro_defconfig       | 2 +-
 configs/rock-pi-n8-rk3288_defconfig           | 2 +-
 configs/rock-pi-s-rk3308_defconfig            | 2 +-
 configs/rock-s0-rk3308_defconfig              | 2 +-
 configs/rock2_defconfig                       | 2 +-
 configs/rock5a-rk3588s_defconfig              | 2 +-
 configs/rock5b-rk3588_defconfig               | 2 +-
 configs/rock64-rk3328_defconfig               | 2 +-
 configs/rock960-rk3399_defconfig              | 2 +-
 configs/rock_defconfig                        | 2 +-
 configs/rockpro64-rk3399_defconfig            | 2 +-
 configs/sige7-rk3588_defconfig                | 2 +-
 configs/sonoff-ihost-rv1126_defconfig         | 2 +-
 configs/soquartz-blade-rk3566_defconfig       | 2 +-
 configs/soquartz-cm4-rk3566_defconfig         | 2 +-
 configs/soquartz-model-a-rk3566_defconfig     | 2 +-
 configs/tiger-rk3588_defconfig                | 2 +-
 configs/tinker-rk3288_defconfig               | 2 +-
 configs/tinker-s-rk3288_defconfig             | 2 +-
 configs/toybrick-rk3588_defconfig             | 2 +-
 configs/turing-rk1-rk3588_defconfig           | 2 +-
 configs/vyasa-rk3288_defconfig                | 2 +-
 125 files changed, 125 insertions(+), 124 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 366d52de4ee..dcebe5d2f2f 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -158,6 +158,7 @@
 	simple-bin {
 		filename = "u-boot-rockchip.bin";
 		pad-byte = <0xff>;
+		skip-at-start = <0x8000>;
 
 #ifndef CONFIG_VPL
 		mkimage {
diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index 14c97b4c5bf..972d4c71b14 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -28,7 +28,7 @@ CONFIG_BOARD_TYPES=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_RNG_SEED=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_POWER=y
diff --git a/configs/bpi-r2-pro-rk3568_defconfig b/configs/bpi-r2-pro-rk3568_defconfig
index d84ea2f955f..e5eaf7f6449 100644
--- a/configs/bpi-r2-pro-rk3568_defconfig
+++ b/configs/bpi-r2-pro-rk3568_defconfig
@@ -19,7 +19,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-bpi-r2-pro.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_SYS_PROMPT="BPI-R2PRO> "
diff --git a/configs/chromebit_mickey_defconfig b/configs/chromebit_mickey_defconfig
index d834c1886a5..fe85ba2f50d 100644
--- a/configs/chromebit_mickey_defconfig
+++ b/configs/chromebit_mickey_defconfig
@@ -36,7 +36,7 @@ CONFIG_LOG=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index 8fbd6fcbf94..47739d0ff67 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -41,7 +41,7 @@ CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
 CONFIG_SPL_MAX_SIZE=0x1e000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_HANDOFF=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/chromebook_jerry_defconfig b/configs/chromebook_jerry_defconfig
index f4b9caeb34f..d268e55f083 100644
--- a/configs/chromebook_jerry_defconfig
+++ b/configs/chromebook_jerry_defconfig
@@ -35,7 +35,7 @@ CONFIG_LOG=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index ff184115311..f00a4529095 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -42,7 +42,7 @@ CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0x100000
 CONFIG_BLOBLIST_SIZE=0x1000
 CONFIG_SPL_MAX_SIZE=0x1e000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_HANDOFF=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/chromebook_minnie_defconfig b/configs/chromebook_minnie_defconfig
index 3a0be3078ab..a31052ca4f8 100644
--- a/configs/chromebook_minnie_defconfig
+++ b/configs/chromebook_minnie_defconfig
@@ -36,7 +36,7 @@ CONFIG_LOG=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/chromebook_speedy_defconfig b/configs/chromebook_speedy_defconfig
index 78ab62c3392..fed4b1d9bde 100644
--- a/configs/chromebook_speedy_defconfig
+++ b/configs/chromebook_speedy_defconfig
@@ -36,7 +36,7 @@ CONFIG_LOG=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_EARLY_INIT_R=y
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/cm3588-nas-rk3588_defconfig b/configs/cm3588-nas-rk3588_defconfig
index fd0a32d6d79..abd60abc177 100644
--- a/configs/cm3588-nas-rk3588_defconfig
+++ b/configs/cm3588-nas-rk3588_defconfig
@@ -21,7 +21,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-friendlyelec-cm3588-nas.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/coolpi-4b-rk3588s_defconfig b/configs/coolpi-4b-rk3588s_defconfig
index ea985b81670..7b90bc59afb 100644
--- a/configs/coolpi-4b-rk3588s_defconfig
+++ b/configs/coolpi-4b-rk3588s_defconfig
@@ -27,7 +27,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-coolpi-4b.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
diff --git a/configs/coolpi-cm5-evb-rk3588_defconfig b/configs/coolpi-cm5-evb-rk3588_defconfig
index 58ffe7baf5f..10d07332ad6 100644
--- a/configs/coolpi-cm5-evb-rk3588_defconfig
+++ b/configs/coolpi-cm5-evb-rk3588_defconfig
@@ -27,7 +27,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-coolpi-cm5-evb.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
diff --git a/configs/coolpi-cm5-genbook-rk3588_defconfig b/configs/coolpi-cm5-genbook-rk3588_defconfig
index 3eb5dc968af..ab867e758cc 100644
--- a/configs/coolpi-cm5-genbook-rk3588_defconfig
+++ b/configs/coolpi-cm5-genbook-rk3588_defconfig
@@ -28,7 +28,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-coolpi-cm5-genbook.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
diff --git a/configs/eaidk-610-rk3399_defconfig b/configs/eaidk-610-rk3399_defconfig
index 8f9a76157f1..7f3215628a4 100644
--- a/configs/eaidk-610-rk3399_defconfig
+++ b/configs/eaidk-610-rk3399_defconfig
@@ -15,7 +15,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-eaidk-610.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
diff --git a/configs/evb-px30_defconfig b/configs/evb-px30_defconfig
index 50dd29fcb01..9335dfd1dad 100644
--- a/configs/evb-px30_defconfig
+++ b/configs/evb-px30_defconfig
@@ -25,7 +25,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/px30-evb.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
diff --git a/configs/evb-px5_defconfig b/configs/evb-px5_defconfig
index c9262417139..9dcf6badc78 100644
--- a/configs/evb-px5_defconfig
+++ b/configs/evb-px5_defconfig
@@ -41,7 +41,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3368-px5-evb.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/evb-rk3036_defconfig b/configs/evb-rk3036_defconfig
index 4e471f0ebb3..a1d9590c841 100644
--- a/configs/evb-rk3036_defconfig
+++ b/configs/evb-rk3036_defconfig
@@ -28,7 +28,7 @@ CONFIG_DEFAULT_FDT_FILE="rk3036-evb.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 # CONFIG_SPL_FRAMEWORK is not set
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
diff --git a/configs/evb-rk3229_defconfig b/configs/evb-rk3229_defconfig
index 3cbc22662a6..030abfc6b6e 100644
--- a/configs/evb-rk3229_defconfig
+++ b/configs/evb-rk3229_defconfig
@@ -28,7 +28,7 @@ CONFIG_DEFAULT_FDT_FILE="rk3229-evb.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x100000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPT=y
diff --git a/configs/evb-rk3288_defconfig b/configs/evb-rk3288_defconfig
index f6b72a2b7a0..024127944c2 100644
--- a/configs/evb-rk3288_defconfig
+++ b/configs/evb-rk3288_defconfig
@@ -33,7 +33,7 @@ CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rk3288-evb-rk808.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
index c8e1753b281..f07234a5024 100644
--- a/configs/evb-rk3308_defconfig
+++ b/configs/evb-rk3308_defconfig
@@ -17,7 +17,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-evb.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
index fd528535838..cb4a5386033 100644
--- a/configs/evb-rk3328_defconfig
+++ b/configs/evb-rk3328_defconfig
@@ -22,7 +22,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-evb.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
index 9481dfae7e4..8f1b7570a35 100644
--- a/configs/evb-rk3399_defconfig
+++ b/configs/evb-rk3399_defconfig
@@ -16,7 +16,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-evb.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
diff --git a/configs/evb-rk3568_defconfig b/configs/evb-rk3568_defconfig
index a068bc6846c..9ab3583b4a0 100644
--- a/configs/evb-rk3568_defconfig
+++ b/configs/evb-rk3568_defconfig
@@ -18,7 +18,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-evb1-v10.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
index 3d4d2747145..9ea4ea1c6ab 100644
--- a/configs/evb-rk3588_defconfig
+++ b/configs/evb-rk3588_defconfig
@@ -19,7 +19,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-evb1-v10.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
index b32ca726b6c..b750df55e68 100644
--- a/configs/ficus-rk3399_defconfig
+++ b/configs/ficus-rk3399_defconfig
@@ -17,7 +17,7 @@ CONFIG_AHCI=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-ficus.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
diff --git a/configs/firefly-px30_defconfig b/configs/firefly-px30_defconfig
index 7398d06274f..eab55f669cf 100644
--- a/configs/firefly-px30_defconfig
+++ b/configs/firefly-px30_defconfig
@@ -26,7 +26,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/px30-firefly.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index d8a671b7a8a..2205ec2f3e5 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -25,7 +25,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-firefly.dtb"
 CONFIG_MISC_INIT_R=y
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
diff --git a/configs/firefly-rk3399_defconfig b/configs/firefly-rk3399_defconfig
index 3871627318b..aaea58b6b4a 100644
--- a/configs/firefly-rk3399_defconfig
+++ b/configs/firefly-rk3399_defconfig
@@ -17,7 +17,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-firefly.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
index f79f0e84400..10d7616296f 100644
--- a/configs/generic-rk3568_defconfig
+++ b/configs/generic-rk3568_defconfig
@@ -23,7 +23,7 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
index 51e31dce3a9..b77f2a76dd6 100644
--- a/configs/generic-rk3588_defconfig
+++ b/configs/generic-rk3588_defconfig
@@ -19,7 +19,7 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-generic.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/jaguar-rk3588_defconfig b/configs/jaguar-rk3588_defconfig
index 6e853991d1d..01cf1bb90c9 100644
--- a/configs/jaguar-rk3588_defconfig
+++ b/configs/jaguar-rk3588_defconfig
@@ -27,7 +27,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-jaguar.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CYCLIC=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 # CONFIG_BOOTM_NETBSD is not set
diff --git a/configs/khadas-edge-captain-rk3399_defconfig b/configs/khadas-edge-captain-rk3399_defconfig
index 89611a0535e..0cac100784f 100644
--- a/configs/khadas-edge-captain-rk3399_defconfig
+++ b/configs/khadas-edge-captain-rk3399_defconfig
@@ -22,7 +22,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-khadas-edge-captain.dtb"
 CONFIG_SYS_PBSIZE=1048
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
diff --git a/configs/khadas-edge-rk3399_defconfig b/configs/khadas-edge-rk3399_defconfig
index 3816f4327a6..5b5e39d8306 100644
--- a/configs/khadas-edge-rk3399_defconfig
+++ b/configs/khadas-edge-rk3399_defconfig
@@ -21,7 +21,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-khadas-edge.dtb"
 CONFIG_SYS_PBSIZE=1048
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
diff --git a/configs/khadas-edge-v-rk3399_defconfig b/configs/khadas-edge-v-rk3399_defconfig
index 35e20942572..07bf6bc595d 100644
--- a/configs/khadas-edge-v-rk3399_defconfig
+++ b/configs/khadas-edge-v-rk3399_defconfig
@@ -22,7 +22,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-khadas-edge-v.dtb"
 CONFIG_SYS_PBSIZE=1048
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
diff --git a/configs/khadas-edge2-rk3588s_defconfig b/configs/khadas-edge2-rk3588s_defconfig
index 208c72ca425..b55f88d64f8 100644
--- a/configs/khadas-edge2-rk3588s_defconfig
+++ b/configs/khadas-edge2-rk3588s_defconfig
@@ -24,7 +24,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-khadas-edge2.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SEPARATE_BSS=y
 CONFIG_SPL_MMC_WRITE=y
diff --git a/configs/kylin-rk3036_defconfig b/configs/kylin-rk3036_defconfig
index 1ebb703c6fa..995d2af74a0 100644
--- a/configs/kylin-rk3036_defconfig
+++ b/configs/kylin-rk3036_defconfig
@@ -30,7 +30,7 @@ CONFIG_DEFAULT_FDT_FILE="rk3036-kylin.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 # CONFIG_SPL_FRAMEWORK is not set
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
diff --git a/configs/leez-rk3399_defconfig b/configs/leez-rk3399_defconfig
index 57b097377fa..ac4c8b06f2f 100644
--- a/configs/leez-rk3399_defconfig
+++ b/configs/leez-rk3399_defconfig
@@ -15,7 +15,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-leez-p710.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
diff --git a/configs/lubancat-2-rk3568_defconfig b/configs/lubancat-2-rk3568_defconfig
index 46cc3c03fff..51f1f6ad5f8 100644
--- a/configs/lubancat-2-rk3568_defconfig
+++ b/configs/lubancat-2-rk3568_defconfig
@@ -19,7 +19,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-lubancat-2.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
index 166468fd4e7..21747abe2bc 100644
--- a/configs/miqi-rk3288_defconfig
+++ b/configs/miqi-rk3288_defconfig
@@ -24,7 +24,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-miqi.dtb"
 CONFIG_MISC_INIT_R=y
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
diff --git a/configs/mk808_defconfig b/configs/mk808_defconfig
index 8c7f4deb843..2b1d5b88d18 100644
--- a/configs/mk808_defconfig
+++ b/configs/mk808_defconfig
@@ -43,7 +43,7 @@ CONFIG_SYS_PBSIZE=276
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x32000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_SEPARATE_BSS=y
diff --git a/configs/nanopc-t4-rk3399_defconfig b/configs/nanopc-t4-rk3399_defconfig
index 26c12c51078..95276602a42 100644
--- a/configs/nanopc-t4-rk3399_defconfig
+++ b/configs/nanopc-t4-rk3399_defconfig
@@ -17,7 +17,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopc-t4.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
diff --git a/configs/nanopc-t6-rk3588_defconfig b/configs/nanopc-t6-rk3588_defconfig
index 772b7df1555..31be93dc2e8 100644
--- a/configs/nanopc-t6-rk3588_defconfig
+++ b/configs/nanopc-t6-rk3588_defconfig
@@ -27,7 +27,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-nanopc-t6.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
diff --git a/configs/nanopi-m4-2gb-rk3399_defconfig b/configs/nanopi-m4-2gb-rk3399_defconfig
index d24b7bc6d17..fa1839baa96 100644
--- a/configs/nanopi-m4-2gb-rk3399_defconfig
+++ b/configs/nanopi-m4-2gb-rk3399_defconfig
@@ -18,7 +18,7 @@ CONFIG_AHCI=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopi-m4-2gb.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
diff --git a/configs/nanopi-m4-rk3399_defconfig b/configs/nanopi-m4-rk3399_defconfig
index da3e44af841..ae84be9f5b9 100644
--- a/configs/nanopi-m4-rk3399_defconfig
+++ b/configs/nanopi-m4-rk3399_defconfig
@@ -18,7 +18,7 @@ CONFIG_AHCI=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopi-m4.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
diff --git a/configs/nanopi-m4b-rk3399_defconfig b/configs/nanopi-m4b-rk3399_defconfig
index 247056ab58b..0815534618b 100644
--- a/configs/nanopi-m4b-rk3399_defconfig
+++ b/configs/nanopi-m4b-rk3399_defconfig
@@ -18,7 +18,7 @@ CONFIG_AHCI=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopi-m4b.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
diff --git a/configs/nanopi-neo4-rk3399_defconfig b/configs/nanopi-neo4-rk3399_defconfig
index 305877d2079..5ac47919e0a 100644
--- a/configs/nanopi-neo4-rk3399_defconfig
+++ b/configs/nanopi-neo4-rk3399_defconfig
@@ -16,7 +16,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopi-neo4.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
index bef1e22d644..c867c044b0a 100644
--- a/configs/nanopi-r2c-plus-rk3328_defconfig
+++ b/configs/nanopi-r2c-plus-rk3328_defconfig
@@ -23,7 +23,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2c-plus.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3328_defconfig
index 4d66a76c7dc..37648c87e87 100644
--- a/configs/nanopi-r2c-rk3328_defconfig
+++ b/configs/nanopi-r2c-rk3328_defconfig
@@ -23,7 +23,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2c.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
diff --git a/configs/nanopi-r2s-plus-rk3328_defconfig b/configs/nanopi-r2s-plus-rk3328_defconfig
index 3a75566ed4d..05a3e51dfb6 100644
--- a/configs/nanopi-r2s-plus-rk3328_defconfig
+++ b/configs/nanopi-r2s-plus-rk3328_defconfig
@@ -23,7 +23,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2s-plus.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
index 2b9193d1ff5..ef458b221be 100644
--- a/configs/nanopi-r2s-rk3328_defconfig
+++ b/configs/nanopi-r2s-rk3328_defconfig
@@ -23,7 +23,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2s.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
diff --git a/configs/nanopi-r3s-rk3566_defconfig b/configs/nanopi-r3s-rk3566_defconfig
index 870613f690a..1b4a89637e4 100644
--- a/configs/nanopi-r3s-rk3566_defconfig
+++ b/configs/nanopi-r3s-rk3566_defconfig
@@ -20,7 +20,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-nanopi-r3s.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/nanopi-r4s-rk3399_defconfig b/configs/nanopi-r4s-rk3399_defconfig
index a6dafe3d9eb..e60888a529f 100644
--- a/configs/nanopi-r4s-rk3399_defconfig
+++ b/configs/nanopi-r4s-rk3399_defconfig
@@ -16,7 +16,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-nanopi-r4s.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
diff --git a/configs/nanopi-r5c-rk3568_defconfig b/configs/nanopi-r5c-rk3568_defconfig
index 4a43b17ccb1..036e9158929 100644
--- a/configs/nanopi-r5c-rk3568_defconfig
+++ b/configs/nanopi-r5c-rk3568_defconfig
@@ -20,7 +20,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-nanopi-r5c.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/nanopi-r5s-rk3568_defconfig b/configs/nanopi-r5s-rk3568_defconfig
index a60d229fbbf..8abd77879f7 100644
--- a/configs/nanopi-r5s-rk3568_defconfig
+++ b/configs/nanopi-r5s-rk3568_defconfig
@@ -20,7 +20,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-nanopi-r5s.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/nanopi-r6c-rk3588s_defconfig b/configs/nanopi-r6c-rk3588s_defconfig
index c4de5518a72..eaef4d23a33 100644
--- a/configs/nanopi-r6c-rk3588s_defconfig
+++ b/configs/nanopi-r6c-rk3588s_defconfig
@@ -21,7 +21,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-nanopi-r6c.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/nanopi-r6s-rk3588s_defconfig b/configs/nanopi-r6s-rk3588s_defconfig
index 2726729b9ac..3318b07736f 100644
--- a/configs/nanopi-r6s-rk3588s_defconfig
+++ b/configs/nanopi-r6s-rk3588s_defconfig
@@ -21,7 +21,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-nanopi-r6s.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/neu2-io-rv1126_defconfig b/configs/neu2-io-rv1126_defconfig
index 18230859b18..431803e1e64 100644
--- a/configs/neu2-io-rv1126_defconfig
+++ b/configs/neu2-io-rv1126_defconfig
@@ -18,7 +18,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_DEFAULT_FDT_FILE="rv1126-edgeble-neu2-io.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/neu6a-io-rk3588_defconfig b/configs/neu6a-io-rk3588_defconfig
index 291e0d26d42..cbcf1434d5e 100644
--- a/configs/neu6a-io-rk3588_defconfig
+++ b/configs/neu6a-io-rk3588_defconfig
@@ -19,7 +19,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-edgeble-neu6a-io.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPT=y
diff --git a/configs/neu6b-io-rk3588_defconfig b/configs/neu6b-io-rk3588_defconfig
index 4e22852f23c..6f4b35510a6 100644
--- a/configs/neu6b-io-rk3588_defconfig
+++ b/configs/neu6b-io-rk3588_defconfig
@@ -19,7 +19,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-edgeble-neu6b-io.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPT=y
diff --git a/configs/nova-rk3588s_defconfig b/configs/nova-rk3588s_defconfig
index fb30dfd1db8..d25405fbb72 100644
--- a/configs/nova-rk3588s_defconfig
+++ b/configs/nova-rk3588s_defconfig
@@ -20,7 +20,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-indiedroid-nova.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index 492802dddae..69bd559c5a9 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -29,7 +29,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_I2C=y
diff --git a/configs/odroid-m1-rk3568_defconfig b/configs/odroid-m1-rk3568_defconfig
index a8e8a8781e1..8e0e2353bf6 100644
--- a/configs/odroid-m1-rk3568_defconfig
+++ b/configs/odroid-m1-rk3568_defconfig
@@ -27,7 +27,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-odroid-m1.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
diff --git a/configs/odroid-m1s-rk3566_defconfig b/configs/odroid-m1s-rk3566_defconfig
index 39e815ad317..0078a33dbc7 100644
--- a/configs/odroid-m1s-rk3566_defconfig
+++ b/configs/odroid-m1s-rk3566_defconfig
@@ -21,7 +21,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-odroid-m1s.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/odroid-m2-rk3588s_defconfig b/configs/odroid-m2-rk3588s_defconfig
index 4c3fa8500d8..0bdc262bad0 100644
--- a/configs/odroid-m2-rk3588s_defconfig
+++ b/configs/odroid-m2-rk3588s_defconfig
@@ -21,7 +21,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-odroid-m2.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/orangepi-3b-rk3566_defconfig b/configs/orangepi-3b-rk3566_defconfig
index 2181c9caf58..83ca7bb27b5 100644
--- a/configs/orangepi-3b-rk3566_defconfig
+++ b/configs/orangepi-3b-rk3566_defconfig
@@ -28,7 +28,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-orangepi-3b.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
diff --git a/configs/orangepi-5-plus-rk3588_defconfig b/configs/orangepi-5-plus-rk3588_defconfig
index 9050fceda45..214d8363313 100644
--- a/configs/orangepi-5-plus-rk3588_defconfig
+++ b/configs/orangepi-5-plus-rk3588_defconfig
@@ -28,7 +28,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-orangepi-5-plus.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
diff --git a/configs/orangepi-5-rk3588s_defconfig b/configs/orangepi-5-rk3588s_defconfig
index 6e2ff7d338a..844dd22a1a8 100644
--- a/configs/orangepi-5-rk3588s_defconfig
+++ b/configs/orangepi-5-rk3588s_defconfig
@@ -27,7 +27,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-orangepi-5.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
index 6d5d8b9dcc9..0874a013046 100644
--- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
@@ -26,7 +26,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-orangepi-r1-plus-lts.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_POWER=y
 CONFIG_SPL_SPI_LOAD=y
diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
index b382f9b9f18..1bd51675cc4 100644
--- a/configs/orangepi-r1-plus-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-rk3328_defconfig
@@ -26,7 +26,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-orangepi-r1-plus.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_POWER=y
 CONFIG_SPL_SPI_LOAD=y
diff --git a/configs/orangepi-rk3399_defconfig b/configs/orangepi-rk3399_defconfig
index fdf3d698939..1d1cf412b43 100644
--- a/configs/orangepi-rk3399_defconfig
+++ b/configs/orangepi-rk3399_defconfig
@@ -16,7 +16,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-orangepi.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
diff --git a/configs/phycore-rk3288_defconfig b/configs/phycore-rk3288_defconfig
index ff03a59b48d..ac2944160b8 100644
--- a/configs/phycore-rk3288_defconfig
+++ b/configs/phycore-rk3288_defconfig
@@ -31,7 +31,7 @@ CONFIG_DEFAULT_FDT_FILE="rk3288-phycore-rdk.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_CONSOLE_MUX=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_CMD_GPIO=y
diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
index dfa927ccb17..195bc01152f 100644
--- a/configs/pinebook-pro-rk3399_defconfig
+++ b/configs/pinebook-pro-rk3399_defconfig
@@ -25,7 +25,7 @@ CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-pinebook-pro.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
diff --git a/configs/pinephone-pro-rk3399_defconfig b/configs/pinephone-pro-rk3399_defconfig
index 5e16749ba7d..d5a70015ed6 100644
--- a/configs/pinephone-pro-rk3399_defconfig
+++ b/configs/pinephone-pro-rk3399_defconfig
@@ -23,7 +23,7 @@ CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-pinephone-pro.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
diff --git a/configs/pinetab2-rk3566_defconfig b/configs/pinetab2-rk3566_defconfig
index 45e63b42d19..cf10abc4c8f 100644
--- a/configs/pinetab2-rk3566_defconfig
+++ b/configs/pinetab2-rk3566_defconfig
@@ -27,7 +27,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-pinetab2-v2.0.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
diff --git a/configs/popmetal-rk3288_defconfig b/configs/popmetal-rk3288_defconfig
index ae7869ae5fa..4c29afe924e 100644
--- a/configs/popmetal-rk3288_defconfig
+++ b/configs/popmetal-rk3288_defconfig
@@ -30,7 +30,7 @@ CONFIG_DEFAULT_FDT_FILE="rk3288-popmetal.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_CONSOLE_MUX=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_CMD_GPIO=y
diff --git a/configs/powkiddy-x55-rk3566_defconfig b/configs/powkiddy-x55-rk3566_defconfig
index 85280839889..3b96c8d3c07 100644
--- a/configs/powkiddy-x55-rk3566_defconfig
+++ b/configs/powkiddy-x55-rk3566_defconfig
@@ -18,7 +18,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-powkiddy-x55.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index 7a180b14130..55e15612260 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -23,7 +23,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-puma-haikou.dtb"
 CONFIG_CONSOLE_MUX=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x2e000
-CONFIG_SPL_PAD_TO=0x38000
+CONFIG_SPL_PAD_TO=0x40000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x200
 CONFIG_SPL_I2C=y
diff --git a/configs/px30-core-ctouch2-of10-px30_defconfig b/configs/px30-core-ctouch2-of10-px30_defconfig
index 97a6d45f39b..23743683aa8 100644
--- a/configs/px30-core-ctouch2-of10-px30_defconfig
+++ b/configs/px30-core-ctouch2-of10-px30_defconfig
@@ -25,7 +25,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/px30-engicam-px30-core-ctouch2-of10.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
diff --git a/configs/px30-core-ctouch2-px30_defconfig b/configs/px30-core-ctouch2-px30_defconfig
index 0d20546a746..c3870f70d67 100644
--- a/configs/px30-core-ctouch2-px30_defconfig
+++ b/configs/px30-core-ctouch2-px30_defconfig
@@ -25,7 +25,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/px30-engicam-px30-core-ctouch2.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
diff --git a/configs/px30-core-edimm2.2-px30_defconfig b/configs/px30-core-edimm2.2-px30_defconfig
index 6d7ec8f3598..1c0a1c63488 100644
--- a/configs/px30-core-edimm2.2-px30_defconfig
+++ b/configs/px30-core-edimm2.2-px30_defconfig
@@ -25,7 +25,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/px30-engicam-px30-core-edimm2.2.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
diff --git a/configs/qnap-ts433-rk3568_defconfig b/configs/qnap-ts433-rk3568_defconfig
index ceef0d25dc0..cb70e2bcdaf 100644
--- a/configs/qnap-ts433-rk3568_defconfig
+++ b/configs/qnap-ts433-rk3568_defconfig
@@ -22,7 +22,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-qnap-ts433.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/quartz64-a-rk3566_defconfig b/configs/quartz64-a-rk3566_defconfig
index fe3fa37611a..2578b5d65a0 100644
--- a/configs/quartz64-a-rk3566_defconfig
+++ b/configs/quartz64-a-rk3566_defconfig
@@ -28,7 +28,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-quartz64-a.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_POWER=y
 CONFIG_SPL_SPI_LOAD=y
diff --git a/configs/quartz64-b-rk3566_defconfig b/configs/quartz64-b-rk3566_defconfig
index 929736f76af..d8e7e3036a8 100644
--- a/configs/quartz64-b-rk3566_defconfig
+++ b/configs/quartz64-b-rk3566_defconfig
@@ -27,7 +27,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-quartz64-b.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
diff --git a/configs/quartzpro64-rk3588_defconfig b/configs/quartzpro64-rk3588_defconfig
index ade7be27e92..40dd6ff84bf 100644
--- a/configs/quartzpro64-rk3588_defconfig
+++ b/configs/quartzpro64-rk3588_defconfig
@@ -22,7 +22,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-quartzpro64.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/radxa-cm3-io-rk3566_defconfig b/configs/radxa-cm3-io-rk3566_defconfig
index 2655fdc3170..690c56ec3b2 100644
--- a/configs/radxa-cm3-io-rk3566_defconfig
+++ b/configs/radxa-cm3-io-rk3566_defconfig
@@ -18,7 +18,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-radxa-cm3-io.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/radxa-e25-rk3568_defconfig b/configs/radxa-e25-rk3568_defconfig
index 4df594ddc01..9d63d04034c 100644
--- a/configs/radxa-e25-rk3568_defconfig
+++ b/configs/radxa-e25-rk3568_defconfig
@@ -21,7 +21,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-radxa-e25.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/radxa-zero-3-rk3566_defconfig b/configs/radxa-zero-3-rk3566_defconfig
index 5989b07ad79..d75ae675b93 100644
--- a/configs/radxa-zero-3-rk3566_defconfig
+++ b/configs/radxa-zero-3-rk3566_defconfig
@@ -20,7 +20,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-radxa-zero-3w.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
diff --git a/configs/rk3399-generic-ddr3_defconfig b/configs/rk3399-generic-ddr3_defconfig
index 490bc72ee92..9d550207ea9 100644
--- a/configs/rk3399-generic-ddr3_defconfig
+++ b/configs/rk3399-generic-ddr3_defconfig
@@ -41,7 +41,7 @@ CONFIG_BLOBLIST_FIXED=y
 CONFIG_BLOBLIST_ADDR=0xff8eff00
 CONFIG_BLOBLIST_SIZE=0x100
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_HAVE_INIT_STACK=y
 # CONFIG_SPL_SEPARATE_BSS is not set
diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
index fb81d3bccfb..b08d0a4c1fb 100644
--- a/configs/roc-cc-rk3308_defconfig
+++ b/configs/roc-cc-rk3308_defconfig
@@ -17,7 +17,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-roc-cc.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defconfig
index 183332ab7ce..80a44449328 100644
--- a/configs/roc-cc-rk3328_defconfig
+++ b/configs/roc-cc-rk3328_defconfig
@@ -22,7 +22,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-roc-cc.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-mezzanine-rk3399_defconfig
index 3ab5fd69c62..bac62d3b8a0 100644
--- a/configs/roc-pc-mezzanine-rk3399_defconfig
+++ b/configs/roc-pc-mezzanine-rk3399_defconfig
@@ -25,7 +25,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-roc-pc-mezzanine.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 0ef86748778..dad038e6020 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -24,7 +24,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-roc-pc.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
diff --git a/configs/rock-3a-rk3568_defconfig b/configs/rock-3a-rk3568_defconfig
index 733ce631457..ebb24491205 100644
--- a/configs/rock-3a-rk3568_defconfig
+++ b/configs/rock-3a-rk3568_defconfig
@@ -26,7 +26,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-rock-3a.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
diff --git a/configs/rock-3b-rk3568_defconfig b/configs/rock-3b-rk3568_defconfig
index 2023feb36c2..349a20349b0 100644
--- a/configs/rock-3b-rk3568_defconfig
+++ b/configs/rock-3b-rk3568_defconfig
@@ -26,7 +26,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-rock-3b.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
diff --git a/configs/rock-3c-rk3566_defconfig b/configs/rock-3c-rk3566_defconfig
index 2528c7c639c..db8f6163627 100644
--- a/configs/rock-3c-rk3566_defconfig
+++ b/configs/rock-3c-rk3566_defconfig
@@ -26,7 +26,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-rock-3c.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
diff --git a/configs/rock-4c-plus-rk3399_defconfig b/configs/rock-4c-plus-rk3399_defconfig
index 0c73a212ea1..97ad1c52c92 100644
--- a/configs/rock-4c-plus-rk3399_defconfig
+++ b/configs/rock-4c-plus-rk3399_defconfig
@@ -23,7 +23,7 @@ CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-4c-plus.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
diff --git a/configs/rock-4se-rk3399_defconfig b/configs/rock-4se-rk3399_defconfig
index 3ae19692155..ed128429c8a 100644
--- a/configs/rock-4se-rk3399_defconfig
+++ b/configs/rock-4se-rk3399_defconfig
@@ -25,7 +25,7 @@ CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-4se.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
diff --git a/configs/rock-5-itx-rk3588_defconfig b/configs/rock-5-itx-rk3588_defconfig
index d0dd1c20ece..47817435f67 100644
--- a/configs/rock-5-itx-rk3588_defconfig
+++ b/configs/rock-5-itx-rk3588_defconfig
@@ -28,7 +28,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5-itx.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
diff --git a/configs/rock-5c-rk3588s_defconfig b/configs/rock-5c-rk3588s_defconfig
index 59f9f25edcb..5089597da7e 100644
--- a/configs/rock-5c-rk3588s_defconfig
+++ b/configs/rock-5c-rk3588s_defconfig
@@ -21,7 +21,7 @@ CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5c.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_ADC=y
diff --git a/configs/rock-pi-4-rk3399_defconfig b/configs/rock-pi-4-rk3399_defconfig
index f3a5c2c45f3..cb01181c651 100644
--- a/configs/rock-pi-4-rk3399_defconfig
+++ b/configs/rock-pi-4-rk3399_defconfig
@@ -25,7 +25,7 @@ CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4a.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
diff --git a/configs/rock-pi-4c-rk3399_defconfig b/configs/rock-pi-4c-rk3399_defconfig
index 9bda50c8c77..1cbd5972463 100644
--- a/configs/rock-pi-4c-rk3399_defconfig
+++ b/configs/rock-pi-4c-rk3399_defconfig
@@ -25,7 +25,7 @@ CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock-pi-4c.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
index 52dad765a8a..532f420e544 100644
--- a/configs/rock-pi-e-rk3328_defconfig
+++ b/configs/rock-pi-e-rk3328_defconfig
@@ -22,7 +22,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock-pi-e.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
diff --git a/configs/rock-pi-e-v3-rk3328_defconfig b/configs/rock-pi-e-v3-rk3328_defconfig
index 518ea4ebe51..fb2bc8cc9c9 100644
--- a/configs/rock-pi-e-v3-rk3328_defconfig
+++ b/configs/rock-pi-e-v3-rk3328_defconfig
@@ -22,7 +22,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock-pi-e.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_POWER=y
 CONFIG_SPL_ATF=y
diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n10-rk3399pro_defconfig
index a9c6d8a907a..4ae0ddd3059 100644
--- a/configs/rock-pi-n10-rk3399pro_defconfig
+++ b/configs/rock-pi-n10-rk3399pro_defconfig
@@ -18,7 +18,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399pro-rock-pi-n10.dtb"
 # CONFIG_CONSOLE_MUX is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
diff --git a/configs/rock-pi-n8-rk3288_defconfig b/configs/rock-pi-n8-rk3288_defconfig
index 92ffc72cd7a..c64e8f080a3 100644
--- a/configs/rock-pi-n8-rk3288_defconfig
+++ b/configs/rock-pi-n8-rk3288_defconfig
@@ -29,7 +29,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_USE_PREBOOT=y
 CONFIG_SILENT_CONSOLE=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_CMD_SPL=y
diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index 4b08af309b1..3c357b5cec6 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -17,7 +17,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-rock-pi-s.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
diff --git a/configs/rock-s0-rk3308_defconfig b/configs/rock-s0-rk3308_defconfig
index 0a46e7bb187..8d7ed5d1434 100644
--- a/configs/rock-s0-rk3308_defconfig
+++ b/configs/rock-s0-rk3308_defconfig
@@ -17,7 +17,7 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-rock-s0.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
diff --git a/configs/rock2_defconfig b/configs/rock2_defconfig
index b356df23ec6..4255e37c448 100644
--- a/configs/rock2_defconfig
+++ b/configs/rock2_defconfig
@@ -30,7 +30,7 @@ CONFIG_DEFAULT_FDT_FILE="rk3288-rock2-square.dtb"
 CONFIG_SILENT_CONSOLE=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_CMD_GPIO=y
diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
index 9618d590009..2449f33abc5 100644
--- a/configs/rock5a-rk3588s_defconfig
+++ b/configs/rock5a-rk3588s_defconfig
@@ -19,7 +19,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5a.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index 47ee2109f8e..80781eef2d1 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -29,7 +29,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
index 6d00b52e62f..12e248c05c1 100644
--- a/configs/rock64-rk3328_defconfig
+++ b/configs/rock64-rk3328_defconfig
@@ -25,7 +25,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock64.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_POWER=y
 CONFIG_SPL_SPI_LOAD=y
diff --git a/configs/rock960-rk3399_defconfig b/configs/rock960-rk3399_defconfig
index aebfa73459c..1c361b019b7 100644
--- a/configs/rock960-rk3399_defconfig
+++ b/configs/rock960-rk3399_defconfig
@@ -16,7 +16,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rock960.dtb"
 CONFIG_SYS_PBSIZE=1052
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
 CONFIG_TPL=y
diff --git a/configs/rock_defconfig b/configs/rock_defconfig
index d2a84710cb0..09740abf55c 100644
--- a/configs/rock_defconfig
+++ b/configs/rock_defconfig
@@ -30,7 +30,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3188-radxarock.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x7800
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_CMD_I2C=y
diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index 75322073285..fdd80e72bf1 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -23,7 +23,7 @@ CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-rockpro64.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0xE0000
diff --git a/configs/sige7-rk3588_defconfig b/configs/sige7-rk3588_defconfig
index 8b033e22b84..c374ff8d337 100644
--- a/configs/sige7-rk3588_defconfig
+++ b/configs/sige7-rk3588_defconfig
@@ -23,7 +23,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-armsom-sige7.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/sonoff-ihost-rv1126_defconfig b/configs/sonoff-ihost-rv1126_defconfig
index 78ca7a3859e..74deef49737 100644
--- a/configs/sonoff-ihost-rv1126_defconfig
+++ b/configs/sonoff-ihost-rv1126_defconfig
@@ -19,7 +19,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_DEFAULT_FDT_FILE="rv1126-sonoff-ihost.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
diff --git a/configs/soquartz-blade-rk3566_defconfig b/configs/soquartz-blade-rk3566_defconfig
index a1a51b2c657..a29310ede62 100644
--- a/configs/soquartz-blade-rk3566_defconfig
+++ b/configs/soquartz-blade-rk3566_defconfig
@@ -21,7 +21,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-soquartz-blade.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/soquartz-cm4-rk3566_defconfig b/configs/soquartz-cm4-rk3566_defconfig
index a8bca0eaccc..4652879be6c 100644
--- a/configs/soquartz-cm4-rk3566_defconfig
+++ b/configs/soquartz-cm4-rk3566_defconfig
@@ -21,7 +21,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-soquartz-cm4.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/soquartz-model-a-rk3566_defconfig b/configs/soquartz-model-a-rk3566_defconfig
index f080d2e36d2..913cb87b12d 100644
--- a/configs/soquartz-model-a-rk3566_defconfig
+++ b/configs/soquartz-model-a-rk3566_defconfig
@@ -21,7 +21,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-soquartz-model-a.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/tiger-rk3588_defconfig b/configs/tiger-rk3588_defconfig
index f962ac416f3..a3952ff55da 100644
--- a/configs/tiger-rk3588_defconfig
+++ b/configs/tiger-rk3588_defconfig
@@ -28,7 +28,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-tiger-haikou.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CYCLIC=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 # CONFIG_BOOTM_NETBSD is not set
diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index bc5379d4343..fd7f60008d6 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -24,7 +24,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-tinker.dtb"
 CONFIG_MISC_INIT_R=y
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index f0c8cc5bbc1..240d8bd9b5f 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -24,7 +24,7 @@ CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3288-tinker-s.dtb"
 CONFIG_MISC_INIT_R=y
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
diff --git a/configs/toybrick-rk3588_defconfig b/configs/toybrick-rk3588_defconfig
index 5e70341c987..7da1b5cbc3b 100644
--- a/configs/toybrick-rk3588_defconfig
+++ b/configs/toybrick-rk3588_defconfig
@@ -19,7 +19,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-toybrick-x0.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index 0eddf15833c..73d7b32e300 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -22,7 +22,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-turing-rk1.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/vyasa-rk3288_defconfig b/configs/vyasa-rk3288_defconfig
index 3b4dc5b5699..d3b88269134 100644
--- a/configs/vyasa-rk3288_defconfig
+++ b/configs/vyasa-rk3288_defconfig
@@ -30,7 +30,7 @@ CONFIG_USE_PREBOOT=y
 CONFIG_DEFAULT_FDT_FILE="rk3288-vyasa.dtb"
 CONFIG_SILENT_CONSOLE=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_PAD_TO=0x800000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_SPL_OS_BOOT=y
-- 
2.43.0

