Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EF1CD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46828848D2;
	Thu, 28 May 2026 19:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gBCXn6U4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 985778469D; Thu, 28 May 2026 19:11:46 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 708A9848D1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e4de538f83so7378691a34.1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988303; x=1780593103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNQx1yQa8ElYAFja1L8r5lzG2j/R8wwyBYkKIv67NK0=;
 b=gBCXn6U4mg8NvXeCWOq2h/RmDnhjKyT+onsoqLIos4QSsRebDPjU5DtULuz23S+7p2
 src5zylIW/JtuMHEflX3fPPd31BF0DXatAvPrrFoNQjGJs4vBsacclQgTnBbAeefnOvH
 yUF1Hm/gers8y/03XG3zeNG3fBy7X3LUIstUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988303; x=1780593103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nNQx1yQa8ElYAFja1L8r5lzG2j/R8wwyBYkKIv67NK0=;
 b=WNKENCKRNFuZ0X1VDLZCJm1etnUg0xAkS52pidwopWD1IrYG4P/KZdGE77xuAU5JZ0
 XBoFMOChZaYvu5MdKoHZfaVFMgri7dcnkcm/5lkKyV1vflEhJVlJWGkT3kGsABeb1dQ3
 NaQVEsDWwHLzRvuiTuvFwLI7Au/SeZZr1ABp05rt/V1VFnk8jlJBF/gvb8IM9ze1I3ui
 7vgMCIHBV+Feh+z9Jywkii2z60tR10qxwZ63vzNuYaHgo9KUu4uh7O6nr2PJbz2PM6A/
 uNUNvTr53z0PtPUfIwdZfWFFcgAoPQ9ytOCyB7jMtIgnMYqJGC/Ws+8yruoMvYUoBpT7
 s8gA==
X-Gm-Message-State: AOJu0YyFebFC403impSgEG7ckebqkeGa3IPBO2vEZCllzXU6UKOOWJol
 u3eYLAgoDGdnG9xxNir6jHYew9P30YC6Gci87LRXgOXVqHmxVdtvO8H99gX0gdwcDvIuOvaXGBD
 bpVgpJsK88r0=
X-Gm-Gg: Acq92OEqfWHC3612McYU0dwpCTWzaIKTHdcuR5C1xbUUJHSqH6aboTrl9fYrkltNPHI
 p+gNUgPmdhbXV9sil4kAYAIyYuFzACjt7LvtQg6qJbEPk78eyxzi2jRbu/snvBaA/j9NC4atq8i
 u6nJYvZ9ka+4ih31f3RQzFc9F41ZFzutHqT19HeGGxUIbE8Mvb3RyiRCNnnsOGnpgbJ8KnwbiaU
 T0di8i3RkCP+aZF3FAJwJZ9qWnzVw+BWxjg+bUrlxxw6K+CdgtkbW07XjxCFc3GMYQYpV5SDZjF
 SoFLJT22qZ5HKCI8dp/tSabNxgMIai2yX8s15XXLs3N4AE1jNVvCAGV0PZokbUQZ4pF8D9JPOSq
 Dp8mzO2Uo+AwIJiQq2gIRDPlJtWlhyrPxYAbGdnKQvcgao8FdOlALlhypZnbqCKbfj7aWtSDO2a
 qtE4l1Kv8uT/VV397xzvGfkOmbPBbc
X-Received: by 2002:a05:6830:6618:b0:7dc:e37b:b5d2 with SMTP id
 46e09a7af769-7e5feec2ac6mr17197297a34.8.1779988303009; 
 Thu, 28 May 2026 10:11:43 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Alexey Charkov <alchark@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Klaus Goger <klaus.goger@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 20/22] rockchip: Set the skip-at-start property correctly
Date: Thu, 28 May 2026 11:10:27 -0600
Message-ID: <20260528171043.910264-21-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

The rockchip image is written to the media at block 64, which is a 32K
offset, so set the skip-at-start property to 0x8000

Update CONFIG_SPL_PAD_TO to point to the offset in the image, since
Binman is dealing with the 'missing' 32K now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v6)

Changes in v6:
- Update CONFIG_SPL_PAD_TO for puma-rk3399 and ringneck-px30

Changes in v5:
- Add to VPL file also

Changes in v2:
- Move this patch to the end of the series
- Drop 0x8000 offset for SPI

 arch/arm/dts/rockchip-u-boot.dtsi     | 1 +
 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 1 +
 common/spl/Kconfig                    | 2 +-
 configs/puma-rk3399_defconfig         | 2 +-
 configs/ringneck-px30_defconfig       | 2 +-
 5 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 7ca2d6d7663..e300d7bc051 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -171,6 +171,7 @@
 	simple-bin {
 		filename = "u-boot-rockchip.bin";
 		pad-byte = <0xff>;
+		skip-at-start = <0x8000>;
 
 		mkimage {
 			filename = "idbloader.img";
diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index ac67b29c57a..66dcf36010e 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -113,6 +113,7 @@
 	simple-bin {
 		filename = "u-boot-rockchip.bin";
 		pad-byte = <0xff>;
+		skip-at-start = <0x8000>;
 
 		alternates-fdt {
 			fdt-list-dir = "dts/upstream/src/arm64/rockchip";
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 4b256abe6af..2cf0f03accb 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -88,7 +88,7 @@ config SPL_MAX_SIZE
 
 config SPL_PAD_TO
 	hex "Offset to which the SPL should be padded before appending the SPL payload"
-	default 0x7f8000 if ARCH_ROCKCHIP
+	default 0x800000 if ARCH_ROCKCHIP
 	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
 	default 0x11000 if ARCH_MX7 || (ARCH_MX6 && !MX6_OCRAM_256KB)
 	default 0x10000 if ARCH_KEYSTONE
diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index 09b965d4637..7a129b7389a 100644
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
diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index 75646935105..ca7c143fe17 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -26,7 +26,7 @@ CONFIG_DEFAULT_FDT_FILE="rockchip/px30-ringneck-haikou.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
-CONFIG_SPL_PAD_TO=0x38000
+CONFIG_SPL_PAD_TO=0x40000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-- 
2.43.0

