Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8352CC3DA70
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 20:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72EB988861;
	Thu, 25 Jul 2024 22:45:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h+iPiVwb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADE5A88403; Thu, 25 Jul 2024 22:45:51 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 922AC88585
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 22:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-260f033fda3so392174fac.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721940348; x=1722545148; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GYwd63sn6oUaTgmZWLPulXms68qGB5K03DSi54RRJeI=;
 b=h+iPiVwbTgc+E7DgSXwLkaiB7YhCHtp5pry+j4dK1l6D1Yv2Aj7L3DLL8l6yfjX1uN
 oj3f3CsMvx0vOdNzJl7FEs70YC/nVxgNEJp21Bm1eM6Pgcxzr8MraqwCELh5tWr/icLb
 CUag06851cExWfjB+mGuXcywpGloz8++gX02lTvXnZig7XDIHHGFO+uhciddJSyfjGwy
 1QCbSL4FkkvqPmpw/JfhRyngCto0hFLqw7TSMb60OeGxnphMtNQrCI3jCKjBYX2665Zy
 5/h3VRpjjLP2A2MMHyYAeMciUkjW8wcWK4CJEO/jgmFeqpRtRaw65E0x2eDmqK+AEnBz
 /v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940348; x=1722545148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GYwd63sn6oUaTgmZWLPulXms68qGB5K03DSi54RRJeI=;
 b=xSV+JrwbXfcyyWBQ7VyuC0QRu6Dm9VINEkCG2cIoksqsLWglR8RdHEo3DphA6CRIaG
 ys3sP76IcDr72vaQKn7wY8Q7sG0sNQ+J/HDMNCf2Fg0fhgXkZT1E1OToQDbdTjcYN6wq
 QGXqvKux9mnfzxVeFCzcJhRH2IklU3YmrB200o+9CPHQix/7iuoTdiXGG+t9HZJib7u9
 Wz2ld5awyBT/sBN6KCvpQB7QmRbDShWKnpwKdTzDNUJbfWm6+0v5BpOO400Lx1sMO4HR
 Xh01nc4YOt/4lrsUjpj1ue9tVlq2RfGok6QEDCOwdakN8yvzVcD8aPJ47TIKTCSedkAq
 B1Qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTRf+oqn7raQBEh17QLl7kto2/D0LnuDYeul3Jpe549n4MxR1ZoXiS1rgwXKEmtLUTp/KsmOY2XjMX6Z49TTjWdn1XhA==
X-Gm-Message-State: AOJu0Yz50Xv+8wWNECyvSnhc7gKKiMnnk3O2np0glZew18b3tle/Nr5Z
 bl1UHfGYperRZpKzCqh4uKhY4O086La7WQFR48L+C3AQBvC+3sYdHhFBq6C74AA=
X-Google-Smtp-Source: AGHT+IH9yePZ+MHA+/ojwjGQyLo/fBemY0dPl/M8uL14KxeQPmmLeuSG5fEDrp4OIdsqrI4i3UqRSw==
X-Received: by 2002:a05:6871:2001:b0:25e:5ff:758b with SMTP id
 586e51a60fabf-264a0ba5543mr4917426fac.4.1721940348310; 
 Thu, 25 Jul 2024 13:45:48 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7093050a348sm452395a34.3.2024.07.25.13.45.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:45:48 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
Subject: [PATCH v4 37/38] configs: e850-96: Enable MMC
Date: Thu, 25 Jul 2024 15:45:19 -0500
Message-Id: <20240725204520.18134-38-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240725204520.18134-1-semen.protsenko@linaro.org>
References: <20240725204520.18134-1-semen.protsenko@linaro.org>
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

