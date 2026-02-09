Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9AFE7E0D5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E9FE8397D;
	Mon,  9 Feb 2026 19:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aeb1XwBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE7983C54; Mon,  9 Feb 2026 19:32:28 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D616380325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-59ddb31ddcaso5380581e87.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770661946; x=1771266746; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OIRaD3c3SNHlrvsel2auziS7cZzN+lQXw6aHKXOWKDQ=;
 b=aeb1XwBYBC2GZnqge2gPaGBmH1mdB3EcFAwQkWpgRrsopABy7EPVWy9KS6vVCNX+lM
 gkNJ4W6twjFwnnh9I5HQJ2zJGR0rBV7jIAnQxBRaeP+aSMlgzyxHpJaXIWDT/mXxX92l
 0lDNe0VecLGg019kAc2SHtz8PHE3e4qB6M4Q4I8y3xsJatVWmj1fFz73GqnOUW1thGG+
 WD+cAc1ANlGDnzxIB2MR3CEDzRB04SqADgBewtRwZap8dl2en5LnvDwbsznwoMNxFi3v
 BxD/qgE30g1nW5rW5EIYjXAFTn2L4iwqZM7zjw97tmqtG9RTYnA/MuDn9E+hxSQ2wF8k
 VpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770661946; x=1771266746;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OIRaD3c3SNHlrvsel2auziS7cZzN+lQXw6aHKXOWKDQ=;
 b=SADGlUQ2BaaxEMMO7Ml+o3WIUps0A9ufP/FtMCNJOoKBh7w18NU+o+rMtuNhPL0mtN
 R5W4LoP3NQOdwygOz/DREB2DPxWGuNncOkpkG3r28Xo+dJK0Bw3ZvYeRRDJdEug5WJt4
 /YUkB1n15ow3kiG92F9JTsRBQr894DA9klkAyJK56+dKzYQe2+nQWmZVTwpvt4htYf2K
 0DD8QAqVJ0Tv4G+tBa2pqHi28YALqBLGl7dlSFfSXRuCILBbgWckr4i8JafTX9In3tzW
 YrEJ87E3iVda/ygct1ioHbusWm8qekUq0gztqEfLycym9gJFNYF4dt387kSDyT4BSxD7
 r0qA==
X-Gm-Message-State: AOJu0YxAsWFHQxOEqiWLu2FnOiw8TpS74WoTYJGGwgyCaoWSnhFxNDvA
 P2hBpVA1LxeCMichZlAz7HHqqC3XJUN0yH7xQHKhtRSceNSwJXJ1JAjk
X-Gm-Gg: AZuq6aKrYZi1SzaJeOWLlDPgg/P9TEnDLoAjDESkuC2u5V/97TgP3MwG/A0B1Ox5EgC
 rp6S89xkryOEPS2pAAvGPTU0CP6xPZr2l94Cpw3nkb5cuId6cvFWqUycvbplgzILWMaE1zf7uD1
 L/k1+5SnCH6rBIP9fBe59ybuUY0vMEKSJuYT/jSCBa8PA3zVMO4Kv26biURDrktrmjvlwttwp1N
 8L4lKYI1q5hiqKj3piaMqtT7Ub6lUJyeqoZltLr9Do/dgklOcgLz70+n1oIWFd+9Wb0pFV3kBvr
 nzc0Kmf4k7ZgnKy24MxueiqyiGHy2li8iCYe4+pNwMcJnN78JypqYvCa9fosB/1R1EuxJujvG6K
 Vw8xBkx2sjsLWXcvnBpFGl2In5EfEdiv9Tdl4102VeSQYnbFEyfUgSYoJKhHMjQbalcbC3ZCpLQ
 1f
X-Received: by 2002:a05:6512:39d4:b0:59d:e65a:26ba with SMTP id
 2adb3069b0e04-59e45152d78mr4105627e87.27.1770661945893; 
 Mon, 09 Feb 2026 10:32:25 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44d299ffsm2815391e87.55.2026.02.09.10.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:32:25 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Ion Agorria <ion@agorria.com>, Peter Robinson <pbrobinson@gmail.com>,
 Peter Geis <pgwipeout@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 0/6] ARM: tegra: various fixes
Date: Mon,  9 Feb 2026 20:32:13 +0200
Message-ID: <20260209183219.34250-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Minor adjustments of device tree of recently added tegra devices,
board adjustment for P990 and rename of sdhci to mmc in all
tegra devices ligning it with Linux kernel trees.

