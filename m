Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F4CCD3439
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 14:55:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 562ED84B07;
	Thu,  7 May 2026 16:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="wSwsaaS1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A9A684A78; Thu,  7 May 2026 16:54:46 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DCCC84AD3
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 16:54:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6967080e6c0so541618eaf.2
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 07:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778165682; x=1778770482;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fia5z2D6Ws7OdJcOCt5tCMzA+j5d/K6pTvb5/EgqNOI=;
 b=wSwsaaS1CZnCdr2Zixs0rgcM4Hk0dHstdGmpBbOaFkjBgNnhKNUU9SvmBX+IxvloMO
 A4jxBRyzGwsUDa3CalS6Q43Nxc1qLGJuk62jQcQmnNtN1PNzI2DpFUv+VHwUIuatxo32
 j6HnWxi349U4ViA54LcnnBTxes1g7wLxq3zQIiwlnsT6hR2e3Kh82OamoAP2Nk1HIRb4
 jHCzjoqL80MZMeDdvjNC6ndnzRU0xyIxJJoEnxBsy9gkeY1xeJOaEc81Wil6yqTEDc/8
 mBC5bNT+XatqfOxrzf4vqS6fxJkm0RNlsX5qCM7ZWBKaHDh8Dcrx6cX9+8bzHTiuzfh8
 A4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778165682; x=1778770482;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fia5z2D6Ws7OdJcOCt5tCMzA+j5d/K6pTvb5/EgqNOI=;
 b=r3VWbaSSFTqlvbgOme8Xetn66/7Tvj0NuhAjtjvRLeDQEn3eHiETBAt2zffkNQXzYR
 Bp8mePaz8ty1Ibd/YpQdZVFLPInGPyoeltA6YSsBJ8IBKY28Q76gA6pSxUlL/PiOVK2c
 FYomVrxqH7CT6/JIXJNpHYVjuSicVHBEtxFgmAPoBjxLt9+OhDTy9pPYranYwJUMYunE
 JNjvNlhy6Khgdw7XJioWlZ7XajOY/D/dZQ8q4Jorvg84zl4KqeekHMXnfOw37AUaC2hg
 3i0mw626DRB0hQUqcbvEUwH6pi6gSsXzTJKxqVbd492/uhnLnfC88ImtjersE9Kym2cc
 D70g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Xzlm3r/KVTY0Kg+Gkg/wEToYfo61pzySK1EmRZxLxJaPgqYZi3p22IhH19HEgzHkUHrAPxfY=@lists.denx.de
X-Gm-Message-State: AOJu0YxeQXDo3Dh8iTcfuu+uogA7Kek6tZtdW/khCI66eD5W6nR4k3Xd
 rl0CdHmD15l1wmRXCT0vz+ixzjJqNbSu7Btcwy7Q1KzpdN+TEan5tMdmo1CddMo3dHToZM2h+YL
 EeIuk
X-Gm-Gg: AeBDieuHJC3fiWk9TH5MYOjJrmi7WJ5JWink+trBsyEfo9+9wG8uEpS12waLEHtlcF+
 QBk31uuzdageJglbbjiJ8nIdv4vzGEYLndyHKPUAbwCRz3axK27S6JRJBufQgzQpOACWsPSRbpq
 CsWRcaoy2BqCwS0K+GzC3TvANHCeYOnu+qn9+ePBf7GXMacC4mCz/aK7KaS131hHkMDsWSOH+3q
 oUU06276YOrpX/bOqvPTI/Iw+aznxbt5tDhKg2ZzCRcUrVbDIay8Zs2V55ubf2WeeJpEbK0qWHI
 zxrRW0P3IhKJsGpbWS+mz49NVYrdCr8ZzvQl8e6Res65eD8Swx28/zvh81uxqPkWk+C/j5jUgpB
 Sz4/SFig+beBEKg5CYVjKYUcy7cUOHtigSLpfnkGjBKg9OxN+N7FdKLWub+joK6ISJVDE8QNpVU
 yALlIIGSY7n6Z6YpOZAMuc/aCJq78FdCbh3+LWeVY=
X-Received: by 2002:a05:6820:160f:b0:695:b571:e579 with SMTP id
 006d021491bc7-69998c8fb84mr4680280eaf.10.1778165682058; 
 Thu, 07 May 2026 07:54:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7374:f02e:e8be:88a5])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69689266bacsm12151275eaf.0.2026.05.07.07.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 07:54:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 07 May 2026 09:54:03 -0500
Subject: [PATCH 2/2] configs/mt8195: enable bootstd, FIT and DT overlays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-mtk-genio-defconfig-v1-2-5ca5d5c956cb@baylibre.com>
References: <20260507-mtk-genio-defconfig-v1-0-5ca5d5c956cb@baylibre.com>
In-Reply-To: <20260507-mtk-genio-defconfig-v1-0-5ca5d5c956cb@baylibre.com>
To: Macpaul Lin <Macpaul.Lin@mediatek.com>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=736; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=ZCfcwvWzAWJ1MtqsQQWxXwwlC8Ns7gSg4DMJiqfO7xY=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBp/KeoMi9CG1ddCQCcjBVRQVln6kqI0J6cnSNOp
 rvoE7kZyFKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCafynqBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AycgIAJ3nClIdvMFoDpgHcybI+Rpy/9/l6VY2828AbxT
 iw6Y1cnVqh41o0VT087hIZTysyTOsHiTuumGlNYKaDhTrFFWe4lDf2W1E/jJWoqxUXzx/kIi44l
 Hj3m0l6A3I0+vGXpTq2lM2Me+FRw5eVRMiJpNRhXjy19G/cy2elGF5rRh7CA5OoE15aGWgKWkuC
 JI5mbLgWW6XLM2HcBHG1pu8cN6FTxX4iF7/gtvzlLreNf6aFvQJHmAbD4s8c8vUNKquvqXtvI5h
 LhIDPZAff6DUG8q3Zv2YsOEBVReP5rEEi49LxHBkatRqjBZEYkjcI4Qfi8+INB/d66BBvqvKaD7
 FuAM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Enable options needed by the default board support package for Genio
1200 EVK board that uses this config.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8195.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/mt8195.config b/configs/mt8195.config
index ed66ea22956..bfe593659a0 100644
--- a/configs/mt8195.config
+++ b/configs/mt8195.config
@@ -4,8 +4,11 @@ CONFIG_POSITION_INDEPENDENT=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_TEXT_BASE=0x4c000000
 CONFIG_NR_DRAM_BANKS=1
+CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_TARGET_MT8195=y
 CONFIG_SYS_LOAD_ADDR=0x60000000
+CONFIG_FIT=y
+CONFIG_BOOTSTD_FULL=y
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y

-- 
2.43.0

