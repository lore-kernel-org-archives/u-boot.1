Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B7EC52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24BC288BE6;
	Thu,  8 Aug 2024 05:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N8tYK29A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB6D788B6B; Thu,  8 Aug 2024 05:15:08 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 448C788B28
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3db504ab5f3so407138b6e.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086905; x=1723691705; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEMddII/dJg7zeqKXZ6gh3nt7UHm8knkyF/Q9SP/yNk=;
 b=N8tYK29A5uvhpMPHaykBQI5oJ00k4o9Z23bhvuLHiFfxVaZsd0oPqko8wmMS3DxXYG
 qiKl3pyUPKBG0foANwcAWCTrPWRmoWcDi8NiFCR7IIr+YZO41Hj9fXa1B1xM/QyIzklk
 Gvoqxl7mhvmZK3JgWXyuqWqMiMp1Kd6FKyb1UMJA9XFbl8o0AB0FT6HkOgP0lesZiq5D
 52DF0P8R6zCRy8P/KtK5/UNeAgiZpTxhWp2opF9/uu5xust+fybzbn5W8Oe5Hbr4E27i
 7dW1CBqmJ6FmLVr4aO2m4AiKblX4vPlBgqR6xY6W0kuFVX7PlycgonbgbDSEei2OtO39
 sjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086905; x=1723691705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BEMddII/dJg7zeqKXZ6gh3nt7UHm8knkyF/Q9SP/yNk=;
 b=j/vSn0Z9nYQGztybv2qVRny3+5glFCqLPF3I544sUwRc53IuHZwaJrIViPye7vcfAN
 aylUuouUs7aUI8zklcuRI703tbhDbpLTZFZzdIZ1dXIUdsdlTT7H5c2XU3Y4M6DeSy51
 /5h2qfuTwHQf+sfAyIQwRcMoo9snsXDQYE/7+q0aDMmhXNBldSm26L5XuFN4XSIJC03q
 hbnLFdtB9qBFSg87HpQ30ei7/5+0BPnYtky642VHNqK9iznGsaImR/v3C099ugn6SQQe
 ndqlXh4uSr28rah6gca4rRTe0It8tfNAtBtmGmvhYr5jKEQT3KZV5WefI+7OKajXDRJ2
 1MmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9sqAClWtMiih67OydsUsd34xY5LauFuRfxftMIRhXETCfcybEroDvrh9VxtC6yX8j+a+/kXVTa0cHgXVaBARQDzFGVg==
X-Gm-Message-State: AOJu0YyN+0mRmnzEPGJI2E10c69BOHn3QNOSB7bXw0CIHqCPPzL/PfOC
 ClnOLqKq2zbtZKBJj6Im0A/cXQyzAMS7H/kakXmiCejLZ4vpD7VEMXWtH6Ild5c=
X-Google-Smtp-Source: AGHT+IGwuKJ4cng6XjBm12jVGL6dEDWc4JcEjNio+/s5PQKYqARb4D7qYh/z8h3+Iir+Hou2Vy4gIQ==
X-Received: by 2002:a54:4790:0:b0:3da:b3c2:b4c0 with SMTP id
 5614622812f47-3dc3b455a2amr619017b6e.31.1723086904993; 
 Wed, 07 Aug 2024 20:15:04 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db563c77b6sm4582401b6e.54.2024.08.07.20.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:04 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Henrik Grimler <henrik@grimler.se>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v5 27/38] mmc: exynos_dw_mmc: Read common clock-frequency
 property
Date: Wed,  7 Aug 2024 22:14:33 -0500
Message-Id: <20240808031444.9619-28-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240808031444.9619-1-semen.protsenko@linaro.org>
References: <20240808031444.9619-1-semen.protsenko@linaro.org>
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

Instead of using non-standard "bus_hz" dts property, read common
"clock-frequency" property used in upstream Linux kernel. It's safe to
do so, as "clock-frequency" property was already added to corresponding
nodes in all affected Exynos device tree files.

No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v5:
  - (none)

Changes in v4:
  - (none)

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 drivers/mmc/exynos_dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 612c2d0c615d..bed8bd8a0fcf 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -306,7 +306,7 @@ static int exynos_dwmmc_of_to_plat(struct udevice *dev)
 	}
 
 	host->fifo_depth = dev_read_u32_default(dev, "fifo-depth", 0);
-	host->bus_hz = dev_read_u32_default(dev, "bus_hz", 0);
+	host->bus_hz = dev_read_u32_default(dev, "clock-frequency", 0);
 
 	return 0;
 }
-- 
2.39.2

