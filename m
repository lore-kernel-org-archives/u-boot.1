Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B59C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E194988BF0;
	Fri,  2 Aug 2024 21:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lHz8ha++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 472A088BC8; Fri,  2 Aug 2024 21:19:00 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BEB688BC8
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=virag.david003@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7a9a7af0d0so1105643466b.3
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722626338; x=1723231138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X9fMILRQigwV/LEcRAmXGUeI4up2nJMbbsv1HpFttTs=;
 b=lHz8ha++DLi95nZGJLtQviMkfH9A9q9vlDJ4a/Mhxh3Qxs7HgGVJMRTaUPrZ7U3/3T
 bNU4HCAdEEbjJnuvKoIm4rAJ0frZksfAb49JTqk+5M8oxjxksHVLUSq8sSk1PpZf4vOG
 i/WW+QuGOXdibMB80eGkBmnh9HYRDzO69d2AmHlH5Lvrcys6Ezgi64q8oc7/gEvGaGu1
 1aOhkYJpdPWsF3vHNiivT1JVBv7Fu9kCE+AWB3e2mhYFRdcoNrhg68Anx5vB144IcFe1
 iB5109h7T2aSs1cihSvTV+xSWm5PsEhZVGFfr2QhsntWrDxh+2Xppth0cNj0j+4KjYM2
 HNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722626338; x=1723231138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X9fMILRQigwV/LEcRAmXGUeI4up2nJMbbsv1HpFttTs=;
 b=Z0zdAbqOJtWXDikkcOYzjmd7L01AlbKvByJT2w+SmmxsnBHIe3f4MUnc7Ap1mr8vLg
 EQoVoUXQrx5j/kT86e9tPSoVw5sT2qnK3DTQiMiKaxaou2CxYPJONSPUmB9BEzASFhqN
 IKb4xou8XOQjOYQdDnfR1c6DjMQo5Cs0wr9PVctFneiFQ7dN4KktCsHutozwKQLDnsCZ
 ZK1TG8UBGsNYcOoj7lj3hns5YcyEVFKMEfErZhNuTlgGZi3vGCFM3xj/CbOCD2EpCpUf
 Hn+45pqNog1SQoC1v3UTCT84jFepXZ1W1+lykry6WnvdJZJCbRM5g6sCs/m2TZzYQvfY
 mXiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM6uKtWPWapJoTudsC2VIfCpRZyoi80DIMTgkTD2AGXvpINefoyUko/o4QB+8aSDN3QNBDudEsm9u0F0RGHU1LYy9SEg==
X-Gm-Message-State: AOJu0YxqsuerKGc/zc0RLCNThAlEcbqowqlMDMboIF8feGOHw8nMZnui
 xqPkVaBcVQvyvE2c7EK0Mf9jiodP/paxknJpMY5MYCHUnLpv+Hmo
X-Google-Smtp-Source: AGHT+IFcq8a2kWoBgLUbcURooBCa8jMf/iY4zcSbzNIuNTAKBkqnA915hmVDvatKawm/mICVVFM0Ig==
X-Received: by 2002:a17:907:9450:b0:a7a:8cb9:7490 with SMTP id
 a640c23a62f3a-a7dc5098889mr292030166b.47.1722626337451; 
 Fri, 02 Aug 2024 12:18:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:3711:c80:e7a7:e025:f1a5:ef78])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e8383dsm130128066b.173.2024.08.02.12.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:18:57 -0700 (PDT)
From: David Virag <virag.david003@gmail.com>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 David Virag <virag.david003@gmail.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
 Henrik Grimler <henrik@grimler.se>, u-boot@lists.denx.de
Subject: [PATCH v2 0/2] Enable Samsung I2C drivers on newer platforms
Date: Fri,  2 Aug 2024 21:19:14 +0200
Message-ID: <20240802191920.132133-1-virag.david003@gmail.com>
X-Mailer: git-send-email 2.46.0
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

This set of patches should enable the Samsung I2C drivers to work on
platforms other than EXYNOS4/EXYNOS5.

This has been tested on Exynos7885 with the S3C I2C driver.
With the clocks for it implemented in it's driver, this should also
enable S3C I2C to work on Exynos850.

While at it, clean up some dead code as well.

Changes in v2:
- Fix compile on Exynos4/Exynos5 platform

David Virag (2):
  i2c: samsung: Drop s3c24x0 specific code.
  i2c: samsung: Support platforms other than EXYNOS4 and EXYNOS5

 drivers/i2c/Kconfig         |  2 +-
 drivers/i2c/exynos_hs_i2c.c | 25 +++++++++++++++++++++----
 drivers/i2c/s3c24x0_i2c.c   | 32 ++++++++++++++++++++++++--------
 drivers/i2c/s3c24x0_i2c.h   |  2 ++
 4 files changed, 48 insertions(+), 13 deletions(-)

-- 
2.46.0

