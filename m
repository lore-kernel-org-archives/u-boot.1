Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B87BC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 03:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3C6D8837A;
	Wed,  5 Jun 2024 05:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dDCh+a9E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0521A88303; Wed,  5 Jun 2024 05:26:46 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6DB3881D6
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 05:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3748aa28d0fso21403615ab.3
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 20:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717558002; x=1718162802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B4hh2AqsakrJVa156/2rBx0C8EpsvRVS0WPLuOj6BJg=;
 b=dDCh+a9E8WMrj4iwPBBGMfp71GlpAZXGi8QIBNwLG6YGQJJ/mERo/lH0Ly+bHzR9Xw
 dbkRC3xUabMcEr0Ik3UH4KydHEeHHpqfRlTaCJfLnOPNeFDYzmAxm6p0Keh577nIicbk
 eKoS2GpJn2iiGNGuaWmlGSHHWZ7phFEvO80x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717558002; x=1718162802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B4hh2AqsakrJVa156/2rBx0C8EpsvRVS0WPLuOj6BJg=;
 b=priGpBRNWFSR/3Jaw8ePn3eJdl/0y65qjnx6YETjRmjMjVS0Zl12324VT8J6Bjbz/P
 L/xm0i4WVhZFiI0yEFB5Dlr/GwJ5WM7nv7MhEeR5GDQSwxxKl59x/upPuplTOg6DqB2j
 SqPZIHrgEXZFZkC6EDzjxFFPoAo79NNXfdqvCu5uGPWpBVvB0idQNf98eWksgCCeb4Yx
 tEgWU2wMdPTBQ7sYG+A2KPLHxv7LZ31eGJq2nAFHarVp1CcLFG1kfcuj8PVgadExNOVO
 KTaCzpvgw7Jw/IggKcZcjmVaz7K6jkqd8h5vL+ywQTu/QnoT+8Kdn1tyV9/xMmn5aUQA
 JAFQ==
X-Gm-Message-State: AOJu0YwJJ9S3W3z0mhzodsf14PoX3zAeTvrmGSUqXP4YnYcWMbIPKXND
 HYWoGW3yCBo8rZ6Gdy2qfM8HRWXinTo96emu6UntrGiWrtO9K6K547vDysYZFEUCzNf8ID9lFmc
 N0g==
X-Google-Smtp-Source: AGHT+IExvSblInSBxOPa9V2UmMRs4aNl7A1d46ea4NASTVbyszLvJANrmwhrOpAVY/3d4NFai0a+Xw==
X-Received: by 2002:a05:6e02:1fee:b0:374:a422:baf with SMTP id
 e9e14a558f8ab-374b1ef3102mr14947605ab.12.1717558002552; 
 Tue, 04 Jun 2024 20:26:42 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-374af0e3ef1sm3691495ab.34.2024.06.04.20.26.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 20:26:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Dragan Simic <dsimic@manjaro.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH 7/9] rockchip: bob: kevin: Disable dcache in SPL
Date: Tue,  4 Jun 2024 21:25:19 -0600
Message-Id: <20240605032521.1142768-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605032521.1142768-1-sjg@chromium.org>
References: <20240605032521.1142768-1-sjg@chromium.org>
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

This causes a hang, so disable it.

Fixes: 6d8cdfd1536 ("rockchip: spl: Enable caches to speed up checksum validation")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

