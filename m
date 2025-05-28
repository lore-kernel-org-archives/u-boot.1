Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19288C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 249CE839FA;
	Wed, 28 May 2025 10:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mSm35eFp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F2DE83A1A; Wed, 28 May 2025 10:26:43 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F298839B9
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:26:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d8020ba858so37928335ab.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748420799; x=1749025599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yvS//xyHPNB3NaasQym2+KXQCjCyAzbHkXtIwBR40JY=;
 b=mSm35eFptP8yYWJWtLevOIZdM4A3y61Zr+KcBodXjTLmhEtIAvYRD6x1mMToMzqruC
 510x9s2GZQYQPbhsCNUIUIJBwBt89R4j7/T9wYc1NZVc4GYePRfjLePyezwogO1hmTB0
 cE45kYIK1RmCoX2R7dAGomSw99vqY0GhkqPzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420799; x=1749025599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvS//xyHPNB3NaasQym2+KXQCjCyAzbHkXtIwBR40JY=;
 b=ZGnFqapb1U0aOqvIlZ98SMUVh33f1UUY3JG8f3OIV9TEw2OfvvabKTvdfoywmhJbDc
 0vaDQOQ3c4BpUGQn+wevm//ydvwXxduRYTQEYZyLk0UH/QevXzQlq6HEobhaTKpp3JQt
 y/7LX9vjXU9qUcssczfNe+xtaTS209O4blBtwTc0egQ/40A3U9kqbbVHe0igbm7+z6jj
 3gg3YWswHLQVfijLRQ4P5n14KRIsBt1I7vGOtNTcQQdQqEuWt5gnC7qePQv8hP8/t9Ob
 J9vH/JZDLFOqF3FGEKPQse5xpZScDxcDoQuqBKaCtA8uh/IKc5T43xhhQJtTqy43KwMT
 5nlg==
X-Gm-Message-State: AOJu0YwwP9Bm3yDBThj1UPRuVORneqYKU4veQ46Bbno9V20I9KMUcnad
 fkWEXW30xk8ls/rk+cWaPnvQMvl1rm/cjaVElHQWgVoTT2EtJglgb7cek+XnCg0f3f7xbt5lQQc
 94shUVMJc
X-Gm-Gg: ASbGncv+Pj9tc2bpJ1sPM04ppX6OIBR7aYEifGO4soQt+qDp4uM2d7Ru7QmiPrMLCJJ
 cKY/ZE8L29ZI37AobeNHTHmHk0cWmD0W+L/r5NiVTKLrZMtzPSDJkHe3mzFDXbNVqEZGfVxUb5M
 OoFPo3c+9T3dBBUkL9l3kCwXaEy+uWx9zVgo7hdrH1oPg3deJcKEB53N5ZMMOdzc39qQIzZ+Xrw
 crlpVo2FUmoTzDOZyyLx3LDXFWNpmCa8StlUVdfksX4hP1DbrduU48Xl9vhYs3Vo0PtiRRHAVGu
 adExuUVJQIgVohwt9ibEOr/SncXxwhKiGoNTKOwyxm/NLUJ2Rn1Fm28JMTYUKtnJrsUiOQqdauv
 uT5Gp6O8sKTNfMmgtgluEAfQ=
X-Google-Smtp-Source: AGHT+IHCU7arLn7SjAUtoZwBI66XpUL4DhaVevbqsN/vTUVarsPhSPXrmk98BHom3frCJMDNifiFNQ==
X-Received: by 2002:a05:6e02:23c3:b0:3dc:8797:a8bf with SMTP id
 e9e14a558f8ab-3dc9b54590fmr158239365ab.0.1748420799400; 
 Wed, 28 May 2025 01:26:39 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dd8b880f80sm1870385ab.0.2025.05.28.01.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:26:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 25/27] x86: efi: Drop some unused options
Date: Wed, 28 May 2025 02:24:51 -0600
Message-ID: <20250528082520.152391-26-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
References: <20250528082520.152391-1-sjg@chromium.org>
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

The cache is managed by the first-stage EFI firmware, so the 'cache'
command is not useful.

SCSI and AHCI are not used in the app, since it relies on EFI for all
block devices.

Make sure all three options are not present in the 32/64-bit apps.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/efi-x86_app32_defconfig | 2 ++
 configs/efi-x86_app64_defconfig | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index 229a4004c0b..2a7d6c9916e 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -6,6 +6,7 @@ CONFIG_DEBUG_UART_BASE=0x0
 CONFIG_DEBUG_UART_CLOCK=0
 CONFIG_ARCH_EFI_X86=y
 CONFIG_DEBUG_UART=y
+# CONFIG_AHCI is not set
 CONFIG_TARGET_EFI_X86_APP32=y
 CONFIG_EFI_CLIENT=y
 CONFIG_FIT=y
@@ -38,4 +39,5 @@ CONFIG_BOOTFILE="bzImage"
 CONFIG_NO_NET=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
+# CONFIG_SCSI is not set
 # CONFIG_GZIP is not set
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index 39b0137686a..e822dd24f00 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -7,6 +7,7 @@ CONFIG_DEBUG_UART_CLOCK=0
 CONFIG_X86_RUN_64BIT=y
 CONFIG_ARCH_EFI_X86=y
 CONFIG_DEBUG_UART=y
+# CONFIG_AHCI is not set
 CONFIG_TARGET_EFI_X86_APP64=y
 CONFIG_EFI_CLIENT=y
 CONFIG_EFI_APP_64BIT=y
@@ -24,8 +25,6 @@ CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_PART=y
-# CONFIG_CMD_SCSI is not set
-CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
@@ -42,6 +41,7 @@ CONFIG_BOOTFILE="bzImage"
 CONFIG_NO_NET=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
+# CONFIG_SCSI is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
-- 
2.43.0

