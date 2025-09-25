Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EB8CAC5B0
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 20:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52B4082A9E;
	Thu, 25 Sep 2025 22:45:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="duY7jlu7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B730E8309D; Thu, 25 Sep 2025 22:45:40 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99D69809A5
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 22:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-789c9c12c11so1197096a34.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 13:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758833137; x=1759437937; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iwdZcx//NcIrwV1jMJGNQgvmrl+msCuHhLryWFRVwK0=;
 b=duY7jlu7v0XMlVHfZB2PFshisQx01TD6malAUD4YazINlpH/oKsEErc80ByrqBI2s5
 DUu9hXcXidj+hbteB7jC62148Nrgw2f333Ac1bHwQBOvnY/BqtyEq8QaVc8YDFm8jyG9
 0eGQ8dm/bFAj8aIHtfYn9qPFWFAeQgsUnxXIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758833137; x=1759437937;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iwdZcx//NcIrwV1jMJGNQgvmrl+msCuHhLryWFRVwK0=;
 b=iXW7ONp/ZchMUnroKlXoBI78UX+tAKC9jqGA3N7+8MQURY9idpW+wcLlO98xyaX1hq
 TJIYyiHOvZCHf9YnilzIL2NKouNVH5XL3vpRoVyooDCaYyeclUH+I5cGwVQjh30wi3sH
 h1j2DwfaeidGcAMI9PSKDVTvF/6XA9Zq4NUv7l+DZ/Rvv0EAheNv6I6cru63owewXHQa
 vWT63TZ3H1SaPO31ZviNe/YD05Ha4f8as7BGveOu1pdPwmLNNG6ivfzzel0cYW//P43l
 0eNEX2smRs3TVq7qVOk2EBqE7/7mKLQ2e7tah5NJZTPb0dqix+BRwmhmfmuz/kgD014b
 GKQQ==
X-Gm-Message-State: AOJu0YxIPXG64n51bZbkq8EjjzdM7vQ4iscch/cMDNWVx83/cu3dQZmK
 W7kZiic930o9rdNSN3PW4mqX+JvmMVIOQfFf36cXR8S8qu5JhTC8Yes/qeGJqLZeNxBMVBXVEvI
 oNKjDS3s=
X-Gm-Gg: ASbGnctyEpvc9iYbKz0SdyW7yq/lWw+2QNuGff+lqmmdBlh6i7BHSvyFh5EWW3hpTBI
 q0r3C3G8ihsrybNCXd1Hs2mW1NmNzC1ClEMP6Uj+vF9MGM+FRUvWBnXCrfApxVrWBOIc2dQtda8
 102TxZfpGbqKsoQEZXZgDYpdnS4pQs0ilcAsT/Rtc2fjCJlFY8+mf2D5UTBw93FXfdpyAd4s1nY
 NsektgY7XuzIgl8RkL/R6Cg1f4lw0BEZVFRMX/67rf/u70AjX/e1WrupyqMLZUO7B+ixyQXkNU4
 NBsnqnJP6ny6grI3wjWB4+rYCS0k542OawB1zocUo6gcphwtpMQz0BskUy7XwELLEkNtsBgBs2D
 IUBIgfdRzLpDcHuVwkQECDoBJe9Pq+gIAakdVXX46XxZBLfBKqEHoLzCaCOllpv8++Xr1Fg==
X-Google-Smtp-Source: AGHT+IHLgA5yEAY9JX09cdVMOKHTdhGP25WVVXwtY1q2NjIhoq74zw2jkSxh0qj9Bm+ms4tAVJmEzw==
X-Received: by 2002:a05:6830:700f:b0:753:7a09:78d5 with SMTP id
 46e09a7af769-7a1e17695b1mr2037341a34.8.1758833137320; 
 Thu, 25 Sep 2025 13:45:37 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a234172c3asm615362a34.17.2025.09.25.13.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 13:45:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Ion Agorria <ion@agorria.com>
Subject: [PATCH] crypto: tegra: Tighten TEGRA_AES driver dependency
Date: Thu, 25 Sep 2025 14:45:35 -0600
Message-ID: <20250925204535.3561174-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This driver relies on tegra-specific headers to compile so make it
depend on ARCH_TEGRA.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Thierry Reding <treding@nvidia.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Ion Agorria <ion@agorria.com>
---
 drivers/crypto/tegra/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/tegra/Kconfig b/drivers/crypto/tegra/Kconfig
index b027609307b0..0f2acaaade1f 100644
--- a/drivers/crypto/tegra/Kconfig
+++ b/drivers/crypto/tegra/Kconfig
@@ -1,6 +1,6 @@
 config TEGRA_AES
 	bool "Support the Tegra AES"
-	depends on DM_AES
+	depends on ARCH_TEGRA && DM_AES
 	help
 	  This provides a means to encrypt and decrypt data using the Tegra
 	  Bit Stream Engine for Video/Audio. Also may provide a mean to
-- 
2.43.0

