Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705A4C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50E8E8858B;
	Thu, 27 Jun 2024 10:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UBa6DPuZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71CB4884DD; Thu, 27 Jun 2024 10:30:04 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B85458857A
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:30:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42562a984d3so7621775e9.3
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719477001; x=1720081801; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CiMow7s4j2CsLyjXWJPRpZ4yYDVro6zP4w6YhlUwuAw=;
 b=UBa6DPuZuN9ezZogmLCjIjvff2vTagN6XG8m0njEP8gAM+8oBsI7cSk+wM5lgpJY5U
 de7BHLmTz44KCQ9mzVhyQXPeKL4fGFuoPiKxduNxpp01dx0rCv3hGe0Ycp/+cROdBPv3
 mM43IyfxhV006v3rW661LKtQrbjW1/iXF2h4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719477001; x=1720081801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CiMow7s4j2CsLyjXWJPRpZ4yYDVro6zP4w6YhlUwuAw=;
 b=Lqm846rfYjjssPCFyFGfxtwKrCzkVsFfszlZ1FbT4rk1ImCuUYe6bXbV2Ij0cItQNR
 4vqII3s6VAc/ooKhDD20zZXJhgOxTNg2NjOWzfiN4qbOF0eoCItpUbbOTxzHxb5FeGMm
 bMiA5WTuLLDe01JtYgH3mzHRecKJigXvbFBfDCVe2KMGShxlsDqMCZRSbg30NxGQSOdA
 ZqZJog1n9Fkeh9Daz0wZnAiF39A0Ja65nk5+SxKrXhLxp/DTfVYNmBddKoSS+inuFHjh
 Lww77KKMD8itS2o4YBYyh/rk0eTJ6u38M8FIqOYeqOO7wtN90ZZ3759+lqAMXjT9q8qi
 ExqA==
X-Gm-Message-State: AOJu0YymUYYnlmmo8sZcHnkgeCbnTGrN9ATlCQE4acCtjILYxjTZfbIB
 Z6AlaloiQ/NzdolRvOrIbEsUfSyJ8X1DEc9ZlKiSB/fcuBzFvaMzORsoEDqnvVIsseauh08pNj2
 p1Q==
X-Google-Smtp-Source: AGHT+IEDGzu3guCkXmGlXr8+KU1y93LBatWWAypwcxVYCQOtGaY+/IQWLlrVtwjLJnY2Vq5F9bTYSw==
X-Received: by 2002:a05:600c:210d:b0:425:6561:477b with SMTP id
 5b1f17b1804b1-4256561481cmr6776705e9.40.1719477001064; 
 Thu, 27 Jun 2024 01:30:01 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c1c8sm1106534f8f.9.2024.06.27.01.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 01:30:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>, huang lin <hl@rock-chips.com>
Subject: [PATCH v6 7/8] rockchip: bob: kevin: Disable dcache in SPL
Date: Thu, 27 Jun 2024 09:29:48 +0100
Message-Id: <20240627082949.357089-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627082949.357089-1-sjg@chromium.org>
References: <20240627082949.357089-1-sjg@chromium.org>
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

