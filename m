Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56A2D2F03E
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 14:43:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 735338408D;
	Tue, 27 Jan 2026 15:43:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GDfZSrd2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45F2484081; Tue, 27 Jan 2026 15:43:00 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA088408D
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 15:42:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-29f102b013fso52454545ad.2
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 06:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769524975; x=1770129775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uQK4bcBRlFkCiKyoVhmUfNGQJ+QPqJMCgWFea1Vu1/E=;
 b=GDfZSrd2DXYVqlUlUaHD3bTa4ihLRXz10WxJkDKs0ZT3t3hya59NzEckYoQ3UgzcP9
 Ct+N3L8pz2eTE70DielkM+EjfvceRodR3d3HOFynyyHYxJT6EXMNZSkOHoZHlrDBeFR1
 MJcQ2t9kKCbZ1d8uHaGFFV//m7AMd+AX4y83Q8/bIliZOLfvvvNkCw7w96+LtzAsb+gu
 Evsz+EiB0ZFmfIxLECMQHgNgCuOIqCYZELm7skjNvTBehlagQ/AEv6eWGAp6s1sOtjJD
 cA5F38bFjQeAyhiL78fgBXBfJ/1QaAIENI3zlz9dm5xwBmc+kj3+I6G/zNOmAuEAL3Tp
 9eWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769524975; x=1770129775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQK4bcBRlFkCiKyoVhmUfNGQJ+QPqJMCgWFea1Vu1/E=;
 b=XOd0AjwnHia7KfT7SDHHV1URd1WroDZkEKan0rF/t6cN4U877ZgtLFBcnVh3FlHRmw
 XPGw7vYjGCHMWP4s1DmBMUZfG3kYGaUqknsHo0o82N3kDOf6VkTB1zQHXdQmpOlKGAD1
 yYnMK7izkhfa5fMJuJOVIW9Lw2trWrlVH1fRxGsTjKzzSjq6T6TjdLgS92T0UMfggBMO
 69QyMjtytC5KR46/yiDST0FQ3ZXDQyYQOJ3lx5xuzlz/7pVBE1RUq7Drcgkr1XAQiVbW
 3sBqF9PwKQbhH1dpvoLCYuLbj8aQTtXlvrAN84XBxpcAL5PXBdBgLPC4+OmjKzZ+czNS
 S94A==
X-Gm-Message-State: AOJu0YzOxPvKM0vgRfLudfGtmsaH5pVXjBsnFt4sk01i0eVSPZsCRZgG
 dlcFhwqvjafsQHbHqhy3w/tuG8VOHnz2ZCmmhm/lBZVcF3dOUJ09KfDM9bcEWsNjeHA=
X-Gm-Gg: AZuq6aKrVUUPXLJJCKI0oPK4mrzU04ohnCS9XThpiTC/DBCA0KQshjgWtlKK8qrKWFP
 M9bG15izhzOIwErGogv4+SRlfG6ZZzCvygzhTt9vblA6lzRzxrtPyz8fUAnFOj6tHHguh0OLqrl
 mCBed/vdpVGmGQmhNEhff85iGUwyhSAXuFNhjLvH4SfL56/BnXdi8mylcFh/6eGk25aYhR4R7B4
 6fqggX4VrHxNj0Gv4kzCXEKk4U82qXvjX+iOGDJ7D7z6LfqkuBflUwW5Ea7Br1LFm2rrBN4ywoY
 UCo5L00ly8Hu2SSOzvapo5uPymTcXbgkCpmxBMdzKw6CilQoeXCE/BIdlJUxMYrFagH4muhIVGW
 xWTv6BYi9VDG+bbgOyFbs3Nzr0LbtX1so+wEp44Jl4c+dvnwSuPPZ+eyTTpZfWew2YvYX8XUoxs
 4Hu9oQoyHNreBOvJymkZjTSJJQoviJ61nT
