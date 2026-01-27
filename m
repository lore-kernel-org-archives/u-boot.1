Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D5CD2D8FA
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 10:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1748D83FF8;
	Tue, 27 Jan 2026 11:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nPrj8dXd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A827983FF5; Tue, 27 Jan 2026 11:53:02 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B0BF83FD9
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 11:53:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a0a95200e8so37645525ad.0
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 02:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769511178; x=1770115978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IfuRPhsr/RBuDEqAt4lu6OlqunOYqYQT8o/kFl2fAKk=;
 b=nPrj8dXdgl3VXk9Rpxi+4kzbSGOaUkJrWutmMOHU3uCXTkBZ91B55jG7OmPET5kheE
 g8vYlH2+0ocYjAL7Q/7NhbE9PJeIbVRyhCcK1qhaxAJC8Re6fRUFXu7FRNuGanKRB8Ou
 TbzTsNnERp0XSe0VJGzF3tYGtLvCJPPuzqyZENOu5/+elrKqGxxivQzCO6aVh+ThcAmU
 SUu6tEDpom/InDETP7fYi8OqIXawZqTF44XuC9fW6T0k5S08ArAQbJCrP6FTwqkUZGsQ
 mpTVAqimUiMK9ZYyWgXBNYxzUYw/3vLf6xuSOlfj/aWBJ2LeitH4i2+bST7sOG3LaJ9d
 rbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769511178; x=1770115978;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IfuRPhsr/RBuDEqAt4lu6OlqunOYqYQT8o/kFl2fAKk=;
 b=VslMTiArrT5s8ksuFCw/MqIpwjK/CXSpsINslXAIYpClJipHqn+jNa9PQQ9penfptD
 MG5vWQ4z14kr9LrfKuovfp6ZBeVIrsQbBTqq12W+9ZEBpnoF3FnXgTLoKDFpgJ1dN8/H
 FDL7ss7+gfWMkjRCPPZfy8Hmy9DDNRC0b8jngPWAg1H3+IPTX76zdLKVEMofnjoBf5+h
 +Z2PkHjHU6X3Zy4FGPJUx7BxQ7gqYsqT844jdpwYgjfi38vXg5Qwc6ibj4pVY2yFpnaj
 1dYgBMi+y9AwPXLgww1jx3zuTwqxn2spC3SG7MX7FWqV5rphhMeuhEsYa7XPMcnW2L5p
 721A==
X-Gm-Message-State: AOJu0YwkuCtOnTiT2GGG05s7kmiAR8Tl6WTkjZDYjH53LayYe69u0/kK
 NwwP3cIQMtGdaKvHJr0m3i1AUqqU3HHt8tVzgsm02flNc/X5RrdLdeS/C4VVW6GO
X-Gm-Gg: AZuq6aIKcKLPSj4U+cB1M//ydoZ/a8q+G4VK8/Y2m6ytAipbC1NiusSA6+6NFlBA1t8
 z/LaNJ85E04n7mJMNFo6kFy8KBA7GdjFDrJBKILT2iWpR/UlcQmTAAmXYF1CzcRWV1i6v8k0IiB
 Tgqbd5MdXVBaW5goyqdtmd6uHe5VAmNr4BcmQI+ZQKPDU6+kGPxc+4IGgWysttVbg34o/IJ4k3j
 l6Uw3CaSpJlUkN/BX+TATffchsdPWiRFVWHN26jd6ONKb14mymqZYiWy8AQ1O9SnUfap97mW9mS
 +mXuoFmkgmTiWC/11BxhVV4g2IqBgNrkKk5mmMfPeQfkdhwd/smNNmbS0TnTPAXlG3dsO6PjZtT
 +I+Uf36+osp/2sE7rnVqsdQurovisHWwK+XDT8VyaV81M4iHiZb1/i+uuzi0dWZ7PNAbUbbeSkf
 yBQVFU035F86Y/3KFqqggPwzB6evYHsz+h
X-Received: by 2002:a17:902:db0f:b0:2a2:bff6:42ef with SMTP id
 d9443c01a7336-2a870d457b4mr15619795ad.7.1769511178504; 
 Tue, 27 Jan 2026 02:52:58 -0800 (PST)
Received: from intel-VirtualBox.. ([185.213.82.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a802fd929asm115094775ad.90.2026.01.27.02.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 02:52:58 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>,
 Brian Sune <briansune@gmail.com>
Subject: [PATCH v4 0/2] Add-CoreCourse-socfpga-Boards
Date: Tue, 27 Jan 2026 18:52:50 +0800
Message-Id: <20260127105252.4714-1-briansune@gmail.com>
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
 18 files changed, 3144 insertions(+)
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

-- 
2.34.1

