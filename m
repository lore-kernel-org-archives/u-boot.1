Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260A9C25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 12:50:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3165D882A2;
	Thu, 16 May 2024 14:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="bjhQMZRu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAD5E88258; Thu, 16 May 2024 11:03:10 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C6518824A
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=anand@edgeble.ai
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f4f2b1c997so4691292b3a.0
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 02:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1715850187; x=1716454987;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/E1VgH+H4576bkChtYnKV3lQq6kJMc/aJeSqTRFaMho=;
 b=bjhQMZRu6QhH2TLOnXksCGNPniQMPNG2PBib7AMrf9M3kVQkDlTmpajajpYkNuRPnO
 MPRleMzOqGdkHi2QnmOsHkJyAk7s26MUMVhD4cr2cAHW89cUzPkO9Jb2q+uQ6i9uV3Z2
 A9tAplI3cZumqBIegh07YKQBFbdpyh9a0x8dXoVGbJGGzdmvKoLtK/D/559Ynphfq3Jn
 mokBZI6DwmPrWi4sr6pjCK6x+KwXs9lhoQetf0TvjG6CRQs8m73EnK1s6p8VlfD89wk3
 wu3ZPCmET7k+9YxZlFsXZ9aYbTVrgTdSh1yvK8yLQFIUoQ9fEYJ39Oxg/mMipnYKpGQb
 uE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715850187; x=1716454987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/E1VgH+H4576bkChtYnKV3lQq6kJMc/aJeSqTRFaMho=;
 b=BinPazpR7R1og46r5bHuAVVBPCoRrOdeHnhj9WX2Q57VJlBL6WIqpjpdqcLeWPh2pJ
 4q3OX6ecp17lGbZFMQ/WBK8xgpkpY8ZZ8Ar8pTZzV0MnG6rUlChKvRyL+L9W8xaf6Saz
 jF31Qp8lS7VZ13kYbsyOw6y1Hzk9OSinTXpftqM0jqdOl0iFMei/OUjDyhwakh+H7KRj
 G8Ctk6hlroK0XEnoWlPFmGNn3sRsOEsWTeMmLZgiBPkYnOiv3rbou7AObgfh5sE3uaJD
 M8M075RlaVWt/xIdfAi21A4b9wjQKD/fcH5OwIC39XAYGBLlwo9RKeFzjHUAp0CbWjb0
 jd5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6+LRVIHhnyOaLqcnaoqSmFnS2BM+E683nX2hV6tHtOXRE14PcNFr0cFtEtegDZPSnm3bovw/FCgzKMAUfzDm+lthDqQ==
X-Gm-Message-State: AOJu0YwPIcqocEs3EfHDZ3skAGCEiygdLe9qwdb2ulyVW19+rh4kQyfg
 3pnZ5+5/JwG10RsDkQqmdBClZE7EPWjvhnXYYsGY4uWMNqd75iFHtdHOBILpnMk=
X-Google-Smtp-Source: AGHT+IEgNlpwYN9gfKBVKHlVNHYW7jUPF/RMFZGAiNufpk9jzNB5zTHeXa7U3mqPDullwEnABGy6mw==
X-Received: by 2002:a05:6a00:3a0f:b0:6ea:914e:a108 with SMTP id
 d2e1a72fcca58-6f4e02af1f2mr16745147b3a.12.1715850186865; 
 Thu, 16 May 2024 02:03:06 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6584e7897bdsm1325189a12.21.2024.05.16.02.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 02:03:06 -0700 (PDT)
From: Anand Moon <anand@edgeble.ai>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tianling Shen <cnsztl@gmail.com>,
 David Bauer <mail@david-bauer.net>, Loic Devulder <ldevulder@suse.com>,
 Chen-Yu Tsai <wens@csie.org>, Jonas Karlman <jonas@kwiboo.se>,
 Banglang Huang <banglang.huang@foxmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc: Anand Moon <anand@edgeble.ai>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de
Subject: [PATCH v1 2/9] rockchip: RK3328: Enable display cpuinfo support on
 all boards
Date: Thu, 16 May 2024 08:59:02 +0000
Message-ID: <20240516090031.2373-3-anand@edgeble.ai>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516090031.2373-1-anand@edgeble.ai>
References: <20240516090031.2373-1-anand@edgeble.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 May 2024 14:50:16 +0200
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

