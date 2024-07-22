Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 217ECC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 18:04:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FB778878A;
	Mon, 22 Jul 2024 19:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m2JBbQkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8431688644; Mon, 22 Jul 2024 19:58:11 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70D09884F9
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 19:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-708b273b437so2483128a34.0
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 10:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721671088; x=1722275888; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/szmDhlxI5TD12xg5Y9pDn//djwXokH5PDOIv4i0Rg=;
 b=m2JBbQkQuN/pCSxghtTQ02tDd6a6zCuL+1GyY2DhbIOSH+YRaVNW0uLreT74cgemFn
 1yJyGFR1SV9AtC4NzmFie2lBi4YccHLhjdVfRRd8I+a9iaIT8LJAd8gl/KoYGaY31VAA
 0H1Jn3Xfx3DBvOID/9n4useBrA1V84+yoVb0YEyK24qilmKSL5mVZDgqdgvG7QeZh/FO
 NjARuyis1w0FjHm9KLsRWJ7Fl0ILuvJP/GnnQaa6Y6fTtE5/zIjBtHj+uKoECh3V5H0V
 UWQo9+rhvyiBPVsM9Qy7ULI4OS4V2U6SOpiCAbGXfSJoyHx+Olr/QToiXZbwDS135LVd
 Eucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721671088; x=1722275888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/szmDhlxI5TD12xg5Y9pDn//djwXokH5PDOIv4i0Rg=;
 b=WHPsX9V0QAIwrEz/2rG5Kra+FJLZPnwrqOpcGXOinW/8uTPBLhgmDP+oA34cMScVyl
 Tlv9nnXrQikndjmPrbPDxVMIDFy+zhGLO81WisT52ySKHQLxxcNSMxpcHOLz39KDtOW9
 yMma2XHqNtaeCuxVpT4FXbZP+ndJiQZ4XMoPACJjUIvGietKjuqaMP9L7N9kTvvkG6Nc
 qORM2ACovuxVvCOLLtXqCSleSusw7bKBnSHuU61yTEv3c+OBuJoBBCYLi/V5MONbj+Kl
 ETTbQm6Bl/1f1hBko/ATYOl+lUUj7H07nz5cUHVjE3x8kX9dwcUDLyp5K3sztgl/0vps
 BdGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtc7uX93BEtxght9h0v0bG8b7tN6YfGKfYmwofrVQGbWJ8BZ9pihTTlieIBCxARtG9KRQGySti3dnr0mX8zES4R68sWg==
X-Gm-Message-State: AOJu0YwrrZxdG/iPT6JXW4qHOGygm9qXx580aDetYWd7GkwpSeNDoVFx
 vJN5XhpdypqRAmp6UnpOhM41Fx13PhFTR45rgUbWPZBD4xMYeMqru5f+UllwYSQ=
X-Google-Smtp-Source: AGHT+IFtKKJjbsFUjtwyD+jPZ1lEIQF9mzRxOFBlMU0Z/WPm1qSrEuv02YRKk5YljoMj1xUXPo5cmQ==
X-Received: by 2002:a05:6830:698e:b0:703:6845:ed89 with SMTP id
 46e09a7af769-7091809843bmr620965a34.5.1721671088279; 
 Mon, 22 Jul 2024 10:58:08 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6172f97sm1628862a34.54.2024.07.22.10.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:58:08 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Minkyu Kang <promsoft@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v3 37/38] configs: e850-96: Enable MMC
Date: Mon, 22 Jul 2024 12:57:39 -0500
Message-Id: <20240722175740.6985-38-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722175740.6985-1-semen.protsenko@linaro.org>
References: <20240722175740.6985-1-semen.protsenko@linaro.org>
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
Changes in v3:
  - (none)

Changes in v2:
  - (none)

 configs/e850-96_defconfig | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 38b9968c1671..29ad31d5f8ed 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -9,11 +9,19 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
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
 # CONFIG_NET is not set
 CONFIG_CLK_EXYNOS850=y
-# CONFIG_MMC is not set
+CONFIG_MMC_DW=y
 CONFIG_SOC_SAMSUNG=y
 CONFIG_EXYNOS_PMU=y
 CONFIG_EXYNOS_USI=y
-- 
2.39.2

