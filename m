Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54292C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 18:14:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84C0788871;
	Tue, 23 Jul 2024 20:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yMfVtBQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22BDB88845; Tue, 23 Jul 2024 20:14:44 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBCD28831F
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 20:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7036e383089so2822132a34.2
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 11:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721758480; x=1722363280; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P3GVMRnXiPuzbPUttwaU4loDFiWPhAjVj9io1tNcyUI=;
 b=yMfVtBQYFb6jftC/6I5CevD6d2dheFxMbaIQ3dQMgXMZly2q2DDGNbqCq49hKMdCdV
 xHJsz8EvA2QH8md+IIbXqHd6uKSBkJFQjK14q7AzznJitw9kDj0ZZEpdlBs1RpXRvQEs
 23YV2u4wkZFd0ZmffM1v6HS5O7NkcGCRl7mbAUVaBt29ACwHamLuRtJXfa2PEDDahJqR
 q32Lx8Ll08V1gmc7skWtG9jL95h5kqERfQWOGjE9uakU+qSuWDGX+WhOR+eqqQd37I2x
 kh+XwR9nM3eQL3q9mb20vZRjmSH4I34qvjvFMMt4UP4XpzC1S/abjggcDXxOGkZyxmnY
 19zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758480; x=1722363280;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P3GVMRnXiPuzbPUttwaU4loDFiWPhAjVj9io1tNcyUI=;
 b=t3bA9Pftqr7tdMiJ5lBidb8VszBMAcWIHej/wDYynbPwGADQcxJdYfo/UZ0mHiWLMW
 IFRaLdoiUsup6txDvXm4foX2IAq0o3bKWNfrENypOEOqrLAwCASXLxWShRvx5y9+qnro
 JDe0MLVWitunk2Mu3TodMJ3wMMqdThtXqarLfKq6DXJLObjxJ1QZN+6/9UkFEqGAQP9g
 h0nZ6KL+prYVUNKL6x6IPwRrn5GaorkeIJ701Ww5vwxsoB3A+jlN/cXAPkkeSqMJ1hqu
 SejqwT5wcpPDsRUOaJ6GWOIsrmQBuV9nvH8G8ePJoqzX97J3a7j/tYRDBsCgsn3p8Tvy
 VOLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpTDQDn1wipDLIQrdOlZDRH0piQAtpye4OQ2bk2QX2FxC+vbf9hv0A12yZef4JAoaOXpattxdmJ1UiMZcl+li5rFvPpw==
X-Gm-Message-State: AOJu0Yy0+Nj4D/U+pn4q33bGh4+LWj5hNRxwo0PCPx5QJBMBLIv+w8Z5
 q8VdjocpLSfaHtMMKXoMygsgENz2ess40TwNT03JOX2T9OqMcDYPFGyM7Shl1yE=
X-Google-Smtp-Source: AGHT+IHlh5ZYkbAEXIqV+HWoHeQGU8s9V9R8g20OiuO8lWMXadvlwrw6AQV1CI+NzhJI8iUDOSAHeQ==
X-Received: by 2002:a05:6830:6186:b0:703:5efa:3ce4 with SMTP id
 46e09a7af769-709180983e5mr4659498a34.4.1721758480630; 
 Tue, 23 Jul 2024 11:14:40 -0700 (PDT)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708f6189ca7sm2126190a34.72.2024.07.23.11.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:14:40 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <promsoft@gmail.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v3 0/5] arm: exynos: Enable TRNG for E850-96 board
Date: Tue, 23 Jul 2024 13:14:34 -0500
Message-Id: <20240723181439.7089-1-semen.protsenko@linaro.org>
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

Changes in v3:
  - Fixed applying the defconfig changes (patch 5/5)
  - Rebased on top of the most recent U-Boot/master

Changes in v2:
  - Addressed comments for [PATCH 4/5] rng: Add Exynos TRNG driver

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

