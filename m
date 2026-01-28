Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE18D3F06D
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 14:18:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D6F383F4C;
	Wed, 28 Jan 2026 15:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YCbRsL0L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8C583EC8; Wed, 28 Jan 2026 15:18:25 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CD8F83EC8
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 15:18:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-81f4f4d4822so3490553b3a.3
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 06:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769609901; x=1770214701; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mHbgdbLAu1nTIE+19SRb78xMy0ZZvvu6ba8LhJfz5f8=;
 b=YCbRsL0LhOGP3c+1HoDSIowNQdt5O+QvIiQrj0dACxHsueWmfqEL3PVFHzPPVwicEu
 sYXiNERHqUI5UCMzOxH/Vir1w5I7icVtPCuzZ9r5InRLcNElijN8okdGCco9WOV0+9z6
 oaRU8rMaVuauwtvGAuLwpwd1k4uRk6DN7Pev7NZLqPAc+pDLNSmldOdS8GnCG88WIzv5
 yiwGywSjfr/eN3yXEjTGZXaf7kIetQILKZtYdzl/V3rI9FaOfj0Ko0FY/Mg5SCTOLEaM
 N0tw6GLhor6qfAy/wzGW7Hos8ZcGryko2G0z+yBmLsVUBCrToJCEXFT1tz8Z7J80eqIn
 nDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769609902; x=1770214702;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mHbgdbLAu1nTIE+19SRb78xMy0ZZvvu6ba8LhJfz5f8=;
 b=L7YU1aub5JupP5r8sziEGvcouYwOduVY0BU0Q+J0/f3W2KABQPcQv4SP2ETVxQifNc
 wVpOVC7/eTtsdHFPYGCu8Pvv6eYxY4mPABDByn4/dKTkpaDk6Vq01eTZDJ8ZCTCRUwnf
 iqcFWE3op0XnEWGt7yA/xfVfRD/2YGwMp5ZgaYvzszGz5txA9wODCj8+l6I7reqwz8tF
 kgEm63nAJQhBQ0miyRemMT+d7RE82p1pZA9X8Gpao4kVFwRp3aG3NAxlNHrgP2Ofr3+g
 +Mia2AMCSPqvyEpDEruis0HDm59u21s3DvyO2Bi/kyE6E8Xo6Cgk/57S64p/7TYzvKkK
 uXxg==
X-Gm-Message-State: AOJu0YxLpSPCu7yuNtrkSslmlRKVEJ0WGdeoHTxXv2AXFp6SeJ7sF0QB
 oyhOIBJ0v9nNEN8DdmKo+0Jzcdd/g+ba981VvHSdXWZV8Wmgwe7w+S8++pF0rXyybZY=
X-Gm-Gg: AZuq6aI52fve9CIuaghkRFKmlah06tKJB2M9dHrgesbZMJDyORxTrTxS2slem7FWJ0E
 nkNsJt9vIW6gTg2HHCX9JjKpBSvlbafIR6B5A27NDtJm9b3HsAq6/18A0/ljC+1r5M2c5/pJvUp
 KQoxbNxCW+I6Zh0LjZHrrDJaUi5+Ghy06So+rqM+F3k65dC0Ny56CEO+kCSPOPhmZIwPOdbACaY
 Y6zAk441iN+5J2bs+uNe4HMowInm0kFzaFmU4VhFHZHXAqsNT/dNSzK/bypJ5y0kKj6q3OqL6p4
 ryOIhHsxoVflx07cBhSdUJezN8KSGekvN1Hrr9P9emnUBoD/FvpqlrD/9QpbMy+qdHLtiC63TV7
 bIhZMzGALtaxakNKjw62Y79DZjbHfTERUDllNC29dGvtOsj8uvdy/KCbivY7TmY1JrPI3jsvymY
 h1THXQTDVFrw7UW/u/+nh1goe1XQ4e2shJAA==
X-Received: by 2002:a05:6a20:93a1:b0:35d:6b4e:91f1 with SMTP id
 adf61e73a8af0-38ec632e065mr5441180637.34.1769609901413; 
 Wed, 28 Jan 2026 06:18:21 -0800 (PST)
Received: from intel-VirtualBox.. ([94.156.205.238])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c642a42b3fcsm2438484a12.20.2026.01.28.06.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 06:18:21 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v7 0/2] Add-CoreCourse-socfpga-Boards
Date: Wed, 28 Jan 2026 22:18:14 +0800
Message-Id: <20260128141816.329533-1-briansune@gmail.com>
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
  Add CoreCourse socfpga Board - AC501
  Add CoreCourse socfpga Board - AC550

 arch/arm/dts/Makefile                         |   2 +
 .../dts/socfpga_cyclone5_ac501soc-u-boot.dtsi |  44 ++
 arch/arm/dts/socfpga_cyclone5_ac501soc.dts    |  72 ++
 .../dts/socfpga_cyclone5_ac550soc-u-boot.dtsi |  44 ++
 arch/arm/dts/socfpga_cyclone5_ac550soc.dts    | 118 ++++
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
 20 files changed, 3144 insertions(+)
 create mode 100644 arch/arm/dts/socfpga_cyclone5_ac501soc-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_cyclone5_ac501soc.dts
 create mode 100644 arch/arm/dts/socfpga_cyclone5_ac550soc-u-boot.dtsi
 create mode 100644 arch/arm/dts/socfpga_cyclone5_ac550soc.dts
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

