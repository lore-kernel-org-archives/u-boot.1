Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF1AC27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FC57885AE;
	Mon, 10 Jun 2024 16:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dFzFjuRE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D60C885FD; Mon, 10 Jun 2024 16:59:50 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F5A6885AE
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 16:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-375b27243e5so349885ab.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718031587; x=1718636387; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CiMow7s4j2CsLyjXWJPRpZ4yYDVro6zP4w6YhlUwuAw=;
 b=dFzFjuREbJZJR3rwuViXt/W8ZrqhFEtT/5dJqZyXUhNpmeFiggRw9zwUQpXlT9tsgw
 EL1kbzPb5rAJnP1DbtlLWc+5eKTcRVYSQ/DbMW8k0Vb19fFHVfoPw97FXmN0KZUojHUT
 safDdPUuSBYl7Bn4MixUL62HpkQHewyD7cwDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031587; x=1718636387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CiMow7s4j2CsLyjXWJPRpZ4yYDVro6zP4w6YhlUwuAw=;
 b=ZVE6Erti03vh4eRV/wSR2vTpfyN2NJMWILCZ1GEWhj8twFW8s4gRIePwMisJg9YHfS
 ylus7yOgyJzdxpDMQ8izrB7dsmyKMiQUYiL3Yd4+TDqlJVPxR9fSp6Y1YecNX4FJlot1
 xTjm54ZdHub2eVEm+J1W6K3EZNE9Xoi6Kly7hT0gR+ih2leP5ae6TkCyAJWgHU0/XBy4
 jnECSJnYFDvDfj724XBnDY4FjNg+TSUmCIB1afJ8xodLIBLpjGZhdGjl4w3nbZGdLRZV
 eOt6m1/Q2WvJ7Wf2rwDhuM6UU1o9CvKMTp5Wc4Gy6WAmpWXzZMJ1dQe1DaQzd7jP8VZQ
 UqyQ==
X-Gm-Message-State: AOJu0YyrnY4B/9ScHeFv1ry84Ff1rYbb/ytsjDRFtrJItrp5pk8pC1N5
 dLHkOESwKEwMNw0QuEII5ZGyWpLI9n46MV3UCi5mUAwP/h9a3SEcHaXth2T0eTtaRMPEkSXq11f
 Kfg==
X-Google-Smtp-Source: AGHT+IElJpWNjnhnHZoCwFrr48lqXNOrclXfgl/M5/PynHA7239DmunD3WzYXdG8WT2yQBBo7TDh/w==
X-Received: by 2002:a05:6e02:1a69:b0:374:a5f0:d580 with SMTP id
 e9e14a558f8ab-37580309953mr121490755ab.5.1718031586948; 
 Mon, 10 Jun 2024 07:59:46 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ac6104dasm2526885ab.4.2024.06.10.07.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 07:59:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Dragan Simic <dsimic@manjaro.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH v2 8/9] rockchip: bob: kevin: Disable dcache in SPL
Date: Mon, 10 Jun 2024 08:59:19 -0600
Message-Id: <20240610145920.3302001-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610145920.3302001-1-sjg@chromium.org>
References: <20240610145920.3302001-1-sjg@chromium.org>
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

This causes a hang, so disable it. Unfortunately the RAM-size fix does
not resolve the problem and I am unsure what is wrong. As soon as the
cache is enabled the board appears to hang.

Fixes: 6d8cdfd1536 ("rockchip: spl: Enable caches to speed up checksum validation")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/chromebook_bob_defconfig   | 1 +
 configs/chromebook_kevin_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index acfe3934104..b2ecfa6050c 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -1,5 +1,6 @@
 CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_SPL_SYS_DCACHE_OFF=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x00200000
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index 95fdb418d82..da748e4f022 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_SYS_DCACHE_OFF=y
 CONFIG_TEXT_BASE=0x00200000
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
-- 
2.34.1

