Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFC7EE49A3
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 15:35:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34DB286FFB;
	Sat, 19 Aug 2023 17:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fbyY+rFv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B6498700F; Sat, 19 Aug 2023 17:35:14 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D532D86F7A
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 17:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9a1681fa868so178305666b.3
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692459311; x=1693064111;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ePyfshe80v0g16JruCfvHZMR/y9qCfXH1GvbSXQgiSk=;
 b=fbyY+rFv3Rw8CUsnphNq8Lxvh0VosD2ITBmcWQNNRofVFf9enRb2roHES6KX0d56ak
 iTq5lPuwl2Tsf3zHX2yqD2DDhg8bzHlk8GZeeY731IN/K7lCWkNdspWJuz/uRqFU7o6R
 d4YpiYN4pDVDKv2L21thPW0Wy9TzmMCVMFQT38zW7jfbQz3B1uEe4vzHxNy2WidEQMRY
 uEefT10riqyGFYEZTS+kEynC6NxfSJl6CWJ8OfklwGXuutk9WfLu76kNSiUuQtHNi5ld
 /NsdPWjsOxUTadHcs+X1nQprodk66wqFrOeprb54X+sU6q9tW+ncljvGhV4EmnaUH09u
 G3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692459311; x=1693064111;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ePyfshe80v0g16JruCfvHZMR/y9qCfXH1GvbSXQgiSk=;
 b=cARnoFDigCcns3T2J8gSvkzzCIaBWyKQ5XhnwFWk+8L3UyasN9k1CHagdkGg82zvol
 BEYxgl/lK01VB4DEy/NzpuehuIxBcGKgKOozkefxn83diXFgnvgKg4R5bvanlO9C+6Ty
 FSGaaWIHoLhhK0t/G+f7NyAqZGDEz1VSWb4Isr/CYPr1/Fji4xj7cV7xrXRq8oAZO6lv
 XlwT93bodanfYG0J7DMUUVX+rWhvr/5osTkekV7Y0aKH4oLltXDVZvG56EJHHAwiHjMI
 CHYG3OxHqgkgfvrLJBpwZsOIUT1JmYUMw9NDy8Y8MPecZ3wYTl6584GdK+LmCS3YuWJY
 bUOw==
X-Gm-Message-State: AOJu0Yy8YppVlYgxQIPrG2uajfX6uqGtFQi8HhEwSOa7nbEzQpv6jO03
 8QftT6ZmuAsrcUiRh2oPEtgYzuNDpa/tww==
X-Google-Smtp-Source: AGHT+IFYkaHUbhZd9m8SSrYjOZ8wWV84MWXjyG/5pi6LAhXSbgtj65HSs8re0PfC48lExjefiknNFA==
X-Received: by 2002:a17:906:31d4:b0:99e:cd0:d95b with SMTP id
 f20-20020a17090631d400b0099e0cd0d95bmr1564107ejf.18.1692459311169; 
 Sat, 19 Aug 2023 08:35:11 -0700 (PDT)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 pv21-20020a170907209500b009829dc0f2a0sm2839737ejb.111.2023.08.19.08.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 08:35:10 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/1] tegra_mmc: get tap and trim from dts
Date: Sat, 19 Aug 2023 18:35:00 +0300
Message-Id: <20230819153501.77245-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Default-tap and default-trim values are used for eMMC setup
mostly on T114+ devices. As for now, those values are hardcoded
for T210 and ignored for all other Tegra generations. Fix this
by passing tap and trim values from dts.

This commit will cause regression on T210 (emmc may not work),
fix is applied in tegra210.dtsi and will be sent next week.

Svyatoslav Ryhel (1):
  mmc: tegra: get default-tap and default-trim from device tree

 arch/arm/include/asm/arch-tegra/tegra_mmc.h | 17 ++++----
 drivers/mmc/tegra_mmc.c                     | 46 ++++++++++-----------
 2 files changed, 30 insertions(+), 33 deletions(-)

-- 
2.39.2