X-Received: by 2002:a17:903:3d0f:b0:29d:65ed:f481 with SMTP id
 d9443c01a7336-2a870c30b22mr19064435ad.0.1769524974774; 
 Tue, 27 Jan 2026 06:42:54 -0800 (PST)
Received: from intel-VirtualBox.. ([94.156.205.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802dcd776sm119025285ad.26.2026.01.27.06.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 06:42:54 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v5 0/2] Add-CoreCourse-socfpga-Boards
Date: Tue, 27 Jan 2026 22:42:48 +0800
Message-Id: <20260127144250.35915-1-briansune@gmail.com>
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

Introduce CoreCourse boards to mainstream.

Altera SoCFPGA GEN5 boards:
AC501 - small formfactor
AC550 - complex development board

Brian Sune (2):
  Add CoreCourse socfpga Board AC501
  Add CoreCourse socfpga Board AC550

 arch/arm/dts/Makefile                         |   2 +
 arch/arm/dts/socfpga_cyclone5_ac501soc.dts    |  85 +++
 arch/arm/dts/socfpga_cyclone5_ac550soc.dts    | 131 ++++
 .../dts/socfpga_cyclone_ac501soc-u-boot.dtsi  |  44 ++
 .../dts/socfpga_cyclone_ac550soc-u-boot.dtsi  |  44 ++
 arch/arm/mach-socfpga/Kconfig                 |  14 +
 board/corecourse/ac501soc/MAINTAINERS         |   6 +
 board/corecourse/ac501soc/qts/iocsr_config.h  | 664 ++++++++++++++++++
 board/corecourse/ac501soc/qts/pinmux_config.h | 222 ++++++
 board/corecourse/ac501soc/qts/pll_config.h    |  86 +++
 board/corecourse/ac501soc/qts/sdram_config.h  | 349 +++++++++
 board/corecourse/ac550soc/MAINTAINERS         |   6 +
 board/corecourse/ac550soc/qts/iocsr_config.h  | 664 ++++++++++++++++++
 board/corecourse/ac550soc/qts/pinmux_config.h | 222 ++++++
 board/corecourse/ac550soc/qts/pll_config.h    |  86 +++
 board/corecourse/ac550soc/qts/sdram_config.h  | 349 +++++++++
 configs/socfpga_ac501soc_defconfig            |  85 +++
 configs/socfpga_ac550soc_defconfig            |  85 +++
 include/configs/socfpga_ac501soc.h            |  13 +
 include/configs/socfpga_ac550soc.h            |  13 +
 20 files changed, 3170 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_cyclone5_ac501soc.dts
 create mode 100644 arch/arm/dts/socfpga_cyclone5_ac550soc.dts
 create mode 100644 arch/arm/dts/socfpga_cyclone_ac501soc-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_cyclone_ac550soc-u-boot.dtsi
 create mode 100644 board/corecourse/ac501soc/MAINTAINERS
 create mode 100644 board/corecourse/ac501soc/qts/iocsr_config.h
 create mode 100644 board/corecourse/ac501soc/qts/pinmux_config.h
 create mode 100644 board/corecourse/ac501soc/qts/pll_config.h
 create mode 100644 board/corecourse/ac501soc/qts/sdram_config.h
 create mode 100644 board/corecourse/ac550soc/MAINTAINERS
 create mode 100644 board/corecourse/ac550soc/qts/iocsr_config.h
 create mode 100644 board/corecourse/ac550soc/qts/pinmux_config.h
 create mode 100644 board/corecourse/ac550soc/qts/pll_config.h
 create mode 100644 board/corecourse/ac550soc/qts/sdram_config.h
 create mode 100644 configs/socfpga_ac501soc_defconfig
 create mode 100644 configs/socfpga_ac550soc_defconfig
 create mode 100644 include/configs/socfpga_ac501soc.h
 create mode 100644 include/configs/socfpga_ac550soc.h

-- 
2.34.1

