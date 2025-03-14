Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5470FC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C604481E06;
	Fri, 14 Mar 2025 17:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VTGx9XQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39D1181ECA; Fri, 14 Mar 2025 17:11:22 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4262881D0B
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e033c2f106so3184343a12.3
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741968680; x=1742573480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/fJbPqmYepULTLC/w7BBSh1dLTNY/ETO8dv58oViIoE=;
 b=VTGx9XQiCnvxeTlDTPZdnrqQkR1jC3Vz4gdbTOJiUpqHkgpOHTgP1PtCMe5XVGRLjs
 26V3rlPTfL9+YgiVqsS1Pa0vNUgUdJD6At9O9J1PjAGeoHFkmmMaB8qKnKJjoAhwPf0M
 GVuDfSPLCYXwpR0Ul51Uj5EtGW0rOW7zOiXhvpFrc19+ShGrTz51738ecAB4ejBMj5pw
 fYrhbzO4t7hgYepn7q/ZBfTRXp+jzkUXULzd332191vaqS7/P4YOrtYByR7pRMMpqi0R
 wm2Sn7aKcT0pjM4IGbAAaKzeBkfTvsFKajgXojtevWVGvNZAKTLzLMmhNyLJBiLIDmTB
 Bq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741968680; x=1742573480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/fJbPqmYepULTLC/w7BBSh1dLTNY/ETO8dv58oViIoE=;
 b=tM09VMG2oWnef6+cGZoxOChtzPhPfSnNQyp2KTwA0/ouAUHEQ0pqWMiJbRWKFbjABB
 mZAxX4kMNEvKdhWgbHtdlhaFKDFDMRyG81FU0WpQ4zPUoyDe4FXR3o6lI4ALGS+dHdAU
 gS98xpOz1s6OFeq/9e9+7Up7wduxH1DsQ4U+wJt6XghvryJtCKZla5kweKLFpMB5csgE
 3cWdKCbQGZosogU64LGWPQXzoyHLIFl6E3QYSBO7bq/ALG8QVRuU0SC3ACIU76kEdlDb
 U5RegFF+2hsKKZ36s1ISjCbpeUyrXeRCGu15m4bwlvCKZgPoVQb0nkQwmvZVeFgl+KZO
 pkjQ==
X-Gm-Message-State: AOJu0YxVN/92tAIGfOXuuMKwicAjAVRqE4Kkgv4yfOS5iGIx03Hd7ggT
 F8/rITGJrm9d6YPNqZy7e+KfJX025OrxEFkbHbNXb1m6kr0W3abg1a63Sg==
X-Gm-Gg: ASbGncuicw0N4O86Zsmqc8cv0Hv5KPFXgLihO/VF08KXdFu3ypy6LySx96iZhxgSagL
 dw8zTOswDZAWguY2pYBFGtGcC7BR+2hP/Kw5DXmgsrsJHS0YEhEg09RfPoYE8durN7tpU2w44Zv
 nxfgZnFDd1UjkOM67ZOAtEp+SI2Vtj1/uanYCmBfBqIlHIyETZazt+2oN8/1ltjAx2z4dKsqblX
 jjHfxvMnotp8M+htA3XH1KLCUiCjPUdPSyTuFbDL/sQNRJI2SfTONNvqXGIOQS2WZGFBog9ZZef
 XoMPFX2aon4xXj6qVOD7oR3P12gcJO863S6c
X-Google-Smtp-Source: AGHT+IEjvwYw/LVX429oXpG3FyraOGuLdQbuZ7HE18NAiUDc6QmANUPFrIYHivdbhw+jalYlXSH89g==
X-Received: by 2002:a05:6402:5186:b0:5e5:b572:a6d7 with SMTP id
 4fb4d7f45d1cf-5e89e6b0648mr4233504a12.6.1741968679483; 
 Fri, 14 Mar 2025 09:11:19 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e8169bcdb3sm2161904a12.43.2025.03.14.09.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:11:19 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/4] pinctrl: tegra: minor driver fixes
Date: Fri, 14 Mar 2025 18:10:56 +0200
Message-ID: <20250314161100.36894-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Adjust pinctrl driver to better work with Tegra Linux device trees regards
lock, io-reset and open-drain properties. Fix pin and drive default values
and fix function naming mismatches on Tegra 2.

Svyatoslav Ryhel (4):
  pinctrl: tegra: adjust default values of pins
  pinctrl: tegra: adjust pin state lists
  pinctrl: tegra20: fix function naming mismatches
  ARM: tegra: dts: fix lock, io-reset and open-drain properties

 arch/arm/dts/tegra124-xiaomi-mocha.dts        | 14 +++---
 arch/arm/dts/tegra30-asus-p1801-t.dts         | 28 +++++------
 arch/arm/dts/tegra30-asus-tf600t.dts          | 44 +++++++++---------
 arch/arm/dts/tegra30-asus-transformer.dtsi    | 26 +++++------
 .../dts/tegra30-lenovo-ideapad-yoga-11.dts    | 46 +++++++++----------
 arch/arm/dts/tegra30-microsoft-surface-rt.dts | 38 +++++++--------
 arch/arm/dts/tegra30-wexler-qc750.dts         | 10 ++--
 arch/arm/include/asm/arch-tegra/pinmux.h      | 20 ++++----
 arch/arm/include/asm/arch-tegra20/pinmux.h    |  6 +--
 drivers/pinctrl/tegra/pinctrl-tegra.c         | 34 +++++++-------
 10 files changed, 133 insertions(+), 133 deletions(-)

-- 
2.43.0

