Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE4BC3DA4A
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 17:41:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F23C88706;
	Sat, 27 Jul 2024 19:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hyqy++Cn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B44B88780A; Sat, 27 Jul 2024 19:41:15 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A121188701
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 19:41:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=virag.david003@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7aada2358fso447373866b.0
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 10:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722102073; x=1722706873; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xDmd576zMaICVM6Hld4zY2QsFjik8S9AX9sNHWdqvXI=;
 b=hyqy++CnT7ZkjQ15PVzMryFgGaSeHSKL889sRfujTiiFp4pWBXbpr3KkUYv00Upr/z
 WNWiRz9o97LbNS7plGwlhHS23KP9r6or5UNqylgPYqn1h2ZGohN4YcND5YOGTTyqLo5x
 zaEjmqnkhvVrjvFU+/lpqMuF4UxrHXZTLPQCW+Mr3KounmCIQ15NCGaCbH7PjE6UzQ6Y
 r1yKlhcwqQMtKSve1+HcLL8dod0QTEFTETooEAllYY+enVXG9n6HF2KRsNz3Zj6p9Rr7
 eTFdug9jT4KtvVYLEn6DlaHUfH2KKLtsmtnkwOV/tqZv+4Prw7zyZp08h0A9EEGsQQYJ
 cQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722102073; x=1722706873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xDmd576zMaICVM6Hld4zY2QsFjik8S9AX9sNHWdqvXI=;
 b=Yr5Imd8xA/++ybQg5iWd126xNeFXLFfF8ZUipT5Kq73R52KCxLp0PgCR3Fom3oAYDM
 FJ7NXSWG7tMpki283UVVizAv6BRqBSWQM80U4S/ekKjz2Mvx/k7PQhfxw4pbTSSWe8n/
 EjHZBjumK7CF0ePfK+MCIntnZENSVBvYjB7vqFuplAvRS5SKvKE6Md2gPm7kDHeI1Ayu
 2ek4u2XXSRNdVzUahSB06E6sNefIssqhNpSPMLmoOGofd8GaSX259jfibwrTPcdm9/dn
 tAUuR36lVgLbK0DumjzZZ9Xzc+4qW+3R6sF6hIXl8KljkrhQEw4crOJ8qqnxu0HttAxr
 KwQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeIK1FyGNaE9fMv9x3XaXfKYFyCwcRz6NJb5UVX4/9Z3wDM2QD37EpQj87JnrhuXNensctK5cAzJMJFB4SFyk8/ma3fg==
X-Gm-Message-State: AOJu0YxGjWbkQjYVTCEkYtISiiDg/rW0GZiC2G1dnjY+DkHQe1QYXQ8l
 0B9pQTSN+oGZYnvz5Ir70PO/Fg1ZzkAVwu4H+oTkTu+XIQP3iYZx
X-Google-Smtp-Source: AGHT+IEEg3+aFKownZlodvPM27knNjmXHhsyePXWYabVVlZfapkrcc0fKxYIoqedJIsxjK7aEYkz/A==
X-Received: by 2002:a17:907:868b:b0:a6f:46f1:5434 with SMTP id
 a640c23a62f3a-a7d3f8011d1mr315046066b.6.1722102072864; 
 Sat, 27 Jul 2024 10:41:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:ab88:3711:c80:e7a7:e025:f1a5:ef78])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a7acadb8361sm299927466b.207.2024.07.27.10.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 10:41:12 -0700 (PDT)
From: David Virag <virag.david003@gmail.com>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Minda Chen <minda.chen@starfivetech.com>,
 David Virag <virag.david003@gmail.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH 0/2] Enable Samsung I2C drivers on newer platforms
Date: Sat, 27 Jul 2024 19:41:46 +0200
Message-ID: <20240727174152.306827-1-virag.david003@gmail.com>
X-Mailer: git-send-email 2.45.2
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

David Virag (2):
  i2c: samsung: Drop s3c24x0 specific code.
  i2c: samsung: Support platforms other than EXYNOS4 and EXYNOS5

 drivers/i2c/Kconfig         |  2 +-
 drivers/i2c/exynos_hs_i2c.c | 25 +++++++++++++++++++++----
 drivers/i2c/s3c24x0_i2c.c   | 32 ++++++++++++++++++++++++--------
 drivers/i2c/s3c24x0_i2c.h   |  2 ++
 4 files changed, 48 insertions(+), 13 deletions(-)

-- 
2.45.2

