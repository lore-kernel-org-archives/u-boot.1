Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D897C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 03:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8439E88967;
	Tue, 16 Jul 2024 05:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t+7AIIpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84A6387E15; Tue, 16 Jul 2024 05:17:14 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6A5587919
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 05:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-25e3b8637c9so2057537fac.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 20:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721099830; x=1721704630; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FIv15UTZn8DHWxa/3B+r7OrQpE6qZ9Tw3X9RDgCc4ow=;
 b=t+7AIIpErLoZSeNA1Hxy4VWgRakCiVC9vyCbWvsVu3wG8WmzEFiWhjOhZNK0gIOZbA
 EOCIh2ni3THmUG+O8f+i3KP2KVn2MjHhJ3+W0as5a1xtnFpzq3VoHtXhRVIDzqzDXPgZ
 kFHC4mgdOMZFBI0J3LLR9qy/yRITZHQF2dE1qTdQZDCWTciJqhwhnWjBEzF9hOQk/wGa
 C4Ljh1EWKLZDUarpu1YOHShZVTFTXtlP+W6aVVYwQKqJ86h+s+fKAyawTk9nOwotj/bN
 C9c2FJHhfKl5JNAR8RodSPMVvgWE39xmuyzpEAc9q+0SXXcXvmVMxHcLPNgHB/mUaRJk
 opcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721099830; x=1721704630;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FIv15UTZn8DHWxa/3B+r7OrQpE6qZ9Tw3X9RDgCc4ow=;
 b=hbgTF3zVdUopvMLb8TNLQMMo6RnmJk4rt3fyjFlqwMjBhKRegLMfqxmFBtIu3lA/xp
 YZF07MNfA46qDU8dnCK6aDSIkqNfCcw24Xp+YQaYYfk2Dt+BuQvNEfZTM2iS80Kstvoc
 62ZuPPtd8pQINoMei8TlNBYkz7jTVDP/SyogYIM8TTj1fLWHiwKLrTwy9uieGuTwlUGw
 ueeFK2ORir2fwyWEW+eepSpnecPcvFehzC2ZoYJMC95pV7fnbkaWwudOArH/MGv2UvL2
 bAWGMQhO3X3ojMH1mfGYTJKXSdmI+NsloipNdUd2HWIKC1diUBxW72aICU+gvDJj/UoM
 nhwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX9O60Ide1nrIaEvvdBda6mkHUc+A7U0W+BVGPxfR24bYjhAxkais6UqFWsNybmmKMnfQjpOICy/oVxsgVcYDUgkjv1A==
X-Gm-Message-State: AOJu0Yz0X+gZLXMkHlLnlH6Wg8ymnmUrxGTY6/yO1SLAMe8g2iDg9RbU
 tpHuwQuHNROW1aTDhWpQBSP0VCjWlChL80kXV+22cVQ2d3Is3xq6E+Rf8eEQ+B4=
X-Google-Smtp-Source: AGHT+IG1/c5R2v/meb4QbOuARNLFsnIXp8ySwmsV9xL50MHyfa6CBaw4NDYxnn4Tu0JutX4NhOLsBQ==
X-Received: by 2002:a05:6870:968b:b0:260:3ae9:c94 with SMTP id
 586e51a60fabf-260bdfefaa4mr620459fac.51.1721099830341; 
 Mon, 15 Jul 2024 20:17:10 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-26075176419sm1215496fac.31.2024.07.15.20.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 20:17:10 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v2 0/5] arm: exynos: Enable TRNG for E850-96 board
Date: Mon, 15 Jul 2024 22:17:04 -0500
Message-Id: <20240716031709.24943-1-semen.protsenko@linaro.org>
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

This series enables True Random Number Generator (TRNG) for E850-96
board. Here is a short breakdown of features implemented in this series:

  1. Load LDFW (Loadable Firmware) on E850-96 board. It's needed to make
     TRNG SMC commands functional. To do so, add the default eMMC
     partition table and implement reading and applying LDFW in
     board_init().
  2. Add Exynos TRNG driver
  3. Enable Exynos TRNG driver on E850-96 board. It requires SSS clocks
     to be enabled, so add those clocks as well.

With this series it's possible to generate random numbers in U-Boot
(e.g. using 'rng' command). The main reason for RNG enablement on
E850-96 board -- it's needed for EFI_RNG_PROTOCOL and kaslr, so it's one
of the requirements to enable EFI boot support on E850-96 board, which
in turn is needed (among other things) for EBBR spec and SystemReady IR
certification. With this series it's also possible to use TRNG in Linux
kernel (which was recently added, see [1] for details), as Linux kernel
Exynos TRNG driver also relies on LDFW firmware to be loaded in the
bootloader.

Changes in v2:
  - Addressed comments for [PATCH 4/5] rng: Add Exynos TRNG driver

[1] https://lore.kernel.org/all/20240618003743.2975-1-semen.protsenko@linaro.org/T/#me6ba1762a254ca438a9715f011d32820babfe2d8

Sam Protsenko (5):
  board: samsung: e850-96: Add default partitions
  board: samsung: e850-96: Load LDFW firmware on board init
  clk: exynos: Add SSS clocks for Exynos850
  rng: Add Exynos TRNG driver
  arm: exynos: Enable TRNG on E850-96 board

 arch/arm/dts/exynos850-e850-96-u-boot.dtsi |  11 +
 arch/arm/mach-exynos/Kconfig               |   2 +
 board/samsung/e850-96/Makefile             |   4 +-
 board/samsung/e850-96/e850-96.c            |   6 +-
 board/samsung/e850-96/e850-96.env          |  26 ++
 board/samsung/e850-96/fw.c                 | 131 ++++++++++
 board/samsung/e850-96/fw.h                 |  12 +
 configs/e850-96_defconfig                  |   1 +
 drivers/clk/exynos/clk-exynos850.c         |  10 +
 drivers/rng/Kconfig                        |  13 +
 drivers/rng/Makefile                       |   1 +
 drivers/rng/exynos-trng.c                  | 291 +++++++++++++++++++++
 12 files changed, 504 insertions(+), 4 deletions(-)
 create mode 100644 board/samsung/e850-96/e850-96.env
 create mode 100644 board/samsung/e850-96/fw.c
 create mode 100644 board/samsung/e850-96/fw.h
 create mode 100644 drivers/rng/exynos-trng.c

-- 
2.39.2

