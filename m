Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238EBC27C53
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 01:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E62598859F;
	Mon, 10 Jun 2024 03:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xs42g4Ks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EF3D88528; Mon, 10 Jun 2024 03:12:57 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B0C88576
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 03:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-24c9f91242dso2045262fac.2
 for <u-boot@lists.denx.de>; Sun, 09 Jun 2024 18:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717981973; x=1718586773; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9fokpperR8k7BYwCKOrniKExo5qDtjR+37lQoDEVle0=;
 b=xs42g4KslwghbH0Bv9rKiE89BdpuVAG6xtQOq5Z44UIS/Zj2oYOdp918GZDtWIA9Kv
 RxcTHt1YeQ01DTsUpMT5WOBczfholpK6NVsu1fnnwTMBhqRLtIbVCodd8l3ysvNjhSCE
 6i+cjMZw0MFm6rumfMK9qJQFYkzl22xefVHZpsnbTRt0JBvTdGOoJc0pwxWRpGEYeehR
 BXgSVIwsXSlNFuQlBxNN9VbyRN2peGOffL+kcE9hvA2p+hbxNokn0yZR4h3QvN/bLyqO
 jQpEMo5zvgIxjYG8dj3IYYx93vTAOuMwurfdU2tFuHs2CHKRmDkGBv4W6REK1qS5HlZV
 oYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717981973; x=1718586773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9fokpperR8k7BYwCKOrniKExo5qDtjR+37lQoDEVle0=;
 b=q4hO8tDEZrDP8cVPT7/qa+eTBj2Fs4YAXP2hlKXpwdEeCZ/KnlqU3E9CesiEc71DBt
 1GiBJCP5fPnDhe0fKyF2JUiCgOzROhuv4oFTxySKt3JAXHg0sbMDpnZGWhpdQPF3PYCc
 oUj1thUGV+ccvULUP2tvqfs4iqfIB3/LUgiTeCGE6Y1reqvEmQqxIKwN9sYhsPN/j+fv
 l9whzeA5k0WZ6J06tLQlGCHFsA/V0zfLWw9ZPdvSWGRzKy8bCJXRC8kKm/LPtl3GGyZl
 c4ltK1aGbR/yGyYa/dvL8eS4W4E7mWeNzQ2BMVNjtaGcN1Fjswhg68Mzcqvy7X9MQPle
 BmwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8kbZtw3giKso4/kZ7oXCZFESte5Q5HT+Sw31hkqHZdMeaD4fJUU7CzHfbK4qbkv+zFE6SheEXZQpjfzqj5MKs90htAg==
X-Gm-Message-State: AOJu0YxHUUTFXqx9m/FOPiLhKS5u6oFRN64Tz/8g0ZpilLmWWVGQ6ETJ
 sl0Nuiue4Km1PITWxBSUgw/JHIfj1NQkXcv/mL03B5A+XmdXRPd/cj2e0g5LKAc=
X-Google-Smtp-Source: AGHT+IHrzrQSxzSfLACp3oZt7Ipn4MNCZfKoP08ibyE5y7nBgcKJ1LhI3H5khJlKXc+GPSKJphpZ5A==
X-Received: by 2002:a05:6870:ec87:b0:254:79a2:38cc with SMTP id
 586e51a60fabf-25479a2c7ccmr7953470fac.5.1717981972786; 
 Sun, 09 Jun 2024 18:12:52 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25448138e4asm2062969fac.57.2024.06.09.18.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jun 2024 18:12:52 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v2 36/40] mmc: exynos_dw_mmc: Use dev->name as driver's
 displayed name
Date: Sun,  9 Jun 2024 20:12:22 -0500
Message-Id: <20240610011226.4050-37-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610011226.4050-1-semen.protsenko@linaro.org>
References: <20240610011226.4050-1-semen.protsenko@linaro.org>
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

Reduce U-Boot footprint by reusing dev->name as a driver's displayed
name. This changes boot device name (and "mmc info" output) from "EXYNOS
DWMMC" to something like "mmc@12100000".

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/mmc/exynos_dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/exynos_dw_mmc.c b/drivers/mmc/exynos_dw_mmc.c
index 43111b749a6b..a9e240fd91d6 100644
--- a/drivers/mmc/exynos_dw_mmc.c
+++ b/drivers/mmc/exynos_dw_mmc.c
@@ -327,7 +327,7 @@ static int exynos_dwmmc_probe(struct udevice *dev)
 		       "continue anyway\n", host->dev_index, err);
 	}
 
-	host->name = "EXYNOS DWMMC";
+	host->name = dev->name;
 	host->board_init = exynos_dwmci_board_init;
 	host->caps = MMC_MODE_DDR_52MHz;
 	host->clksel = exynos_dwmci_clksel;
-- 
2.39.2

