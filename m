Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E51C83F1D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 06:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 374EA8304D;
	Tue, 15 Jul 2025 08:33:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CBPle3Bz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11B1082B07; Tue, 15 Jul 2025 04:53:21 +0200 (CEST)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C79488277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 04:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jj251510319013@gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7481600130eso5653438b3a.3
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 19:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752547997; x=1753152797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jMHNop73rGsc2qAseM8BY5RZ2J0OH+NwXBM/BAlHQek=;
 b=CBPle3Bz5kAAGaVCYMcOjbDf2VS6LHZ+xMo9HTuxVyUV8eaTnhd+ZfMSzzGqxFuslO
 h0KLM5UEemHKYmQJnbDN6jvoHnCdJDlz26ZOnYI0tP8Myzfr04r8oDdhK7jh/MmYI0zn
 4JMAK8uEtnkVBMkCCGXUeuQapSFzFOophRHjUSmci2PKxmaVyOSHc265uTKWJyk92mLB
 D6gh9waUabp5GeTm2xE9X85WhjWxcw2l/QKZaD4U5pY70fwg7SdqdLigXYTBSFj9xZ+r
 dSV0HOoY4iz3qaDiG9jlBMLhtNOMSwB8v7L6m++vQstq7gVAexwki4Y5/7VEs1u32klO
 kH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752547997; x=1753152797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jMHNop73rGsc2qAseM8BY5RZ2J0OH+NwXBM/BAlHQek=;
 b=jrFJAZ5inNDbGTOqBbcm745hUn8RTmTuAzmTekr2qoTPl2z5c+/BWJ1WLVs0WB9KEf
 LQ2U1FDpbKQICMmbXh3wuDNw0d1p2uyxgscGe++7W5+FTxcFxE8Slgfs5aRO2HqJAgTi
 M5o0mnR6wM5fEJpGYaPWaXIUCUyX66CfoyvcWCSB7wZwvTn+qMELqIL2cTWGMPJygDw6
 5IZV7V/3nvS9hQlt0C+P1qGKzAUZkOdiCDI9W/7d6rf+USKml+2C644g/GPCByMaBVE4
 ZLu/kIsbu6HB4R6P0fQcZ3G/nKLY0Ltjl3VXLOpPpPJ3uGEmAc9CNnlDPlZbRSIuz0Sv
 3Bmw==
X-Gm-Message-State: AOJu0YwSkaClix6WJzp/folJH52MFtAnn0tAd0tGH/m33TofUGaX8NY1
 Gy7Ca/GSYVueRZ/zrzcC/KBbMHvKgFRNttl7v2IP5p9Ph9fGAaq16JULA6ynOQ==
X-Gm-Gg: ASbGncuBuQ0zKeEtI7wgQ6MjvKyVrb0cVlHazwlBUIJPvZT1+E/0wa4+hGS42z8fJ7a
 oD8nDzRvsb405bxZNXdGWpOZEsZDiCtRSxhjqlRCr1HqYRxUcxX8ZMHW1KnoT3gHKL4VtA0bmDy
 bwnfyJu9luNyAeHeGfhCoeJPj+r0bb5LGZc1vpM3Te0SA40PCmP3lWNWRP01GWt1szV+QLh7Cr+
 tMV6i3wAOHQkp59VKY0PnMzPXf+V+lazHWogK4Ptz1AbzjFBUQZF6bHrZ7WPS77fepIQXsqVgjB
 887biku1lQKOtsG6pXRF7qU6DvWfpLAe686o8LmzZJfpk8rfJRr1jmXCsKX5iF9urDecIAFiLPB
 +IhwO3+b4IsO6FpmYnnvPt7DjdsqWKv++1O3uSH5sg/XIkEzfncOw2c+B8RrSX75NMR5QuqMF2S
 9OfF3S9Rwj
X-Google-Smtp-Source: AGHT+IHeyIxVD8kfShDi/x5eFARZv+M9yJcdUDn9EAMKYiK5fWG5NPno9c/toPkG27XcNuf1IiB/JQ==
X-Received: by 2002:a05:6a00:1401:b0:748:ef3d:3247 with SMTP id
 d2e1a72fcca58-74ee333b573mr18915541b3a.20.1752547996679; 
 Mon, 14 Jul 2025 19:53:16 -0700 (PDT)
Received: from noble-uboot.lxd (124-218-37-86.cm.dynamic.apol.com.tw.
 [124.218.37.86]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f4ca28sm11777889b3a.134.2025.07.14.19.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 19:53:16 -0700 (PDT)
From: Aristo Chen <jj251510319013@gmail.com>
X-Google-Original-From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, ravi@prevas.dk, sjg@chromium.org,
 jan.kiszka@siemens.com, baocheng.su@siemens.com,
 Aristo Chen <aristo.chen@canonical.com>
Subject: [PATCH v1 0/3] mkimage: validate default configuration reference
Date: Tue, 15 Jul 2025 02:52:51 +0000
Message-ID: <20250715025307.2013-1-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Jul 2025 08:33:25 +0200
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

This patch series introduces a validation step in `mkimage` to ensure that
the `default` property under the `/configurations` node in a FIT image
references a valid subnode. If the referenced node does not exist, mkimage
now prints an error and fails early. This helps prevent runtime failures
when U-Boot attempts to boot using an undefined configuration.

The first patch implements the validation logic in `fit_image.c`. The second
patch fixes an invalid default configuration reference exposed by this new
check in the `k3-am65-iot2050-boot-image.dtsi`. The final patch adds a test
case to verify that mkimage correctly fails when an invalid default
configuration is present in the ITS file.

This series improves the robustness of FIT image generation and helps
catch malformed image trees during build time.

Aristo Chen (3):
  tools: fit_image: validate existence of default configuration node
  arm: k3-am65-iot2050: Fix invalid default configuration reference
  test: fit: add test case for invalid default configuration reference

 arch/arm/dts/k3-am65-iot2050-boot-image.dtsi |  4 +-
 test/py/tests/test_fit_mkimage_validate.py   | 45 ++++++++++++++++++++
 tools/fit_image.c                            | 10 +++++
 3 files changed, 57 insertions(+), 2 deletions(-)

-- 
2.43.0