Svyatoslav Ryhel (6):
  ARM: tegra: lg-x3: fix panel property
  ARM: tegra: surface2: fix panel supply
  ARM: tegra: mot: change backlight LED source
  ARM: tegra: remove unsupported properties from the max8907 node
  ARM: tegra: rename sdhci nodes to mmc
  board: lg: star: make panel fix optional

 arch/arm/dts/tegra114-asus-tf701t.dts                |  4 ++--
 arch/arm/dts/tegra114-dalmore.dts                    |  8 ++++----
 .../arm/dts/tegra114-microsoft-surface-2-common.dtsi |  6 +++---
 arch/arm/dts/tegra114-nvidia-tegratab.dts            |  4 ++--
 arch/arm/dts/tegra114.dtsi                           |  8 ++++----
 arch/arm/dts/tegra124-apalis.dts                     | 12 ++++++------
 arch/arm/dts/tegra124-cei-tk1-som.dts                |  8 ++++----
 arch/arm/dts/tegra124-jetson-tk1.dts                 |  8 ++++----
 arch/arm/dts/tegra124-nyan-big.dts                   |  6 +++---
 arch/arm/dts/tegra124-nyan.dtsi                      |  6 +++---
 arch/arm/dts/tegra124-venice2.dts                    |  8 ++++----
 arch/arm/dts/tegra124-xiaomi-mocha.dts               |  4 ++--
 arch/arm/dts/tegra124.dtsi                           |  8 ++++----
 arch/arm/dts/tegra186-p2771-0000-000.dts             |  2 +-
 arch/arm/dts/tegra186-p2771-0000-500.dts             |  2 +-
 arch/arm/dts/tegra186-p2771-0000.dtsi                |  8 ++++----
 arch/arm/dts/tegra186.dtsi                           |  4 ++--
 arch/arm/dts/tegra20-acer-a500-picasso.dts           |  4 ++--
 arch/arm/dts/tegra20-asus-transformer.dtsi           |  4 ++--
 arch/arm/dts/tegra20-colibri.dts                     |  4 ++--
 arch/arm/dts/tegra20-harmony.dts                     |  8 ++++----
 arch/arm/dts/tegra20-lg-star.dts                     | 10 ++--------
 arch/arm/dts/tegra20-medcom-wide.dts                 |  2 +-
 arch/arm/dts/tegra20-motorola-mot.dtsi               |  6 +++---
 arch/arm/dts/tegra20-paz00.dts                       |  8 ++++----
 arch/arm/dts/tegra20-plutux.dts                      |  2 +-
 arch/arm/dts/tegra20-samsung-bose.dts                |  2 +-
 arch/arm/dts/tegra20-samsung-n1-common.dtsi          | 10 ++--------
 arch/arm/dts/tegra20-samsung-n1.dts                  |  2 +-
 arch/arm/dts/tegra20-seaboard.dts                    | 10 +++++-----
 arch/arm/dts/tegra20-tamonten.dtsi                   |  2 +-
 arch/arm/dts/tegra20-tec.dts                         |  2 +-
 arch/arm/dts/tegra20-trimslice.dts                   |  8 ++++----
 arch/arm/dts/tegra20-ventana.dts                     | 10 +++++-----
 arch/arm/dts/tegra20.dtsi                            |  8 ++++----
 arch/arm/dts/tegra210-p2371-0000.dts                 |  8 ++++----
 arch/arm/dts/tegra210-p2371-2180.dts                 |  8 ++++----
 arch/arm/dts/tegra210-p2571.dts                      |  8 ++++----
 arch/arm/dts/tegra210-p3450-0000.dts                 |  8 ++++----
 arch/arm/dts/tegra210.dtsi                           |  8 ++++----
 arch/arm/dts/tegra30-apalis.dts                      | 12 ++++++------
 arch/arm/dts/tegra30-asus-grouper-common.dtsi        |  2 +-
 arch/arm/dts/tegra30-asus-p1801-t.dts                |  4 ++--
 arch/arm/dts/tegra30-asus-tf600t.dts                 |  4 ++--
 arch/arm/dts/tegra30-asus-transformer.dtsi           |  4 ++--
 arch/arm/dts/tegra30-beaver.dts                      |  8 ++++----
 arch/arm/dts/tegra30-cardhu.dts                      |  8 ++++----
 arch/arm/dts/tegra30-colibri.dts                     |  8 ++++----
 arch/arm/dts/tegra30-htc-endeavoru.dts               |  2 +-
 arch/arm/dts/tegra30-lenovo-ideapad-yoga-11.dts      |  4 ++--
 arch/arm/dts/tegra30-lg-p880.dts                     |  2 +-
 arch/arm/dts/tegra30-lg-p895.dts                     |  2 +-
 arch/arm/dts/tegra30-lg-x3.dtsi                      |  2 +-
 arch/arm/dts/tegra30-microsoft-surface-rt.dts        |  4 ++--
 arch/arm/dts/tegra30-ouya.dts                        |  2 +-
 arch/arm/dts/tegra30-pegatron-chagall.dts            |  4 ++--
 arch/arm/dts/tegra30-tamonten.dtsi                   | 10 +++++-----
 arch/arm/dts/tegra30-tec-ng.dts                      |  2 +-
 arch/arm/dts/tegra30-wexler-qc750.dts                |  4 ++--
 arch/arm/dts/tegra30.dtsi                            |  8 ++++----
 board/lg/star/star.c                                 |  4 +++-
 61 files changed, 169 insertions(+), 179 deletions(-)

-- 
2.51.0

