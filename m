Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C8EC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 11:12:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0873880F56;
	Wed,  5 Mar 2025 12:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Eo07zURp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF8BC810DC; Wed,  5 Mar 2025 12:12:30 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7F9B8003E
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 12:12:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5439a6179a7so810859e87.1
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 03:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741173148; x=1741777948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JGdShUklW4ktBOPp55j3y+bxocrIe5ta64ryl41lWOc=;
 b=Eo07zURppwquQyACbxMAj+v6dNczIvy09RGtOSe0IoCDQF3rGYwxUL7gFivT9C6ph6
 9wiCjj6/UMIK+2l2BA6pHAQceIjQmqHAxnnGXq73+mK2qi0pZaWUHcrXS8Z8N5iqblVm
 9bJ/gfBKoNg5GJ/GoZv/1rCnqke+rFieGAK0uNyp56Emczr3fCpUkAqjZOTj90A2auWM
 1nFkmck1XZrTMq7O71PNzyUlbnQXnbKZMmi3jIWg004pYE3tSY0AgM4UKKKQBrFKt72a
 d624Wkqw6KOCs3JPiBH07Bz8cP3S+J2asgBNi/EQmMgmU42dPzvrhSWy5ms1nUX98Fdt
 oUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741173148; x=1741777948;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JGdShUklW4ktBOPp55j3y+bxocrIe5ta64ryl41lWOc=;
 b=A9k292OkocKsY0XZoCfsJpq+MXAfWMbGqheMRYyvyJl7/U60dBCuN0W3SHLw5LdMZN
 QS2528kcf73YE7p3JT+YGG+fdkhUtutZx2L/UBe/oIPp76iytmpq6ZUT9Dbig5lSRH+R
 NvAiyt4WqSBZNh3m4WFXC71Ak/2umMNbS/W+dl1arBWraMjhL9Rxj1UXihDA9oTTzGtz
 sFjDNyIo5LvObdyQSdBNv1wGTa5JuMtACKYhrewpYT2Oy/MmfJmTDwU6m+AMmVzo44A1
 SoNcBNzz4ly0mnyBKvZjqVhDTOfH1XRYOkzgPQhIIf4s2CWahl2KFU3GaZRG3RYPfXrN
 rqQA==
X-Gm-Message-State: AOJu0Yz3eqvpV4TJHnxxctiCTL+zxiMBGRw7XDCu3Nl+5IINO67ZwluC
 Mc0BDJEHRMd3La347RPvy4ERCAxsW18rDwVHeMC7ZBoKYfjEHWdI
X-Gm-Gg: ASbGncsISUMEDp5NPCuyXYJQrvG7cDUqnyTvQNVkGn/1mO+mIkNWp1D5/QhwwVv1cjL
 +FYJm2YNDoqaGLz72/dOZzjr4j2sPgUb0PWJ8SVffn5jy/7y3bM2rDvitcOjFpoTRZ5JS0fuvYh
 lEPPoKH61tV5kWeTqVvCIUzsJLDEYUzegY3qMvVmYXMmQ45fPpr8G93WN188bSmGlt42BfiEPrN
 pYfLcDo6bQzoayqm1DhwuVxkfQebglvld5G3m3X+ftBIBWqMagM9flKS4CzIIauQMqsliV7DONT
 zDsnXXqLNnzdHrE3fQqb3QcJGLr+qiKQnibO
X-Google-Smtp-Source: AGHT+IF/21Orsa7Yai1ZzDYKb9bz1N3xp+ZPgq1LeBeVkhyy+wVZ1efnPht2uvPiO85YrkWpCCwsMw==
X-Received: by 2002:a05:6512:b08:b0:546:2ff7:530d with SMTP id
 2adb3069b0e04-549756e4ea1mr2229655e87.25.1741173148005; 
 Wed, 05 Mar 2025 03:12:28 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30babec1731sm12490791fa.62.2025.03.05.03.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 03:12:26 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/2] Tegra: general improvements
Date: Wed,  5 Mar 2025 13:12:11 +0200
Message-ID: <20250305111213.163428-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fix PLLD/PLLD2 related clock calculations to better fit existing needs.
Mark second DC on Tegra 2 with bootph-all as it is done for other generations.

Jonas Schwöbel (1):
  ARM: tegra: clock: fix PLLD/PLLD2 related clock calculations

Svyatoslav Ryhel (1):
  ARM: tegra20: mark second DC with bootph-all

 arch/arm/dts/tegra20-u-boot.dtsi |  4 ++++
 arch/arm/mach-tegra/clock.c      | 30 +++++++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.43.0

