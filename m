Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE83DE92733
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 15:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 123C583E7A;
	Mon, 29 Dec 2025 16:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SmH8jmfS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A892483E57; Mon, 29 Dec 2025 16:34:04 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6370D83E36
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 16:34:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2a0a33d0585so84973825ad.1
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 07:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767022440; x=1767627240; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qlZpum7PanN1FhzWWr8KqSjor0rWqzn/hFemfNX6pUU=;
 b=SmH8jmfSJnjeCNzK+7QIW699QEu0RUlkWut4xiGEM5RMNAsliui555K6n0UhDUvaAs
 S3xfeUXq8BEagDDVEh5wwNrxKaYWu7MSyx9UDe4TvJjPnClBlvq+26PPABmwIbKDvA9q
 oQhc2BLzficT+48FaimPcH0LEqaj4gsfF2yy9JqeaoEo7qPTBJ3P2AzAUyk5aN+MVl5I
 3IMLrdg0dNE3DPAF2zQshBwn9VNvadEbzWv+F5XzwSaDDkndVdjkNdxY2h+ySrmIBz4c
 obEARjAVl1eVMcfWuz1SPn1Gtsj0OFZ5nQraHUedkw3ReVjoLje7TvsQ/0lXblBerrvz
 KEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767022440; x=1767627240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qlZpum7PanN1FhzWWr8KqSjor0rWqzn/hFemfNX6pUU=;
 b=FXn+434r5dPYcTKRp5tyMUg4fPkaziUN4vOnjlI6luXFHda5AbPul52bZT5SNEB8rg
 6sM3k/qI6k9w8Pk7AYHHmQ6g7UuMZ6GQ0Kk7wlL5Ngioc8QEBBDyvEBvb5xLZsikaQta
 Y0az8kFPIhOvOKVa0bq4jtr3mE2Bx3Lk3fULG4NWlNxKQyVeKW5FGS9o/9KA1Bf3hKS5
 4/o6PzFNxrQOSDBry5vEvz6Ux4aoHeevGCl0yo29SXeUJlBvdWZK78L7ktQ3OptEn8Us
 rsFEMdhf7iT2vruVSj+Cn3be05Ex1EwUQLi/oImC0CoBsJunEnb+s7zdK+Lm/y65zlqP
 M8TQ==
X-Gm-Message-State: AOJu0YyKqwYwIzjl4cHmi/I5LC9OtV4G3rYNMaYrQJ9PDRwcFeUv5gUe
 8h8FENyGy94MQgONWvpFpBxoL4ANsfh0ZekAee5nwAubl0Etv2BVKnlj5W2511eMky0=
X-Gm-Gg: AY/fxX57JOtoyRJQp6euiqTJdBCmh6NX9NFujPT+auIMTCqKreMmCwt9ae5Ql/lpAuq
 Tq90+qKGK6KaEUIksGt710J0XGvJr3/lzDLLC0cXHhgxNTpoyj33m/9sZ69N8wvdxCde93A+OFp
 GKdZ8ldylJiwKUui9uIXvdK/VEOvqM9WONIYouTCP+F0nikCgEMP2jjjtT11KsFA35ZXgwxjFRI
 vnOzFfaCEtBWY71bmy9xuLdkDCBorJopLim/1ht2pZEKRczGlyIK9hCLSY4/ZH5V8jiVMzapK3z
 4lD4bDrE/vVs1j0+pBjcQejEr2wOp97LR1qCsQsI/9rb7JgMd5MRywo7msyfJwAd8oo+ki9AvPC
 zP+ZX1Bs0ssMIZAVLhHOIrjoE8ZVOSoBiBNF5iaQ5pAVSYe1Im1kPBupnuCKShefP6Lz+BT7HSi
 TDKifFsjmZZDgKmbEK6kL61st9SdiMd8ErAQ==
X-Google-Smtp-Source: AGHT+IEoKGy9CArB0rLntHaY3l+KfKycleJ13fHxtSvwV6bxxhOwQLwxjygPWbC5rTkeckm58o9aww==
X-Received: by 2002:a17:903:2ac5:b0:2a1:3ee7:cc7a with SMTP id
 d9443c01a7336-2a2f2223616mr290450325ad.17.1767022440022; 
 Mon, 29 Dec 2025 07:34:00 -0800 (PST)
Received: from intel-VirtualBox.. ([185.213.82.123])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d76ceesm279825195ad.91.2025.12.29.07.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 07:33:59 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>,
 Brian Sune <briansune@gmail.com>
Subject: [PATCH v2 0/2] Add-CoreCourse-socfpga-Board
Date: Mon, 29 Dec 2025 23:33:52 +0800
Message-Id: <20251229153354.5558-1-briansune@gmail.com>
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

Introduce CoreCourse board to mainstream.

Altera SoCFPGA GEN5 boards:
AC501 - small formfactor
AC550 - complex development board

Brian Sune (2):
  Add CoreCourse socfpga Board - AC501
  Add CoreCourse socfpga Board - AC550

 arch/arm/dts/Makefile                         |   2 +
 arch/arm/dts/socfpga_cyclone5_ac501soc.dts    |  86 +++
 arch/arm/dts/socfpga_cyclone5_ac550soc.dts    | 132 ++++
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
 include/configs/socfpga_ac501soc.h            |  16 +
 include/configs/socfpga_ac550soc.h            |  16 +
 20 files changed, 3178 insertions(+)
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

