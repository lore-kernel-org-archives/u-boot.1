Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 050EBC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 23:43:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9706887FA;
	Sat, 13 Jul 2024 01:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bMfVvNHI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EFA488427; Sat, 13 Jul 2024 01:43:09 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2BD88609
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 01:43:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5ca9835db95so1433192eaf.3
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 16:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720827785; x=1721432585; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EyTMlOkRbE8fiCLWxzZ7VGroqbI/uR1qk+gHE22RDx0=;
 b=bMfVvNHItq0CxmXbKAaZmBgpxmBi3AQLsn8vPU1YFFv1p/5shAVdcJiR5FxLN1Q8wB
 NPolL3qqp/FBwFccuUnBkzuGlDLVupbIk0mhB237GanWzVUZcedeTvGmx3DxGYmmUv0m
 nuftTautF2XqSaVpX/ZaVcCQL1dipjsJOeWnblda6yTmPUC07DtOMFGy64l06ILAWCSY
 7/pPK5qVzfnVQkUeIUPkd2hXVtrBZl/Sp863/SezKRqArrzqYl3jsbLKzgl21QD7ZeJc
 66Qrgrl/fDC63v0XL+VX15K23XFd2xu67TQHBE8YX7y1tHaCUuG614O+UPTKiPazIBVk
 yWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720827785; x=1721432585;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EyTMlOkRbE8fiCLWxzZ7VGroqbI/uR1qk+gHE22RDx0=;
 b=TW44Xtcbjk3IqPIoTNRYFO5yiA+fZUQ6VudQpf6/3Hp/yBXMGmzrxs5v7ehvedxcsU
 P3MCf6yX7Ijs1SPQ1B+VrKao/sMD4/t0BCAMQ/4Iu2vCPIbw5f+J57L6OjKvd3h5h9vb
 cUQoCh0WfX513E1xihw0L+86/dkLWMO1ABoC+P6pf7S9MuJlnnaEwnXEOuUk0wEEz6H1
 4nt8A6huagA4fxS3ORZSr3mxiD5Po3A6BAHmxsu+nDrZP5WVBTKw7tTLu3hVlsEVMI+g
 8loXLfo5HdJwslm0QO7iVgWHB5rIrVBX+kxqoY5KF4G++E2MTpO3SPnxlW9KBRa+Ui5H
 K5Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaZolMeov/umHDk5Dp4eCzX6Fxsw1UDn2AoUBxr9QRD6iTlpgblX7Y2K65nBrNzLq0a82JCOQMGOovKZ6svHQDtmjXEA==
X-Gm-Message-State: AOJu0YzagJs0NtlVkW/yOCbt7on5k2XNI/ZjJtJhlyYomMzsO+JEDCjK
 ySNoflZUySxXIN+XZmE6L+RDrYdhscpDbe/kMyLTUd47rut4hmrX/h5qscsv7o0=
X-Google-Smtp-Source: AGHT+IE0to2KTNhP/rR+L2RChrlN5eyEnUoV4vYxZKK0jLyiAVmh4QLQ1OUt9qeQu7tTM4SH0X78Lw==
X-Received: by 2002:a05:6820:1e14:b0:5c2:1bdc:669c with SMTP id
 006d021491bc7-5cce6b55ae5mr3166705eaf.6.1720827785339; 
 Fri, 12 Jul 2024 16:43:05 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ce774dbde3sm15329eaf.43.2024.07.12.16.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 16:43:05 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de
Subject: [PATCH 0/5] arm: exynos: Enable TRNG for E850-96 board
Date: Fri, 12 Jul 2024 18:42:59 -0500
Message-Id: <20240712234304.9675-1-semen.protsenko@linaro.org>
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
in turn is needed (among other things) for EBBR spec and SystemReady
certification. With this series it's also possible to use TRNG in Linux
kernel (which was recently added, see [1] for details), as Linux kernel
Exynos TRNG driver also relies on LDFW firmware to be loaded in the
bootloader.

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
 drivers/rng/Kconfig                        |   7 +
 drivers/rng/Makefile                       |   1 +
 drivers/rng/exynos-trng.c                  | 275 +++++++++++++++++++++
 12 files changed, 482 insertions(+), 4 deletions(-)
 create mode 100644 board/samsung/e850-96/e850-96.env
 create mode 100644 board/samsung/e850-96/fw.c
 create mode 100644 board/samsung/e850-96/fw.h
 create mode 100644 drivers/rng/exynos-trng.c

-- 
2.39.2

