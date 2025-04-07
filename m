Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6354C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 938C182FAB;
	Mon,  7 Apr 2025 19:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gpiFkNlD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F130082FB8; Mon,  7 Apr 2025 19:00:08 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1514582F1D
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 19:00:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e5dce099f4so5990123a12.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744045205; x=1744650005; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ArCj8rgfxnWPcLeBishb3HGe4HRwK8ZgVzO2/E8aoXc=;
 b=gpiFkNlD9Ytq2YYo7oW7sF5KadmfqSSsxqbUxKDIPrE8jNaRLSFV6dAlhlmNK8Fe2k
 QtM4M7G7ZiN8KwNa+mazLqA4X0dIADV2ZsuC/RspXotApU3YvSXQr5J164SvjydaS8jS
 zlS1oEOu+EhnwUtlWrnwzAGlpttuEo0IHPrgpwG+FU8F5jgMRMwdsdqQKM1NBvmgCCcq
 rSA4TlPiC+RrF4GYCBVGT69+ZC5LlpEQwNzErz4oSfDr8bqEEx6D39c+OyXsIbUAJpAb
 Sq0zKFS6rvelEjhalijCdAv+msBXM7yqHvmfKq+Zw/fJN1RZCv/8uO3YNPY/X6InXgDL
 Nrdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744045205; x=1744650005;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ArCj8rgfxnWPcLeBishb3HGe4HRwK8ZgVzO2/E8aoXc=;
 b=sVS8j6UvsCTDcMmMMZ/Wuo513RjvsaClhbHgpEhz6WlZcWl3XfvapvWKh4PRurP37N
 Xpcf5nOXgwV0eI1uHd8KVpT3Pc9LNVmkoTj60r77qj6N3Cpk08z1FmtvHeAj9XbDw5tI
 pZqCgeDPygENI+eFiBXwBJv1g2BDkSkKfS/cYhaxpshhCyezRupMdQUc1GSJenhgC24s
 smXmEqeYwOp9o8CCBuyf1NLM32DVWk8AZDmErpBNrV9w7rUyW2EfLodtvA8HMy9kIe/Q
 bfbXl1jj5VWLeBiEyTa49x33HRkk3f2KxFSDjvIRN4CIybMCkIX2kX9mkun9oYEra9AP
 L59g==
X-Forwarded-Encrypted: i=1;
 AJvYcCULLzoyJGwMq+l1Tu3t2dM9Ro6GwwaX+Ze6Xs8VM8FjMX8cqNcO53E/i5G/a8OOF3QtOoR1Hcs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx51m/c19xGuCHmPdmbjleaw8ZXlpMqL2s03N60DjDZVqZX7Z7o
 6FC/7f41GSaiD9LZlkTScqYSR+LVEyvJkVBpguGU7UX4gh10ytwJfOVFHK8zjes=
X-Gm-Gg: ASbGncssYT9Jv5/9iUuge8+GWLbsxeYQ/dFCQMta/x0PTKE/dIGCVcC3QGu9Gyv4w1U
 C8Rk8ZjpVtsdailGiMjweN8PmbpqHBKQLDh83ujl0r3hO24mGa8DqsbDyH33ZJXerXrd9/eMfKP
 Kmpkex5X/V0x1r9vdval8d8eMO5YG7G9nUMOjLJyHc27UknA/XU6m8IusWl/kmp4DMTZW4gFNoU
 uw0oK4ca6KQeXW11QCA9CM+hIVdi72yFOOfkrUCuADYq1/CGIdcb6thP7qsyYO0XAG7bZnCdwjE
 hNgAQaJZ14kGfhBIDbQ1LD8qPAANQVtbOkwlXi3qDPgyKQU/zbbKtZgn5w==
X-Google-Smtp-Source: AGHT+IGrAKrIUy9XYMmt1sVcjW49jgZWpaVta0CVu8OugBun/FG2Br8CQmTyEji498RqFqHNeFWlNw==
X-Received: by 2002:a17:907:7f9f:b0:abf:6f87:c720 with SMTP id
 a640c23a62f3a-ac7d6d5672fmr1313266566b.29.1744045205442; 
 Mon, 07 Apr 2025 10:00:05 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea16aesm773603666b.70.2025.04.07.10.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 10:00:04 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 07 Apr 2025 18:59:32 +0200
Subject: [PATCH 11/13] board: dragonboard410c: Enable support for Android
 boot images
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-db410c-fixes-v1-11-524aefbc8bb4@linaro.org>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
In-Reply-To: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
X-Mailer: b4 0.14.2
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

The U-Boot port for DB410c still has plenty of extra space available at
this point, so avoid disabling features that would be normally enabled by
default. In particular, this incldues support for Android boot images,
which is quite likely to be used together with the USB Fastboot interface.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 configs/dragonboard410c_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index 62fc42c9460d075fd27c3e2823eb8eea2a559772..414dda6778c95eb3fdcd6ef522d8c7d0ef9219fa 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -14,7 +14,6 @@ CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x80080000
 CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"
 CONFIG_REMAKE_ELF=y
-# CONFIG_ANDROID_BOOT_IMAGE is not set
 CONFIG_FIT=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
@@ -25,7 +24,6 @@ CONFIG_SYS_PBSIZE=548
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_MISC_INIT_R=y
 CONFIG_SYS_PROMPT="dragonboard410c => "
-# CONFIG_CMD_IMI is not set
 CONFIG_CMD_MD5SUM=y
 CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_GPIO=y

-- 
2.47.2

