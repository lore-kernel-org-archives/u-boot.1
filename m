Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56950C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40F0A885EC;
	Fri, 21 Jun 2024 01:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dXFHa0d5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C151885A0; Fri, 21 Jun 2024 01:06:54 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A583885B6
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7f39116e564so9051139f.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718924811; x=1719529611; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CiMow7s4j2CsLyjXWJPRpZ4yYDVro6zP4w6YhlUwuAw=;
 b=dXFHa0d5liYw1BbI6VAl5/jvNsdAV/S18d6LOTRaQEZyrlR1qyaMvZT1bbKF3BaWvZ
 01RiFlU5nY7tbazy+Q4TwibNl6pwnuoi50jHmzOZfFrIo6kn2mS5VX37sBR3T6BsI2GG
 kMT8dvVSCtGhCjFIgx2JfKgLUDJnMtMNtdlro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718924811; x=1719529611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CiMow7s4j2CsLyjXWJPRpZ4yYDVro6zP4w6YhlUwuAw=;
 b=k8TLXIUzpR44Fv5xuCpSTFCNlqH80yupLlaYBJ+oiZHBzFEKwIEMO28s7DDSYrg9BE
 lfOiMyqmstqOwpX5+/Kz/nClzFcc+kuiKsnmB4kl6qIS2kutzCQ9VWkv8h5W/wJsFnqJ
 7eB9IESkfoDv6SCLZJ9fKF17fLEOuat5efhgpx6mC0pAKKktyn81gMNptw1w4v52y/YM
 eifzYTxaPCxtvtpAqq/DPZahgiOYE4pLlXg7/CLKJ2fqElnUqrgvZ4RYhNOOHC/q2Oob
 98bbIZ6wffpzXankmoLGyiwLuEFJ5+ZpiiK9+Hs02v1RVe+PJ8FjxY9V8P1UgXzZEIxO
 HYHg==
X-Gm-Message-State: AOJu0Yy4Fa0ziDG+e10pbZvH2HXVr3dJt2wmLy98jGB5dcuw2EmW6YkP
 NpjTwW69CxQjf/VWkq1ekM1IwM0/IUtIkEq+Txz83SYTnYEZ/ExPecwuk2tvbLTzq8MLgY9WSt6
 RLA==
X-Google-Smtp-Source: AGHT+IH0SlKS1hTLNZd6rnzvto58I9YU+TqW6mc2r0ngbcdHDElYHCLNLRm7Inf5ZXJj5yeZ+RfQEw==
X-Received: by 2002:a05:6602:3421:b0:7f1:3ad1:234e with SMTP id
 ca18e2360f4ac-7f13eea32f1mr828065639f.18.1718924811135; 
 Thu, 20 Jun 2024 16:06:51 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d110f566sm53269173.44.2024.06.20.16.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:06:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Dragan Simic <dsimic@manjaro.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH v3 17/18] rockchip: bob: kevin: Disable dcache in SPL
Date: Thu, 20 Jun 2024 17:06:24 -0600
Message-Id: <20240620230625.1797397-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620230625.1797397-1-sjg@chromium.org>
References: <20240620230625.1797397-1-sjg@chromium.org>
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

