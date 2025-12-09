Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61000D1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 10:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3A3483B8F;
	Tue,  9 Dec 2025 11:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oDC7ph1c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CA2B83B8F; Tue,  9 Dec 2025 11:22:45 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD3283885
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 11:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-42e2e628f8aso2531788f8f.1
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 02:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765275762; x=1765880562;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hy2G7ix/0nEqLiC4EGg9qSk7CSS2hKEj1BoMFNruKiA=;
 b=oDC7ph1cEfR01upH/EJhUlYnV+dRycWfsmVRzMqggjWUH+5aMiYqxz+emLhIR71trZ
 yu1nMBWgShLLnfFK6y6lzp/Q0WqNsJ6Dx+S8I484D8W/PL4hnRA71yuEjEo9t67br1Om
 0PnH+Ym72TX4Rr/w+ShkjkmJOiOdOxyoohYY4dU688/qTM/Qnn2vLhT9hckgNyJks2yX
 xXwsSg0V0l3n5nb0CuvJMLhJWHlVkVg3N17/cIpynIsfzPwFJBBzdDK0jCbC5KFaQBG+
 L6vAr2QTfAHxz+zky7xNoQhw3LBcFy70ZbQmHXnWVcHYmhhB6IrApPgWJ57+rw9UF4A8
 Hfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765275762; x=1765880562;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hy2G7ix/0nEqLiC4EGg9qSk7CSS2hKEj1BoMFNruKiA=;
 b=xS1zAh9PzN+pEN4ajmwIXTGlsHQ04o/GhFxQhvo5eGf1YI+9fZNd+2U9FM5m0rr1fN
 +/nAVK7tRre5v8+e41YvXF6SY/kmShZsWxsuQyTj0DSxPfUfr5/v9j1Oe8WK/z0sGdyT
 vz47ZLEgPauFNYDyrH9PfYW9kbE+h0QMy0cIocBErl/7EqDhUmh9Ybc0LUgnMfuJj/Ut
 /DpF4VZO7BhCsm4oUM5p4UxHwi96nRWgPMmSCzaTmew4i6H12dWOovdh93sHderCivNm
 92S8gVvoFPYL/eJ2ORRFczAoyfWBaAvlRt+yi2Dx2Mqm07FU196IDZuSnacQyD8d98lK
 CXtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyHk/NtpZZSDKRcdPiKrOvr1Q8FnJJFbj9UWMb/QNigN2O2FkTLsz4j66yUKRKNsfF8rGzHgo=@lists.denx.de
X-Gm-Message-State: AOJu0YzqzMXqCWoQ7ZT/G0YX4V6XBAxu2+1doC0indqla5zGwvYvFQQB
 ptOLhJDAPRaxH4epsCR/bbCIOn9Pgt+K1kKxgahtDP2dPB7qRhMHCTjla488XyrL12o=
X-Gm-Gg: ASbGncuORaMy8oVJ0Yo5TdQQ041Nm9g/xPe4+wM2DpI5NCho9JQ7xmV1a7etHkRkgOS
 6Q2ZqA6eQrKlLeGmz/dileSpHAumaQ4EfQKRKn4QN8jxY7GWrorF+gFI9P8GtMUhCkkvRsosqEA
 q30DimsGbBcabwu9Iex9NoGjNTebVqmaZ8e1q9O+8F0hLbnimd85HHP5MatPFs3TZn7rft2R/ZX
 3JHq+6RSwPHTRuNq8jzjZP/o6bzalsJ6wjKdwAhqJ9HQwNzfKps635uUuIl++zI+iqPSJiaR4Zc
 Ol0t5C5reOQ2CSVPcM9cJmlbyfe7+qWvTmGW4yWddBDKHUKUDbJgEBb5Q35KYLdTfAeemSS64ow
 vmdkJEaC7cD9+/nU610gZLUuTehtVRivY/BDEXjKGikT/7YFJpr/qNrJ1C+3rTGD3+jYg8x2+6k
 N2ujfsmx1IhSyB5OUkJyfimTccwZz88deB5bRBsCfMWgYLFEYfs8T7eVC3OE9RSiVjvbsiD2o7g
 ThgOh7FYw==
X-Google-Smtp-Source: AGHT+IFYLDIJZYKQpIFZ0GUJKP45gkxpqZqH+g/jcLMPCrk5qVHChIg1qdKut6j+1nVG95MVUcys6A==
X-Received: by 2002:a05:6000:240a:b0:3e9:3b91:e846 with SMTP id
 ffacd0b85a97d-42f89f0fadbmr11576544f8f.10.1765275761902; 
 Tue, 09 Dec 2025 02:22:41 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-f92a-5586-f2e9-b313.rev.sfr.net.
 [2a02:842a:d52e:6101:f92a:5586:f2e9:b313])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbfee66sm30497029f8f.11.2025.12.09.02.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 02:22:41 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/2] Add support for MT8188
Date: Tue, 09 Dec 2025 11:22:23 +0100
Message-Id: <20251209-add-mt8188-support-v2-0-31dbfcf7303c@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF/4N2kC/22Nyw6CMBBFf4XM2jF9oDxW/odh0dJBJhFKWiQSw
 r9bSdy5PCe5524QKTBFqLMNAi0c2Y8J1CmDtjfjg5BdYlBCXaQSEo1zOMylLEuMr2nyYUarpXZ
 toTqRE6ThFKjj9xG9N4l7jrMP6/GxyK/95fS/3CJRYGXElaytikLnN2vWJ9tA59YP0Oz7/gGeu
 3sYtwAAAA==
X-Change-ID: 20251201-add-mt8188-support-b313dc72f04e
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Yao Zi <ziyao@disroot.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Julien Masson <jmasson@baylibre.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Sam Shih <sam.shih@mediatek.com>, David Lechner <dlechner@baylibre.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2
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

Hi all,

The MediaTek MT8188 is a ARM64-based SoC with a dual-core Cortex-A78
cluster and a six-core Cortex-A55 cluster. It includes UART, SPI,
USB3.0 dual role, SD and MMC cards, UFS, PWM, I2C, I2S, S/PDIF, and
several LPDDR3 and LPDDR4 options.

This series adds basic support for MT8188.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- Fix Copyright and Authors
- Link to v1: https://lore.kernel.org/r/20251203-add-mt8188-support-v1-0-9a06ebb97734@baylibre.com

---
Julien Masson (2):
      arm: mediatek: add support for MediaTek MT8188 SoC
      clk: mediatek: add MT8188 clock driver

 MAINTAINERS                            |    1 +
 arch/arm/dts/mt8188-u-boot.dtsi        |   10 +
 arch/arm/mach-mediatek/Kconfig         |   11 +-
 arch/arm/mach-mediatek/Makefile        |    1 +
 arch/arm/mach-mediatek/mt8188/Makefile |    3 +
 arch/arm/mach-mediatek/mt8188/init.c   |   70 ++
 drivers/clk/mediatek/Makefile          |    1 +
 drivers/clk/mediatek/clk-mt8188.c      | 1840 ++++++++++++++++++++++++++++++++
 drivers/watchdog/mtk_wdt.c             |    1 +
 9 files changed, 1937 insertions(+), 1 deletion(-)
---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251201-add-mt8188-support-b313dc72f04e

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

