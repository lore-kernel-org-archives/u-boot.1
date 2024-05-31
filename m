Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5629AC25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 14:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47C79887D8;
	Fri, 31 May 2024 16:19:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BgLckHsE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27FDE887F8; Fri, 31 May 2024 16:19:32 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7C04885AF
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 16:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c1ab9e17f6so1563685a91.1
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 07:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717165168; x=1717769968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldv8d1u7EFBM36PHkHT8SbQcO5ocz8zS0Zff+n3f/EI=;
 b=BgLckHsEDkPxhyIKiRCbnUJdeQDUbNL/+ltd5UnCG1x8T4/ePZc5oKyfm0txXmLNos
 xLGz+An/ghmLYjMDyxfbncz7Ig8jMvFcU6jW9QysQjOGo9bbk9DwlJ2syUdbfcLfd4N3
 8g/qgD1Wj0GxZJZqh7PJIHopOKy7q2sVEB0yVG7ruhgrJ6ghcs8/lK8tJYVF/G50kESx
 YwT7qL8KANSnmh3yau63b+1SejMUW1LQxjH3JOkju2+vc3bIw0FPq/PpNdC6wx4x2f4F
 hP9Bk7/Y7UmKdJljYAV0Z83NUddk5ROpTz5kfl0xeVI/7K4YLk20F8EuxOk7Tq2aNoAK
 JmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717165168; x=1717769968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldv8d1u7EFBM36PHkHT8SbQcO5ocz8zS0Zff+n3f/EI=;
 b=AU/OmW2KudM+cEDf+4fI2K0ksJ3SnJWyqEOZ+EkU9rROksScHCxAGb8ojHDDrHHvWG
 5uHbQMOI0bLRfaRFMcNTRuACUyWxYV0iwbqiLNjZWN59WlnjQ4p7LRC2iCBlrggQdC/I
 n3YlfG6IXgj5ksZCrStN7jLv1pxnj7vCZRl4btqELvqERdhpJMQGAOoJcKI1kBODmD3a
 BIsOyo3+z2qb/Qy03Q1D/8HMAP7SpFqvev8pujeyhDc2ePKWeLK8Uyspi1/VWI3Dr7S1
 anc1QL6TiPTye+/TWDh8hSuBISRoXYTKJQinMG3z2a2UQv5GL5mzoRVqnnxnwv+sBFcv
 2SYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQVJkx1SQjCP7yF2T6xMeRk/Jb7Az5cL3jgUK/+q1jnF7sN4BECuQN4wteRzXUkV/fhRtnvtc1PMH4xl159I+n+kNvsA==
X-Gm-Message-State: AOJu0YxZCqtiQ06wujlXsdVwTjrNmngzSnbqaAoZhGiER7upd+BQyCaT
 ntQRyI1SDgci9r2OjDTO0Wp01yGA/7LqYLNBD/M8QWNmsoImiw5p
X-Google-Smtp-Source: AGHT+IHkeN4U6y2mNLzRhnPZeaBtTz6cdeY27GGPf69f0/Uy6JiMB6Z1QeNZ2vqVW0hUmu2fp3+Xog==
X-Received: by 2002:a17:90a:e657:b0:2b8:c813:1696 with SMTP id
 98e67ed59e1d1-2c1dc56d974mr1851544a91.10.1717165168408; 
 Fri, 31 May 2024 07:19:28 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775ccedsm3563935a91.1.2024.05.31.07.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 07:19:28 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>, Jagan Teki <jagan@edgeble.ai>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Anand Moon <anand@edgeble.ai>, Anand Moon <linux.amoon@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH RFC v2 11/23] rockchip: PX30: Enable display cpuinfo support
 on all boards
Date: Fri, 31 May 2024 19:48:25 +0530
Message-ID: <20240531141837.13189-12-linux.amoon@gmail.com>
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

Enable DISPLAY_CPUINFO options to support on all PX30 boards.
Its used to determine the reset cause of the board.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 configs/evb-px30_defconfig                    | 1 -
 configs/firefly-px30_defconfig                | 1 -
 configs/px30-core-ctouch2-of10-px30_defconfig | 1 -
 configs/px30-core-ctouch2-px30_defconfig      | 1 -
 configs/px30-core-edimm2.2-px30_defconfig     | 1 -
 configs/ringneck-px30_defconfig               | 1 -
 6 files changed, 6 deletions(-)

diff --git a/configs/evb-px30_defconfig b/configs/evb-px30_defconfig
index 73a3c6120e..72b562ed69 100644
--- a/configs/evb-px30_defconfig
+++ b/configs/evb-px30_defconfig
@@ -32,7 +32,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/px30-evb.dtb"
 # CONFIG_CONSOLE_MUX is not set
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
diff --git a/configs/firefly-px30_defconfig b/configs/firefly-px30_defconfig
index 0a14b39366..2310c0bdc5 100644
--- a/configs/firefly-px30_defconfig
+++ b/configs/firefly-px30_defconfig
@@ -33,7 +33,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/px30-firefly.dtb"
 # CONFIG_CONSOLE_MUX is not set
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
diff --git a/configs/px30-core-ctouch2-of10-px30_defconfig b/configs/px30-core-ctouch2-of10-px30_defconfig
index 87a39e115d..3c9b9b8493 100644
--- a/configs/px30-core-ctouch2-of10-px30_defconfig
+++ b/configs/px30-core-ctouch2-of10-px30_defconfig
@@ -33,7 +33,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/px30-engicam-px30-core-ctouch2-of10.dtb"
 # CONFIG_CONSOLE_MUX is not set
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
diff --git a/configs/px30-core-ctouch2-px30_defconfig b/configs/px30-core-ctouch2-px30_defconfig
index 7162c117be..3040fc5405 100644
--- a/configs/px30-core-ctouch2-px30_defconfig
+++ b/configs/px30-core-ctouch2-px30_defconfig
@@ -33,7 +33,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/px30-engicam-px30-core-ctouch2.dtb"
 # CONFIG_CONSOLE_MUX is not set
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
diff --git a/configs/px30-core-edimm2.2-px30_defconfig b/configs/px30-core-edimm2.2-px30_defconfig
index 1182f60358..7431bedf7a 100644
--- a/configs/px30-core-edimm2.2-px30_defconfig
+++ b/configs/px30-core-edimm2.2-px30_defconfig
@@ -33,7 +33,6 @@ CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/px30-engicam-px30-core-edimm2.2.dtb"
 # CONFIG_CONSOLE_MUX is not set
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index 94179dca3a..f571eb6b11 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -21,7 +21,6 @@ CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/px30-ringneck-haikou.dtb"
-# CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x20000
-- 
2.44.0

