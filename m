Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513A5C52D6F
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 03:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CC7788B81;
	Thu,  8 Aug 2024 05:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pa+RVdUn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26E3588C25; Thu,  8 Aug 2024 05:15:22 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C943988C28
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 05:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3db18842a4dso792529b6e.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 20:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723086912; x=1723691712; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fjQQOetGXVK+xtU2b2bn038bOzbhgIt6wK4s+tVCTKw=;
 b=Pa+RVdUnX/IC2ww49F2ag3KR9ZO1uZXV2cXd8hf3jDGqgAlP7J0UCHxnpWsqykIvQH
 Zb4MXJctv135zdqWTEwAko0zaUs7h4cqUHx4XYvvji5wUyMaWZuxKEvAMTrrC9Eqxw+C
 3u7nw3FkBW+TRfJ2sNpJb11XqSJHpU3bJ0Dazg3o5uvNipJv+8wmWd9lWToUzxEcuq3g
 6ofFI+z8i5VUhkueB63PEsezY1TfrUrLJA7rtBiTMw2DWCnlyFZbGy0vgrZueDwDXzvt
 HCBQnvprIba5o77UPHjhpx0IS1rS14KC28JOi3JVBz3licfKqLOpOoGwFVok9+oh2uWX
 l8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723086912; x=1723691712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fjQQOetGXVK+xtU2b2bn038bOzbhgIt6wK4s+tVCTKw=;
 b=eesYJJnvf2gBrBK3Og3HzAK2P+jcwKt9Tk5/Jvc5/AqMd/hkQpPwGdfJcMSHv+CUMK
 mdYH2cTa8su9lxdRndUHuABSQvaZTo8wTvRWmyvpHu4AJXe/k5OslrBVyDIr6UfmYn97
 VN3LpeqoQOdAy/hRe8/YVZJPdJNJ1jTJokadNgdYJY4mUXloPeVowA9NuYCVdkxENQ7i
 BqzJcDE/0u/77WqzDbcCIC8ZR0kqeK1meb4ffLCX41Z/7sfnpmTiTKDBqjBduJgSzws3
 7wVygK0mO3DcXKwhCPsoG89VCbVK3J+tWcMeyH2awhoqAAzdEV88/TJeQ1xcybBrqP5j
 cOpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMpNpHz/6KGVyfxDaCSWYGipIWnZ9a264gi57Jni5zuF/jz9gSHI2mWytlPYLeXF2On1bM1D+uHUfyLT0WAMv0Fd8VgA==
X-Gm-Message-State: AOJu0Yzgwlf1ROa3pjIQZG2pi49fMRc2stCx8j6/DvDh+Sq9+JX+TuJj
 5GaydNQ9opRANiye9fMt+nREIC7TYjYC202rztuHv36MKWgBo6Qd+Dncyhj8ovk=
X-Google-Smtp-Source: AGHT+IGJWEpfZw/diOBqUeEJktH0kJFObvVj93N47iqWTRN1dKGI5VbHxgUGWKzYOzBP2OEYywCjIg==
X-Received: by 2002:a54:4399:0:b0:3d9:3427:56b9 with SMTP id
 5614622812f47-3dc3c160e9bmr95965b6e.4.1723086912580; 
 Wed, 07 Aug 2024 20:15:12 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3db563618e4sm4600169b6e.2.2024.08.07.20.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 20:15:12 -0700 (PDT)
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
Subject: [PATCH v5 37/38] configs: e850-96: Enable MMC
Date: Wed,  7 Aug 2024 22:14:43 -0500
Message-Id: <20240808031444.9619-38-semen.protsenko@linaro.org>
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

Enable MMC subsystem and DW MMC driver support to make eMMC functional.
Also enable a couple of related commands so the user can make use of
eMMC from U-Boot shell.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
Changes in v5:
  - (none)

Changes in v4:
  - Rebased on top of the most recent master

Changes in v3:
  - (none)

Changes in v2:
  - (none)

 configs/e850-96_defconfig | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 2949da24267f..e5d90996234e 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -9,12 +9,20 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xf8c00000
 CONFIG_DEFAULT_DEVICE_TREE="exynos/exynos850-e850-96"
 CONFIG_SYS_LOAD_ADDR=0x80000000
+CONFIG_ANDROID_BOOT_IMAGE=y
 # CONFIG_AUTOBOOT is not set
 # CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_ABOOTIMG=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
 # CONFIG_NET is not set
 CONFIG_CLK_EXYNOS850=y
-# CONFIG_MMC is not set
+CONFIG_MMC_DW=y
 CONFIG_SOC_SAMSUNG=y
 CONFIG_EXYNOS_PMU=y
 CONFIG_EXYNOS_USI=y
-- 
2.39.2

