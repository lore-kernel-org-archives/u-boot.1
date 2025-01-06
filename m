Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1287E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47600806D5;
	Mon,  6 Jan 2025 15:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fYczKKRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D248806D5; Mon,  6 Jan 2025 15:33:54 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9C2B806FE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a816cc9483so112416035ab.3
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174030; x=1736778830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=spqHqXdrlvhqc6cfitlakRXzVJ2zr1zOvxSrSQuaA0A=;
 b=fYczKKRUn7i0qQu6Soc0K5cuUPn5DAZjYgIKIM4zMJTkH/oCiO+VnayIVBo4Yoq6An
 zQrlbTL9Annf4sekCWzYU/LnGmGHkS7xKIdZ7LGNXsJ7G+VN975uOTySDjQGy0ckROBz
 r5I7SMCwPf1RZdmCiwed0QfXHnI6syH3ais1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174030; x=1736778830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=spqHqXdrlvhqc6cfitlakRXzVJ2zr1zOvxSrSQuaA0A=;
 b=k8L2LHkaTfCJP5Ku+2YaKxTZlfnvpVm2irYgYqtE/DBakruaSEn/8IxHwGHv5qHha8
 y7BkG5UGXwh/TSn8wxBTDD9rh/7KYyHru+6AgTymRTm5YK8zfl7ljl6xKEiz3q8mL0Ee
 YiM5/51zfGbVgvkmP+IeQzbqAUjLW3SnGXbSHAEFFoXRbbqfU+vl7OsdtzULlVhBMbAH
 7ruqpMoJ18O2O0juLhAbWFs7zzOvxCH+DVOi/bpSaEuP7I/Qhr3iVtZmEYTRaC+gDbrs
 FTC/bKNJw+wlUgyhpkdWXQfvKGUuff2BLpvsgAKiPQHaNNFUjSeYtFk9yqA1ICj+OCnw
 xszg==
X-Gm-Message-State: AOJu0Yxl6SNEXz0L7N0OhMahTFxggaxisdHqweC017HAN3w97igsXYYw
 pzGjlKJ2pKxq4z+QXsH362Gqf5rsMYIniA8YvXNvR5cHkehXlxz7+3hPOWNhujUzJCZH4ZHyuEk
 =
X-Gm-Gg: ASbGncvHCSD8Pr9TK0sf53Yy3FQ7zt0ufl88JTYk3CmAHqmR18oCXb1Mw2Dg6UIgb2y
 eyitSHrPjKW08iaLfzQrBrmxhSOKtKCZU/6tWOX4z0zfPguwtSdRKVnanY/G6bPe8+Lbtiu66/H
 mczmsMKTwZCGCDGB5lDOErG2IzzMx5g5KYeX1fSJGP2uX6fQp+4rAR/J+2JAph+EUCFbntl5N7s
 RTEvOzId892DOZfROIFezL4iiaRg4CojVZH8FUfSdfvr41s7ucerm6JgmxbPOZ+3+RtEZKIMf1c
 ZhIC2Lts8a/J+gU+5A==
X-Google-Smtp-Source: AGHT+IE7OMjXnT6KlIO1MaqBjAG8Hh+wE62sluOuEMRaC/Z7BdxeQUlYxW4xBzvPsiWFFsPfd8ldBg==
X-Received: by 2002:a05:6e02:1c42:b0:3a7:87f2:b00e with SMTP id
 e9e14a558f8ab-3c2d533f04dmr485568065ab.19.1736174029922; 
 Mon, 06 Jan 2025 06:33:49 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 25/33] x86: Show an error if video fails
Date: Mon,  6 Jan 2025 07:32:21 -0700
Message-Id: <20250106143229.3023771-26-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

(no changes since v1)

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
2.34.1

