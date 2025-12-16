Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345DDD5C0C0
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 02:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F02A80077;
	Tue, 16 Dec 2025 03:47:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IiBAV+0h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24730800AB; Tue, 16 Dec 2025 03:47:52 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB7E28003E
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 03:47:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7d26a7e5639so4623102b3a.1
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 18:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765853268; x=1766458068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TITfNZv5W6toXo34g9Bwm/0vpcm2276HmestGo2gOFE=;
 b=IiBAV+0h3xp0DBME/2StoOtoxZIo6PhM/14L3OR/hYaoCc98OTB0fSzQAj6JDAZv0v
 suU3uuIOw3RgXHeii+TIMVrNqVxfChXuxy83cNa4Hk8qrtsYjKJheQGcplyPTaSdRAaK
 S6WEGaBhsO7WJM9dSrC4x/Crvvdh7cksQxIq6cLa1c2CWfpxeUohSzaLsJGYDHiBaFGF
 YHCLia2aFActnrw45ZveB3NODS6aH1v6VGxSCzRpSue5Y9xJosWMwAMl2NKqn6cFLXH/
 NL6MfQtMIFcm9Xtbg3r82Fz6Og6gC06G97/OkzRVxIWw9Jl5ACo8TqP//0mQbVLDtei6
 JaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765853268; x=1766458068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TITfNZv5W6toXo34g9Bwm/0vpcm2276HmestGo2gOFE=;
 b=L979GORN2LAfqWyb5llU6XTlbLBvzFAVGCOU/YDq34tjQJsGng01ogrGP/WLDbfnA4
 yBcNnr4F35cEgzCKJ5mE78TQ9yBdo3MW55PNpwrw7P/NTGxoga46LT28cKbkTdWS+8MA
 Mlb4awos9E/Vs9NLUp+hVO7/wY/mXJP1d6F/f469pnqIk4vO9naUykeucTp5Rtb/dLpM
 FfzGUZvBLnDHpUKLsrAvUs2QqAdSaprA+yCUpYKirsKubG4n3mfKbARS/JfDWZLQojfV
 hrkezRaXxMcglgAhDnvcWtgOaQjz+QNI/WZ2GQk+7l7tjHa57EEC/Nx5VresIu6n+8+I
 BaUA==
X-Gm-Message-State: AOJu0YxZRhp+3Wx+tvugoWvDm6N00FHXDnTsYjKD/UVY2+BVGjrepHkk
 JtRElBu20caJrMfXy5wlInGXUwAW35fZCI8ynG68ja3zq7qQQr5A9mtnwXL3xJdA
X-Gm-Gg: AY/fxX6ST0my6oELyoiFSVRuOM4eEAwSRJ1T/hBv+84eHNiaHSFDUkoIZ61nzlpZAbB
 qNn7GbSQ0HS4YHTn1f+KcoJtUSWfUNouBGAeGftgBsAWQvxAy1wQwwtXlFotp7jl004HJYYAJeC
 UyeUNmIzQHH0XUCenwflyqtYhINNdH7UY2vvlT9ewztzPRTPYKjk6vlCs4+R3N7N5b7kEjMu/HJ
 HejPHs3r0i8NNuZDQGAF1syZ/z/CDYvvaLviOfXnl0gVGxMlPAj6ZFb1AlwUDQrHwalfjQ162un
 PONhwREZuZ5aPr0SnQ/pnDOpWvuzfwEGUn03MwVNpE/IujgT/dtyVpXbYVysS5Fv1N1NjxaQoDe
 Z5cWYVTCAWqw3f3YKl7ta3GpM3tVhm2zsOtrCow/2juHZStX9r9eUnTrLwZzQFwFVRcNBxeJlxV
 A1jRzTHxSu0DraT0okUPuhfw==
X-Google-Smtp-Source: AGHT+IGyIzMnYdSnjPdN1Hw3Pdd6S8BFCdDfiN7NEODOAxDnYb0bhC2R1VZs+tj6ssLj7wA9Z7uiZQ==
X-Received: by 2002:a05:6a21:3283:b0:34f:ce39:1f42 with SMTP id
 adf61e73a8af0-369b432deb9mr12082864637.8.1765853268044; 
 Mon, 15 Dec 2025 18:47:48 -0800 (PST)
Received: from cs20-buildserver.. ([2402:7500:502:d4da:9fd1:87b1:de1a:188c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c26eb1d05sm13401606a12.13.2025.12.15.18.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 18:47:47 -0800 (PST)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com,
	jim.t90615@gmail.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/6] modify npcm7xx/8xx feature and bug fixed
Date: Tue, 16 Dec 2025 10:47:23 +0800
Message-Id: <20251216024729.1031306-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
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

modify npcm7xx/8xx feature and bug fixed

Jim Liu (2):
  gpio: sgpio: modify persist check condition
  arm: dts: Add SGPIO node in dts

Stanley Chu (3):
  watchdog: npcm: Support more timeout value
  pinctrl: npcm8xx: Add smb11ddc pin config
  dts: fix typo in the pin name of GPIO191/GPIO192

Ted Lee (1):
  pinctrl: npcm8xx: Remove incorrect spi0cs2_pins and spi0cs3_pins

 arch/arm/dts/nuvoton-npcm845-pincfg.dtsi  | 10 ++---
 arch/arm/dts/nuvoton-npcm8xx-u-boot.dtsi  | 46 +++++++++++++++++++----
 drivers/gpio/npcm_sgpio.c                 |  8 ++--
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c |  6 ++-
 drivers/watchdog/npcm_wdt.c               | 25 +++---------
 5 files changed, 56 insertions(+), 39 deletions(-)

-- 
2.34.1