Imply DISPLAY_CPUINFO Kconfig options to support on all RK3328
boards, Its used to determine the reset cause of the board.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
---
 arch/arm/mach-rockchip/Kconfig                | 1 +
 configs/evb-rk3328_defconfig                  | 1 -
 configs/nanopi-r2c-plus-rk3328_defconfig      | 1 -
 configs/nanopi-r2c-rk3328_defconfig           | 1 -
 configs/nanopi-r2s-rk3328_defconfig           | 1 -
 configs/orangepi-r1-plus-lts-rk3328_defconfig | 1 -
 configs/orangepi-r1-plus-rk3328_defconfig     | 1 -
 configs/roc-cc-rk3328_defconfig               | 1 -
 configs/rock-pi-e-rk3328_defconfig            | 1 -
 configs/rock64-rk3328_defconfig               | 1 -
 10 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index ec3697f358..ba1474bb9e 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -206,6 +206,7 @@ config ROCKCHIP_RK3328
 	imply SPL_SEPARATE_BSS
 	imply SPL_SERIAL
 	imply TPL_SERIAL
+	imply DISPLAY_CPUINFO
 	help
 	  The Rockchip RK3328 is a ARM-based SoC with a quad-core Cortex-A53.
 	  including NEON and GPU, 1MB L2 cache, Mali-T7 graphics, two
diff --git a/configs/evb-rk3328_defconfig b/configs/evb-rk3328_defconfig
index bfb8522343..e1c2016cb3 100644
--- a/configs/evb-rk3328_defconfig
+++ b/configs/evb-rk3328_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-evb.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/nanopi-r2c-plus-rk3328_defconfig b/configs/nanopi-r2c-plus-rk3328_defconfig
index f311a0a80b..700ce47696 100644
--- a/configs/nanopi-r2c-plus-rk3328_defconfig
+++ b/configs/nanopi-r2c-plus-rk3328_defconfig
@@ -20,7 +20,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2c-plus.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/nanopi-r2c-rk3328_defconfig b/configs/nanopi-r2c-rk3328_defconfig
index 533dc1029f..a594f329bf 100644
--- a/configs/nanopi-r2c-rk3328_defconfig
+++ b/configs/nanopi-r2c-rk3328_defconfig
@@ -20,7 +20,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2c.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/nanopi-r2s-rk3328_defconfig b/configs/nanopi-r2s-rk3328_defconfig
index 2591a9cc8a..c1d0a1f396 100644
--- a/configs/nanopi-r2s-rk3328_defconfig
+++ b/configs/nanopi-r2s-rk3328_defconfig
@@ -20,7 +20,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-nanopi-r2s.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/orangepi-r1-plus-lts-rk3328_defconfig b/configs/orangepi-r1-plus-lts-rk3328_defconfig
index 14cdbd813c..7e0b1b2773 100644
--- a/configs/orangepi-r1-plus-lts-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-lts-rk3328_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-orangepi-r1-plus-lts.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/orangepi-r1-plus-rk3328_defconfig b/configs/orangepi-r1-plus-rk3328_defconfig
index 7fe58e7a14..4525c99ca2 100644
--- a/configs/orangepi-r1-plus-rk3328_defconfig
+++ b/configs/orangepi-r1-plus-rk3328_defconfig
@@ -23,7 +23,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-orangepi-r1-plus.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/roc-cc-rk3328_defconfig b/configs/roc-cc-rk3328_defconfig
index 91b9422e26..c1eb03c5e8 100644
--- a/configs/roc-cc-rk3328_defconfig
+++ b/configs/roc-cc-rk3328_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-roc-cc.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/rock-pi-e-rk3328_defconfig b/configs/rock-pi-e-rk3328_defconfig
index 5cc54af3ca..bb99670b8c 100644
--- a/configs/rock-pi-e-rk3328_defconfig
+++ b/configs/rock-pi-e-rk3328_defconfig
@@ -19,7 +19,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock-pi-e.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
diff --git a/configs/rock64-rk3328_defconfig b/configs/rock64-rk3328_defconfig
index 9d77dfb709..836f18a806 100644
--- a/configs/rock64-rk3328_defconfig
+++ b/configs/rock64-rk3328_defconfig
@@ -22,7 +22,6 @@ CONFIG_SPL_FIT_SIGNATURE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3328-rock64.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
-- 
2.45.0

