Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE07E7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BF638069C;
	Wed,  1 Jan 2025 23:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ULcFsVqg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49F7080352; Wed,  1 Jan 2025 23:13:29 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D97A803F6
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-219f8263ae0so104946995ad.0
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769605; x=1736374405; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+C5MhFPMn5qrfSSLm4bFt7rFemRSJOaIjpq4YcJkCD0=;
 b=ULcFsVqg4jzOgLjSBtH04SXakMyyD1ejONOTBj5aYQI9d+xzH7L5z6ekPdxrNPws6F
 ssBQrjuGyRS5YJNmMbyVwMIHn9knfoocKclkujeA4y6OAYg4oLD56fWxdfttf6sx2q6x
 kivhCuyLy1UWxLy3bQnCWOzqDiV58WmKdUpFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769605; x=1736374405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+C5MhFPMn5qrfSSLm4bFt7rFemRSJOaIjpq4YcJkCD0=;
 b=J4KHzNaQfh0yUupnu2YstCegRQc3MR2Cie+8mwr8xgXP9G5LSAAim/DptqaI4dw5+y
 QNnag2mi0eJPAKgspQqC+8bkD0LqugxPDI9r2dhGCYNOpFra586ac0HaX5EDjKRrJUdb
 CuFouuhPuc9bh5N82U8LIPg5ApFXX0rZ5HjUkTdxC/CalEWxgi6BANKDs+8SXCZa2bhA
 NqTvBiK46wIpFAY0ohZL7Xx5/OJXGib9Aopf5I29dsCNK7qg8rNc8CehcJZzm6fqSzUF
 Hj/LsUNmEvLs8ntGhNi6TasKCcgpo9t7Bhd33V6PgRMoG0KFYAb3v9r7Lp/U/UxEgqJB
 RdcA==
X-Gm-Message-State: AOJu0YzEqOK/lb13jjnY6ELAnrG0c2TBOpjIiePZpn+CkCl1EBE+iV7a
 8Ye8P+Y4hvSKblG9G5N5ToJN6LS6V3yLwE6Yik4d6Wm4wvQRCgDVdqZbSI14wM/tgGgb4Wu7eRU
 =
X-Gm-Gg: ASbGncvayZZ1VmuPTddQS9UcEb417p7X6XD3FDDMHyGCFJTUx7Hlsq2mv2hN834Y07/
 1oZFdGNj5hCjCW3hzRzL07nkEE5/c3HScDfsRhOXhlrk+qY7BCLQhpuHc4TnnCDwzTpsLfW2Lmy
 wwiEECPDdvlKyQh6leW/Sk9EwVPGWdlkK6ZDqHyFP6HnoPOXFM2R3kfPtwuHwUT57VwMAAQCTi+
 CP2+0qaIVmHfHPJqM6Q74Jpr5YTPeSTlxLEyiX7b4KCZzsQLLLN/VI=
X-Google-Smtp-Source: AGHT+IF/clgQlMRGxcTwdy44yq0SPjV6K9v74qCEv1YPXfyF/K96tvAbM3L3fBpT7DhC7BiT8jktsQ==
X-Received: by 2002:a05:6a20:c70b:b0:1e1:c054:4c58 with SMTP id
 adf61e73a8af0-1e5e0450020mr68708669637.2.1735769604986; 
 Wed, 01 Jan 2025 14:13:24 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.13.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:13:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 30/67] x86: Show an error if video fails
Date: Thu,  2 Jan 2025 11:09:16 +1300
Message-ID: <20250101221003.1944600-31-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

If video is enabled we expect it to work. Avoid silent failure by adding
a panic if things go wrong.

Expand the SPL malloc-area for qemu-x86_64 to avoid a panic.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/lib/spl.c            | 9 +++++++--
 configs/qemu-x86_64_defconfig | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index f761fbc8bc3..aad748532d0 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -300,9 +300,14 @@ void spl_board_init(void)
 
 	if (CONFIG_IS_ENABLED(VIDEO)) {
 		struct udevice *dev;
+		int ret;
 
 		/* Set up PCI video in SPL if required */
-		uclass_first_device_err(UCLASS_PCI, &dev);
-		uclass_first_device_err(UCLASS_VIDEO, &dev);
+		ret = uclass_first_device_err(UCLASS_PCI, &dev);
+		if (ret)
+			panic("Failed to set up PCI");
+		ret = uclass_first_device_err(UCLASS_VIDEO, &dev);
+		if (ret)
+			panic("Failed to set up video");
 	}
 }
diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index 39375c76227..2771a4b9e19 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -6,7 +6,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_MAX_CPUS=2
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="qemu-x86_i440fx"
-CONFIG_SPL_SYS_MALLOC_F_LEN=0x2000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x3000
 CONFIG_SPL_TEXT_BASE=0xfffd0000
 CONFIG_DEBUG_UART_BASE=0x3f8
 CONFIG_DEBUG_UART_CLOCK=1843200
-- 
2.43.0

