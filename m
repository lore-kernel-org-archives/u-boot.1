Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079B9C67861
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 21:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1899688176;
	Thu,  4 Apr 2024 23:51:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hVshGC5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F262882B1; Thu,  4 Apr 2024 23:51:36 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98B06882A6
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 23:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d82713f473so26411971fa.3
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 14:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712267494; x=1712872294; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5sYf6tjussApSntegRK3O5sObKd2leiMmbPhYg8T45k=;
 b=hVshGC5l8ZF3KZNiRmJtDwKpnHLkMX4ttRBoGNR00kgabKb9cixPbCN5zQT1JaXM/c
 jNe7k/ucWsTmHSvtHdYtwBCE/Vw4PM1gIUoZZ/Skz8Jt6OOR0Nlc4Rl/0CHqzusQGR5f
 5eGSBDp3m0LUtXTC5NtGosl3pUupOzbO4uqMZu6z3L4KY/4104hvvU+s7opzwqs9K6Z1
 Q/3cYRg7pqRk+vl8Bh7FTilsuMIgdtf+7HRu137eu33U5ois8C4HL0Plm7KkzMDv272G
 pRzr7s5r1oRcPILkjpVakrHR80+1964KP308QbhgyjysLIdXB+Wsc4Gk3sfuyKkxfpsq
 Y2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712267494; x=1712872294;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5sYf6tjussApSntegRK3O5sObKd2leiMmbPhYg8T45k=;
 b=DNzgcXcPOjKKsxtphZyTg1H+DLwKKTtFo6Xr3T/cz5Om2lpoNnHH4ULiF5OY5ypvAg
 gruXpVVKtGJ0+Xa4xGjS7ptdQdfZ9rT3R8O7wRTR/GWaCN3TyLS7QqskEOwb98nIu+tK
 TVpeY7PzQJArIC7q0e2r9LyXa9ZV8jI55zdqme7NKr/3TAZ56kUdw+R3uGGZXzXc/PRS
 kAOOrWaXH3bLEbpVOALRF238Bhb4RnbxoWv7bmDsV6nhyc2ow3yDeMvarHSN7Q1OfTti
 GoIWXL5HTcdVD4n4nXM+ZXgiDuqG6rWOLxHdC8fcUZuYdPLUIyYSYmeaIUVmweNCu2Xj
 EqWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRCv07QIUaBQstvSdoPn3bjOv59KaQMFAPFP6ikn05jGDwCncHow3Mu0xUWM0qz1hmuvqJkM6DjDdVgMX3o1nnZniO0w==
X-Gm-Message-State: AOJu0YxojjAaCd3aiKfutmj6yCqKVTZHG6s3nO0x0BWHFNQCImk4ngS7
 0CBnxdOxmooZkl4Z61GYFzNPV+Lwr2LRO3hsBT82kx0BxgaDzqHcIqXjKd8o+Ic=
X-Google-Smtp-Source: AGHT+IHFxMTRaulw9R12VUIw/6lTzLSc/LMArijDVYmWP822H8bHYbCNyp+LoIpfQM3vL3NzNW0tkA==
X-Received: by 2002:a2e:88d2:0:b0:2d6:d2fb:3d27 with SMTP id
 a18-20020a2e88d2000000b002d6d2fb3d27mr3088661ljk.53.1712267493649; 
 Thu, 04 Apr 2024 14:51:33 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 kb3-20020a1709070f8300b00a5191b1a8d8sm51956ejc.142.2024.04.04.14.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 14:51:33 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PULL] Please pull qcom-next-2024Apr04
Date: Thu,  4 Apr 2024 23:49:50 +0200
Message-ID: <20240404215114.2149043-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.44.0
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

Hi Tom,

Some new Qualcomm features for you:

* Ethernet, i2c, and USB support are now enabled by default
* The clock driver gets some bug fixes and cleanup
* Invalid FDTs are now properly detected in board_fdt_blob_setup().
* The pinctrl driver gains preparatory support for per-pin function muxes.
* Support is added for two generations of Qualcomm HighSpeed USB PHY
* A power domain driver is added for the Globall Distributed Switch Controllers
  on the GCC hardware block.
* SDM845 gains USB host mode support.
* OF_LIVE is enabled by default for Qualcomm platforms
* Some U-Boot devicetree compatibility fixups are added during init to improve
  compatbility with upstream DT.

The following changes since commit b2511143fba4c0631446c968fb4c0d962b01d850:

  qcom_defconfig: enable USB (2024-04-04 17:46:48 +0200)

are available in the Git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git tags/qcom-next-2024Apr04

for you to fetch changes up to b2511143fba4c0631446c968fb4c0d962b01d850:

  qcom_defconfig: enable USB (2024-04-04 17:46:48 +0200)

----------------------------------------------------------------
