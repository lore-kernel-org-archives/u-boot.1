Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C59C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A73F5887B9;
	Fri, 31 May 2024 16:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BZ1OiXUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EB8E885AF; Fri, 31 May 2024 16:19:04 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AFF3887C4
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-6bce380ebc2so1782122a12.0
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165139; x=1717769939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fqU0YFx6cSRjVw2zD+R0tht6d4TzcGxYEhidKZzMmv8=;
 b=BZ1OiXUD5fkkWaQPfSoENLGPl26dU2nDIApJ5xpRGpP/MZ9ZQMmjOgTWOeWtnHiEm6
 XSMk3F7uYtqZVYZGRiHihLPUqHV7q4YCYXt7B6M0OXec04Cl7dVc9uicuLThal8MCK/O
 cXH1Hs5GmIcvHstYksJh5KN0j/V/M1cNAmt0N1u48zEXrPWLPGWKZe7+FaL9aEU42n47
 +IbI3lGpGOo8bZd42nZI+E8b1bSoAZAeTN7AncZe7q32rFMUqdnnNpq0GLtcsgUWp57J
 Pyw7iWplmqgQUxcWajERf+YkhqQsg2owUo+B8ZCX1wP/RQEX6RQzacFHWqQZv9vx7H2X
 Cs1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165139; x=1717769939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fqU0YFx6cSRjVw2zD+R0tht6d4TzcGxYEhidKZzMmv8=;
 b=LOgeaJLaOkDzs03WM2Wnkj2/KtTkqV1i8U+pGoNTQiyHsj6TIYjUHNMW1fjV0be4pu
 wBuTeq86sos14nqBYRL0W0dApUCgRgjU9bTzTUPGoA5tRgXiPSKdl+SwIjxOS9jLJZ3u
 TnLKv/oSjgefPZVPu7hNMCiYMUYu7IKwSgIjSjyO8Yah5dC03Jen3cg2KS7QHlicmZcB
 TAiu6sIXoaDeGQ2m58hAEvig8pSj1hqBk4A1uYGkc68HzrBY0TXfCjvyUVEiQODpE4j+
 jt9sxC225SiV6hefG35UprLiSQNILHLJp4+qQ28AH7ZgvhizKPMNmrshNPymu6geGB+1
 bA/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo5W74IaFlwK8BH52fUyYUg6EDfVqVk7V6hojTzOBpZzMSq8hkNHLlQY0vpaMfo9btsIZJclR6S77BOZ0HkpgDkHs+Tw==
X-Gm-Message-State: AOJu0YzT6m4s/f71XI/LMEXGuKHdNdxQl1P9xQZyfKU4nV6FghLLZIzl
 AP7qWCav5mbuCsIqADtyWDGEa8SdvvEqcd7AHatNT/Q6ofbE6knyFnRWqk4H
X-Google-Smtp-Source: AGHT+IEFnQm08GpBzoWr4iIsJEtK7PGuLNYMmqqKOHNA0LSvQ6g3xHbxP2gAvyKY0xoRO7sVQBgx4A==
X-Received: by 2002:a17:90a:eb8a:b0:2c1:a74d:653a with SMTP id
 98e67ed59e1d1-2c1dc57ceb7mr1834119a91.16.1717165139536; 
 Fri, 31 May 2024 07:18:59 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:18:59 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 02/23] rockchip: RK3328: Enable display cpuinfo support
 on all boards
Date: Fri, 31 May 2024 19:48:16 +0530
Message-ID: <20240531141837.13189-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240531141837.13189-1-linux.amoon@gmail.com>
References: <20240531141837.13189-1-linux.amoon@gmail.com>
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

From: Anand Moon <anand@edgeble.ai>

Enable DISPLAY_CPUINFO options to support on all RK3328 boards,
Its used to determine the reset cause of the board.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/evb-rk3328_defconfig                  | 1 -
 configs/nanopi-r2c-plus-rk3328_defconfig      | 1 -
 configs/nanopi-r2c-rk3328_defconfig           | 1 -
 configs/nanopi-r2s-rk3328_defconfig           | 1 -
 configs/orangepi-r1-plus-lts-rk3328_defconfig | 1 -
 configs/orangepi-r1-plus-rk3328_defconfig     | 1 -
 configs/roc-cc-rk3328_defconfig               | 1 -
 configs/rock-pi-e-rk3328_defconfig            | 1 -
 configs/rock64-rk3328_defconfig               | 1 -
 9 files changed, 9 deletions(-)

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
2.44.0

