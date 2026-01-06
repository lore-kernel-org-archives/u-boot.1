Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9E7CD042A
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 01:13:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E22683D9F;
	Tue,  6 Jan 2026 02:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P5T06YGi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADB2C83E7F; Tue,  6 Jan 2026 02:13:42 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70F1A839F1
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 02:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7bab7c997eeso645022b3a.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 17:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767662019; x=1768266819; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8Y9Rj3TaCPbF3HtfHFolal30c36J6+vdSY3GJFKWY9s=;
 b=P5T06YGiOsyZHrg277H0CXyPfyOErqFw16Xpr4lhqwS/Fs3ws/fFdv7VKRFgeRdFF6
 QEIRKzPED43fWcSb2i0NZ2CBsF5tMfbxdj9aEkYf+BqmqvpxzQVcLNJGOlqUbFvGFFXD
 akr01hA8VOcSTIo6PxSUXAdUWCu0WSYbpBy0s35wIRMY8VzEDjaVuG5YBE6aoY/exUnc
 AZPHNt0ZQ7IOj4i0GbmRU6Ka5cDL0J2OEBsljqzGondamAM6E2cxlG/XS005I81saQz4
 JJTqxz2wRuuXLHi2+8XC0fJRv3po8XSYQgHUXAhXUmTMn7gsQk2pppVx5tZVkM04myfN
 Aesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767662019; x=1768266819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Y9Rj3TaCPbF3HtfHFolal30c36J6+vdSY3GJFKWY9s=;
 b=XZEdhpWnSPtPhhwsedrVDtdrac5aTY6tx7w/fp9kwC4Zf+GumUXgorVZ4wWRvTVfKi
 sxd4I+2o+MrfFFSw7nZm/1iVLwvLy8qpeU+myGJSldS3Oxxaivj/evWa87Ogoa3DDEeR
 or/xlH5aIyxHJkLIv7N9Jqc8JrIEPgm+APcJ93nStGWS4uVq2VZ3sr8S4lIENFCoZakZ
 jng3Mx3fccugpWNN0CUsFEYTxyMQvoikrz57OP8SVQ7D3tbjF5nowcC40nLRQkhrRrey
 zdmmPJZ13gEzYO/sZ3u6TylvWG7yu+5T8iFJKQKHSqF2iwxarQlm4E0KBxa1s1oF72lB
 FSqg==
X-Gm-Message-State: AOJu0YyUTOOxdNRfEdCJEJpKAXz5zp2e59YzOQmJE33/l8iStU1ZxUP5
 MpeVHr/PaK6sEaNOM2wq+E6xRy3kV1crxjThnKU486gt+yKA4xJ5wGufgr/mwS3Y
X-Gm-Gg: AY/fxX5O1qf2ag/5JHL3FlQ5loT3A11B4vojn4bHN1dGSnjfBtLyRaD7hTlvvx8lS/S
 uwJiuuiqnXJ0O79UI2tXsZ4QtMF58IBBgnMJt32L+5NDhKJGZnlsPfFxkqwdx8lOBeu0Fh9osa0
 4Fdthe1oQZjpEy6NeArrl4houyaXR9CFkb5Et0sBiGTjZ48DFbKXXuW1gH1o1NQkkUmmQRerbEL
 ww+HkXHtSjQ/aly8zPowdXxaalL7zrSCCKMNlHVABNwhgbmGpXXRUISCWmhBWAhVlBLX8uVRDGz
 eXAOSF55GycfZXOeHIEz9EOo7T2soZnSWkqhDOSV3A9g19SjJTXMhO/M400bOBXI7E152g6+5TV
 m3iKz29XLP7DAU08AuJEVv3hjmTw4pX8Z0BfWIWeBdm0v3RnhDudqBOQLpXnNz7BqDthXK3ApOc
 k6Tshjr8G3GquueIUPHATtFpleU829qNKp
X-Google-Smtp-Source: AGHT+IHZOtf1meZoD/4ORHAyRvgjm5nqpot+hqPdJHz/8JRFDfUTv7VaGz3SSahn3gHbKMBQxedrfQ==
X-Received: by 2002:a05:6a20:3ca2:b0:387:963b:68ae with SMTP id
 adf61e73a8af0-389823ddc44mr973128637.80.1767662018673; 
 Mon, 05 Jan 2026 17:13:38 -0800 (PST)
Received: from intel-VirtualBox.. ([94.156.205.11])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cbfd27953sm555733a12.11.2026.01.05.17.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 17:13:38 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Brian Sune <briansune@gmail.com>
Subject: [PATCH v3 0/2] Add-CoreCourse-socfpga-Boards
Date: Tue,  6 Jan 2026 09:13:23 +0800
Message-Id: <20260106011325.4634-1-briansune@gmail.com>
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

